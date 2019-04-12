//
//  VocPracticeController.swift
//  GuVocabulary
//
//  Created by Yuhang Xiong on 2019-03-11.
//  Copyright © 2019 xiongma. All rights reserved.
//

import UIKit
import AVFoundation

// randomly pick one element from array
extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}


// transform 汉字 to 拼音
extension String{
    func transformToPinYin()->String{
        let mutableString = NSMutableString(string:self)
        CFStringTransform(mutableString,nil,kCFStringTransformToLatin,false)
        
        CFStringTransform(mutableString, nil , kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        
        return string.replacingOccurrences(of: " ", with: "")
        
        
    }
}

// random pick any number element from total array which including 25 words
extension Array {
    /// Picks `n` random elements (partial Fisher-Yates shuffle approach)
    subscript (randomPick n: Int) -> [Element] {
        var copy = self
        for i in stride(from: count - 1, to: count - n - 1, by: -1) {
            copy.swapAt(i, Int(arc4random_uniform(UInt32(i + 1))))
        }
        return Array(copy.suffix(n))
    }
}



class VocPracticeController: UIViewController {
    
    var text = ""
    var popup:UIView!
    var VocWordList = [String]()
    var RandomWordList = [String]()
    var randomItem = String()
    var correctness = "0"
    var lookHelp = "0"
    
    var currentIndex = 0
    var currentAudioName = ""
    var audioList = [String]()
    
    @IBOutlet weak var suggestlabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    var audioPlayer : AVAudioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var pronounceButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //get the 10 random words
        self.RandomWordList = self.VocWordList[randomPick: 10]
        print(self.RandomWordList)
        text1.font = UIFont(name:"FZZJ-CZXKJW",size:40)
        self.randomItem = self.RandomWordList.randomItem()!
        
        
        label1.text = self.randomItem
        
        // Do any additional setup after loading the view.
    }
 
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func Pronounce(_ sender: Any) {
        self.lookHelp = "1"
        getAudioName()
        // Check if the audio is existed first
        if(self.currentAudioName==""){
            let alertController = UIAlertController(title: "没有音频!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //1秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
        else{
            audioPlayer = Util.getPlayer(audioName: self.currentAudioName)
            audioPlayer.play()
        }
    }
    @IBAction func finish(_ sender: Any) {
        if text1.text == label1.text{
            label1.font = label1.font.withSize(50)
            self.correctness = "1"
            text1.text = ""
            text1.font = UIFont(name:"Courier",size:40)
          
            
            
            if self.lookHelp=="0" && self.RandomWordList.count>1{
                self.RandomWordList.removeAll{$0 == self.randomItem}
                self.randomItem = self.RandomWordList.randomItem()!
                label1.text = self.randomItem
               
                
            }
            
            else if self.lookHelp=="1" && self.RandomWordList.count>1{
              
                self.randomItem = self.RandomWordList.randomItem()!
                label1.text = self.randomItem
                self.lookHelp = "0"
            }
            else if self.RandomWordList.count<2{
                
                label1.font = label1.font.withSize(30)
                label1.text = "全部完成!!!"
                submitButton.isHidden = true
                text1.isHidden = true
                suggestlabel.isHidden = true
                pronounceButton.isHidden = true
            }
         
            
            
        }
        else if text1.text == "" {
            
            let alertController = UIAlertController(title: "输入拼音后再点完成哦",
                                                     message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //1秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
            
        else{
            let alertController = UIAlertController(title: "输入的不对哟，再试一次吧",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //1秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
            
        }
        
    }
    
    func getAudioName() {
        self.currentIndex = self.VocWordList.firstIndex(of: self.randomItem)!
        if(self.currentIndex<self.audioList.count){
            self.currentAudioName = self.audioList[self.currentIndex]
        }
        else{
            self.currentAudioName = ""
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

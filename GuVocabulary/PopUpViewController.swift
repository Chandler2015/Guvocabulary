//
//  PopUpViewController.swift
//  GuVocabulary
//
//  Created by Yuhang Xiong on 2019-03-18.
//  Copyright © 2019 xiongma. All rights reserved.
//

import UIKit
import AVFoundation

class PopUpViewController: UIViewController {
    
    @IBOutlet weak var return_button: UIView!
    
    @IBOutlet weak var word_label: UILabel!
    @IBOutlet weak var translation: UILabel!
    @IBOutlet weak var exampleSentence: UILabel!
    
    var audioPlayer : AVAudioPlayer = AVAudioPlayer()
    
    var word = ""
    var audioName = ""
    var translationText = ""
    var sentenceText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        word_label.text = self.word
        word_label.font = UIFont(name: "FZZJ-CZXKJW", size: 60)
        print("Popup: " + word)
      
        // Do any additionalwsetup after loading the view.
    }
    
    @IBAction func pronounce(_ sender: Any) {
        print(audioName)
        if(self.audioName==""){
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
            print("hahaha")
            playAudio(audioName: self.audioName)
        }
    }
    
    @IBAction func showTranslation(_ sender: Any) {
        translation.text = translationText
    }
    
    @IBAction func showExampleSentence(_ sender: Any) {
        exampleSentence.text = sentenceText
    }
    @IBAction func back(_ sender: UIButton) {
        dismiss(animated:true)
    }
    
    func playAudio(audioName:String){
        audioPlayer = Util.getPlayer(audioName: audioName)
        audioPlayer.play()
    }
}

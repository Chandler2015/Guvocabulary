//
//  VocSentenceViewController.swift
//  GuVocabulary
//
//  Created by 白小菲528 on 2019-03-20.
//  Copyright © 2019 xiongma. All rights reserved.
//

import UIKit
import AVFoundation

class VocSentenceViewController: UIViewController {

    @IBOutlet weak var wordText: UILabel!
    @IBOutlet weak var sentenceText: UILabel!
    @IBOutlet weak var wordInput: UITextField!
    @IBOutlet weak var sentenceInput: UITextField!
    
    @IBOutlet weak var finishButton: UIButton!
    
    @IBOutlet weak var wordCheckText: UILabel!
    @IBOutlet weak var sentenceCheckText: UILabel!
    @IBOutlet weak var practiceNumberText: UILabel!
    var currentWord = ""
    var currentSentence = ""
    var currentIndex = 0
    var i = 0
    
    var count = 0
    
    var wordList = [String]()
    var sentenceList = [String]()
    var wordAudioList = [String]()
    var sentenceAudioList = [String]()
    
    // Used to store every index of word that asked for help
    var isHelped : Bool = false
    var randomWordList = [String]()
    
    var audioPlayer : AVAudioPlayer = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.randomWordList = self.wordList[randomPick: 10]
        wordCheckText.text = ""
        sentenceCheckText.text = ""
        getRandomWord()
        
        initTapEvent()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }

    @objc func keyboardShow(_ notification : Notification){
        let info = notification.userInfo
        let kbRect = (info?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let offsetY = kbRect.origin.y - UIScreen.main.bounds.height
        UIView.animate(withDuration: 0.3) {
            self.view.transform = CGAffineTransform(translationX: 0, y: offsetY)
        }
    }
    
    @objc func keyboardHide(_ notification : Notification){
        let info = notification.userInfo
        let kbRect = (info?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let offsetY = UIScreen.main.bounds.height - kbRect.origin.y
        UIView.animate(withDuration: 0.3) {
            self.view.transform = CGAffineTransform(translationX: 0, y: offsetY)
        }
    }
    
    func initTapEvent() {
        wordText.isUserInteractionEnabled = true
        //点击事件
        var tap = UITapGestureRecognizer.init(target: self, action: #selector(pronounceWord(tap:)))
        tap.numberOfTapsRequired = 2
        //绑定tap
        wordText.addGestureRecognizer(tap)
        
        sentenceText.isUserInteractionEnabled = true
        tap = UITapGestureRecognizer.init(target: self, action: #selector(pronounceSentence(tap:)))
        tap.numberOfTapsRequired = 2
        //绑定tap
        sentenceText.addGestureRecognizer(tap)
    }
    
    @objc func pronounceWord(tap : UITapGestureRecognizer){
        //print(self.currentIndex)
        if(self.currentIndex<self.wordAudioList.count){
            self.audioPlayer = Util.getPlayer(audioName: self.wordAudioList[self.currentIndex])
            self.audioPlayer.play()
            self.isHelped = true
        }
    }
    
    @objc func pronounceSentence(tap : UITapGestureRecognizer){
        //print(self.currentIndex)
        if(self.currentIndex<self.sentenceAudioList.count){
            self.audioPlayer = Util.getPlayer(audioName: self.sentenceAudioList[self.currentIndex])
            self.audioPlayer.play()
            self.isHelped = true
        }
    }
    
    @IBAction func finish(_ sender: Any) {
        if wordInput.text == wordText.text{
            wordCheckText.text = ""
            if sentenceInput.text == sentenceText.text{
                //wordCheckText.text = ""
                sentenceCheckText.text = ""
                if(isHelped){
                    isHelped = false
                    randomWordList.append(self.currentWord)
                }
                
                if(self.i > self.randomWordList.count){
                    let alertController = UIAlertController(title: "恭喜你",
                                                            message: "你已经顺利完成本次练习", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "好的", style: .default, handler: {
                        action in
                        self.dismiss(animated: true)
                    })
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    getRandomWord()
                }
            }
            else{
                sentenceCheckText.text = "句子拼音不正确"
            }
        }
        else{
            wordCheckText.text = "单词拼音不正确"
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func getRandomWord() {
        self.currentWord = self.randomWordList[self.i]
        
        self.i += 1
        let numberText = String(self.i) + " / 10" + "(+" + String(self.randomWordList.count - 10) + ")"
        
        practiceNumberText.text = numberText
        self.currentIndex = self.wordList.firstIndex(of: self.currentWord)!
        self.currentSentence = self.sentenceList[self.currentIndex]
        
        wordText.text = currentWord
        sentenceText.text = currentSentence
        
        wordInput.text = ""
        sentenceInput.text = ""
    }
}

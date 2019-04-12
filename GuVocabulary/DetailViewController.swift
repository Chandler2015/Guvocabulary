//
//  DetailViewController.swift
//  test
//
//  Created by 白小菲528 on 2019-03-10.
//  Copyright © 2019 白小菲528. All rights reserved.
//

import UIKit
import AVFoundation

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    
    @IBOutlet weak var button16: UIButton!
    @IBOutlet weak var button17: UIButton!
    @IBOutlet weak var button18: UIButton!
    @IBOutlet weak var button19: UIButton!
    @IBOutlet weak var button20: UIButton!
    
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button22: UIButton!
    @IBOutlet weak var button23: UIButton!
    @IBOutlet weak var button24: UIButton!
    @IBOutlet weak var button25: UIButton!
    
    // Button list contains 25 buttons
    var buttonList = [UIButton]()
    
    // audioList contains audio names of words
    var wordAudioList = [String]()
    // wordList contains words
    var wordList = [String]()
    // translationList contains translations
    var translationList = [String]()
    // sentenceAudioList contains audio names of sentences
    var sentenceAudioList = [String]()
    // SentenceList contains example sentences
    var sentenceList = [String]()
    // The key of data in DataController
    var currentChapter = ""
    
    // Used to pass values to another views
    var wordText = ""
    var audioName = ""
    var translation = ""
    var sentence = ""
    
   // self.navigationController?.pushViewController(DetailViewController!, animated: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This is the list that contains 25 buttons
        buttonList = [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10,button11,button12,button13,button14,button15,button16,button17,button18,button19,button20,button21,button22,button23,button24,button25]
        
        detailLabel.text = currentChapter
        
        var data = DataController.data[currentChapter]
        
        wordList = data![Util.WORD]!
        wordAudioList = data![Util.WORD_AUDIO]!
        translationList = data![Util.TRANSLATION]!
        sentenceList = data![Util.SENTENCE]!
        sentenceAudioList = data![Util.SENTENCE_AUDIO]!
       
        // Used to select the action onClick to a specific button
        let method = #selector(onClick as (UIButton) -> ())
        
        // Use a loop to init every button
        for i in 0...buttonList.count-1 {
            if(i<wordList.count){
                buttonList[i].setTitle(wordList[i], for: UIControl.State.normal)
                buttonList[i].titleLabel?.font =  UIFont(name: "FZZJ-CZXKJW", size: 50)
            }
            buttonList[i].addTarget(self, action: method, for: .touchUpInside)
        }
        
    }
    
    @objc dynamic func onClick(_ button : UIButton){
        let index = buttonList.firstIndex(of: button)
        if(index!<self.wordList.count){
            self.wordText = self.wordList[index!]
        }
        else{
            self.wordText = "空"
        }
        if(index!<self.wordAudioList.count){
            self.audioName = self.wordAudioList[index!]
        }
        else{
            self.audioName = ""
        }
        if(index!<self.translationList.count){
            self.translation = self.translationList[index!]
        }
        else{
            self.translation = ""
        }
        if(index!<self.sentenceList.count){
            self.sentence = self.sentenceList[index!]
        }
        else{
            self.sentence = ""
        }

        performSegue(withIdentifier:"pass_word", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "pass_word"){
            let vc = segue.destination as! PopUpViewController
            
            vc.word = self.wordText
            vc.audioName = self.audioName
            vc.translationText = self.translation
            vc.sentenceText = self.sentence
            
            print(vc.word+"vcvc")
        }
        else if(segue.identifier == "voc_practice"){
            let vc = segue.destination as! VocPracticeController
            
            vc.text = self.wordText
            vc.VocWordList = self.wordList
            vc.audioList = self.wordAudioList
        }
        else if(segue.identifier == "word_sentence_practice"){
            let vc = segue.destination as! VocSentenceViewController
            vc.wordList = self.wordList
            vc.sentenceList = self.sentenceList
            vc.wordAudioList = self.wordAudioList
            vc.sentenceAudioList = self.sentenceAudioList
        }
        
        
        else if(segue.identifier == "sentence_practice"){
            let vc = segue.destination as! SentenPracViewController
            
           // vc.text = self.wordText
            vc.VocWordList = self.wordList
          
        }
        
        
    }
    
    @IBAction func wordPractice(_ sender: Any) {
        //self.wordText = "测试"
        performSegue(withIdentifier:"voc_practice", sender: self)
    }
    
    @IBAction func wordSentencePractice(_ sender: Any) {
        performSegue(withIdentifier:"word_sentence_practice", sender: self)
    }
    
    @IBAction func sentencePractice(_ sender: Any) {
        
        
        performSegue(withIdentifier:"sentence_practice", sender: self)
    }
}

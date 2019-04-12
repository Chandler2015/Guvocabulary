//
//  Util.swift
//  GuVocabulary
//
//  Created by 白小菲528 on 2019-03-19.
//  Copyright © 2019 xiongma. All rights reserved.
//

import Foundation
import AVFoundation

class Util {
    static let WORD = "word"
    static let WORD_AUDIO = "word_audio"
    static let TRANSLATION = "translation"
    static let SENTENCE = "sentence"
    static let SENTENCE_AUDIO = "sentence_audio"
    
    static func getPlayer(audioName : String) -> AVAudioPlayer {
        var player : AVAudioPlayer = AVAudioPlayer()
        do{
            let audioPlayer = Bundle.main.path(forResource: audioName, ofType: "m4a")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPlayer!) as URL)
        }
        catch{
            
        }
        return player
    }
}

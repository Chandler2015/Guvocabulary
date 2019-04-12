//
//  ViewController.swift
//  test
//
//  Created by 白小菲528 on 2019-03-07.
//  Copyright © 2019 白小菲528. All rights reserved.
//

import UIKit




class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var alist = [String]()
   
    @IBOutlet weak var byfxka: UIButton!
    @IBOutlet weak var byf: UILabel!
    
    var wordList = [String]()
    var wordText = "abcd"
    var wordAudioList =  [String]()
    
    
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alist.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = alist[indexPath.row]
        cell.textLabel?.font = UIFont(name:"FZZJ-CZXKJW", size:22)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
        viewController?.currentChapter = alist[indexPath.row]
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        byf.text = "第"+String(myIndex+1) + "单元"
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        var audio_list: [String] = []
        
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
        //    var audio_list: [String] = []

          
            for item in items {
                
                let file = item.split(separator: ".")
                
                if file.contains("m4a"){
                    let name = file[0]
                    audio_list.append(String(name))
                   
                }
                
            }
        } catch {
            // failed to read directory – bad permissions, perhaps?
        }
        
        
        
        let words1 = ["大","的","点","测试","测试",
                      "六","七","八","九","十",
                      "是","如","进","打","会",
                      "还","别","有","前","进",
                      "招","急","对","不","气"]
        //let audios =  audio_list
        let word_audios1 = ["大","的","点","点","test","test","test","test","test","test","test","test","test","test","test","test","test","test","test","test","test","test","test","test","test"]
        let sentence_audios1 = ["iloveu","iloveu","iloveu","iloveu","iloveu","test","test","test","test","test","test","test","test","test","test","test","test","test","iloveu","iloveu","test","test","test","test","test"]
        var data = Dictionary<String, [String]>()
        data[Util.WORD] = words1
        data[Util.WORD_AUDIO] = word_audios1
        data[Util.TRANSLATION] = ["one", "two", "three", "four", "five", "six", "seven"]
        data[Util.SENTENCE] = ["一个苹果","二话不说","三人行","四个小人","五个西瓜","六个六六六六六六","a","b","c","abc","cdd","a","c","d","e","f","g","h","j","k","l","q","w","e","r"]
        data[Util.SENTENCE_AUDIO] = sentence_audios1
        
        DataController.data["第一课"] = data
        
        let words2 = ["爱","我","哇","哈","黑",
                      "六","七","八","九","十",
                      "第三方","二","三","文","五",
                      "一","文明","三","四","五",
                      "五","四","三","二","一"]
        let word_audios2 = ["test", "test", "test"]
        let sentence_audios2 = ["iloveu","baiyifei","iloveu"]
        data = Dictionary<String, [String]>()
        data[Util.WORD] = words2
        data[Util.WORD_AUDIO] = word_audios2
        data[Util.TRANSLATION] = ["love", "me", "wa", "ha", "black", "six", "seven"]
        data[Util.SENTENCE] = ["我爱你","我是谁","哇哈哈","哈哈大笑","黑夜降临啦","六六大顺"]
        data[Util.SENTENCE_AUDIO] = sentence_audios2
        
        DataController.data["第二课"] = data
        let words3 = ["一","二","三","四","五",
                      "六","七","八","九","十",
                      "一","二","三","四","五",
                      "爱","我","哇","哈","黑",
                      "六","七","八","九","十"]
        let word_audios3 = ["baiyifei", "test", "baiyifei"]
        let sentence_audios3 = ["test","baiyifei","iloveu"]
        
        data = Dictionary<String, [String]>()
        data[Util.WORD] = words3
        data[Util.WORD_AUDIO] = word_audios3
        data[Util.TRANSLATION] = ["one", "two", "three", "four", "five", "six", "seven"]
        data[Util.SENTENCE] = ["一个苹果","二话不说","三人行，必有我师焉！","四个小人","五个西瓜","六个六六六六六六"]
        data[Util.SENTENCE_AUDIO] = sentence_audios3
        
        DataController.data["第三课"] = data
        
        DataController.data["第四课"] = data
        
        for key in DataController.data.keys{
            alist.append(key)
            
            
            
        self.wordList = words1 + words2 + words3
        self.wordAudioList = word_audios1 + word_audios2 + word_audios3
        }
    }
    
    
    @IBAction func unitpractice(_ sender: Any) {
        performSegue(withIdentifier:"unitprac", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "unitprac"){
            let vc = segue.destination as! VocPracticeController
            
            vc.text = self.wordText
            vc.VocWordList = self.wordList
            vc.audioList = self.wordAudioList
        }}
    
    
    
}


//
//  SentenPracViewController.swift
//  GuVocabulary
//
//  Created by Yuhang Xiong on 2019-03-20.
//  Copyright © 2019 xiongma. All rights reserved.
//

import UIKit
import AVFoundation
import MessageUI




class SentenPracViewController: UIViewController, MFMailComposeViewControllerDelegate {

    var VocWordList = [String]()
    
    var RandomWordList = [String]()
    
    var randomItem = String()
    
    var words = String()
    
    var words_list = [String]()
    
    var sentenceList = [String]()
    
    
    
    @IBOutlet weak var sendEmailbutton: UIButton!
    
    @IBOutlet weak var suggestlabel: UILabel!
    
    @IBOutlet weak var wordlabel: UILabel!
    
    
    @IBOutlet weak var entertext: UITextField!
    
    
    
    @IBOutlet weak var submitbutton: UIButton!
    
    
    
    override func viewDidLoad() {
        
        sendEmailbutton.isHidden = true
        super.viewDidLoad()
        self.RandomWordList = self.VocWordList[randomPick: 10]
        print(self.RandomWordList)
        self.randomItem = self.RandomWordList.randomItem()!
        wordlabel.text = self.randomItem
        // Do any additional setup after loading the view.
    }
    

    @IBAction func submitsentence(_ sender: Any) {
        if entertext.text != "" && self.RandomWordList.count>1{
            print(self.RandomWordList.count)
            words_list =  entertext.text!.components(separatedBy: " ")
            
            if words_list[0] == wordlabel.text! && entertext.text!.contains(wordlabel.text!){
            
            sentenceList.append(String(entertext.text!))
            print(sentenceList)
            self.RandomWordList.removeAll{$0 == self.randomItem}
            self.randomItem = self.RandomWordList.randomItem()!
            wordlabel.text = self.randomItem
            entertext.text = ""}
            else{
                let alertController = UIAlertController(title: "请输入正确句子后再点完成!",
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
                //1秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.presentedViewController?.dismiss(animated: false, completion: nil)}
        }
        }
            
        else if entertext.text != "" && self.RandomWordList.count<2{
            print("daodaodaodao")
            words_list =  entertext.text!.components(separatedBy: " ")

            if words_list[0] == wordlabel.text! && entertext.text!.contains(wordlabel.text!){
            wordlabel.text = "全部完成！！！"
            
            entertext.isHidden = true
            suggestlabel.isHidden = true
            submitbutton.isHidden = true
            sendEmailbutton.isHidden = false
                print(sentenceList)}
            
            else{
                let alertController = UIAlertController(title: "请输入正确句子后再点完成!",
                                                        message: nil, preferredStyle: .alert)
                //显示提示框
                self.present(alertController, animated: true, completion: nil)
                //1秒钟后自动消失
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                    self.presentedViewController?.dismiss(animated: false, completion: nil)}}
        
        }
    
        else{
            let alertController = UIAlertController(title: "请输入正确句子后再点完成!",
                                                    message: nil, preferredStyle: .alert)
            //显示提示框
            self.present(alertController, animated: true, completion: nil)
            //1秒钟后自动消失
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)}}
}
    
    
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func sendEmail(_ sender: Any) {
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail(){
            self.present(mailComposeViewController, animated: true, completion: nil)
        }
        else{
            showMailError()
        }
        
    }
    
    
    
    func configureMailController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["yxiong4@ualberta.ca"])
        
        mailComposerVC.setSubject("Testmessage")
        
        mailComposerVC.setMessageBody(self.sentenceList.joined(separator:"-"), isHTML: false)
        
        return mailComposerVC
        
    }
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email",message: "You device can not send email", preferredStyle: .alert)
        
        let dismiss = UIAlertAction(title:"Ok",style: .default, handler: nil)
        
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil )
    }
    
    
    
}

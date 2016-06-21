//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Meena Sengottuvelu on 6/21/16.
//  Copyright © 2016 Meena Sengottuvelu. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var chatTextField: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    
    let chatText = PFObject(className: "Message_fbuJuly2016")
    var data: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.estimatedRowHeight = 100
        chatTableView.rowHeight = UITableViewAutomaticDimension
        
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendChat(sender: AnyObject) {
//        let chatText = PFObject(className: "Message_fbuJuly2016")
        chatText["text"] = chatTextField.text
        chatText.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                print("It worked! :)")
            } else {
                
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chatCellClass", forIndexPath: indexPath) as! chatCellClass
        
        let message = data[indexPath.row]
        cell.chatTextLabel.text = message

        
        return cell
}
    
    func getData() {
        let query = PFQuery(className: "Message_fbuJuly2016")
        if chatText.objectId != nil {
            query.whereKeyExists("text")
            query.findObjectsInBackgroundWithBlock {
                (objects: [PFObject]?, error: NSError?) -> Void in
                if error == nil {
                    print("sucessful")
                    
                    if let objects = objects {
                        for object in objects {
                            self.data.append(String(object))
                        }
                    }
                    
                }
            }
        }

    }
    
    

    func onTimer() {
        self.viewDidLoad()
        self.chatTableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

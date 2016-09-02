//
//  DataViewController.swift
//  MobileDemo
//
//  Created by Mike Moore on 8/25/16.
//  Copyright © 2016 Mike Moore. All rights reserved.
//

import UIKit

class DataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var items: [(Int,String,String)] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        table.delegate = self
        table.dataSource = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        table.delegate = self

        // Get "product list" from pre-canned demo endpoint
        MAS.getFrom("/protected/resource/products", withParameters: ["operation":"listProducts"], andHeaders: [:]) { (response: [NSObject : AnyObject]!, error: NSError!) in
            if(error != nil)
            {
                print(error.localizedDescription)
                return
            }
            let json = response[MASResponseInfoBodyInfoKey]!["products"]!
            print(json!.count)
            self.items.removeAll()
            for product in json as! [Dictionary<String, AnyObject>]
            {
                let id = product["id"] as! Int
                let name = product["name"] as! String
                let price = product["price"] as! String
                self.items.append((id, name, price))
            }
            print(self.items)
            self.table.reloadData()

        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.table.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        let (itemId, itemName, itemPrice) = self.items[indexPath.row]
        
        cell.textLabel?.text = itemName + " | SKU: "+String(itemId)+" | $" + itemPrice
        print(itemName + " | SKU: "+String(itemId)+" | $" + itemPrice)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }

    
    //MARK: Actions
    
    //Perform Logout
    @IBAction func doLogout(sender: UIButton) {
        
        let curUser = MASUser.currentUser()
        
        curUser.logoffWithCompletion({(completed: Bool, error: NSError!) -> () in
            
            //
            // Hide the activity view
            //
           // MASMainViewController.sharedViewController.hideActivityStatusView(1.0, completion: nil)
            
            //
            // Handle the error
            //
            if(error != nil)
            {
               
                return;
            }
            
            
            
        })
        

    }
    

}

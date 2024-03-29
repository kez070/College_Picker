//
//  ViewController.swift
//  My College Builder
//
//  Created by Kenny on 7/6/15.
//  Copyright © 2015 EGGROLLS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var editButton: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    var cities : [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editButton.tag = 0
        cities.append(City(name: "chicago", state: "illinois", population: 27000, image: UIImage(named:"SFflag")!))
        cities.append(City(name: "shanghai", state: "shanghai", population: 3002131, image: UIImage(named:"default")!))
        cities.append(City(name: "Louisianna", state: "Nowhere", population: 2721312000, image: UIImage(named:"Lflag")!))
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = cities[indexPath.row].name
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete{
            cities.removeAtIndex(indexPath.row)
            tableView.reloadData()
        }
    }

    @IBAction func onTappedPlus(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add City", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addTextFieldWithConfigurationHandler { (textField) -> Void in
            textField.placeholder = "Add City Here"
        }
        let cancelAction = UIAlertAction(title: "cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancelAction)
        
        let addAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.Default) { (action) -> Void in
            let cityTextField = alert.textFields![0] as UITextField
            self.cities.append(City(name: cityTextField.text!))
            self.tableView.reloadData()
        }
        alert.addAction(addAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        let city = cities[sourceIndexPath.row]
        cities.removeAtIndex(sourceIndexPath.row)
        cities.insert(city, atIndex: destinationIndexPath.row)
    }

    @IBAction func onTappedEditButton(sender: UIBarButtonItem) {
        if sender.tag == 0{
            tableView.editing = true
            sender.tag = 1
        }
        else {
            tableView.editing = false
            sender.tag = 0
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc = segue.destinationViewController as! DetailViewController
        let index = tableView.indexPathForSelectedRow?.row
        dvc.city = cities[index!]
    }

}


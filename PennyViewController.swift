//
//  PennyViewController.swift
//  PennySwiftXCode11
//
//  Created by Christine Sun on 12/8/21.
//

import UIKit

class PennyViewController: UIViewController {

    // The text field users edit to search for an author
    @IBOutlet weak var authorTextField: UITextField!
    
    // The label that displays the results of the search
    @IBOutlet weak var resultsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // This function is called every time the text inside authorTextField changes
    @IBAction func textDidChange(_ sender: Any) {
        
        // Get the text in authorTextField
        var author:String = self.authorTextField.text!
        
        // URL encode the author text input
        author = author.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        // Instantiate an object of the standard class URL that will be used to send to the server an HTTP request for the specified author
        let url = URL(string:"https://pennyandroidserver.herokuapp.com/searchresults?author=\(author)")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            if let data = data {
                // data is NOT nil
                DispatchQueue.main.async {
                    self.resultsLabel.text = String(data: data, encoding: .utf8)!
                }
            } else {
                // data IS nil
                DispatchQueue.main.async {
                    self.resultsLabel.text = error!.localizedDescription
                }
            }
        }
        task.resume()
    }
    

}

//
//  ViewController.swift
//  MyMovieAppGruper
//
//  Created by MICHAEL GRUPER on 1/17/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let movieNames = [String]()
    @IBOutlet weak var tableViewOutlet: UITableView!

    @IBOutlet weak var errorLabelOutlet: UILabel!
    @IBOutlet weak var textFieldOutlet: UITextField!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        return UITableViewCell()
    }
    func getMovie(){
        let session = URLSession.shared
        let movieSearchParameter = textFieldOutlet.text!
            let movieURL = URL(string: "http://www.omdbapi.com/?&apikey=62536319&s=\(movieSearchParameter)")!
       
            let dataTask = session.dataTask(with: movieURL) { data, response, error in
                    if let d = data{
                        if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: .fragmentsAllowed) as? NSDictionary {
                            print(jsonObj)
                            if jsonObj.value(forKey: "Error") != nil{
                                DispatchQueue.main.async{
                                    self.errorLabelOutlet.isHidden = false
                                   self.errorLabelOutlet.text = "Error: Enter a valid movie title!"
                                }
                            }
//                            else{
//                                let j = jsonObj.value(forKey: "Year")!
//                            DispatchQueue.main.async{
//                               self.nameLabelOutlet.text = "Movie Release Year: \(j)"
//                            }
                        }
                    }
                
            }
            dataTask.resume()
        
    }
    @IBAction func searchButtonAction(_ sender: UIButton) {
        getMovie()
    }
    
}


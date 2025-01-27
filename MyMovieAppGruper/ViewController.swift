//
//  ViewController.swift
//  MyMovieAppGruper
//
//  Created by MICHAEL GRUPER on 1/17/25.
//

import UIKit


struct Movie: Codable{
    var titles: String
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let movieNames = [String]()
    @IBOutlet weak var tableViewOutlet: UITableView!

    @IBOutlet weak var errorLabelOutlet: UILabel!
    @IBOutlet weak var textFieldOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
               cell.textLabel?.text = "Hello World!"
               return cell
    }
    func getMovie(){
        let session = URLSession.shared
        let movieSearchParameter = textFieldOutlet.text!
            let movieURL = URL(string: "http://www.omdbapi.com/?&apikey=62536319&s=\(movieSearchParameter)")!
       
            let dataTask = session.dataTask(with: movieURL) { data, response, error in
                    if let d = data{
                        if let jsonObj = try? JSONSerialization.jsonObject(with: d, options: []) as? NSDictionary {
                            print(jsonObj)
                            if let movieObj = try? JSONDecoder().decode(Movie.self, from: d){
                                //print(movieObj.titles)
                                
                                for r in movieObj.titles{
                                    print("Title: \(r)")
                                                            }
                                                   }
                                                   else{
                                                       print("error decoding to movie object")
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


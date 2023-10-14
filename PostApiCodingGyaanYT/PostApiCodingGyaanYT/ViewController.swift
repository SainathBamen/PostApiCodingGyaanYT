//
//  ViewController.swift
//  PostApiCodingGyaanYT
//
//  Created by Sainath Bamen on 16/09/23.
//

import UIKit
import Foundation


struct user : Decodable{
    let userId:Int
    let id :Int
    let title : String
    let body: String
    
    enum CodingKeys:String, CodingKey{
        case userId
        case id
        case title
        case body
    }
    
}



class ViewController: UIViewController {
    
    //@IBOutlet weak var txtId: UITextField!
    
    @IBOutlet weak var txtUserId: UITextField!
    
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var txtBody: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addActionBtn(_ sender: Any) {
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        let parameters:[String:Any] = [
            "title" : txtTitle.text ?? "",
            "body": txtBody.text ?? "",
            "userId": txtUserId.text ?? ""
            
        ]
        guard let apiUrl = URL(string: url) else{
            print("ur not enter right format to call api")
            return
            
        }
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else{
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request){(data, res, err) in
            guard err == nil else{
                debugPrint("Error found")
                return
            }
            
            guard let res = res as? HTTPURLResponse,(200..<299) ~= res.statusCode else{
                debugPrint("Success")
                return
            }
            
            guard let data = data else{
                print("Error found")
                return
            }
            print(res)
            
        }.resume()
        
    }
}



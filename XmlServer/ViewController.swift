//
//  ViewController.swift
//  XmlServer
//
//  Created by R Shantha Kumar on 1/11/20.
//  Copyright © 2020 R Shantha Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,XMLParserDelegate,UITableViewDelegate,UITableViewDataSource {
    
    

    var xmlParserobj:XMLParser!
    var dataTask:URLSessionDataTask!
    
    var currentZone:String!
    
    var tableVie:UITableView!
    
    var titles = [String]()
    var category = [String]()
    var dicrption = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
        
        print(titles)
        return titles.count
            
            
           }
           
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "abcd")
    //
               cell.backgroundColor = .systemBlue
            
               cell.textLabel?.text = titles[indexPath.row]
    //
            cell.textLabel?.textColor = .blue
               print("@@@@@@@@@@@@@")
               
               return cell
           }
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xml()
        
        tableVie = UITableView(frame: view.frame, style: UITableView.Style.plain)
        tableVie.register(UITableViewCell.self, forCellReuseIdentifier: "abcd")
        
       view.addSubview(tableVie)
        
        tableVie.delegate = self
        tableVie.dataSource = self
       
    }
    
    func parserDidStartDocument(_ parser: XMLParser){
    
        
    }

    func parser(_ parser: XMLParser, foundCharacters string: String){
        
       
        
        let trimmedElement = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if(trimmedElement.count > 0){
        
        if(currentZone == "title"){
            
            titles.append(trimmedElement)
       
        }
        else if(currentZone == "category"){
                   
                   category += [trimmedElement]
              
               }
        else if(currentZone == "description"){
                   
                   dicrption += [trimmedElement]
              
               }
        }
             
 print(titles)
        
        
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        
        if(elementName == "title" || elementName == "category" || elementName == "description"){
            
            
            currentZone = elementName

        }
       

        
        
    }
     
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        
        
        
    }
    func parserDidEndDocument(_ parser: XMLParser){
        
        tableVie.reloadData()
        
    }
    
    
    
    
    
    
    
    
    
    
    
    func xml(){
        var urlRequest = URLRequest(url: URL(string: "https://rss.itunes.apple.com/api/v1/in/ios-apps/top-free/all/10/explicit.rss")!)

        urlRequest.httpMethod = "GET"

        dataTask = URLSession.shared.dataTask(with: urlRequest, completionHandler: { (data, connectionDetails, error) in
            
            do{
            self.xmlParserobj =  XMLParser(data: data!)
            self.xmlParserobj.delegate = self
            self.xmlParserobj.parse()
            
                print(self.xmlParserobj)
            }
            catch{
                
                print("parsing failed")
                
            }
       
        })
         self.dataTask.resume()
    }
    
    
    
    
    

}


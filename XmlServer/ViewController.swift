//
//  ViewController.swift
//  XmlServer
//
//  Created by R Shantha Kumar on 1/11/20.
//  Copyright © 2020 R Shantha Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,XMLParserDelegate {

    var xmlParserobj:XMLParser!
    var dataTask:URLSessionDataTask!
    
    var currentZone:String!
    
    var allApps = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        xml()
        // Do any additional setup after loading the view.
    }
    
    func parserDidStartDocument(_ parser: XMLParser){
    
        print(parser)
    }

    func parser(_ parser: XMLParser, foundCharacters string: String){
        
       
        
        let trimmedElement = string.trimmingCharacters(in: CharacterSet.whitespaces)
        
      
        if(currentZone == "item"){
            
            allApps += [trimmedElement]
            
            print(allApps)
            
        }
        
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        
        if(currentZone == "item"){
            
            
            currentZone = elementName
            
        }
        
    }
     
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        
        
        
    }
    func parserDidEndDocument(_ parser: XMLParser){
        
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


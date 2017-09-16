//
//  ViewController.swift
//  Proyec
//
//  Created by JanPier Armijos on 15/9/17.
//  Copyright © 2017 JanPier Armijos. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextFieldDelegate {

  
    @IBOutlet weak var libro: UITextField!
    
    
    @IBOutlet weak var textoRespuesta: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        libro.delegate = self
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
       @IBAction func btnBuscar(sender: AnyObject) {
        
   
        
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + libro.text!
        let url = NSURL(string: urls)
        let session = NSURLSession.sharedSession()
        var response = ""
        let bloque = { (datos: NSData?, resp: NSURLResponse?, error: NSError?) -> Void in
            if datos != nil {
                let texto = NSString(data: datos!, encoding: NSUTF8StringEncoding)
                response = texto! as String
                dispatch_async(dispatch_get_main_queue(), {
                    self.cargarTextView(response)
                })
            }
            else {
                let alertController = UIAlertController(title: "Error", message: "Ha ocurrido un error, intente nuevamente", preferredStyle: .Alert)
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                    print("you have pressed OK button");
                }
                alertController.addAction(OKAction)
                self.presentViewController(alertController, animated: true, completion:nil)
            }
        }
        let dt = session.dataTaskWithURL(url!, completionHandler: bloque)
        dt.resume()
       
       
        }
    
    @IBAction func btnBorrar(_ sender: Any) {
        libro.text = ""
        textoRespuesta.text = ""
    }

}


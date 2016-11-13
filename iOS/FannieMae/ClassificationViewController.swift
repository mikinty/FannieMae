//
//  ClassificationViewController.swift
//  FannieMae
//
//  Created by Arunjot Singh on 11/12/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import Firebase
import FirebaseInstanceID
import FirebaseAnalytics
import SwiftyJSON

class ClassificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    //@available(iOS 2.0, *)
    
    var object = Property()
    var url = ""
    var index = 0
    let paths = ["img/plumbing/plumb.jpg","img/electricity/electricity.jpg","img/lawn/lawn.jpg","img/bathrooms/bathroom.jpg",
                 "img/bedrooms/bedroom.jpg","img/roof/roof.jpg","img/AC/ac.jpg","img/heating/heating.jpg","img/windows/window.jpg"]
    
    @IBOutlet var postImageView: UIVisualEffectView!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var imagePicked: UIImageView!
    
    @IBOutlet var imageDisplay: UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var postbutton: UIBarButtonItem!
    @IBOutlet var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextField.delegate = self
        postImageView.isHidden = true
        
        displayImage()
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func displayImage() {
        print(url)
        if(url == "") {
            
        } else {
            indicator.startAnimating()
            label.text = ""
            let Url = "\(object.id)/\(url)"
            let storageRef = FIRStorage.storage().reference(forURL: "gs://fanniemae-efcae.appspot.com/\(Url)")
            
            storageRef.downloadURL { (URL, error) -> Void in
                
                if (error != nil) {
                    print(error!)
                    self.indicator.stopAnimating()
                    
                } else {
                    if let data = NSData(contentsOf: URL!) {
                        let image = UIImage(data: data as Data)
                        self.imageDisplay.image = image
                    }
                    self.indicator.stopAnimating()
                }
            }
        }
    }
    
  
    
 
    var imagePicker: UIImagePickerController?
    
    @IBAction func camera(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            imagePicker = UIImagePickerController()
            imagePicker?.delegate = self
            imagePicker?.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker?.allowsEditing = true
            self.present(imagePicker!, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func gallery(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            imagePicker = UIImagePickerController()
            imagePicker?.delegate = self
            imagePicker?.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker?.allowsEditing = true
            self.present(imagePicker!, animated: true, completion: nil)
        }
    }
    
   
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("Did Pick image")
        let image = info[UIImagePickerControllerEditedImage]
        postImageView.isHidden = false
        imagePicked.image = image as! UIImage?
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postImage(_ sender: UIBarButtonItem) {
        print("lalalalalalalal")
        let rootRef = FIRDatabase.database().reference(withPath: "0001")
        print(rootRef)
        
        let url = paths[index]
        let storageRef = FIRStorage.storage().reference(forURL: "gs://fanniemae-efcae.appspot.com/")
        
        // Points to "images"
        let imagesRef = storageRef.child("\(object.id)/\(url)")
        
        if let image = imagePicked.image {
            activityIndicator.startAnimating()
            postbutton.isEnabled = false
            let data = UIImagePNGRepresentation(image) as NSData?
            let uploadTask = imagesRef.put(data as! Data, metadata: nil) { metadata, error in
                if (error != nil) {
                    print("there's an error")
                    // Uh-oh, an error occurred!
                    self.activityIndicator.stopAnimating()
                    self.postbutton.isEnabled = true
                    
                } else {
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    //let downloadURL = metadata!.downloadURL
                    print("upload complete")
                    self.activityIndicator.stopAnimating()
                    self.postbutton.isEnabled = true
                    self.postImageView.isHidden = true
                }
            }
            
            uploadTask.observe(.progress, handler: { (snapshot) in
                //let progress = snapshot.progress
                //self.progressView.progress
            })

        }
        
        let file = "file.txt" //this is the file. we will write to and read from it
        
        let text = "some text" //just a text

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            
            let path = dir.appendingPathComponent(file)
            
            //writing
            do {
                try text.write(to: path, atomically: false, encoding: String.Encoding.utf8)
                print("no error")
            }
            catch {print("error")}
            let localFile: NSURL = path as NSURL//NSURL.fileURL(withPath: path) as NSURL
            let riversRef = storageRef.child("images/rivers.text")
            
            // Upload the file to the path "images/rivers.jpg"
            let uploadTask = riversRef.putFile(localFile as URL, metadata: nil) { metadata, error in
                if (error != nil) {
                    // Uh-oh, an error occurred!
                } else {
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    let downloadURL = metadata!.downloadURL
                    print("uploaded file?(!)")
                }
            }
            //reading
            do {
                let text2 = try String(contentsOf: path, encoding: String.Encoding.utf8)
            }
            catch {/* error handling here */}
        }
        //let urlPath = Bundle.main.path(forResource: "file", ofType: "txt")
        
        
        
        //let ref = FIRDatabase.database().reference(forURL: "gs://fanniemae-efcae.appspot.com")

        
        // Points to "images/space.jpg"
        // Note that you can use variables to create child values
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "classificationCell", for: indexPath)
//        cell.textLabel?.text = classification[indexPath.row]
//        cell.accessoryType = .none
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "show", sender: self)
        
    }
   
    
    
    
    
    
    var kbHeight: CGFloat!
    
    override func viewWillAppear(_ animated:Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let keyboardSize =  (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                kbHeight = keyboardSize.height
                self.animateTextField(up: true)
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.animateTextField(up: false)
    }
    
    func animateTextField(up: Bool) {
        let movement = (up ? -kbHeight : kbHeight)
        
        UIView.animate(withDuration: 0.3, animations: {
            self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement!)
        })
    }
    
}

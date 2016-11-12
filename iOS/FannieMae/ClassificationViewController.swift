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

class ClassificationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    @IBOutlet var postImageView: UIVisualEffectView!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var imagePicked: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionTextField.delegate = self
        postImageView.isHidden = true
        
        // Do any additional setup after loading the view, typically from a nib.
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
        
        let storageRef = FIRStorage.storage().reference(forURL: "gs://fanniemae-efcae.appspot.com/")
        
        // Points to "images"
        let imagesRef = storageRef.child("0001/test.jpeg")
        
        if let image = imagePicked.image {
            
            let data = UIImagePNGRepresentation(image) as NSData?
            let uploadTask = imagesRef.put(data as! Data, metadata: nil) { metadata, error in
                if (error != nil) {
                    print("there's an error")
                    // Uh-oh, an error occurred!
                } else {
                    // Metadata contains file metadata such as size, content-type, and download URL.
                    //let downloadURL = metadata!.downloadURL
                    print("upload complete")
                }
            }
            
            uploadTask.observe(.progress, handler: { (snapshot) in
//                let progress = snapshot.progress
//                self.progressView.progress
            })
        }
        
        
        
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

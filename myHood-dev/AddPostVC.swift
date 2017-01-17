//
//  AddPostVC.swift
//  myHood-dev
//
//  Created by Eduardo Chiaro on 1/17/17.
//  Copyright © 2017 Eduardo Chiaro. All rights reserved.
//

import UIKit

class AddPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postImg.layer.cornerRadius = postImg.frame.size.width / 2
        postImg.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func SavePostPressed(_ sender: Any) {
        
        if let title = titleField.text, let desc = descField.text, let img = postImg.image {
            let imgPath = DataService.instance.saveImage(image: img)
            
            let post = Post(imagePath: imgPath, title: title, description: desc)
            DataService.instance.addPost(post: post)
            self.dismiss(animated: true, completion: nil)
        }
        
    }

    @IBAction func CancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func AddPicPressed(_ sender: UIButton) {
        
        present(imagePicker, animated: true, completion: nil)
        
        
        sender.setTitle("", for: .normal)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            postImg.image = pickedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
}

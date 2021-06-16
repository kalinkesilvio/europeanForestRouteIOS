//
//  UploadViewController.swift
//  forestTrail_Prototype01
//
//  Created by Moser Adrian on 26.05.21.
//

import UIKit

class UploadViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    @IBAction func didTapButton() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        


    }
    
    
    @IBAction func uploadPic(_ sender: UIButton) {
        
    }
    
    func httpPost(stringData: Data) {
        let url = URL(string: "localhost")
        guard let requestURL = url else { fatalError() }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "POST"
        
        let postString = "yesyes";
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        
        
        
    }
        
}



extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")]as? UIImage {
            imageView.image = image
            print(image)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

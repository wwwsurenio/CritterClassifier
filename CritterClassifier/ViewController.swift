//
//  ViewController.swift
//  CritterClassifier
//
//  Created by User01 on 11/3/23.
//

import UIKit
import CoreML
import Vision


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textBox: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageView.image = userPickedImage
            
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Could not convert UIImage into CI Image")
            }
            
            detect(image: ciimage)
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: CritterClassifier().model) else{
            fatalError("Loading CoreML Model Failed.")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Failed to process image! ")
            }
            
//            if let firstResult = results.first{
//                if firstResult.identifier.contains("Dog"){
//                    self.imageView.image = UIImage(named: "dog")
//                    self.navigationItem.title = "It looks like a dog!"
//                    self.textBox.text = "This looks like a Dog, our classifier is confident with a \(String(format: "%.0f", (firstResult.confidence * 100))) % "
//                    self.textBox.sizeToFit()
//                }else if firstResult.identifier.contains("Cat"){
//                    self.imageView.image = UIImage(named: "cat")
//                    self.navigationItem.title = "It looks like a cat!"
//                    self.textBox.text = "This looks like a Cat, our classifier is confident with a \(String(format: "%.0f", (firstResult.confidence * 100))) % "
//                    self.textBox.sizeToFit()
//                }else if firstResult.identifier.contains("Rabbit"){
//                    self.imageView.image = UIImage(named: "rabbit")
//                    self.navigationItem.title = "It looks like a Rabbit!"
//                    self.textBox.text = "This looks like a Rabbit, our classifier is confident with a \(String(format: "%.0f", (firstResult.confidence * 100))) % "
//                    self.textBox.sizeToFit()
//                }else{
//                    self.navigationItem.title = "Not a Critter !"
//                }
//            }
            
            
            if let firstResult = results.first {
                switch firstResult.identifier {
                case let id where id.contains("Dog"):
                    self.imageView.image = UIImage(named: "dog")
                    self.navigationItem.title = "It looks like a dog!"
                    self.textBox.text = "This looks like a Dog, our classifier is confident with a \(String(format: "%.0f", (firstResult.confidence * 100))) % "
                    self.textBox.sizeToFit()
                case let id where id.contains("Cat"):
                    self.imageView.image = UIImage(named: "cat")
                    self.navigationItem.title = "It looks like a cat!"
                    self.textBox.text = "This looks like a Cat, our classifier is confident with a \(String(format: "%.0f", (firstResult.confidence * 100))) % "
                    self.textBox.sizeToFit()
                case let id where id.contains("Rabbit"):
                    self.imageView.image = UIImage(named: "rabbit")
                    self.navigationItem.title = "It looks like a Rabbit!"
                    self.textBox.text = "This looks like a Rabbit, our classifier is confident with a \(String(format: "%.0f", (firstResult.confidence * 100))) % "
                    self.textBox.sizeToFit()
                default:
                    self.navigationItem.title = "Not a Critter !"
                }
            }
            
//            print("These are the results we get from the results constant\(results) END of first print")
//            print("This is the 2nd Print, confidence of first is equal to \(results.first?.confidence)")
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
            try handler.perform([request])
        }
        catch{
            print(error)
        }
        
    }
    
    
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
} //ViewController class end


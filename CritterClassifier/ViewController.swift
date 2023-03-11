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
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textBox: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 0.92, green: 0.11, blue: 0.21, alpha: 1.00)]
        
    }


    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
    }
    
}


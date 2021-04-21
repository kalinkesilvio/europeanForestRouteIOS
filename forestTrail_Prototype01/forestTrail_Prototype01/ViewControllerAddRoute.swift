//
//  ViewControllerAddRoute.swift
//  forestTrail_Prototype01
//
//  Created by Valentina Sageder on 21.04.21.
//

import UIKit

class ViewControllerAddRoute: UIViewController {
    
    @IBOutlet weak var idRouteTextField: UITextField!
    @IBOutlet weak var nameOfRouteTextField: UITextField!
    @IBOutlet weak var lengthTextField: UITextField!
    
    @IBOutlet weak var idControlPointTextField: UITextField!
    @IBOutlet weak var nameControlPointTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var countrAbbrTextField: UITextField!
    
    @IBOutlet weak var addControlPointButton: UIButton!
    @IBOutlet weak var addRouteButton: UIButton!
    
    @IBOutlet weak var displayContrP: UILabel!
    
    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addControlPoint(_ sender: Any) {
        
        if (idControlPointTextField.hasText && nameControlPointTextField.hasText && longitudeTextField.hasText && latitudeTextField.hasText && countrAbbrTextField.hasText) {
            
            let longitude = (Double)(longitudeTextField.text!) ?? 0.0
            let latitude = (Double)(latitudeTextField.text!) ?? 0.0
            
            if longitude == 0.0 {
                print("longitude value is not correct")
                if latitude == 0.0 {
                    print("latitude value is not correct")
                }
            }
            
            model.controlPoints.append(ControlPoint(id: idControlPointTextField.text ?? "", name: nameControlPointTextField.text ?? "", longitude: longitude, latitude: latitude, countryAbbr: countrAbbrTextField.text ?? ""))
            
            
            displayContrP.text! += "| \(idControlPointTextField.text!), \(nameControlPointTextField.text!), \(longitude), \(latitude), \(countrAbbrTextField.text!)"
            
            idControlPointTextField.text = ""
            nameControlPointTextField.text = ""
            longitudeTextField.text = ""
            latitudeTextField.text = ""
            countrAbbrTextField.text = ""
    
        } else {
            print("please insert the missing values")
        }
        
    }
    
    @IBAction func addRoute(_ sender: Any) {
        if (idRouteTextField.hasText && nameOfRouteTextField.hasText && lengthTextField.hasText) {
            
            if model.controlPoints.count > 0 {
                model.streckenAbschnitte.append(StreckenAbschnitt(id: idRouteTextField.text!, name: nameOfRouteTextField.text!, controlPoints: model.controlPoints, length: (Double)(lengthTextField.text!) ?? 0.0))
                
                idRouteTextField.text = ""
                nameOfRouteTextField.text = ""
                lengthTextField.text = ""
                
                print("route added: \(model.streckenAbschnitte.last!.name)")
            } else {
                print("You have to add controlpoints")
            }
        } else {
            print("Please fill in the missing fields")
        }
        
    }
    

}

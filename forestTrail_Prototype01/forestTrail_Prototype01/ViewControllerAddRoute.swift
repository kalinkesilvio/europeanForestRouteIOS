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

    @IBOutlet var tapRec: UITapGestureRecognizer!
    
    
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
                        
                if model.streckenAbschnitte.isEmpty {
                    self.displayContrP.text = "The Array is empty."
                }
                
                //self.jsonFileUpload(newRoute: model.streckenAbschnitte.last!)
            
                self.networkUpload(url: URL(string: "localhost")!, newRoute: model.streckenAbschnitte.last!)
                
                // TODO: call jsonFileUpload Method to add the route 
//                if try self.jsonFileUpload(newRoute: <#T##StreckenAbschnitt#>) {
//
//                }
                
                print("route added: \(model.streckenAbschnitte.last!.name)")
            } else {
                print("You have to add controlpoints")
            }
        } else {
            print("Please fill in the missing fields")
        }
        
    }
    
    private func networkUpload(url: URL!, newRoute: StreckenAbschnitt) {
        do {
             
            var contrP: [ControlPointCodeable] = []
            
            for point in newRoute.controlPoints {
                contrP.append(
                    ControlPointCodeable(
                        id: point.id, name: point.name,
                        longitude: point.longitude, latitude: point.latitude,
                        countryAbbr: point.countryAbbr)
                )
            }
            
            let route = RouteCodable(id: newRoute.id, name: newRoute.name, controlPoints: contrP, length: newRoute.length)
            
//            let encoder = JSONEncoder()
//            encoder.outputFormatting = .prettyPrinted
//
//            let jsonData = try! encoder.encode(route)
//
            guard let requestURL = url else {
                fatalError()
            }
            
            var request = URLRequest(url: requestURL)
            request.httpMethod = "POST"
            
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        
            let postString = "id=\(route.id)&name=\(route.name)&controlPoints=\(route.controlPoints)&length=\(route.length)"
            
            request.httpBody = postString.data(using: String.Encoding.utf8)
            
            let task = URLSession.shared.dataTask(with: request) { (data, encoding, error) in
                
                if let error = error {
                    print(error)
                    return
                }
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                }
            }
        
            task.resume()
            
        }
    }
    
    @IBAction func tapRec(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    struct RouteCodable: Codable {
        var id: String
        var name: String
        var controlPoints: [ControlPointCodeable]
        var length: Double
        
        enum Codingkeys: String, CodingKey {
            case id = "idOfRoute"
            case name = "nameOfRoute"
            case controlPoints
            case length = "lengthOfRoute"
        }
    }
    
    struct ControlPointCodeable: Codable {
        var id: String
        var name: String
        var longitude: Double
        var latitude: Double
        var countryAbbr: String
        
        enum Codingkeys: String, CodingKey {
            case id = "idOfControlPoint"
            case name = "nameOfControlPoint"
            case longitude
            case latitude
            case countryAbbr
        }
    }

}

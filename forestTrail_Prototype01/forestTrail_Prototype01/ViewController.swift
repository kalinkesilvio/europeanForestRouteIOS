//
//  ViewController.swift
//  forestTrail_Prototype01
//
//  Created by Kalinke Silvio on 04.03.21.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var addRouteButton: UIButton!
    
    var model = Model()
    
    var textBoxPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textBox.inputView = textBoxPicker
        
        textBox.placeholder = "Select a route"
        
        textBox.textAlignment = .center
        
        textBoxPicker.delegate = self
        textBoxPicker.dataSource = self
        
        mapView.delegate = self
        
    }
    
    @IBAction func addRoute(_ sender: Any) {
        performSegue(withIdentifier: "addRoute", sender: self)
    }
    
    @IBAction func valueChanged(_ sender: Any) {
        
        if mapView.annotations.count != 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        getStreckenAbschnittWithName(dropDown)
    }
    
    
    
}

extension ViewController:  UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.streckenAbschnitte.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return model.streckenAbschnitte[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        textBox.text = model.streckenAbschnitte[row].name
        textBox.resignFirstResponder()
        
    }
    
    class MyPointAnnotation: MKPointAnnotation {
        var startingPoint = false
        var endingPoint = false
    }
    
    func showRouteOnMap(pickUpCoordinate: CLLocationCoordinate2D, destinationCoordinate: CLLocationCoordinate2D) {
        
        /*let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: pickUpCoordinate, addressDictionary: nil))
        
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate, addressDictionary: nil))
        
        request.requestsAlternateRoutes = true
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        
        
        self.mapView.addOverlay()*/
    }
    
    func getStreckenAbschnittWithName(_ pickerView: UIPickerView) {
        if textBox.text != "" {
            for strAb in model.streckenAbschnitte {
                if strAb.name == textBox.text {
                    getLongLatPoint(strAb: strAb)
                    
                    label1.text = "ControlPoints changed to \(strAb.name)"
                }
            }
        } else {
            print("Select a distance")
        }
    }
    
    private func getLongLatPoint(strAb: StreckenAbschnitt) {
        for contrPoints in strAb.controlPoints {
            let latitude: Double = contrPoints.latitude
            let longitude: Double = contrPoints.longitude
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            mapView.addAnnotation(annotation)
            
            annotation.title = NSLocalizedString(contrPoints.name, comment: "")
            let polyline = MKGeodesicPolyline(coordinates: &annotation.coordinate, count: mapView.annotations.count)
            mapView.addOverlay(polyline)
            
            let viewSpan = MKCoordinateSpan.init(latitudeDelta: 1, longitudeDelta: 1)
            
            let region: MKCoordinateRegion = MKCoordinateRegion.init(center: annotation.coordinate, span: viewSpan)
            self.mapView.setRegion(region, animated: true)
            
        }
    }
}

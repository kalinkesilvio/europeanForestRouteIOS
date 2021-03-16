//
//  Model.swift
//  forestTrail_Prototype01
//
//  Created by Kalinke Silvio on 04.03.21.
//

import Foundation

class StreckenAbschnitt {
    
    var id: String
    var name: String
    var controlPoints: [ControlPoint]
    var length: Double
    
    init(id: String, name: String, controlPoints: [ControlPoint], length: Double) {
        self.id = id
        self.name = name
        self.controlPoints = controlPoints
        self.length = length
    }
    
}

class ControlPoint {
    
    var id: String
    var name: String
    var longitude: Double
    var latitude: Double
    var countryAbbr: String
    
    init(id: String, name: String, longitude: Double, latitude: Double, countryAbbr: String) {
        self.id = id
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.countryAbbr = countryAbbr
    }
    
}

class Model {
    
    var streckenAbschnitte: [StreckenAbschnitt] = []
    
    init() {
        self.fillWithStrecken()
    }
    
    
    func fillWithStrecken() {
        
        var controlPoints01: [ControlPoint] = []
        var controlPoints02: [ControlPoint] = []
        
        controlPoints01.append(
                ControlPoint(
                    id: "011", name: "Wreechensee", longitude: 13.462928, latitude: 54.32832, countryAbbr: "D"
                )
                //ControlPoint(id: "011", name: "Waldhalle", longitude: "13°40'27,735''", latitude: "54°32'10,9030''", countryAbbr: "D")
        )
        
        controlPoints01.append(
            ControlPoint(
                id: "010", name: "Waldhalle", longitude: 13.402774, latitude: 54.321093, countryAbbr: "D"
            )
        )
        
        controlPoints01.append(
            ControlPoint(
                id: "012", name: "Stralsund", longitude: 13.61029, latitude: 54.181682, countryAbbr: "D"
            )
        )
        
        controlPoints02.append(
            ControlPoint(
                id: "012", name: "Stralsund", longitude: 13.610287, latitude: 54.1816820, countryAbbr: "D"
            )
        )
        
        controlPoints02.append(
            ControlPoint(
                id: "020", name: "Grenztalmoor", longitude: 12.740701, latitude: 54.096175, countryAbbr: "D"
            )
        )
        
        streckenAbschnitte.append(
            StreckenAbschnitt(
                id: "01", name: "Sassnitz - Stralsund", controlPoints: controlPoints01, length: 105.7
            )
        )
        
        streckenAbschnitte.append(
            StreckenAbschnitt(
                id: "02", name: "Stralsund - Malchow", controlPoints: controlPoints02, length: 177.3
            )
        )
    }
}

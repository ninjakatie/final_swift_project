//
//  Place.swift
//
//  Created by Katie Fedoseeva
//  Copyright © 2019. All rights reserved.
//  Interactive game: Pick the country that matches the flag.

import MapKit

extension Place: MKAnnotation { }

@objc class Place: NSObject {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    var flagName: String?
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D, flagName: String?) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        self.flagName = flagName
    }
    
    static func getPlaces() -> [Place] {
        guard let path = Bundle.main.path(forResource: "Places", ofType: "plist"), let array = NSArray(contentsOfFile: path) else { return [] }
        
        var places = [Place]()
        
        for item in array {
            let dictionary = item as? [String : Any]
            let title = dictionary?["title"] as? String
            let subtitle = dictionary?["description"] as? String
            let latitude = dictionary?["latitude"] as? Double ?? 0, longitude = dictionary?["longitude"] as? Double ?? 0
            let flagName = dictionary?["flagImageName"] as? String
            
            let place = Place(title: title, subtitle: subtitle, coordinate: CLLocationCoordinate2DMake(latitude, longitude), flagName: flagName)
            places.append(place)
        }
        
        return places as [Place]
    }
}

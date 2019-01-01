//
//  ViewController.swift
//
//  Created by Katie Fedoseeva
//  Copyright © 2019. All rights reserved.
//  Interactive game: Pick the country matching the flag.

import GameplayKit
import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var flagButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func nextButtonTapped(_ sender: Any) {
        randomFlag()
    }
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var places = Place.getPlaces()
    var currentPlace: Place?

    override func viewDidLoad() {
        super.viewDidLoad()
        requestLocationAccess()
        addAnnotations()
        randomFlag()
        
        //Adding countries/images to the countries array:
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        
    }
    
    //randomizes the places array and assigns a flag to the image.
    func randomFlag() {
    places = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: places) as! [Place]
    
    currentPlace = places[0]
    
    let flagImg = UIImage(named: (currentPlace?.flagName!)!)
    flagButton.setImage(flagImg, for: .normal)
    }
    
    //enables real-time user location.
    func requestLocationAccess() {
        let status = CLLocationManager.authorizationStatus()
        let locationManager = CLLocationManager()
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            return
            
        case .denied, .restricted:
            print("location access denied")
            
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }

    //Adding the pins for different countries that correlate to the flags.
    func addAnnotations() {
        mapView?.delegate = self
        mapView?.addAnnotations(places)
    }
    
    //trigerring an alert on click of annotation.
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let clickedPlace = view.annotation as! Place
        let placeName = view.annotation?.title
        let placeInfo = view.annotation?.subtitle
        //       let flagCountry = flagButton.currentTitle
        let ac = UIAlertController(title: placeName!, message: placeInfo!, preferredStyle: .alert)
        
        if(clickedPlace.flagName == currentPlace?.flagName) {
            //you clicked on the right pin
            ac.addAction(UIAlertAction(title: "Correct", style: .default))
        } else {
            ac.addAction(UIAlertAction(title: "Nope, try again", style: .default))
        }
        
        present(ac, animated: true)
    }
    
    func showPopup(ac : UIAlertController) {
        ac.show(self, sender: self)
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   }


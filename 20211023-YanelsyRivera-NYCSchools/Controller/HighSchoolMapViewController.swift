//
//  HighSchoolMapViewController.swift
//  20211023-YanelsyRivera-NYCSchools
//
//  Created by yanelsy rivera on 10/24/21.
//

import UIKit
import MapKit

class HighSchoolMapViewController: UIViewController, MKMapViewDelegate {
    
    // MARK: - Properties
    @IBOutlet var mapView: MKMapView!
    
    var school: HighSchool!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSchoolAnnotation()
    }
    
    func addSchoolAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.title = school.schoolName
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(school.latitude ?? "0") ?? 0, longitude: CLLocationDegrees(school.longitude ?? "0") ?? 0)
        annotation.coordinate = coordinate
        self.mapView.addAnnotation(annotation)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        let adjustRegion = self.mapView.regionThatFits(region)
        self.mapView.setRegion(adjustRegion, animated:true)
    }
    
    // MARK: - MapKit Delegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
    
}

//
//  ViewController.h
//  MKMapViewTest
//
//  Created by Kevin Lin on 10/13/15.
//  Copyright © 2015 Kevin Lin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>


@property(strong, nonatomic)IBOutlet MKMapView *mapView;
@property(nonatomic)CLLocationManager *locationManager;;

@end

 
//
//  ViewController.m
//  MKMapViewTest
//
//  Created by Kevin Lin on 10/13/15.
//  Copyright © 2015 Kevin Lin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *addressText;
@property (weak, nonatomic) IBOutlet UITextView *locationViewText;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Default setting
    _locationManager = [[CLLocationManager alloc] init];
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    //New setting
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.delegate = self;
    
    //self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, (self.view.bounds.size.height/2))];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    [self.view addSubview:self.mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    //CLLocation *location1 = [[CLLocation alloc] initWithLatitude:40.6919377 longitude:-73.96963];
//    MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(.0005f, 0.0005f));
//    [self.mapView setRegion:region animated:YES];
//    
    //self.locationViewText.text = [NSString stringWithFormat:@"%@", self.locationManager.location];

    //40.6919377,-73.96963
    //CLLocation *location1 = [[CLLocation alloc] initWithLatitude:40.6919377 longitude:-73.96963];
}

-(void)findLocation:(CLPlacemark *)placemark{
    NSString *address = @"";
    if(!placemark.subThoroughfare || !placemark.thoroughfare){
        address = [address stringByAppendingFormat:@"Location is not an establishment\n%@ %@ %@ %@ %@",placemark.subLocality, placemark.locality,placemark.administrativeArea, placemark.postalCode, placemark.country];
    }
    else{
        address = [address stringByAppendingFormat:@"%@ %@ %@ %@ %@ %@ %@",placemark.subThoroughfare, placemark.thoroughfare, placemark.subLocality, placemark.locality,placemark.administrativeArea, placemark.postalCode, placemark.country];
    }
    self.addressText.text = address;
}

- (IBAction)soonToCurrentLocation:(id)sender {
    MKCoordinateRegion region = MKCoordinateRegionMake(self.mapView.userLocation.coordinate, MKCoordinateSpanMake(.0005f, 0.0005f));
    [self.mapView setRegion:region animated:YES];
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:self.mapView.userLocation.coordinate.latitude longitude:self.mapView.userLocation.coordinate.longitude];
    
    self.locationViewText.text = [NSString stringWithFormat:@"%@", location];
    
    [self getAddress:location];
}
- (IBAction)soonToHome:(id)sender {
    //Home: 40.6984248,-73.9501786,21z
    CLLocation *location = [[CLLocation alloc] initWithLatitude:40.6983369 longitude:-73.9500017];
    MKCoordinateRegion region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(.0005f, 0.0005f));
    [self.mapView setRegion:region animated:YES];
    self.locationViewText.text = [NSString stringWithFormat:@"%@", self.locationManager.location];
    [self getAddress:location];
}

-(void)getAddress:(CLLocation *)location{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        }
        if (placemarks.count > 0) {
            CLPlacemark *placemark = placemarks[0];
            [self findLocation:placemark];
        }
    }];
}
@end

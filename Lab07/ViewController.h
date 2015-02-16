//
//  ViewController.h
//  Lab07
//
//  Created by developer on 2/13/15.
//  Copyright (c) 2015 developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <CoreLocation/CoreLocation.h>

NSString    *strUserLocation;
float       mlatitude;
float       mlongitude;


@interface ViewController : UIViewController<CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager     *locationManager;
@property (strong, nonatomic) CLLocation            *location;



- (IBAction)btnLista:(id)sender;
- (IBAction)btnMapa:(id)sender;

@end


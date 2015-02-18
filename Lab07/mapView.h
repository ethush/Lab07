//
//  mapView.h
//  Lab07
//
//  Created by developer on 2/16/15.
//  Copyright (c) 2015 developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <iAd/iAd.h>

@interface mapView : UIViewController <CLLocationManagerDelegate, GMSMapViewDelegate, ADBannerViewDelegate>{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}

@property (strong, nonatomic) IBOutlet UIView *Map_View;
@property (strong, nonatomic) IBOutlet UIView *myMap;

@end

//
//  mapView.h
//  Lab07
//
//  Created by developer on 2/16/15.
//  Copyright (c) 2015 developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface mapView : UIViewController <GMSMapViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *Map_View;
@property (strong, nonatomic) IBOutlet UIView *myMap;

@end

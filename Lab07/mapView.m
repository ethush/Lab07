//
//  mapView.m
//  Lab07
//
//  Created by developer on 2/16/15.
//  Copyright (c) 2015 developer. All rights reserved.
//

#import "mapView.h"
#import "ViewController.h"
#import "variables.h"
#import <GoogleMaps/GoogleMaps.h>

GMSMapView *mapView_;

@interface mapView ()

@end

@implementation mapView 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:mlatitude
                                                            longitude:mlongitude
                                                                 zoom:16];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.frame = CGRectMake(0, 0, self.myMap.frame.size.width, self.myMap.frame.size.height);
    mapView_.myLocationEnabled = YES;
    
    
    
    // Creates a marker in the center of the map.
    int i;
    for(i=0;i<maNombre.count;i++) {
        NSString *latitud = [maLatitud objectAtIndex:i];
        NSString *longitud = [maLongitud objectAtIndex:i];
        
        
        NSLog(@"%@ - %@", latitud, longitud);
        
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([latitud floatValue], [longitud floatValue]);
        marker.title = @"Master UAG";
        marker.snippet = @"A punto de salir!";
        marker.map = mapView_;
        
    }
    //GMSMarker *marker = [[GMSMarker alloc] init];
    //marker.position = CLLocationCoordinate2DMake(mlatitude, mlongitude);
    //marker.title = @"Master UAG";
    //marker.snippet = @"A punto de salir!";
    //marker.map = mapView_;
    [self.myMap addSubview:mapView_];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
     



@end

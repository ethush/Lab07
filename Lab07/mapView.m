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
#import <MapKit/MapKit.h>
#import <GoogleMaps/GoogleMaps.h>

GMSMapView *mapView_;

@interface mapView ()

@end

@implementation mapView 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self cfgiAdBanner];
    //A partir de la ubicacion del posicionador GPS se centra el mapa
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
        
        
        NSLog(@"Agregado marcador en:%@ - %@", latitud, longitud);
        
        
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = CLLocationCoordinate2DMake([latitud floatValue], [longitud floatValue]);
        marker.title = [maNombre objectAtIndex:i];
        marker.tappable = YES;
        
        marker.snippet = [maHorario objectAtIndex:i];
        marker.map = mapView_;
        
    }
    //GMSMarker *marker = [[GMSMarker alloc] init];
    //marker.position = CLLocationCoordinate2DMake(mlatitude, mlongitude);
    //marker.title = @"Master UAG";
    //marker.snippet = @"A punto de salir!";
    //marker.map = mapView_;
    [self.myMap addSubview:mapView_];
    
    //Esto debe ir para que los marcadores sean tappables *preguntar al profesor*
    mapView_.delegate = self;
}

/**********************************************************************************************
 Google Analytics
 **********************************************************************************************/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"on mapView screen";
}


#pragma mark - set current location
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
}

// Verifica y asigna como activo el marcador tocado
#pragma mark - mapview events
-(BOOL) mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker{
    NSLog(@"%@", marker.description);
    //    show info window
    [mapView_ setSelectedMarker:marker];
    return YES;
}

// Aqui se controla el tap en la ventana de informacion y manda a la aplicacion de mapas de iOS
-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker{
    NSLog(@"info window tapped");
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(marker.layer.latitude,marker.layer.longitude);
    
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:location addressDictionary:nil];
    MKMapItem *item = [[MKMapItem alloc] initWithPlacemark:placemark];
    item.name = marker.title;
    [item openInMapsWithLaunchOptions:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//---------------------------------------------------
// Aqui las funciones de iAds

- (void)cfgiAdBanner
{
    // Setup iAdView
    adView = [[ADBannerView alloc] initWithFrame:CGRectZero];
    
    //Set coordinates for adView
    CGRect adFrame      = adView.frame;
    adFrame.origin.y    = self.view.frame.size.height - 50;
    NSLog(@"adFrame.origin.y: %f",adFrame.origin.y);
    adView.frame        = adFrame;
    
    [adView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    
    [self.view addSubview:adView];
    adView.delegate         = self;
    adView.hidden           = YES;
    self->bannerIsVisible   = NO;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self->bannerIsVisible)
    {
        adView.hidden = NO;
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        [UIView commitAnimations];
        self->bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self->bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        [UIView commitAnimations];
        adView.hidden = YES;
        self->bannerIsVisible = NO;
    }
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    NSLog(@"Banner view is beginning an ad action");
    BOOL shouldExecuteAction = YES;
    if (!willLeave && shouldExecuteAction)
    {
        // stop all interactive processes in the app
        // [video pause];
        // [audio pause];
    }
    return shouldExecuteAction;
}

- (void)bannerViewActionDidFinish:(ADBannerView *)banner
{
    // resume everything you've stopped
    // [video resume];
    // [audio resume];
}



@end

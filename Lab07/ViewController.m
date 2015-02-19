//
//  ViewController.m
//  Lab07
//
//  Created by developer on 2/13/15.
//  Copyright (c) 2015 developer. All rights reserved.
//

#import "ViewController.h"
#import "variables.h"



@interface ViewController ()

@end

//Aqui los arreglos para la lista de ubicaciones agisnados a los extern en variables.h
NSMutableArray *maUbicacion;
NSMutableArray *maNombre;
NSMutableArray *maLatitud;
NSMutableArray *maLongitud;
NSMutableArray *maHorario;
NSMutableArray *maImagen;

NSString        *userID = @"1";

//Variable donde se asigna el json del host remoto
NSDictionary    *jsonResponse;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //inicia la localizacion gps
    self.locationManager                    = [[CLLocationManager alloc] init];
    self.locationManager.delegate           = self;
    self.location                           = [[CLLocation alloc] init];
    self.locationManager.desiredAccuracy    = kCLLocationAccuracyKilometer;
    [self.locationManager  requestWhenInUseAuthorization];
    [self.locationManager  requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
    //init iADS
    [self cfgiAdBanner];
    
    //Se obtienen los datos del host remoto en estas funciones
    [self postService];
    
    [self loadService];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnLista:(id)sender {
}

- (IBAction)btnMapa:(id)sender {
}


/**********************************************************************************************
 Google Analytics
 **********************************************************************************************/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"on ViewController screen";
}



/**********************************************************************************************
 Localization
 **********************************************************************************************/
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.location = locations.lastObject;
    //NSLog( @"didUpdateLocation!");
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:self.locationManager.location completionHandler:^(NSArray *placemarks, NSError *error)
     {
         for (CLPlacemark *placemark in placemarks)
         {
             //NSString *addressName = [placemark name];
             //NSString *city = [placemark locality];
             NSString *administrativeArea = [placemark administrativeArea];
             //NSString *country  = [placemark country];
             NSString *countryCode = [placemark ISOcountryCode];
             //NSLog(@"name is %@ and locality is %@ and administrative area is %@ and country is %@ and country code %@", addressName, city, administrativeArea, country, countryCode);
             strUserLocation = [[administrativeArea stringByAppendingString:@","] stringByAppendingString:countryCode];
             NSLog(@"gstrUserLocation = %@", strUserLocation);
         }
         mlatitude = self.locationManager.location.coordinate.latitude;
         //[mUserDefaults setObject: [[NSNumber numberWithFloat:mlatitude] stringValue] forKey: pmstrLatitude];
         mlongitude = self.locationManager.location.coordinate.longitude;
         //[mUserDefaults setObject: [[NSNumber numberWithFloat:mlatitude] stringValue] forKey: pmstrLatitude];
         //NSLog(@"mlatitude = %f", mlatitude);
         //NSLog(@"mlongitude = %f", mlongitude);
     }];
}

- (void) postService
{
    NSLog(@"postService");
    NSOperationQueue *queue = [NSOperationQueue new];
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(loadService) object:nil];
    [queue addOperation:operation];
}


- (void) loadService
{
    @try
    {
        NSString *post = [[NSString alloc] initWithFormat:@"id=%@", userID];
        //NSLog(@"postService: %@",post);
        //Host remoto con el script que devuelve el JSON
        NSURL *url = [NSURL URLWithString:@"http://www.s22.mx/administracion/json.php"];
        //NSLog(@"URL postService = %@", url);
        
        NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        [NSURLRequest requestWithURL:url];
        NSError *error = [[NSError alloc] init];
        NSHTTPURLResponse *response = nil;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        //-------------------------------------------------------------------------------
        // Aqui es la magia para comvertir de string a JSON a una variable de tipo NSDictionary para
        //manipular mas facil los datos de los campos
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            jsonResponse = [NSJSONSerialization JSONObjectWithData:urlData options:kNilOptions error:&error];
        }
        else
        {
            if (error)
            {
                NSLog(@"Error");
                
            }
            else
            {
                NSLog(@"Conect Fail");
            }
        }
        //-------------------------------------------------------------------------------
    }
    @catch (NSException * e)
    {
        NSLog(@"Exception");
    }
    //-------------------------------------------------------------------------------
    //Salida a consola del JSON obtenido
    NSLog(@"jsonResponse %@", jsonResponse);
    
    /* Con el json obtenido se asignan los valores en los NSMutableArray */
    maNombre    = [jsonResponse valueForKey:@"nombre"];
    maLatitud   = [jsonResponse valueForKey:@"latitud"];
    maLongitud  = [jsonResponse valueForKey:@"longitud"];
    maHorario   = [jsonResponse valueForKey:@"horario"];
    maImagen    = [jsonResponse valueForKey:@"imagen"];
    //maUbicacion       = [jsonResponse valueForKey:@"surname"];
    
    //NSLog(@"maNames %@", maNombre);
    //NSLog(@"maLatitud %@", maLatitud);
    //NSLog(@"maLongitud %@", maLongitud);
    //NSLog(@"maSurname %@", maSurname);
}


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

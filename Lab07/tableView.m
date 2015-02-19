//
//  tableView.m
//  Lab07
//
//  Created by developer on 2/13/15.
//  Copyright (c) 2015 developer. All rights reserved.
//

#import "tableView.h"
#import "variables.h"
#import "cellView.h"


@interface tableView ()


@end


NSMutableArray *maUbicacion;
NSMutableArray *maNombre;
NSMutableArray *maLatitud;
NSMutableArray *maLongitud;

NSString *strSelectedName;

@implementation tableView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //init iAds
    [self cfgiAdBanner];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**********************************************************************************************
 Google Analytics
 **********************************************************************************************/

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.screenName = @"on tableView screen";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 84;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return maNombre.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    //cellView *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
        //cell = [[cellView alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    NSLog(@"%@", [maNombre objectAtIndex:indexPath.row]);
    
    cell.textLabel.text = [maNombre objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [maHorario objectAtIndex:indexPath.row];
    //NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://upload.wikimedia.org/wikipedia/en/f/fc/UWH_userbox_image_test.png"]];
    
    /* 
     Aqui la magia para obtener la imagen desde URL - no se considera buena practica porque
     se obtiene de manera sincrona, debe hacerse de manera asincrona para o afectar la experiencia 
     del usuario.
     */
    NSData* imageData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[maImagen objectAtIndex:indexPath.row]]];
    UIImage* image = [[UIImage alloc] initWithData:imageData];
    [cell.imageView setImage:image]; // UIImageView
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    strSelectedName     = [NSString stringWithFormat:@"%@", maNombre[indexPath.row]];
    //strSelectedImg      = [NSString stringWithFormat:@"%@", maImages[indexPath.row]];
    
    NSLog(@"strSelectedName %@", strSelectedName);
    //NSLog(@"strSelectedImg %@", strSelectedImg);
    
    
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

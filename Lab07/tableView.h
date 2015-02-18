//
//  tableView.h
//  Lab07
//
//  Created by developer on 2/13/15.
//  Copyright (c) 2015 developer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>


@interface tableView : UIViewController <UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate>{
    ADBannerView *adView;
    BOOL bannerIsVisible;
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITableViewCell *TableViewCell;

@end

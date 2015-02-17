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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return maNombre.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    cellView *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[cellView alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    NSLog(@"%@", [maNombre objectAtIndex:indexPath.row]);
    cell.lblNombre.text = [maNombre objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    strSelectedName     = [NSString stringWithFormat:@"%@", maNombre[indexPath.row]];
    //strSelectedImg      = [NSString stringWithFormat:@"%@", maImages[indexPath.row]];
    
    NSLog(@"strSelectedName %@", strSelectedName);
    //NSLog(@"strSelectedImg %@", strSelectedImg);
    
    
}

@end

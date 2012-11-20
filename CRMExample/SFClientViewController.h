//
//  SFFirstViewController.h
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/3/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFClientViewController : UITableViewController
{
    UIAlertView *alertView;
}
@property (nonatomic,strong) UIAlertView *alertView;
- (void) clientDidLoad;
- (void) clientWillLoad;

@end

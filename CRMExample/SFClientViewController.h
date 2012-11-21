//
//  SFFirstViewController.h
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/3/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFLoadingRestObjects.h"

@interface SFClientViewController : UITableViewController <SFLoadingRestObjects>
{
    UIAlertView *alertView;
    NSArray *clients;
}
@property (nonatomic,strong) UIAlertView *alertView;
@property (nonatomic,strong) NSArray *clients;

@end

//
//  SFActionsViewController.h
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/5/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFLoadingRestObjects.h"

@class Client;

@interface SFActionsViewController : UITableViewController <SFLoadingRestObjects, UITextFieldDelegate>
{
    Client *client;
    NSArray *actions;
    UIAlertView *alertView;

}
@property (nonatomic,strong) Client *client;
@property (nonatomic,strong) NSArray *actions;
@property (nonatomic,strong) UIAlertView *alertView;
@property (nonatomic,strong) IBOutlet UITextField *phone;
@property (nonatomic,strong) IBOutlet UITextField *address;
@property (nonatomic,strong) IBOutlet UITextField *name;

- (IBAction)updateClient:(id)sender;
@end

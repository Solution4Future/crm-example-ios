//
//  SFActionsViewController.h
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/5/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Client;

@interface SFActionsViewController : UITableViewController
{
    Client *client;
}
@property (nonatomic,strong) Client *client;
@property (nonatomic,strong) IBOutlet UITextField *phone;
@property (nonatomic,strong) IBOutlet UITextField *address;
@property (nonatomic,strong) IBOutlet UITextField *name;
@end

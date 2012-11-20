//
//  SFFirstViewController.m
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/3/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import "SFClientViewController.h"



@implementation SFClientViewController
@synthesize alertView;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) clientDidLoad{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Downloading Clients" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
}
- (void) clientWillLoad{
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
}
@end

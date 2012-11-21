//
//  SFActionsViewController.m
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/5/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import "SFActionsViewController.h"
#import "SFAppDelegate.h"
#import "SFRestAPI.h"
#import "Action.h"
#import "Client.h"

@implementation SFActionsViewController
@synthesize name, address, phone, client, actions, alertView;

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
    SFAppDelegate *delegate = (SFAppDelegate *)[UIApplication sharedApplication].delegate;
    [[delegate api] getActions:[self.client.pk stringValue] withController:self];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.name setText:client.name];
    [self.phone setText:client.phone];
    [self.address setText:client.address];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[client actions] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ActionCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell.textLabel setText:[(Action *)[self.actions objectAtIndex:0] type]];
    return cell;
}

#pragma mark - Table view delegate

- (void) clientDidLoad{
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
    self.actions = [[self.client actions] allObjects];
    [self.tableView reloadData];
    
}
- (void) clientWillLoad{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Downloading Clients" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [self.alertView show];
}
- (IBAction)updateClient:(id)sender{
    NSLog([[self.client pk] stringValue]);
    SFAppDelegate *delegate = (SFAppDelegate *)[UIApplication sharedApplication].delegate;
    [self.client setName:self.name.text];
    [self.client setPhone:self.phone.text];
    [self.client setAddress:self.address.text];
    [[delegate api] updateClient:self.client];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
@end

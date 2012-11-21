//
//  SFFirstViewController.m
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/3/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import "SFClientViewController.h"
#import "SFAppDelegate.h"
#import "SFActionsViewController.h"
#import "Client.h"
#import "SFRestAPI.h"


@implementation SFClientViewController
@synthesize alertView, clients;

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
    [[delegate api] startSynchronization:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSError *error;
    return [Client count:&error];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ClientCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    [cell.textLabel setText:[[self.clients objectAtIndex:[indexPath row]] name]];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    SFActionsViewController *controller = (SFActionsViewController *)segue.destinationViewController;
    UITableViewCell* cell = (UITableViewCell *)sender;
    [controller setClient:[self.clients objectAtIndex:[[self.tableView indexPathForCell:cell] row]]];

}
- (void) clientDidLoad{
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
    self.clients = [Client findAll];
    [self.tableView reloadData];

}
- (void) clientWillLoad{
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Downloading Clients" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
    [self.alertView show];
}
@end

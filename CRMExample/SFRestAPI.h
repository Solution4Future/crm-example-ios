//
//  SFRestAPI.h
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/20/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "SFClientViewController.h"
@class Action, Client;

@interface SFRestAPI : NSObject <RKObjectLoaderDelegate>
{
    UIViewController<SFLoadingRestObjects> *controller;
}
@property (nonatomic,strong) UIViewController<SFLoadingRestObjects> *controller;

- (void) configureDatabase;

- (void) configureMappings;

- (void) configureRoutes;

- (void) configurePosting;

- (void) postClient:(Client *) object;

- (void) postAction:(Action * ) object;

- (void) deleteClient:(Client *) object;

- (void) deleteAction:(Action *) object;

- (void) updateClient:(Client *) object;

- (void) updateAction:(Action *) object;

- (void) startSynchronization:(UIViewController<SFLoadingRestObjects> *)destinationController;

- (void) startSynchronizationInBackground;

- (void) getActions:(NSString *) clientId withController:(UIViewController<SFLoadingRestObjects> *)destinationController;
@end

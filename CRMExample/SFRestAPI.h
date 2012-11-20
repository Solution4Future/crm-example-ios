//
//  SFRestAPI.h
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/20/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Action, Client;

@interface SFRestAPI : NSObject
- (void) configureMappings;

- (void) configurePosting;

- (void) configureRoutes;

- (void) postClient:(Client *) object;

- (void) postAction:(Action * ) object;

- (void) deleteClient:(Client *) object;

- (void) deleteAction:(Action *) object;
@end

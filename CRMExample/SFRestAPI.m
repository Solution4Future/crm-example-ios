//
//  SFRestAPI.m
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/20/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import "SFRestAPI.h"
#import "Client.h"
#import "Action.h"
#import <RestKit/RestKit.h>

@implementation SFRestAPI

- (RKObjectManager *) getObjectManager{
    return [ RKObjectManager sharedManager];
}

- (void) configureDatabase{
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURLString:@"http://example-crm.herokuapp.com"];
    RKManagedObjectStore* objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"CRM.sqlite" ];
    objectManager.objectStore = objectStore;
}

- (void) configureMappings{
    RKObjectManager* objectManager = [self getObjectManager];
    // Configure Comments on the Article. Send POST of Comment objects to '/articles/1234/comments'
    // where the Comment has a relationship to an Article.

    
    RKManagedObjectMapping* clientMapping = [RKManagedObjectMapping mappingForClass:[Client class] inManagedObjectStore:objectManager.objectStore ];
    [clientMapping mapKeyPath:@"id" toAttribute:@"pk"];
    [clientMapping mapKeyPath:@"phone" toAttribute:@"phone"];
    [clientMapping mapKeyPath:@"address" toAttribute:@"address"];
    [clientMapping mapKeyPath:@"description" toAttribute:@"description"];
    clientMapping.primaryKeyAttribute = @"id";
    
    RKManagedObjectMapping* actionsMapping = [RKManagedObjectMapping mappingForClass:[Action class] inManagedObjectStore:objectManager.objectStore ];
    [actionsMapping mapKeyPath:@"id" toAttribute:@"pk"];
    [actionsMapping mapKeyPath:@"phone" toAttribute:@"phone"];
    [actionsMapping mapKeyPath:@"address" toAttribute:@"address"];
    [actionsMapping mapKeyPath:@"description" toAttribute:@"description"];
    actionsMapping.primaryKeyAttribute = @"id";
    
    [actionsMapping mapKeyPath:@"clientId" toRelationship:@"client" withMapping:clientMapping];
    [clientMapping mapRelationship:@"actions" withMapping:actionsMapping];
    
    [objectManager.mappingProvider setMapping:actionsMapping forKeyPath:@"clients"];
    [objectManager.mappingProvider setMapping:clientMapping forKeyPath:@"actions"];
    
}

- (void) configurePosting{
    
}

- (void) configureRoutes{
    RKObjectRouter *router = objectManager.router;

    [router routeClass:[Client class] toResourcePath:@"/clients" forMethod:RKRequestMethodPOST];
    [router routeClass:[Client class] toResourcePath:@"/clients/:id"];
    [router routeClass:[Action class] toResourcePath:@"/clients/:client.id/actions" forMethod:RKRequestMethodPOST];
    [router routeClass:[Action class] toResourcePath:@"/clients/:client.id/actions/:id"];
}

- (void) postClient:(Client *) object{
    
}

- (void) postAction:(Action * ) object{
    
}

- (void) deleteClient:(Client *) object{
    
}

- (void) deleteAction:(Action *) object{
    
}

@end

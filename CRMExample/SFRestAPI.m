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
#import "SFClientViewController.h"
#import "SFAppDelegate.h"
#import <RestKit/RestKit.h>

@implementation SFRestAPI
@synthesize controller;
- (RKObjectManager *) getObjectManager{
    return [RKObjectManager sharedManager];
}

- (void) configureDatabase{
    RKObjectManager* objectManager = [RKObjectManager managerWithBaseURLString:@"http://example-crm.herokuapp.com"];
    RKManagedObjectStore* objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"CRM.sqlite" ];
    objectManager.objectStore = objectStore;

    SFAppDelegate *delegate = (SFAppDelegate *)[UIApplication sharedApplication].delegate;
    NSURL *storeUrl = [NSURL fileURLWithPath: [[delegate applicationDocumentsDirectory] stringByAppendingPathComponent: @"CRM.sqlite"]];
    
    // handle db upgrade
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    NSError *error = nil;
    NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: objectManager.objectStore.managedObjectModel];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:options error:&error]) {
        // Handle error
        NSLog(@"Error migration");
    }
    else{
        NSLog(@"Migration Succes!");

    }
}

- (void) configureMappings{
    RKObjectManager* objectManager = [self getObjectManager];
    // Configure Comments on the Article. Send POST of Comment objects to '/articles/1234/comments'
    // where the Comment has a relationship to an Article.

    
    RKManagedObjectMapping* clientMapping = [RKManagedObjectMapping mappingForClass:[Client class] inManagedObjectStore:objectManager.objectStore ];
    [clientMapping mapKeyPath:@"id" toAttribute:@"pk"];
    [clientMapping mapKeyPath:@"phone" toAttribute:@"phone"];
    [clientMapping mapKeyPath:@"address" toAttribute:@"address"];
    [clientMapping mapKeyPath:@"name" toAttribute:@"name"];
    clientMapping.primaryKeyAttribute = @"pk";
    
    RKManagedObjectMapping* actionsMapping = [RKManagedObjectMapping mappingForClass:[Action class] inManagedObjectStore:objectManager.objectStore ];
    [actionsMapping mapKeyPath:@"id" toAttribute:@"pk"];
    [actionsMapping mapKeyPath:@"type" toAttribute:@"type"];
    [actionsMapping mapKeyPath:@"description" toAttribute:@"descriptionText"];
    actionsMapping.primaryKeyAttribute = @"pk";
    
    [actionsMapping mapKeyPath:@"clientId" toRelationship:@"client" withMapping:clientMapping];
    [clientMapping mapRelationship:@"actions" withMapping:actionsMapping];
    
    [objectManager.mappingProvider setMapping:clientMapping forKeyPath:@"clients"];
    [objectManager.mappingProvider setMapping:actionsMapping forKeyPath:@"actions"];


}

- (void) configurePosting{
    RKObjectMapping* clientMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class] ];
    [clientMapping mapKeyPath:@"phone" toAttribute:@"phone"];
    [clientMapping mapKeyPath:@"address" toAttribute:@"address"];
    [clientMapping mapKeyPath:@"description" toAttribute:@"description"];
    RKObjectMapping* actionsMapping = [RKObjectMapping mappingForClass:[NSMutableDictionary class] ];
    [actionsMapping mapKeyPath:@"type" toAttribute:@"type"];
    [actionsMapping mapKeyPath:@"descriptionText" toAttribute:@"description"];
    
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:clientMapping forClass:[Client class]];
    [[RKObjectManager sharedManager].mappingProvider setSerializationMapping:actionsMapping forClass:[Action class]];
}
- (void) configureRoutes{
    RKObjectRouter *router = [self getObjectManager].router;

    [router routeClass:[Client class] toResourcePath:@"/clients" forMethod:RKRequestMethodPOST];
    [router routeClass:[Client class] toResourcePath:@"/clients/:pk"];
    [router routeClass:[Action class] toResourcePath:@"/clients/:client.pk/actions" forMethod:RKRequestMethodPOST];
    [router routeClass:[Action class] toResourcePath:@"/clients/:client.pk/actions/:pk"];
}


- (void) startSynchronization:(UIViewController<SFLoadingRestObjects> *)destinationController{
    self.controller = destinationController;
    [self.controller clientWillLoad];
    [[self getObjectManager] loadObjectsAtResourcePath:@"/clients/" delegate:self];
}
- (void) startSynchronizationInBackground{
    [[self getObjectManager] loadObjectsAtResourcePath:@"/clients/" delegate:self];
}
- (void) getActions:(NSString *) clientId withController:(UIViewController<SFLoadingRestObjects> *)destinationController{
    self.controller = destinationController;
    [self.controller clientWillLoad];
    [[self getObjectManager] loadObjectsAtResourcePath:[[NSString alloc] initWithFormat:@"/clients/%@/actions/", clientId, nil ] delegate:self];
}
- (void) postClient:(Client *) object{
    [[self getObjectManager] postObject:object delegate:self];
}

- (void) postAction:(Action * ) object{
    [[self getObjectManager] postObject:object delegate:self];
}

- (void) deleteClient:(Client *) object{
    [[self getObjectManager] deleteObject:object delegate:self];
}

- (void) deleteAction:(Action *) object{
    [[self getObjectManager] deleteObject:object delegate:self];
}

- (void) updateClient:(Client *) object{
    [[self getObjectManager] putObject:object delegate:self];
}

- (void) updateAction:(Action *) object{
    [[self getObjectManager] putObject:object delegate:self];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error{
    NSLog(@"Error in mapping");
    NSLog([error localizedDescription]);
    NSLog([error localizedFailureReason]);
    [self.controller clientDidLoad];

}
- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)objects{
    NSLog(@"Mapping is ended");
    [self.controller clientDidLoad];

}
@end

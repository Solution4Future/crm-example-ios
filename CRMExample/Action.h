//
//  Action.h
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/21/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/CoreData.h>

@class Client;

@interface Action : NSManagedObject

@property (nonatomic, retain) NSNumber * pk;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * descriptionText;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) Client *client;

@end

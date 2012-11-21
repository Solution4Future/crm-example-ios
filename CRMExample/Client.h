//
//  Client.h
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/21/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/CoreData.h>


@interface Client : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * pk;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * phone;
@property (nonatomic, retain) NSSet *actions;

@end

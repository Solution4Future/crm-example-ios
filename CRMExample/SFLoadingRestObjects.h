//
//  SFLoadingRestObjects.h
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/21/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SFLoadingRestObjects <NSObject>

@required
- (void) clientDidLoad;
- (void) clientWillLoad;

@end

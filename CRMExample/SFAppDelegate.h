//
//  SFAppDelegate.h
//  CRMExample
//
//  Created by Kamil Gałuszka on 11/3/12.
//  Copyright (c) 2012 Kamil Gałuszka. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>


@interface SFAppDelegate : UIResponder <UIApplicationDelegate, RKObjectLoaderDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

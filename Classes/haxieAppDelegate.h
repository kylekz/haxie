//
//  haxieAppDelegate.h
//  haxie
//
//  Created by Kaikz on 7/01/11.
//  Copyright 2011 Pedanic-dev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface haxieAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@end

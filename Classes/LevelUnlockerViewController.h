//
//  LevelUnlockerViewController.h
//  haxie
//
//  Created by Kaikz on 7/01/11.
//  Copyright 2011 Pedanic-dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSTask.h"
#import "MBProgressHUD.h"

@interface LevelUnlockerViewController : UIViewController <MBProgressHUDDelegate, UIActionSheetDelegate> {
	NSTask *task;
	NSTask *stask;
	MBProgressHUD *HUD;
	IBOutlet UINavigationBar *navbar;
}

@property (nonatomic,retain) UINavigationBar *navbar;


-(IBAction) run;
-(IBAction) supported;
-(IBAction) info;

@end

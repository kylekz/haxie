//
//  LevelUnlockerViewController.h
//  haxie
//
//  Created by Kaikz on 7/01/11.
//  Copyright Kaikz 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSTask.h"
#import "MBProgressHUD.h"

@interface LevelUnlockerViewController : UIViewController <MBProgressHUDDelegate, UIActionSheetDelegate, UIAlertViewDelegate> {
	NSTask *task;
	NSTask *stask;
	MBProgressHUD *HUD;
}



-(IBAction) run;
-(IBAction) supported;

@end
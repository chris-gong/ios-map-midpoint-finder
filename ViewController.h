//
//  ViewController.h
//  MapAppDraft
//
//  Created by Xu Wu on 2/28/15.
//  Copyright (c) 2015 Chris Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "MeetUp.h"

@interface ViewController : UIViewController
- (IBAction)openSettings:(id)sender;
- (IBAction)openAbout:(id)sender;
- (IBAction)openMore:(id)sender;
- (IBAction)openMeetup:(id)sender;
- (IBAction)openLongtrips:(id)sender;
- (IBAction)openMorethemerrier:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *meetUp;
@property (weak, nonatomic) IBOutlet UIButton *longTrips;
@property (weak, nonatomic) IBOutlet UIButton *moreTheMerrier;
@property (weak, nonatomic) IBOutlet UIButton *settings;
@property (weak, nonatomic) IBOutlet UIButton *about;
@property (weak, nonatomic) IBOutlet UIButton *more;



@end


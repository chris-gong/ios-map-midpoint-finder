//
//  ViewController.m
//  MapAppDraft
//
//  Created by Xu Wu on 2/28/15.
//  Copyright (c) 2015 Chris Gong. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "MeetUp.h"

@interface ViewController ()



@end

@implementation ViewController
@synthesize meetUp, longTrips, moreTheMerrier, settings, about, more;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //adds shadow to button
    self.meetUp.layer.cornerRadius = 8.0f;
    self.meetUp.layer.masksToBounds = NO;
    
    self.meetUp.layer.shadowColor = [UIColor blackColor].CGColor;
    self.meetUp.layer.shadowOpacity = 0.4;
    self.meetUp.layer.shadowRadius = 3;
    self.meetUp.layer.shadowOffset = CGSizeMake(6.0f,6.0f);
    
    //adds shadow to button
    self.longTrips.layer.cornerRadius = 8.0f;
    self.longTrips.layer.masksToBounds = NO;
    
    self.longTrips.layer.shadowColor = [UIColor blackColor].CGColor;
    self.longTrips.layer.shadowOpacity = 0.4;
    self.longTrips.layer.shadowRadius = 3;
    self.longTrips.layer.shadowOffset = CGSizeMake(6.0f,6.0f);
    
    //adds shadow to button
    self.moreTheMerrier.layer.cornerRadius = 8.0f;
    self.moreTheMerrier.layer.masksToBounds = NO;
    
    self.moreTheMerrier.layer.shadowColor = [UIColor blackColor].CGColor;
    self.moreTheMerrier.layer.shadowOpacity = 0.4;
    self.moreTheMerrier.layer.shadowRadius = 3;
    self.moreTheMerrier.layer.shadowOffset = CGSizeMake(6.0f,6.0f);
    
    //adds shadow to button
    
    
    self.settings.layer.masksToBounds = NO;
    self.settings.layer.shadowColor = [UIColor blackColor].CGColor;
    self.settings.layer.shadowOpacity = 0.4;
    self.settings.layer.shadowRadius = 3;
    self.settings.layer.shadowOffset = CGSizeMake(6.0f,6.0f);
    
    //adds shadow to button
    
    
    self.about.layer.masksToBounds = NO;
    self.about.layer.shadowColor = [UIColor blackColor].CGColor;
    self.about.layer.shadowOpacity = 0.4;
    self.about.layer.shadowRadius = 3;
    self.about.layer.shadowOffset = CGSizeMake(6.0f,6.0f);
    
    //adds shadow to button
    
    
    self.more.layer.masksToBounds = NO;
    self.more.layer.shadowColor = [UIColor blackColor].CGColor;
    self.more.layer.shadowOpacity = 0.4;
    self.more.layer.shadowRadius = 3;
    self.more.layer.shadowOffset = CGSizeMake(6.0f,6.0f);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//passing data between view controllers, setting booleans in MeetUp class to default values
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"meetUpSegue"]){
    MeetUp *meetUpvc = [segue destinationViewController];
    meetUpvc.addressOneValid = NO;
    meetUpvc.addressTwoValid = NO;
    }
}





- (IBAction)openSettings:(id)sender {
}

- (IBAction)openAbout:(id)sender {
}

- (IBAction)openMore:(id)sender {
}

- (IBAction)openMeetup:(id)sender {
}

- (IBAction)openLongtrips:(id)sender {
}

- (IBAction)openMorethemerrier:(id)sender {
}



@end

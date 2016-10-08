//
//  Person2.h
//  MapAppDraft
//
//  Created by Xu Wu on 3/8/15.
//  Copyright (c) 2015 Chris Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetUp.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

@interface Person2 : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *person2TextField;
@property (strong,nonatomic) NSString *addressTwo;
@property (strong,nonatomic) NSString *addressOne;
@property(nonatomic, assign) BOOL saveAddressOneValid;
@property(nonatomic, assign) BOOL saveAddressTwoValid;
@property CLLocationCoordinate2D addressOneCoords;
@property CLLocationCoordinate2D addressTwoCoords;
@end

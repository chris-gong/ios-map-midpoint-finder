//
//  Radius.m
//  MapAppDraft
//
//  Created by Xu Wu on 3/8/15.
//  Copyright (c) 2015 Chris Gong. All rights reserved.
//

#import "Radius.h"
#import "MeetUp.h"
#import "MeetUpMap.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
@interface Radius ()

@end

@implementation Radius

@synthesize addressTwo, addressOne, person2TextField, saveAddressOneValid, saveAddressTwoValid, addressOneCoords, addressTwoCoords,saveRadius;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"radius.png"]]];
}

-(void) viewWillAppear:(BOOL)animated{
    
    
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//transferring data between view controllers
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id) sender{
    MeetUp * meetUpvc = [segue destinationViewController];
    MeetUpMap *meetUpMapvc = [segue destinationViewController];
    if([segue.identifier isEqualToString:@"radiusToMeetUp"]){
        meetUpvc.saveAddressOne = addressOne;
        meetUpvc.saveAddressTwo = addressTwo;
        meetUpvc.saveAddressOneCoords = addressOneCoords;
        meetUpvc.saveAddressTwoCoords = addressTwoCoords;
        meetUpvc.addressOneValid = saveAddressOneValid;
        meetUpvc.addressTwoValid = saveAddressTwoValid;
        
    }
    if([segue.identifier isEqualToString:@"fiveMilesSegue"]){
        meetUpMapvc.addressOne = addressOne;
        meetUpMapvc.addressTwo = addressTwo;
        meetUpMapvc.addressOneCoords = addressOneCoords;
        meetUpMapvc.addressTwoCoords = addressTwoCoords;
        meetUpMapvc.saveAddressOneValid = saveAddressOneValid;
        meetUpMapvc.saveAddressTwoValid = saveAddressTwoValid;
        meetUpMapvc.radius = 1609.344f * 5.0f;
        
    }
    if([segue.identifier isEqualToString:@"tenMilesSegue"]){
        meetUpMapvc.addressOne = addressOne;
        meetUpMapvc.addressTwo = addressTwo;
        meetUpMapvc.addressOneCoords = addressOneCoords;
        meetUpMapvc.addressTwoCoords = addressTwoCoords;
        meetUpMapvc.saveAddressOneValid = saveAddressOneValid;
        meetUpMapvc.saveAddressTwoValid = saveAddressTwoValid;
        meetUpMapvc.radius = 1609.344f * 10.0f;
        
    }
    if([segue.identifier isEqualToString:@"fifteenMilesSegue"]){
        meetUpMapvc.addressOne = addressOne;
        meetUpMapvc.addressTwo = addressTwo;
        meetUpMapvc.addressOneCoords = addressOneCoords;
        meetUpMapvc.addressTwoCoords = addressTwoCoords;
        meetUpMapvc.saveAddressOneValid = saveAddressOneValid;
        meetUpMapvc.saveAddressTwoValid = saveAddressTwoValid;
        meetUpMapvc.radius = 1609.344f * 15.0f;
        
    }
    if([segue.identifier isEqualToString:@"twentyMilesSegue"]){
        meetUpMapvc.addressOne = addressOne;
        meetUpMapvc.addressTwo = addressTwo;
        meetUpMapvc.addressOneCoords = addressOneCoords;
        meetUpMapvc.addressTwoCoords = addressTwoCoords;
        meetUpMapvc.saveAddressOneValid = saveAddressOneValid;
        meetUpMapvc.saveAddressTwoValid = saveAddressTwoValid;
        meetUpMapvc.radius = 1609.344f * 20.0f;
        
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  Person2.m
//  MapAppDraft
//
//  Created by Xu Wu on 3/8/15.
//  Copyright (c) 2015 Chris Gong. All rights reserved.
//

#import "Person2.h"
#import "MeetUp.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>


@interface Person2 ()

@end

@implementation Person2
@synthesize addressTwo, addressOne, person2TextField, saveAddressOneValid, saveAddressTwoValid, addressOneCoords, addressTwoCoords;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"person2.png"]]];
    self.person2TextField.delegate = self;
    [person2TextField setText:addressTwo];
    addressTwo = person2TextField.text;
    [person2TextField resignFirstResponder];
}


-(void)viewDidUnload{
    
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//dismisses keyboard when user clicks on background
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch =[[event allTouches]anyObject];
    if(![[touch view]isKindOfClass:[UITextField class]]){
        [self.view endEditing:YES];
    }
    [super touchesBegan:touches withEvent:event];
}
//keyboard appears when user clicks on textfield
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}
//keyboard dismisses when user presses return key
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//transferring data between view controllers
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id) sender{
    addressTwo = person2TextField.text;
    MeetUp * meetUpvc = [segue destinationViewController];
    meetUpvc.saveAddressOne = addressOne;
    meetUpvc.saveAddressTwo = person2TextField.text;
    
    
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:addressTwo completionHandler:^(NSArray *placemarks, NSError *error){
        //executes code if address input is invalid
        if(error){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Address" message:@"You must enter a valid address" delegate:nil cancelButtonTitle:@"Ok"otherButtonTitles:nil];
            [alert show];
            saveAddressTwoValid = NO;
            meetUpvc.addressOneValid = saveAddressOneValid;
            meetUpvc.addressTwoValid = saveAddressTwoValid;
            meetUpvc.saveAddressOneCoords = addressOneCoords;
            meetUpvc.saveAddressTwoCoords = addressTwoCoords;
            meetUpvc.radius.enabled = saveAddressOneValid;
            [meetUpvc.radius setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            
            
            
        }
        //executes code if address input is valid
        if(placemarks && placemarks.count>0){
            CLPlacemark *placemark = placemarks[0];
            CLLocation *location = placemark.location;
            addressTwoCoords = location.coordinate;
            saveAddressTwoValid = YES;
            meetUpvc.addressOneValid = saveAddressOneValid;
            meetUpvc.addressTwoValid = saveAddressTwoValid;
            meetUpvc.saveAddressOneCoords = addressOneCoords;
            meetUpvc.saveAddressTwoCoords = addressTwoCoords;
            if(saveAddressOneValid ==YES && saveAddressTwoValid == YES){
                meetUpvc.radius.enabled = YES;
                [meetUpvc.radius setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }
        }
        
        
    }];
    
    
    
    
    
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

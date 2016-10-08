//
//  Person1.m
//  MapAppDraft
//
//  Created by Xu Wu on 3/8/15.
//  Copyright (c) 2015 Chris Gong. All rights reserved.
//

#import "Person1.h"
#import "Meetup.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>

@interface Person1 ()

@end

@implementation Person1
@synthesize addressOne, addressTwo, person1TextField, addressOneCoords, addressTwoCoords, saveAddressTwoValid, saveAddressOneValid;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"person1.png"]]];
    person1TextField.delegate = self;
    [person1TextField setText:addressOne];
    addressOne = person1TextField.text;
    
    [person1TextField resignFirstResponder];
    
    
    
}

-(void)viewDidUnload{
    
    
}
-(void) viewWillAppear:(BOOL)animated{
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//keyboard dismisses when user touches background
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

//keyboard dismisses when user presses return key on keyboard
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//transferring data between view controllers
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    addressOne = person1TextField.text;
    
    MeetUp *meetUpvc = [segue destinationViewController];
    
    meetUpvc.saveAddressOne = person1TextField.text;
    meetUpvc.saveAddressTwo = addressTwo;
    

    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    [geocoder geocodeAddressString:addressOne completionHandler:^(NSArray *placemarks, NSError *error){
        //executes code if address input is not valid
        if(error){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Address" message:@"You must enter a valid address" delegate:nil cancelButtonTitle:@"Ok"otherButtonTitles:nil];
            [alert show];
            saveAddressOneValid = NO;
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
            addressOneCoords = location.coordinate;
            saveAddressOneValid = YES;
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

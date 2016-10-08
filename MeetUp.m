//
//  MeetUp.m
//  MapAppDraft
//
//  Created by Xu Wu on 3/3/15.
//  Copyright (c) 2015 Chris Gong. All rights reserved.
//

#import "MeetUp.h"
#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>
#import "Person1.h"
#import "Person2.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "Radius.h"
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
@interface MeetUp ()

@end


@implementation MeetUp
@synthesize mapView, saveAddressOne, saveAddressTwo, addressOneValid, addressTwoValid, saveAddressOneCoords, saveAddressTwoCoords,radius;






- (void)viewDidLoad {
    
    [super viewDidLoad];
    //creates mapView
    
    mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    [self.mapView setDelegate: self];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        //asks user for permission to access their location
        [self.locationManager requestWhenInUseAuthorization];
        
    }
    

    [self.locationManager startUpdatingLocation];
    //zooms to user's location on map
    [mapView setShowsUserLocation:YES];
    mapView.showsUserLocation =YES;
    
    //creating buttons
    UIButton *person1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *person2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    radius = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *buttonImage = [UIImage imageNamed:@"button.png"];
    UIImage *arrowImage = [UIImage imageNamed:@"arrow.png"];
    
    [person1 setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [person2 setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [radius setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [back setBackgroundImage:arrowImage forState:UIControlStateNormal];
    
    [person1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [person2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [radius setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //CGRectMake(x-cord,y-cord, width, height)
    person1.frame = CGRectMake(225,30,80,40);
    person2.frame = CGRectMake(225,110,80,40);
    radius.frame = CGRectMake(225, 190,80,40);
    back.frame = CGRectMake(10, 30,60,40);
    
    [person1 setTitle:@"Person 1" forState:UIControlStateNormal];
    [person2 setTitle:@"Person 2" forState:UIControlStateNormal];
    [radius setTitle:@"Radius" forState:UIControlStateNormal];
    
    
    person1.titleLabel.font = [UIFont fontWithName:@"Monoglyceride" size:16];
    person2.titleLabel.font = [UIFont fontWithName:@"Monoglyceride" size:16];
    radius.titleLabel.font = [UIFont fontWithName:@"Monoglyceride" size:16];
    
    //assigning actiosn to buttons
    [person1 addTarget:self action:@selector(myAction:) forControlEvents: UIControlEventTouchUpInside];
    [person2 addTarget:self action:@selector(myAction2:) forControlEvents: UIControlEventTouchUpInside];
    [radius addTarget:self action:@selector(myAction3:) forControlEvents: UIControlEventTouchUpInside];
    [back addTarget:self action:@selector(myAction4) forControlEvents: UIControlEventTouchUpInside];
  
    
    mapView.mapType = MKMapTypeStandard;
    
    
    
    self.view = mapView;
    
    

    //adding buttons to mapView
    [mapView addSubview: person1];
    [mapView addSubview: person2];
    [mapView addSubview: radius];
    [mapView addSubview: back];
    
    
    
    
    
    
    
    //if at least one address input is invalid, then user cannot continue to radius page
    if(addressOneValid == NO || addressTwoValid == NO){
        radius.enabled = NO;
        [radius setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}


-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}

//Goes to Person1 page
-(void)myAction:(id)sender{
    [self performSegueWithIdentifier:@"person1Segue" sender:(id)sender];
    
}
//Goes to Person2 Page
-(void)myAction2:(id)sender{
    [self performSegueWithIdentifier:@"person2Segue" sender:(id)sender];
    
}
//Goes to Radius Page
-(void)myAction3:(id)sender{
    [self performSegueWithIdentifier:@"radiusSegue" sender:(id)sender];
    
}
//Goes back to main page
-(void)myAction4{
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"FirstPage"];
    [self presentViewController:vc animated:YES completion:nil];
    
    
}
#pragma mark - MKMapViewDelegate Methods
//properly zooms into userlocation
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate,MKCoordinateSpanMake(0.1f,0.1f))animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//transferring data between view controllers
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    Person1 *person1vc = [segue destinationViewController];
    Person2 *person2vc = [segue destinationViewController];
    Radius *radiusvc = [segue destinationViewController];
    if([segue.identifier isEqualToString:@"person1Segue"]){
        
        person1vc.addressOne = saveAddressOne;
        person1vc.addressTwo = saveAddressTwo;
        person1vc.saveAddressOneValid = addressOneValid;
        person1vc.addressOneCoords = saveAddressOneCoords;
        person1vc.saveAddressTwoValid = addressTwoValid;
        person1vc.addressTwoCoords = saveAddressTwoCoords;
        
    }
    if([segue.identifier isEqualToString:@"person2Segue"]){
        person2vc.addressOne = saveAddressOne;
        person2vc.addressTwo = saveAddressTwo;
        person2vc.saveAddressOneValid = addressOneValid;
        person2vc.addressOneCoords = saveAddressOneCoords;
        person2vc.saveAddressTwoValid = addressTwoValid;
        person2vc.addressTwoCoords = saveAddressTwoCoords;
        
    }
    if([segue.identifier isEqualToString:@"radiusSegue"]){
        radiusvc.addressOne = saveAddressOne;
        radiusvc.addressTwo = saveAddressTwo;
        radiusvc.saveAddressOneValid = addressOneValid;
        radiusvc.addressOneCoords = saveAddressOneCoords;
        radiusvc.saveAddressTwoValid = addressTwoValid;
        radiusvc.addressTwoCoords = saveAddressTwoCoords;
        
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

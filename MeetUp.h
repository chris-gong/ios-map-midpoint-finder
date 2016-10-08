//
//  MeetUp.h
//  MapAppDraft
//
//  Created by Xu Wu on 3/3/15.
//  Copyright (c) 2015 Chris Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <MapKit/MapKit.h>
#import "Person1.h"
#import "Person2.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "Radius.h"
@interface MeetUp : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{
    
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) CLLocationManager *locationManager;

@property(strong,nonatomic) NSString *saveAddressOne;
@property(strong,nonatomic) NSString *saveAddressTwo;

@property(nonatomic, assign) BOOL addressOneValid;
@property(nonatomic, assign) BOOL addressTwoValid;


@property CLLocationCoordinate2D saveAddressOneCoords;
@property CLLocationCoordinate2D saveAddressTwoCoords;

@property (strong,nonatomic) IBOutlet UIButton *radius;


@end

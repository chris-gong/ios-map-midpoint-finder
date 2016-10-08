//
//  MeetUpMap.h
//  MapAppDraft
//
//  Created by Xu Wu on 3/14/15.
//  Copyright (c) 2015 Chris Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Radius.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "MapOverlayRenderer.h"
#import "CustomAnnotation.h"
@interface MeetUpMap : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>{
    
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) MKPolyline *routeLine;



@property (strong, nonatomic) IBOutlet UITextField *person2TextField;
@property (strong,nonatomic) NSString *addressTwo;
@property (strong,nonatomic) NSString *addressOne;
@property(nonatomic, assign) BOOL saveAddressOneValid;
@property(nonatomic, assign) BOOL saveAddressTwoValid;
@property CLLocationCoordinate2D addressOneCoords;
@property CLLocationCoordinate2D addressTwoCoords;
@property CLLocationCoordinate2D midCoords;
@property (nonatomic) float radius;

@property MKCoordinateRegion midRegion;
- (IBAction)findFood:(id)sender;
- (IBAction)findMovies:(id)sender;
- (IBAction)findMuseums:(id)sender;
- (IBAction)findBars:(id)sender;

@end

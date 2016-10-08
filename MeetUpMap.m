//
//  MeetUpMap.m
//  MapAppDraft
//
//  Created by Xu Wu on 3/14/15.
//  Copyright (c) 2015 Chris Gong. All rights reserved.
//

#import "MeetUpMap.h"
#import <MapKit/MapKit.h>
#import "Radius.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>


@interface MeetUpMap ()

@end

@implementation MeetUpMap

@synthesize mapView, addressTwo, addressOne, person2TextField, saveAddressOneValid, saveAddressTwoValid, addressOneCoords, addressTwoCoords,radius, routeLine, midCoords, midRegion;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //generates map view
    mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 75, 320, 493)];
    //setting delegate to self is not fixing the error
    mapView.delegate = self;
    UIButton *back = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    UIImage *arrowImage = [UIImage imageNamed:@"arrow.png"];
    [back setBackgroundImage:arrowImage forState:UIControlStateNormal];
    back.frame = CGRectMake(5, 80,50,35);
    //random button that switches between view controllers
    [back addTarget:self action:@selector(myAction:) forControlEvents: UIControlEventTouchUpInside];
    
    mapView.mapType = MKMapTypeStandard;
    [self.view addSubview: mapView];
    [self.view addSubview: back];
    
    
    //converting CLLocationCoordinate2D to MKPlacemark
    MKPlacemark *startPlacemark = [[MKPlacemark alloc]initWithCoordinate: addressOneCoords addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:nil]];
    MKPlacemark *endPlacemark = [[MKPlacemark alloc]initWithCoordinate: addressTwoCoords addressDictionary:[NSDictionary dictionaryWithObjectsAndKeys:nil]];
    
    //converting MKPlacemark to MKMapItem
    MKMapItem *start = [[MKMapItem alloc ]initWithPlacemark:startPlacemark];
    
    MKMapItem *end = [[MKMapItem alloc]initWithPlacemark:endPlacemark];
    
    
    MKDirectionsRequest *request = [MKDirectionsRequest new];
    [request setSource:start];
    [request setDestination:end];
    [request setTransportType:MKDirectionsTransportTypeAutomobile];
    request.requestsAlternateRoutes = YES;
    

    
    MKDirections *directions = [[MKDirections alloc]initWithRequest:request];
    
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error){
        //if the route can't be created
        if(error){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Unable to create route" message:@"Go back to check if addresses are valid" delegate:nil cancelButtonTitle:@"Ok"otherButtonTitles:nil];
            [alert show];
        }
        
        else{
           //removes any polylines already on the map
            [mapView removeOverlays:self.mapView.overlays];
            
            
            
            //Creating and adding an overlay that covers the entire mapView
            CLLocationCoordinate2D worldPoints[6] = { {90,0},{90,180},{-90,180},{-90,0},{-90,-180},{90,-180}};
            MKPolygon *worldSquare = [MKPolygon polygonWithCoordinates:worldPoints count:6];
            
            [mapView addOverlay:worldSquare];
            
            
            
            //Acquiring the first element in the routes array
            MKRoute *mainRoute = [response.routes firstObject];
            
            
            
            routeLine = mainRoute.polyline;
            
            //removes any polylines already on the map
            if(routeLine){
                [self.mapView removeOverlay:routeLine];
            }
            
            
            
            
            
            //draws the polyline
            [self.mapView addOverlay: routeLine level:MKOverlayLevelAboveRoads];
            
            
            
            //acquiring the midpoint of the route
            int midPointIndex =  (int) mainRoute.polyline.pointCount/2;
            MKMapPoint middlePoint = mainRoute.polyline.points[midPointIndex];
            
            
            
            
            
            //Code for the region and circle
            CLLocationCoordinate2D midCoordinate = MKCoordinateForMapPoint(middlePoint);
            midCoords= midCoordinate;
            
            CLLocationCoordinate2D baseCoordinate = CLLocationCoordinate2DMake(0, 0);
            
            MKCircle *baseCircle = [MKCircle circleWithCenterCoordinate: baseCoordinate radius: radius];
            float baseRadius = baseCircle.boundingMapRect.size.height/2;
            MKCircle *midCircle = [MKCircle circleWithCenterCoordinate:midCoordinate radius: radius];
            float currentRadius = midCircle.boundingMapRect.size.height/2;
            float factor = baseRadius/currentRadius;
            float updatedRadius = factor * radius;
            
            
            
                                                                        
            float zoomRadius = radius + (radius/ 1609.344f * 1000);
            
            
            
            //Creates region that is zoomed on
            midRegion = MKCoordinateRegionMakeWithDistance(midCoordinate, zoomRadius, zoomRadius);
            
            //Creates a circle around the midpoint
            MKCircle *updatedCircle = [MKCircle circleWithCenterCoordinate:midCoordinate radius:updatedRadius];
            [mapView addOverlay:updatedCircle];
            [mapView setRegion: midRegion animated: YES];
            [self createAndAddAnnotationForCoordinate:MKCoordinateForMapPoint(middlePoint)];
            
        }
    }];
    
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//transferring data between view controllers
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id) sender{
    Radius *radiusvc = [segue destinationViewController];
    if([segue.identifier isEqualToString:@"backToRadius"]){
        radiusvc.addressOne = addressOne;
        radiusvc.addressTwo = addressTwo;
        radiusvc.addressOneCoords = addressOneCoords;
        radiusvc.addressTwoCoords = addressTwoCoords;
        radiusvc.saveAddressOneValid = saveAddressOneValid;
        radiusvc.saveAddressTwoValid = saveAddressTwoValid;
        radiusvc.saveRadius = radius;
    }
    
}




//when back button is clicked it goes back to the radius page
-(void)myAction:(id)sender{
    [self performSegueWithIdentifier:@"backToRadius" sender:(id)sender];
    
}

//custom method that adds an annotation onto the mapView for a coordinate
-(void) createAndAddAnnotationForCoordinate : (CLLocationCoordinate2D)coordinate{
    
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    
    [mapView addAnnotation:annotation];
    
    
}



//will be filled out at later date
-(void) createAndAddAnnotationForTheater : (CLLocationCoordinate2D)coordinate{
    
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = @"Meet up here!";
    annotation.subtitle = @"midpoint";
    [mapView addAnnotation:annotation];
    
    
}


//will be filled out at later date
-(void) createAndAddAnnotationForMuseum : (CLLocationCoordinate2D)coordinate{
    
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = @"Meet up here!";
    annotation.subtitle = @"midpoint";
    [mapView addAnnotation:annotation];
    
    
}


//will be filled out at later date
-(void) createAndAddAnnotationForBar : (CLLocationCoordinate2D)coordinate{
    
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = @"Meet up here!";
    annotation.subtitle = @"midpoint";
    [mapView addAnnotation:annotation];
 
}



//will be filled out at later date
-(void) createAndAddAnnotationForRestaurant : (CLLocationCoordinate2D)coordinate{
    
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = @"Meet up here!";
    annotation.subtitle = @"midpoint";
    [mapView addAnnotation:annotation];
    
    
}



//will be filled out at later date
-(void) createAndAddAnnotationForOther : (CLLocationCoordinate2D)coordinate{
    
    MKPointAnnotation* annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = coordinate;
    annotation.title = @"Meet up here!";
    annotation.subtitle = @"midpoint";
    [mapView addAnnotation:annotation];
    
    
}

//Overridden method that adds the overlay
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    if([overlay isKindOfClass:[MKPolygon class]]){
        MKPolygonRenderer *polygonView = [[MKPolygonRenderer alloc]initWithOverlay:overlay];
        
        polygonView.fillColor = [UIColor blackColor];
        polygonView.alpha = 0.15;
        return polygonView;
    }
    
    
    if([overlay isKindOfClass:[MKCircle class]]){
        MKCircleRenderer *circleView = [[MKCircleRenderer alloc]initWithOverlay:overlay];
        //strokecolor and linewidth have to do with border of circle
        circleView.strokeColor = [UIColor blackColor];
        circleView.lineWidth = 2.0f;
        circleView.fillColor = [UIColor whiteColor];
        circleView.alpha = 0.3;
        return circleView;
    }
    
    if([overlay isKindOfClass:[MKPolyline class]]){
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
    
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 4.0f;
    
    return renderer;
    }
    
    else
        return nil;
}

//Overridden method that adds the annotation
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    static NSString *viewID = @"MKPinAnnotationView";
    MKAnnotationView *annotationView = (MKAnnotationView*)
    [self.mapView dequeueReusableAnnotationViewWithIdentifier:viewID];
    if(annotationView ==nil){
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:viewID];
        annotationView.image = [UIImage imageNamed:@"PinSmall.png"];
        annotationView.canShowCallout = YES;
        annotationView.calloutOffset = CGPointMake(-1,-1);
        //centerOffset does not work, currently trying to find out why
        annotationView.centerOffset = CGPointMake(0,-15);
        
    }
    else{
        annotationView.annotation = annotation;
    }
    
    return annotationView;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//finds and adds annotations for all restaurants within a 5 mile radius of the midpoint
//it only finds 10 points of interest and some are outside the circle, currently working on that
- (IBAction)findFood:(id)sender {
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc]init];
    request.naturalLanguageQuery = @"restaurant";
    request.region = midRegion;
    
    MKLocalSearch *localSearch = [[MKLocalSearch alloc]initWithRequest:request];
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        NSMutableArray *annotations = [NSMutableArray array];
        [response.mapItems enumerateObjectsUsingBlock:^(MKMapItem *item, NSUInteger idx, BOOL *stop){
            
            CustomAnnotation *annotation = [[CustomAnnotation alloc] initWithPlacemark:item.placemark];
            annotation.title = item.name;
            annotation.subtitle = item.placemark.addressDictionary[(NSString *)kABPersonAddressStreetKey];
            annotation.phone = item.phoneNumber;
            annotation.url= item.url;
            
            [annotations addObject:annotation];
        }];
        
        [self.mapView addAnnotations:annotations];
        
        
        
        
    }];
}

- (IBAction)findMovies:(id)sender {
}

- (IBAction)findMuseums:(id)sender {
}

- (IBAction)findBars:(id)sender {
}
@end

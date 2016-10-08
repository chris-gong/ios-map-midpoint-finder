//
//  CustomAnnotation.h
//  MapAppDraft
//
//  Created by Xu Wu on 3/28/15.
//  Copyright (c) 2015 Chris Gong. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface CustomAnnotation : MKPlacemark
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSURL *url;
@end


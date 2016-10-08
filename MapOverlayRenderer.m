//
//  MapOverlayRenderer.m
//  MapAppDraft
//
//  Created by Xu Wu on 3/21/15.
//  Copyright (c) 2015 Chris Gong. All rights reserved.
//

#import "MapOverlayRenderer.h"
//class not used in program
@implementation MapOverlayRenderer
-(void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context{
    CGRect rect = [self rectForMapRect:mapRect];
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextRestoreGState(context);
    
    [super drawMapRect:mapRect zoomScale: zoomScale inContext:context];
}
@end

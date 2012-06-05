//
//  WorkHistoryView.m
//  xplore
//
//  Created by Caroline Leung on 12-06-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WorkHistoryView.h"
#import "ViewFactory.h"

@implementation WorkHistoryView

#define viewPadding 5.0f
#define durationWidthDefault 100.0f

@synthesize employerName = _employerName, position = _position, workDesc = _workDesc, duration = _duration;

- (id)initWithFrame:(CGRect)frame data:(NSDictionary*)data {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat deviceWidth = frame.size.width - 2 * 10.0f;
        CGFloat viewHeightNeeded = viewPadding;
        
        NSString *startDateText = [data objectForKey:@"start_date"];
        NSString *endDateText = [data objectForKey:@"end_date"];
        CGFloat durationWidth = durationWidthDefault; 
    
        if (!startDateText.length && !endDateText.length) {
            durationWidth = 0;
        }
        
        NSDictionary *employerData = [data objectForKey:@"employer"];
        NSString *employerNameText = [employerData objectForKey:@"name"];
        if (employerNameText) {
            self.employerName = [ViewFactory createTextLabel:employerNameText frame:CGRectMake(viewPadding, viewHeightNeeded, deviceWidth - durationWidth, 100) parentView:self font:[UIFont boldSystemFontOfSize:13.0f]];
            viewHeightNeeded = _employerName.frame.origin.y + _employerName.frame.size.height;
        }
       
        NSString *durationText = [NSString stringWithFormat:@"%@ - %@", startDateText.length ? startDateText : @"", endDateText.length ? endDateText : @"Present"];
        if (durationText.length) {
            self.duration = [ViewFactory createTextLabel:durationText frame:CGRectMake(deviceWidth - durationWidth, _employerName.frame.origin.y, durationWidth, 30) parentView:self font:kTinyFont];
            _duration.textColor = [UIColor darkGrayColor];
        }
        
        NSDictionary *positionData = [data objectForKey:@"position"];
        NSString *positionText = [positionData objectForKey:@"name"];
        if (positionText) {
            self.position = [ViewFactory createTextLabel:positionText frame:CGRectMake(viewPadding, viewHeightNeeded + viewPadding, deviceWidth, 100) parentView:self font:kSmallFont];
            _position.textColor = [UIColor darkGrayColor];
            viewHeightNeeded = _position.frame.origin.y + _position.frame.size.height;
        }
        
        NSString *descriptionText = [data objectForKey:@"description"];
        if (descriptionText) {
            self.workDesc = [ViewFactory createTextLabel:descriptionText frame:CGRectMake(viewPadding, viewHeightNeeded + viewPadding, deviceWidth, 100) parentView:self font:kSmallFont];
            viewHeightNeeded = _workDesc.frame.origin.y + _workDesc.frame.size.height;
        }
        UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, viewHeightNeeded + 3 * viewPadding, frame.size.width, 1)];
        separatorLine.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:separatorLine];
        viewHeightNeeded = separatorLine.frame.origin.y + separatorLine.frame.size.height;
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, viewHeightNeeded);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

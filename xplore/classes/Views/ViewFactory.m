//
//  ViewFactory.m
//  xplore
//
//  Created by Caroline Leung on 12-06-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewFactory.h"

@implementation ViewFactory

+ (UILabel*)createTextLabel:(NSString*)text frame:(CGRect)frame parentView:(UIView*)parent font:(UIFont*)font {
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.text = text;
    textLabel.numberOfLines = 0;
    textLabel.font = font;
    CGFloat heightNeeded = [text sizeWithFont:textLabel.font constrainedToSize:CGSizeMake(frame.size.width, kMaxViewHeight) lineBreakMode:UILineBreakModeWordWrap].height;
    textLabel.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, heightNeeded);
    [parent addSubview:textLabel];
    return textLabel;
}

@end

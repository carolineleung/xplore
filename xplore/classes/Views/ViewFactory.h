//
//  ViewFactory.h
//  xplore
//
//  Created by Caroline Leung on 12-06-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewFactory : NSObject

+ (UILabel*)createTextLabel:(NSString*)text frame:(CGRect)frame parentView:(UIView*)parent font:(UIFont*)font;

@end

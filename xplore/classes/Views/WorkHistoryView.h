//
//  WorkHistoryView.h
//  xplore
//
//  Created by Caroline Leung on 12-06-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkHistoryView : UIView

@property (nonatomic, strong) UILabel *employerName, *position, *workDesc, *duration;

- (id)initWithFrame:(CGRect)frame data:(NSDictionary*)data;

@end

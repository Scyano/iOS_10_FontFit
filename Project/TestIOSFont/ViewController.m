//
//  ViewController.m
//  TestIOSFont
//
//  Created by 徐斌 on 28/11/2016.
//  Copyright © 2016 Scyano. All rights reserved.
//

#import "ViewController.h"

@import CoreText;
@implementation ViewController

- (void)testFont
{
    NSString *item = @"墨";
    for (int i = 0; i < 100; i++) {
        NSAttributedString *attItem = [[NSAttributedString alloc] initWithString:item attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:i]}];
        CTFramesetterRef setter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attItem);
        CGSize fitSize = CTFramesetterSuggestFrameSizeWithConstraints(setter, CFRangeMake(0, 0), nil, CGSizeMake(MAXFLOAT, MAXFLOAT), nil);
        NSLog(@"%d size is %lf", i, fitSize.width);
    }
    
    UIFont *font = [UIFont systemFontOfSize:12];
    NSLog(@"\n%lf\n%lf\n%lf\n%lf\n%lf\n%lf\n%lf\n%@\n%@",
          font.xHeight,
          font.capHeight,
          font.lineHeight,
          font.pointSize,
          font.descender,
          font.ascender,
          font.leading,
          font.familyName,
          font.fontName
          );
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self testFont];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end

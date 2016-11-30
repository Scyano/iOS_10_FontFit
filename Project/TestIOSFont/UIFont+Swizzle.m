//
//  UIFont+Swizzle.m
//  TestIOSFont
//
//  Created by 徐斌 on 29/11/2016.
//  Copyright © 2016 Scyano. All rights reserved.
//  Just drag the .m&.h file to your project without any other operation.

#import "UIFont+Swizzle.h"
#import <objc/runtime.h>

@implementation UIFont (Swizzle)

+ (void)load
{
    NSString *version = [UIDevice currentDevice].systemVersion;
    if (![version hasPrefix:@"10"]) {
        return;
    }
    NSDictionary *map = @{@0:@"1.021",
                          @1:@"1.022",
                          @2:@"1.022",
                          @3:@"1.022",
                          @4:@"1.022",
                          @5:@"1.022",
                          @6:@"1.022",
                          @7:@"1.022",
                          @8:@"1.022",
                          @9:@"1.022",
                          @10:@"1.022",
                          @11:@"1.022",
                          @12:@"1.021",
                          @13:@"1.020",
                          @14:@"1.020",
                          @15:@"1.020",
                          @16:@"1.020",
                          @17:@"1.019",
                          @18:@"1.019",
                          @19:@"1.019",
                          @20:@"1.019",
                          @21:@"1.016",
                          @22:@"1.013",
                          @23:@"1.013",
                          @24:@"1.013",
                          @25:@"1.013",
                          @26:@"1.013",
                          @27:@"1.013",
                          @28:@"1.013",
                          @29:@"1.012",
                          @30:@"1.011",
                          @31:@"1.010",
                          @32:@"1.009",
                          @33:@"1.008",
                          @34:@"1.008",
                          @35:@"1.008",
                          @36:@"1.008",
                          @37:@"1.007",
                          @38:@"1.007",
                          @39:@"1.007",
                          @40:@"1.006",
                          @41:@"1.006",
                          @42:@"1.006",
                          @43:@"1.006",
                          @44:@"1.005",
                          @45:@"1.005",
                          @46:@"1.005",
                          @47:@"1.004"};
    objc_setAssociatedObject([UIFont class], @selector(swizzle_systemFontOfSize:), map, OBJC_ASSOCIATION_RETAIN);
    
    Method ori_standard = class_getClassMethod([UIFont class], @selector(systemFontOfSize:));
    Method mod_standard = class_getClassMethod([UIFont class], @selector(swizzle_systemFontOfSize:));
    method_exchangeImplementations(ori_standard, mod_standard);
    
    Method ori_bold = class_getClassMethod([UIFont class], @selector(boldSystemFontOfSize:));
    Method mod_bold = class_getClassMethod([UIFont class], @selector(swizzle_boldSystemFontOfSize:));
    method_exchangeImplementations(ori_bold, mod_bold);
    
    Method ori_italic = class_getClassMethod([UIFont class], @selector(italicSystemFontOfSize:));
    Method mod_italic = class_getClassMethod([UIFont class], @selector(swizzle_italicSystemFontOfSize:));
    method_exchangeImplementations(ori_italic, mod_italic);
    
    Method ori_typeface = class_getClassMethod([UIFont class], @selector(fontWithName:size:));
    Method mod_typeface = class_getClassMethod([UIFont class], @selector(swizzle_fontWithName:size:));
    method_exchangeImplementations(ori_typeface, mod_typeface);
    
    Method ori_descriptor = class_getClassMethod([UIFont class], @selector(fontWithDescriptor:size:));
    Method mod_descriptor = class_getClassMethod([UIFont class], @selector(swizzle_fontWithDescriptor:size:));
    method_exchangeImplementations(ori_descriptor, mod_descriptor);
}

+ (UIFont *)swizzle_systemFontOfSize:(CGFloat)fontSize
{
    CGFloat fitSize = [UIFont fontThatFits:fontSize];
    return [UIFont swizzle_systemFontOfSize:fitSize];
}

+ (UIFont *)swizzle_boldSystemFontOfSize:(CGFloat)fontSize
{
    CGFloat fitSize = [UIFont fontThatFits:fontSize];
    return [UIFont swizzle_boldSystemFontOfSize:fitSize];
}

+ (UIFont *)swizzle_italicSystemFontOfSize:(CGFloat)fontSize
{
    CGFloat fitSize = [UIFont fontThatFits:fontSize];
    return [UIFont swizzle_italicSystemFontOfSize:fitSize];
}

+ (UIFont *)swizzle_fontWithName:(NSString *)fontName size:(CGFloat)fontSize
{
    CGFloat fitSize = [UIFont fontThatFits:fontSize];
    return [UIFont swizzle_fontWithName:fontName size:fitSize];
}

+ (UIFont *)swizzle_fontWithDescriptor:(UIFontDescriptor *)descriptor size:(CGFloat)fontSize
{
    CGFloat fitSize = [UIFont fontThatFits:fontSize];
    return [UIFont swizzle_fontWithDescriptor:descriptor size:fitSize];
}

+ (CGFloat)fontThatFits:(CGFloat)fontSize
{
    NSDictionary *map = objc_getAssociatedObject([UIFont class], @selector(swizzle_systemFontOfSize:));
    CGFloat fitSize = ceil(fontSize);
    CGFloat proportion = ((NSString *)map[[NSNumber numberWithDouble:fitSize]]).floatValue;
    
    // font size over 47 get 1.004 of the proportion.
    if (proportion == 0.0) {
        proportion = 1.004;
    }
    
    // 12 as default.
    fontSize = fontSize?:12;
    
    return fontSize/proportion;
}

@end

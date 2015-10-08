//
//  NSMutableDictionary+QD.h
//  ShouKeBao
//
//  Created by 金超凡 on 15/4/3.
//  Copyright (c) 2015年 shouKeBao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (QD)

+ (NSMutableDictionary *)cleanNullResult:(NSDictionary *)dict;

- (void)setParam:(id)param forKey:(NSString *)aKey;


@end

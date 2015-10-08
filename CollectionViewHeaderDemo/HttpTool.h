//
//  HttpToolJuJu.h
//  GoddesCable
//
//  Created by 时伟轩 on 15/5/12.
//  Copyright (c) 2015年 MI+. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableDictionary+QD.h"

//typedef void (^SuccessBlock)(id JSON);
//typedef void (^FailureBlock)(NSError *error);

@interface HttpTool : NSObject

/**
 post请求
 */
+ (void)postWithNormalUrl:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(NSDictionary *contentDic))success
                  failure:(void (^)(NSString *errorStr))failure;

//for pay
+ (void)postWithPayUrl:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(NSDictionary *contentDic))success
                  failure:(void (^)(NSString *errorStr))failure;

+ (NSString *)getNetStatues;//监听当前网络状态 返回值有：移动，wifi，无网络，未知网络


@end

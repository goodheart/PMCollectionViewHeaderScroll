//
//  HttpToolJuJu.m
//  GoddesCable
//
//  Created by 时伟轩 on 15/5/12.
//  Copyright (c) 2015年 MI+. All rights reserved.
//

#import "HttpTool.h"
//#import "AFNetworking.h"

#import <AFNetworking.h>
#import "DES_Bse64_apple.h"
#define kPayURL @"http://192.168.0.212:8080/pocket_pay/"
@implementation HttpTool
//请求普通数据
+ (void)postWithNormalUrl:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(NSDictionary *contentDic))success
                  failure:(void (^)(NSString *errorStr))failure
{
    //NSString *overStr = [kBaseURL stringByAppendingString:url];
    NSString *newStr = [url stringByReplacingOccurrencesOfString:@"\U0000fffc" withString:@""];
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置头部 1
    [mgr.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"Accept-Charset"];
    //取唯一标识
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uuid =[def objectForKey:@"uuid"];
    if (!uuid) {
        uuid = [self getUuid];
        [def setObject:uuid forKey:@"uuid"];
    }
    //取userid
    NSString *userId = [def objectForKey:@"userID"];
    if (!userId) {
        userId = @"";
    }
    [def synchronize];
    //取secret
    NSString *secret = @"#pocket48&snh48&wholeuniverse#";
    //设置头部 2
    //将得到的三个值des＋base64加密后做value传给requestHeader
//    NSLog(@"%@",kCurrentTimeStamp);
    NSString  *Authorization = [DES_Bse64_apple base64StringFromText:[NSString stringWithFormat:@"%@,%@,%@",userId,secret,uuid] withKey:@"[SNH48&pocket48]"];
    [mgr.requestSerializer setValue:Authorization forHTTPHeaderField:@"Authorization"];
    //设置头部 3
    [mgr.requestSerializer setValue:@"Mobile_Pocket" forHTTPHeaderField:@"User-Agent"];
    //设置头部 4
    [mgr.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"Baseprototype"];
    //设置头部 5
    [mgr.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"Structprototype"];
    //设置头部 6
    [mgr.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"Contentprototype"];
    
    [mgr POST:newStr
   parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if (success) {
              NSNumber * status = [responseObject objectForKey:@"status"];
              if ([status isEqualToNumber:@0]){
                  success(responseObject[@"content"]);
              }else{
                  if (failure) {
                      failure([NSString stringWithFormat:@"%@,%@",status,responseObject[@"message"]]);
                  }
              }
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure([NSString stringWithFormat:@"%@",error]);
          }
      }];
}



//请求普通数据
+ (void)postWithPayUrl:(NSString *)url
                   params:(NSDictionary *)params
                  success:(void (^)(NSDictionary *contentDic))success
                  failure:(void (^)(NSString *errorStr))failure
{
    NSString *overStr = [kPayURL stringByAppendingString:url];
    NSString *newStr = [overStr stringByReplacingOccurrencesOfString:@"\U0000fffc" withString:@""];
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    //设置头部 1
    [mgr.requestSerializer setValue:@"UTF-8" forHTTPHeaderField:@"Accept-Charset"];
    //取唯一标识
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *uuid =[def objectForKey:@"uuid"];
    if (!uuid) {
        uuid = [self getUuid];
        [def setObject:uuid forKey:@"uuid"];
    }
    //取userid
    NSString *userId = [def objectForKey:@"userID"];
    if (!userId) {
        userId = @"";
    }
    [def synchronize];
    //取secret
    NSString *secret = @"#pocket48&snh48&wholeuniverse#";
    //设置头部 2
    //将得到的三个值des＋base64加密后做value传给requestHeader
    NSString  *Authorization = [DES_Bse64_apple base64StringFromText:[NSString stringWithFormat:@"%@,%@,%@",userId,secret,uuid] withKey:@"[SNH48&pocket48]"];
    [mgr.requestSerializer setValue:Authorization forHTTPHeaderField:@"Authorization"];
    //设置头部 3
    [mgr.requestSerializer setValue:@"Mobile_Pocket" forHTTPHeaderField:@"User-Agent"];
    //设置头部 4
    [mgr.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"Baseprototype"];
    //设置头部 5
    [mgr.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"Structprototype"];
    //设置头部 6
    [mgr.requestSerializer setValue:@"1.0" forHTTPHeaderField:@"Contentprototype"];
    
    [mgr POST:newStr
   parameters:params
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if (success) {
              NSNumber * status = [responseObject objectForKey:@"status"];
              if ([status isEqualToNumber:@0]){
                  success(responseObject[@"content"]);
              }else{
                  if (failure) {
                      failure([NSString stringWithFormat:@"%@,%@",status,responseObject[@"message"]]);
                  }
              }
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure([NSString stringWithFormat:@"%@",error]);
          }
      }];
}
//唯一标识码
+(NSString *)getUuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

#pragma mark - 监听网络
+ (NSString *)getNetStatues
{
    __block NSString *netStatues;
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态发生改变的时候调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:
                netStatues = @"wifi";
                // NSLog(@"WIFI");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                netStatues = @"移动网络";
                //NSLog(@"自带网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                netStatues = @"没有网络";
                //NSLog(@"没有网络");
                break;
                
            case AFNetworkReachabilityStatusUnknown:
                netStatues = @"未知网络";
                //NSLog(@"未知网络");
                break;
            default:
                break;
        }
    }];
    // 开始监控
    [mgr startMonitoring];
    return netStatues;
}

- (void)dealloc
{
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}
@end

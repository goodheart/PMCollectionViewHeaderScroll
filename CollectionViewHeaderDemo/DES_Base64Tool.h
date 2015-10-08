//
//  DES+Base64Tool.h
//  testDES
//
//  Created by David on 15/8/8.
//  Copyright (c) 2015年 com.DuYi. All rights reserved.
//

#import <Foundation/Foundation.h>
//该为三方gtmbase64加密
@interface DES_Base64Tool : NSObject

+ (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;//加密
+ (NSString *) decryptUseDES:(NSString*)cipherText key:(NSString*)key;//解密

@end

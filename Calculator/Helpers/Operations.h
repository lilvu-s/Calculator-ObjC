//
//  Calculator.h
//  Calculator
//
//  Created by Ангеліна Семенченко on 02.07.2023.
//

#import <Foundation/Foundation.h>

@interface Operations : NSObject

- (NSDecimalNumber *)add:(NSDecimalNumber *)a to:(NSDecimalNumber *)b;
- (NSDecimalNumber *)subtract:(NSDecimalNumber *)a from:(NSDecimalNumber *)b;
- (NSDecimalNumber *)multiply:(NSDecimalNumber *)a by:(NSDecimalNumber *)b;
- (NSDecimalNumber *)divide:(NSDecimalNumber *)a by:(NSDecimalNumber *)b;

@end


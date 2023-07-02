//
//  Calculator.m
//  Calculator
//
//  Created by Ангеліна Семенченко on 02.07.2023.
//

#import "Operations.h"

@implementation Operations

- (NSDecimalNumber *)add:(NSDecimalNumber *)a to:(NSDecimalNumber *)b {
    return [a decimalNumberByAdding:b];
}

- (NSDecimalNumber *)subtract:(NSDecimalNumber *)a from:(NSDecimalNumber *)b {
    return [b decimalNumberBySubtracting:a];
}

- (NSDecimalNumber *)multiply:(NSDecimalNumber *)a by:(NSDecimalNumber *)b {
    return [a decimalNumberByMultiplyingBy:b];
}

- (NSDecimalNumber *)divide:(NSDecimalNumber *)a by:(NSDecimalNumber *)b {
    if (![b isEqualToNumber:[NSDecimalNumber zero]]) {
        return [a decimalNumberByDividingBy:b];
    } else {
        NSLog(@"Error: Division by zero is not allowed");
        return [NSDecimalNumber notANumber];
    }
}

@end


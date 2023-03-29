//
//  ThousandsFormatter.swift
//  Basic
//
//  Created by Haizi on 2023/3/29.
//

import Foundation

protocol ThousandsConvertible {
    func tenThousands() -> String
}

extension NumberFormatter {
    class func tenThousandFormatter(minimumFractionDigits minimumDigits: Int = 1,
                                    maximumFractionDigits maximumDigits: Int = 1,
                                    roundingMode: NumberFormatter.RoundingMode = .down,
                                    positiveSuffix suffix: String? = "万") -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal // 小数形式
        numberFormatter.groupingSeparator = ""
        numberFormatter.multiplier = 0.0001 //
        numberFormatter.allowsFloats = true
        numberFormatter.roundingMode = roundingMode
        numberFormatter.positiveSuffix = suffix // 后缀字符
        numberFormatter.minimumFractionDigits = minimumDigits // 保留小数点后面的位数
        numberFormatter.maximumFractionDigits = maximumDigits // 小数点后最多位数（不足补0)
        numberFormatter.paddingCharacter = "0" // 不足位用0补
        return numberFormatter
    }
}

extension Double: ThousandsConvertible {
    func tenThousands() -> String {
        if self >= 10000 {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal // 小数形式
            numberFormatter.groupingSeparator = ""
            numberFormatter.multiplier = 0.0001 //
            numberFormatter.allowsFloats = true
            numberFormatter.roundingMode = .down //只舍不入
            numberFormatter.positiveSuffix = "万" // 后缀字符
            numberFormatter.minimumFractionDigits = 1 // 保留小数点后面的位数
            numberFormatter.maximumFractionDigits = 1 // 小数点后最多位数（不足补0)
            numberFormatter.paddingCharacter = "0" // 不足位用0补
            let number = NSNumber(value: self)
            if let formatedNumber = numberFormatter.string(from: number) {
                return formatedNumber
            }
        }
        
        return String(format: "%.0f", self)
    }
    
    func tenThousandsWithNumberFormatter(_ numberFormatter: NumberFormatter) -> String {
        let number = NSNumber(value: self)
        if let formatedNumber = numberFormatter.string(from: number) {
            return formatedNumber
        }
        return String(format: "%.0f", self)
    }
}

extension BinaryInteger {
    public func tenThousands() -> String {
        let temp = Double("\(self)") ?? 0
        return temp.tenThousands()
    }
    
    public func tenThousandsWithNumberFormatter(_ numberFormatter: NumberFormatter) -> String {
        let temp = Double("\(self)") ?? 0
        return temp.tenThousandsWithNumberFormatter(numberFormatter)
    }
}

extension BinaryFloatingPoint {
    public func tenThousands() -> String {
        let temp = Double("\(self)") ?? 0
        return temp.tenThousands()
    }
    
    public func tenThousandsWithNumberFormatter(_ numberFormatter: NumberFormatter) -> String {
        let temp = Double("\(self)") ?? 0
        return temp.tenThousandsWithNumberFormatter(numberFormatter)
    }
}

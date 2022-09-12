//
//  MobileStorage.swift
//  Exitek-iOS-Developer-Tech-Task
//
//  Created by pavel mishanin on 12.09.2022.
//

import UIKit

protocol MobileStorage {
    func getAll() -> Set<Mobile>
    func findByImei(_ imei: String) -> Mobile?
    func save(_ mobile: Mobile) throws -> Mobile
    func delete(_ product: Mobile) throws
    func exists(_ product: Mobile) -> Bool
}

final class MobileStorageImpl {
    
    private var mobileDic: [String: Mobile] = [:]
}

extension MobileStorageImpl: MobileStorage {
    
    func getAll() -> Set<Mobile> {
        var result: [Mobile] = []
        
        self.mobileDic.forEach { (_, value) in
            result.append(value)
        }
        
        return Set(result)
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        self.mobileDic[imei]
    }
    
    func save(_ mobile: Mobile) throws -> Mobile {
        if self.mobileDic[mobile.imei] == nil {
            self.mobileDic[mobile.imei] = mobile
        } else {
            throw StorageError.saveError
        }
        
        return mobile
    }
    
    func delete(_ product: Mobile) throws {
        if self.mobileDic[product.imei] != nil {
            self.mobileDic.removeValue(forKey: product.imei)
        } else {
            throw StorageError.deleteError
        }
    }
    
    func exists(_ product: Mobile) -> Bool {
        if self.mobileDic.contains(where: { $0.value == product }) {
            return true
        }
        
        return false
    }
}

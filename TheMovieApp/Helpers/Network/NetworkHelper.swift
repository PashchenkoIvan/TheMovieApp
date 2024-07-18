//
//  NetworkHelper.swift
//  TheMovieApp
//
//  Created by Пащенко Иван on 18.07.2024.
//

import Foundation
import Network

class NetworkHelper {
    static func hasInternetConnection() -> Bool {
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        let semaphore = DispatchSemaphore(value: 0)
        
        var isConnected = false
        
        monitor.pathUpdateHandler = { path in
            isConnected = path.status == .satisfied
            semaphore.signal()
        }
        
        monitor.start(queue: queue)
        semaphore.wait() // Ожидаем сигнала от pathUpdateHandler
        monitor.cancel() // Останавливаем мониторинг после получения статуса
        
        return isConnected
    }
}

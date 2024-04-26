//
//  RemoteConfigService.swift
//  PlacesAI
//
//  Created by User on 26/04/24.
//

import Foundation
import Firebase

class RemoteConfigService: RemoteConfigurable{
    static let shared = RemoteConfigService()
    
    // Pertama, kita butuh satu variable untuk mengatur berapa interval fetch data ke Fire base RemoteConfig dari local code kita
    
    private var remoteConfig = RemoteConfig.remoteConfig()
    
    private init(){
        configure()
    }
    
    func configure() {
        #if DEBUG
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0 // development
        #else
        settings.minimumFetchInterval = 86400 // production
        #endif
        
        remoteConfig.configSettings = settings
    }
    
    //fetch dan activate configuration, simpan hasilnya sebagai status
    
    func fetchConfig<T: Decodable>(forKey key:
        ConfigKeys) async throws -> T {
        let status = try await remoteConfig.fetchAndActivate()
        
        switch status {
        case .successFetchedFromRemote:
            print("Configuration fetched from remote and activated")
        case .successUsingPreFetchedData:
            print("Pre-fetched data available and activated")
        case .error:
            print("An error occured while fetching remote config")
        @unknown default:
            print("An unknown status was returned")
        }
        //pastikan bahwa nilai dari config value yang kita set di firebase remote config berupa string
        
        let stringValue = remoteConfig.configValue(forKey: key.rawValue).stringValue ?? ""
        
        print("Fetched valur for \(key.rawValue):\(stringValue)")
        
        if T.self == String.self, let stringValue = stringValue as? T {
            return stringValue
        }
        
        //jika ternyata ketika di decode, generic T bukan sebuah string, kita guard agar tidak crash
        
        guard let data = stringValue.data(using: .utf8)
        else{
            throw ErrorConfiguration.failedToConvertData(key: key.rawValue)

        }
        do{
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        }catch {
            throw ErrorConfiguration.failedToDecodeData(key: key.rawValue, underlyingError: error)
        }
        
    }
    
}

enum ErrorConfiguration: Error, LocalizedError {
    case failedToDecodeData(key: String, underlyingError: Error)
    case failedToConvertData(key: String)
    
    var errorDescription: String?{
        switch self {
        case .failedToDecodeData(let key, let underlyingError):
            return "Failed to decode configuration for key: \(key). Error: \(underlyingError.localizedDescription)"
            
        case .failedToConvertData(key: let key):
            return "Failed to convert configuration for key: \(key) to Data"
        }
    }
}


protocol RemoteConfigurable {
    func fetchConfig<T: Decodable>(forKey key:
        ConfigKeys) async throws -> T
    
}

enum ConfigKeys: String {
    case apiKey = "API_KEY"
}


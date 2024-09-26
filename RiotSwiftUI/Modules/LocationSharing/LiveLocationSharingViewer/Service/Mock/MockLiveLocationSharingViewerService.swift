// 
// Copyright 2021-2024 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only
// Please see LICENSE in the repository root for full details.
//

import Foundation
import Combine
import CoreLocation

class MockLiveLocationSharingViewerService: LiveLocationSharingViewerServiceProtocol {
    
    // MARK: Properties
    
    private(set) var usersLiveLocation: [UserLiveLocation] = []
    
    var didUpdateUsersLiveLocation: (([UserLiveLocation]) -> Void)?
    
    // MARK: Setup
    
    init(generateRandomUsers: Bool = false) {
        
        let firstUserLiveLocation = self.createFirstUserLiveLocation()
        
        let secondUserLiveLocation = self.createSecondUserLiveLocation()
        
        var usersLiveLocation: [UserLiveLocation] = [firstUserLiveLocation, secondUserLiveLocation]
        
        
        if generateRandomUsers {
            for _ in 1...20 {
                let randomUser = self.createRandomUserLiveLocation()
                usersLiveLocation.append(randomUser)
            }
        }

        self.usersLiveLocation = usersLiveLocation
    }
    
    // MARK: Public
    
    func isCurrentUserId(_ userId: String) -> Bool {
        return "@alice:matrix.org" == userId
    }
    
    func startListeningLiveLocationUpdates() {
        
    }
    
    func stopListeningLiveLocationUpdates() {
        
    }
    
    func stopUserLiveLocationSharing(completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
    
    // MARK: Private
    
    private func createFirstUserLiveLocation() -> UserLiveLocation {
        let userAvatarData = AvatarInput(mxContentUri: nil, matrixItemId: "@alice:matrix.org", displayName: "Alice")
        let userCoordinate = CLLocationCoordinate2D(latitude: 51.4932641, longitude: -0.257096)
        
        let currentTimeInterval = Date().timeIntervalSince1970
        let timestamp = currentTimeInterval - 300
        let timeout: TimeInterval = 800
        let lastUpdate = currentTimeInterval - 100
        
        return UserLiveLocation(avatarData: userAvatarData, timestamp: timestamp, timeout: timeout, lastUpdate: lastUpdate, coordinate: userCoordinate)
    }
    
    private func createSecondUserLiveLocation() -> UserLiveLocation {
        
        let userAvatarData = AvatarInput(mxContentUri: nil, matrixItemId: "@bob:matrix.org", displayName: "Bob")
        let coordinate = CLLocationCoordinate2D(latitude: 51.4952641, longitude: -0.259096)
        
        let currentTimeInterval = Date().timeIntervalSince1970
        
        let timestamp = currentTimeInterval - 600
        let timeout: TimeInterval = 1200
        let lastUpdate = currentTimeInterval - 300
        
        return UserLiveLocation(avatarData: userAvatarData, timestamp: timestamp, timeout: timeout, lastUpdate: lastUpdate, coordinate: coordinate)
    }
    
    
    private func createRandomUserLiveLocation() -> UserLiveLocation {
        
        let uuidString = UUID().uuidString.suffix(8)
        
        let random = Double.random(in: 0.005...0.010)
        
        let userAvatarData = AvatarInput(mxContentUri: nil, matrixItemId: "@user_\(uuidString):matrix.org", displayName: "User \(uuidString)")
        let coordinate = CLLocationCoordinate2D(latitude: 51.4952641 + random, longitude: -0.259096 + random)
        
        let currentTimeInterval = Date().timeIntervalSince1970
        
        let timestamp = currentTimeInterval - 600
        let timeout: TimeInterval = 1200
        let lastUpdate = currentTimeInterval - 300
        
        return UserLiveLocation(avatarData: userAvatarData, timestamp: timestamp, timeout: timeout, lastUpdate: lastUpdate, coordinate: coordinate)
    }
}

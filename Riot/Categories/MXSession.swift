// 
// Copyright 2022-2024 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only
// Please see LICENSE in the repository root for full details.
//

import Foundation

extension MXSession {
    
    func avatarInput(for userId: String) -> AvatarInput {
        let user = self.user(withUserId: userId)
        
        return AvatarInput(mxContentUri: user?.avatarUrl,
                           matrixItemId: userId,
                           displayName: user?.displayname)
    }
}

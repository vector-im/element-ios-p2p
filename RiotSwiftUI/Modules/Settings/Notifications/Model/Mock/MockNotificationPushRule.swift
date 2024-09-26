// 
// Copyright 2021-2024 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only
// Please see LICENSE in the repository root for full details.
//

import Foundation

struct MockNotificationPushRule: NotificationPushRuleType {
    var ruleId: String!
    var enabled: Bool
    func matches(standardActions: NotificationStandardActions?) -> Bool {
        return false
    }
}

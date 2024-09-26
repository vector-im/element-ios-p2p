// File created from SimpleUserProfileExample
// $ createScreen.sh Spaces/SpaceCreation/SpaceCreationEmailInvites SpaceCreationEmailInvites
// 
// Copyright 2021-2024 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only
// Please see LICENSE in the repository root for full details.
//

import Foundation

enum SpaceCreationEmailInvitesViewModelResult {
    case cancel
    case back
    case done
    case needIdentityServiceTerms(_ baseUrl: String?, _ accessToken: String?)
    case identityServiceFailure(_ error: Error?)
    case inviteByUsername
}

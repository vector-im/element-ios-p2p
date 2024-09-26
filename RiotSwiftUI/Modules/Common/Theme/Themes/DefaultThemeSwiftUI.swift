// 
// Copyright 2021-2024 New Vector Ltd.
//
// SPDX-License-Identifier: AGPL-3.0-only
// Please see LICENSE in the repository root for full details.
//

import Foundation
import DesignKit

struct DefaultThemeSwiftUI: ThemeSwiftUI {
    var identifier: ThemeIdentifier = .light
    let isDark: Bool = false
    var colors: ColorSwiftUI = LightColors.swiftUI
    var fonts: FontSwiftUI = FontSwiftUI(values: ElementFonts())
}

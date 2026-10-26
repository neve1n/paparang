//
//  BottomButtonBar.swift
//  paparang
//
//  Created by karl on 10/26/26.
//

import SwiftUI

extension View {
    /// 화면 아래에 고정되는 버튼 영역. 스크롤 내용은 이 영역 위에서 끝난다.
    /// Figma: 각 화면 하단 프레임 (배경 Bg/primary, 위·좌우 여백 16)
    ///
    ///     ScrollView { … }
    ///         .bottomButtonBar {
    ///             Button("놀이 완료") { }
    ///                 .buttonStyle(.paparang(.primary))
    ///         }
    func bottomButtonBar(@ViewBuilder _ content: () -> some View) -> some View {
        safeAreaInset(edge: .bottom) {
            content()
                .padding(16)
                .background(Color.bgPrimary.ignoresSafeArea())
        }
    }
}

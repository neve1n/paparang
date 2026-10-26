//
//  PlayPhoto.swift
//  paparang
//
//  Created by karl on 10/26/26.
//

import SwiftUI

/// 정해진 틀을 사진으로 꽉 채우고 넘치는 부분은 잘라낸다. 사진이 늦게 뜨거나 비어도 배경색이 보인다.
/// 크기는 쓰는 곳에서 frame으로 정한다.
///
///     PlayPhoto(play.image, cornerRadius: 12)
///         .frame(width: 80, height: 80)
///
/// 서버 이미지로 바뀌면 이 파일만 AsyncImage를 쓰도록 고치면 된다.
struct PlayPhoto: View {
    let image: ImageResource
    var cornerRadius: CGFloat = 0

    init(_ image: ImageResource, cornerRadius: CGFloat = 0) {
        self.image = image
        self.cornerRadius = cornerRadius
    }

    var body: some View {
        Color.bgPrimary
            .overlay {
                Image(image)
                    .resizable()
                    .scaledToFill()
            }
            .clipShape(.rect(cornerRadius: cornerRadius))
            .accessibilityHidden(true)
    }
}

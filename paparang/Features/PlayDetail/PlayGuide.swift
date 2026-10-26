//
//  PlayGuide.swift
//  paparang
//
//  Created by karl on 10/26/26.
//

import SwiftUI

/// 놀이 상세·완료 화면이 보여주는 데이터.
///
/// 팀 공통 데이터 구조(스키마)가 정해지기 전에 화면만 먼저 만들기 위한 모양이다.
/// 서버·저장 모델이 정해지면 그 모델을 이 모양으로 바꾸는 변환 함수 하나만 추가하면 되고,
/// 화면 코드는 고치지 않아도 된다. (10/20 회의: 데이터 구조는 각자 기능을 검토한 뒤 같이 맞춘다)
struct PlayGuide: Identifiable, Hashable {

    struct Step: Hashable {
        let description: String
        let image: ImageResource
    }

    let id: String
    let title: String
    /// 생후 일수 구간 표시. 예: "100-200일" (10/8 회의: 출생~300일, 일수 중심)
    let dayRange: String
    /// 준비물. 비어 있으면 "준비물 없음"으로 표시한다
    let materials: [String]
    /// 발달 카테고리 (10/20 결정 8개: 대근육·소근육·인지·청각·촉각·시각·언어·사회정서)
    let developmentAreas: [String]
    /// 소요 시간 표시. 예: "10분"
    let duration: String
    let cautions: [String]
    let steps: [Step]
    /// 대표 사진. 서버 이미지로 바뀌면 URL로 바꾸고 화면에서 AsyncImage를 쓴다
    let image: ImageResource

    /// 목록·추천 카드에 쓰는 한 줄 요약. 예: "10분 · 준비물 필요"
    var summary: String {
        "\(duration) · \(materials.isEmpty ? "준비물 없음" : "준비물 필요")"
    }
}

/// 놀이를 마친 뒤 고르는 아이 반응. 10/20 회의: 반응 체크 결과를 놀이 추천에 반영한다.
enum PlayReaction: Hashable {
    case liked
    case indifferent
}

#if DEBUG
// 미리보기·시뮬레이터 확인용 예시 데이터. 주의사항과 일부 놀이 내용은 화면 확인용 예시 문구다.
// Figma 예시의 "감각" 태그는 10/20에 정한 8개 카테고리 이름으로 바꿨다.
extension PlayGuide {
    static let sampleRattle = PlayGuide(
        id: "sample-rattle",
        title: "딸랑이 흔들기",
        dayRange: "100-200일",
        materials: ["딸랑이"],
        developmentAreas: ["소근육", "청각", "언어", "사회정서"],
        duration: "10분",
        cautions: [
            "아이 얼굴 가까이에서 세게 흔들지 않아요",
            "딸랑이에 깨진 곳이나 빠지는 부품이 없는지 확인해요",
            "놀이하는 동안 아이 곁을 떠나지 않아요",
        ],
        steps: [
            Step(description: "아이에게 딸랑이를 보여주세요", image: .sampleRattle),
            Step(description: "말과 표정으로 반응해주세요", image: .sampleRattle),
        ],
        image: .sampleRattle
    )

    static let sampleHandkerchief = PlayGuide(
        id: "sample-handkerchief",
        title: "손수건 까꿍",
        dayRange: "150-200일",
        materials: ["손수건"],
        developmentAreas: ["인지", "사회정서", "시각"],
        duration: "5분",
        cautions: [],
        steps: [],
        image: .sampleRattle
    )

    static let sampleMirror = PlayGuide(
        id: "sample-mirror",
        title: "거울 보며 웃기",
        dayRange: "100-150일",
        materials: [],
        developmentAreas: ["시각", "사회정서"],
        duration: "5분",
        cautions: [],
        steps: [],
        image: .sampleRattle
    )
}
#endif

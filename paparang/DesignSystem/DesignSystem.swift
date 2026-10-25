//
//  DesignSystem.swift
//  paparang
//
//  Created by karl on 10/25/26.
//

// 파파랑 디자인 시스템 — 안내와 미결 사항만 담은 파일 (코드 없음)
//
// Figma: c4-개인용 › Design System (node 249:2714)
// https://www.figma.com/design/1om0DjBMCzzmqYyMgoYQRA/?node-id=249-2714
// 팀 원본 디자인 파일과 합치면 위 주소와 각 컴포넌트의 node 번호를 원본 기준으로 바꾼다.
//
// 구성
// - Colors.swift                 색 토큰. Figma 변수 이름과 1:1 (Text/primary → .textPrimary)
// - Components/                  버튼, 태그, 필터 칩, 놀이 행, 아기 반응 얼굴
// - DesignSystemCatalog.swift    모든 컴포넌트를 한 화면에서 보는 미리보기 (DEBUG 전용)
// - Assets.xcassets/DesignSystem 컴포넌트용 이미지
//
// 글자: 커스텀 폰트 없이 iOS 기본 글자 스타일을 쓴다. Figma 글자 스타일이 iOS 기본값과 같다.
//   Title1 → .title        Title2 → .title2      Title3 → .title3     Headline → .headline
//   Body → .body           Subheadline → .subheadline
//   Footnote → .footnote   Caption1 → .caption
//   "/Emphasized"는 같은 스타일에 굵기만 더한다: Title1·Title2는 .bold, 나머지는 .semibold
//   기본 스타일을 쓰면 글자 크기 설정(Dynamic Type)이 자동으로 반영된다.
//
// 규칙
// - 화면 코드에서는 hex 값 대신 색 토큰을, 직접 만든 버튼 대신 이 컴포넌트를 쓴다.
// - Figma에서 이름이 바뀌면 코드 이름도 같이 바꾼다. 이름이 1:1이어야 합칠 때 찾기 쉽다.
// - 반영한 팀 결정: 발달 카테고리 8개(10/20), 놀이 후 아이 반응 체크를 추천에 반영(10/20).
//
// MARK: - 마치와 맞출 것 (2026-10-25 Figma 확인 기준)
// 해결되면 이 목록과 코드의 `TODO(마치)` 주석을 함께 지운다.
//
// 1. 같은 이름의 변수에 값이 두 벌 있다. 옛 C4 변수와 새 파파랑 변수가 섞인 것으로 보인다.
//    - Bg/primary      새 #F6F8F9 (완료 화면 249:1266) / 옛 #F5F5F5 (상세 화면 249:1339, playElement 썸네일 배경)
//    - Text/secondary  새 #7A8F9F (버튼·태그·필터)     / 옛 #999999 (playElement 설명·화살표, 완료 화면)
//    코드는 새 값(파란 회색 계열)으로 통일했다.
// 2. 검정 버튼의 배경 변수가 섞여 있다. primary-m·primary-l은 Text/primary, primary-s는 Button/primary.
//    값은 둘 다 #0F1215라 코드는 Button/primary로 통일했다.
// 3. 발달 카테고리: 10/20 회의에서 8개(대근육·소근육·인지·청각·촉각·시각·언어·사회정서)로 정했는데
//    Figma 예시 태그에 "감각"이 있다. theme/visual·sensory·auditory·physical 4색은 C4 때 4개 발달 영역
//    이름이고, 지금은 완료 화면 꽃가루 장식 색으로 쓰이는 것으로 보인다.
//    → 장식용 이름으로 바꿀지, 8개 카테고리별 색이 따로 필요한지.
// 4. 태그 develop / developEnabled("발달x" / "발달o")의 뜻. 코드는 "강조된 발달 영역"으로만 구분했다.
//    developEnabled만 글자 굵기가 Regular인 것도 의도인지.
// 5. playElement 발달 태그 개수: 예시는 6개 + "+2"라 줄을 넘친다. 몇 개까지 보여주고 +n으로 접을지.
//    코드는 3개.
// 6. 눌림 상태: 버튼·필터·반응 얼굴의 눌림 디자인이 없다. 코드는 살짝 투명해지게만 했다.
// 7. 다크 모드: 색이 라이트 값만 있다. 지원할지, 라이트로 고정할지. 앱 전체 결정이라 개발팀장과도 맞춘다.
// 8. 버튼 너비: CTA·primary-m 304pt, secondary-m 120pt, primary-s 272pt처럼 고정 너비가 있다.
//    화면마다 정하는 값으로 보고, 코드는 large만 가로를 꽉 채우고 나머지는 쓰는 곳에서 너비를 정한다.

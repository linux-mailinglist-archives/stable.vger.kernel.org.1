Return-Path: <stable+bounces-99914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 010FD9E7427
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC65281BEF
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5011B20ADFC;
	Fri,  6 Dec 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="teQG8uCw"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD81B4122
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499173; cv=none; b=uIEVC/ClZQk+q3/D5iz0l+S4pgNiDDsj64Sy7TiXycyKhE3s3+upPKQi3OYYryqFGIORuc/5vsogqDxd+leJesm9e7Xb7OnTjqjuNGblVgt6UTGYxGUOt0haS1lhvwCPrjfVcq28E1U80o0XvdlXLxrzXqYWi+xG2QZQNszL8mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499173; c=relaxed/simple;
	bh=TIif4gFB4h/LqQjH73EF7Dn/xIREbzfII/NyIH+Q4dA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eb8hKHTSPLUtrUXUn5eh7L48gb6PX5pmISvHJvZ7uzeMuYMZ3hwYWY4qFqk2ddjef6C/Br7m8TL/sH1xA7M42cTQ9It1+2FJujnKQi4MD6gB23ZqQcIappGQXqNL89cS951y/bcqPu7ER7GTDYiEVTlEqaMaGz4cosFvh4f696c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=teQG8uCw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349c376d4fso2386315e9.0
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499169; x=1734103969; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AJ70EcJe8jYywWDYC9CMHy+Cxyz1o4e3QlzB+VWKUbE=;
        b=teQG8uCwOC/+0C1xMcri2wn8wl1jiQkH/5SxJpuc1Jc/T5xiZFgn59oeHyPs7xpSne
         DYMG5ovHf/u5/QMU7Gfn0vHNzQmmONVAAiinH4dV/X1pJx6vU/aa4xznLwFPtbmg+DHu
         gCoNpU+XpamN4Fs3x1sr/JunypXjLOzDOPIiMwWBWCzUyf2Fb8b8KMw68j2nstqiyycK
         bHfvJf2/S7HdDB/pM/4rL+Fvv3Vwes1LCrnax2KmX6bUjH0RnziqivJYQ8U30v8GpiA+
         bC0Mzb349N4m2ATtLXGAfCbpmCY0zVTvyHz2x0GIZ2V8kN9Xe6L1eW9XIRVE7xOmlpkr
         OZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499169; x=1734103969;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AJ70EcJe8jYywWDYC9CMHy+Cxyz1o4e3QlzB+VWKUbE=;
        b=N+HO+bjvPm/BdvjsLwBh09RohMsPnJfKXFCOymUsKyZr1Osjvj5i4jT5/UyxIYHB5r
         fLKAxewv5aV+ChkzKvUotYpA7uvrtOlZKsV8kaNpvlyId1AyWYFV/pnCT0TPet++tZZh
         JE0tSpbL4qUeU1h4ApR3xlTeZRCbJPag/zPZkNHRpi19v9i3xVPrUPLGY9koj0ytKDn1
         hAmf833fvU5yBfU7ZtCwEd2QIhgUsWUEpqEBbLMRGDhBNM+yP2Dqk400/N0AJjT3FJN0
         Q4/xd1p/K6J22XrOvqwOJ+W4F4z0twsb2jH6p1/rAjbeduzmc45gq+3iaVYcZNud7GCV
         LoXw==
X-Forwarded-Encrypted: i=1; AJvYcCVwdXRR9mERmz+JwXnAj0Y31Xmu/KFHI6Yn4UDaTtMh4eZ3rCK+zq4poekadz6Dwi0S8r6YZjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlP2b6Svu9mGdvAt8QgMMB5zHdNnSLXW+Ngftvv0kd1f81y9O2
	CeRIUGGuRrzL9G5kpmTrShxyXlIw3DCOHfIkjxMm6PQHOXxblWFCb9Kz8/Qj6PC2MvrMQLX2h2R
	h43c=
X-Gm-Gg: ASbGnctKn0V7TqWHi5g/164B/d1IOx6KpVyxBppgAA1yDHYkfAAI9edcMD+584kzAsN
	Dxl7dDnBFhakMnyr+kgMyxUEGDruGiHjsjhZFjBXdgAg4w2dSt75slelKSld4pS7yKV77RQrDBW
	+4/Dwg/5mqrx9WMGswH6s7MTe8E093VWwIvTUy0XlVym0REK9BRAvqFsiwJsSPzT1HyOC/6yiFI
	/IW44vMIdIwuCUi//TmofDu0hWQTpBQ3IXQSCRjkrn9NWDfFzVlDnl1x4FACoeV4A==
X-Google-Smtp-Source: AGHT+IFKpm7qOUxTbqaZKrrVqg194z5KBoP1DrhsMMILvR8vDAu3Na1B60Dhv/Spq2gdpCrBU1GMfg==
X-Received: by 2002:a05:600c:1ca3:b0:434:9d62:aa17 with SMTP id 5b1f17b1804b1-434dded1d94mr12649675e9.5.1733499168669;
        Fri, 06 Dec 2024 07:32:48 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm61158035e9.29.2024.12.06.07.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:32:48 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 00/19] arm64: dts: qcom: Fix remoteproc memory base and
 length
Date: Fri, 06 Dec 2024 16:32:24 +0100
Message-Id: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAgZU2cC/x3NQQqDQAxA0atI1gbGYbC0Vyku0iS2WajjREQQ7
 97B5dv8f4JrMXV4NScU3c1tmSu6tgH+0fxVNKmGGGLqYuhRNseVlwlZPOOU3fFDrkgiRStIH5x
 CT/wkhlrJRUc77sN7uK4/wroinnEAAAA=
X-Change-ID: 20241206-dts-qcom-cdsp-mpss-base-address-ae7c406ac9ac
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2427;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=TIif4gFB4h/LqQjH73EF7Dn/xIREbzfII/NyIH+Q4dA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnUxkKUzJ2/4adaFmTbJ6uzv6aXkDSxtdLMiiRT
 waJjbvhP7KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1MZCgAKCRDBN2bmhouD
 16pXD/0enUrYMzdi3VsReZlxxnqlSBDGceVCHTUTvLrGrSdeZC1QSVZwXTwnvYWXwmLcWZpq5/r
 EmeW0S7/VyhR6eakXF7VKd/3EBS8V5y3Vru7lmZANaJzK6ODgHI7jWKuVcIljrDoR0ZtsF0cqej
 oWQ0cvL2PZ8KxwRt3hvqK5ObenYphE0/XCa3OF9EeaYFA3pjUUitVOEA5JgV2fJkSw9sb9tOACC
 kBfj/zUpJN+ZyzoxbWyZ/5E42lNKp3RfTSwpq2iXczJX+aPvP50fvJYA6dNVAr3PrNQqkh436yt
 w5efIBLaVajfnaN02cF2o1hufb9T2iD6NahE64DYuetJTIm5RaBqgEn67wHEnAY6YwH+y3FXSxX
 uQhZrbDeIpwcDQq0gyd0gQXHTpsRuOFyXVZcUzt2mECFVwWi/8wCVe3cLMHeXau+xpf+VC0Wqk1
 21Ijz0QinENsWYW1eLXcROu0NvZLOducSeN7NzKxSeD7DC845hmp1ZkenugC2bIhuThnX7yYjjf
 paUCBGk5V/73sz1Y8oIsZBRLCG9OFvmkKd6MH0ZZ4cRP0I1d1eSBT1jxEVTp3osGnWsJ+Ax5ufW
 AbZ0wfqvt7mTLlk7ZK7qY+vyXJIgLKmA+IJanI5lIXJO1Tmyo4kkpWvq8mKEloMolFouKClC6rI
 Jkfhn9h7TAWpr1w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Konrad pointed out during SM8750 review, that numbers are odd, so I
looked at datasheets and downstream DTS for all previous platforms.

Most numbers are odd.

Older platforms like SM8150, SM8250, SC7280, SC8180X seem fine. I could
not check few like SDX75 or SM6115, due to lack of access to datasheets.

SM8350, SM8450, SM8550 tested on hardware. Others not, but I don't
expect any failures because PAS drivers do not use the address space.
Which also explains why odd numbers did not result in any failures.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (19):
      arm64: dts: qcom: sm8350: Fix ADSP memory base and length
      arm64: dts: qcom: sm8350: Fix CDSP memory base and length
      arm64: dts: qcom: sm8350: Fix MPSS memory length
      arm64: dts: qcom: sm8450: Fix ADSP memory base and length
      arm64: dts: qcom: sm8450: Fix CDSP memory length
      arm64: dts: qcom: sm8450: Fix MPSS memory length
      arm64: dts: qcom: sm8550: Fix ADSP memory base and length
      arm64: dts: qcom: sm8550: Fix CDSP memory length
      arm64: dts: qcom: sm8550: Fix MPSS memory length
      arm64: dts: qcom: sm8650: Fix ADSP memory base and length
      arm64: dts: qcom: sm8650: Fix CDSP memory length
      arm64: dts: qcom: sm8650: Fix MPSS memory length
      arm64: dts: qcom: x1e80100: Fix ADSP memory base and length
      arm64: dts: qcom: x1e80100: Fix CDSP memory length
      arm64: dts: qcom: sm6350: Fix ADSP memory length
      arm64: dts: qcom: sm6350: Fix MPSS memory length
      arm64: dts: qcom: sm6375: Fix ADSP memory length
      arm64: dts: qcom: sm6375: Fix CDSP memory base and length
      arm64: dts: qcom: sm6375: Fix MPSS memory base and length

 arch/arm64/boot/dts/qcom/sm6350.dtsi   |   4 +-
 arch/arm64/boot/dts/qcom/sm6375.dtsi   |  10 +-
 arch/arm64/boot/dts/qcom/sm8350.dtsi   | 492 ++++++++++++++++-----------------
 arch/arm64/boot/dts/qcom/sm8450.dtsi   | 216 +++++++--------
 arch/arm64/boot/dts/qcom/sm8550.dtsi   | 266 +++++++++---------
 arch/arm64/boot/dts/qcom/sm8650.dtsi   | 300 ++++++++++----------
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 276 +++++++++---------
 7 files changed, 782 insertions(+), 782 deletions(-)
---
base-commit: c245a7a79602ccbee780c004c1e4abcda66aec32
change-id: 20241206-dts-qcom-cdsp-mpss-base-address-ae7c406ac9ac

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>



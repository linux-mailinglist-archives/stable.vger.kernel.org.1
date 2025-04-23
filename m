Return-Path: <stable+bounces-135282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17672A98A34
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 14:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A20444346A
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 12:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B10C2FD;
	Wed, 23 Apr 2025 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqQag7lU"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D61DBE4A
	for <stable@vger.kernel.org>; Wed, 23 Apr 2025 12:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745413145; cv=none; b=gaxw3N1kO9lvWHdv/Aoc8Gtfqh1RKH1+UKXfzMu4zPUVl83ePObstgYW1ltVgf0eqyRmmuSn+5F0hA8Nb/jEzohRHXEOXSJQfA+mvD/NyjLbcH6LlaiW6eQ7+ruRrNxMqg4gefZ++OYJCenLllGV+RUQMoeHmQKy+Xvcv8vO6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745413145; c=relaxed/simple;
	bh=TyEJqV+iPI49wYRxxheS7AY0Oo5A/AIP7GetFD9olro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NP13jXVjhfyOSPQK1lWFaAO6fRfDjn6sAztB4tNCdcwo2+gZ+q+5PauAWpduMAK6WPBBzVvX6kVj+MU+rih1ISvNf5GBSqyYxxwlP7wL34OAflMkpjaLw4YVR2B4/GwYI8ggndEpwgmqgk/SZWAbIKWP9i58vfKyTpGih2qT8DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IqQag7lU; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ace333d5f7bso259915466b.3
        for <stable@vger.kernel.org>; Wed, 23 Apr 2025 05:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745413142; x=1746017942; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWSgYU4Bs/P+4N0/0yj45j2zwuuB7lOSEXG+V6K+MOE=;
        b=IqQag7lU35JYDzug7NsQHo0KBA2LA1ZA3GNWFFO4RPQ4w+KOcYBCK28u7qMaJd3PSz
         flNb+6CtW/ZW+NXr1FkmjEX2U8YPqiCZ9Xb93lcaGwy1IIFpbtkVypny6EIPWW/C9hQv
         b/Dhmg2ysslUUcCGKfDk2TC2KaebgezPXUNs0u7YL4dHQA/+wy2Wm7H/Hu02uZ3RkgFt
         9VlOOJ9kan/9ORfkTaIiR7qX177EP01X5Sqtqznk056XWn4xblE+0aDDFdWjOXX6o5x/
         yLljq2vECAYD9x8+4ZibEpmALOY9E5r8W0/zTV9UflfGl5g2MxNa5GXa92TLgGZOqm07
         OHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745413142; x=1746017942;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWSgYU4Bs/P+4N0/0yj45j2zwuuB7lOSEXG+V6K+MOE=;
        b=bfkWdOyEzcpE5d8yvJPAV7mNNqvo7K3ffvhgPzLxziqXeUVVQNR8KEYBjzQI8tRBG3
         WehhUXGL79RgEA3xhT4rrN5hqkUjzxstzavOJs4DjbRo/MspDS7yUTk/wIk6VV8LViUP
         Bdjnx2Mj831Tzmneaa4aLkJSekTu2BpEfH9gBP+vY/tiBDNxozy/OCkBN/seGszwQ4Ak
         7Bb1lDc6XZTs929EmeoNfhjXxc5/9oQGuFNgqj4jBkdn+0CPYngToirMZcv4V+Py8ofl
         3uQI6h9GiaFyCkxaRjvvqWKOCr/pYM2Qy0PVFkQNW9TM81i29N2JGNThMQSIw9JQVEXE
         kNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYNCClEceVwcXVC9q2owNPzJ7aCDhEQyuv9vX3ZOOJHjbaMxzfaDxotlpns7LDCM5BSyfbK4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDvIEWTCbq/xmqqY0R7SwDI6w8CBXnX1URXjRc5uc8Atb9Zd9p
	cU5hlv50lfIcNs7K7P9WT38hd+sLtuP1IlkhMjdxjpwusaAdctW2ZzIJK7rT3HMFy4ufAKcKCfJ
	W
X-Gm-Gg: ASbGncvbNuXCiWq8YlOihx7shzmZJIIcUvr3TZwo3rRRrRcJN3r6wD+ALbted4aavgy
	nwtAku3XlC2A9wVNZf4Kqi5Vti70+8ATNVszE0Cy6taGypbS/7QfPa3wF/eKBLvdLcOjNE/bADr
	p9oIGAjFZie2B+U99UIxq603yVwQFE6KAznWA6kALuIYICtwVh6KucOvTs4hB3K11i3t1jJM8UL
	mCSwNdpz3ArxVV2KzyU7e6PEZS/a4hRRkJm8rItRFhNqmB4e4ygaqa4QguaSKEHiV/lI0PK2tVJ
	I3xs+7n8RSQUE3Y+PwosfWDh8AAQMK5AZAM7HxM=
X-Google-Smtp-Source: AGHT+IHOahSmPfO3hs7sUfnCfxpEOAB/NiskqrVfwSdRbErJuG4vZlaOfuNODVHDVcw1+Mk7JEWnnw==
X-Received: by 2002:a17:907:1c21:b0:ab7:1012:3ccb with SMTP id a640c23a62f3a-acb74b2e84cmr1485463766b.14.1745413141636;
        Wed, 23 Apr 2025 05:59:01 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ef426c4sm794377966b.131.2025.04.23.05.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 05:59:00 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 23 Apr 2025 15:58:52 +0300
Subject: [PATCH] arm64: dts: qcom: x1e80100: Add GFX power domain to GPU
 clock controller
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-x1e80100-add-gpucc-gfx-pd-v1-1-677d97f61963@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAvkCGgC/x3MPQrDMAxA4asEzRVIzg+hVykdjCU7WhJj02IIu
 XtMxm9474SqxbTCezih6N+qHXsHvwYIm9+Tokk3OHIzTW7ExroSE6EXwZR/IWCKDbOgn1nHGJ0
 sytD7XDRae96f73XdscwmEGsAAAA=
X-Change-ID: 20250423-x1e80100-add-gpucc-gfx-pd-a51e3ff2d6e1
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>, 
 stable@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=TyEJqV+iPI49wYRxxheS7AY0Oo5A/AIP7GetFD9olro=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBoCOQN3ZP4llDd4xTrqoYEBqHvi08og4dAIxlKD
 0RC5xJ1rEGJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaAjkDQAKCRAbX0TJAJUV
 VgTbD/0dGPsZw4skZK545sXIXLPy9uRQDXtDk2p36rtTpN1x9m/yIy//KakO+AGrY0jhZ7m82w0
 v7KZkA+ehartHeFVBRnJp39j/OJxk0nRKe6n0E8n+8UX4VTo3Sjvkmtp1Gj15S7XXePHGTsZe/C
 veXybYjS4DJ64K2LZiEak+bZ/2F3gYs7FiddjNFZYtoUSds6Ei7L1NOCWbJN4V1odiQLdrf6gMo
 fhWstp0V3ah4AZgcZVNs8yv/tGcjdtbXxte+u0LLCeGFQLXMHi+lqnAh4LkVX1TqV0ris3lGz4H
 dt1bgOuiLh8NuBUKzDEJpRdTGVzmFmC7enE/hUZHfd8hLWVMdP3ORRSvfPfA/514LPqIWFUqFYM
 mgDLwDnuA3eSwCi+XF7c/j5keiRYBqUgDnxKAy25kUSvSfu4d15+mfvzkNZjBXKN5uU3SJg9Hht
 A6552zu/PIwaKfAHFOL8oQS6Lq17APphEQbacmdzZ4TsTVlXNzqvZxsJqB2/Haslew6iUjwbvgx
 FSWmlPmDJCeEed2K1F2YAb6tDD+CDPbzhdbz3rv4AdIJC5Hzjwq6HbeSMuSFVB93w6ZEXV1kaBK
 wE86cK6Bdxy9qsVI3ur08wzx3rS13c8cmVb2B3OvrnWwTaq06hFvhnxlvLfDk+wSa5zxImn+ey7
 lUK1qHepyy2Kg7Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

According to documentation, the VDD_GFX is powering up the whole GPU
subsystem. The VDD_GFX is routed through the RPMh GFX power domain.

So tie the RPMh GFX power domain to the GPU clock controller.

Cc: stable@vger.kernel.org # 6.11
Fixes: 721e38301b79 ("arm64: dts: qcom: x1e80100: Add gpu support")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 46b79fce92c90d969e3de48bc88e27915d1592bb..96d5ab3c426639b0c0af2458d127e3bbbe41c556 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -3873,6 +3873,7 @@ gpucc: clock-controller@3d90000 {
 			clocks = <&bi_tcxo_div2>,
 				 <&gcc GCC_GPU_GPLL0_CPH_CLK_SRC>,
 				 <&gcc GCC_GPU_GPLL0_DIV_CPH_CLK_SRC>;
+			power-domains = <&rpmhpd RPMHPD_GFX>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

---
base-commit: 2c9c612abeb38aab0e87d48496de6fd6daafb00b
change-id: 20250423-x1e80100-add-gpucc-gfx-pd-a51e3ff2d6e1

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>



Return-Path: <stable+bounces-185615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B9CBD898E
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 11:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3E311923C76
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D577030FC3D;
	Tue, 14 Oct 2025 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ob4eJLwL"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB643093A1
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435202; cv=none; b=J7LibKU2Q0w+wD3pby76C/5lXT9YnTMD/Z6x5lUAKKB+jIoCO+j6Y1Cr6KTw0ttVOdi3kgAMHR+yGmpYZa94dp+1INr+Bw1o3nHgsaZK9ogTVHgpxKBR5mb1bG6QSKFoD7PDQAz3JdpMSUAIGcvC+6rhJtD9kj3SUcvzqHcdhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435202; c=relaxed/simple;
	bh=lMgoKm6fFriFGTk58UsXdD/s6UE1JLiRxIhK+/XA3EQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nl9ffI13DtYv6Ln/8Jc65CUYJNoP1Vk5DBg1tAIRF1Sw1Y4LF/UHe7yS8pYLKJXXysUMRf9Qx7YYQPyM9GaIavxYoA15a5zOKjQwsfji+pnjMwHLl71306k0KMTQqEHinOgp5K5YMKnDj5ey3R4YE39fvj2lN86U2M58RhifquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ob4eJLwL; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e3af7889fso27761785e9.2
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760435198; x=1761039998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUaeped6AYTKx4zcDVin/2JtzA4/FqNOiGDU51UI8HM=;
        b=Ob4eJLwL1jy5pdRhSy987E5TWW35fjW5cctory4ljaIm6T/OVyYBzqaEBwf65aIFon
         tnFru3b/yIYBGGNisorW8FtjK/q1mmXAlmOHPPI5El/x6o8JPqiXOPzGttdHX2UC5pVB
         SRgeHMu3PFfLg6ubDEEKzlKkuC9OzOGZZ4DO2aAIoTkneiLzkj7fmXqE36P//IWzR1DQ
         n3inH0D6W4LBTDgLYQOJxod1DJSYnIsnK+QUjPVjDwOAywSvBM2hZpS69GDTaer1osZQ
         HKizZA8wEJuVgHFo/R/YHGMjPdO5r8P/cEIaoGMvPZKDDpMfCK34v2fMcQc7KXcWOH7j
         24rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435198; x=1761039998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUaeped6AYTKx4zcDVin/2JtzA4/FqNOiGDU51UI8HM=;
        b=DUVnk3xK59e6bakz8UzzIVhEGlMXYYBCiUhv1RDSZwK3middqe6T2t8ik1sFXvzL4M
         WfVcor9b+8sl+B2QZ9acY+PcKxRLKzhqy8shb8gOVMFH/2Gjz03/GqVfXXt3zs5sw3JY
         /44NwtPHxSpEglPoff820RC1XMJ/RTW7qx9ftZu4dC2pLmEPcNRb/pYPQZibxmXCCNpR
         LZDoYyZuABFXmCr1LlBCt0Okfeb6w+OSZKCVcDcWCD3mLr3xcqDQxMPWAxD8byoVxZnp
         gR/NPP5bLKIUFFPrmVbxZ7QAhNdX4iFOB5FJ2o4/Bo7GLcgLbr1e36PJhe7gM2tYI0cR
         CVlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxEw2C+3Ew7rhgjm/7ZN3BnKFdPxeCQAWS6UKF2TVRx2iCkN8Edhb3lr/pLnYhOHOOjN2qftU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxErW+M9mPiPD3J18p0q/4WcKGYXPWAtWaz6iVxLoONONRn3NXG
	V45kMKSwP2Ui/kQ93VkFOTl9kfiHEewbSWMQGJMc9e1ZJJhGz2STnKQSl3QKAUm5sGo=
X-Gm-Gg: ASbGncssuA6z0KyytuWQFzjsZ4YMhcOFL/K+iQv/lg6oJEPb+V3bM5XZhfQZfc1dV0W
	cco3JUD/eUQH7p/VYzLHFPc6SfPiZjRlJpyhSjzZMPngdJUZLpM1apcMX4ay0bpJ8LIdzL257Nc
	/syCiunPjJuEe9YoVGF9PTJQqtkwFFmwN13xLi/ZIYKXAzhSHlSUunl4RaXFs8m6IQ2j6KaMfc7
	AGkYFPw6EyOXi8oXaTW8yKxS0r005DvLIpGCiAzvMQe/wxfGw18JZokBci9eotfNWrGYX3Tvntj
	uyPZISUa/xuFcyG/RbbAvhnHfxFoelUGDCJvuTZXftB5OdipQoX7uFk5XclTfgK5K21U+I+gJIs
	zIPClGQWmV9xTzlU9QLt76Ty/H7nbRuxwtyBdbzYQ4cMJ3ByIhnbOxZ3cTDHnInPo
X-Google-Smtp-Source: AGHT+IHF94BpDjyQHISB3YpTos3ClDnO2QEk9OvNMWaiACfwfHscIkvvEEFe8GflJANQQTK/kZpUVA==
X-Received: by 2002:a05:600c:c096:b0:46e:2cfe:971c with SMTP id 5b1f17b1804b1-46fa9b937e1mr113989105e9.0.1760435198283;
        Tue, 14 Oct 2025 02:46:38 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8b31sm22866442f8f.54.2025.10.14.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:46:36 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 14 Oct 2025 12:46:05 +0300
Subject: [PATCH RESEND v3 3/3] arm64: dts: qcom: Add missing TCSR ref clock
 to the DP PHYs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-phy-qcom-edp-add-missing-refclk-v3-3-078be041d06f@linaro.org>
References: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
In-Reply-To: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=lMgoKm6fFriFGTk58UsXdD/s6UE1JLiRxIhK+/XA3EQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7hvpvtZYMOOjNeP/WxoC05ERCeQIn31ePA6ou
 KHQQL1n7NiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO4b6QAKCRAbX0TJAJUV
 VjkFEACACdNyGShHB0VCbqgl3wmaUbLAiFR1/ZnEk/ntbJYOWJBHthyNxhu6Kwq2S+xgChEcJ3C
 QZEC4bm0PJK353jPGQV+PvNWHLv5P4m2njVLdNctNau9asqqoyyjwwhOlGn4xS6Oi/p33yl87II
 +8CtFUZ7Lx4XirqFhNykxJ7QjgbsgZnMJmrRC906I9ps+TaOe1DtxTXP3sozR+NA6Q6nbz1YT1R
 4mhAmHzCiMGo+89DwZsUhkKIoVSrq9kV4D4p8Gi4tRwhTuGIpBl7bT5HLNOzWzaJwEc6B8HikTX
 rkpx2ZneYmmtu+UkRp6ZhJ5B0M7zuZC4TPxm5UGJUGtWYwv1MklakNYZLq5nfo/mi4Xa/zYwXbd
 nqM2eynJEMLpctZoXnC37DG4V8GMhsWIapXT4aXBRoY0gAZQbSGfS7nJYez4GewE531xVEB8ZpN
 B194MntxyQ2ezz9uk76VlkMua8dQkKf1IerZX1NIn/0COX0MfC0oxpQhWO8V5cjrg1lANTgKWP4
 h0zCHgiS76+ux8b/syakZ6yz609Ka34j1+l0QNMZHtTwOCoBecT8/AtUpzSi9w/9slJ1/q/Vx8e
 Mc6fUI0oevA6qCEEiUnZmqkabLH7VpJT17idYRfFGCazycy+HrDbGL7lQ/GHo1miGw1dPT9BU24
 j0PBwMhOV6uhIMA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The DP PHYs on X1E80100 need the ref clock which is provided by the
TCSR CC.

The current X Elite devices supported upstream work fine without this
clock, because the boot firmware leaves this clock enabled. But we should
not rely on that. Also, even though this change breaks the ABI, it is
needed in order to make the driver disables this clock along with the
other ones, for a proper bring-down of the entire PHY.

So lets attach it to each of the DP PHYs in order to do that.

Cc: stable@vger.kernel.org # v6.9
Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 51576d9c935decbc61a8e4200de83e739f7da814..0db5183cb4c4ea984d6a47987a1a165cacb3c4e7 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5817,9 +5817,11 @@ mdss_dp2_phy: phy@aec2a00 {
 			      <0 0x0aec2000 0 0x1c8>;
 
 			clocks = <&dispcc DISP_CC_MDSS_DPTX2_AUX_CLK>,
-				 <&dispcc DISP_CC_MDSS_AHB_CLK>;
+				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&tcsr TCSR_EDP_CLKREF_EN>;
 			clock-names = "aux",
-				      "cfg_ahb";
+				      "cfg_ahb",
+				      "ref";
 
 			power-domains = <&rpmhpd RPMHPD_MX>;
 
@@ -5837,9 +5839,11 @@ mdss_dp3_phy: phy@aec5a00 {
 			      <0 0x0aec5000 0 0x1c8>;
 
 			clocks = <&dispcc DISP_CC_MDSS_DPTX3_AUX_CLK>,
-				 <&dispcc DISP_CC_MDSS_AHB_CLK>;
+				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&tcsr TCSR_EDP_CLKREF_EN>;
 			clock-names = "aux",
-				      "cfg_ahb";
+				      "cfg_ahb",
+				      "ref";
 
 			power-domains = <&rpmhpd RPMHPD_MX>;
 

-- 
2.48.1



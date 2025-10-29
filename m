Return-Path: <stable+bounces-191614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EBBC1AEAA
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 14:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF13189F9BB
	for <lists+stable@lfdr.de>; Wed, 29 Oct 2025 13:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F5D3559F4;
	Wed, 29 Oct 2025 13:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vLt9FAw2"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A352A3559DA
	for <stable@vger.kernel.org>; Wed, 29 Oct 2025 13:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744716; cv=none; b=iqa2dRT3Q+9bIXsP7baKxUO2/hHzpbYHC3gtAMspNfq16QXCAUdkoFYLFyrDDK5jiddu9vQQBlovl1l8JodcPnjJP5+jarP/ErsTou/nVSHdDTbxHUmthdLCsIDdqZWUF6S66yViDyNdTRsy+yxPdwDLf1PvFEx3ejXlV5QhmFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744716; c=relaxed/simple;
	bh=KPHt1suJLdA9xJbwn2KTdFAVkwcQfxRACwyO17/eejI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JIT83pP2By1ZEl2AbmH//x1e1hHg24Tfz1dBmdnQerlHlrCj052hwWHAvsCxMQjziY53Eo7h83nXZluiMqDsOlLHNytoGp8WgcvdUsDS8pKoh2Rg/U9kh6CHJ5+IOreOzSpectGjBeIo/xlVam0izHxDXADJhggTl0hQkJ+cyKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vLt9FAw2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47117f92e32so67280025e9.1
        for <stable@vger.kernel.org>; Wed, 29 Oct 2025 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761744713; x=1762349513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxFx9AVopbicqvEHjs4lmh9jOTKVKMn3jkGcEi+fwfw=;
        b=vLt9FAw2eUHRYdCwsWxckB5hsRo2HYZuAQ7aEcIZHEeNpYVdcu3m/dbllSGKtM5ZuP
         qTSRfHatLR0ttH23LyL5x5U09j3gQ2hKl5bUiaCEZgR82xGMXQ02byZlTdpAToaoSNbL
         yYB6EyybRBDRWxqLtZMa3u4ExQ8HcYdvkUbSBmhVNKVbBBlq1QI5G30R6+rhsy2A9W8i
         OiYU/hWB3YBeHirrx1//NfBvQklD5pBlrw5jt7dBULy7gbWf8GjgFRoybysmxqBrLPcc
         5GsDElrXFbjwerpw0/rCm3/9zBY+syDCZAOCrkMMyI8jf9xMvqWFGcGH6Sty+JZw4QAp
         UYjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761744713; x=1762349513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kxFx9AVopbicqvEHjs4lmh9jOTKVKMn3jkGcEi+fwfw=;
        b=gSxDwww1ZeAjMoKz0Hkhw4pepRLFrL/97swxMY5INAQWV8Fljh8P578CxAwchGB6RC
         qXK+DvnJdT7FcfjYYcTErKjO6qOC3MQaPk+48P5k3/vb6Jidd+9iD/p/kanFF12MpZ31
         sf0T7Xbb3DO5f50mdxqplcV0hLBHCKcpZtJR90yRZm8CpB2f/vdGcl4gYCF12QI9w9r7
         osnV9G6r/GNWMoyPNfm06OCKmH3iKkw+A0baaGIbQ1TGbJJ2wseWaxurhaDyQ2T5pZ84
         M12yGIkhcfPWXejJoo/2+rL5OipqsczWogtAKyYjrQTSDbrNvDvutJzlK/MdkS7fQtCz
         A1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHYQvuzOyE9GbLQmU/I4ovw+eWtDKrH9vuWOjZHD7j6mnU2zZ3LZoMThwKzL0OK9Sl0p2NmbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPE/7adep5A/PrE+MZi9AgnlEvMu6YDI5fwBNfc1H5oayA4YUf
	uKihV8DxW8LR9fEgSI/qZFAluc15gRRAykbFQND7VJfyloxKxTSNqxWwwwBtpmFFEiWzn89lutR
	1Fc6y
X-Gm-Gg: ASbGncu7vwhOhvOTGjqTjqxuQHv440z8c95y8CrPIIqta3VcFjrnjz2N7A+kf3Eq80T
	T2JDamEk1Qd/FvJBB9TODtWW6GvSfGXbTnCeWtu/dDrZLaS32+2N4uKyd2gaFobUaIT4rJSoWXY
	FNw0iaFceXnyaM8FuujrWk0DKySBg0gII7ppW++QyoRg/cDbYsh7dJ6f7f6i+O6J9Z9mtfzwW4N
	fiAK5VjKck0DKbGiqs4xXZVwa9/c32Fw0zodYhlrF1UnR7LM6oaxLhHMtoBFKlS5hE9SQcHxd9S
	/t6KHdmjGzlRjISRLVvkxDM9lC9kO+1/5galDM+UL73GWCtYmfbfqAGbhqHYtvjQuf1ZSdPU3Q8
	UwBzL+AjhOUOKK9UHBnGWcB3jAC3Oc5UsV2JflWTF+66lEPlxhyhw6k7xVKJXfQ7/l12SlK1t1g
	==
X-Google-Smtp-Source: AGHT+IH0r1cHcYhclN+lddpFSTpYRQm37SvwBdJsO9ETQMGuuRIVJvR1BxyxAyy4GGcFpYwjtQMFpQ==
X-Received: by 2002:a05:600c:3509:b0:477:da4:364c with SMTP id 5b1f17b1804b1-4771e316d15mr29213535e9.4.1761744712875;
        Wed, 29 Oct 2025 06:31:52 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e3b7cb9sm58273015e9.15.2025.10.29.06.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 06:31:51 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 29 Oct 2025 15:31:32 +0200
Subject: [PATCH v4 3/3] arm64: dts: qcom: x1e80100: Add missing TCSR ref
 clock to the DP PHYs
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-phy-qcom-edp-add-missing-refclk-v4-3-adb7f5c54fe4@linaro.org>
References: <20251029-phy-qcom-edp-add-missing-refclk-v4-0-adb7f5c54fe4@linaro.org>
In-Reply-To: <20251029-phy-qcom-edp-add-missing-refclk-v4-0-adb7f5c54fe4@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1834; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=KPHt1suJLdA9xJbwn2KTdFAVkwcQfxRACwyO17/eejI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBpAhc78Huk1DUxx69JKQSG5U4czu0+QGuk2fxft
 ec98SugJk2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaQIXOwAKCRAbX0TJAJUV
 Vm/+D/9CM974LmK6eWlkBPTFJajwpYn6wuv7c739h4bugBgRVu0GzJ30jM6vHpkuKcg3VwGflxw
 qDNk31xmb15SwWqmZc+iFO5SRgKTbq25gECsaHWDJ8ErmxvR/NNKL5WkLE2XkgfLGqr2xsSijob
 NFsToK94sSWO+86qgY8VTmvOwV0R5Uxm29EZG/4cBOPKleO0jmIh9HAlXfoPKI0w5S4x2zSoStm
 OTTFCp+sMFVYoZwdYq35GCiVom/y14FwUregArwG+Sq63JRy7r8xiWTg8XiKi7JmAcKfERiIA0e
 P7jpf6jT3sOjVMjv2J7Z8/nYAMdqUg1zq9eJlTGGlKnE1pPvz3PDvVBwscjJh6OhY1umkI7nwaP
 xnTGCAJZ7V20qXf1kuccr/gNkRpJk/5xm5+ZywkYuMW3h/J1qlOUNx0bAZfa6AZfVI8AdyxOjlP
 kNzjhzlIvZFKSH26uKHmoTcwYp2MKqkpHHq3/eQIrqpjb2tpgKU2slJJFfdu4FYNarVrVRXq/ad
 7xTkEJfPUt5NGMAZmX2dqg1lm8tDg3KxRuYipdxii7RfY+OKcjYAcPpxYIrf/MmsDZ9vusThXJH
 oo/0C+OQ65NUi38EqEnlPl1IXa9FSZ5GLSrilhN+83R5Zm/GPN75Xn7lPsiDUaU22mOmwhJ2oga
 0k7P0GxytieUtEg==
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
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index a17900eacb20396a9792efcfcd6ce6dd877435d1..59603616a3c229c69467c41e6043c63daa62b46b 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -5896,9 +5896,11 @@ mdss_dp2_phy: phy@aec2a00 {
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
 
@@ -5916,9 +5918,11 @@ mdss_dp3_phy: phy@aec5a00 {
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



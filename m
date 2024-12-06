Return-Path: <stable+bounces-99920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 308369E743B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E161528265E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E8D20E31A;
	Fri,  6 Dec 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ew4vvDAZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9D620E022
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499184; cv=none; b=luFfvwUfDQIH8pVC5XTVI9oBZ+W6U8XhlOOw963uX1uTuc8CnW14hcy1lqNvapnDZCXbuxje4stDuu/7Ote5E/AuvFtuxLaduAuHx6EjbmOU8jXjw4X7hx2HZwJmOb8qWQlZmM2ifb/tfiK1rCC70I6MfM5Awzbsqjc2ZzGXc7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499184; c=relaxed/simple;
	bh=wGJs/hCgvCfg4tPxqhTQVJCx5xKl6MYukEo2gMI2JOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hlx+S0dzJT1zfEzWcVat2yCPT1/3Ut+PUDXPRn1XTLw5ja0Cvp1FIAJl1w1IkFEuQtceHoF3btI34mIVZfK4ZsBkxiSs3c7D/cZ9ZZbpHFD/F6DbJ1nvI/jGdtyLKmciHBrLcDdtLTvb7N2PT97+Q0wSJSbMiAfBRF/VedmVh7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ew4vvDAZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434975a1fb1so1641585e9.0
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499181; x=1734103981; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=scjyqPvfEwyYnHKcOKZj+usRHidKmUR9PWZzzmumLP8=;
        b=ew4vvDAZU88uAsZHAV8MLXwB973lgWF8zwO+z9dNLTiemUH3YzMn9SFyWcT2STu+Xr
         23psCon2EqSJyKSHKdEd1F2nPFfrhsQaD/dNiUw5jjRPaEj0j8bt9AyIJdWqR8OVdbto
         v7+JzNJyDx9JwTcLmdfXxVYsmtUi4CqG2g9uHhOYIa4w1x+ATj7H/mVpigwd6tASWHvb
         8ToHMRTP8oAIkBoVbpg7fKenabWxjvzhscgMyCHG41664apgpkQ7YKUQR53KE8DvxZ8V
         oLSJs8iJ56wXvphfqSUsxmfXEeWBMlcneUl5ZyqsiinX/y34Cdnd59P6Gg0BRsX+T8ig
         aqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499181; x=1734103981;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=scjyqPvfEwyYnHKcOKZj+usRHidKmUR9PWZzzmumLP8=;
        b=RMA9qTYCAudOxVQsaFxaCaFltCw/G5756fZ46Ve2jomJGlHtiTaVy5AVgn4jfjcd4M
         xzzoXAWXgZGiRLE+QwDFRZONrzcCLeQlBcgHs49+Xl2wCo8CFLDUkXcCbIedTD6TRgwA
         NpYF3ZfKti+gPmQLOhsii1sT4aGEFhmqhM3iGYphUwr8rwoT6aB+Ke4oUVHJ3nYrOnvf
         D6z4c5iozjVkbe9DNu9RJNjX9YQEYfrakd8Rritnnn6QLC3q8/LQMzj8ZOyixXWoV568
         QAaSHmIdxraA3jTcJX0zVy+SRJm3P0aBIep3mTNU8LEFDcOFygqUK1X8n39KMU7IRCgz
         CB7w==
X-Forwarded-Encrypted: i=1; AJvYcCWHMm9QO9ZcTwU3FBddFvERyGmu6uez11pqJMOuCSRUTdEWN9wIm3F5ZxU/QhRwCv0kZAnjdj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJNxZF6Rd5zxcp/sIDN2ilL9jGy9aA321G6dv/RjIV5w5x/ful
	toUVqFzz9D+2wIvv2P7aiMdvR3CjcH1dlH+2BnkPceJjPwYdnpUKZ1B7G8YNWuw=
X-Gm-Gg: ASbGncu/MIsfM2iuvg2QTjxzitkiWD2q8jl5onujD6ul8XO26Ix5Q+HqxwkT2n4TTMb
	TzYORi+q2EGQK/6NUSDWa4ovWu/fFSr0D9uacPOPZSgfQyPt7WoZcK0tWQMhR6naWBHpvGc+tc+
	BzJqCHOVLcDk96UnJGaof8rqD8i2kwbpteyiZCFu+WutJ1z5kqxqZbpHlkRBOosWeAPx3yFMXGp
	tbJJTA3VY2o08/tI4tGwmJAfsDZ7/up58vghBxueyC7Y0WDSS1m86d7a03lh+bDjQ==
X-Google-Smtp-Source: AGHT+IHILBeWRHwkDA17u+4MRyoG92Fr9Qvb08+lPm19d2dTJXAT6qJi3ewM+7kEyqmMIGCLJqWHSg==
X-Received: by 2002:a05:600c:1393:b0:430:52ec:1e2a with SMTP id 5b1f17b1804b1-434dded5a3bmr12438535e9.7.1733499180663;
        Fri, 06 Dec 2024 07:33:00 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm61158035e9.29.2024.12.06.07.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:33:00 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 06 Dec 2024 16:32:30 +0100
Subject: [PATCH 06/19] arm64: dts: qcom: sm8450: Fix MPSS memory length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-dts-qcom-cdsp-mpss-base-address-v1-6-2f349e4d5a63@linaro.org>
References: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
In-Reply-To: <20241206-dts-qcom-cdsp-mpss-base-address-v1-0-2f349e4d5a63@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=wGJs/hCgvCfg4tPxqhTQVJCx5xKl6MYukEo2gMI2JOc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnUxkSAiZZ/djyD3ojNevVX5dvjku8nb3JP6jMK
 XSqJxpAPryJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1MZEgAKCRDBN2bmhouD
 11vtD/4pjoutspeu27zGNtPOzJRYXILv2CNUQ8GsEAuB5iEI5uCEu8B/96cQPuk8LkSvY6CFRDk
 s5WqQZXJMjLVpsmCBJpGvfTMXbBjeSgFZx5AJwM8SdnCXLo2HLMIirYX/nhvylabsXbh5+XipVQ
 TYRCjQXgYyxLt71CFaB85Okkf4uZ/yyK3Bxg5C1aT9/JKki1SVC01wQKhp0BlVKHJ0yE/BONjbI
 gGGhMyOa+08SYwAfT3+5wutt3yVtsdsnxyD1givRz+6ivLkiKdIs690yzo4LFmNdga8yDAI6nDP
 fUbr2yPS8nZrRMNRrUvkbxQufH9U2cjGriD+iCobfp06KK8GaAAXF1nvX1VbcSeeZ43yEATZfXY
 6K8cPh/GXpmiIIJAMabq78jbE1nogUZUB2wJqBqt2qFe0X++s6YCbXEVd2TJbybTkWzl0LumUAZ
 e1EtV42skhjat6rljZsWRAm+Rc1qkm0Hmbvmb4bmWNIm540x+hB0bhGK+P2bt0+A+EiQ3SGjnnn
 GH2WkzodHhX6g3/DAdULZ9S+xCGY8lr4iCs3Mtu6wcB+ycqt28CLZe7MXGS7HIi/W6ffU220C/Z
 jkoqAzTPtsZlWdHckHsnbQOsCPHR9ZLTAlGzSyGHkQLNwX9RW1/7/UYRI4DxMmIsrwUOZ77nwgY
 CcM6qqLUojBzioA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x4040 was
copied from older DTS, but it grew since then.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 1172729576fb ("arm64: dts: qcom: sm8450: Add remoteproc enablers and instances")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 7a3bf847b0b9eae2094b0a8f48f6900a31b28ae4..6df110f3ec21dd8efe0bf5e93621b2cabb77fd17 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2907,7 +2907,7 @@ compute-cb@8 {
 
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sm8450-mpss-pas";
-			reg = <0x0 0x04080000 0x0 0x4040>;
+			reg = <0x0 0x04080000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



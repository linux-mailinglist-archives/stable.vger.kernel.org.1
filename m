Return-Path: <stable+bounces-104089-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB1A9F0FEB
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1147B162B29
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0411F03C5;
	Fri, 13 Dec 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vOxuW5yH"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1A1EF09A
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101690; cv=none; b=Q+hMGe5q4MavCaaq/JIsCED/OdIxPsCaM5nDzXqd/eRLNF/QblbHKXXlq88UtX/FH3BbqkJn4vpZFhf8XL0rsq39j2SLjk9RdvYObr77/vfMvog2swWWxXPYmH/Hi/AsAJC/hpgayJBfLPexzx8KagmcYTgYJZDrEW3VGRachNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101690; c=relaxed/simple;
	bh=7SBFgAew8JfeR0zbJ6uTquGaPm6FhiIBi50wes+3zko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TBMMoYaqu3sxQhziYXACXuMzbWzGPn+vAjHk3iKmZUA+vMr3dOu7bjPdE33pfGk8W3h01LjQlOcZyZbDiiCO0vUYhzO++LrtEqeIt0eZf1KodSXW4l/LnBAwrbgWXAKRGm6+cyncnR183NOGBUKi6Tf9CpxtQvY+d7ArScWoMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vOxuW5yH; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436246b1f9bso2334735e9.1
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101686; x=1734706486; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSOiaotFjrdX9Uak/7nrtVBsDX7lzAoKWyjlpUSUNaw=;
        b=vOxuW5yH0/eoZIx5s/IXFX3mSXGBIinUYjR4NWTwgc2zC4chZotQKuxnffG8M3wHco
         HE4G3ihFLz6uV6lCH91BIVnHB8PXTl05UwdZ55timPLoPLJqisC8vPy9dyjdLAukFFqL
         GXefX6TQqsKYWkeKbAWGM0Suu3/kFE/3cPoBt0Vu8x3S2Xg4y5n2vC/SWpw9x5sFUBVY
         t1xKMpVk4zzivDW3ibYI9h4JHwWixR58tXENcQ2PevHKbcF6CjQ3OLWPtbHOck2WuLq8
         DQ15vnn7RWXkhx+vh9Kg3n3pIXzq2PThVwdOl5u0RYEWbYrMkspZcVYobwVhejvWfScL
         VTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101686; x=1734706486;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSOiaotFjrdX9Uak/7nrtVBsDX7lzAoKWyjlpUSUNaw=;
        b=JVUrcIGei92FUX3Z35vWvRyiZqBd0iWMBGki6gGaVL9lj0KzomT6u5QjgdyY3P42PV
         ljvq7M2Ba4Nmgs+3G60Lu9A9HpMiiiZU3vMXKH2gJpFefwXGS5xDcCGTzKo41J6P/pxq
         N93xbauuFuYbKnvbQZ+xm87iiBNUjPw0teX8oi4FALW68fUjVZqpI0KueP7nWm6pmDTV
         ewrPcLjKhzcY/PY75tsIejjNfQ3+UTKwdHmaSitNjgzT9sY8D6FpBUhcCAhCecFRPO1R
         2UhLMSrmWMum/Na0vu6r/ThEgMztUeo/kNb/yC0zlu0CL2YmsDRDebl5d0jB5gk8ct2x
         Q8dg==
X-Forwarded-Encrypted: i=1; AJvYcCWyGXcXnfJ6heIEbNosi/R6RVT/11yBxA9Xs0cJoIa+14LiWjblBGqMslKYIoi8qrOTRneoNOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD8rpbd/NYHQO6uwAJenY3sJjWT+ZBEeC6IdPs+i3yxsme/PXT
	lATEbMK9LMZKir2Dxjb223jjdn6KwMpuvmOL0kRPaerFhG+WAkUPphWa4IaaDms=
X-Gm-Gg: ASbGncsbGB5pDSpBS9JMMTzbselUcCf27Ve6m43hk2yUvykflkURA9ODJW6asmUHobQ
	8KTGbKvKCB7+C4PVcG/8sFI1pCaYUHVgJvsEH9E0MW1iyeD0UZBgFXe9cVXIqT1H6rgum0bSzIt
	wW5XQ0SzsYKZLY0efF3OYSuXpm5aAXM+sLxS6jXgln3w7JN7FU18QPo8SbWjzDTGU3CJDyH9xC4
	AtHssSTZxSRzDd5vHz4oM4wo9iCjwgA3+cR4BZWuvne9giOb1+pWhEO6mAek6u9ph0RfXiG
X-Google-Smtp-Source: AGHT+IFUnK6Q/rSKuh82gn3vZeXSl3vtocbMSbcEhsEHsBmXL7Xg/qPzTgSvKurGo0EV0I8TTlUvYg==
X-Received: by 2002:a05:600c:1c1c:b0:42c:aeee:e603 with SMTP id 5b1f17b1804b1-4362aab2452mr9266575e9.7.1734101685647;
        Fri, 13 Dec 2024 06:54:45 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:45 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:54:03 +0100
Subject: [PATCH v3 14/23] arm64: dts: qcom: x1e80100: Fix CDSP memory
 length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-14-2e0036fccd8d@linaro.org>
References: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
In-Reply-To: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1378;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=7SBFgAew8JfeR0zbJ6uTquGaPm6FhiIBi50wes+3zko=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqTc6MupIsUbVqu6cpho/rtJp6UhXjtyEeLU
 Hppw3W6wDOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKkwAKCRDBN2bmhouD
 16lcD/0ezsAvVP5icQ1Ipg/Vj3u7cNr2ELf2mNmXElqjuR85AOdEjoGbcQhzjN5rzd2vD46MPtI
 /iWE1VTve0GPB2BfhqsRBMBARAc65fdpHdlVTcRVeIc2DL4CTjv485ue+xNVJj+aFnFsWCogP/G
 cU3O29oJH5xuuhZZSLmGN+/ZlalJBGuTlbTrp8YFmSWV60GOQwgFU5dQQAzNs5Cu7VBLq/G9wn2
 bGIH6RDa5sKhNWiNANaCBv1L/zPY+iQB1YGd1h+qxowYe4/UEYF9D+z0scmJ19D66E+g+Jx9ORU
 /9mjHttbqHcDiSbNMXhuuyM/ORLyHremhPm6e6ZHPvzMW90EEc5lZcQi5yoHgrhTPFgHWSQj7vD
 n4BR52laLeiTL/dlNIszAryWpPISiVOhkqSwpO8u6TiX6Gg07cL8fGkLAeROoFcnav33VGAjAko
 3YUUt+HL8Cma2BolnQuJLXKfvrLdQ3hmiL36SAAIZeEi1UXKdjKyxCxuxU69GDfF9/5OHGxKSYc
 srLFpWO5pgaHEUzUzK5T+/PsCgmtknRiLLRLGV4rWESsxMnLibibLig5LrU3RhFgz8o9zVP8KoB
 0/R4evTxIF6VNtUqCaiAU4FaaHqeK6ETOihjXGz33VUOKWW8UwxyT5Fgzo/nFjh2SNk+4MdoeeH
 8+x9jeOd00lEsEg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
copied from older DTS, but it does not look accurate at all.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 5f2a9cd4b104 ("arm64: dts: qcom: x1e80100: Add ADSP/CDSP remoteproc nodes")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 9df6903b5d59aadda26d9e0d4d9f951c5c3add7b..bc2187700ead2f368172040b23e1343cf0895012 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -6458,7 +6458,7 @@ system-cache-controller@25000000 {
 
 		remoteproc_cdsp: remoteproc@32300000 {
 			compatible = "qcom,x1e80100-cdsp-pas";
-			reg = <0 0x32300000 0 0x1400000>;
+			reg = <0x0 0x32300000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



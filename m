Return-Path: <stable+bounces-104092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76F959F0FF7
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D29165422
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE301F2391;
	Fri, 13 Dec 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qrzUf7pG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91AE1F12EE
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101694; cv=none; b=KPtdk9EIwmg+JeoSbqptmlZdDWnK/B8qLESB3rFU1aMVUcQ6MxDp8Ufw/dS/Rxw1WuSqVHXiYyRwEbn5X3xgpdhhV1p+6FsFdGxinSGO5mAkpxdNhsBKfFuKT3m2VwFOvnMTqR118kvqzXB9sUvbhNT1ek+EvPBX5HmtTq8jioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101694; c=relaxed/simple;
	bh=kkscAfqjZ1iO8Mt1cf8ePp07BRkZZiJewMrsa6+GGrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S+EyAC1y/V05VXPnJQfU+GBOfzxEMGxrF5R3aNKpGb8DjyBth2IU9GqWw0xWmZvrtlGmbEUfMLvRHGbDfiAnfl92Tu2tqWq90UYsz5yDFedbepkN/IA8QK8DfJ1japRk277XFobbJ3SQJVD1jroA12l3o8EEAeKkvKw1/EEU6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qrzUf7pG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4363298fff2so470315e9.3
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101690; x=1734706490; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BnGnc4auB4BfoL4yYa22p83zP4f8oOwWvOviDPs2/c=;
        b=qrzUf7pGmrNiRBWY38wzM9w2VTKc+fbSjGB3hEgdvmfPdmY8kr2J+otV6dVY89A5sf
         r9FhUmqcQ2e/5zs193zzOJmAeV8513Nw0N1+9mNgTdFkK8T87CG1sMFCodOZ4ESoAKrt
         HYA+hk2hgR98qsJyRDds9Ldz+vD85oxftB2X/kKtRdL8MS9tqr4zshsQXDRMr8ni6009
         4nm03gAVYM5sRknJDwuMm+rZB7FXalPNCJ+Itzy9CEsf+KB8UbfOIoHFfBdph5tmxOrR
         iczS55S/GZ4amPvUT1Z31FSZVkgr4ScfDV+EKuFOB/Zi0RYvTYtTOy0XQnpAT2YUKslZ
         zZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101690; x=1734706490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6BnGnc4auB4BfoL4yYa22p83zP4f8oOwWvOviDPs2/c=;
        b=Sm5ud/WjhN1sZJoSVjKhcwJMfOA7unA+LSv2mVV+qbVXzKunw2Vb7+FPmAZ+B27N/h
         PhXbAyakVqq+naCXDgAYW475PXPv7BT7cy0OLZqQk3xZdHpgBNjl+t6lsTJG+7ef10mY
         2wCJKXaxZ2o2315ZHloWvUbaI9MPaHTo+Pm/A7b1SP59zCVktUNeCss28U6nGQvwXJcL
         O4Y4bE7Jn+11uNBpIHKJXrCS3UoxdS5gyDXJhHhEdmOtGy+9HGuHra87f+85wl1hTVa3
         Z41zCodY4+o6PIW/oXaXxqZaXVDuthTfS+pfMSo8xoM0KYfSrWIBR98odjdTQV81UouA
         X8Ig==
X-Forwarded-Encrypted: i=1; AJvYcCX5XcYakSG7ODkUVsNvRaKKzO9XwB1Sq7fxg8J8cLsQ5IjMwGoA6B//tCwpQjX1tj8W+OgLKhQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3TdwA691uCT14SSsc9Lco1pfsR47ZhQ/pEWcQgrOnQ2eK3Gp
	uZmVouDp1vbmEy1hMX8PALukTY9NINjDv9+M8Z806iiKx5Fwi84c8/g8S8rFjOWMqd6sYtOT4n7
	b
X-Gm-Gg: ASbGncs8jzakml9aPGGleRCkgS/ZJ+2l+p3bWvbXCQ0qh89DhiE6PaXS4qNMUIfsADz
	IDQPk4r4ES8/n2xGbelQuy0Uws/oqawo74X4NTHRCka9iywRUA7xtoQWokyiElQ7tIixroQoJLe
	zXQp82Ql5Slhx10bbuBd4bCNpRYSoweNweq4LQr6hGa+TA+iVPXkKvk9e2gUvHXbMbACJ32citU
	djQppacniFgMYG7qt6tMqs0Pmi6wVgJ8yYLB9Dc1+HkL381hPKnLlXmMWNjTBT9ODyWMQXG
X-Google-Smtp-Source: AGHT+IF1IC2mqCjLc2vv19TUx2Amo9ZuLxvxJ7yfXZ0E3xlXoptqi7L7F3KE6+ShGn85/Dtt1ZR2XA==
X-Received: by 2002:a05:600c:35c6:b0:434:a30b:5433 with SMTP id 5b1f17b1804b1-4362aa9f021mr9601625e9.5.1734101690392;
        Fri, 13 Dec 2024 06:54:50 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:49 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:54:06 +0100
Subject: [PATCH RFT v3 17/23] arm64: dts: qcom: sm6375: Fix ADSP memory
 length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-17-2e0036fccd8d@linaro.org>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1182;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=kkscAfqjZ1iO8Mt1cf8ePp07BRkZZiJewMrsa6+GGrY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqW2AezEFpOTTUwnTymsNPVg/tLeNbmVkA7h
 V7I9hzceWyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKlgAKCRDBN2bmhouD
 19rdD/4u6ZehyIIUmESVu4qg25AgBZ4GArKdRsYDuvVfnk+UCEOgeiQ2QSBhi5W3Ky8spJfeu4A
 H1W8kIn+p/CQX1AuB1JMBIblDWn0TnvFwhEURJ+H2BMd1JfdPRTiPfFJp8UvNVezbXsisUcnx0n
 v93QSaFjEzUkp7YwOh2ENKfk4ijk06O4lX2nVHF1a4t9uIHXFBzVJ7pKnf3Cg5T2ZdGhBr2HZzf
 XoezfXE88WTH2mSZJX4FI5iC6ZUFdBprTlhxRC2BtbEISJWSw5Tb7O0gxacFAmnUlrkEIOQispd
 gpZ5Aeiv2INneCd6qq2eEjNZYClfK6Cuk1DfX8ZIWlYE5D1ZH3hDfFj/J5GBfF8ABoWKzrHEPxn
 clA832MJv0GWuzToy3N1bKk9J3KirF+u+YyXTyohCklcXgA6Ul8SubJ/bfOKMDUvuePke/OCBLp
 D+kLaMfHxVmzDZocooKfBnsrS1SSZfN20wsSWbTLlgTZgA2nKUqHVuX+CwD5XYOV/+sDmaR9GVj
 jXHhZBSJa/gLjjGD5qWHEbpdCgev2XCLNagZhNjqVR8XiusMN2y4OhU9FRlMIrvIyy6sHY1Z/E2
 4TkSqo0L7faw1n5O+tiTd7fLux4CUB163yAyA/jkh2t9V6VHOpiRja1vtl1FZWudWIwX5J/1wEd
 0xiEfXn4nAyaiNg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in ADSP (Peripheral Authentication Service) remoteproc
node should point to the QDSP PUB address space (QDSP6...SS_PUB) which
has a length of 0x10000.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: fe6fd26aeddf ("arm64: dts: qcom: sm6375: Add ADSP&CDSP")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index e0b1c54e98c0e8d244b5f658eaee2af5001c3855..613319021238a1fec44660cd9740a980edeb3f10 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1559,7 +1559,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 
 		remoteproc_adsp: remoteproc@a400000 {
 			compatible = "qcom,sm6375-adsp-pas";
-			reg = <0 0x0a400000 0 0x100>;
+			reg = <0 0x0a400000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 282 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



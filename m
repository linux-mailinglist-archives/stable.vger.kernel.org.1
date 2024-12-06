Return-Path: <stable+bounces-99925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C150E9E7453
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A91D282CCD
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3477020E712;
	Fri,  6 Dec 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wj4ycJP0"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3120FA9A
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499192; cv=none; b=AQKg/PkxsPR1FuwW3mFjRiEHeq6K9P4DHkzr9oPbiWm308J8OW/2TqxsQIUX+/lMl0Xbai6DGNUczvjsOqwa/BsORkiCwfCG+5XpyJu1CWzyLZlxto/lOm1BSXLxxT4+vmXnlPi0R8edEtHpbOm+O/UgRXsLnDwJqHL5ueiFJkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499192; c=relaxed/simple;
	bh=aJvlApAxgC7n6fKvQG7Bbnk+g8//tcpuElaE6FpNB/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eftiNEVQmyx1AOt+Q+OF5fQTmSKDtNU1wsSfqK+W0Tgz/oU/vRsTrkkZI9hwMTp9NuaFcMgVLHaBMWyBVySTuOpiahPxPq20w5culz0+w2S7UEaUPT/Ler2oYr3oUEkbiZcm2g7eg4CiZd2eHcTDB/KbAXt2+G7OGsqFqyVYXPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wj4ycJP0; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4349fe119a8so2668905e9.3
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499189; x=1734103989; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SiXVjdPcDiI8Sun+60i2CEF0JB9fBHrCBN1Nz3NvWAc=;
        b=wj4ycJP0Z/Wrg6yDR5MXUUBowfs4rY1qLW8qahodV/oeMz4K2fnaN2WX2ORi5Dc877
         waYY0cK+LqtgEaJMfnU0KEmsshp8S/rhGBriGTytBaRpgm0CIr0I0q0zN3YzzmGC9Cgn
         IucjiDNauXEpmYucmo7dW1s9b8eDRSgC05oBKR1FCO+k8DXxqoxzhfwsNCGD8uxUur2k
         YfQR9+Thp0oDk+Me6gR8w3FJw+nr+j8pglMCUKGYFpH81u9v0DOu0OQg3LP7s19F+pBh
         dI8lhWpgkQH3CjjWkNRgMcwjfJWqBBRft4fqZG0vjJ2bvkG+WRTeJHGeaqc+Cf/SOdpw
         fbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499189; x=1734103989;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SiXVjdPcDiI8Sun+60i2CEF0JB9fBHrCBN1Nz3NvWAc=;
        b=VpBeM1S6nPrApWETQ7Rw2gbCkE+H0KSv2mjRPNHnksZLmJgPZAMU1izK9Ab0aPRcW7
         GM/ckg8OGFlaLkbR1WdUtiUEiIhJHQTbh8AIsA6/KBvq8Md8XFl0j83fSpmQY8jwZ1wl
         0r3y5HRMnYnZJDblULw96hRG3lbAuMME6VybfYVts/UwHST5zFHrYiNXLPWOMwX6buZF
         0d7kJg0Kq60PR5jY7UAcrc1PI6sGHzjrMOUgGnfW5+TpLE4BztO5qoX5Tsox3v0aaDGI
         rNRHeb+r5cpVk3lqA75ObIAqB7V6IlI6G0PyDjWAZdqfk55bfXblI8b/W/FNiihA6Axt
         Tq4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXve+NLqJDlUssYrgqr9+DTvKM+zozs2KPpGCnYP6ucsNal3jWdtzrypr6QUXixxL5Oz/AyR5c=@vger.kernel.org
X-Gm-Message-State: AOJu0YztRVpeXiB/JJwxWUVIGcN+pwABP5/fAa14aM2r1avWiIk8TVEY
	oll9HRm4/V2Uq7MbMrrQl3JGGr4VXHMbcIm3NH14xDHjgEsGbacG3BLzZ+DRgQQ=
X-Gm-Gg: ASbGncuHwVzBPvm4AP8F3j0NoQpJo347xzM9ODyqo176UUSnfuK+nw9rjBlHS1CUcuf
	cuQ+2739WxHxVcYiKkoPZuRyikb+5Czv5niMDT4OI94/iH5vt7UmZUU+NjpdPgpllcfPTaXNtL8
	yJbxebD2GqplQ/ODfFMayKZO+YSU67v3T/VR+EU2yHKj6sk4C5cUNCc2aLWyGBuEmz0qu7M2e0+
	HGAAobqS8FKwTEwBlTdnVFjZSXleb8I3x2m0p1+ZOsGEpv+rLaijManS1n4IrNDiA==
X-Google-Smtp-Source: AGHT+IEZe8aXxGCrY2gNnm6cDB8H9PZKktAkpXhNjyACuxo5TEDA12WsDnf+Taj9+KclBqsdeMmG6A==
X-Received: by 2002:a05:600c:350a:b0:434:a0fd:95d0 with SMTP id 5b1f17b1804b1-434ddecfacbmr12741755e9.4.1733499189306;
        Fri, 06 Dec 2024 07:33:09 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm61158035e9.29.2024.12.06.07.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:33:08 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 06 Dec 2024 16:32:35 +0100
Subject: [PATCH PATCH RFT 11/19] arm64: dts: qcom: sm8650: Fix CDSP memory
 length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-dts-qcom-cdsp-mpss-base-address-v1-11-2f349e4d5a63@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=aJvlApAxgC7n6fKvQG7Bbnk+g8//tcpuElaE6FpNB/I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnUxkWZTBr4dqP65u78+QIGKWMRmfj1qvGAOyZ4
 D8cU6Nt4byJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1MZFgAKCRDBN2bmhouD
 14s+D/9ZRfIpi96l1xWom8PNZ4WFjunWJvNMEavGFOu/kd6p6mJFq2kHjn64bA9jng/Bn0FD4Oz
 BOtzIIKiLEvMOf45MjFB7YXDcPORVVQUJxDqg4hQe2hPlWdEkOKzUeaTRJiaSMAXwFZmRT6+gCc
 bAs0YOnQuK02Eo3mQ3lWM2ALzVEwgmRtNF5bX9/zy5/sYE/7LfS0HNhpqx4FEht0oYWgZLr2xrf
 lTtc8lU1lDopxWq9txvJqyuL+8/69JX3g8OBU9ca0dYl/tveUCrNN1GfAgLunRAjZMn7Fxw5utP
 jRmcmDaM3qB0hUlC/omVd5Q0Tfwidr4BcrzTW7hcz1Qvzwqa+4zjgY6IvuI8o3s0D7G4aKb4g48
 Jq3asRROwqXebLJNtgE6blpFM0dE69baXTimSaT0R3yrpWQlpwUFBk50rmk4Cp5n/DxBdc0fMIH
 7VCuhKOpYv68rGQ4HEanS5uAQY2Q9AFKdaGzuyIv1DKEulB9/sUybqyj6hyputZCDlkguEzJNRd
 IFOK+pAnooePcLw5KSCrYgLDQYRq1apgE+WlBFIzObucEmIq1YXoSJoRBzWyqVQWoAzsUjDJpXs
 rEJvTLu3vCdz/QEk2v8WLXiO44kRPvAAISnja19yjG6Jjv8J61T+vOiki5rAQ+K+UYuWG6fdSt5
 fLFJ3ucZaCWaicg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
copied from older DTS, but it does not look accurate at all.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 95ec82bce3162bce4a3da6122a41fee37118740e..1d935bcdcb2eee7b56e0a1f71c303a54d870e672 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5481,7 +5481,7 @@ nsp_noc: interconnect@320c0000 {
 
 		remoteproc_cdsp: remoteproc@32300000 {
 			compatible = "qcom,sm8650-cdsp-pas";
-			reg = <0 0x32300000 0 0x1400000>;
+			reg = <0x0 0x32300000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



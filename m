Return-Path: <stable+bounces-99932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8639E746A
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF94F283DF2
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E8B213258;
	Fri,  6 Dec 2024 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wBFygXz/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB3E212B3E
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499204; cv=none; b=UNbISS63GZF+T6OgfxA/uRrgA+69sWttiWDMxQhqhQnreU8T14Ul3Abpz4vNqFHhvzwm8MN/Wrp5nvXxeKHShycrx/tvzxH3KU/usytYCjj0Xy8GIoQtINCWHuvvs7Od2ecnl+kROygtnf1OVqIIqp53pmdvuokSvaLV7g092ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499204; c=relaxed/simple;
	bh=4XlWKfnmTuQGxdgudvxQgYEWyzNKQNtSzL8TC+5d//c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vi9vGIRCl/f2KnsVL24XzrjRQbfaJGzThAPsQEXzUJCrHkmYwFYiaEo4KFFLEXNHB8NNSr3Is97YFPTsqVGZrZTnF9h5gFHU3dFwFciDmtgRIaBVWt74M3p1TTJ86OKOGmuBAI2/VyLVsMlPg2lgWwcMaRP9+A7tf+YNxnuLL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wBFygXz/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4349fe119a8so2669055e9.3
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499201; x=1734104001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iO10RQLOSphsKOuYcR9GWLEZ5zCmIXSgPjuSN5APqZ4=;
        b=wBFygXz/jvbxwTDR7Ip98YAZc98kRNMf398aLx9cXcYrcYZeRXHoMWKh3lMOGnIHdP
         gBEQNM1TTQsVoY3tysT/W50bPlDXV9XzuVDvq+XnRbfZSLLoWw6swq3fTpoUjhFrEvrR
         hJ0BiEVVw6cmaSs9fHo2wgfM1+SQXChv9dG5YuxfzjBfJK1Fyvfs7Exu9rphBc5GTtFY
         +DZXchrjl67MSjKDoJ2F1hBJJ4MfIso+pfgOepDg34moREW+hiHJ2RYUPaBfkUbHDBM+
         rjUJjq9hoNvw0JquXTgQ+zSSpVRWn7hw/lF0Z3gDv7SQPeK5WR3pSyXdlrhP3o5rL5p0
         qVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499201; x=1734104001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iO10RQLOSphsKOuYcR9GWLEZ5zCmIXSgPjuSN5APqZ4=;
        b=FKaNGbp+LuIuIJOlatbNB5zfYkwE2plNP7Ss5kP+McFe24nEM3E9KxoGql+uUS0kv7
         9dF2UUzSbwJmxgtGQnSYkNT2iKxC+UF5a9VEwozUv+gHxlBRxD9Hx1L1ejIhkIxdoG6G
         w1AJvzZYFtHmV0bov5NwPJ8IBmZOE9Vx2nS6Q+Ng8ApcA28p5nRvMeXp2CmD8eIH3/D8
         RNmuxd63o8d1fkqlqPqT/ztK5YRjGCsKpt96TKwKH4m58Fs6LgIeU7AcKd/JAVmxBO6g
         Hg7OaofkneGfn/PzwJcWTIPAWYdEW5DyEXa0I8/2a/gF6gWH+QCy7yylNfow8WOEba9z
         070Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCj4wfNZRWKHjOCXYTO0sFUr+3PcJGqlX+Fo83P4RDarhH6Cznjy2cNhLN9iisyDnKJ+viCH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPYv1yaljs3Q7sjq/5W9DG0FwP+jibtkKMcEuFbvT8EwmokNTs
	sk4eBI4B3+EtHg9jtcIihBudBFmbP5FFRrs4ZpWkUL12M4Uf7PNIdgH3cCf5C+8=
X-Gm-Gg: ASbGncvEoENFfnjzJg9Rk1ziW1ZoQvvVv+AMgUzg8795Jm+NXDIhVnRjOP/pu+2eKlS
	6p8e0GnHJtxZxqANl54Y3EoQOaJOm3bVX/jf0gG33qVQAGSrr25NziDuPF+LYaT3vTKNNKL19Jb
	PMH2H/v7bkpxKTMC9TQBLTXEKjR8vv2V+Rg+zXVOA4wocjVfFNuw13HB0E2HzL8rRsB+Df17GTq
	rSrZEjBouNQ6KDTARBY/RtnB3CXuDlzPtmccdEq//+IBAmDtZ1lzHM5dS8M0e1gZw==
X-Google-Smtp-Source: AGHT+IHHP/cGnPTTgRqF3TmnS5NBXarCpD4l3hpgDNb95920KuHdW5+XnU0eTIBCH4LDzmhb4uKNbg==
X-Received: by 2002:a05:600c:4e91:b0:431:4e33:98ae with SMTP id 5b1f17b1804b1-434ddecfb3emr12341595e9.5.1733499201044;
        Fri, 06 Dec 2024 07:33:21 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm61158035e9.29.2024.12.06.07.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:33:20 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 06 Dec 2024 16:32:42 +0100
Subject: [PATCH PATCH RFT 18/19] arm64: dts: qcom: sm6375: Fix CDSP memory
 base and length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-dts-qcom-cdsp-mpss-base-address-v1-18-2f349e4d5a63@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4XlWKfnmTuQGxdgudvxQgYEWyzNKQNtSzL8TC+5d//c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnUxkdmpoq2RKWT+Zqyyr+rCI5s4mJfXCTnHhXS
 CPiqqC3ZtWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1MZHQAKCRDBN2bmhouD
 1w3BEACUmFTC+LqVtxqEXZyZOTkhF54Qt6GHaRaP8goI8VSKo6/XiIjB/N+DEwlIEPdEejAq1mG
 MSq7/WuK0SilUNjSJQ0KFD8cLwp2eWmYADcHdmaBwT+KVbKzHs/fKeB7NR3681gq5CI1w5yM/Ba
 FMlSNRm6cdqPaAdkcEOPGysDPGEV/soBlNPdl4wGDWLf28z/z51GfAEkBEHPm5vDARntBdJefc7
 +xXDqA+9EMuHtAI5FQCBB6BmZWEgoetzRlaxnW1WYXOYwaOXQGVk1zV97NukTYVozeX+KwEPw+K
 328g0cDF4qSajP3DKXeu0F6D5VBySpYBTN4ynB7IIua9eb6D4SlFg9PaM+vSntKEYZRJMbqBIjV
 jx8ShusR7GXLz40QA/COS+ySm+gLz+m5XVfAcpbE70HutAN64MpAtTRGdbAOEb7mnHITzfzmtur
 LRjPrGyZLd6dv4CJsiVdhk3UCWoLOShnCFiyT0HV2nVLil8rFnNS1UnA62Acsk96Y4OOpJQxDpA
 I/EFFMWLbtfPI4sQKVWPmMG1yK0jGLyFoxqFGzcGE4f5vh/lBkThAvI0hVRN+mDioxuVLpA4OlZ
 upMiLf339OWriMie29KnT11jfW1D5eju2Xk9MmP8E3XAZRk2d54/7ZjFzs9fsvqhtX/PYQVDmNg
 g0zMm4jbg3Td87Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB): 0x0b30_0000 with length of 0x10000.

0x0b00_0000, value used so far, is the main region of CDSP.

Correct the base address and length, which should have no functional
impact on Linux users, because PAS loader does not use this address
space at all.

Fixes: fe6fd26aeddf ("arm64: dts: qcom: sm6375: Add ADSP&CDSP")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index 613319021238a1fec44660cd9740a980edeb3f10..bb6511cb451b1c45ed2669f208fe3ed00848b481 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1595,9 +1595,9 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 			};
 		};
 
-		remoteproc_cdsp: remoteproc@b000000 {
+		remoteproc_cdsp: remoteproc@b300000 {
 			compatible = "qcom,sm6375-cdsp-pas";
-			reg = <0x0 0x0b000000 0x0 0x100000>;
+			reg = <0x0 0x0b300000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 265 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



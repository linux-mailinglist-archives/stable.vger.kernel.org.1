Return-Path: <stable+bounces-104093-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C619F0FF6
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4FF281294
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C37E1F2C5C;
	Fri, 13 Dec 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJS+INke"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E961F1319
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101695; cv=none; b=Vdo0Tp6/9SBzK6dALXcNj4+PE1m4cbGD1IBDxBR2aUmoYJsQu+x+hgC/5NahS54SvUJ7TwoBVf/oAqFGrwb/krWK7IOmemPKJa0rX1CxKr1m4iz2GQZMVJdoN66haWp4H16BEhxUObHra6QJ62sWDEYwZxRgkf1C3nna6uexsCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101695; c=relaxed/simple;
	bh=4XlWKfnmTuQGxdgudvxQgYEWyzNKQNtSzL8TC+5d//c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fs5Q+HP9p9mdQ0EqFaCse9OZlcFnpw7LUnqkIUlfKhs/osZTLKk44nMkfCBUkMSexJ/2KNKWbnERTEaG27yd8LCPqoh28VAngZeEjkuMDRUOOdltKdnV+vpbNIsZ4cN9Rs5rdGgPmy9tI43wTG2ghNfmMjlMa5G3Gr383G4wPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aJS+INke; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4361e82e3c3so2344905e9.0
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101692; x=1734706492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iO10RQLOSphsKOuYcR9GWLEZ5zCmIXSgPjuSN5APqZ4=;
        b=aJS+INkeWk0VpMd4rV9JoJ5EtzIZ0alQbAI4u5Br7zX95KAnaWghmW+cRZkmvcdVVL
         mpCQXel8p1hM2qVF9Zgmua2Yw7Pfj2wpZgoTZtfOqx+pbIwvy0sTLmnEE+MziadG//Qs
         k8EzM+prDcy35HTyJJblhaPJDZ61Rhw59xSm1wnc/K92dvUeDqmCvEUFZRPqu5mqdYzm
         rY35+owAtfSpnmn/tRO3AShVL6nareRMeK6lhl0wHp289VJPXzYwtZNgNW73I0Y9yLI2
         9nZcCeNeG0p6BtPwwiNuvh3iVCl3QiW+Fg9SWm1NIxY4GBC3JG+YGCyPvtnuFPuBrjOc
         SEag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101692; x=1734706492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iO10RQLOSphsKOuYcR9GWLEZ5zCmIXSgPjuSN5APqZ4=;
        b=RAS/gLt7VuTB0NJejKibdGqPFSvH10HkXGtxTtTl25p8/xWNj/Tr3iPp2isNNXJCJl
         PniE2WIt2PTSJEgxAijgjyxf1/ogNSFctgR8gx6ux+VoFEYO9vyjKt7u7/19e0qQuyxs
         Z1iw0iFcXVJ8aCkaaqpWOV4Dtm61tJcWUNyOsSFCRbm0OouI+Z7tfUs0nnIL6qZtuApz
         f0BmuEtd9oL4bbamjLmt7euDRk4cbozxiBvy62G7aA0ssmE++d1AbqaiHuh3AjdEFJ+P
         jWTVGxTvi7lmYVdAmvAHgqSucyB0THstEHoHwR+UMNPvtXiEKlodvJkQ8wDahN8a21/y
         mr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUcc56dw1TA/D4jtD1qrFDQ7OxapDqNffxjmdAVFMhaImNjyZ8UySRdXIerJnfddhLZ+CQSwAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXR3Q6HDKv7B0SMMeSDNL6c7cKJa/q6n19DuGT/ueFc4rJonR
	HydgWbWS9HCo6upYd+HbdietDLMBJG5pIcvDM2W8icplJhsQhF+V/ACaNF/kioQ=
X-Gm-Gg: ASbGncsAZimrPzJNOVgCVVGsIpAfPwTz01z8QaNZDkJGhnWDHtrY7C73vLcuzN88B8s
	zm+rVE2DhZT+0rDzBsqhqHKQS7DAfO/79FNXqltXLNqn4g4KgHCMco/1LbVEy/MI8lSvh9Zl73U
	hQGkVCifVo+kU3nxUTU9Iqpu2Uts/D+kQZfP0mn/cW2PzNHRZQtj1GLQOnLHcjLtHVcyDsF/u0a
	NjiUEYNBmdcIvBXsxHzBYT0T4cmxw2bPP+il1TW2E2V4pmOcND2Bihddqp9uC+cM2exY2tS
X-Google-Smtp-Source: AGHT+IFkbSFYO2tVIHGBhWsmKJwrpbF1iONLkfAHBKHALsaJ9F+2v5aak2onv6WRegZrdIFRTiXJ/w==
X-Received: by 2002:a05:600c:3b88:b0:436:1902:23b5 with SMTP id 5b1f17b1804b1-4362aaa6c13mr8919775e9.4.1734101691888;
        Fri, 13 Dec 2024 06:54:51 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:51 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:54:07 +0100
Subject: [PATCH RFT v3 18/23] arm64: dts: qcom: sm6375: Fix CDSP memory
 base and length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-18-2e0036fccd8d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1366;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=4XlWKfnmTuQGxdgudvxQgYEWyzNKQNtSzL8TC+5d//c=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqXAe7QiuUxwnp8Xq0Cx8DNlbmLHHJs4DlFq
 z56lnUcBE2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKlwAKCRDBN2bmhouD
 1/1WD/0bApfHPfJtZWmqEVIefN4S6IDWERep/K6tH5g00/vHu9lndzrNZ3ZI2+fsXJrryYXZoBs
 jk3PlhtbG/mQ0yXIOHuXkbopdQSqqkRrIqSlknhSB6Z8NqLwITQfrvqQ6Q+zE7zuy3Zm4X1hsJp
 eMsHVQ1J2ALvoX78TfHxuvgxCwIF7JrjyEHFHaiFTkjFyiYhIjXTQXeF2nCtj1dRCeKGsMb4gTR
 SOaxTGFrpa8JjuZVITWd2QADOH8NBIgqC4ogDtHieZx1+gL+QulAIsf7l4N6ws/XQz8pPmr+wcY
 R4rGsO8rc4T0eIWb/Nvlppht/pR7/Zw3TN9/59jxZwXD8iAGXmk0Ez4YJ5jp/1hSLLNsxU7V3LQ
 7AoddbXRXE+3H03FLonOSWlnajE64V/iMRE24y5H+58xrXHni5WzAiN86AOObbB/vXofF9NN5cY
 JlBWiI6Z4kOw8EEPlYQdfyFMnVUsdEoJn9J5xlsTtx8B0uCHlDvAcFNmGax2KLJr07DuVAp9IU5
 0C4Qv2/B/8fHfV8vApLwraRp4GiYAj4VDvyJzf2sVZO7M1JLNrgve8mN3lFOVoKmsPYZzFaLlBQ
 a6WvC4ehtSQliUG0h1FMUOBLlPNBq0cXfBdhkV9InUUYw32H8vX/78I7ceNrj09blzPSFwGiP1G
 rLndnRS+l1hVIow==
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



Return-Path: <stable+bounces-104083-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E08B9F0FD2
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715B916544A
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6317D1E883A;
	Fri, 13 Dec 2024 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZjiRcWaM"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5AB1E5716
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101680; cv=none; b=T/+OmOyLrE+H5BwOF/lzM3uEuSPBLzMUx8nfEUQJPPKi+9xctQJlIiuflXzx6HlIIjdY/BZzEDErZGBd7kIGIMGArf3yzeyUUPhJwMZjlLtu8bDiHeq+wNESYrtMgug1MqlrEpRqUAXO0NUXYGhztWQCRb3uvhoSsuYX17RgxvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101680; c=relaxed/simple;
	bh=t1DYQrTH708HNfSqvTWYh3NTNjncX62oLPLPAgSDGUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pTrkRDt4gUQHwPdxLzF9JTGr6CTVkC7joDLV5HGzl1lHXNvMjo4CBlUjHB5xrUiw7/sQAhDmu2CIDKu2F0KpBKi6MdZ23tQ2ZOqkMj5EKuz1xQcUARBqi7dr7L1aSwR4xPOqQa3g9nAuNVo3SUA+Y+riG3ONf5KP1e/jjbI+7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZjiRcWaM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4361aa6e517so2064785e9.2
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101676; x=1734706476; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uhAQOwvh0yTBK2Iw1/ctnZm/eVjW6CA195nsjVVLwEM=;
        b=ZjiRcWaM9vv4F/jpeABIma6/dlIlMufoHgYfk+nEt2RslFdzxOF3qXf4X3BJ6YkzIl
         PivlRM8MqnJfta5ewko4doBIJ5mMQyxtpgknRHrrsR4VJaoZcBHoazQI6czOWg+RbWCp
         bLIeemLEZ462EUlHeRh2vQygVRxUSIJQDI3JhrjQ+U3Y7gVKFp/3/dXuWxNUojghR06Q
         aPGUugw53vZRmQC1ezLykii5cLfNk3NSygQO4HJVv/p5MHNWIFLId/bzkLsm1JZQuOmX
         ngt757+fPj46thI7rwpzl11PXh+c+Pq3m8whorOQi0P15MtVtYtxmfj1EB704ZW+EXT3
         KMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101676; x=1734706476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uhAQOwvh0yTBK2Iw1/ctnZm/eVjW6CA195nsjVVLwEM=;
        b=uGpCWcCGEj0E2+Q8vvtPQ2PBcQheyqtN5jJ6L53BvhG3q0XpVZNiYjYCZfz5rODRE+
         WBViB0A+f09ddsT5Z3e10OPqytcDY9MVIylo1LkibIHo6HiPaJcEm+/tNXZcrlLvdtlR
         g9VJ8VUkbPLM7f8mBhH9hLxx0tr4a054Fz90JRpKSGYfqoYLzkzDE2Evp7V+PA4+DdXy
         aCTFRo7WZmfoU4wIN4tC0do0FD+SEjNdcK2aN2TCo3geGiig4Rp9/ja7rEQmp9UsRJ+o
         BXUk+kZjBpUM7bUsynVRytaUSvwz9MTPYUpFlJvNP9I0MLRWThzenJQjbKT/JtNYNYb/
         +afw==
X-Forwarded-Encrypted: i=1; AJvYcCXKa4CzJWCYOAfOkZ5K71lOg9u235CrkGxIyjPiCCJwzvQzFsMYHeEkka2He/ejezm2yg7PGfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVjydpIiFWR7I6BTUeG8OrLFPOEqPyQy6Ew8+a+zPCUfTzRAvU
	MpVXjTi4X1lPRROVRIr6J4+bHAshROr6t7K8yUt04DAPom7N7vY5ePpfNw4xI34=
X-Gm-Gg: ASbGnctzBiSn7bOVTp55cJB848hHLnQ/47NEC1MoXN4sLmTH3N9S5MEOs4DIHOhOz6u
	7CTMT9LMsLUbIeVPCtrxsgAHLskLw2/X3yigQTyV/IizeHoesP6WABt7Ys9x9BoS2FZzNKMn8WZ
	rqdppJcGtHetyt/hAXLfOUg1/1aW74kl0zbmpqSkjBv5NjTIV9M5P/Ufr/ycwvnsCU7q/Gf6I4g
	iYHy2agi33GkWJUM6/ccIeyuDiFxn2t2gDjbB2qbT9kUts3Ie0Ngo0+qDv8QDqIAdxzYtC0
X-Google-Smtp-Source: AGHT+IHx/j2sBGSnRub+RaGUP2n+gCdzHV8EsieYpm/J/mv+nGk615H2fhvSSXX3qDge72y7X/UR3g==
X-Received: by 2002:a05:600c:358f:b0:436:17f4:9b3d with SMTP id 5b1f17b1804b1-4362aaa1c24mr8899805e9.4.1734101676494;
        Fri, 13 Dec 2024 06:54:36 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:36 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:53:57 +0100
Subject: [PATCH v3 08/23] arm64: dts: qcom: sm8550: Fix CDSP memory length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-8-2e0036fccd8d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=t1DYQrTH708HNfSqvTWYh3NTNjncX62oLPLPAgSDGUo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqO0uA+9RvgLDwsYaNZDK31gVU79LLlTQs28
 Z8uh81dAyuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKjgAKCRDBN2bmhouD
 1wB3EACE5pokcOACQ8Ys2jLKPvwaek3olyqL1lSuc457zMWt0znZsEPzI3lxVo6h1h7nQ5RcUYO
 CGJwi1K5xOcTvYMOPUP7msmjITiWBvPHf63G2HvBaUv+pp2eB3DTiC32i5ceGTx7k+ieNltHHSa
 BKNwfvQST2XksJz9D9WILzzEvQnD0vesNUIcy988003ivia5IN7ck6hrRhpzVkwCLJkcIapFVJU
 DrNYfDeRYTwXKQ6uJVN5arOTbfZ8cLSvLvshUKQyeXnQtIDWPk6bZsOai1UZtVpq3GFBwmeHoJh
 NeW3NPhKKSxuOru8W7VrsJxKu/q1y2/6pH8uITEON5F3XKvjAgUDAYbXiqANRCTNWbkW3fsLHn+
 lZ24JkIj9AD4/03aOmYha3SyTIvMDWgCR4z2KtnKXg3Vb8xYPovA4WoiBn/CF9daVz3mmdGQpza
 3Xtdh3Bmy/g6zhFDtXY9WdPbRmbe7osUF2ucvQOq4SLEGnEr46pscRRPuYhDwtSp7IovF2YhOAx
 zrl3MPR6dhvTW6r9axr1cnDWFko6dDSXqFVxaeI6PQ6LW4Nq7lSE9WViToJQ3r2BQWyeU5UhMMe
 GYG460f6YxFPMzd6tHWKF7dmICMY3vL+5kppKYUgYsmOkgW4Ln/KpJ1PLWwtAs2gRm6sYGt8GF7
 HQTCLLEPJ9toIOA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
copied from older DTS, but it does not look accurate at all.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: d0c061e366ed ("arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes")
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index f454015c5b90c7d792c01bf85256812857d79c64..541b88eb5f5300ef9e20220305ff638db9b2e46b 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -4716,7 +4716,7 @@ nsp_noc: interconnect@320c0000 {
 
 		remoteproc_cdsp: remoteproc@32300000 {
 			compatible = "qcom,sm8550-cdsp-pas";
-			reg = <0x0 0x32300000 0x0 0x1400000>;
+			reg = <0x0 0x32300000 0x0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



Return-Path: <stable+bounces-104097-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEAE9F1010
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 16:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2ED188831B
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E1F1F473A;
	Fri, 13 Dec 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CD3v4DTy"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897B91F4704
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101701; cv=none; b=q3vQtL0hXW3nIHDYr4/Qi1DGCuqV2nLyp0bK1lQoRYIkY72GjQgMtS0lNilrIKhUIHeas2Xs34Pg3xnb3SGUX5ydVdIY9ayMqH5Vy9SW4p1Jlx7XS6DoqUJBcUM1pCn/SzHIeMK1UtSyps7XQHHeZ0GoBGRx4V6kEwDgKGES2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101701; c=relaxed/simple;
	bh=OVs1pW8HXYviRDdBDJSdTxkf1pHhAXwfKakDLCDnDNo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bcSIYUmg0bQUHw8xfKXjeuK/7AkzHtYZAPBiv7W5x3tHOw7f3B3BeORtihTxilsS3+fyRg671XzBbrpf98miKy/XIWCfeYOxTxctnVQuI0gXNPaWdysc6S6npWtfY4+lFa/qGqDmqDbJFRNxgdkpHLL9ogdA6Gbrjc0bwY7eFy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CD3v4DTy; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-434f398a171so1477105e9.2
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101698; x=1734706498; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96fv6yQ6ADzYBHITZDeQe5lcsb7Ca6WUimdGVSH7r0w=;
        b=CD3v4DTyxL+goYQvwmZ3HRsPaT3HqAJUjq8bQHxURjMP5XSQCSEeMA7T5vid8lghBF
         GeGQLhwJnDtU6dAb1GCbWb72fi6DKy+qDDXV3lRgOFC7+xZoc3QRzpYHNG8KvunzoNHh
         MZ5rqBuA8MzXGN2mZm1QE3i/7sdPA0LCNsg2/1WFd9wqWAufStdMBK3lsGVK3RJk4gbK
         AuzUPWs9hHWrVjZLvdZxgD+zUaSAPG1DjxCVXXcmiHgxR18Jqb0m4BoymdP5GGhW/O/y
         oHDnmp1QMcYnExrcQyu4tLPBrypO5Yi2NDoZnsImOdtmBhAYpzs1dAu9d0Gz2hOSeNkz
         IW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101698; x=1734706498;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=96fv6yQ6ADzYBHITZDeQe5lcsb7Ca6WUimdGVSH7r0w=;
        b=EDjR1/iCw4F7IU54oWDbalskyNRiV+B+NkLqx0G7esGkLkRFq2/HEitnFiNwXq2J5G
         cGpyVQazO6qRc7HVYJAX8xiD1gY6sgNuyRbSN29Ekr3Bhx5hR/Qc3gd+HV9BlKLPhjYO
         bpp04gas5AxQ2xh8nLn+ukXe9GvLsGc8AcKNLZINoBaKkTHS+8Yb2z0tF1y3ZpjDcwOk
         EW4jsquu53q7wwsI1iEAOrpSLuS+hcFraRONX1667j1xS1Aik8r8HYzRlPZ5Y9KfRisN
         icHhdieQvfPD3Q3InpWo5i+o7rBys2DJtCcHfc/i3xzfn3IY+3wGjTP3Y22FWg3ymx4j
         RMxg==
X-Forwarded-Encrypted: i=1; AJvYcCXl/R5obMdHrFQsDlrsZrbdG5wm8d8uqghPY42GaKhDE/6CVUv/kae94ZbKmYjssxSdnqLLrQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMAdmpkMoAswb4Rqk1eFd8AIQJuQs+e8OC/K/PKlMTMHd3VlJC
	uTVkpJlPfvJEBRqAmwAHDwwVmop64J3Nzk7w1gbXkNg7lJ4ol3YhFTVXAYyS0JU=
X-Gm-Gg: ASbGncubWrPIAXYaqIdboSryy7IBLDvciBFGfbo+e+yEMrU8IA3YfqhglhkKhSXotx8
	tw59n59JYA/qIZq486C3NqY8zBuUD15yeSFdsjDESqjKt/yLTFeyRZSHFO3JQHWB8VPnHcHFPH/
	+6ZPr90Q6bPzw3RKGbgH4npHpyhUAIHwAqQJhDXePNNSo3am+s/tBs/DcMbnLNbARKjLsm0gAtl
	zjp0IWBo510H6HIAnMQjNIucQUU0RB+5MR7KsOVNlKuNXJ8LKpDr1c75DFttfyxu1JOqdSW
X-Google-Smtp-Source: AGHT+IG2xPKsjM9w1WZmh/gAbRxyawsIo/UGV1fOk7SQlhsXr4gjTxar9Jpmd4FGI/fiJj9PGZGJQQ==
X-Received: by 2002:a05:600c:3b02:b0:434:fecf:cb2f with SMTP id 5b1f17b1804b1-4362aa8faa0mr9500045e9.5.1734101697946;
        Fri, 13 Dec 2024 06:54:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:54:11 +0100
Subject: [PATCH v3 22/23] arm64: dts: qcom: sm6115: Fix CDSP memory length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-22-2e0036fccd8d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=OVs1pW8HXYviRDdBDJSdTxkf1pHhAXwfKakDLCDnDNo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqau2irMTS4H3C/8tmYk+b2vABvHbxCkkr0I
 wrBfzAkoraJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKmgAKCRDBN2bmhouD
 15uCD/9jLqFnQW1IHAyGy1GrL3aIR7QN4HnGWqB5NrChFTQauWdsDtSa/C0I1uw7dV1vhsGIZOB
 3M5ae49HWx+EkARS15/6RE7WPVtQ52G7px5zaXVu7eeRF+DYxRgBz0ngI66YXZaZxXKYEwaM60E
 k6EAhGHQUXtwJgW87najc5VWZWWV8G3DzQKa7FqeB+Cs64pHUd7RXncIcgSFGZH72KVVdDFYESs
 rLl6fy4v0csCXYE6y7CFu/8UWbGLLbRdD5DT+VUK/AmAhMzwEr9qSmHQozJe8sWLLjR7p00zMwr
 aVwIu/Hs6MPJQPtyPwtjbRy8K0IHNiu+lYJYZvwJIHtlDBrbBjSaoj4ZRi7Tw3VqkvP8yeo7yES
 gMfluXhfXJ6+qkChZmf0LfsUx3u9srqv6ztBd3UKn2sgdLKvYtjmGEDckUZm2X/4KKmXc4iJQ4D
 7S+uSXK6uKkb4sBa7o8ndi0GpPirOLz3yLgCN4XjFEwGfFw+q9kd693Epk7dqA+zgnZiwtcuQAY
 VgZLjEVGBbFK73eGKRgikhxWooVDyKuj9CAPJuQMIr5pAQSpaS6t9Rtv+6sr8WHu7LERkkpbzdj
 ymKX6p9wmLdxhOV7tEFweAf2A+X79p1gVJwpiC5p0Xbw2vOauMf1zAPylZE/mpbU8Pd7MmX+Nbk
 BHBuY87j985sx/A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in MPSS/Modem PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x4040.  Value of 0x100000 covers
entire Touring/CDSP memory block seems to big here.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Cc: stable@vger.kernel.org
Fixes: 96ce9227fdbc ("arm64: dts: qcom: sm6115: Add remoteproc nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v3:
New patch
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index e5ebe7c7e87fcb3ab87284a2ec8fe88567f6cd70..5af2c7a3f6ff67c216f1c817a3d5f54e10b65450 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -2744,7 +2744,7 @@ compute-cb@7 {
 
 		remoteproc_cdsp: remoteproc@b300000 {
 			compatible = "qcom,sm6115-cdsp-pas";
-			reg = <0x0 0x0b300000 0x0 0x100000>;
+			reg = <0x0 0x0b300000 0x0 0x4040>;
 
 			interrupts-extended = <&intc GIC_SPI 265 IRQ_TYPE_EDGE_RISING>,
 					      <&cdsp_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



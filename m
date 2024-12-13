Return-Path: <stable+bounces-104086-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FBA9F0FDC
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04CB282827
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCB51EE019;
	Fri, 13 Dec 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pmfVt2AX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EFB1EBA1C
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101684; cv=none; b=ghBlSVl0Bk7fGT66sZUR1j7E0C9dITqe1OhO09uLKnpMi3kKMr9maG1hwhK1TrEcizAwnPJFh/n9dh4XCiUHL7TvqULiVeAdC9tOj0Pik3ccoilXfqW+3aPm4MQbYL5H9r/v57fYKo5DF5i9YVjJDkqvQlMgd2lnofNNvJ80+Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101684; c=relaxed/simple;
	bh=0O3xLfdDmCTgCs90LWVeDRVLpMsgmI/a/nc1mL2oFb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K7bYio631nrSM1+r73F68Ca19d3Cy+rz+VvTowsdo/UAzvLLtXmU1aKiqgyvGEkmydQfcKZqY3FH9N4NXDmw+maUkC1gfIen0URty8/R+hm2S2nO/EjPmZl+ZyhgCpGsfQ8w7LcpARJtMOzqqOOKF4ztSyp3KvkqQedAcIi7InI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pmfVt2AX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43616bf3358so2062565e9.3
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101681; x=1734706481; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AnCWdwhIEptV5upb5oBw9vQuEE9es852QwJBMituxU=;
        b=pmfVt2AXvQEx+B8K8mNC8VX6ORAZ3qsC13x6xU5JGJtY0YEJKSv8QW/1aZOqQCGJQP
         i1d9OjGpjURGtKne51R1rPoqsSYE/Q+P2uromtAz3f2EOUzAFWiXHeep9A7T0/VmL06W
         WEGLefzwAWQ6F9Wur8Mug21rOO+XpoF5oXttUltON5f0qlE7UD7l9Mkd+apJluAxIVfW
         Bvfi3/XSx3Rwn5uyMw11nO6/vEIU/MOxBo8b7ddmSQ5KsBfp1rmKChxMyAU4jobRHxtj
         ap/1P8NC4G/zxXK8j5wUYCw/VSh1ah4dpmDlssud+SFHptCop0ds8t0xv2NqtjxK3T0Y
         Et3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101681; x=1734706481;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AnCWdwhIEptV5upb5oBw9vQuEE9es852QwJBMituxU=;
        b=bQ9HBxEE1j8RQd4+eD7z6p3C43sdHXUD+z27cPveziG4XZhjrc8LgMsm8QIiokqvzn
         bWSvlW+xdt91PhHvMqfxiMSU/cdUmuiH2mKeYHezKsOoPe6BD2mUy0Vg/BPZYe0+mAKS
         3KZhiv32SrkjdcT5Mmt7yLZLlq1xjkfvTRdS/JGohgwyJ9hQQi3wGJAcbyBSZQXDyRKM
         DiRVTTjaIhXhwr4enVYIkBdmoYcP/BLfJ4icpFqNyxemfCUrDWUfstdy4ivaeYqlkq4s
         Q1jAPag6WfT0Sr2008CACQ6KQ5q17JqMUEU2d7L8n6QaWmLxlSf98rFGbxMdy0dKETY7
         gYZw==
X-Forwarded-Encrypted: i=1; AJvYcCW4Fp6/+VFVu6YIcymjQ9R5kw+aoCRY6fIIXEEufFPc9oNQUSbjHDXOQVmIm5325yw061PdwK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwtYO9t8iH7aPsRpIntiFP2slmI0f2SLKoHbyXQmFkss81f1SI
	zzFrTTC6JuH9WPT7e/nz+BjkJsK0amKoyD88vyhshw8GbT6kl6n+xHuvr65wss8=
X-Gm-Gg: ASbGncsZ7GQhJoupWGwNWfx9XlofMQZkzjMLPWDAj6YcDmrF4OtRbVx0l5A6jmoF9XR
	1pkY6cBmgOP//mtBnujG99FLKFN9aHrktW1n9yN38WjOeVBD8CNqaLDH8noxOfmoi2EIIvfpqUe
	dNwfvNtQ9pG00QsxFpt5LMkA0Ut7kKSoNYf+DbEu8KRRpSaBe11rXYsgs+n4Z3vjC8IVW34DRc/
	G0LxljNZdFGEkOqiDyVpcelWyzb8/zcDq/fFJuVwIRgD0+tp6wqIxP+YFX2cvvcHj0fWqh5
X-Google-Smtp-Source: AGHT+IH9SBqwqXbTeuwO74WXN4VIPv0MNfZmE48ghiYCYmlomRQeMSzN/rQWIeOmaVuE5cnMQaXzjg==
X-Received: by 2002:a05:600c:1c82:b0:434:f537:f9c1 with SMTP id 5b1f17b1804b1-4362aab668emr9149425e9.9.1734101681072;
        Fri, 13 Dec 2024 06:54:41 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:54:00 +0100
Subject: [PATCH v3 11/23] arm64: dts: qcom: sm8650: Fix CDSP memory length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-11-2e0036fccd8d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=0O3xLfdDmCTgCs90LWVeDRVLpMsgmI/a/nc1mL2oFb4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqRIQHBj4k+PB2pollNNW3n+9bz3C6SCJPtj
 14PBFzheqmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKkQAKCRDBN2bmhouD
 10m5D/9iban3VZHLr6f05u6t4PGs2RpNULZ2eQwDIzTzjN4VyZ1VYOQPcS5nlG8TVxow49EOHQR
 iSG3D1XrHFluIYqCozT87rhDO3r3hSP2PM0V19ER0833Hg30u5GACMGTMqg+JD4VGqTpanPNIpQ
 7hhvRcssUl4+XO5WM3cjIOfAL+OkC799rfvqJlb1vP5uvJdfbWpubvnBUJhOnSbV0Pzm300qBvA
 pTiSLYnLPA1h5yVsGfALk+pCCfKlkJ9gnbnt2k53YGp4aKde1pFJje9fQdznWU4h86Prdho3bKP
 DmAQtHr30mGuSB756UTV7LaLWjAU7dSjI3+7/PdX2Ah6MjLTDHApnAbmeKGQmZtgPYaVK7OhwLR
 5r8zHeNM1RpOojbjC636ygVW+VNS0w+a9VjpHDsNCLheEOvqoZZ8vDn7B2Hb39RhR3Xs1GXiAhH
 WWYqi/kar1Xj0Ls6sudBirlqTrlfNn8zQ4mEx9exulT5zZ8gzG7YPeDFNRJjFZ7EIb8fqW4jO8R
 CVC2gQswOB5jlrOSWSMRy09/X6PZa6JOUE/AUDuwoxn+c7ME/xn2NeBizJjJ/0vbd0djDBahEFy
 XJYHuyTWvfwWEJLxLyixDQWoYgWLTs/cRIwRjMl5a5pQoPTXoeCvPF+s7rTlaY7mWoC6YOpRu0I
 gG4bd12tIiV38Zg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
copied from older DTS, but it does not look accurate at all.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 10e024671295 ("arm64: dts: qcom: sm8650: add interconnect dependent device nodes")
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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



Return-Path: <stable+bounces-100139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0659E9162
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E961886001
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F198C21A95B;
	Mon,  9 Dec 2024 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBj4L7Qp"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8913B21A958
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 11:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742161; cv=none; b=B99F4ztxm7B1PWUIP1j8kMjZan/tPLJDIk+3cxVQrNTRh97WGDHkJULhms3LSJXSQsmbordvnkxYYWWYWHo+WfJ4CirjRxWYvjNxmpR4TBvp1N0hzDqHMQjywzoeY+81Q2kdUJ+tqyogbHWjhYzwuyo3FBYcXnpKyQM8D/jcc9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742161; c=relaxed/simple;
	bh=XAEiKnCO1r1d3Rt38gaJyxFTDUYuD0/ITOVOdeMu+YQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7Sx5w/EdsyK6wHJMEyrnBRq03ePHQz/das/IQAAko09YJn2sgEIEDHq50uGm5LY0iqpuj4+KvbikgMDb3Kpg680nT772kaG0nM9Xo91XoYKRsBc/mfUzvo7CmZPsDR7trAGtmct/kCD9u7gyXOGb+PG1I3lWVXwvJIbUVoJwRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MBj4L7Qp; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d0b85c5574so435098a12.2
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 03:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733742158; x=1734346958; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIBR65NQgnFdG5+Wr1oGSIxsxM3LOWc73QgneL07cmA=;
        b=MBj4L7QpvchthVgiH4sfMpbOXUYmRB0rRzulT5noNr0VBg+wi/y/vElQo3DMNX36j0
         t+iFG/A+2mPPbUPOAFFasKeFOOU4C7Wao1UG1W2sEmTTZ/dM+I9ywONiwqiknyKtanGL
         Rk8BRrCMgFqQ904pAWSGvGZ6FNqBoeN54YQ97xyF/aK5es/sBNpBmL+8Ol2xdbxUkIGc
         oS2u2stZEEzqOuo2g0GY0HjpPzXIDhw2/dTRYXyWsMyeM0jQLF2PxCw+H0tQH0io91VY
         mA+9a2bYvxefqcu/JGepsmAMwhCF0/3oXSzNa3UxYMFkrDBsUaz67VC4IfWE3qbW5uYG
         DQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742158; x=1734346958;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIBR65NQgnFdG5+Wr1oGSIxsxM3LOWc73QgneL07cmA=;
        b=vAvIidLyg2aoUClY91Yw+NmrLAbxCv3z33UB5fkCxj9y58j3V9nr1sAoQddtA09PK4
         d0jbwIPcFAzkMDhpUcNgA4QrapxDnK1/GOYe0Agz452NjZlblG1tQXYYtD0jUW2mH15o
         CvRi7qAV69P+El0w3lqN6Qb9P31XdkGTkl3bGPr1pQrEF6bYeojEzbYTBh+tbPJgi0RB
         58z+XfiVxOKvw1naLuAcJJ1UddyXqntedi3TWaDjZJ8vjEvvOkDz+hVv3+XlA3318Z0a
         azZP1IFYCf531AxpCmm5D0C+CDhE7oi3ZcBrLbHMDL7wiwniZJUfZrPBwEAtWg1vi2lc
         tPAA==
X-Forwarded-Encrypted: i=1; AJvYcCXMA8lH8WvVqMv93yJ37qFLBF+NhpTb7hW2V9sblmiGcC1i4I778PVgi12k9hJfgrQATc29YpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeKH8lqTheUTi32rZzANiZl8fgagh2sHokt2PgtZINTObq9/Lj
	0yvNxdd5DROZVZXNO3Ic+pEfb8VPNRAwdF/zj+TkAIAbswJ6Iw1Vxvp46KMFSGM=
X-Gm-Gg: ASbGncvY2Ilp2XCTeZ8b34/NHQ+IlL2alyaC9B1gaw8D4Hcf4JGB7uc66SLVDFGDLgV
	P8l0V2A05let5t4mkeljdYVhaq33a9dBmK5/WxqRMUXzgFW6xwI25H7bvz75g0hdwBrDg1qAkZ3
	UsA/LoLJjYPsXhvwHHc3Okcd0M0yTmK+O+a0yvG2a6RwDZJ051DFEGh0pOcReGn8LgWOvKZZE39
	+sMoh4ii+qgNN6LkI4fWGhxpJQJvodRkgZ8YCI6rVt/H7T/G5/T6WGXnYsAyKUkPg==
X-Google-Smtp-Source: AGHT+IHAdSvGUMJ6WzNylQo7YE1SQHxO9I1C8GmPvQQClOmUWgSyK2GKzRFMICqjXdmANW1pTx5cVQ==
X-Received: by 2002:a05:6402:51cb:b0:5d2:727d:dc04 with SMTP id 4fb4d7f45d1cf-5d3be79f1bdmr4493603a12.8.1733742157853;
        Mon, 09 Dec 2024 03:02:37 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dd4f641bsm3348818a12.51.2024.12.09.03.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:02:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 12:02:10 +0100
Subject: [PATCH v2 05/19] arm64: dts: qcom: sm8450: Fix CDSP memory length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-dts-qcom-cdsp-mpss-base-address-v2-5-d85a3bd5cced@linaro.org>
References: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
In-Reply-To: <20241209-dts-qcom-cdsp-mpss-base-address-v2-0-d85a3bd5cced@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1353;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=XAEiKnCO1r1d3Rt38gaJyxFTDUYuD0/ITOVOdeMu+YQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVs40pheQLD7ikDweDTuPirbb9rI+zxFhT77oG
 U+0nQQYy5mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bONAAKCRDBN2bmhouD
 1+UHEACJoZZJ8e2ORkVLjDW2jP7bDhCV3z4+8ldDPOn6oc15bIK9NG/V9XqCN30rPpgtGxeq6mJ
 B0jQYDj2HgSV29a/9jhqumoB40EDYMsn/NABLTOLcgaFttSKRozpK8rjXI8qKMSNUDrvN65gyA8
 x+8d7XB6dNmfqOdRAnLcN1cxS1HCm42Q32GLi79KVIWulg7mR1KrF0myPO8j1eUTBV8iST1WgEq
 o6fqW1/7IU3lthdWnOWQP3f9TrIaIDTIW0eQarDajXxbzpxo+wgr9fL1go3BlplS/JFWgMnT0lh
 +t4KCZdzSlX7C2nWZokQNDDc5OCa7KVYb6OxgZ/LIdNOb4cUMepEP7Y3DB3H4MI6CovyWEHYG9s
 iQ259EAin877F66dm+9lSPvZP47MXrCoHIdRjfnhz2+lvLQrNb+EA1Waq4UY9BPCqyNlJSDZtYi
 QuKWw0rGtTmEhXpMFaPeYosEnerCEZ6E1W9YOBg6Z0dsUsEzCKzvMjLnJ9XR7VOaxKf6ya6Wu4A
 SQnJPFmccwMPAjRY5sqzby77HfZvsy/vIkyv+/jlHK0aKFC0VsopHRvTAWf55njp3RDgDbBvXZL
 5Fh8EmPX/9Z2u4d8X7lkG1fqIqskhomKWkLwVn73GdsZPa5BiwA4IFT8zhKMs5QMUWKvWBmBm4L
 ne78++J5LtiUx+g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
copied from older DTS, but it does not look accurate at all.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 1172729576fb ("arm64: dts: qcom: sm8450: Add remoteproc enablers and instances")
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index d028079c11bdc2dd2b254f7f7d85e315a86f79bc..7a3bf847b0b9eae2094b0a8f48f6900a31b28ae4 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2800,7 +2800,7 @@ vamacro: codec@33f0000 {
 
 		remoteproc_cdsp: remoteproc@32300000 {
 			compatible = "qcom,sm8450-cdsp-pas";
-			reg = <0 0x32300000 0 0x1400000>;
+			reg = <0 0x32300000 0 0x10000>;
 
 			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
 					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,

-- 
2.43.0



Return-Path: <stable+bounces-100147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EBB9E9181
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EEFE16500D
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7312D221DBC;
	Mon,  9 Dec 2024 11:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUvVrH4i"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BBF221D9D
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 11:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742178; cv=none; b=mW5zxat5tjIQp4KU3Ug03mvfwUnDDcF+5WBtmzSRYnxbA3AyaXQqLnpc4KVNk7DyfbzSbeZiJSQ4ym/Ucky4OvSPImm4MkARTEAekR1yjqo8OzKhsLQxLofsI9Q54N4O+Ka4y/4PZK/Sir0aa9LnZ4ocnX/omsUo7lg4zRRD2ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742178; c=relaxed/simple;
	bh=NfgQA/XgYVV5OKpmwdBaDSEA9tYYVgnK+RFM1b7SHis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cRbOGc191IteS9G4Ydn1UeFV4DTvWEPM/0t5ScgoSqnSE2jh7O7l3nHHK01pfvLH6+G+Wkkl8shoKjJeeGDlFcmB2sfZuakxaON8upU+V/g1zivhJqKYtKaEuQyj4c47CKJE77KUXKVxgVfVDj0Em5CPEIwXOJhgK/lwcWxYXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MUvVrH4i; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3c1f68ef1so492979a12.1
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 03:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733742174; x=1734346974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XUPiOrNH1n//ypUMYkuFABYWmDpGewo2IYrQwWO/Hmo=;
        b=MUvVrH4iiclPhUomfzi6tHBIcAbBuo3/LGmiVdJF27ip2+n3zykKZR7MNWVvvBbwTz
         /dUGpEea2ioUqmU+A72gZEqdp+AX7rH8iswfPevSvUDLPUnTbh3Wza2wz+cpyE228Hz4
         jZEjuTA9jtyUGL5Uw/W6ML6Nqw1LW9D9mf/QfIdyB/U0oKY6o1eG4uzg1W+lKwJMJTTs
         O7mT4jnNauh/vzri/9uoXRQqUmfk4K2jRJGuVaxCeXz2cl+Q661zZYCgUJ2y918syDNn
         PqV5926DWS6xu8+2PHNC5uO7FDRg41+IMFHxhnBQuHFzT8kAxQkV8aiAhsp+pIUkXXSC
         ydQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742174; x=1734346974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XUPiOrNH1n//ypUMYkuFABYWmDpGewo2IYrQwWO/Hmo=;
        b=mukzOvZLz1zVl+jUzTZme5T8hI1+Xg9GOLIPCbBSdfFvOPidDMfSvgjAvO02E/6iKe
         E7sZM93xNrZA26Wr37nr1jLSUA8JbbrUes69zt3n6UfQfC5b+6Dpon6FrkhcfpRE5Gw8
         cMw6FEKMaeBuKDgLO+9+Qz3b2EKEcMH6Ssq1vvt096z7u9n0V5fnjZ5MZVrTQlHIsFVT
         1T5DmGmlBGRWP0+gaBvTJYwY4ttycii34PdnoA6rvEweLYtGz+zvfMp6YvYC/tIQA3tR
         XHB3Q/s0IDsuBSjeyrjUcJiZ0n3HfnmDOMkVhwdfybhIZ1DVa85nicE/9xjoSwteoWlQ
         YZkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEw+ZA6xuUlEsOIUL3NEW3vLSHjGxDIUALBsQE8ww2CpSZQ+/YIYc2jYYGR0pBJ9I3mimfUIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCMWhgM8QckUsMKSH+gQnXmpGY21uMBaSzXrwjO39dy4nUenc9
	0tjH9+rVRMWwVVteBByG5Hv2uIuffBse5lKQUOXzZHE9OIa2tSz263l3Z+h+Brw=
X-Gm-Gg: ASbGnctyVqBn/oGoa6ZTPss4bEnSXh1KxDxQhwaHfLdDyaZL+xArVpB21LV8zYDd6li
	oY4a2Pa/93Pm89ePHmwdvjk17YvE1JLecH61ez7/61f/zkCRgfFQdtk9aDIKbUyF+Na8A/lZjtV
	EOa6rCu3FqPtXTdoQNsYZrHmJOt2r+oPN53oT+y3E34V/dPAIRJ4pAPoWRvbDH0z9CrAZUb6Uvx
	ExoDEb+z6GI6t5Tp/VCLiSZMbmCB8yQrEU6dE4U/rJ7+UMIs9HPP8ZP6kcG1M6ca1DBvg==
X-Google-Smtp-Source: AGHT+IGzG/+sNYhVLMvQBtnv9Nm/PRVjLNtlsJ2/nBF9d0SHrnmyN30fgse6/SB8+4QRL8/+oWCMpg==
X-Received: by 2002:a05:6402:5201:b0:5d0:bf79:e92e with SMTP id 4fb4d7f45d1cf-5d3be78e220mr4410831a12.6.1733742174501;
        Mon, 09 Dec 2024 03:02:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dd4f641bsm3348818a12.51.2024.12.09.03.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:02:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 12:02:19 +0100
Subject: [PATCH v2 14/19] arm64: dts: qcom: x1e80100: Fix CDSP memory
 length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-dts-qcom-cdsp-mpss-base-address-v2-14-d85a3bd5cced@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1319;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NfgQA/XgYVV5OKpmwdBaDSEA9tYYVgnK+RFM1b7SHis=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVs486MXCYyd69c4PabXhYd0fnocDIwwxfVpDP
 70dA4FhTnaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bOPAAKCRDBN2bmhouD
 111ID/9IUZmDIOA3Q471nRYAYEwX/prFc2VkFuOtIYRBLnKcEUO+CgVDNP4RId0OFQ6XIurVH+o
 rbMfNqQRGzM98eK/a2SoSAPqcT947jpY6jiwdbW1iqLLymRKpRHAtEPD9h3Ygsfnx5hPVxmRw+D
 2WjY/riQNlJ/uxk3qzlawDRTDToiQktpZEjyPT0ErClJiC3Vl+hLNUk+fia1+EvbUw66OnFoGEw
 z7G87+MlfIO3BZSmeol5qA7i3orQeRzxBL5aPR5jpKsdUOEs/RHXyDTBEIok/gViUQB/ZHSR4+j
 /gwd0vuZPx5JtJawKzeLOEscmwme9eyTArBCS1ILc5ZPParKjeDBFQwaltSjA/zIKBQUtSDxXO3
 7qOYRdi2FOjpLeqmfk6EZ3IULYQOxOgnEyiAlbuXLI8gJKOgWFa7h9Tl7wgYf5YJRA97hRHWBfE
 c6IXqTnZrAun4Dgei1vexKazFZlseRnUoDzVCYBoWlBq8riV0y8J+YoX24kTHU2mdiwh20SK66u
 NEVHjkkXQWTwBFmzpKmXiQ70xBKcWwH8xk7M/4TWzBUFUiNEfS1QKbypO3aoiRBYakSI8nv7iKr
 ABXGfzZPwe8aGmQhGaL573Z1DGghMbpdVGjjOLvWQO6DqF9wYnlZQwkPg7vEcogetbrI/sDeEZC
 ela3APLGxLd+c0A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB) which has a length of 0x10000.  Value of 0x1400000 was
copied from older DTS, but it does not look accurate at all.

This should have no functional impact on Linux users, because PAS loader
does not use this address space at all.

Fixes: 5f2a9cd4b104 ("arm64: dts: qcom: x1e80100: Add ADSP/CDSP remoteproc nodes")
Cc: <stable@vger.kernel.org>
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



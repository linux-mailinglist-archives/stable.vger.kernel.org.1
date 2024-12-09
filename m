Return-Path: <stable+bounces-100135-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A309E9152
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B6F7161B88
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7141219EA8;
	Mon,  9 Dec 2024 11:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOpjSd9A"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6168D217F43
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742155; cv=none; b=R/9tRp/t0YCYEMPe1HiH4pmTAa3YwD7MELAbXXgH24LDhC0vpr8VeO8cS8oKnnzBUaugNgVJBjmfeIMyhDx0wA1czBz4fmsd5FpiqQyqaIUsGuqfBuamdgyy5PceV/SdkxjqrgL6clY4Y2TTOhZC3AVtle3umwa3DSmkHDbC1rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742155; c=relaxed/simple;
	bh=BmeLBSD7e/5702j3yO++zDTzKsDBRH4GtN6Tw8+69y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pj7x9v7Xs+7XX8IuSsqLnCdJczRcaLR2UoOsLJzMPqlooJ20/+qzxzwTpIv+PmHbzCbyCeNaC8+hpo1aAlN4rbcd9bN+u0PVR8B68jqwbphPwF3UGM0A5ZoNXVwSTMHFhh66jDKhkzOzrWrdDWdrWBAvBVIdzHE1SBx8DErmtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GOpjSd9A; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d0ac3be718so511758a12.1
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 03:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733742150; x=1734346950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fP5kZHXhj/8NE4k7+vfB0C5FDMhhdszC9LncVHhIgA=;
        b=GOpjSd9A9vCRJpzw5zNg1qvt5/4ifOe+qBv2xVNLuxzMZe+tYsfyOuYZMKQvYZ46Y/
         ECtCVlCyKEzluLZ/wC4zlnMEFn7QqgM+VDWttxVskaqhnKzHn+2CUgMhcja973WIK4B6
         mV1nYcy2Gi/ErbBs2Hee7wvnIHI8uLiSOuXboEUrXSK73NKe3+XkP2uJc834GT4FgJG5
         D74YD/GBOGYmBUftIbgTYzionhod3ZJTlJMciNHFLHVvjWan1AcOm27ZWRQi41EG+HMO
         EpaRwMF12rpSUCM7DQpHSImk6mHvPpXvdYYsTWnO8zib0pA6XvDvdNTXZEHQRf5kpibE
         lEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742150; x=1734346950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fP5kZHXhj/8NE4k7+vfB0C5FDMhhdszC9LncVHhIgA=;
        b=azfDmYAgJR7ojGDNaASftqFoHv5kRFqGjEswdbGhBluDpCWWRROJjMTTqG/YGO5bg1
         9QMZ84dxIvXKe/gnFY1+iYqlj3/srVIyuGRw0gag/SISsMUY3Thbvh+RtW3c1Isv1urd
         9J7ngvNZ/O0HHR/JaJZmDJsaKAnkwXhM+QA3CCZ5kDVZDJwVk8XJ+cqjGQtxyQHOZ2h7
         Y0xfvvvqacfYUWHRmuae8H3q2kYZGdK+f1nAWMF8Qo8C0rDOmhRZV81589RMGbNhGAL5
         pNADSRKBCefGNH3fOoK/CmrQjJVmD4Vr2PdTzxkQR3VB2O+z1CUstny7V0oXQfJEmPLh
         QHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqo7KKIeqJ9/HaFNt8VPjXqZcCYBMBRaU1RnDMA0Jli1g2ivU4ozO+LSqqHaZpC/yvWOr5Lkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYXTkpEjDU5jG+e/2WyvitNEr/WktWps5kAiVedEQzanD+JbGh
	5kL+h1FovOwgddKPXfQGGqI099RyBUQg35gkMOGiEZw/KqfMAMe5v6Wi8TjIeCg=
X-Gm-Gg: ASbGnctleYVu3HUkDYzQ2k98vEJ6OtBm5Sqhr4WtaqVcxLlYGd7BIfRRhILMwwaxgMH
	qMjR9bg670ybM3O10RrBmzkWo34uxjt5z3d0GNZcUkVntO3jY2rCM/5IGMUwK6EME5oFuTX00Lr
	R1hlv52Kr0KbN00E6O0bX1OuFTPpCarhQkSyRAJFKi9+YYXHYHrDRNhOBwwuKIQ/vo31IMb4JZM
	bdU61LA52pLhN6v12294/sQJfoqEp+7kheMBOH8AVyEnxYFGz3WQc+2ss1FaIqvwg==
X-Google-Smtp-Source: AGHT+IE4Um91Aalnsg+dgl23v4V/6CYS0o5T52fibvfVdIFzyI3393akYxxjkGeVOSgg+7KcWm+QcA==
X-Received: by 2002:a05:6402:2349:b0:5d0:b87c:3eb6 with SMTP id 4fb4d7f45d1cf-5d3be7883c8mr4687314a12.10.1733742149681;
        Mon, 09 Dec 2024 03:02:29 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dd4f641bsm3348818a12.51.2024.12.09.03.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:02:29 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 12:02:06 +0100
Subject: [PATCH v2 01/19] arm64: dts: qcom: sm8350: Fix ADSP memory base
 and length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-dts-qcom-cdsp-mpss-base-address-v2-1-d85a3bd5cced@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8733;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=BmeLBSD7e/5702j3yO++zDTzKsDBRH4GtN6Tw8+69y4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVs4xdy5GpFiACHNzRmnbB/fcpnkMcRvLKXgKY
 ukbCc+XNSaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bOMQAKCRDBN2bmhouD
 1/K4EACX3+kQRVY4kboNdL9iU0+NIlgCfEym6CKnxtvCFfefqQ9eFMmP7Gs83UAQ5HPE0THxtCG
 gBqubXrSaWuaH5a4tOsvLckuWfjiwBKL7kXOCq8iPCzYmv9Me4pL7YS7nTYWsd2cX0mmwjsQYTW
 m90ChrEqGjWhBhMkoCHMuqB3iV0LZDXo1PL6imPYptipTMkOWfIc3sEITVdy3ySb4v00EmAFjIY
 KjrwL0Y0TWI+5kE54nZ5GO9avcxf0xsZDarr88WhOaNofaJzNvhi7ZfHTnbQzfIqi1XviMf3OfZ
 bqxDSM8EY2wap/T6l30u6sMmspdzmqo7h9lFTmBZKWSVhZLcvTTxzBREKx9PfVaERkKuehBPwAp
 0TMSZ4lerJ718ry/+kCbyI/EYZL9UrDq6195BiWbHbfROssV0KB+hbYQlO6bp9tsGYw4nn8X4G2
 5GQW4kxH6byKHzBUeq927625XlA90+MWxQIX1Jn3VyVKfDt8gEw14zkFOFjNLadHbm9f7Iqi9K2
 dpaT1I8hqPsPYOFOUCFaTyoUeczc2xpRgvvdtnNQyO67BSP2hjHZ+1O0EEMMehkOIALtTNh5gzr
 OYkEgkX7uVEzFZBzu/BYbVeKZCxrAmzE2aBjtQHqcXT7tAf7Zyqy+owQ4a8tGghl3nFuJTt3ypF
 EBUjxizvHGlPPxA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in ADSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB): 0x0300_0000 with length of 0x10000.  0x1730_0000,
value used so far, was copied from downstream DTS, is in the middle of
unused space and downstream DTS describes the PIL loader, which is a bit
different interface.

Assume existing value (thus downstream DTS) is not really describing the
intended ADSP PAS region.

Correct the base address and length, which also moves the node to
different place to keep things sorted by unit address.  The diff looks
big, but only the unit address and "reg" property were changed.  This
should have no functional impact on Linux users, because PAS loader does
not use this address space at all.

Fixes: 177fcf0aeda2 ("arm64: dts: qcom: sm8350: Add remoteprocs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 272 +++++++++++++++++------------------
 1 file changed, 136 insertions(+), 136 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 877905dfd861edbcd083e6691a7cfa1279164ffc..5fae676af3a3da21066d01092b6b24fbc4ae4a40 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1876,6 +1876,142 @@ tcsr: syscon@1fc0000 {
 			reg = <0x0 0x1fc0000 0x0 0x30000>;
 		};
 
+		adsp: remoteproc@3000000 {
+			compatible = "qcom,sm8350-adsp-pas";
+			reg = <0x0 0x03000000 0x0 0x10000>;
+
+			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
+			power-domain-names = "lcx", "lmx";
+
+			memory-region = <&pil_adsp_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <2>;
+
+				apr {
+					compatible = "qcom,apr-v2";
+					qcom,glink-channels = "apr_audio_svc";
+					qcom,domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					service@3 {
+						reg = <APR_SVC_ADSP_CORE>;
+						compatible = "qcom,q6core";
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+					};
+
+					q6afe: service@4 {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+						};
+
+						q6afecc: clock-controller {
+							compatible = "qcom,q6afe-clocks";
+							#clock-cells = <2>;
+						};
+					};
+
+					q6asm: service@7 {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+							iommus = <&apps_smmu 0x1801 0x0>;
+
+							dai@0 {
+								reg = <0>;
+							};
+
+							dai@1 {
+								reg = <1>;
+							};
+
+							dai@2 {
+								reg = <2>;
+							};
+						};
+					};
+
+					q6adm: service@8 {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
+
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "adsp";
+					qcom,non-secure-domain;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x1803 0x0>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x1804 0x0>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x1805 0x0>;
+					};
+				};
+			};
+		};
+
 		lpass_tlmm: pinctrl@33c0000 {
 			compatible = "qcom,sm8350-lpass-lpi-pinctrl";
 			reg = <0 0x033c0000 0 0x20000>,
@@ -3285,142 +3421,6 @@ apps_smmu: iommu@15000000 {
 			dma-coherent;
 		};
 
-		adsp: remoteproc@17300000 {
-			compatible = "qcom,sm8350-adsp-pas";
-			reg = <0 0x17300000 0 0x100>;
-
-			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "wdog", "fatal", "ready",
-					  "handover", "stop-ack";
-
-			clocks = <&rpmhcc RPMH_CXO_CLK>;
-			clock-names = "xo";
-
-			power-domains = <&rpmhpd RPMHPD_LCX>,
-					<&rpmhpd RPMHPD_LMX>;
-			power-domain-names = "lcx", "lmx";
-
-			memory-region = <&pil_adsp_mem>;
-
-			qcom,qmp = <&aoss_qmp>;
-
-			qcom,smem-states = <&smp2p_adsp_out 0>;
-			qcom,smem-state-names = "stop";
-
-			status = "disabled";
-
-			glink-edge {
-				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
-							     IPCC_MPROC_SIGNAL_GLINK_QMP
-							     IRQ_TYPE_EDGE_RISING>;
-				mboxes = <&ipcc IPCC_CLIENT_LPASS
-						IPCC_MPROC_SIGNAL_GLINK_QMP>;
-
-				label = "lpass";
-				qcom,remote-pid = <2>;
-
-				apr {
-					compatible = "qcom,apr-v2";
-					qcom,glink-channels = "apr_audio_svc";
-					qcom,domain = <APR_DOMAIN_ADSP>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					service@3 {
-						reg = <APR_SVC_ADSP_CORE>;
-						compatible = "qcom,q6core";
-						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-					};
-
-					q6afe: service@4 {
-						compatible = "qcom,q6afe";
-						reg = <APR_SVC_AFE>;
-						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-
-						q6afedai: dais {
-							compatible = "qcom,q6afe-dais";
-							#address-cells = <1>;
-							#size-cells = <0>;
-							#sound-dai-cells = <1>;
-						};
-
-						q6afecc: clock-controller {
-							compatible = "qcom,q6afe-clocks";
-							#clock-cells = <2>;
-						};
-					};
-
-					q6asm: service@7 {
-						compatible = "qcom,q6asm";
-						reg = <APR_SVC_ASM>;
-						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-
-						q6asmdai: dais {
-							compatible = "qcom,q6asm-dais";
-							#address-cells = <1>;
-							#size-cells = <0>;
-							#sound-dai-cells = <1>;
-							iommus = <&apps_smmu 0x1801 0x0>;
-
-							dai@0 {
-								reg = <0>;
-							};
-
-							dai@1 {
-								reg = <1>;
-							};
-
-							dai@2 {
-								reg = <2>;
-							};
-						};
-					};
-
-					q6adm: service@8 {
-						compatible = "qcom,q6adm";
-						reg = <APR_SVC_ADM>;
-						qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
-
-						q6routing: routing {
-							compatible = "qcom,q6adm-routing";
-							#sound-dai-cells = <0>;
-						};
-					};
-				};
-
-				fastrpc {
-					compatible = "qcom,fastrpc";
-					qcom,glink-channels = "fastrpcglink-apps-dsp";
-					label = "adsp";
-					qcom,non-secure-domain;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					compute-cb@3 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <3>;
-						iommus = <&apps_smmu 0x1803 0x0>;
-					};
-
-					compute-cb@4 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <4>;
-						iommus = <&apps_smmu 0x1804 0x0>;
-					};
-
-					compute-cb@5 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <5>;
-						iommus = <&apps_smmu 0x1805 0x0>;
-					};
-				};
-			};
-		};
-
 		intc: interrupt-controller@17a00000 {
 			compatible = "arm,gic-v3";
 			#interrupt-cells = <3>;

-- 
2.43.0



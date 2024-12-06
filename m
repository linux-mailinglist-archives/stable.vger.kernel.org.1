Return-Path: <stable+bounces-99918-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C17B9E7436
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB9A816A5E6
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB0C20E00A;
	Fri,  6 Dec 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="btPAaw9Z"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1239720CCC3
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733499181; cv=none; b=nGuVZjB5TZdzL/XSWQHX0UBmqkLO0LbsT1CGZvjHFi8frQZMnGiTJoNMbunZ3pPcAG0m2ErlorI1zhZiQc14pv2dUg6TRt45WI8hjutTEL42p6Y1u24plLUBgoTgFV8lLO0aL4aHzuhzED5YDfOxlpYGGwCG+ynXb9Fz816gfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733499181; c=relaxed/simple;
	bh=IVyQTZIE68AzxH9FQtbvcgKH5TGZedgmtjpHshfGvYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pOETmCBHcgJQbsi7um7qcy9/79qvLaQMjiyh7eUzSQACJtzemSqTo4GuBEqgpi2C27y1kr+UGJr/Q/q78yGNSo5drv8E1aEkFf7W9hMlSU4/9PdQXCYa17FUdstBqDt8i1k5VQLz7BtIkIF4kmF3DbfptphC6FOis0aABQrVnbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=btPAaw9Z; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-434941aac88so1624585e9.3
        for <stable@vger.kernel.org>; Fri, 06 Dec 2024 07:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733499176; x=1734103976; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fH2tFnhRhcccS4mYAVP/YwLfbHBb/6okJKwDtdiFtuI=;
        b=btPAaw9ZNQSgp/mc5zw6wxQqxNWIjo1/72wWIXK1QYHxy3UrESD/LOHbOC1/h1Crib
         sw4+gL417Wz2eQpxMH4H48e7Um0Ql/7QACgfckWyndFMpTWAsczAkoed3/WmMJ/0Vjt/
         BuDrAQkKQR5waWjsxCjRroZpyH2Zd/v//wG8cmJ1hH4IUXWD3XZJdxQcYtlcuILXWQQK
         PRyWXpWdBIbGlArlH4VW+k9sXjpZ5jfOr9mY5ESporq0K6KUEiRhmJLXbZxerFL7wnJt
         xQRrhlmNuE+miUeVS5el9BKJKJOaso3zE5mlG6YLl9+NuuctBWiE7qVbdyq1zhPa4sE6
         eyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733499176; x=1734103976;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fH2tFnhRhcccS4mYAVP/YwLfbHBb/6okJKwDtdiFtuI=;
        b=hH3bw0m3a1TzU6+1yHPM0XmwFEIQ9n7JHPboS5SiSKzl9cV76x/SgHdeb/SmhFd/Qb
         wPz/lLgmZCRrXQtgrZSQFlIo7m1qMsC/p/uSLWtaql7G+eSSQ7hm15Z5AngnrQbC8BEi
         M2m7etJdYJ+JxnAUOs3XgCUlIkqJLAXcGmwuTnoO3axAJQ3BqaSKm5JsurrTmrQQUSvt
         unxKdANumvZRkyD4SJA2LjEu5HAcdVw0tpvjHILBw1TAlAfjVDDZK0hQ5FqhO+N++W0G
         DGc8Uwu8FLNRohfVZ/vaU9oPEOxLMzBf9++aQlrWwte14rEdtnkdXBDb4PP7f+RMPElh
         cQtA==
X-Forwarded-Encrypted: i=1; AJvYcCV04E8+bKP3FR+KhpFcPqD61vENq5AxIT5d5djBJukvzEOzfH5TWAPwQRUUdIn/Ovt2NgeYp3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5/I5SqWDWuUKPLuVrNCKsWl7buwAzRmOubAhXiRrOyJOaKLAr
	SNr9S87muj2e+wG/9/7Bl/170WEYByvatmuL99xQG2dkTJob7032Q9mV+2A/mO4=
X-Gm-Gg: ASbGncvDplf/30x0sS6LU32mrPZhwqtXFkvjWNZdjlx+yWGfyrMh7apAE+l0Gl/0IbJ
	TFnpTKZgO/JJBKT0qbVDDwzykfDoRGg+yT/xIOWOV01n6ZS18jkmrQU3l4PIqfiFj64eWNTjeOI
	OHJ4YGkpOgqeRRstyzkO5b3ZkgQgaKUyaQITGPcQDTFfShrssBw8EinBNAP4zjXvBvtks6YqT2W
	e99+UckUWA0GjLHBy6l7OPL1oNtJCoiQ4ruBay4/TkAiTaKiN25ll146zBlm8WZ0A==
X-Google-Smtp-Source: AGHT+IGuXFQuYRD8aHNFapqOQBpMB2SxJBt+aLCJyZjCJup0LzW1HrBMcKxG+7ym7UhlSJEYnZrHWw==
X-Received: by 2002:a05:600c:4590:b0:431:5632:448d with SMTP id 5b1f17b1804b1-434ddee65e9mr12535585e9.9.1733499176363;
        Fri, 06 Dec 2024 07:32:56 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm61158035e9.29.2024.12.06.07.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 07:32:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 06 Dec 2024 16:32:28 +0100
Subject: [PATCH 04/19] arm64: dts: qcom: sm8450: Fix ADSP memory base and
 length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-dts-qcom-cdsp-mpss-base-address-v1-4-2f349e4d5a63@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7307;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=IVyQTZIE68AzxH9FQtbvcgKH5TGZedgmtjpHshfGvYQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnUxkQ0ciKIp/2XxjbEc0R+b5ccwt8gjrGcF1Pu
 DBNp7TQFMSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1MZEAAKCRDBN2bmhouD
 1+GlD/4kDw8ZCaXGkTJ271UEHntS4rRUtC8O0Mb9a0k0is4HFM19SfPbHCUaFsmd19yS/XYmGxn
 o0k0kLHaBZ9Twm7fjtwpKqKphkZpE9I1WqnEzRVC6y82jpxUD5UiiTEZ6/thx29vPC3WXxo8m9B
 seQVKqvBFDKDxvL/UXxbSFxEZLR/2/IVpNzYc4757xYzMoGMh1U/Rmawwoo+7TRcIaSurTxpTN2
 D20iCNFeKezTcYZMDY2KTcXy5nr78NEa4GNTdUhmWrtip5rSXKeET3USA6GNfDtP2zEp+eF/zKc
 MkjRiwN3HnuD/sHfc0k8wI9XsxkK7yP+7AdmqELQ6hGSbqm2/6xGYt2p/9AWGVAD+myEbud4DUu
 cFlu7nywo+ynCgjz91MJrZrhdnVnQ4R1+fUN9/bfMG3/3OuZWxLE8L+qp+MLU7Lx7u4soO3hPdx
 C3kk/OxM3iRhHzA2pV3lIn3h1e0B7vdmS2c37Ll52TwJH6PRd2AQNj1HOQawlDINDli3KqmGmqX
 JVzEjnCOfR2bfWNsnWSA2HsalGIKrGEBiQrbgO8P4dQ+zLrD5z49nDP2k6i6bIceBXJuLBB+Qgx
 a9opVgWimqKCVqtbgnwbR0cKSnMxbgWVG/gzPGG1SsfB98rjrPztGq4CRkFWfzUZKRggppcsjjA
 uSNXxYOiRIRyg+A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in ADSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB): 0x0300_0000 with length of 0x10000, which also matches
downstream DTS.  0x3000_0000, value used so far, was in datasheet is the
region of CDSP.

Correct the base address and length, which also moves the node to
different place to keep things sorted by unit address.  The diff looks
big, but only the unit address and "reg" property were changed.  This
should have no functional impact on Linux users, because PAS loader does
not use this address space at all.

Fixes: 1172729576fb ("arm64: dts: qcom: sm8450: Add remoteproc enablers and instances")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 212 +++++++++++++++++------------------
 1 file changed, 106 insertions(+), 106 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 53147aa6f7e4acb102dd5dee51f0aec164b971c7..d028079c11bdc2dd2b254f7f7d85e315a86f79bc 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -2496,6 +2496,112 @@ compute-cb@3 {
 			};
 		};
 
+		remoteproc_adsp: remoteproc@3000000 {
+			compatible = "qcom,sm8450-adsp-pas";
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
+			memory-region = <&adsp_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			remoteproc_adsp_glink: glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <2>;
+
+				gpr {
+					compatible = "qcom,gpr";
+					qcom,glink-channels = "adsp_apps";
+					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+					qcom,intents = <512 20>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6apm: service@1 {
+						compatible = "qcom,q6apm";
+						reg = <GPR_APM_MODULE_IID>;
+						#sound-dai-cells = <0>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x1801 0x0>;
+						};
+
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
+						};
+					};
+
+					q6prm: service@2 {
+						compatible = "qcom,q6prm";
+						reg = <GPR_PRM_MODULE_IID>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6prmcc: clock-controller {
+							compatible = "qcom,q6prm-lpass-clocks";
+							#clock-cells = <2>;
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
 		wsa2macro: codec@31e0000 {
 			compatible = "qcom,sm8450-lpass-wsa-macro";
 			reg = <0 0x031e0000 0 0x1000>;
@@ -2692,112 +2798,6 @@ vamacro: codec@33f0000 {
 			status = "disabled";
 		};
 
-		remoteproc_adsp: remoteproc@30000000 {
-			compatible = "qcom,sm8450-adsp-pas";
-			reg = <0 0x30000000 0 0x100>;
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
-			memory-region = <&adsp_mem>;
-
-			qcom,qmp = <&aoss_qmp>;
-
-			qcom,smem-states = <&smp2p_adsp_out 0>;
-			qcom,smem-state-names = "stop";
-
-			status = "disabled";
-
-			remoteproc_adsp_glink: glink-edge {
-				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
-							     IPCC_MPROC_SIGNAL_GLINK_QMP
-							     IRQ_TYPE_EDGE_RISING>;
-				mboxes = <&ipcc IPCC_CLIENT_LPASS
-						IPCC_MPROC_SIGNAL_GLINK_QMP>;
-
-				label = "lpass";
-				qcom,remote-pid = <2>;
-
-				gpr {
-					compatible = "qcom,gpr";
-					qcom,glink-channels = "adsp_apps";
-					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
-					qcom,intents = <512 20>;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					q6apm: service@1 {
-						compatible = "qcom,q6apm";
-						reg = <GPR_APM_MODULE_IID>;
-						#sound-dai-cells = <0>;
-						qcom,protection-domain = "avs/audio",
-									 "msm/adsp/audio_pd";
-
-						q6apmdai: dais {
-							compatible = "qcom,q6apm-dais";
-							iommus = <&apps_smmu 0x1801 0x0>;
-						};
-
-						q6apmbedai: bedais {
-							compatible = "qcom,q6apm-lpass-dais";
-							#sound-dai-cells = <1>;
-						};
-					};
-
-					q6prm: service@2 {
-						compatible = "qcom,q6prm";
-						reg = <GPR_PRM_MODULE_IID>;
-						qcom,protection-domain = "avs/audio",
-									 "msm/adsp/audio_pd";
-
-						q6prmcc: clock-controller {
-							compatible = "qcom,q6prm-lpass-clocks";
-							#clock-cells = <2>;
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
 		remoteproc_cdsp: remoteproc@32300000 {
 			compatible = "qcom,sm8450-cdsp-pas";
 			reg = <0 0x32300000 0 0x1400000>;

-- 
2.43.0



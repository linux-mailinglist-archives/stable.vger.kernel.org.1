Return-Path: <stable+bounces-104079-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9D49F0FC0
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251D8165CA4
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6009B1E3DC6;
	Fri, 13 Dec 2024 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qyS1Wsxt"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA341E3775
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101673; cv=none; b=tz8a6YxPwBGVSSC3OD3rMeH58SdPkN1BtSrnX4Y36lMgwDel3yidsQCg09GX9lP6H36V6hRu1jrBScxYPmCJyFESFbDFBkQkHFZDppo+yDV2JK83EbAYTGl5t+XRHcdOfL/pqSIKmIx05oAMqmFpMJArNhfvcCf6Zl1naZ4ICi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101673; c=relaxed/simple;
	bh=ojNBKn2Cn0kL/c1PWCkFJmK3q2qRhAktzyUnFGcbPSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hzaL8bgtRMVo9N23DtsF91aDYdHBGXxlKxkper1uKEoGDVGpqdVaWLXlndFb2+c3c2B8IgVAEaR/php2v9XSuQgJd7o+iz2UWhWAtSCpfE9zYknys2QzDRNvhI05D+S4/FKv0FeqQ3F27Dy+uhKCLJaTQ6uY74q63SQVgWhsYA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qyS1Wsxt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385e44a1a2dso171196f8f.3
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101669; x=1734706469; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AiJezWnFLPyP/UDR+sDZkKbQNqEaekKVv8EfgzgM7q4=;
        b=qyS1WsxtWN6Sh4UpwKUMUsoOR3MzhQxGqMVNTXrM4yPYoCxTYiPmCOnJUIgarswJ4A
         VXXlKGvOcRKEUyqK5NinLd8p4npIpJwSAMbgqMPnf6sKzgC82Cz8ak9wrz3BaO8TQMsL
         /q79WInDFc6w7wbuNXU1NFxLH2JQWV3T1QNamcGpwitJ//lnuSV4L7VlPkw1+xgY/OYC
         b4utuRleH8Gjik2nfn3HBlbgyK0HjvB4pez7vC5GT4aG8hI9phtWKHA50tZn0z/q8TiM
         NTvmWkB+B7c042OXSzmW3xH0d0M+3gIJH5TiIsQpzpOs1fCKH3F33VmL2yxCWT1SzM7M
         fedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101669; x=1734706469;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiJezWnFLPyP/UDR+sDZkKbQNqEaekKVv8EfgzgM7q4=;
        b=KZyJU0rVukyTpiL1v3CrB6pcdkyizSld9MgZrQvxtU1VWUOYNHn6fKQacfkPe4sAaS
         sPpioiW/Pn+jbW22qWR4unqRrK9yLWazUe/d8vRYecUDsakKQoYM9ZpRatOSqrBW9z6B
         vcODqsKh0uYf/M6mzakLJbbQdbh964TPN6DMngEDMe0GzI2yoa5YydW+XCpFsNv48jOc
         izRkACqxo2Ttx6/x2tPwMhbGD4ZKQb/Q0NVw0immgMpgqJwfNyRarhDh73TxwaoGJNT6
         HW96cxmamZb828mQ4gVEX546GHfMPgmVpiWwh3vcpamZ/ClLOE+X3FVnyQD8N/+JhTlh
         yd7g==
X-Forwarded-Encrypted: i=1; AJvYcCXhCI2UDZtHVHlLaATZp2vsFxAYEN1bnUv+YHBnb7oMhbLcfvfQq+g9K/QhJ8AdY/J3qhBA3fU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUMVtaFBbGXl/NmTnk1qUnWrLZHaIdQGK782SLkcRnpfUrAY3Y
	qQP3qU8iS+M9N9XRQqfHqcCAcSGiMMsnggPijps4fGGHgyBG7Xy0pYT9CZeLGcWdSYotaDuhs5D
	O
X-Gm-Gg: ASbGncupWl2RXJS0dEHPxFkUzLMgefKZ1pjDGyYmHROW5TTxLHtVGXZg5XSUhgF8Vf6
	IBpfBzl/5ww/5dH2F5zwU8awS/MmyK+bsp+fT+7y2R8ZvJ8m5RWxk2wD8bvcwgP98RQp+MBNZkk
	4tKAHq6Jo/P+QVyFOH9SyOxN4BNNBI0a5ZHOxWMwYOGgbE/zO/S3l0Kx+idOod/x6PIfBfNkBYX
	msWkU+U/W13ubqr9u0/uH9pc6m/sA642sC/E56mTqpNzGfaYgJXYuj6s7POyiniKAhfpzk3
X-Google-Smtp-Source: AGHT+IFSLvlHvmQZ4WskaSJiKFUKer13iQ8HlY5gPR18i67oLLkQSVD2lwydoLHuDj4m4wQK0OFrgQ==
X-Received: by 2002:a5d:6c63:0:b0:385:df73:2f43 with SMTP id ffacd0b85a97d-38880ac184bmr882913f8f.2.1734101669355;
        Fri, 13 Dec 2024 06:54:29 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:27 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:53:53 +0100
Subject: [PATCH v3 04/23] arm64: dts: qcom: sm8450: Fix ADSP memory base
 and length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-4-2e0036fccd8d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7362;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ojNBKn2Cn0kL/c1PWCkFJmK3q2qRhAktzyUnFGcbPSU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqKdzG5JVj3/6kPy8p2OlHz7U+m1iTprU6jL
 u5lpVAW+bOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKigAKCRDBN2bmhouD
 15UkD/4iw1515ni2P9R1tKtSm6qXFxh3+7yue2ZZwzbtMnWUPyG+bg1TygzK0V+57xdS83KehZ2
 f2nLbLYtjN16pxh+qRxnOEieI0Y11prT2rC/Ju/JJ3lFm9TTyi65d130vf6rysHs7+zbwv2mgoC
 BUqPax8k4PrjnfUCl2jl72BhwKniCsfPLxez4JtaniwCqLcuFzMpZOXX2Q2dgef4U1BEyqtd33d
 q7nzKntqJw8Cx0VqIgNbv+S4q6MYVr/E5tH0He5e5ZUT7Zox59nbUykWt2tgiyyWQOZp9xwlbGS
 7KoA1uDA9vhb6ERpWiFdDNHYAn1HwrvEHhERwtQh7/TeiYbiNzNFDx5koEdKi34iOMdogo0SHXF
 UQT/YWUB3ptkGZNlOLVWErvG/oRrKJz/+s7LOGSEW6ADgIrT+8iNRFllp43XDR/3meaaI67n5F8
 v6IvBvj94yBhOJc14NxI1AozYac1UU22axw3Pm12FnTfI/i/lRpWygEJFCUb30bMMffByeRcy1b
 qEDPw9O5G5NwTX8IqN67LdRo3bGfh1MZEiRTL5317E/0b/g4JDcKPB/CvyFv1Urn06AoBCmymp9
 IKEGl7MAseJa+mN3ip26VErTRnUj9DL+i4QqPMvGRSKIcp9KYDuxeBe1TzjQwjvpGnd6m5fW2hf
 itxHjw4nM5b13bQ==
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
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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



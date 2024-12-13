Return-Path: <stable+bounces-104076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D9C9F0FB7
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 15:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376191887EA6
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 14:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943CF1E2610;
	Fri, 13 Dec 2024 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ru3/IYcq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720D61E1C09
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 14:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101668; cv=none; b=QpTeh9WAbUySCKg5q3qGrjRNIVs4g63geLPGNKJNv4+ldOjHmKClc90KpFem/XNhZseoEuRAqHyBkCVfxhVJMRNKKY9CeEoKGN87UcZJlU2L1QW8MtnxFzNHNOGoTzYe6XF8L/JYc0Zaf3g6HVG9JZ9ERfLKm6YZSbd72Zn2Xww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101668; c=relaxed/simple;
	bh=2Z7rlZ8KnIbtY9crod+Oqe8Ow4JgBajXrBH2UgHp4zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YhJ8afh6Ud9zFtaTkNGjZih21F36XrUFAnsGQ7KTovVGqRfWyjpoUHgfxE014Qjwti3pOubrp7cQ5bYcrQjs69b4t+SDzavlNKbXcrm0Xs7CSEDR0EGTEDK5mQhK0g5Eh5pVNCJW5gF+Xre70BYL+E5xc2BsO1ItwgAmsGROr4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ru3/IYcq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385d7fe2732so153454f8f.1
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 06:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101664; x=1734706464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qp8DHezHQjmX4URQ12rjx/9mdAe/cabXONMMNGG3es0=;
        b=ru3/IYcqYibmgilVvEkxYYbRsrGvhHjijXbbkIwU6IolJYUBzGE/Kq1HtMEQldzqj7
         ok8LwRm3R8DqsO/m61jPn7emICYVj0QFpsG4VVNeC20brOPHYgmctL6+dJZ0tx0ARf7A
         wx8gBiBRq04ZIKcRz6G4ekNh5+E4ybtqQ9gglP/BipPPGOJUh0Jsii5pE1sla5KTjdyG
         yPFsRwoQS4zxn3HIIRCUjY/xuNBblzqe0h5Ss3t6fRKB265Z9sycPsl0W6DW8a7qx5L/
         ZMMVCKw1RLPu+3feCwia08yGKBaT4AEq+QYAJ9G7NnV6PS1euyJWJYuKfIIbVG+UWZig
         zVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101664; x=1734706464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp8DHezHQjmX4URQ12rjx/9mdAe/cabXONMMNGG3es0=;
        b=O3Vc55DbVtxBTZoyAmMeC4tbSn1NA0kaj/+I/awQxUFqeIC3xjaU9wcIAzorjByyRp
         wq4/CatCO5ge7mTt75JVYwA+EwP/VHv7Z3Flg8L0KsR01T2g1dhvKNgiH3FPbbKXDnN/
         Gfdg8pvakWcdLguEcAnNOERmaDgjI5tCeeXdZ7qcT11g8Iccneu/va4B2fRJKe4w00Yn
         BbFNeq1sFo/VMUUuW8qzmIWMwtT6go6nc5m/4temPGkDQmlluuiaqv4lngiMRuC5AOCt
         RlAPqpsPyQM6xlzpEMFY/qPbMi9GSajkoo7lqwVm8IAFCU0Rwh5AKq46mV17RXHgOAuA
         Lb+A==
X-Forwarded-Encrypted: i=1; AJvYcCVyJ4to2oNQHnkXfm5fRhk20tdDW48tufvXyApbq55wan2YDleGVtJNOsGbrhkxk7a98tIfMDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxogDQRHc1zdTqJ4BkwYENn1DG26pmgptQnNWKxkkCC0Q3cZNds
	XRdf7DcydtNRlXStok81/NTA6hRRv+We7Swtgn9E82tIEWpmR1R/f38BE3UzlmQ=
X-Gm-Gg: ASbGnctQ7Vl9nsRdmtuzVbqMBVrttOjb2CzlNK2ldZsukb+/bquls0QMK0Nkr2ZE8h6
	RTJdMGcKUI0CNQrhD9A12x4Gb9LmxC3nb9K8eIt8l1WQ7G34ejUGMZ707nLjNMIEG71k8lbfy8W
	CfYsg9T6dffZmIhjYxJQzI0NljqKMGU0cC72z6wBvyYfYSHBqy1z+VG7NOtqxzAURKiJM0Ntsa1
	kLcanguUbQgSR/QZp/iRwETLPDXrkOmwZYergs7LPyr6pFvaCZFsuWjlwkfmXqQcVMSteJy
X-Google-Smtp-Source: AGHT+IGlQJCWPBdzvowciiADLBr74y2Gno+/9C6IZnOnkHlonlslL6iwnAa4Gp/yWKuDDl0X+h31iw==
X-Received: by 2002:a05:6000:1886:b0:385:f479:ef46 with SMTP id ffacd0b85a97d-3888e0bb633mr889734f8f.13.1734101663868;
        Fri, 13 Dec 2024 06:54:23 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:23 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:53:50 +0100
Subject: [PATCH v3 01/23] arm64: dts: qcom: sm8350: Fix ADSP memory base
 and length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-1-2e0036fccd8d@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8792;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=2Z7rlZ8KnIbtY9crod+Oqe8Ow4JgBajXrBH2UgHp4zw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqIbs/B40RcMVl2vPIFOzT1aP8ppeIxICb/W
 HqJfCn6L3aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKiAAKCRDBN2bmhouD
 121zD/45niGFok4o0YDpNlRAq5kA3DKetzS0k8hriSKbFE39aRfVwRaJ0IOHV6EuR4eQEzESw2K
 rfYCRxC1pPDY3+5U/2odibwWFLXBLag9p+iSlA024PrJni9H4hAEFRVvYT/bmNM23a5M7N+nJOf
 nRSlVQx2RiWgc1QxRv1z/pCkcYf0xDG2t8z+oR7og1zFrPiD19WjWEgg8tv5BnMZVgAYKMmdEzj
 BAa+IpqpMitzpGp0p2RFAIVkMMrm1vpkoSf0VWoc031+17u0ZRrmXxj0+TMR6wJXt1KdOjelz7S
 /EWyh8ZXNbD+e39MaHXhxCRbLK5agSD/8c5CEoIIoKeRgxDv4FIb6DLmmOSAY5Rrenw0PMGTxDe
 3GAJwR4ciaLUvYbtstAEbV7sbZjvG3tE2RN6NoM6OQG5ErDBBkC9FAASfTjYKYWvpruEmUKNtY3
 SqTaP9VpEvao/X/DBVfXQTgEI201FPIOTS4Y/64joV24FyD0/Wc5az11TtRCFPdpNxx9k0/e5hE
 aJHpUsWgqkG/YemFem8BTnL0ojqm3m15f1S/sW+nCXYi+HG83yjAxG1mpgBhdVT3YZa1fWH5loT
 XmlpvHPHWYsS7oFpJYyHcK6rgkfrXSaGs124NMwaRaFUcA6/QmCkWQxzw62ixFoQ+EO7gH74Wu4
 YfsBfEZjyzO4T2g==
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
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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



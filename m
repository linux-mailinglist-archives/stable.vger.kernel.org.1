Return-Path: <stable+bounces-100142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 835829E9171
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 12:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF3AA1887508
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 11:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033B721B91D;
	Mon,  9 Dec 2024 11:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="clkyOoO1"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37CD21B8F7
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 11:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742167; cv=none; b=Ot+pVsXMBfLvUVw/xKxD/RO74LQ4lOi357BT7vlxucyx7/KBCAKKqunMyyD+9IvFQ5mkPTgKKBwTIqN19QofbJOw2oF7tfbNgzNN74w66loHYF930INml0Rxhsc9yFiaqtLXL6KTdDr9TcmsN/EY6Fw1DBqSmIZGo0bgFzuEP1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742167; c=relaxed/simple;
	bh=vrwP+h6zpIhOuCkjeo3qhBybMESM51e5HW0nDc1kJiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sn/OuZX+9XOwLw4jgWLFkaweEtYYrTNxAbS8bgyrMFaBLWy97ZDh7Utfg923gozqKZ2N+HQwF/NG0kzEC3ZwBveaJa7I7K7El37W5sjhdipcMPsgzNgdTvlRFe2aL5uV+g/DUp/Ms9LZixuHLQ8im4SO+b+bTqodlyVifApsQ1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=clkyOoO1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d0d6087ca3so625062a12.2
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 03:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733742161; x=1734346961; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylbfkDketc8h5XC3dggtd3WAotQ14SQ+WCMxgV3LPvw=;
        b=clkyOoO17qW2OHblEkMyzfzcbo3p6mReDvAKeeRWfa6ErPTOq91j8oo46pxNFKnryb
         oGBEVQ0bywrYWkF2yWTLje8Ag7rryMqXkLrtGE1EM0+pf8zWzlbuYq2WxkfFFkDwd491
         ZR+1SPE71jkabhKwyPvjJjKJ0UWtaA9VQ+jZ/gLTAj/pJraKRbfJf3pXTYusCwv1U+HA
         U6oYhV9c+m5onu+WxE1ijVBv3U3APnq1u3OqLAC44LxSgfGKxbuEavJx+6Q/pFzvdwN3
         DlaGlSraigTSt0h89J/8KqVgm5fhcTSaWTX84RwxrI4jvO8OTtMr9MhMDGo4oKPXz9QT
         7UNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733742161; x=1734346961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ylbfkDketc8h5XC3dggtd3WAotQ14SQ+WCMxgV3LPvw=;
        b=Cp8doDyPXr6btpJhih1HoxLdEBqYpmFBwmTCUnvOPb4O/5PBlYBqLnNEguLxDck3sk
         FM0MjF0SVwNAvPR4LGnO9oIHQl7I35dqWuK5H2ifO3QUecaGB/GeJIcC2vPCxuedMoEl
         jsTQk4ochXIH3H7dGnI36kp61UX567NmLkKDDo6q9KDY6V17CLz6Ugn36OAnp4dGg8Uq
         j0Mys3ELFUTeHbnQdT9cThEctiRYjZ2GNPQWwAGWLbHlU6ki3EeeC81vosspWjw86kRp
         Hy3Sx9MDiTyq6RyMrq/t5g7pR+5FexX1vp0vV4NrtQLQ3fcvFPh7cAMeQ+6FQ+yqNxzt
         lYNg==
X-Forwarded-Encrypted: i=1; AJvYcCWl6kM2/FmGtOrwwGt0TarBkdyPDDU7c6Fzu9L7l9TKBZ8SOk/kHOYTNIjzOgG4sKvZ92EQVyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMThT8BpfINkrwg2J3bQwjr8i6gUy/xNYpi0fatNQR+SOPs18u
	Zd550no9vayTKzstC3j+k3nvHWHdh96ehdPfU0Nphgs5HOU0Qsle1i7J/NIDbxw=
X-Gm-Gg: ASbGncsMKNoEV+PF4WzgYx1o8lKHy/nbZCnH0WycDyzc6dCONYI9DsIWUIP9Hc6daVu
	NLkXjn4GvLkWHRDqhcs63hRU4PljoDFtpdH6JvPNPHdhIabe/4EkuVEzWaaHGfaLjh/RfOc+Qs7
	HHylp1rjOvTNC1NMCQsfBSIHhjOYVWGZ80Jf+LfHJpLiZqERorxdAvQYxKiFZGSeMNgpipHFc2P
	spZN/F0wc2r9K1LfB/8lY73ZZuBEQWsOF7Sx/TVlQ/G/WI74LNLEWqOEkjRUh5gKA==
X-Google-Smtp-Source: AGHT+IF2mcNXKaw/FZzi7gg0/uWlXrIwcL0K9xSH7PrjhEKX0XxZycwI13k/NkXr2kaKHJNglr+2gg==
X-Received: by 2002:a05:6402:3224:b0:5d3:e79b:3b4f with SMTP id 4fb4d7f45d1cf-5d3e79b3fe6mr2481141a12.8.1733742161118;
        Mon, 09 Dec 2024 03:02:41 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d3dd4f641bsm3348818a12.51.2024.12.09.03.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 03:02:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 09 Dec 2024 12:02:12 +0100
Subject: [PATCH v2 07/19] arm64: dts: qcom: sm8550: Fix ADSP memory base
 and length
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241209-dts-qcom-cdsp-mpss-base-address-v2-7-d85a3bd5cced@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8927;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vrwP+h6zpIhOuCkjeo3qhBybMESM51e5HW0nDc1kJiY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnVs423CFVOKApA3wu78lFPDWKAuT8mwgni+MHA
 jSNnFRT11+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1bONgAKCRDBN2bmhouD
 121wD/91jTaAE3KeZhGDkg3p7Z/FV2Tcz5LUVzb6okEaB2aD3CHNNSQC8rCXwLcl/992hVNFNfh
 CogA2Ck77F4Cp+zi7wJSmAR5dJgWNCG2Ln2q3R3A20lkWFH9VbCp9SDe9ppeFemUcrfnU1YzDZ3
 OauxMSA5daMpLVn1IiVGGfg2FzL3yX58c3oSMAOZjbEkt6E+e2DsDt2WXWG1FHJ/5Mo9fh254Od
 fzGqIvrv5oQ1lEvbCg4DmJ35O0ePCcUchxYuezqY1Ra/EdTwN0P0ZlMOLXVYiZuJ3OIsyHJ/aD5
 6DVlykcOZzS0SxdyWuTDWOH6dF8M/joYODmiHNaj8MbNlixlqgnaHan+7ZxXsl8G73cLPbekW2y
 b+X5rUaycE0FDnfDTkv/dUPrHVPgD2o4PuIUeDo12UqktqdbPMBdnquyqKWwoR87aU9H0znTAPS
 3BHcUxG5vd2xOs4VbtsO+CzWLqmNjYlYVJt+Rl3INc1sOks0XxQGHSNfyaW0HtBBxI2t8k3t/Kc
 EwyISSOf6n7rU+KybpzcLQL1tg/oz3hoDE9Ir5IwJ0aNF5tiWjMwspSz48a/fT0RH3DZv3uK8PX
 L3WZs+02HGkqIkHyKmtMkIxNwPlfRxIO0b/Iz2qOF2VzWkE4+54gAjnRbi6IacCDJ5X383VRCbi
 d/J8OU5jg9nswlw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in ADSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB): 0x0680_0000 with length of 0x10000.

0x3000_0000, value used so far, is the main region of CDSP.  Downstream
DTS uses 0x0300_0000, which is oddly similar to 0x3000_0000, yet quite
different and points to unused area.

Correct the base address and length, which also moves the node to
different place to keep things sorted by unit address.  The diff looks
big, but only the unit address and "reg" property were changed.  This
should have no functional impact on Linux users, because PAS loader does
not use this address space at all.

Fixes: d0c061e366ed ("arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes")
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 262 +++++++++++++++++------------------
 1 file changed, 131 insertions(+), 131 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index e7774d32fb6d2288748ecec00bf525b2b3c40fbb..f454015c5b90c7d792c01bf85256812857d79c64 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -2354,6 +2354,137 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 			};
 		};
 
+		remoteproc_adsp: remoteproc@6800000 {
+			compatible = "qcom,sm8550-adsp-pas";
+			reg = <0x0 0x06800000 0x0 0x10000>;
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
+			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC 0 &mc_virt SLAVE_EBI1 0>;
+
+			memory-region = <&adspslpi_mem>, <&q6_adsp_dtb_mem>;
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
+						iommus = <&apps_smmu 0x1003 0x80>,
+							 <&apps_smmu 0x1063 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x1004 0x80>,
+							 <&apps_smmu 0x1064 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x1005 0x80>,
+							 <&apps_smmu 0x1065 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x1006 0x80>,
+							 <&apps_smmu 0x1066 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+						iommus = <&apps_smmu 0x1007 0x80>,
+							 <&apps_smmu 0x1067 0x0>;
+						dma-coherent;
+					};
+				};
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
+							iommus = <&apps_smmu 0x1001 0x80>,
+								 <&apps_smmu 0x1061 0x0>;
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
+			};
+		};
+
 		lpass_wsa2macro: codec@6aa0000 {
 			compatible = "qcom,sm8550-lpass-wsa-macro";
 			reg = <0 0x06aa0000 0 0x1000>;
@@ -4576,137 +4707,6 @@ system-cache-controller@25000000 {
 			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		remoteproc_adsp: remoteproc@30000000 {
-			compatible = "qcom,sm8550-adsp-pas";
-			reg = <0x0 0x30000000 0x0 0x100>;
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
-			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC 0 &mc_virt SLAVE_EBI1 0>;
-
-			memory-region = <&adspslpi_mem>, <&q6_adsp_dtb_mem>;
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
-						iommus = <&apps_smmu 0x1003 0x80>,
-							 <&apps_smmu 0x1063 0x0>;
-						dma-coherent;
-					};
-
-					compute-cb@4 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <4>;
-						iommus = <&apps_smmu 0x1004 0x80>,
-							 <&apps_smmu 0x1064 0x0>;
-						dma-coherent;
-					};
-
-					compute-cb@5 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <5>;
-						iommus = <&apps_smmu 0x1005 0x80>,
-							 <&apps_smmu 0x1065 0x0>;
-						dma-coherent;
-					};
-
-					compute-cb@6 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <6>;
-						iommus = <&apps_smmu 0x1006 0x80>,
-							 <&apps_smmu 0x1066 0x0>;
-						dma-coherent;
-					};
-
-					compute-cb@7 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <7>;
-						iommus = <&apps_smmu 0x1007 0x80>,
-							 <&apps_smmu 0x1067 0x0>;
-						dma-coherent;
-					};
-				};
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
-							iommus = <&apps_smmu 0x1001 0x80>,
-								 <&apps_smmu 0x1061 0x0>;
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
-			};
-		};
-
 		nsp_noc: interconnect@320c0000 {
 			compatible = "qcom,sm8550-nsp-noc";
 			reg = <0 0x320c0000 0 0xe080>;

-- 
2.43.0



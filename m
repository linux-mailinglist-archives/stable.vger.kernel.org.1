Return-Path: <stable+bounces-115920-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4BA34665
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 16:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99170189779F
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD36A35961;
	Thu, 13 Feb 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MRssIacD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8910B26B0A5;
	Thu, 13 Feb 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739459717; cv=none; b=ha8LPJtVIwk4lFjrga1st8BwU6hkg1oDjozLydCZb1bxcS+bipqCuQai85xEZ+zvaaLIjVI+Ll0CzfrzkPszba+QumkJjd+L4xqWE08J3XZpsQAkLpxdNhiiIe0+S4XAaaLkRcVxuhYqG4MR6qhO6kXWVYywo4ZXeP5hbKsqnoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739459717; c=relaxed/simple;
	bh=YP5xF1TaOpz2QWefE8Y2UicXJ002VH+NofAIiJFQM3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTZezpKhJuLtRheTFejg/SJSsdRp0UeTildAbxDcK10RkGlFBwdIIFYhPaMvhZl/+HGOkETweif/WaJU9vlm82jdHRRy6EfA4LI7EyTVnoRDVkWrw+rhc186pN8GskYH2/we8RyOt2sK+zTPSsRVXuw5q9Y9Op2H1QMuwB3mrwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MRssIacD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E841DC4CED1;
	Thu, 13 Feb 2025 15:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739459717;
	bh=YP5xF1TaOpz2QWefE8Y2UicXJ002VH+NofAIiJFQM3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRssIacD8/fBUN2QXPs5LTfpad/07xG2uG5Hlk0COR0rLHDFoaRERTurYCmnj9PGe
	 2BP+WCu4sq0d+wA10i9DdNwsHMk+CbAKBTNJQwoQTftI/yOzXXE6RfID7JPxVym9k4
	 DVyWbZKF8eIwcX7ZguA1cVHt5t1in6oYdRgsu6Wo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 6.13 311/443] arm64: dts: qcom: sm8350: Fix CDSP memory base and length
Date: Thu, 13 Feb 2025 15:27:56 +0100
Message-ID: <20250213142452.616467891@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250213142440.609878115@linuxfoundation.org>
References: <20250213142440.609878115@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit f4afd8ba453b6e82245b9068868c72c831aec84e upstream.

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB): 0x0a30_0000 with length of 0x10000.  0x9890_0000,
value used so far, was copied from downstream DTS, is in the middle of
RAM/DDR space and downstream DTS describes the PIL loader, which is a
bit different interface.  Datasheet says that one of the main CDSP
address spaces is 0x0980_0000, which is oddly similar to 0x9890_0000,
but quite different.

Assume existing value (thus downstream DTS) is not really describing the
intended CDSP PAS region.

Correct the base address and length, which also moves the node to
different place to keep things sorted by unit address.  The diff looks
big, but only the unit address and "reg" property were changed.  This
should have no functional impact on Linux users, because PAS loader does
not use this address space at all.

Fixes: 177fcf0aeda2 ("arm64: dts: qcom: sm8350: Add remoteprocs")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20241213-dts-qcom-cdsp-mpss-base-address-v3-2-2e0036fccd8d@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi |  218 +++++++++++++++++------------------
 1 file changed, 109 insertions(+), 109 deletions(-)

--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2496,6 +2496,115 @@
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		cdsp: remoteproc@a300000 {
+			compatible = "qcom,sm8350-cdsp-pas";
+			reg = <0x0 0x0a300000 0x0 0x10000>;
+
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>;
+			power-domain-names = "cx", "mxc";
+
+			interconnects = <&compute_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
+
+			memory-region = <&pil_cdsp_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_cdsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_CDSP
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "cdsp";
+				qcom,remote-pid = <5>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "cdsp";
+					qcom,non-secure-domain;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&apps_smmu 0x2161 0x0400>,
+							 <&apps_smmu 0x1181 0x0420>;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_smmu 0x2162 0x0400>,
+							 <&apps_smmu 0x1182 0x0420>;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x2163 0x0400>,
+							 <&apps_smmu 0x1183 0x0420>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x2164 0x0400>,
+							 <&apps_smmu 0x1184 0x0420>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x2165 0x0400>,
+							 <&apps_smmu 0x1185 0x0420>;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x2166 0x0400>,
+							 <&apps_smmu 0x1186 0x0420>;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+						iommus = <&apps_smmu 0x2167 0x0400>,
+							 <&apps_smmu 0x1187 0x0420>;
+					};
+
+					compute-cb@8 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <8>;
+						iommus = <&apps_smmu 0x2168 0x0400>,
+							 <&apps_smmu 0x1188 0x0420>;
+					};
+
+					/* note: secure cb9 in downstream */
+				};
+			};
+		};
+
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,sm8350-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
@@ -3589,115 +3698,6 @@
 			#freq-domain-cells = <1>;
 			#clock-cells = <1>;
 		};
-
-		cdsp: remoteproc@98900000 {
-			compatible = "qcom,sm8350-cdsp-pas";
-			reg = <0 0x98900000 0 0x1400000>;
-
-			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "wdog", "fatal", "ready",
-					  "handover", "stop-ack";
-
-			clocks = <&rpmhcc RPMH_CXO_CLK>;
-			clock-names = "xo";
-
-			power-domains = <&rpmhpd RPMHPD_CX>,
-					<&rpmhpd RPMHPD_MXC>;
-			power-domain-names = "cx", "mxc";
-
-			interconnects = <&compute_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
-
-			memory-region = <&pil_cdsp_mem>;
-
-			qcom,qmp = <&aoss_qmp>;
-
-			qcom,smem-states = <&smp2p_cdsp_out 0>;
-			qcom,smem-state-names = "stop";
-
-			status = "disabled";
-
-			glink-edge {
-				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
-							     IPCC_MPROC_SIGNAL_GLINK_QMP
-							     IRQ_TYPE_EDGE_RISING>;
-				mboxes = <&ipcc IPCC_CLIENT_CDSP
-						IPCC_MPROC_SIGNAL_GLINK_QMP>;
-
-				label = "cdsp";
-				qcom,remote-pid = <5>;
-
-				fastrpc {
-					compatible = "qcom,fastrpc";
-					qcom,glink-channels = "fastrpcglink-apps-dsp";
-					label = "cdsp";
-					qcom,non-secure-domain;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					compute-cb@1 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <1>;
-						iommus = <&apps_smmu 0x2161 0x0400>,
-							 <&apps_smmu 0x1181 0x0420>;
-					};
-
-					compute-cb@2 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <2>;
-						iommus = <&apps_smmu 0x2162 0x0400>,
-							 <&apps_smmu 0x1182 0x0420>;
-					};
-
-					compute-cb@3 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <3>;
-						iommus = <&apps_smmu 0x2163 0x0400>,
-							 <&apps_smmu 0x1183 0x0420>;
-					};
-
-					compute-cb@4 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <4>;
-						iommus = <&apps_smmu 0x2164 0x0400>,
-							 <&apps_smmu 0x1184 0x0420>;
-					};
-
-					compute-cb@5 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <5>;
-						iommus = <&apps_smmu 0x2165 0x0400>,
-							 <&apps_smmu 0x1185 0x0420>;
-					};
-
-					compute-cb@6 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <6>;
-						iommus = <&apps_smmu 0x2166 0x0400>,
-							 <&apps_smmu 0x1186 0x0420>;
-					};
-
-					compute-cb@7 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <7>;
-						iommus = <&apps_smmu 0x2167 0x0400>,
-							 <&apps_smmu 0x1187 0x0420>;
-					};
-
-					compute-cb@8 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <8>;
-						iommus = <&apps_smmu 0x2168 0x0400>,
-							 <&apps_smmu 0x1188 0x0420>;
-					};
-
-					/* note: secure cb9 in downstream */
-				};
-			};
-		};
 	};
 
 	thermal_zones: thermal-zones {




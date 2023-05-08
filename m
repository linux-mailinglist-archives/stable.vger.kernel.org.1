Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C32C6FA716
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjEHK1h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjEHK1H (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:27:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DFBE71C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:26:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DD1E62626
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB10C4339B;
        Mon,  8 May 2023 10:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541593;
        bh=KZEttA3c8t1nBgXwlZyJMMRNiX8dJRnAjXowDGEnR48=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mttZKnaRBX/VY4zMi2zgqWqMHfwooLA0BT8LdcrLg61YfsclDOdYQNzQW/SGU9QlO
         F3mV994V9zwRax0H3LLqNacs/qIpp3Y0O0dXpV6/4p0TLvaWEeuz87rKPM6PClTv6d
         RkD1aIh0fGUpjreMb5Pma6pWFlkMwUpkaezFH2zg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 164/663] arm64: dts: qcom: ipq6018: Add/remove some newlines
Date:   Mon,  8 May 2023 11:39:50 +0200
Message-Id: <20230508094433.806460041@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 6db9ed9a128cbae1423d043f3debd8bfa77783fd ]

Some lines were broken very aggresively, presumably to fit under 80 chars
and some places could have used a newline, particularly between subsequent
nodes. Address all that and remove redundant comments near PCIe ranges
while at it so as not to exceed 100 chars needlessly.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230102094642.74254-5-konrad.dybcio@linaro.org
Stable-dep-of: 75a6e1fdb351 ("arm64: dts: qcom: ipq6018: Fix the PCI I/O port range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -96,26 +96,31 @@
 			opp-microvolt = <725000>;
 			clock-latency-ns = <200000>;
 		};
+
 		opp-1056000000 {
 			opp-hz = /bits/ 64 <1056000000>;
 			opp-microvolt = <787500>;
 			clock-latency-ns = <200000>;
 		};
+
 		opp-1320000000 {
 			opp-hz = /bits/ 64 <1320000000>;
 			opp-microvolt = <862500>;
 			clock-latency-ns = <200000>;
 		};
+
 		opp-1440000000 {
 			opp-hz = /bits/ 64 <1440000000>;
 			opp-microvolt = <925000>;
 			clock-latency-ns = <200000>;
 		};
+
 		opp-1608000000 {
 			opp-hz = /bits/ 64 <1608000000>;
 			opp-microvolt = <987500>;
 			clock-latency-ns = <200000>;
 		};
+
 		opp-1800000000 {
 			opp-hz = /bits/ 64 <1800000000>;
 			opp-microvolt = <1062500>;
@@ -131,8 +136,7 @@
 
 	pmuv8: pmu {
 		compatible = "arm,cortex-a53-pmu";
-		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) |
-					 IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
 	psci: psci {
@@ -437,24 +441,18 @@
 			phys = <&pcie_phy0>;
 			phy-names = "pciephy";
 
-			ranges = <0x81000000 0 0x20200000 0 0x20200000
-				  0 0x10000>, /* downstream I/O */
-				 <0x82000000 0 0x20220000 0 0x20220000
-				  0 0xfde0000>; /* non-prefetchable memory */
+			ranges = <0x81000000 0 0x20200000 0 0x20200000 0 0x10000>,
+				 <0x82000000 0 0x20220000 0 0x20220000 0 0xfde0000>;
 
 			interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "msi";
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
-			interrupt-map = <0 0 0 1 &intc 0 75
-					 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
-					<0 0 0 2 &intc 0 78
-					 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
-					<0 0 0 3 &intc 0 79
-					 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
-					<0 0 0 4 &intc 0 83
-					 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+			interrupt-map = <0 0 0 1 &intc 0 75 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+					<0 0 0 2 &intc 0 78 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+					<0 0 0 3 &intc 0 79 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+					<0 0 0 4 &intc 0 83 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
 
 			clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
 				 <&gcc GCC_PCIE0_AXI_M_CLK>,



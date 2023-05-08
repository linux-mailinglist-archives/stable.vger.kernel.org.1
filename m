Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA3A6FA458
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjEHJ6O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233851AbjEHJ6M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:58:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C702D7E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:58:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2664061560
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37648C433D2;
        Mon,  8 May 2023 09:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539890;
        bh=Eg+nyi0XwJ8xztLL0SiZt2T3PmkYbIOAAjWr0fzWDFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pJ+bBFp3iRsD9g/xcOad5mglW2jhNd2jXYseunQDeLwtKjNWVnVWqALL2w4daKyPG
         n9IeZgd+/iiQ5Q6ay5VxByW2gEBN4fwC/R1HnWvgwYYNP2kxjdH/sSq/w2lDiBdt2Y
         llhXWBcxdTcE5PqTYdRFmzk+qewd+4d4N7O6qFJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 169/611] ARM: dts: qcom: sdx55: Fix the unit address of PCIe EP node
Date:   Mon,  8 May 2023 11:40:11 +0200
Message-Id: <20230508094427.836980441@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 3b76b736cd9933ff88764ffec01cbd859c1475e7 ]

Unit address of PCIe EP node should be 0x1c00000 as it has to match the
first address specified in the reg property.

This also requires sorting the node in the ascending order.

Fixes: e6b69813283f ("ARM: dts: qcom: sdx55: Add support for PCIe EP")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230308082424.140224-6-manivannan.sadhasivam@linaro.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/qcom-sdx55.dtsi | 78 +++++++++++++++----------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom-sdx55.dtsi
index 29fdf29fdb8c8..a4bf1d5ee2068 100644
--- a/arch/arm/boot/dts/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom-sdx55.dtsi
@@ -303,6 +303,45 @@
 			status = "disabled";
 		};
 
+		pcie_ep: pcie-ep@1c00000 {
+			compatible = "qcom,sdx55-pcie-ep";
+			reg = <0x01c00000 0x3000>,
+			      <0x40000000 0xf1d>,
+			      <0x40000f20 0xc8>,
+			      <0x40001000 0x1000>,
+			      <0x40200000 0x100000>,
+			      <0x01c03000 0x3000>;
+			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+				    "mmio";
+
+			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
+
+			clocks = <&gcc GCC_PCIE_AUX_CLK>,
+				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_PCIE_SLEEP_CLK>,
+				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
+			clock-names = "aux", "cfg", "bus_master", "bus_slave",
+				      "slave_q2a", "sleep", "ref";
+
+			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global", "doorbell";
+			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+			resets = <&gcc GCC_PCIE_BCR>;
+			reset-names = "core";
+			power-domains = <&gcc PCIE_GDSC>;
+			phys = <&pcie0_lane>;
+			phy-names = "pciephy";
+			max-link-speed = <3>;
+			num-lanes = <2>;
+
+			status = "disabled";
+		};
+
 		pcie0_phy: phy@1c07000 {
 			compatible = "qcom,sdx55-qmp-pcie-phy";
 			reg = <0x01c07000 0x1c4>;
@@ -400,45 +439,6 @@
 			status = "disabled";
 		};
 
-		pcie_ep: pcie-ep@40000000 {
-			compatible = "qcom,sdx55-pcie-ep";
-			reg = <0x01c00000 0x3000>,
-			      <0x40000000 0xf1d>,
-			      <0x40000f20 0xc8>,
-			      <0x40001000 0x1000>,
-			      <0x40200000 0x100000>,
-			      <0x01c03000 0x3000>;
-			reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
-				    "mmio";
-
-			qcom,perst-regs = <&tcsr 0xb258 0xb270>;
-
-			clocks = <&gcc GCC_PCIE_AUX_CLK>,
-				 <&gcc GCC_PCIE_CFG_AHB_CLK>,
-				 <&gcc GCC_PCIE_MSTR_AXI_CLK>,
-				 <&gcc GCC_PCIE_SLV_AXI_CLK>,
-				 <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
-				 <&gcc GCC_PCIE_SLEEP_CLK>,
-				 <&gcc GCC_PCIE_0_CLKREF_CLK>;
-			clock-names = "aux", "cfg", "bus_master", "bus_slave",
-				      "slave_q2a", "sleep", "ref";
-
-			interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "global", "doorbell";
-			reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
-			wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
-			resets = <&gcc GCC_PCIE_BCR>;
-			reset-names = "core";
-			power-domains = <&gcc PCIE_GDSC>;
-			phys = <&pcie0_lane>;
-			phy-names = "pciephy";
-			max-link-speed = <3>;
-			num-lanes = <2>;
-
-			status = "disabled";
-		};
-
 		remoteproc_mpss: remoteproc@4080000 {
 			compatible = "qcom,sdx55-mpss-pas";
 			reg = <0x04080000 0x4040>;
-- 
2.39.2




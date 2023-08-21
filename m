Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546AC78322F
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjHUUJL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbjHUUJK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:09:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC1212A
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:09:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A14264A60
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:09:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58715C433C8;
        Mon, 21 Aug 2023 20:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648547;
        bh=qeudcGN8HNgBz5SgkXygnoDhjvgcagvT5TCfF54u/7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sv4QdEu5y2EPPK7chkclov67qLjiP+yBNR+LTW5uUiYlkU8tncnXtMWgOM8mrwuE7
         O8TA8sMV3lRqm62h5Knkfiar1JBZb3L7ZYVCL2/9JLKvlOv1y49wPr5lbbZYQ0/ccx
         JvcC8PzHyiRsjxDcW+n1qJJZ1oRB+Qnbq26RImlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Fabio Estevam <festevam@denx.de>,
        Marek Vasut <marex@denx.de>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 187/234] arm64: dts: imx8mm: Drop CSI1 PHY reference clock configuration
Date:   Mon, 21 Aug 2023 21:42:30 +0200
Message-ID: <20230821194137.105468441@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Fabio Estevam <festevam@denx.de>

[ Upstream commit f02b53375e8f14b4c27a14f6e4fb6e89914fdc29 ]

The CSI1 PHY reference clock is limited to 125 MHz according to:
i.MX 8M Mini Applications Processor Reference Manual, Rev. 3, 11/2020
Table 5-1. Clock Root Table (continued) / page 307
Slice Index n = 123 .

Currently the IMX8MM_CLK_CSI1_PHY_REF clock is configured to be
fed directly from 1 GHz PLL2 , which overclocks them. Instead, drop
the configuration altogether, which defaults the clock to 24 MHz REF
clock input, which for the PHY reference clock is just fine.

Based on a patch from Marek Vasut for the imx8mn.

Fixes: e523b7c54c05 ("arm64: dts: imx8mm: Add CSI nodes")
Signed-off-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Marek Vasut <marex@denx.de>
Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index d6b36f04f3dc1..1a647d4072ba0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -1221,10 +1221,9 @@
 				compatible = "fsl,imx8mm-mipi-csi2";
 				reg = <0x32e30000 0x1000>;
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-				assigned-clocks = <&clk IMX8MM_CLK_CSI1_CORE>,
-						  <&clk IMX8MM_CLK_CSI1_PHY_REF>;
-				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>,
-							  <&clk IMX8MM_SYS_PLL2_1000M>;
+				assigned-clocks = <&clk IMX8MM_CLK_CSI1_CORE>;
+				assigned-clock-parents = <&clk IMX8MM_SYS_PLL2_1000M>;
+
 				clock-frequency = <333000000>;
 				clocks = <&clk IMX8MM_CLK_DISP_APB_ROOT>,
 					 <&clk IMX8MM_CLK_CSI1_ROOT>,
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC296FAA65
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjEHLCr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjEHLCb (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:02:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C7D34114
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:01:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A20B662A44
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F06C433D2;
        Mon,  8 May 2023 11:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543674;
        bh=ergl51rdfktsKrtfXxXWo+tJohdEG+4OQ+TgiDrC1H0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=swjgC8ktRLx5DTRxiQg08yO4uMRUE/8kc+bQh3JTTcHtbgdkb/Mdx17KtaD2mapk9
         N3sux42kTU0W48zGCRmIye9dslbURnTDjfx4SLuwkEv3xWXPHTExr2+4XYktMqj4cJ
         VaVBC4Zs7KBT4qnQmbnKiGsogwTnsCuA85RWVMKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 164/694] arm64: dts: renesas: r9a07g043: Update IRQ numbers for SSI channels
Date:   Mon,  8 May 2023 11:39:59 +0200
Message-Id: <20230508094437.730108927@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit 2a5c9891392dca47f6865a2add1986876e40849c ]

>From R01UH0968EJ0100 Rev.1.00 HW manual the interrupt numbers for SSI
channels have been updated,

SPI 329 - SSIF0 is now marked as reserved
SPI 333 - SSIF1 is now marked as reserved
SPI 335 - SSIF2 is now marked as reserved
SPI 336 - SSIF2 is now marked as reserved
SPI 341 - SSIF3 is now marked as reserved

This patch drops the above IRQs from SoC DTSI.

Fixes: 559f2b0708c70 ("arm64: dts: renesas: r9a07g043: Add SSI{1,2,3} nodes and fillup the SSI0 stub node")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230217185225.43310-5-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r9a07g043.dtsi | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
index c8a83e42c4f3a..a9700654b4218 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
@@ -80,9 +80,8 @@
 			reg = <0 0x10049c00 0 0x400>;
 			interrupts = <SOC_PERIPHERAL_IRQ(326) IRQ_TYPE_LEVEL_HIGH>,
 				     <SOC_PERIPHERAL_IRQ(327) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(328) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(329) IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <SOC_PERIPHERAL_IRQ(328) IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD R9A07G043_SSI0_PCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SSI0_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -101,9 +100,8 @@
 			reg = <0 0x1004a000 0 0x400>;
 			interrupts = <SOC_PERIPHERAL_IRQ(330) IRQ_TYPE_LEVEL_HIGH>,
 				     <SOC_PERIPHERAL_IRQ(331) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(332) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(333) IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <SOC_PERIPHERAL_IRQ(332) IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD R9A07G043_SSI1_PCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SSI1_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -121,10 +119,8 @@
 				     "renesas,rz-ssi";
 			reg = <0 0x1004a400 0 0x400>;
 			interrupts = <SOC_PERIPHERAL_IRQ(334) IRQ_TYPE_LEVEL_HIGH>,
-				     <SOC_PERIPHERAL_IRQ(335) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(336) IRQ_TYPE_EDGE_RISING>,
 				     <SOC_PERIPHERAL_IRQ(337) IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			interrupt-names = "int_req", "dma_rt";
 			clocks = <&cpg CPG_MOD R9A07G043_SSI2_PCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SSI2_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -143,9 +139,8 @@
 			reg = <0 0x1004a800 0 0x400>;
 			interrupts = <SOC_PERIPHERAL_IRQ(338) IRQ_TYPE_LEVEL_HIGH>,
 				     <SOC_PERIPHERAL_IRQ(339) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(340) IRQ_TYPE_EDGE_RISING>,
-				     <SOC_PERIPHERAL_IRQ(341) IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <SOC_PERIPHERAL_IRQ(340) IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD R9A07G043_SSI3_PCLK2>,
 				 <&cpg CPG_MOD R9A07G043_SSI3_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
-- 
2.39.2




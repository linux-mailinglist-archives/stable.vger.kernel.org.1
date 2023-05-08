Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543146FA6FE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbjEHK0B (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234549AbjEHKZe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:25:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05FBD862
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8665A625C9
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCB4C433EF;
        Mon,  8 May 2023 10:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541528;
        bh=VBD6nhKNNZiwl8wWH1AEL8jtVPgKCn2EUc4nX1gLjaI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rCfmQDKRSZM20ER1DC6UfTZNZOZG0EwhIGKgHHJ6ToO6heGDsBiQ0vXs2hiw22UHt
         GTVC2JNEZEhAIJfXPdCFVsefXpcCKusEa7wHbKQN/3OOvpbD0Z1d3Kd7V9gCq1Gsgu
         IqRKouj/SElpB6j8j2X07+BmD18HxrGHRd7pBWG8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 144/663] arm64: dts: renesas: r9a07g054: Update IRQ numbers for SSI channels
Date:   Mon,  8 May 2023 11:39:30 +0200
Message-Id: <20230508094433.183273751@linuxfoundation.org>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

[ Upstream commit c2b0dc0e83ef4a74cbe381fd0c84cea16cf067f0 ]

>From R01UH0936EJ0120 Rev.1.20 HW manual the interrupt numbers for SSI
channels have been updated,

SPI 329 - SSIF0 is now marked as reserved
SPI 333 - SSIF1 is now marked as reserved
SPI 335 - SSIF2 is now marked as reserved
SPI 336 - SSIF2 is now marked as reserved
SPI 341 - SSIF3 is now marked as reserved

This patch drops the above IRQs from SoC DTSI.

Fixes: cd0339ec25895c0b ("arm64: dts: renesas: r9a07g054: Add SSI{1,2,3} nodes and fillup the SSI0 stub node")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20230217185225.43310-4-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 304ade54425bf..fea537d9fce66 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -175,9 +175,8 @@
 			reg = <0 0x10049c00 0 0x400>;
 			interrupts = <GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 327 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 329 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <GIC_SPI 328 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD R9A07G054_SSI0_PCLK2>,
 				 <&cpg CPG_MOD R9A07G054_SSI0_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -196,9 +195,8 @@
 			reg = <0 0x1004a000 0 0x400>;
 			interrupts = <GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 331 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 333 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <GIC_SPI 332 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD R9A07G054_SSI1_PCLK2>,
 				 <&cpg CPG_MOD R9A07G054_SSI1_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -216,10 +214,8 @@
 				     "renesas,rz-ssi";
 			reg = <0 0x1004a400 0 0x400>;
 			interrupts = <GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 335 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 336 IRQ_TYPE_EDGE_RISING>,
 				     <GIC_SPI 337 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+			interrupt-names = "int_req", "dma_rt";
 			clocks = <&cpg CPG_MOD R9A07G054_SSI2_PCLK2>,
 				 <&cpg CPG_MOD R9A07G054_SSI2_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
@@ -238,9 +234,8 @@
 			reg = <0 0x1004a800 0 0x400>;
 			interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 339 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>,
-				     <GIC_SPI 341 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "int_req", "dma_rx", "dma_tx", "dma_rt";
+				     <GIC_SPI 340 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "int_req", "dma_rx", "dma_tx";
 			clocks = <&cpg CPG_MOD R9A07G054_SSI3_PCLK2>,
 				 <&cpg CPG_MOD R9A07G054_SSI3_PCLK_SFR>,
 				 <&audio_clk1>, <&audio_clk2>;
-- 
2.39.2




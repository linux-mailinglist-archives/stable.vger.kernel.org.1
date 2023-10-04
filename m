Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA817B89C6
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244277AbjJDS3N (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244279AbjJDS3M (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:29:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A005A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:29:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714D3C433C7;
        Wed,  4 Oct 2023 18:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444148;
        bh=NC6pol2o82ph7Q470HTYvitiyyj9G0750UQjKqcbogo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AorJGrG54dH2vdyPoVyuQ+FtdcF6et4FlOVJvwFTihXM89Lli5rWFQmJpopWutPU+
         k5/CapvlDdLyC5hTzU/lXTY9DWl0zHJZ5oGEt5kzTTsif8jrNXwoKMWilJzK4+tjUG
         A6UqmOAd2K6oTQr8fgx3FG2mh/DqF022rgk/CctM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 146/321] arm64: dts: imx8mp: Fix SDMA2/3 clocks
Date:   Wed,  4 Oct 2023 19:54:51 +0200
Message-ID: <20231004175236.008367507@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Ford <aford173@gmail.com>

[ Upstream commit b739681b3f8b2a7a684a71ddd048b9b6b5400011 ]

Commit 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks
from CCM node") removed the Audio clocks from the main clock node, because
the intent is to force people to setup the audio PLL clocks per board
instead of having a common set of rates, since not all boards may use
the various audio PLL clocks in the same way.

Unfortunately, with this parenting removed, the SDMA2 and SDMA3
clocks were slowed to 24MHz because the SDMA2/3 clocks are controlled
via the audio_blk_ctrl which is clocked from IMX8MP_CLK_AUDIO_ROOT,
and that clock is enabled by pgc_audio.

Per the TRM, "The SDMA2/3 target frequency is 400MHz IPG and 400MHz
AHB, always 1:1 mode, to make sure there is enough throughput for all
the audio use cases."

Instead of cluttering the clock node, place the clock rate and parent
information into the pgc_audio node.

With the parenting and clock rates restored for  IMX8MP_CLK_AUDIO_AHB,
and IMX8MP_CLK_AUDIO_AXI_SRC, it appears the SDMA2 and SDMA3 run at
400MHz again.

Fixes: 16c984524862 ("arm64: dts: imx8mp: don't initialize audio clocks from CCM node")
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index cc406bb338feb..587265395a9b4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -794,6 +794,12 @@
 						reg = <IMX8MP_POWER_DOMAIN_AUDIOMIX>;
 						clocks = <&clk IMX8MP_CLK_AUDIO_ROOT>,
 							 <&clk IMX8MP_CLK_AUDIO_AXI>;
+						assigned-clocks = <&clk IMX8MP_CLK_AUDIO_AHB>,
+								  <&clk IMX8MP_CLK_AUDIO_AXI_SRC>;
+						assigned-clock-parents =  <&clk IMX8MP_SYS_PLL1_800M>,
+									  <&clk IMX8MP_SYS_PLL1_800M>;
+						assigned-clock-rates = <400000000>,
+								       <600000000>;
 					};
 
 					pgc_gpu2d: power-domain@6 {
-- 
2.40.1




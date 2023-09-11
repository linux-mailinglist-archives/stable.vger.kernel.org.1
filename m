Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF7E79B700
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237125AbjIKV4i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240428AbjIKOn5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:43:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D1312A
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:43:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4B2C433C8;
        Mon, 11 Sep 2023 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694443433;
        bh=8YWaVQkft7UrS8ElJ3FfErUMGgGk56J2r1R+wEBR+F0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xkxf8P5kotc9tCGxM/4OhELDbKj7nwCe+4YgYgtrSYmIS1PP6LyHLnVCEnClUm+FB
         U2QZwtfJwdp8Lh/EOOz+Dsuaqj/8b0U0yv9xKKMsk8AdxhllJJbJz0INe9JjO0Khcd
         edpgprei94FRQC+2jNrzfxWd6RYTjcQmq5tWMrLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marco Felsch <m.felsch@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 376/737] arm64: dts: imx8mp-debix: remove unused fec pinctrl node
Date:   Mon, 11 Sep 2023 15:43:55 +0200
Message-ID: <20230911134701.069387581@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 574e4099d787c2eb41a43f14c453e422515bf658 ]

The SoM A uses the EQOS ethernet interface and not the FEC, so drop the
interface pinctrl node from the device tree.

Fixes: c86d350aae68 ("arm64: dts: Add device tree for the Debix Model A Board")
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../dts/freescale/imx8mp-debix-model-a.dts    | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
index b4409349eb3f6..1004ab0abb131 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-debix-model-a.dts
@@ -355,28 +355,6 @@ MX8MP_IOMUXC_SAI1_TXD6__GPIO4_IO18				0x19
 		>;
 	};
 
-	pinctrl_fec: fecgrp {
-		fsl,pins = <
-			MX8MP_IOMUXC_SAI1_RXD2__ENET1_MDC				0x3
-			MX8MP_IOMUXC_SAI1_RXD3__ENET1_MDIO				0x3
-			MX8MP_IOMUXC_SAI1_RXD4__ENET1_RGMII_RD0				0x91
-			MX8MP_IOMUXC_SAI1_RXD5__ENET1_RGMII_RD1				0x91
-			MX8MP_IOMUXC_SAI1_RXD6__ENET1_RGMII_RD2				0x91
-			MX8MP_IOMUXC_SAI1_RXD7__ENET1_RGMII_RD3				0x91
-			MX8MP_IOMUXC_SAI1_TXC__ENET1_RGMII_RXC				0x91
-			MX8MP_IOMUXC_SAI1_TXFS__ENET1_RGMII_RX_CTL			0x91
-			MX8MP_IOMUXC_SAI1_TXD0__ENET1_RGMII_TD0				0x1f
-			MX8MP_IOMUXC_SAI1_TXD1__ENET1_RGMII_TD1				0x1f
-			MX8MP_IOMUXC_SAI1_TXD2__ENET1_RGMII_TD2				0x1f
-			MX8MP_IOMUXC_SAI1_TXD3__ENET1_RGMII_TD3				0x1f
-			MX8MP_IOMUXC_SAI1_TXD4__ENET1_RGMII_TX_CTL			0x1f
-			MX8MP_IOMUXC_SAI1_TXD5__ENET1_RGMII_TXC				0x1f
-			MX8MP_IOMUXC_SAI1_RXD1__ENET1_1588_EVENT1_OUT			0x1f
-			MX8MP_IOMUXC_SAI1_RXD0__ENET1_1588_EVENT1_IN			0x1f
-			MX8MP_IOMUXC_SAI1_TXD7__GPIO4_IO19				0x19
-		>;
-	};
-
 	pinctrl_gpio_led: gpioledgrp {
 		fsl,pins = <
 			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16				0x19
-- 
2.40.1




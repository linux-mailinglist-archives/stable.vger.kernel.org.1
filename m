Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD31F7ECC33
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbjKOT12 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233824AbjKOT1U (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:27:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6883DD48
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:27:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF941C433C8;
        Wed, 15 Nov 2023 19:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076437;
        bh=oz+Rr/zN8/DHAyi6Uj8ZcUWQIzj907ZxnW62JivrxTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jowEoJee4R/j8wGdIoMOBWcGeluGUa2fmUIj2lV87CBYNtQNhSvgD10o/p6kIn8Yp
         BQY597VRMAD3LsKSuR0MD8Rq/z2qutTsH4zWlY8Sl0ppvdltkSrWFfZXwtswwZ1SGq
         ngC5F7z64IUjDoxwiDm/7fd/xWVbLg1ogIfMPoLU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adam Ford <aford173@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 288/550] ARM: dts: am3517-evm: Fix LED3/4 pinmux
Date:   Wed, 15 Nov 2023 14:14:32 -0500
Message-ID: <20231115191620.754104819@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Adam Ford <aford173@gmail.com>

[ Upstream commit 2ab6b437c65233f06bdd2988fd5913baeca5f159 ]

The pinmux for LED3 and LED4 are incorrectly attached to the
omap3_pmx_core when they should be connected to the omap3_pmx_wkup
pin mux.  This was likely masked by the fact that the bootloader
used to do all the pinmuxing.

Fixes: 0dbf99542caf ("ARM: dts: am3517-evm: Add User LEDs and Pushbutton")
Signed-off-by: Adam Ford <aford173@gmail.com>
Message-ID: <20231005000402.50879-1-aford173@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/ti/omap/am3517-evm.dts | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am3517-evm.dts b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
index af9df15274bed..866f68c5b504d 100644
--- a/arch/arm/boot/dts/ti/omap/am3517-evm.dts
+++ b/arch/arm/boot/dts/ti/omap/am3517-evm.dts
@@ -271,13 +271,6 @@ OMAP3_CORE1_IOPAD(0x21c4, PIN_INPUT_PULLUP | MUX_MODE0)  /* i2c3_sda */
 		>;
 	};
 
-	leds_pins: leds-pins {
-		pinctrl-single,pins = <
-			OMAP3_WKUP_IOPAD(0x2a24, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu0.gpio_11 */
-			OMAP3_WKUP_IOPAD(0x2a26, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu1.gpio_31 */
-		>;
-	};
-
 	mmc1_pins: mmc1-pins {
 		pinctrl-single,pins = <
 			OMAP3_CORE1_IOPAD(0x2144, PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc1_clk.sdmmc1_clk */
@@ -355,3 +348,12 @@ OMAP3430_CORE2_IOPAD(0x25e2, PIN_INPUT | MUX_MODE3)	/* etk_d3.hsusb1_data7 */
 		>;
 	};
 };
+
+&omap3_pmx_wkup {
+	leds_pins: leds-pins {
+		pinctrl-single,pins = <
+			OMAP3_WKUP_IOPAD(0x2a24, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu0.gpio_11 */
+			OMAP3_WKUP_IOPAD(0x2a26, PIN_OUTPUT_PULLUP | MUX_MODE4)	/* jtag_emu1.gpio_31 */
+		>;
+	};
+};
-- 
2.42.0




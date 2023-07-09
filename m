Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE7174C36C
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjGILcl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232930AbjGILcJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DD1E71
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:31:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BA8460BC4
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE9FC433C7;
        Sun,  9 Jul 2023 11:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902316;
        bh=3iSB0MGSrP2vPbBY71uK/49IVHvrztwJmbGfqvdfQw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=paOutroDdgHjG5EB936q8iPOOeV5vmlAiNncr7sgM95ZpwQFh+XIBxrLtvITvgFvt
         W0SEg41MQtMmq5EUEHU+gmqxrhTplmb8Q1LZzim2/aAl72gngYPJhh8Ue+tzrcrB0I
         Dvsy+4Yh/0r+eHAsDwu4fz2m8CnpceRONDROiTqs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Thejasvi Konduru <t-konduru@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 305/431] arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl node offsets
Date:   Sun,  9 Jul 2023 13:14:13 +0200
Message-ID: <20230709111458.313775477@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Thejasvi Konduru <t-konduru@ti.com>

[ Upstream commit 14462bd0b247d05070d48d0f02eb7ca2680ab7bd ]

The wkup_pmx register region in j784s4 has multiple non-addressable
regions, hence the existing wkup_pmx region is split as follows to
avoid the non-addressable regions. The pinctrl node offsets are
also corrected as per the newly split wkup_pmx* nodes.

wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
wkup_pmx1 -> 11 pins (WKUP_PADCONFIG 14 - 24)
wkup_pmx2 -> 72 pins (WKUP_PADCONFIG 26 - 97)
wkup_pmx3 -> 1 pin (WKUP_PADCONFIG 100)

Fixes: 4664ebd8346a ("arm64: dts: ti: Add initial support for J784S4 SoC")
Signed-off-by: Thejasvi Konduru <t-konduru@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20230503083143.32369-1-t-konduru@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts      | 30 +++++++++----------
 .../boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi     | 29 +++++++++++++++++-
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
index 0c4ee83fc9d75..ed575f17935b6 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
@@ -140,28 +140,28 @@ J784S4_IOPAD(0x020, PIN_INPUT, 7) /* (AJ35) MCAN15_RX.GPIO0_8 */
 	};
 };
 
-&wkup_pmx0 {
+&wkup_pmx2 {
 	mcu_cpsw_pins_default: mcu-cpsw-pins-default {
 		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x094, PIN_INPUT, 0) /* (A35) MCU_RGMII1_RD0 */
-			J784S4_WKUP_IOPAD(0x090, PIN_INPUT, 0) /* (B36) MCU_RGMII1_RD1 */
-			J784S4_WKUP_IOPAD(0x08c, PIN_INPUT, 0) /* (C36) MCU_RGMII1_RD2 */
-			J784S4_WKUP_IOPAD(0x088, PIN_INPUT, 0) /* (D36) MCU_RGMII1_RD3 */
-			J784S4_WKUP_IOPAD(0x084, PIN_INPUT, 0) /* (B37) MCU_RGMII1_RXC */
-			J784S4_WKUP_IOPAD(0x06c, PIN_INPUT, 0) /* (C37) MCU_RGMII1_RX_CTL */
-			J784S4_WKUP_IOPAD(0x07c, PIN_OUTPUT, 0) /* (D37) MCU_RGMII1_TD0 */
-			J784S4_WKUP_IOPAD(0x078, PIN_OUTPUT, 0) /* (D38) MCU_RGMII1_TD1 */
-			J784S4_WKUP_IOPAD(0x074, PIN_OUTPUT, 0) /* (E37) MCU_RGMII1_TD2 */
-			J784S4_WKUP_IOPAD(0x070, PIN_OUTPUT, 0) /* (E38) MCU_RGMII1_TD3 */
-			J784S4_WKUP_IOPAD(0x080, PIN_OUTPUT, 0) /* (E36) MCU_RGMII1_TXC */
-			J784S4_WKUP_IOPAD(0x068, PIN_OUTPUT, 0) /* (C38) MCU_RGMII1_TX_CTL */
+			J784S4_WKUP_IOPAD(0x02c, PIN_INPUT, 0) /* (A35) MCU_RGMII1_RD0 */
+			J784S4_WKUP_IOPAD(0x028, PIN_INPUT, 0) /* (B36) MCU_RGMII1_RD1 */
+			J784S4_WKUP_IOPAD(0x024, PIN_INPUT, 0) /* (C36) MCU_RGMII1_RD2 */
+			J784S4_WKUP_IOPAD(0x020, PIN_INPUT, 0) /* (D36) MCU_RGMII1_RD3 */
+			J784S4_WKUP_IOPAD(0x01c, PIN_INPUT, 0) /* (B37) MCU_RGMII1_RXC */
+			J784S4_WKUP_IOPAD(0x004, PIN_INPUT, 0) /* (C37) MCU_RGMII1_RX_CTL */
+			J784S4_WKUP_IOPAD(0x014, PIN_OUTPUT, 0) /* (D37) MCU_RGMII1_TD0 */
+			J784S4_WKUP_IOPAD(0x010, PIN_OUTPUT, 0) /* (D38) MCU_RGMII1_TD1 */
+			J784S4_WKUP_IOPAD(0x00c, PIN_OUTPUT, 0) /* (E37) MCU_RGMII1_TD2 */
+			J784S4_WKUP_IOPAD(0x008, PIN_OUTPUT, 0) /* (E38) MCU_RGMII1_TD3 */
+			J784S4_WKUP_IOPAD(0x018, PIN_OUTPUT, 0) /* (E36) MCU_RGMII1_TXC */
+			J784S4_WKUP_IOPAD(0x000, PIN_OUTPUT, 0) /* (C38) MCU_RGMII1_TX_CTL */
 		>;
 	};
 
 	mcu_mdio_pins_default: mcu-mdio-pins-default {
 		pinctrl-single,pins = <
-			J784S4_WKUP_IOPAD(0x09c, PIN_OUTPUT, 0) /* (A36) MCU_MDIO0_MDC */
-			J784S4_WKUP_IOPAD(0x098, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
+			J784S4_WKUP_IOPAD(0x034, PIN_OUTPUT, 0) /* (A36) MCU_MDIO0_MDC */
+			J784S4_WKUP_IOPAD(0x030, PIN_INPUT, 0) /* (B35) MCU_MDIO0_MDIO */
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
index 64bd3dee14aa6..8a2350f2c82d0 100644
--- a/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi
@@ -50,7 +50,34 @@ mcu_ram: sram@41c00000 {
 	wkup_pmx0: pinctrl@4301c000 {
 		compatible = "pinctrl-single";
 		/* Proxy 0 addressing */
-		reg = <0x00 0x4301c000 0x00 0x178>;
+		reg = <0x00 0x4301c000 0x00 0x034>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx1: pinctrl@4301c038 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c038 0x00 0x02c>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx2: pinctrl@4301c068 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c068 0x00 0x120>;
+		#pinctrl-cells = <1>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0xffffffff>;
+	};
+
+	wkup_pmx3: pinctrl@4301c190 {
+		compatible = "pinctrl-single";
+		/* Proxy 0 addressing */
+		reg = <0x00 0x4301c190 0x00 0x004>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
-- 
2.39.2




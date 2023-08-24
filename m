Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2D578735B
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbjHXPCj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242054AbjHXPCR (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:02:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F93EC7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EC0567156
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:02:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523B3C433C8;
        Thu, 24 Aug 2023 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889333;
        bh=K4eedfp1deSXNzNfh9HfdrhJ/xQ028wb+E8REO0y+gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xk3oN0RgeZrbpuPslkdxPQFQxKeAgrnpWtmX5plqcMYpAwrheD3JU7rz7BuAqEDMg
         HBFNfuuVRZk54AbJ/LXLYh4SV+4QJrydi+ndQRJ9qsu+zLhLdRltFlNjooShjzV8Qe
         +04wSxs2o4zBLsP0QIDSboJOED7MQ6Tyd2qyRmWo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, FUKAUMI Naoki <naoki@radxa.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 099/135] arm64: dts: rockchip: fix regulator name on rk3399-rock-4
Date:   Thu, 24 Aug 2023 16:50:42 +0200
Message-ID: <20230824145031.233689700@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
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

From: FUKAUMI Naoki <naoki@radxa.com>

[ Upstream commit 69448624b770aa88a71536a16900dd3cc6002919 ]

fix regulator name

ref:
 https://dl.radxa.com/rockpi4/docs/hw/rockpi4/rockpi4_v13_sch_20181112.pdf

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Link: https://lore.kernel.org/r/20220909195006.127957-4-naoki@radxa.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Stable-dep-of: cee572756aa2 ("arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 25 ++++++++++---------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index fcd8eeabf53b6..4e1c1f970aba1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -116,24 +116,25 @@
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vcc5v0_typec: vcc5v0-typec-regulator {
+	vbus_typec: vbus-typec-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&vcc5v0_typec_en>;
-		regulator-name = "vcc5v0_typec";
+		regulator-name = "vbus_typec";
 		regulator-always-on;
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vcc_lan: vcc3v3-phy-regulator {
+	vcc3v3_lan: vcc3v3-lan-regulator {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_lan";
+		regulator-name = "vcc3v3_lan";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_sys>;
 	};
 
 	vdd_log: vdd-log {
@@ -180,7 +181,7 @@
 	assigned-clocks = <&cru SCLK_RMII_SRC>;
 	assigned-clock-parents = <&clkin_gmac>;
 	clock_in_out = "input";
-	phy-supply = <&vcc_lan>;
+	phy-supply = <&vcc3v3_lan>;
 	phy-mode = "rgmii";
 	pinctrl-names = "default";
 	pinctrl-0 = <&rgmii_pins>;
@@ -285,8 +286,8 @@
 				};
 			};
 
-			vcc1v8_codec: LDO_REG1 {
-				regulator-name = "vcc1v8_codec";
+			vcca1v8_codec: LDO_REG1 {
+				regulator-name = "vcca1v8_codec";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -296,8 +297,8 @@
 				};
 			};
 
-			vcc1v8_hdmi: LDO_REG2 {
-				regulator-name = "vcc1v8_hdmi";
+			vcca1v8_hdmi: LDO_REG2 {
+				regulator-name = "vcca1v8_hdmi";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -354,8 +355,8 @@
 				};
 			};
 
-			vcc0v9_hdmi: LDO_REG7 {
-				regulator-name = "vcc0v9_hdmi";
+			vcca0v9_hdmi: LDO_REG7 {
+				regulator-name = "vcca0v9_hdmi";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <900000>;
@@ -495,7 +496,7 @@
 	status = "okay";
 
 	bt656-supply = <&vcc_3v0>;
-	audio-supply = <&vcc1v8_codec>;
+	audio-supply = <&vcca1v8_codec>;
 	sdmmc-supply = <&vcc_sdio>;
 	gpio1830-supply = <&vcc_3v0>;
 };
-- 
2.40.1




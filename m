Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08D807876DC
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 19:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240373AbjHXRUj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 13:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242588AbjHXRUK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 13:20:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7091BC2
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 10:20:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C19DB67587
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 17:20:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF585C4AF1E;
        Thu, 24 Aug 2023 17:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692897607;
        bh=UbKxGnNwrslj6utalOepnQaM/+E4Bt6UxwNHtpApro0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PRLMPiCWcF+ugeWrtSo5/b4Yi1UK3WyP/JrWR+EHUOV1jEsj1oKLifYOJSJ3dTM8G
         pJGJsY/JNkpIdYafZiTMsV5i3zrTiLiW+EevyVs88HPpnELTwujAEO7kxnQDbNJ3jd
         5RGWyMP2sAO/AgCj0iyFjZve+ZAMedAcJSEgqE34=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, FUKAUMI Naoki <naoki@radxa.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 100/135] arm64: dts: rockchip: sort nodes/properties on rk3399-rock-4
Date:   Thu, 24 Aug 2023 19:09:32 +0200
Message-ID: <20230824170621.597189271@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824170617.074557800@linuxfoundation.org>
References: <20230824170617.074557800@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: FUKAUMI Naoki <naoki@radxa.com>

[ Upstream commit 06c5b5690a578514b3fe8f11a47a3c37d3af3696 ]

sort nodes/properties alphabetically

Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
Link: https://lore.kernel.org/r/20220909195006.127957-5-naoki@radxa.com
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Stable-dep-of: cee572756aa2 ("arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../boot/dts/rockchip/rk3399-rock-pi-4.dtsi   | 124 +++++++++---------
 1 file changed, 61 insertions(+), 63 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
index 4e1c1f970aba1..360a31d2c56cc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dtsi
@@ -54,32 +54,33 @@
 		};
 	};
 
-	vcc12v_dcin: dc-12v {
+	vbus_typec: vbus-typec-regulator {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc12v_dcin";
+		enable-active-high;
+		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_typec_en>;
+		regulator-name = "vbus_typec";
 		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
+		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vcc5v0_sys: vcc-sys {
+	vcc12v_dcin: dc-12v {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc5v0_sys";
+		regulator-name = "vcc12v_dcin";
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <5000000>;
-		regulator-max-microvolt = <5000000>;
-		vin-supply = <&vcc12v_dcin>;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
 	};
 
-	vcc_0v9: vcc-0v9 {
+	vcc3v3_lan: vcc3v3-lan-regulator {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_0v9";
+		regulator-name = "vcc3v3_lan";
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <900000>;
-		regulator-max-microvolt = <900000>;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc3v3_sys>;
 	};
 
@@ -116,24 +117,23 @@
 		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vbus_typec: vbus-typec-regulator {
+	vcc5v0_sys: vcc-sys {
 		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio1 RK_PA3 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&vcc5v0_typec_en>;
-		regulator-name = "vbus_typec";
+		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
-		vin-supply = <&vcc5v0_sys>;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_dcin>;
 	};
 
-	vcc3v3_lan: vcc3v3-lan-regulator {
+	vcc_0v9: vcc-0v9 {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc3v3_lan";
+		regulator-name = "vcc_0v9";
 		regulator-always-on;
 		regulator-boot-on;
-		regulator-min-microvolt = <3300000>;
-		regulator-max-microvolt = <3300000>;
+		regulator-min-microvolt = <900000>;
+		regulator-max-microvolt = <900000>;
 		vin-supply = <&vcc3v3_sys>;
 	};
 
@@ -493,21 +493,10 @@
 };
 
 &io_domains {
-	status = "okay";
-
-	bt656-supply = <&vcc_3v0>;
 	audio-supply = <&vcca1v8_codec>;
-	sdmmc-supply = <&vcc_sdio>;
+	bt656-supply = <&vcc_3v0>;
 	gpio1830-supply = <&vcc_3v0>;
-};
-
-&pmu_io_domains {
-	status = "okay";
-
-	pmu1830-supply = <&vcc_3v0>;
-};
-
-&pcie_phy {
+	sdmmc-supply = <&vcc_sdio>;
 	status = "okay";
 };
 
@@ -523,6 +512,10 @@
 	status = "okay";
 };
 
+&pcie_phy {
+	status = "okay";
+};
+
 &pinctrl {
 	bt {
 		bt_enable_h: bt-enable-h {
@@ -544,6 +537,20 @@
 		};
 	};
 
+	pmic {
+		pmic_int_l: pmic-int-l {
+			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		vsel1_pin: vsel1-pin {
+			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		vsel2_pin: vsel2-pin {
+			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+	};
+
 	sdio0 {
 		sdio0_bus4: sdio0-bus4 {
 			rockchip,pins = <2 RK_PC4 1 &pcfg_pull_up_20ma>,
@@ -561,20 +568,6 @@
 		};
 	};
 
-	pmic {
-		pmic_int_l: pmic-int-l {
-			rockchip,pins = <1 RK_PC5 RK_FUNC_GPIO &pcfg_pull_up>;
-		};
-
-		vsel1_pin: vsel1-pin {
-			rockchip,pins = <1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-
-		vsel2_pin: vsel2-pin {
-			rockchip,pins = <1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_down>;
-		};
-	};
-
 	usb-typec {
 		vcc5v0_typec_en: vcc5v0-typec-en {
 			rockchip,pins = <1 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
@@ -598,6 +591,11 @@
 	};
 };
 
+&pmu_io_domains {
+	pmu1830-supply = <&vcc_3v0>;
+	status = "okay";
+};
+
 &pwm2 {
 	status = "okay";
 };
@@ -608,6 +606,14 @@
 	vref-supply = <&vcc_1v8>;
 };
 
+&sdhci {
+	bus-width = <8>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	non-removable;
+	status = "okay";
+};
+
 &sdio0 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -635,14 +641,6 @@
 	status = "okay";
 };
 
-&sdhci {
-	bus-width = <8>;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
-	non-removable;
-	status = "okay";
-};
-
 &spdif {
 
 	spdif_p0: port {
@@ -724,13 +722,13 @@
 	status = "okay";
 };
 
-&usbdrd_dwc3_0 {
+&usbdrd3_1 {
 	status = "okay";
-	dr_mode = "host";
 };
 
-&usbdrd3_1 {
+&usbdrd_dwc3_0 {
 	status = "okay";
+	dr_mode = "host";
 };
 
 &usbdrd_dwc3_1 {
-- 
2.40.1




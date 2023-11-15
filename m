Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0F07E2488
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjKFNWw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbjKFNWw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:22:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EFC994
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:22:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77C5C433C7;
        Mon,  6 Nov 2023 13:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276967;
        bh=BQ7hFKzgbbOCpuddj3Ud28HegzFhNvBpGHmDXK3PVEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OeVGSg4opv9D83lZ02u5m7SSyYsAMEFoNFMwESg4xOIt3PwQ5xGjvwD9HKG+V3QiZ
         0PsypqBrVlfGkXwzA+67xuBJaJ3ncKbDzBxr3LlLY6LJM1FWPZxstcYNUJhLZ/dbo7
         QpUH3fEe9WiJsS30vGIlZB6YpffqqISbn9Gk3hwE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 5.4 68/74] Revert "ARM: dts: Move am33xx and am43xx mmc nodes to sdhci-omap driver"
Date:   Mon,  6 Nov 2023 14:04:28 +0100
Message-ID: <20231106130304.033114155@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

This reverts commit d0c69c722ff16ce2481a5e0932c6d5b172109f21 which is
commit 0b4edf111870b83ea77b1d7e16b8ceac29f9f388 upstream.

The reverted commit completely breaks MMC on the AM33xx/AM437x for
multiple reasons:

- The changed compatible strings ti,am335-sdhci and ti,am437-sdhci
  aren't supported on Linux 5.4 at all, so no driver is found
- Even when additionally backporting the support for these compatible
  strings in the sdhci-omap driver, I could not the the MMC interfaces
  to work on our TQMa335x SoM - the interface would time out during card
  initialization for both an eMMC and an SD card.

I did not investigate the cause of the timeouts further, and instead
just reverted the commit - switching to a different MMC driver in a stable
kernel seems like a rather risky change unless it's thoroughly tested,
which has obviously not happened in this case.

The reverted commit is also given as a Stable-dep-of commit 2eb502f496f7
("ARM: dts: am33xx: Fix MMCHS0 dma properties"), however the conflict
resulting when only the one commit is reverted is trivial to resolve,
which leads to working MMC controllers again.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/am335x-baltos.dtsi              |    2 +-
 arch/arm/boot/dts/am335x-boneblack-common.dtsi    |    1 -
 arch/arm/boot/dts/am335x-boneblack-wireless.dts   |    1 +
 arch/arm/boot/dts/am335x-boneblue.dts             |    1 +
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts   |    1 +
 arch/arm/boot/dts/am335x-evm.dts                  |    3 ++-
 arch/arm/boot/dts/am335x-evmsk.dts                |    2 +-
 arch/arm/boot/dts/am335x-lxm.dts                  |    2 +-
 arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi |    2 +-
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts    |    2 +-
 arch/arm/boot/dts/am335x-pepper.dts               |    4 ++--
 arch/arm/boot/dts/am335x-phycore-som.dtsi         |    2 +-
 arch/arm/boot/dts/am33xx-l4.dtsi                  |    6 ++++--
 arch/arm/boot/dts/am33xx.dtsi                     |    3 +--
 arch/arm/boot/dts/am4372.dtsi                     |    3 +--
 arch/arm/boot/dts/am437x-cm-t43.dts               |    2 +-
 arch/arm/boot/dts/am437x-gp-evm.dts               |    4 ++--
 arch/arm/boot/dts/am437x-l4.dtsi                  |    5 +++--
 arch/arm/boot/dts/am437x-sk-evm.dts               |    2 +-
 19 files changed, 26 insertions(+), 22 deletions(-)

--- a/arch/arm/boot/dts/am335x-baltos.dtsi
+++ b/arch/arm/boot/dts/am335x-baltos.dtsi
@@ -381,7 +381,7 @@
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&wl12xx_vmmc>;
-	non-removable;
+	ti,non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
 	pinctrl-names = "default";
--- a/arch/arm/boot/dts/am335x-boneblack-common.dtsi
+++ b/arch/arm/boot/dts/am335x-boneblack-common.dtsi
@@ -22,7 +22,6 @@
 	pinctrl-0 = <&emmc_pins>;
 	bus-width = <8>;
 	status = "okay";
-	non-removable;
 };
 
 &am33xx_pinmux {
--- a/arch/arm/boot/dts/am335x-boneblack-wireless.dts
+++ b/arch/arm/boot/dts/am335x-boneblack-wireless.dts
@@ -75,6 +75,7 @@
 	bus-width = <4>;
 	non-removable;
 	cap-power-off-card;
+	ti,needs-special-hs-handling;
 	keep-power-in-suspend;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wl18xx_pins>;
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -389,6 +389,7 @@
 	bus-width = <4>;
 	non-removable;
 	cap-power-off-card;
+	ti,needs-special-hs-handling;
 	keep-power-in-suspend;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wl18xx_pins>;
--- a/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
+++ b/arch/arm/boot/dts/am335x-bonegreen-wireless.dts
@@ -75,6 +75,7 @@
 	bus-width = <4>;
 	non-removable;
 	cap-power-off-card;
+	ti,needs-special-hs-handling;
 	keep-power-in-suspend;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wl18xx_pins>;
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -782,7 +782,8 @@
 	bus-width = <4>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc3_pins &wlan_pins>;
-	non-removable;
+	ti,non-removable;
+	ti,needs-special-hs-handling;
 	cap-power-off-card;
 	keep-power-in-suspend;
 
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -700,7 +700,7 @@
 &mmc2 {
 	status = "okay";
 	vmmc-supply = <&wl12xx_vmmc>;
-	non-removable;
+	ti,non-removable;
 	bus-width = <4>;
 	cap-power-off-card;
 	keep-power-in-suspend;
--- a/arch/arm/boot/dts/am335x-lxm.dts
+++ b/arch/arm/boot/dts/am335x-lxm.dts
@@ -361,7 +361,7 @@
 	pinctrl-0 = <&emmc_pins>;
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 	status = "okay";
 };
 
--- a/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
+++ b/arch/arm/boot/dts/am335x-moxa-uc-2100-common.dtsi
@@ -176,7 +176,7 @@
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <8>;
 	pinctrl-0 = <&mmc1_pins_default>;
-	non-removable;
+	ti,non-removable;
 	status = "okay";
 };
 
--- a/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
+++ b/arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
@@ -473,7 +473,7 @@
 	vmmc-supply = <&vmmcsd_fixed>;
 	bus-width = <8>;
 	pinctrl-0 = <&mmc2_pins_default>;
-	non-removable;
+	ti,non-removable;
 	status = "okay";
 };
 
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -341,7 +341,7 @@
 	pinctrl-0 = <&emmc_pins>;
 	vmmc-supply = <&ldo3_reg>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 };
 
 &mmc3 {
@@ -351,7 +351,7 @@
 	pinctrl-0 = <&wireless_pins>;
 	vmmmc-supply = <&v3v3c_reg>;
 	bus-width = <4>;
-	non-removable;
+	ti,non-removable;
 	dmas = <&edma_xbar 12 0 1
 		&edma_xbar 13 0 2>;
 	dma-names = "tx", "rx";
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -69,7 +69,7 @@
 	pinctrl-0 = <&emmc_pins>;
 	vmmc-supply = <&vmmc_reg>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 	status = "disabled";
 };
 
--- a/arch/arm/boot/dts/am33xx-l4.dtsi
+++ b/arch/arm/boot/dts/am33xx-l4.dtsi
@@ -1333,8 +1333,10 @@
 			ranges = <0x0 0x60000 0x1000>;
 
 			mmc1: mmc@0 {
-				compatible = "ti,am335-sdhci";
+				compatible = "ti,omap4-hsmmc";
+				ti,dual-volt;
 				ti,needs-special-reset;
+				ti,needs-special-hs-handling;
 				dmas = <&edma 24 0>, <&edma 25 0>;
 				dma-names = "tx", "rx";
 				interrupts = <64>;
@@ -1824,7 +1826,7 @@
 			ranges = <0x0 0xd8000 0x1000>;
 
 			mmc2: mmc@0 {
-				compatible = "ti,am335-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				ti,needs-special-reset;
 				dmas = <&edma 2 0
 					&edma 3 0>;
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -259,11 +259,10 @@
 			ranges = <0x0 0x47810000 0x1000>;
 
 			mmc3: mmc@0 {
-				compatible = "ti,am335-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				ti,needs-special-reset;
 				interrupts = <29>;
 				reg = <0x0 0x1000>;
-				status = "disabled";
 			};
 		};
 
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -250,11 +250,10 @@
 			ranges = <0x0 0x47810000 0x1000>;
 
 			mmc3: mmc@0 {
-				compatible = "ti,am437-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				ti,needs-special-reset;
 				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 				reg = <0x0 0x1000>;
-				status = "disabled";
 			};
 		};
 
--- a/arch/arm/boot/dts/am437x-cm-t43.dts
+++ b/arch/arm/boot/dts/am437x-cm-t43.dts
@@ -291,7 +291,7 @@
 	pinctrl-0 = <&emmc_pins>;
 	vmmc-supply = <&vmmc_3v3>;
 	bus-width = <8>;
-	non-removable;
+	ti,non-removable;
 };
 
 &spi0 {
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -872,7 +872,7 @@
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&emmc_pins_default>;
 	pinctrl-1 = <&emmc_pins_sleep>;
-	non-removable;
+	ti,non-removable;
 };
 
 &mmc3 {
@@ -889,7 +889,7 @@
 	pinctrl-1 = <&mmc3_pins_sleep>;
 	cap-power-off-card;
 	keep-power-in-suspend;
-	non-removable;
+	ti,non-removable;
 
 	#address-cells = <1>;
 	#size-cells = <0>;
--- a/arch/arm/boot/dts/am437x-l4.dtsi
+++ b/arch/arm/boot/dts/am437x-l4.dtsi
@@ -1104,8 +1104,9 @@
 			ranges = <0x0 0x60000 0x1000>;
 
 			mmc1: mmc@0 {
-				compatible = "ti,am437-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				reg = <0x0 0x1000>;
+				ti,dual-volt;
 				ti,needs-special-reset;
 				dmas = <&edma 24 0>,
 					<&edma 25 0>;
@@ -1640,7 +1641,7 @@
 			ranges = <0x0 0xd8000 0x1000>;
 
 			mmc2: mmc@0 {
-				compatible = "ti,am437-sdhci";
+				compatible = "ti,omap4-hsmmc";
 				reg = <0x0 0x1000>;
 				ti,needs-special-reset;
 				dmas = <&edma 2 0>,
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -694,7 +694,7 @@
 	pinctrl-1 = <&mmc3_pins_sleep>;
 	cap-power-off-card;
 	keep-power-in-suspend;
-	non-removable;
+	ti,non-removable;
 
 	#address-cells = <1>;
 	#size-cells = <0>;



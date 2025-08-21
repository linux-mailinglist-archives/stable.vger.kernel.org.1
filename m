Return-Path: <stable+bounces-172030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B9CB2F955
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 15:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E88127AA91A
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 13:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4769E2DA76E;
	Thu, 21 Aug 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yBaElJhr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0791D36CDE1
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781567; cv=none; b=BHB8X0ttuE2jvDcj0TP8F5LWIRrBu5Ca3jlU+1O+9qsLWXJYXdrGeGEXw3/Ap6urAH1XJ8JgEueTrSKr3zz8KeQPb2WCpvaeSw4Tr/k+PpFPveldnXsdNLrZ1cpX5NN6Zyy/uBPevm72A/FVXPlQfuBffvucpzjCZ6um3/9B3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781567; c=relaxed/simple;
	bh=X3DLQZPHA3/pE0bFChg6xnx2IHu+R2jXpqEXtykSr74=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Yo8yAvsp7c4d607CGdft0gCXIuxxOZMEL7plz9DmrXOGch0a0PmOP8vSwMYt19cRAhBFoeyFT1olrXhrqeuXRI2656gds8cbNJPqfpFFAwkKFXupNTCS/kNwfhHkPAPMLKml9Tc+Y8PkZuSFR8so1SpXw3cn+KSscFOqwaTFfxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yBaElJhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830D9C4CEEB;
	Thu, 21 Aug 2025 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755781566;
	bh=X3DLQZPHA3/pE0bFChg6xnx2IHu+R2jXpqEXtykSr74=;
	h=Subject:To:Cc:From:Date:From;
	b=yBaElJhrsK/0Tm63O+j/6JDqtZU3jhlstWwZrZAhmYoWhP0WPr33HeEKdZCjdPG35
	 YDOTxQt9i2D52n2tUlgxzKHIYohpth8szTkvZv8t0Z5urwOVVCVxg3IE9oWK8VPB24
	 x3NSlBrvxsyZtGB+SGHpavc+IKOrJ27siLWlEhwQ=
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board" failed to apply to 6.12-stable tree
To: jm@ti.com,vigneshr@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 21 Aug 2025 15:06:04 +0200
Message-ID: <2025082104-undermost-dispute-929c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a0b8da04153eb61cc2eaeeea5cc404e91e557f6b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082104-undermost-dispute-929c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a0b8da04153eb61cc2eaeeea5cc404e91e557f6b Mon Sep 17 00:00:00 2001
From: Judith Mendez <jm@ti.com>
Date: Mon, 7 Jul 2025 14:08:30 -0500
Subject: [PATCH] arm64: dts: ti: k3-am62*: Move eMMC pinmux to top level board
 file

This moves pinmux child nodes for sdhci0 node from k3-am62x-sk-common
to each top level board file. This is needed since we require internal
pullups for AM62x SK and not for AM62 LP SK since it has external
pullups on DATA 1-7.

Internal pulls are required for AM62 SK as per JESD84 spec
recommendation to prevent unconnected lines floating.

Fixes: d19a66ae488a ("arm64: dts: ti: k3-am625-sk: Enable on board peripherals")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Link: https://lore.kernel.org/r/20250707190830.3951619-1-jm@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

diff --git a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
index aafdb90c0eb7..4609f366006e 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am62-lp-sk.dts
@@ -74,6 +74,22 @@ vddshv_sdio: regulator-4 {
 };
 
 &main_pmx0 {
+	main_mmc0_pins_default: main-mmc0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (V3) MMC0_CMD */
+			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (Y1) MMC0_CLK */
+			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (V2) MMC0_DAT0 */
+			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (V1) MMC0_DAT1 */
+			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (W2) MMC0_DAT2 */
+			AM62X_IOPAD(0x208, PIN_INPUT, 0) /* (W1) MMC0_DAT3 */
+			AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (Y2) MMC0_DAT4 */
+			AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (W3) MMC0_DAT5 */
+			AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (W4) MMC0_DAT6 */
+			AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (V4) MMC0_DAT7 */
+		>;
+	};
+
 	vddshv_sdio_pins_default: vddshv-sdio-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x07c, PIN_OUTPUT, 7) /* (M19) GPMC0_CLK.GPIO0_31 */
@@ -144,6 +160,14 @@ exp2: gpio@23 {
 	};
 };
 
+&sdhci0 {
+	bootph-all;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	status = "okay";
+};
+
 &sdhci1 {
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vddshv_sdio>;
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 2fbfa3719345..d240165bda9c 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -106,6 +106,22 @@ vcc_1v8: regulator-5 {
 };
 
 &main_pmx0 {
+	main_mmc0_pins_default: main-mmc0-default-pins {
+		bootph-all;
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
+			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
+			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
+			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
+			AM62X_IOPAD(0x208, PIN_INPUT_PULLUP, 0) /* (Y4) MMC0_DAT3 */
+			AM62X_IOPAD(0x204, PIN_INPUT_PULLUP, 0) /* (AB2) MMC0_DAT4 */
+			AM62X_IOPAD(0x200, PIN_INPUT_PULLUP, 0) /* (AC1) MMC0_DAT5 */
+			AM62X_IOPAD(0x1fc, PIN_INPUT_PULLUP, 0) /* (AD2) MMC0_DAT6 */
+			AM62X_IOPAD(0x1f8, PIN_INPUT_PULLUP, 0) /* (AC2) MMC0_DAT7 */
+		>;
+	};
+
 	main_rgmii2_pins_default: main-rgmii2-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -195,6 +211,14 @@ exp1: gpio@22 {
 	};
 };
 
+&sdhci0 {
+	bootph-all;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_mmc0_pins_default>;
+	status = "okay";
+};
+
 &sdhci1 {
 	vmmc-supply = <&vdd_mmc1>;
 	vqmmc-supply = <&vdd_sd_dv>;
diff --git a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
index ee8337bfbbfd..13e1d36123d5 100644
--- a/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
@@ -203,22 +203,6 @@ AM62X_IOPAD(0x0b4, PIN_INPUT_PULLUP, 1) /* (K24/H19) GPMC0_CSn3.I2C2_SDA */
 		>;
 	};
 
-	main_mmc0_pins_default: main-mmc0-default-pins {
-		bootph-all;
-		pinctrl-single,pins = <
-			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3/V3) MMC0_CMD */
-			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1/Y1) MMC0_CLK */
-			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2/V2) MMC0_DAT0 */
-			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (AA1/V1) MMC0_DAT1 */
-			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (AA3/W2) MMC0_DAT2 */
-			AM62X_IOPAD(0x208, PIN_INPUT, 0) /* (Y4/W1) MMC0_DAT3 */
-			AM62X_IOPAD(0x204, PIN_INPUT, 0) /* (AB2/Y2) MMC0_DAT4 */
-			AM62X_IOPAD(0x200, PIN_INPUT, 0) /* (AC1/W3) MMC0_DAT5 */
-			AM62X_IOPAD(0x1fc, PIN_INPUT, 0) /* (AD2/W4) MMC0_DAT6 */
-			AM62X_IOPAD(0x1f8, PIN_INPUT, 0) /* (AC2/V4) MMC0_DAT7 */
-		>;
-	};
-
 	main_mmc1_pins_default: main-mmc1-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
@@ -457,14 +441,6 @@ &main_i2c2 {
 	clock-frequency = <400000>;
 };
 
-&sdhci0 {
-	bootph-all;
-	status = "okay";
-	non-removable;
-	pinctrl-names = "default";
-	pinctrl-0 = <&main_mmc0_pins_default>;
-};
-
 &sdhci1 {
 	/* SD/MMC */
 	bootph-all;



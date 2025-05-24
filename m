Return-Path: <stable+bounces-146280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18269AC3055
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96DAC1BA0B5E
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A4A1EBA19;
	Sat, 24 May 2025 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RiBGDmbG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F841A5BB7
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748102059; cv=none; b=tyUkaWPNyD/ochzSHElsFsCR2DkJZqccn01rzteTEYgkskMIaaOcA983zLfBHg8S9WD7niyxO2KmzyZceqalWEZ9qwGGSwD28bF6/DiaX1+WlAqv0RTHJTSllFyEIc1k/a/+IF6DZFs+G9jgQ6vBmfLVHxTqWTce+78p7pZoTss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748102059; c=relaxed/simple;
	bh=7sMMIYdcCEvxf9/ilAXLHYxMjqUVKEIQFNTvBowhw9A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lfHB1HGHQ6XAsrVPUbDXHW5XQlf0VDmYf0qgVzEoZgiXiLsH+nrxw9zBqmi6rKjT6fHp1egSgTFuBtCPPaDeJTU4EOWI9UFEOKmRMkaTGd/TDlwi39uAuXL7LecjwKmwiBF5LySm1gNRi00hDx7NYbm5tUUi8ag3ET5S1ZgPVJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RiBGDmbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778EEC4CEE4;
	Sat, 24 May 2025 15:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748102059;
	bh=7sMMIYdcCEvxf9/ilAXLHYxMjqUVKEIQFNTvBowhw9A=;
	h=Subject:To:Cc:From:Date:From;
	b=RiBGDmbGFYRU8+Zhu5AijSs2hWzp1Q9soScRerVtwc/lrARpu9UhWr/30E8hTBd1o
	 Njmevor+KsdnVR2cY3nIHNTmkmvDM+znJzga2KZWDLpQxNCrYGFuOB/hCxtW0vqCXX
	 c/B7P/TZh8KSL+T68G5fxfemppSRgi3uFPEVIyNA=
Subject: FAILED: patch "[PATCH] arm64: dts: marvell: uDPU: define pinctrl state for alarm" failed to apply to 5.4-stable tree
To: j4g8y7@gmail.com,gregory.clement@bootlin.com,kaloz@openwrt.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:54:03 +0200
Message-ID: <2025052403-postcard-ferocious-b503@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x b04f0d89e880bc2cca6a5c73cf287082c91878da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052403-postcard-ferocious-b503@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b04f0d89e880bc2cca6a5c73cf287082c91878da Mon Sep 17 00:00:00 2001
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 9 May 2025 15:48:52 +0200
Subject: [PATCH] arm64: dts: marvell: uDPU: define pinctrl state for alarm
 LEDs

The two alarm LEDs of on the uDPU board are stopped working since
commit 78efa53e715e ("leds: Init leds class earlier").

The LEDs are driven by the GPIO{15,16} pins of the North Bridge
GPIO controller. These pins are part of the 'spi_quad' pin group
for which the 'spi' function is selected via the default pinctrl
state of the 'spi' node. This is wrong however, since in order to
allow controlling the LEDs, the pins should use the 'gpio' function.

Before the commit mentined above, the 'spi' function is selected
first by the pinctrl core before probing the spi driver, but then
it gets overridden to 'gpio' implicitly via the
devm_gpiod_get_index_optional() call from the 'leds-gpio' driver.

After the commit, the LED subsystem gets initialized before the
SPI subsystem, so the function of the pin group remains 'spi'
which in turn prevents controlling of the LEDs.

Despite the change of the initialization order, the root cause is
that the pinctrl state definition is wrong since its initial commit
0d45062cfc89 ("arm64: dts: marvell: Add device tree for uDPU board"),

To fix the problem, override the function in the 'spi_quad_pins'
node to 'gpio' and move the pinctrl state definition from the
'spi' node into the 'leds' node.

Cc: stable@vger.kernel.org # needs adjustment for < 6.1
Fixes: 0d45062cfc89 ("arm64: dts: marvell: Add device tree for uDPU board")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Signed-off-by: Imre Kaloz <kaloz@openwrt.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
index 3a9b6907185d..242820845707 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dtsi
@@ -26,6 +26,8 @@ memory@0 {
 
 	leds {
 		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&spi_quad_pins>;
 
 		led-power1 {
 			label = "udpu:green:power";
@@ -82,8 +84,6 @@ &sdhci0 {
 
 &spi0 {
 	status = "okay";
-	pinctrl-names = "default";
-	pinctrl-0 = <&spi_quad_pins>;
 
 	flash@0 {
 		compatible = "jedec,spi-nor";
@@ -108,6 +108,10 @@ partition@180000 {
 	};
 };
 
+&spi_quad_pins {
+	function = "gpio";
+};
+
 &pinctrl_nb {
 	i2c2_recovery_pins: i2c2-recovery-pins {
 		groups = "i2c2";



Return-Path: <stable+bounces-146278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DA9AC3053
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 17:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBD469E58AB
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 15:53:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5024B1EBFF0;
	Sat, 24 May 2025 15:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a2+ll2FS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115DB1A5BB7
	for <stable@vger.kernel.org>; Sat, 24 May 2025 15:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748102053; cv=none; b=aO0RadaLjVfjiIBYM6V0a0RiE/gc//4VdTZimoCBpibISIDSlx+8SuIebYGaW+Rz1Hxly0x/EYBFgA5GtXU/PN8Fbi04rd8XTBtvg7E4LKsyMsAULLNtKplWaMaGVs0CaivrebY+ORFYVoFrDyzWgGL+LHPVZ2yM37mVLHmWY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748102053; c=relaxed/simple;
	bh=reTmnan/wIdWO6cJPQQ2E1pDtarFgRGqos+6ZR43DYg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MioOTUDOmkRZlV1frGhoSi5tO9nnXDTNgX5xuAbeKv5lO+E8ysxcOEV1zVQ3xWlve3tDvsWDuBqoEMHBup9LGYwJrfR7V603q2iW9wuzvLuIQOOvOsWySq9zaJAkEsuYuvJIiWT+rPHMLnE3mPQO618RpS7UJQzp/CwkekNmTK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a2+ll2FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47022C4CEE4;
	Sat, 24 May 2025 15:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748102052;
	bh=reTmnan/wIdWO6cJPQQ2E1pDtarFgRGqos+6ZR43DYg=;
	h=Subject:To:Cc:From:Date:From;
	b=a2+ll2FSSkYRVZ6gzndSS8+jETtboO/3ZyZQV7rPs4vl+xwf7wlD8lbLpdcJrpAHb
	 ZeBBuJib/P0mjxMH4Z1AdUb2P2un/nLOPvt9GafqWlIVy2QiMrg1DSji8lWvAtJ4gP
	 Xz5kEoPcfOi3DTXIrRdkmS2NcX/srGsNe8QBhGws=
Subject: FAILED: patch "[PATCH] arm64: dts: marvell: uDPU: define pinctrl state for alarm" failed to apply to 5.15-stable tree
To: j4g8y7@gmail.com,gregory.clement@bootlin.com,kaloz@openwrt.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 24 May 2025 17:54:01 +0200
Message-ID: <2025052401-unbiased-designate-2089@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b04f0d89e880bc2cca6a5c73cf287082c91878da
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025052401-unbiased-designate-2089@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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



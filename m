Return-Path: <stable+bounces-114613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB02A2F042
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4C5188823B
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2342236FC;
	Mon, 10 Feb 2025 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pCLT7JIc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3D204860
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199126; cv=none; b=OcN8xx+t3+zLkzfShJXpFwRiVab/4hxoKwN1p5kOVxPdeJ2jBs8ZNXNPPA8A1I2MLy6l0ug52TFRKFdqbVdI96miKZpkYBUHlph2Y42Y6ZHN695pnTwDAT0oQA789YrS7pcbKBCdnhnBAdvryar2KfgG7g5AGudS0gzJJWr8e/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199126; c=relaxed/simple;
	bh=pWPshaQfulbpo6tSzK5Gr6gXO14bvEg8j8RMgDzM4ig=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gHO5ul5dP+QdDG+mzXR/w9ZxHK8Ok7sUBI2cFyEGnPwcK2XKavor0B0ac0L5R+528vSxfNVtKNIZUD7WnKPU54kWuEiHPZc+QfcAAwz3xUg3EyE+3qdMpEPQHQVvoLTEFpZioadspx+/yzdGGZ2lTpM/Ox2XXvMSdEIYr0CZGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pCLT7JIc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 432CCC4CED1;
	Mon, 10 Feb 2025 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199125;
	bh=pWPshaQfulbpo6tSzK5Gr6gXO14bvEg8j8RMgDzM4ig=;
	h=Subject:To:Cc:From:Date:From;
	b=pCLT7JIclRTXB9Z1CHMPOgghRH5soLGhRTRvEqRASTUatOU2mohYrXiMAkxfw7R02
	 hdTBHjCgl7rhDGZTc2gGBS6JRenqgsOet0pRUgAkyfAfKwFUFRKJoPx9UNDhznEvmu
	 qSITqzxZEIjz6rKjruiaueDKoJfcb6wolLD3F+qY=
Subject: FAILED: patch "[PATCH] ARM: dts: ti/omap: gta04: fix pm issues caused by spi module" failed to apply to 5.15-stable tree
To: andreas@kemnade.info,khilman@baylibre.com,rogerq@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 15:51:51 +0100
Message-ID: <2025021051-patriarch-epidermis-967b@gregkh>
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
git cherry-pick -x 0cfbd7805fe13406500e6a6f2aa08f198d5db4bd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021051-patriarch-epidermis-967b@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0cfbd7805fe13406500e6a6f2aa08f198d5db4bd Mon Sep 17 00:00:00 2001
From: Andreas Kemnade <andreas@kemnade.info>
Date: Wed, 4 Dec 2024 18:41:52 +0100
Subject: [PATCH] ARM: dts: ti/omap: gta04: fix pm issues caused by spi module

Despite CM_IDLEST1_CORE and CM_FCLKEN1_CORE behaving normal,
disabling SPI leads to messages like when suspending:
Powerdomain (core_pwrdm) didn't enter target state 0
and according to /sys/kernel/debug/pm_debug/count off state is not
entered. That was not connected to SPI during the discussion
of disabling SPI. See:
https://lore.kernel.org/linux-omap/20230122100852.32ae082c@aktux/

The reason is that SPI is per default in slave mode. Linux driver
will turn it to master per default. It slave mode, the powerdomain seems to
be kept active if active chip select input is sensed.

Fix that by explicitly disabling the SPI3 pins which used to be muxed by
the bootloader since they are available on an optionally fitted header
which would require dtb overlays anyways.

Fixes: a622310f7f01 ("ARM: dts: gta04: fix excess dma channel usage")
CC: stable@vger.kernel.org
Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
Link: https://lore.kernel.org/r/20241204174152.2360431-1-andreas@kemnade.info
Signed-off-by: Kevin Hilman <khilman@baylibre.com>

diff --git a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
index 2ee3ddd64020..536070e80b2c 100644
--- a/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/ti/omap/omap3-gta04.dtsi
@@ -446,6 +446,7 @@ &omap3_pmx_core2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <
 			&hsusb2_2_pins
+			&mcspi3hog_pins
 	>;
 
 	hsusb2_2_pins: hsusb2-2-pins {
@@ -459,6 +460,15 @@ OMAP3630_CORE2_IOPAD(0x25fa, PIN_INPUT_PULLDOWN | MUX_MODE3)	/* etk_d15.hsusb2_d
 		>;
 	};
 
+	mcspi3hog_pins: mcspi3hog-pins {
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25dc, PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* etk_d0 */
+			OMAP3630_CORE2_IOPAD(0x25de, PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* etk_d1 */
+			OMAP3630_CORE2_IOPAD(0x25e0, PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* etk_d2 */
+			OMAP3630_CORE2_IOPAD(0x25e2, PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* etk_d3 */
+		>;
+	};
+
 	spi_gpio_pins: spi-gpio-pinmux-pins {
 		pinctrl-single,pins = <
 			OMAP3630_CORE2_IOPAD(0x25d8, PIN_OUTPUT | MUX_MODE4) /* clk */



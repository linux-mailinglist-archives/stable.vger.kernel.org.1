Return-Path: <stable+bounces-204629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F3CF3059
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 11:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C053068DCC
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 10:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99325314D05;
	Mon,  5 Jan 2026 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SPxvw9zA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C26313E00
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609476; cv=none; b=H0iWCDIA6ccFpjmJzpIWSLT+KYqQ/TpcUBnnrMLyyOW3wjl7+ootrQXmLQUN4VoI0eAkre8QNww1VWNZNECGfaAJo4J4Yq8HcOIcd6LLkjfEnFjUd/oI9HlCDjiGAc+Rky7km6NYGQd6G21QIwG3LsK95nw50QAplPHDqpKd02s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609476; c=relaxed/simple;
	bh=LhKq3U5d2cMz1LifwglwYbpIVrpxCDWvI/cXjDGkx9c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EBTi6m5hQ0vUyzLK90XkkGsvYnVotfUvsF1JzxaLDSql3ZrChe5yEkxPKW94I+DR0b2ek6z4ht1LLQ1pFXF1yKAxR3LSjH4C16sLokxXrL5nPutCqlu+eJtUzz/zjWSQgQgwvAbKmUrGEWNbFv86uODQ3HCx6GdfjADl95CSSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SPxvw9zA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DBDC116D0;
	Mon,  5 Jan 2026 10:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767609476;
	bh=LhKq3U5d2cMz1LifwglwYbpIVrpxCDWvI/cXjDGkx9c=;
	h=Subject:To:Cc:From:Date:From;
	b=SPxvw9zAZuQAYSO+qY2B3IY+XtXWuVLDfGyI321WM8NA1o4zs76G1c8Xi7G63IoEj
	 YzfFoDZwA/r9gMZYd1X8d1J1mFrFnBncPoZNfxMbBKLNPvClI7ApZGlT4kYaSU0+IX
	 uY/MswwcGkDIK/T3SyuPxKdaW28lhgCxAPTniGa4=
Subject: FAILED: patch "[PATCH] arm64: dts: ti: k3-j721e-sk: Fix pinmux for pin Y1 used by" failed to apply to 6.1-stable tree
To: s-vadapalli@ti.com,vigneshr@ti.com,y-abhilashchandra@ti.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 11:37:52 +0100
Message-ID: <2026010552-unmoved-tipoff-f490@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 51f89c488f2ecc020f82bfedd77482584ce8027a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026010552-unmoved-tipoff-f490@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51f89c488f2ecc020f82bfedd77482584ce8027a Mon Sep 17 00:00:00 2001
From: Siddharth Vadapalli <s-vadapalli@ti.com>
Date: Wed, 19 Nov 2025 21:31:05 +0530
Subject: [PATCH] arm64: dts: ti: k3-j721e-sk: Fix pinmux for pin Y1 used by
 power regulator

The SoC pin Y1 is incorrectly defined in the WKUP Pinmux device-tree node
(pinctrl@4301c000) leading to the following silent failure:

    pinctrl-single 4301c000.pinctrl: mux offset out of range: 0x1dc (0x178)

According to the datasheet for the J721E SoC [0], the pin Y1 belongs to the
MAIN Pinmux device-tree node (pinctrl@11c000). This is confirmed by the
address of the pinmux register for it on page 142 of the datasheet which is
0x00011C1DC.

Hence fix it.

[0]: https://www.ti.com/lit/ds/symlink/tda4vm.pdf

Fixes: 97b67cc102dc ("arm64: dts: ti: k3-j721e-sk: Add DT nodes for power regulators")
Cc: stable@vger.kernel.org
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Yemike Abhilash Chandra <y-abhilashchandra@ti.com>
Link: https://patch.msgid.link/20251119160148.2752616-1-s-vadapalli@ti.com
Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 542eabfb48db..050776cb4df8 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -474,6 +474,12 @@ rpi_header_gpio1_pins_default: rpi-header-gpio1-default-pins {
 			J721E_IOPAD(0x234, PIN_INPUT, 7) /* (U3) EXT_REFCLK1.GPIO1_12 */
 		>;
 	};
+
+	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
+		pinctrl-single,pins = <
+			J721E_IOPAD(0x1dc, PIN_OUTPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */
+		>;
+	};
 };
 
 &wkup_pmx0 {
@@ -536,12 +542,6 @@ J721E_WKUP_IOPAD(0xd4, PIN_OUTPUT, 7) /* (G26) WKUP_GPIO0_9 */
 		>;
 	};
 
-	vdd_sd_dv_pins_default: vdd-sd-dv-default-pins {
-		pinctrl-single,pins = <
-			J721E_IOPAD(0x1dc, PIN_OUTPUT, 7) /* (Y1) SPI1_CLK.GPIO0_118 */
-		>;
-	};
-
 	wkup_uart0_pins_default: wkup-uart0-default-pins {
 		pinctrl-single,pins = <
 			J721E_WKUP_IOPAD(0xa0, PIN_INPUT, 0) /* (J29) WKUP_UART0_RXD */



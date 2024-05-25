Return-Path: <stable+bounces-46154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4D98CEF9A
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 17:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437F11F215AC
	for <lists+stable@lfdr.de>; Sat, 25 May 2024 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADAD101F4;
	Sat, 25 May 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="onrE2mQ5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4FE15A4
	for <stable@vger.kernel.org>; Sat, 25 May 2024 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716649220; cv=none; b=V0Z3x7/k0b6966N07bfTsCC1KMCZ5HGeMeStci6KPEtcs5YbmZ9oClQrShF+YBhaJ90sRfNdNydel0bm5V+9CpT/dp+xE6Hy5m8XYi5kL6XOBLTNujW6nY5wCTTPYbbuNNUJzq5aTgwjYPtfveilnR7Mx+LOe0yfqfef81fS/Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716649220; c=relaxed/simple;
	bh=PqihlDYmgDyZm5C/tguhXSFYxOtw+166FOgorx2d02c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nbY5OuEOD5JJtkrUsQsz4AS8aiDnG8IgopkwOg+N2yS9722efyS6NzBJ0n9mcN1uFd2DLFZMBlmYgp5sU97urvCJci0X4svgd9boBS0tzWUzdMkT7uWgAwsgVc0mtweZ3HdvZ/Lh9BenYl8VC17gHwW2ExMEhqRIsjIKFX4JVe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=onrE2mQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC5FC3277B;
	Sat, 25 May 2024 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716649220;
	bh=PqihlDYmgDyZm5C/tguhXSFYxOtw+166FOgorx2d02c=;
	h=Subject:To:Cc:From:Date:From;
	b=onrE2mQ5kHbYtU0m9q8LiMHRh3MT8XX8rgL3+eTwP+2lFbUVhRUdDlhvZbhC5tION
	 hZsZyWyziHSZGbJ7eaHBQ13g4t47+XbsGNePm2ABjxlXBl4nQ3dTC3+tB1uH607L/6
	 PVM83CUGuyX5Q49mmCGhKKx4prRPG7HeCvCStiVQ=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when using" failed to apply to 5.4-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,jirislaby@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 25 May 2024 17:00:08 +0200
Message-ID: <2024052508-corporate-mayday-15b7@gregkh>
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
git cherry-pick -x 8492bd91aa055907c67ef04f2b56f6dadd1f44bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024052508-corporate-mayday-15b7@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8492bd91aa055907c67ef04f2b56f6dadd1f44bf Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue, 30 Apr 2024 16:04:30 -0400
Subject: [PATCH] serial: sc16is7xx: fix bug in sc16is7xx_set_baud() when using
 prescaler

When using a high speed clock with a low baud rate, the 4x prescaler is
automatically selected if required. In that case, sc16is7xx_set_baud()
properly configures the chip registers, but returns an incorrect baud
rate by not taking into account the prescaler value. This incorrect baud
rate is then fed to uart_update_timeout().

For example, with an input clock of 80MHz, and a selected baud rate of 50,
sc16is7xx_set_baud() will return 200 instead of 50.

Fix this by first changing the prescaler variable to hold the selected
prescaler value instead of the MCR bitfield. Then properly take into
account the selected prescaler value in the return value computation.

Also add better documentation about the divisor value computation.

Fixes: dfeae619d781 ("serial: sc16is7xx")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20240430200431.4102923-1-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 929206a9a6e1..12915fffac27 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -554,16 +554,28 @@ static bool sc16is7xx_regmap_noinc(struct device *dev, unsigned int reg)
 	return reg == SC16IS7XX_RHR_REG;
 }
 
+/*
+ * Configure programmable baud rate generator (divisor) according to the
+ * desired baud rate.
+ *
+ * From the datasheet, the divisor is computed according to:
+ *
+ *              XTAL1 input frequency
+ *             -----------------------
+ *                    prescaler
+ * divisor = ---------------------------
+ *            baud-rate x sampling-rate
+ */
 static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	u8 lcr;
-	u8 prescaler = 0;
+	unsigned int prescaler = 1;
 	unsigned long clk = port->uartclk, div = clk / 16 / baud;
 
 	if (div >= BIT(16)) {
-		prescaler = SC16IS7XX_MCR_CLKSEL_BIT;
-		div /= 4;
+		prescaler = 4;
+		div /= prescaler;
 	}
 
 	/* Enable enhanced features */
@@ -573,9 +585,10 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 			      SC16IS7XX_EFR_ENABLE_BIT);
 	sc16is7xx_efr_unlock(port);
 
+	/* If bit MCR_CLKSEL is set, the divide by 4 prescaler is activated. */
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,
-			      prescaler);
+			      prescaler == 1 ? 0 : SC16IS7XX_MCR_CLKSEL_BIT);
 
 	/* Backup LCR and access special register set (DLL/DLH) */
 	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
@@ -591,7 +604,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	/* Restore LCR and access to general register set */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	return DIV_ROUND_CLOSEST(clk / 16, div);
+	return DIV_ROUND_CLOSEST((clk / prescaler) / 16, div);
 }
 
 static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,



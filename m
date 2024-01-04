Return-Path: <stable+bounces-9700-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C13E82450A
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 16:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D6AE1C22268
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 15:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE27E24206;
	Thu,  4 Jan 2024 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jqVHExVb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8835C241E6
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 15:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947FCC433C7;
	Thu,  4 Jan 2024 15:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704382442;
	bh=vcNn4OFTnTYMUrAxYNZn0SQIimjEckPSXtKAkM4zu0o=;
	h=Subject:To:From:Date:From;
	b=jqVHExVb4Y7WWTsadNWWJYod8K0OEZU0C/P0Kjz4PU6m8AQ3X0ruDnChMCGuiTH03
	 uZyinW5dr5Fdz8TvUo0GOLy0bmPAa/4hhxyDowpNTuDaP8hEQ25JWf56wJcN4jD8CA
	 /CHBVYwU9H1R5xNP4iFqcpOWdCW2oDLqGdQz8FU4=
Subject: patch "serial: core, imx: do not set RS485 enabled if it is not supported" added to tty-testing
To: l.sanfilippo@kunbus.com,gregkh@linuxfoundation.org,ilpo.jarvinen@linux.intel.com,s.hauer@pengutronix.de,shawnguo@kernel.org,stable@vger.kernel.org,u.kleine-koenig@pengutronix.de
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jan 2024 16:33:51 +0100
Message-ID: <2024010451-crumpet-aloof-f69d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: core, imx: do not set RS485 enabled if it is not supported

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 74eab89b26ac433ad857292f4707b43c1a8f0209 Mon Sep 17 00:00:00 2001
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Date: Wed, 3 Jan 2024 07:18:16 +0100
Subject: serial: core, imx: do not set RS485 enabled if it is not supported
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the imx driver cannot support RS485 it nullifies the ports
rs485_supported structure. But it still calls uart_get_rs485_mode() which
may set the RS485_ENABLED flag nevertheless.

This may lead to an attempt to configure RS485 even if it is not supported
when the flag is evaluated in uart_configure_port() at port startup.

Avoid this by bailing out of uart_get_rs485_mode() if the RS485_ENABLED
flag is not supported by the caller.

With this fix a check for RTS availability is now obsolete in the imx
driver, since it can not evaluate to true any more. So remove this check.

Furthermore the explicit nullifcation of rs485_supported is not needed,
since the memory has already been set to zeros at allocation. So remove
this, too.

Fixes: 00d7a00e2a6f ("serial: imx: Fill in rs485_supported")
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc:  <stable@vger.kernel.org>
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240103061818.564-6-l.sanfilippo@kunbus.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/imx.c         | 7 -------
 drivers/tty/serial/serial_core.c | 3 +++
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 8b7d9c5a7455..4aa72d5aeafb 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2211,7 +2211,6 @@ static enum hrtimer_restart imx_trigger_stop_tx(struct hrtimer *t)
 	return HRTIMER_NORESTART;
 }
 
-static const struct serial_rs485 imx_no_rs485 = {};	/* No RS485 if no RTS */
 static const struct serial_rs485 imx_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
 		 SER_RS485_RX_DURING_TX,
@@ -2295,8 +2294,6 @@ static int imx_uart_probe(struct platform_device *pdev)
 	/* RTS is required to control the RS485 transmitter */
 	if (sport->have_rtscts || sport->have_rtsgpio)
 		sport->port.rs485_supported = imx_rs485_supported;
-	else
-		sport->port.rs485_supported = imx_no_rs485;
 	sport->port.flags = UPF_BOOT_AUTOCONF;
 	timer_setup(&sport->timer, imx_uart_timeout, 0);
 
@@ -2331,10 +2328,6 @@ static int imx_uart_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_clk;
 
-	if (sport->port.rs485.flags & SER_RS485_ENABLED &&
-	    (!sport->have_rtscts && !sport->have_rtsgpio))
-		dev_err(&pdev->dev, "no RTS control, disabling rs485\n");
-
 	/*
 	 * If using the i.MX UART RTS/CTS control then the RTS (CTS_B)
 	 * signal cannot be set low during transmission in case the
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b9606db78c92..b56ed8c376b2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3607,6 +3607,9 @@ int uart_get_rs485_mode(struct uart_port *port)
 	u32 rs485_delay[2];
 	int ret;
 
+	if (!(port->rs485_supported.flags & SER_RS485_ENABLED))
+		return 0;
+
 	ret = device_property_read_u32_array(dev, "rs485-rts-delay",
 					     rs485_delay, 2);
 	if (!ret) {
-- 
2.43.0




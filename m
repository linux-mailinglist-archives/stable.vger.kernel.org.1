Return-Path: <stable+bounces-9701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D7982450B
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 16:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B541C22278
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 15:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF61241FD;
	Thu,  4 Jan 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JWzalPfL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDB241E6
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 15:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EB2BC433C7;
	Thu,  4 Jan 2024 15:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704382444;
	bh=2ei1v68MjFAdw0DHgYzaQcLuoYDliM4IUUJ+8hA0kHA=;
	h=Subject:To:From:Date:From;
	b=JWzalPfL6k2B8CFOIuDZ/lRrg1rzCrp+ijADTSVlwo1W2jtKHC1tPFjB30Glij6HT
	 yoIrHKk/xW74eXmz57mCsW7S47aT4wKxYM7nfXRcX7VEuvaAFY/ilQUKrbxyhB/Egg
	 N/h4fAHCnbgoYcdZ18/0NbHcMT3HMUfO8eoDcMoA=
Subject: patch "serial: omap: do not override settings for RS485 support" added to tty-testing
To: l.sanfilippo@kunbus.com,gregkh@linuxfoundation.org,ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jan 2024 16:33:52 +0100
Message-ID: <2024010452-fade-elated-89f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: omap: do not override settings for RS485 support

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 51f93776b84dee23e44a7be880736669a01cec2b Mon Sep 17 00:00:00 2001
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Date: Wed, 3 Jan 2024 07:18:17 +0100
Subject: serial: omap: do not override settings for RS485 support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The drivers RS485 support is deactivated if there is no RTS GPIO available.
This is done by nullifying the ports rs485_supported struct. After that
however the settings in serial_omap_rs485_supported are assigned to the
same structure unconditionally, which results in an unintended reactivation
of RS485 support.

Fix this by moving the assignment to the beginning of
serial_omap_probe_rs485() and thus before uart_get_rs485_mode() gets
called.

Also replace the assignment of rs485_config() to have the complete RS485
setup in one function.

Fixes: e2752ae3cfc9 ("serial: omap: Disallow RS-485 if rts-gpio is not specified")
Cc:  <stable@vger.kernel.org>
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240103061818.564-7-l.sanfilippo@kunbus.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/omap-serial.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 730755621879..f5a0b401af63 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1483,6 +1483,13 @@ static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
 	return omap_up_info;
 }
 
+static const struct serial_rs485 serial_omap_rs485_supported = {
+	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
+		 SER_RS485_RX_DURING_TX,
+	.delay_rts_before_send = 1,
+	.delay_rts_after_send = 1,
+};
+
 static int serial_omap_probe_rs485(struct uart_omap_port *up,
 				   struct device *dev)
 {
@@ -1497,6 +1504,9 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
 	if (!np)
 		return 0;
 
+	up->port.rs485_config = serial_omap_config_rs485;
+	up->port.rs485_supported = serial_omap_rs485_supported;
+
 	ret = uart_get_rs485_mode(&up->port);
 	if (ret)
 		return ret;
@@ -1531,13 +1541,6 @@ static int serial_omap_probe_rs485(struct uart_omap_port *up,
 	return 0;
 }
 
-static const struct serial_rs485 serial_omap_rs485_supported = {
-	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
-		 SER_RS485_RX_DURING_TX,
-	.delay_rts_before_send = 1,
-	.delay_rts_after_send = 1,
-};
-
 static int serial_omap_probe(struct platform_device *pdev)
 {
 	struct omap_uart_port_info *omap_up_info = dev_get_platdata(&pdev->dev);
@@ -1604,17 +1607,11 @@ static int serial_omap_probe(struct platform_device *pdev)
 		dev_info(up->port.dev, "no wakeirq for uart%d\n",
 			 up->port.line);
 
-	ret = serial_omap_probe_rs485(up, &pdev->dev);
-	if (ret < 0)
-		goto err_rs485;
-
 	sprintf(up->name, "OMAP UART%d", up->port.line);
 	up->port.mapbase = mem->start;
 	up->port.membase = base;
 	up->port.flags = omap_up_info->flags;
 	up->port.uartclk = omap_up_info->uartclk;
-	up->port.rs485_config = serial_omap_config_rs485;
-	up->port.rs485_supported = serial_omap_rs485_supported;
 	if (!up->port.uartclk) {
 		up->port.uartclk = DEFAULT_CLK_SPEED;
 		dev_warn(&pdev->dev,
@@ -1622,6 +1619,10 @@ static int serial_omap_probe(struct platform_device *pdev)
 			 DEFAULT_CLK_SPEED);
 	}
 
+	ret = serial_omap_probe_rs485(up, &pdev->dev);
+	if (ret < 0)
+		goto err_rs485;
+
 	up->latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	up->calc_latency = PM_QOS_CPU_LATENCY_DEFAULT_VALUE;
 	cpu_latency_qos_add_request(&up->pm_qos_request, up->latency);
-- 
2.43.0




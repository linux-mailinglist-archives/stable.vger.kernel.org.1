Return-Path: <stable+bounces-9753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 702BE8250BA
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 10:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96E5D1C22AB3
	for <lists+stable@lfdr.de>; Fri,  5 Jan 2024 09:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DEA22EF0;
	Fri,  5 Jan 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnZSstPs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B0B24B21
	for <stable@vger.kernel.org>; Fri,  5 Jan 2024 09:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86CBC433C8;
	Fri,  5 Jan 2024 09:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704446540;
	bh=WcNHOWHpueOJwAsJWlGPcbVAlr5FCaJxRRcHos+l9Vk=;
	h=Subject:To:From:Date:From;
	b=KnZSstPs4YPslGor9PixqnH62qEzzkrT/1E81e0BEyHrt1/I7uGfqMPL48Oga/0/O
	 9eKByzOC3+eCCSaxfSvDCIckFhbEJq1MTdr4ciL3GB4IKSvrqhcXUZwkUOcnHjn2i/
	 II1xB8AIgZyyslbWaEa46i1YSMoMmKMExOQsZ8OY=
Subject: patch "serial: Do not hold the port lock when setting rx-during-tx GPIO" added to tty-next
To: l.sanfilippo@kunbus.com,gregkh@linuxfoundation.org,s.hauer@pengutronix.de,shawnguo@kernel.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Jan 2024 10:21:45 +0100
Message-ID: <2024010545-pendant-salute-e641@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: Do not hold the port lock when setting rx-during-tx GPIO

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 07c30ea5861fb26a77dade8cdc787252f6122fb1 Mon Sep 17 00:00:00 2001
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Date: Wed, 3 Jan 2024 07:18:12 +0100
Subject: serial: Do not hold the port lock when setting rx-during-tx GPIO

Both the imx and stm32 driver set the rx-during-tx GPIO in rs485_config().
Since this function is called with the port lock held, this can be a
problem in case that setting the GPIO line can sleep (e.g. if a GPIO
expander is used which is connected via SPI or I2C).

Avoid this issue by moving the GPIO setting outside of the port lock into
the serial core and thus making it a generic feature.

Also with commit c54d48543689 ("serial: stm32: Add support for rs485
RX_DURING_TX output GPIO") the SER_RS485_RX_DURING_TX flag is only set if a
rx-during-tx GPIO is _not_ available, which is wrong. Fix this, too.

Furthermore reset old GPIO settings in case that changing the RS485
configuration failed.

Fixes: c54d48543689 ("serial: stm32: Add support for rs485 RX_DURING_TX output GPIO")
Fixes: ca530cfa968c ("serial: imx: Add support for RS485 RX_DURING_TX output GPIO")
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc:  <stable@vger.kernel.org>
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Link: https://lore.kernel.org/r/20240103061818.564-2-l.sanfilippo@kunbus.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/imx.c         |  4 ----
 drivers/tty/serial/serial_core.c | 26 ++++++++++++++++++++++++--
 drivers/tty/serial/stm32-usart.c |  8 ++------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a0fcf18cbeac..8b7d9c5a7455 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1948,10 +1948,6 @@ static int imx_uart_rs485_config(struct uart_port *port, struct ktermios *termio
 	    rs485conf->flags & SER_RS485_RX_DURING_TX)
 		imx_uart_start_rx(port);
 
-	if (port->rs485_rx_during_tx_gpio)
-		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
-					 !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
-
 	return 0;
 }
 
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index cc866da50b81..8d381c283cec 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1407,6 +1407,16 @@ static void uart_set_rs485_termination(struct uart_port *port,
 				 !!(rs485->flags & SER_RS485_TERMINATE_BUS));
 }
 
+static void uart_set_rs485_rx_during_tx(struct uart_port *port,
+					const struct serial_rs485 *rs485)
+{
+	if (!(rs485->flags & SER_RS485_ENABLED))
+		return;
+
+	gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
+				 !!(rs485->flags & SER_RS485_RX_DURING_TX));
+}
+
 static int uart_rs485_config(struct uart_port *port)
 {
 	struct serial_rs485 *rs485 = &port->rs485;
@@ -1418,12 +1428,17 @@ static int uart_rs485_config(struct uart_port *port)
 
 	uart_sanitize_serial_rs485(port, rs485);
 	uart_set_rs485_termination(port, rs485);
+	uart_set_rs485_rx_during_tx(port, rs485);
 
 	uart_port_lock_irqsave(port, &flags);
 	ret = port->rs485_config(port, NULL, rs485);
 	uart_port_unlock_irqrestore(port, flags);
-	if (ret)
+	if (ret) {
 		memset(rs485, 0, sizeof(*rs485));
+		/* unset GPIOs */
+		gpiod_set_value_cansleep(port->rs485_term_gpio, 0);
+		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio, 0);
+	}
 
 	return ret;
 }
@@ -1462,6 +1477,7 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 		return ret;
 	uart_sanitize_serial_rs485(port, &rs485);
 	uart_set_rs485_termination(port, &rs485);
+	uart_set_rs485_rx_during_tx(port, &rs485);
 
 	uart_port_lock_irqsave(port, &flags);
 	ret = port->rs485_config(port, &tty->termios, &rs485);
@@ -1473,8 +1489,14 @@ static int uart_set_rs485_config(struct tty_struct *tty, struct uart_port *port,
 			port->ops->set_mctrl(port, port->mctrl);
 	}
 	uart_port_unlock_irqrestore(port, flags);
-	if (ret)
+	if (ret) {
+		/* restore old GPIO settings */
+		gpiod_set_value_cansleep(port->rs485_term_gpio,
+			!!(port->rs485.flags & SER_RS485_TERMINATE_BUS));
+		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
+			!!(port->rs485.flags & SER_RS485_RX_DURING_TX));
 		return ret;
+	}
 
 	if (copy_to_user(rs485_user, &port->rs485, sizeof(port->rs485)))
 		return -EFAULT;
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 9781c143def2..794b77512740 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -226,12 +226,6 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
 
 	stm32_usart_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
 
-	if (port->rs485_rx_during_tx_gpio)
-		gpiod_set_value_cansleep(port->rs485_rx_during_tx_gpio,
-					 !!(rs485conf->flags & SER_RS485_RX_DURING_TX));
-	else
-		rs485conf->flags |= SER_RS485_RX_DURING_TX;
-
 	if (rs485conf->flags & SER_RS485_ENABLED) {
 		cr1 = readl_relaxed(port->membase + ofs->cr1);
 		cr3 = readl_relaxed(port->membase + ofs->cr3);
@@ -256,6 +250,8 @@ static int stm32_usart_config_rs485(struct uart_port *port, struct ktermios *ter
 
 		writel_relaxed(cr3, port->membase + ofs->cr3);
 		writel_relaxed(cr1, port->membase + ofs->cr1);
+
+		rs485conf->flags |= SER_RS485_RX_DURING_TX;
 	} else {
 		stm32_usart_clr_bits(port, ofs->cr3,
 				     USART_CR3_DEM | USART_CR3_DEP);
-- 
2.43.0




Return-Path: <stable+bounces-12747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66527837206
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90A6E1C2ACE5
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E9E40BEE;
	Mon, 22 Jan 2024 18:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cc30grH8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DE9405D0
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949305; cv=none; b=adWrk3Vz1BI1ALYnemQHZyibMRTkQ22+jD8DaIVAYvZzfN6r5ZD+wzlaqUiFFfSCHKm8nqQF0MkAhMi8TINGkKKNfOvWCpZ8KBtrmPZOPH7koKe4GyF0Vy59+9tC/S0K6TrGAqONNjlZ6mvb2D1iS4BV4B9UBU75Ev5ysH18wd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949305; c=relaxed/simple;
	bh=7eXbLTRZxLKxxf3whMambHra194Pfv8sLUJdFEtyzXs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XxSpq61IjuCOthl+d2LfRMjJvP3FHBoJf2hn1MRDGULff4bmVy815YbTydzJjKHuGKlt9dxM8wLXDT3dy1OPesN3ytpZWOffCzS4K8BHvba6xkr+2vWUB8R5/FFgnAyVQrRhH5WLBpfDvetXAB731mbznOhFwxQaL5EEWcqIGBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cc30grH8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43084C433C7;
	Mon, 22 Jan 2024 18:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705949305;
	bh=7eXbLTRZxLKxxf3whMambHra194Pfv8sLUJdFEtyzXs=;
	h=Subject:To:Cc:From:Date:From;
	b=Cc30grH8u4ojHN72zENH5VZ6A0gLNIxtXudsug65YlZASaBejQ1+VW+AQJf1dEoh7
	 KnR61FDZfdYtHQFvI+yGK/fQ5F/0cJMlXZyqBpiEt3Ia+m5UHDbuQHj3aC+/OhNV6D
	 OFe54bbm63643jfihmAT4btfCCv/yM87qc8C58dU=
Subject: FAILED: patch "[PATCH] serial: Do not hold the port lock when setting rx-during-tx" failed to apply to 6.6-stable tree
To: l.sanfilippo@kunbus.com,gregkh@linuxfoundation.org,s.hauer@pengutronix.de,shawnguo@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 22 Jan 2024 10:48:04 -0800
Message-ID: <2024012204-tattered-oxidation-ac0c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 07c30ea5861fb26a77dade8cdc787252f6122fb1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012204-tattered-oxidation-ac0c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

07c30ea5861f ("serial: Do not hold the port lock when setting rx-during-tx GPIO")
fe2017ba24f3 ("Merge 6.6-rc6 into tty-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 07c30ea5861fb26a77dade8cdc787252f6122fb1 Mon Sep 17 00:00:00 2001
From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Date: Wed, 3 Jan 2024 07:18:12 +0100
Subject: [PATCH] serial: Do not hold the port lock when setting rx-during-tx
 GPIO

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



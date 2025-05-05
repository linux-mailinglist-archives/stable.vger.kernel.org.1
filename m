Return-Path: <stable+bounces-140761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E25E9AAAF24
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0D71BC0F17
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C5472F5F97;
	Mon,  5 May 2025 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYef9bAm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB1391A7D;
	Mon,  5 May 2025 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486172; cv=none; b=Oqw2NQ9OjpXm6qwBHREa2kjYhCUWQv1RPgNQKDQOwHqgq8Bx9+XiH+XmxeJjGL91C43Y3pPvtyvOFnlgVtuqMkv8yAYoNrqI2mvWtfUyyaUctIBuwO6UMgd9idc/T1/T0+/nMttTAgtAf+qq+SEdQnWTV4cMxywTLzQBoYNJ6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486172; c=relaxed/simple;
	bh=kHidY8XyaKPgujESjHx+QB172kiQKmkkr3z6d135WBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgUDzL7jQEAjHEGy/VAO7hf/+x5tbLtIlnHTZwueWYQFi8XWHMYpspV+D5k4d7CJP8F0OnyJciByHQSNldrQVKF3VBoEt9BAOXwpvyRos++IMxeMjqOVVHPaI3+qSX0A21nDczaMERly0X73WFUI8fJybDjrsEh+w4C1aR6FzxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYef9bAm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D39C4CEE4;
	Mon,  5 May 2025 23:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486172;
	bh=kHidY8XyaKPgujESjHx+QB172kiQKmkkr3z6d135WBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYef9bAmEUz2XqFnWDdYj0PthOhNb/oZUWQ7UPclRJBNt1TYFVnkwzIH8mfXY7CGA
	 KZzrIUaa6KQA5uO4kJk89JMalKyEuUZG5e7SmNNWyeHa0EBn6457IpIk+kodbZZPuK
	 IcdeLgpeN5BIPU5NNBUndoYjDpwzO3L77+xqqHfSFhJKvdFlwvemzy4x+YDwaYF/qW
	 55ecJwqrNuxJsC2Mh/rmoBvwAThFOJ4CoCoAr3rSzHlFCt5OngJXfTfEvkYT5pkl+N
	 LUGoq8cT1u4mUHipKDfykcSfMN8eO/JF0pK91+/Ea0gOQgBTWtt4ktuURR1dzM4FDT
	 iZDzDc7GJDWEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Richard Genoud <richard.genoud@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	corbet@lwn.net,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	shawnguo@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	john.ogness@linutronix.de,
	pmladek@suse.com,
	arnd@arndb.de,
	namcao@linutronix.de,
	benjamin.larsson@genexis.eu,
	schnelle@linux.ibm.com,
	esben@geanix.com,
	zack.rusin@broadcom.com,
	festevam@gmail.com,
	marex@denx.de,
	stefan.eichenberger@toradex.com,
	linux@rasmusvillemoes.dk,
	tglx@linutronix.de,
	jeff.johnson@oss.qualcomm.com,
	linux@treblig.org,
	geert+renesas@glider.be,
	wsa+renesas@sang-engineering.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	ben.wolsieffer@hefring.com,
	cheick.traore@foss.st.com,
	u.kleine-koenig@baylibre.com,
	linux-serial@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH AUTOSEL 6.6 186/294] serial: mctrl_gpio: split disable_ms into sync and no_sync APIs
Date: Mon,  5 May 2025 18:54:46 -0400
Message-Id: <20250505225634.2688578-186-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
Content-Transfer-Encoding: 8bit

From: Alexis Lothoré <alexis.lothore@bootlin.com>

[ Upstream commit 1bd2aad57da95f7f2d2bb52f7ad15c0f4993a685 ]

The following splat has been observed on a SAMA5D27 platform using
atmel_serial:

BUG: sleeping function called from invalid context at kernel/irq/manage.c:738
in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 27, name: kworker/u5:0
preempt_count: 1, expected: 0
INFO: lockdep is turned off.
irq event stamp: 0
hardirqs last  enabled at (0): [<00000000>] 0x0
hardirqs last disabled at (0): [<c01588f0>] copy_process+0x1c4c/0x7bec
softirqs last  enabled at (0): [<c0158944>] copy_process+0x1ca0/0x7bec
softirqs last disabled at (0): [<00000000>] 0x0
CPU: 0 UID: 0 PID: 27 Comm: kworker/u5:0 Not tainted 6.13.0-rc7+ #74
Hardware name: Atmel SAMA5
Workqueue: hci0 hci_power_on [bluetooth]
Call trace:
  unwind_backtrace from show_stack+0x18/0x1c
  show_stack from dump_stack_lvl+0x44/0x70
  dump_stack_lvl from __might_resched+0x38c/0x598
  __might_resched from disable_irq+0x1c/0x48
  disable_irq from mctrl_gpio_disable_ms+0x74/0xc0
  mctrl_gpio_disable_ms from atmel_disable_ms.part.0+0x80/0x1f4
  atmel_disable_ms.part.0 from atmel_set_termios+0x764/0x11e8
  atmel_set_termios from uart_change_line_settings+0x15c/0x994
  uart_change_line_settings from uart_set_termios+0x2b0/0x668
  uart_set_termios from tty_set_termios+0x600/0x8ec
  tty_set_termios from ttyport_set_flow_control+0x188/0x1e0
  ttyport_set_flow_control from wilc_setup+0xd0/0x524 [hci_wilc]
  wilc_setup [hci_wilc] from hci_dev_open_sync+0x330/0x203c [bluetooth]
  hci_dev_open_sync [bluetooth] from hci_dev_do_open+0x40/0xb0 [bluetooth]
  hci_dev_do_open [bluetooth] from hci_power_on+0x12c/0x664 [bluetooth]
  hci_power_on [bluetooth] from process_one_work+0x998/0x1a38
  process_one_work from worker_thread+0x6e0/0xfb4
  worker_thread from kthread+0x3d4/0x484
  kthread from ret_from_fork+0x14/0x28

This warning is emitted when trying to toggle, at the highest level,
some flow control (with serdev_device_set_flow_control) in a device
driver. At the lowest level, the atmel_serial driver is using
serial_mctrl_gpio lib to enable/disable the corresponding IRQs
accordingly.  The warning emitted by CONFIG_DEBUG_ATOMIC_SLEEP is due to
disable_irq (called in mctrl_gpio_disable_ms) being possibly called in
some atomic context (some tty drivers perform modem lines configuration
in regions protected by port lock).

Split mctrl_gpio_disable_ms into two differents APIs, a non-blocking one
and a blocking one. Replace mctrl_gpio_disable_ms calls with the
relevant version depending on whether the call is protected by some port
lock.

Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Acked-by: Richard Genoud <richard.genoud@bootlin.com>
Link: https://lore.kernel.org/r/20250217-atomic_sleep_mctrl_serial_gpio-v3-1-59324b313eef@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/driver-api/serial/driver.rst |  2 +-
 drivers/tty/serial/8250/8250_port.c        |  2 +-
 drivers/tty/serial/atmel_serial.c          |  2 +-
 drivers/tty/serial/imx.c                   |  2 +-
 drivers/tty/serial/serial_mctrl_gpio.c     | 34 +++++++++++++++++-----
 drivers/tty/serial/serial_mctrl_gpio.h     | 17 +++++++++--
 drivers/tty/serial/sh-sci.c                |  2 +-
 drivers/tty/serial/stm32-usart.c           |  2 +-
 8 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/Documentation/driver-api/serial/driver.rst b/Documentation/driver-api/serial/driver.rst
index 84b43061c11be..60434f2b02863 100644
--- a/Documentation/driver-api/serial/driver.rst
+++ b/Documentation/driver-api/serial/driver.rst
@@ -103,4 +103,4 @@ Some helpers are provided in order to set/get modem control lines via GPIO.
 .. kernel-doc:: drivers/tty/serial/serial_mctrl_gpio.c
    :identifiers: mctrl_gpio_init mctrl_gpio_free mctrl_gpio_to_gpiod
            mctrl_gpio_set mctrl_gpio_get mctrl_gpio_enable_ms
-           mctrl_gpio_disable_ms
+           mctrl_gpio_disable_ms_sync mctrl_gpio_disable_ms_no_sync
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index c2778300e1510..d5ad6cae6b652 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1676,7 +1676,7 @@ static void serial8250_disable_ms(struct uart_port *port)
 	if (up->bugs & UART_BUG_NOMSR)
 		return;
 
-	mctrl_gpio_disable_ms(up->gpios);
+	mctrl_gpio_disable_ms_no_sync(up->gpios);
 
 	up->ier &= ~UART_IER_MSI;
 	serial_port_out(port, UART_IER, up->ier);
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index bcca5627afaca..85559d9b35d83 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -698,7 +698,7 @@ static void atmel_disable_ms(struct uart_port *port)
 
 	atmel_port->ms_irq_enabled = false;
 
-	mctrl_gpio_disable_ms(atmel_port->gpios);
+	mctrl_gpio_disable_ms_no_sync(atmel_port->gpios);
 
 	if (!mctrl_gpio_to_gpiod(atmel_port->gpios, UART_GPIO_CTS))
 		idr |= ATMEL_US_CTSIC;
diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 349d4849ba5e3..04809b781f45b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1597,7 +1597,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 		imx_uart_dma_exit(sport);
 	}
 
-	mctrl_gpio_disable_ms(sport->gpios);
+	mctrl_gpio_disable_ms_sync(sport->gpios);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
 	ucr2 = imx_uart_readl(sport, UCR2);
diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 7d5aaa8d422b1..d5fb293dd5a93 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -322,11 +322,7 @@ void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
 }
 EXPORT_SYMBOL_GPL(mctrl_gpio_enable_ms);
 
-/**
- * mctrl_gpio_disable_ms - disable irqs and handling of changes to the ms lines
- * @gpios: gpios to disable
- */
-void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
+static void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios, bool sync)
 {
 	enum mctrl_gpio_idx i;
 
@@ -342,10 +338,34 @@ void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
 		if (!gpios->irq[i])
 			continue;
 
-		disable_irq(gpios->irq[i]);
+		if (sync)
+			disable_irq(gpios->irq[i]);
+		else
+			disable_irq_nosync(gpios->irq[i]);
 	}
 }
-EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms);
+
+/**
+ * mctrl_gpio_disable_ms_sync - disable irqs and handling of changes to the ms
+ * lines, and wait for any pending IRQ to be processed
+ * @gpios: gpios to disable
+ */
+void mctrl_gpio_disable_ms_sync(struct mctrl_gpios *gpios)
+{
+	mctrl_gpio_disable_ms(gpios, true);
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms_sync);
+
+/**
+ * mctrl_gpio_disable_ms_no_sync - disable irqs and handling of changes to the
+ * ms lines, and return immediately
+ * @gpios: gpios to disable
+ */
+void mctrl_gpio_disable_ms_no_sync(struct mctrl_gpios *gpios)
+{
+	mctrl_gpio_disable_ms(gpios, false);
+}
+EXPORT_SYMBOL_GPL(mctrl_gpio_disable_ms_no_sync);
 
 void mctrl_gpio_enable_irq_wake(struct mctrl_gpios *gpios)
 {
diff --git a/drivers/tty/serial/serial_mctrl_gpio.h b/drivers/tty/serial/serial_mctrl_gpio.h
index fc76910fb105a..79e97838ebe56 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.h
+++ b/drivers/tty/serial/serial_mctrl_gpio.h
@@ -87,9 +87,16 @@ void mctrl_gpio_free(struct device *dev, struct mctrl_gpios *gpios);
 void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios);
 
 /*
- * Disable gpio interrupts to report status line changes.
+ * Disable gpio interrupts to report status line changes, and block until
+ * any corresponding IRQ is processed
  */
-void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios);
+void mctrl_gpio_disable_ms_sync(struct mctrl_gpios *gpios);
+
+/*
+ * Disable gpio interrupts to report status line changes, and return
+ * immediately
+ */
+void mctrl_gpio_disable_ms_no_sync(struct mctrl_gpios *gpios);
 
 /*
  * Enable gpio wakeup interrupts to enable wake up source.
@@ -148,7 +155,11 @@ static inline void mctrl_gpio_enable_ms(struct mctrl_gpios *gpios)
 {
 }
 
-static inline void mctrl_gpio_disable_ms(struct mctrl_gpios *gpios)
+static inline void mctrl_gpio_disable_ms_sync(struct mctrl_gpios *gpios)
+{
+}
+
+static inline void mctrl_gpio_disable_ms_no_sync(struct mctrl_gpios *gpios)
 {
 }
 
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 4350a69d97d7a..2434eb6e6847d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2237,7 +2237,7 @@ static void sci_shutdown(struct uart_port *port)
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
 	s->autorts = false;
-	mctrl_gpio_disable_ms(to_sci_port(port)->gpios);
+	mctrl_gpio_disable_ms_sync(to_sci_port(port)->gpios);
 
 	spin_lock_irqsave(&port->lock, flags);
 	sci_stop_rx(port);
diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 9ef90bb30a47e..b58422ae156c9 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -952,7 +952,7 @@ static void stm32_usart_enable_ms(struct uart_port *port)
 
 static void stm32_usart_disable_ms(struct uart_port *port)
 {
-	mctrl_gpio_disable_ms(to_stm32_port(port)->gpios);
+	mctrl_gpio_disable_ms_sync(to_stm32_port(port)->gpios);
 }
 
 /* Transmit stop */
-- 
2.39.5



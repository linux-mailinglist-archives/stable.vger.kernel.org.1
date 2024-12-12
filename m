Return-Path: <stable+bounces-102961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E91B9EF579
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A1F176512
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5943B223C46;
	Thu, 12 Dec 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rkm479cO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0421576E;
	Thu, 12 Dec 2024 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734023118; cv=none; b=nHLBlh/+YWdOGnOrE5Xyrrl7D4Z6LyOsDZ4p7o4BDkWcEF0/w9E9r6gZl6v01UgF4MHihmAsCXjfAIbCtnc9XBEsbbAQjYbq6/+BRWfzPlfr8TR6oPHCbRBljEaEW4JZWCfkPclqAZTf3+FAS6tyobKxBmGtHLNNXs3ksBxMki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734023118; c=relaxed/simple;
	bh=pYGDg+8akSNBahLUrmBDQ9ToVhJi0SiF24mdd6hD6o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=um9MTRGA8Sf2nsf+HtbZVpBZkghISsXz68pczv/rjx2l43Sw6JD5eq7+jj7c82/JBJ68A7lg3nTSLEnRd/4LoXQjvDBYjI4eUQdR35qOONxQOqON+Zx5zpMV56CUMDcYUKzaheOw+BtlszYVwpc7ZzxF4t54RQskM897sVfu0bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rkm479cO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DF8C4CECE;
	Thu, 12 Dec 2024 17:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734023117;
	bh=pYGDg+8akSNBahLUrmBDQ9ToVhJi0SiF24mdd6hD6o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rkm479cOU7HBK61Y1iMUVQKV2a5j/Q2+bxtFNh2GIu0lQajzxNjJyr2BQfXPdt3Nr
	 7h9z9ez/GHz6l40yYdriTojEbeWDTzDZlvWYWc+or2u7hEC9A6ImPudSpBbeyH+K6b
	 ewmzTzBhfpYRS3UaIN6zCqZcs0n/X+Gs02J8vn7g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 430/565] serial: amba-pl011: Use port lock wrappers
Date: Thu, 12 Dec 2024 16:00:25 +0100
Message-ID: <20241212144328.683315586@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 68ca3e72d7463d79d29b6e4961d6028df2a88e25 ]

When a serial port is used for kernel console output, then all
modifications to the UART registers which are done from other contexts,
e.g. getty, termios, are interference points for the kernel console.

So far this has been ignored and the printk output is based on the
principle of hope. The rework of the console infrastructure which aims to
support threaded and atomic consoles, requires to mark sections which
modify the UART registers as unsafe. This allows the atomic write function
to make informed decisions and eventually to restore operational state. It
also allows to prevent the regular UART code from modifying UART registers
while printk output is in progress.

All modifications of UART registers are guarded by the UART port lock,
which provides an obvious synchronization point with the console
infrastructure.

To avoid adding this functionality to all UART drivers, wrap the
spin_[un]lock*() invocations for uart_port::lock into helper functions
which just contain the spin_[un]lock*() invocations for now. In a
subsequent step these helpers will gain the console synchronization
mechanisms.

Converted with coccinelle. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/20230914183831.587273-18-john.ogness@linutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 2bcacc1c87ac ("serial: amba-pl011: Fix RX stall when DMA is used")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/amba-pl011.c | 72 ++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index a5eb5dc275ccd..16fc159bdf3b9 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -351,9 +351,9 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 				flag = TTY_FRAME;
 		}
 
-		spin_unlock(&uap->port.lock);
+		uart_port_unlock(&uap->port);
 		sysrq = uart_handle_sysrq_char(&uap->port, ch & 255);
-		spin_lock(&uap->port.lock);
+		uart_port_lock(&uap->port);
 
 		if (!sysrq)
 			uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
@@ -548,7 +548,7 @@ static void pl011_dma_tx_callback(void *data)
 	unsigned long flags;
 	u16 dmacr;
 
-	spin_lock_irqsave(&uap->port.lock, flags);
+	uart_port_lock_irqsave(&uap->port, &flags);
 	if (uap->dmatx.queued)
 		dma_unmap_single(dmatx->chan->device->dev, dmatx->dma,
 				dmatx->len, DMA_TO_DEVICE);
@@ -569,7 +569,7 @@ static void pl011_dma_tx_callback(void *data)
 	if (!(dmacr & UART011_TXDMAE) || uart_tx_stopped(&uap->port) ||
 	    uart_circ_empty(&uap->port.state->xmit)) {
 		uap->dmatx.queued = false;
-		spin_unlock_irqrestore(&uap->port.lock, flags);
+		uart_port_unlock_irqrestore(&uap->port, flags);
 		return;
 	}
 
@@ -580,7 +580,7 @@ static void pl011_dma_tx_callback(void *data)
 		 */
 		pl011_start_tx_pio(uap);
 
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	uart_port_unlock_irqrestore(&uap->port, flags);
 }
 
 /*
@@ -1009,7 +1009,7 @@ static void pl011_dma_rx_callback(void *data)
 	 * routine to flush out the secondary DMA buffer while
 	 * we immediately trigger the next DMA job.
 	 */
-	spin_lock_irq(&uap->port.lock);
+	uart_port_lock_irq(&uap->port);
 	/*
 	 * Rx data can be taken by the UART interrupts during
 	 * the DMA irq handler. So we check the residue here.
@@ -1025,7 +1025,7 @@ static void pl011_dma_rx_callback(void *data)
 	ret = pl011_dma_rx_trigger_dma(uap);
 
 	pl011_dma_rx_chars(uap, pending, lastbuf, false);
-	spin_unlock_irq(&uap->port.lock);
+	uart_port_unlock_irq(&uap->port);
 	/*
 	 * Do this check after we picked the DMA chars so we don't
 	 * get some IRQ immediately from RX.
@@ -1091,11 +1091,11 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 	if (jiffies_to_msecs(jiffies - dmarx->last_jiffies)
 			> uap->dmarx.poll_timeout) {
 
-		spin_lock_irqsave(&uap->port.lock, flags);
+		uart_port_lock_irqsave(&uap->port, &flags);
 		pl011_dma_rx_stop(uap);
 		uap->im |= UART011_RXIM;
 		pl011_write(uap->im, uap, REG_IMSC);
-		spin_unlock_irqrestore(&uap->port.lock, flags);
+		uart_port_unlock_irqrestore(&uap->port, flags);
 
 		uap->dmarx.running = false;
 		dmaengine_terminate_all(rxchan);
@@ -1191,10 +1191,10 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 	while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
 		cpu_relax();
 
-	spin_lock_irq(&uap->port.lock);
+	uart_port_lock_irq(&uap->port);
 	uap->dmacr &= ~(UART011_DMAONERR | UART011_RXDMAE | UART011_TXDMAE);
 	pl011_write(uap->dmacr, uap, REG_DMACR);
-	spin_unlock_irq(&uap->port.lock);
+	uart_port_unlock_irq(&uap->port);
 
 	if (uap->using_tx_dma) {
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
@@ -1405,9 +1405,9 @@ static void pl011_throttle_rx(struct uart_port *port)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	pl011_stop_rx(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void pl011_enable_ms(struct uart_port *port)
@@ -1425,7 +1425,7 @@ __acquires(&uap->port.lock)
 {
 	pl011_fifo_to_tty(uap);
 
-	spin_unlock(&uap->port.lock);
+	uart_port_unlock(&uap->port);
 	tty_flip_buffer_push(&uap->port.state->port);
 	/*
 	 * If we were temporarily out of DMA mode for a while,
@@ -1450,7 +1450,7 @@ __acquires(&uap->port.lock)
 #endif
 		}
 	}
-	spin_lock(&uap->port.lock);
+	uart_port_lock(&uap->port);
 }
 
 static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
@@ -1556,7 +1556,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
 	int handled = 0;
 
-	spin_lock_irqsave(&uap->port.lock, flags);
+	uart_port_lock_irqsave(&uap->port, &flags);
 	status = pl011_read(uap, REG_RIS) & uap->im;
 	if (status) {
 		do {
@@ -1586,7 +1586,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 		handled = 1;
 	}
 
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	uart_port_unlock_irqrestore(&uap->port, flags);
 
 	return IRQ_RETVAL(handled);
 }
@@ -1658,14 +1658,14 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 	unsigned int lcr_h;
 
-	spin_lock_irqsave(&uap->port.lock, flags);
+	uart_port_lock_irqsave(&uap->port, &flags);
 	lcr_h = pl011_read(uap, REG_LCRH_TX);
 	if (break_state == -1)
 		lcr_h |= UART01x_LCRH_BRK;
 	else
 		lcr_h &= ~UART01x_LCRH_BRK;
 	pl011_write(lcr_h, uap, REG_LCRH_TX);
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	uart_port_unlock_irqrestore(&uap->port, flags);
 }
 
 #ifdef CONFIG_CONSOLE_POLL
@@ -1804,7 +1804,7 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 	unsigned long flags;
 	unsigned int i;
 
-	spin_lock_irqsave(&uap->port.lock, flags);
+	uart_port_lock_irqsave(&uap->port, &flags);
 
 	/* Clear out any spuriously appearing RX interrupts */
 	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
@@ -1826,7 +1826,7 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;
 	pl011_write(uap->im, uap, REG_IMSC);
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	uart_port_unlock_irqrestore(&uap->port, flags);
 }
 
 static void pl011_unthrottle_rx(struct uart_port *port)
@@ -1834,7 +1834,7 @@ static void pl011_unthrottle_rx(struct uart_port *port)
 	struct uart_amba_port *uap = container_of(port, struct uart_amba_port, port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&uap->port.lock, flags);
+	uart_port_lock_irqsave(&uap->port, &flags);
 
 	uap->im = UART011_RTIM;
 	if (!pl011_dma_rx_running(uap))
@@ -1842,7 +1842,7 @@ static void pl011_unthrottle_rx(struct uart_port *port)
 
 	pl011_write(uap->im, uap, REG_IMSC);
 
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	uart_port_unlock_irqrestore(&uap->port, flags);
 }
 
 static int pl011_startup(struct uart_port *port)
@@ -1862,7 +1862,7 @@ static int pl011_startup(struct uart_port *port)
 
 	pl011_write(uap->vendor->ifls, uap, REG_IFLS);
 
-	spin_lock_irq(&uap->port.lock);
+	uart_port_lock_irq(&uap->port);
 
 	/* restore RTS and DTR */
 	cr = uap->old_cr & (UART011_CR_RTS | UART011_CR_DTR);
@@ -1873,7 +1873,7 @@ static int pl011_startup(struct uart_port *port)
 
 	pl011_write(cr, uap, REG_CR);
 
-	spin_unlock_irq(&uap->port.lock);
+	uart_port_unlock_irq(&uap->port);
 
 	/*
 	 * initialise the old status of the modem signals
@@ -1934,13 +1934,13 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
 	unsigned int cr;
 
 	uap->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS);
-	spin_lock_irq(&uap->port.lock);
+	uart_port_lock_irq(&uap->port);
 	cr = pl011_read(uap, REG_CR);
 	uap->old_cr = cr;
 	cr &= UART011_CR_RTS | UART011_CR_DTR;
 	cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
 	pl011_write(cr, uap, REG_CR);
-	spin_unlock_irq(&uap->port.lock);
+	uart_port_unlock_irq(&uap->port);
 
 	/*
 	 * disable break condition and fifos
@@ -1952,14 +1952,14 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
 
 static void pl011_disable_interrupts(struct uart_amba_port *uap)
 {
-	spin_lock_irq(&uap->port.lock);
+	uart_port_lock_irq(&uap->port);
 
 	/* mask all interrupts and clear all pending ones */
 	uap->im = 0;
 	pl011_write(uap->im, uap, REG_IMSC);
 	pl011_write(0xffff, uap, REG_ICR);
 
-	spin_unlock_irq(&uap->port.lock);
+	uart_port_unlock_irq(&uap->port);
 }
 
 static void pl011_shutdown(struct uart_port *port)
@@ -2104,7 +2104,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	bits = tty_get_frame_size(termios->c_cflag);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/*
 	 * Update the per-port timeout.
@@ -2171,7 +2171,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	pl011_write_lcr_h(uap, lcr_h);
 	pl011_write(old_cr, uap, REG_CR);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void
@@ -2189,10 +2189,10 @@ sbsa_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	termios->c_cflag &= ~(CMSPAR | CRTSCTS);
 	termios->c_cflag |= CS8 | CLOCAL;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	uart_update_timeout(port, CS8, uap->fixed_baud);
 	pl011_setup_status_masks(port, termios);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *pl011_type(struct uart_port *port)
@@ -2345,9 +2345,9 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	if (uap->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&uap->port.lock);
+		locked = uart_port_trylock(&uap->port);
 	else
-		spin_lock(&uap->port.lock);
+		uart_port_lock(&uap->port);
 
 	/*
 	 *	First save the CR then disable the interrupts
@@ -2373,7 +2373,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 		pl011_write(old_cr, uap, REG_CR);
 
 	if (locked)
-		spin_unlock(&uap->port.lock);
+		uart_port_unlock(&uap->port);
 	local_irq_restore(flags);
 
 	clk_disable(uap->clk);
-- 
2.43.0





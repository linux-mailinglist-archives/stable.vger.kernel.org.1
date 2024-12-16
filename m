Return-Path: <stable+bounces-104394-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E7D9F3999
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 20:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40785163729
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 19:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93F884A2F;
	Mon, 16 Dec 2024 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="elRI/OQs"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04979207DFE;
	Mon, 16 Dec 2024 19:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.120.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734376730; cv=none; b=PPWBrpjRmg1zAvFYIvuUqyRBvPz/t9ccj4OQGHa8Gh97pZ8X3GVmopBULY0TMwaUi6lxyuCZ5oh+Z1DbreEL+xikZsmGWpFhL/XHMsYOES9JfGF0ZJ18ys9fRX02aV+Txvmz7FOWNdrlqTdajIusbI345/9LQKTTWuoCM6+Y4zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734376730; c=relaxed/simple;
	bh=U5HVEyK+ca5hlp2ZKLLP+1AaUL1pGdExNVBsrWqU6tY=;
	h=From:To:Cc:Date:Message-Id:In-Reply-To:References:MIME-Version:
	 Subject; b=rM85+HwceEc9iuLbj6wG5HV9NDiVpQmPbd3WvaLx6w5KEdZzYxPoN9dBk/Zmu41GVHk73k4zF9cbpKAdHI1r8Hy90b1+DaP6P8r59uADId8CCPIxOOstVLQVq0py8jA6aUtlX2KnWJQvnPHIjkKm+ZGtwsqx6U/Y6inbMZaOmrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com; spf=pass smtp.mailfrom=hugovil.com; dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b=elRI/OQs; arc=none smtp.client-ip=162.243.120.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=WBCNvQ5CVwXKYqhIpuaoLGn+LGa8ssqnIADLPplGbWo=; b=elRI/OQsEUnuaZJulmDWjTqatg
	NLWpVmW6+E6hk6eMKxO4YFKZ2sCn5lXeHNGeNiSI/KviFD9KlhZgfiD5CrRvXOeicM95+cNwAnMzJ
	VtB4HIrklzC/Fp49Pls6QR3KEHJkyTJPOq+GqovswfWF/G1clDMR+FGbPU7dxmEvFkDM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:42958 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1tNGc7-0002CS-R9; Mon, 16 Dec 2024 14:18:44 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: hugo@hugovil.com,
	hui.wang@canonical.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Mon, 16 Dec 2024 14:18:17 -0500
Message-Id: <20241216191818.1553557-4-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216191818.1553557-1-hugo@hugovil.com>
References: <20241216191818.1553557-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
Subject: [PATCH 3/4] serial: sc16is7xx: fix TX fifo corruption
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Sometimes, when a packet is received on channel A at almost the same time
as a packet is about to be transmitted on channel B, we observe with a
logic analyzer that the received packet on channel A is transmitted on
channel B. In other words, the Tx buffer data on channel B is corrupted
with data from channel A.

The problem appeared since commit 4409df5866b7 ("serial: sc16is7xx: change
EFR lock to operate on each channels"), which changed the EFR locking to
operate on each channel instead of chip-wise.

This commit has introduced a regression, because the EFR lock is used not
only to protect the EFR registers access, but also, in a very obscure and
undocumented way, to protect access to the data buffer, which is shared by
the Tx and Rx handlers, but also by each channel of the IC.

Fix this regression first by switching to kfifo_out_linear_ptr() in
sc16is7xx_handle_tx() to eliminate the need for a shared Rx/Tx buffer.

Secondly, replace the chip-wise Rx buffer with a separate Rx buffer for
each channel.

Reworked to fix conflicts when backporting to linux-5.15.y.

Fixes: 4409df5866b7 ("serial: sc16is7xx: change EFR lock to operate on each channels")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240723125302.1305372-2-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sc16is7xx.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 591f97e78cdb7..928c701f0c35a 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -318,6 +318,7 @@ struct sc16is7xx_one {
 	struct kthread_work		tx_work;
 	struct kthread_work		reg_work;
 	struct sc16is7xx_one_config	config;
+	unsigned char			buf[SC16IS7XX_FIFO_SIZE]; /* Rx buffer. */
 	bool				irda_mode;
 };
 
@@ -327,7 +328,6 @@ struct sc16is7xx_port {
 #ifdef CONFIG_GPIOLIB
 	struct gpio_chip		gpio;
 #endif
-	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
 	struct kthread_worker		kworker;
 	struct task_struct		*kworker_task;
 	struct sc16is7xx_one		p[];
@@ -555,17 +555,17 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 				unsigned int iir)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	unsigned int lsr = 0, ch, flag, bytes_read, i;
 	bool read_lsr = (iir == SC16IS7XX_IIR_RLSE_SRC) ? true : false;
 
-	if (unlikely(rxlen >= sizeof(s->buf))) {
+	if (unlikely(rxlen >= sizeof(one->buf))) {
 		dev_warn_ratelimited(port->dev,
 				     "ttySC%i: Possible RX FIFO overrun: %d\n",
 				     port->line, rxlen);
 		port->icount.buf_overrun++;
 		/* Ensure sanity of RX level */
-		rxlen = sizeof(s->buf);
+		rxlen = sizeof(one->buf);
 	}
 
 	while (rxlen) {
@@ -578,10 +578,10 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 			lsr = 0;
 
 		if (read_lsr) {
-			s->buf[0] = sc16is7xx_port_read(port, SC16IS7XX_RHR_REG);
+			one->buf[0] = sc16is7xx_port_read(port, SC16IS7XX_RHR_REG);
 			bytes_read = 1;
 		} else {
-			sc16is7xx_fifo_read(port, s->buf, rxlen);
+			sc16is7xx_fifo_read(port, one->buf, rxlen);
 			bytes_read = rxlen;
 		}
 
@@ -614,7 +614,7 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 		}
 
 		for (i = 0; i < bytes_read; ++i) {
-			ch = s->buf[i];
+			ch = one->buf[i];
 			if (uart_handle_sysrq_char(port, ch))
 				continue;
 
@@ -632,7 +632,7 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 
 static void sc16is7xx_handle_tx(struct uart_port *port)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned int txlen, to_send, i;
 
@@ -664,11 +664,11 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 
 		/* Convert to linear buffer */
 		for (i = 0; i < to_send; ++i) {
-			s->buf[i] = xmit->buf[xmit->tail];
+			one->buf[i] = xmit->buf[xmit->tail];
 			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
 		}
 
-		sc16is7xx_fifo_write(port, s->buf, to_send);
+		sc16is7xx_fifo_write(port, one->buf, to_send);
 	}
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-- 
2.39.5



Return-Path: <stable+bounces-66470-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3314A94EBF4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 13:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5500E1C20EBD
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DBF8176FA4;
	Mon, 12 Aug 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Ytwfq8+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB76176AD2
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462896; cv=none; b=ohBKQbVPZQ7fFyDPng38EBYatqApRjgcEzH9DhNkUyo4WGJWF+IPS8TZwRYIjSbM9fRKKX2s8klQHgF9wospNryH4tIMmsj6CC1lNRJ2xKs6aUeinUTuyFLfcTa/+N8akrlW3DIRfuDUSzz0HSASjKN7s8e1RDyck0fsbcBhV4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462896; c=relaxed/simple;
	bh=HUdEuwZ4Q2nrzV919UvADcbLZApm58qiojai7/h0Q8c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EtMG5QvRpR1kLM+p9fAhgIDIdwV7BxyK9uBveVSt30/7RISOArj6smYSNFNGf/tbwoEjKAuZVYzGes6XwATPl/8z2qlKM+8uT9STMGLiAPAWEuKN+D5JXsTovZchyh0SMw9OElrcNLKYHpS3+vesjEcsycO61O8GhNUZojEh2PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Ytwfq8+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A3DFC32782;
	Mon, 12 Aug 2024 11:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723462895;
	bh=HUdEuwZ4Q2nrzV919UvADcbLZApm58qiojai7/h0Q8c=;
	h=Subject:To:Cc:From:Date:From;
	b=2Ytwfq8+0rC1xMSwB8GxUXBj7eVGTVOFHRAoHxf8Jr4GadST3ex8hw+0C2Zf5glOx
	 /J0Dfu+UL33XktIxKIUy1PFNdA1NK+r2wElv6swUD0iPBUgp9y0dZnICCqiU3fqni8
	 B3Uj8GpAQe5S83GKsLnbLi4eAOHEqFL7ZCxnx9mA=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: fix TX fifo corruption" failed to apply to 6.1-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 13:41:31 +0200
Message-ID: <2024081230-glance-tamale-974a@gregkh>
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
git cherry-pick -x 133f4c00b8b2bfcacead9b81e7e8edfceb4b06c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081230-glance-tamale-974a@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

133f4c00b8b2 ("serial: sc16is7xx: fix TX fifo corruption")
1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
f8fef2fa419f ("tty: msm_serial: use dmaengine_prep_slave_sg()")
9054605ab846 ("tty: 8250_omap: use dmaengine_prep_slave_sg()")
8192fabb0db2 ("tty: 8250_dma: use dmaengine_prep_slave_sg()")
3bcb0bf65c2b ("Merge tag 'tty-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 133f4c00b8b2bfcacead9b81e7e8edfceb4b06c4 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue, 23 Jul 2024 08:53:00 -0400
Subject: [PATCH] serial: sc16is7xx: fix TX fifo corruption

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

Fixes: 4409df5866b7 ("serial: sc16is7xx: change EFR lock to operate on each channels")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20240723125302.1305372-2-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index c79dcd7c8d1a..58696e05492c 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -327,6 +327,7 @@ struct sc16is7xx_one {
 	struct kthread_work		reg_work;
 	struct kthread_delayed_work	ms_work;
 	struct sc16is7xx_one_config	config;
+	unsigned char			buf[SC16IS7XX_FIFO_SIZE]; /* Rx buffer. */
 	unsigned int			old_mctrl;
 	u8				old_lcr; /* Value before EFR access. */
 	bool				irda_mode;
@@ -340,7 +341,6 @@ struct sc16is7xx_port {
 	unsigned long			gpio_valid_mask;
 #endif
 	u8				mctrl_mask;
-	unsigned char			buf[SC16IS7XX_FIFO_SIZE];
 	struct kthread_worker		kworker;
 	struct task_struct		*kworker_task;
 	struct sc16is7xx_one		p[];
@@ -612,18 +612,18 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 				unsigned int iir)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 	unsigned int lsr = 0, bytes_read, i;
 	bool read_lsr = (iir == SC16IS7XX_IIR_RLSE_SRC) ? true : false;
 	u8 ch, flag;
 
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
@@ -636,10 +636,10 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
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
 
@@ -672,7 +672,7 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 		}
 
 		for (i = 0; i < bytes_read; ++i) {
-			ch = s->buf[i];
+			ch = one->buf[i];
 			if (uart_handle_sysrq_char(port, ch))
 				continue;
 
@@ -690,10 +690,10 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 
 static void sc16is7xx_handle_tx(struct uart_port *port)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct tty_port *tport = &port->state->port;
 	unsigned long flags;
 	unsigned int txlen;
+	unsigned char *tail;
 
 	if (unlikely(port->x_char)) {
 		sc16is7xx_port_write(port, SC16IS7XX_THR_REG, port->x_char);
@@ -718,8 +718,9 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 		txlen = 0;
 	}
 
-	txlen = uart_fifo_out(port, s->buf, txlen);
-	sc16is7xx_fifo_write(port, s->buf, txlen);
+	txlen = kfifo_out_linear_ptr(&tport->xmit_fifo, &tail, txlen);
+	sc16is7xx_fifo_write(port, tail, txlen);
+	uart_xmit_advance(port, txlen);
 
 	uart_port_lock_irqsave(port, &flags);
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)



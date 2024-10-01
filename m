Return-Path: <stable+bounces-78441-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBC698B9A7
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 12:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 220E2284488
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 10:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C540F1A00EE;
	Tue,  1 Oct 2024 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="socYvV2I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853051C693
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727778415; cv=none; b=dFqLs7ZTZA4BUWumMNIS1Gn0Lj+9n4f2Znup0l9Rf8fxN/Tp2HRidDk0wStvYvvZZUL1r19CUBeYX7MjBuyY9Iow3QcPvNONo3OY87jNKS951N1HGmgIceDCPWWeKrcSsP+be5ysl0qZBSnrRt9vQCaOi2SOlUXZuVbzDwQwugI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727778415; c=relaxed/simple;
	bh=pSt8TZEAt+MA++S4EFiMIGziHOvqUCETUSi00NEbyoQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F4d5P9qRwwK1LxiD8ti7SVA7ayUE3Yg4fwOMZA8DpRcac8AFc7d7cbT9IheIDSghpLkMSU8xiETjcsovoew99XiJVBVY4UHDKlB4T/q057DrwvniBqLZNLqArJ45nsHjccVHpKrJ5UdCv4HqEWeGtaYmaEkblDkR6CPCvXAKhnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=socYvV2I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EFE7C4CEC6;
	Tue,  1 Oct 2024 10:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727778415;
	bh=pSt8TZEAt+MA++S4EFiMIGziHOvqUCETUSi00NEbyoQ=;
	h=Subject:To:Cc:From:Date:From;
	b=socYvV2IgxeDlFwuIOK2Jgm6iEFyN2KvKTkDKlfgBy1gpA1dyMe7x4JIX6tR1bk/X
	 dg8jkkN47AGUudCCN5300bDFUuL7KVpX711IoLDYCRH5KQSPrF8Bq0MO84kzVsg//F
	 kmmnPMc+oTJ3MjhCQxnX3nwj8/yYZmEAJ/NSXy+s=
Subject: FAILED: patch "[PATCH] serial: qcom-geni: fix console corruption" failed to apply to 4.19-stable tree
To: johan+linaro@kernel.org,dianders@chromium.org,gregkh@linuxfoundation.org,nfraprado@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 12:26:44 +0200
Message-ID: <2024100144-jolt-purge-3b6b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x cc4a0e5754a16bbc1e215c091349a7c83a2c5e14
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100144-jolt-purge-3b6b@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

cc4a0e5754a1 ("serial: qcom-geni: fix console corruption")
f97cdbbf187f ("serial: qcom-geni: fix false console tx restart")
947cc4ecc06c ("serial: qcom-geni: fix soft lockup on sw flow control and suspend")
1788cf6a91d9 ("tty: serial: switch from circ_buf to kfifo")
f8fef2fa419f ("tty: msm_serial: use dmaengine_prep_slave_sg()")
9054605ab846 ("tty: 8250_omap: use dmaengine_prep_slave_sg()")
8192fabb0db2 ("tty: 8250_dma: use dmaengine_prep_slave_sg()")
3bcb0bf65c2b ("Merge tag 'tty-6.9-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cc4a0e5754a16bbc1e215c091349a7c83a2c5e14 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Fri, 6 Sep 2024 15:13:34 +0200
Subject: [PATCH] serial: qcom-geni: fix console corruption
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Qualcomm serial console implementation is broken and can lose
characters when the serial port is also used for tty output.

Specifically, the console code only waits for the current tx command to
complete when all data has already been written to the fifo. When there
are on-going longer transfers this often means that console output is
lost when the console code inadvertently "hijacks" the current tx
command instead of starting a new one.

This can, for example, be observed during boot when console output that
should have been interspersed with init output is truncated:

	[    9.462317] qcom-snps-eusb2-hsphy fde000.phy: Registered Qcom-eUSB2 phy
	[  OK  ] Found device KBG50ZNS256G KIOXIA Wi[    9.471743ndows.
	[    9.539915] xhci-hcd xhci-hcd.0.auto: xHCI Host Controller

Add a new state variable to track how much data has been written to the
fifo and use it to determine when the fifo and shift register are both
empty. This is needed since there is currently no other known way to
determine when the shift register is empty.

This in turn allows the console code to interrupt long transfers without
losing data.

Note that the oops-in-progress case is similarly broken as it does not
cancel any active command and also waits for the wrong status flag when
attempting to drain the fifo (TX_FIFO_NOT_EMPTY_EN is only set when
cancelling a command leaves data in the fifo).

Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver support for GENI based QUP")
Fixes: a1fee899e5be ("tty: serial: qcom_geni_serial: Fix softlock")
Fixes: 9e957a155005 ("serial: qcom-geni: Don't cancel/abort if we can't get the port lock")
Cc: stable@vger.kernel.org	# 4.17
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/r/20240906131336.23625-7-johan+linaro@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 7bbd70c30620..f8f6e9466b40 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -131,6 +131,7 @@ struct qcom_geni_serial_port {
 	bool brk;
 
 	unsigned int tx_remaining;
+	unsigned int tx_queued;
 	int wakeup_irq;
 	bool rx_tx_swap;
 	bool cts_rts_swap;
@@ -144,6 +145,8 @@ static const struct uart_ops qcom_geni_uart_pops;
 static struct uart_driver qcom_geni_console_driver;
 static struct uart_driver qcom_geni_uart_driver;
 
+static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport);
+
 static inline struct qcom_geni_serial_port *to_dev_port(struct uart_port *uport)
 {
 	return container_of(uport, struct qcom_geni_serial_port, uport);
@@ -393,6 +396,14 @@ static void qcom_geni_serial_poll_put_char(struct uart_port *uport,
 #endif
 
 #ifdef CONFIG_SERIAL_QCOM_GENI_CONSOLE
+static void qcom_geni_serial_drain_fifo(struct uart_port *uport)
+{
+	struct qcom_geni_serial_port *port = to_dev_port(uport);
+
+	qcom_geni_serial_poll_bitfield(uport, SE_GENI_M_GP_LENGTH, GP_LENGTH,
+			port->tx_queued);
+}
+
 static void qcom_geni_serial_wr_char(struct uart_port *uport, unsigned char ch)
 {
 	struct qcom_geni_private_data *private_data = uport->private_data;
@@ -468,7 +479,6 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	struct qcom_geni_serial_port *port;
 	bool locked = true;
 	unsigned long flags;
-	u32 geni_status;
 
 	WARN_ON(co->index < 0 || co->index >= GENI_UART_CONS_PORTS);
 
@@ -482,34 +492,20 @@ static void qcom_geni_serial_console_write(struct console *co, const char *s,
 	else
 		uart_port_lock_irqsave(uport, &flags);
 
-	geni_status = readl(uport->membase + SE_GENI_STATUS);
+	if (qcom_geni_serial_main_active(uport)) {
+		/* Wait for completion or drain FIFO */
+		if (!locked || port->tx_remaining == 0)
+			qcom_geni_serial_poll_tx_done(uport);
+		else
+			qcom_geni_serial_drain_fifo(uport);
 
-	if (!locked) {
-		/*
-		 * We can only get here if an oops is in progress then we were
-		 * unable to get the lock. This means we can't safely access
-		 * our state variables like tx_remaining. About the best we
-		 * can do is wait for the FIFO to be empty before we start our
-		 * transfer, so we'll do that.
-		 */
-		qcom_geni_serial_poll_bit(uport, SE_GENI_M_IRQ_STATUS,
-					  M_TX_FIFO_NOT_EMPTY_EN, false);
-	} else if ((geni_status & M_GENI_CMD_ACTIVE) && !port->tx_remaining) {
-		/*
-		 * It seems we can't interrupt existing transfers if all data
-		 * has been sent, in which case we need to look for done first.
-		 */
-		qcom_geni_serial_poll_tx_done(uport);
+		qcom_geni_serial_cancel_tx_cmd(uport);
 	}
 
 	__qcom_geni_serial_console_write(uport, s, count);
 
-
-	if (locked) {
-		if (port->tx_remaining)
-			qcom_geni_serial_setup_tx(uport, port->tx_remaining);
+	if (locked)
 		uart_port_unlock_irqrestore(uport, flags);
-	}
 }
 
 static void handle_rx_console(struct uart_port *uport, u32 bytes, bool drop)
@@ -690,6 +686,7 @@ static void qcom_geni_serial_cancel_tx_cmd(struct uart_port *uport)
 	writel(M_CMD_CANCEL_EN, uport->membase + SE_GENI_M_IRQ_CLEAR);
 
 	port->tx_remaining = 0;
+	port->tx_queued = 0;
 }
 
 static void qcom_geni_serial_handle_rx_fifo(struct uart_port *uport, bool drop)
@@ -916,6 +913,7 @@ static void qcom_geni_serial_handle_tx_fifo(struct uart_port *uport,
 	if (!port->tx_remaining) {
 		qcom_geni_serial_setup_tx(uport, pending);
 		port->tx_remaining = pending;
+		port->tx_queued = 0;
 
 		irq_en = readl(uport->membase + SE_GENI_M_IRQ_EN);
 		if (!(irq_en & M_TX_FIFO_WATERMARK_EN))
@@ -924,6 +922,7 @@ static void qcom_geni_serial_handle_tx_fifo(struct uart_port *uport,
 	}
 
 	qcom_geni_serial_send_chunk_fifo(uport, chunk);
+	port->tx_queued += chunk;
 
 	/*
 	 * The tx fifo watermark is level triggered and latched. Though we had



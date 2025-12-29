Return-Path: <stable+bounces-203572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37281CE6ED4
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 14:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA85A3006A4D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFD422F386;
	Mon, 29 Dec 2025 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hz/D8l36"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA5F227B94
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016586; cv=none; b=XbFUtSxNtWp/P0Zmj4gIAjidIJKbVED/fAsb1mG1EOrVZ5ZG7Y53TwYmeB5g4y27D5nabdFT790NIuG9Qp+LbnuhUw0rgC7LccJ0wlNF9xoZukPdZcBUVrBxkYlSlNQDamkyOg8TRZy8zJrKqv7ukjJX0Tu9fkTgQXyLndkAxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016586; c=relaxed/simple;
	bh=8pE+43lIFEcHy8F4HKVys19recj6stWvcchGwMh9DmY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W3wost8BEGZAh6JQJNQSKMNOKO1XcJb23YwC6B37TyCk5hdMhFpGv+Sf3IQXcpd9tInPfmN3RVCdGXHE5eE9kKhxKxxpX04YvI2HNns/+sA9A38xPlEOfgn5i4d7wEXek6cZxuwhwB6MMcTw3f668RrhjhvRy6gVJyUZPXWQFNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hz/D8l36; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC1FC4CEF7;
	Mon, 29 Dec 2025 13:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767016586;
	bh=8pE+43lIFEcHy8F4HKVys19recj6stWvcchGwMh9DmY=;
	h=Subject:To:Cc:From:Date:From;
	b=hz/D8l36l7LAQMWB1Vz8Pat80LtNvySzZZEkeoR+HO05i0T25WaZFZ1p2urcLk3uI
	 H3/SzEQG+qZC414ZTH6MgSfzaqlQ4Icc7IXC+RhVrEB+YKntN9r04QhdYH1tpPlAzz
	 S+ocRoBDf1OBQgM9hXHnNtlkUEzwoospfSU6jjos=
Subject: FAILED: patch "[PATCH] serial: xilinx_uartps: fix rs485 delay_rts_after_send" failed to apply to 6.12-stable tree
To: jakub.turek@elsta.tech,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 14:56:23 +0100
Message-ID: <2025122923-amaretto-output-f3dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 267ee93c417e685d9f8e079e41c70ba6ee4df5a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122923-amaretto-output-f3dc@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 267ee93c417e685d9f8e079e41c70ba6ee4df5a5 Mon Sep 17 00:00:00 2001
From: "j.turek" <jakub.turek@elsta.tech>
Date: Sun, 21 Dec 2025 11:32:21 +0100
Subject: [PATCH] serial: xilinx_uartps: fix rs485 delay_rts_after_send

RTS line control with delay should be triggered when there is no more
bytes in kfifo and hardware buffer is empty. Without this patch RTS
control is scheduled right after feeding hardware buffer and this is too
early.

RTS line may change state before hardware buffer is empty.

With this patch delayed RTS state change is triggered when function
cdns_uart_handle_tx is called from cdns_uart_isr on
CDNS_UART_IXR_TXEMPTY exactly when hardware completed transmission

Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps driver")
Cc: stable <stable@kernel.org>
Link: https://patch.msgid.link/20251221103221.1971125-1-jakub.turek@elsta.tech
Signed-off-by: Jakub Turek  <jakub.turek@elsta.tech>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index c793fc74c26b..c593d20a1b5b 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -428,10 +428,17 @@ static void cdns_uart_handle_tx(void *dev_id)
 	struct tty_port *tport = &port->state->port;
 	unsigned int numbytes;
 	unsigned char ch;
+	ktime_t rts_delay;
 
 	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
 		/* Disable the TX Empty interrupt */
 		writel(CDNS_UART_IXR_TXEMPTY, port->membase + CDNS_UART_IDR);
+		/* Set RTS line after delay */
+		if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED) {
+			cdns_uart->tx_timer.function = &cdns_rs485_rx_callback;
+			rts_delay = ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart));
+			hrtimer_start(&cdns_uart->tx_timer, rts_delay, HRTIMER_MODE_REL);
+		}
 		return;
 	}
 
@@ -448,13 +455,6 @@ static void cdns_uart_handle_tx(void *dev_id)
 
 	/* Enable the TX Empty interrupt */
 	writel(CDNS_UART_IXR_TXEMPTY, cdns_uart->port->membase + CDNS_UART_IER);
-
-	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
-	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
-		hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_rx_callback);
-		hrtimer_start(&cdns_uart->tx_timer,
-			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_REL);
-	}
 }
 
 /**



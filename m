Return-Path: <stable+bounces-204237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 792C3CEA1D0
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 16:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF7A0301F27E
	for <lists+stable@lfdr.de>; Tue, 30 Dec 2025 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3F62857C7;
	Tue, 30 Dec 2025 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUIa6Jam"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC2261B70
	for <stable@vger.kernel.org>; Tue, 30 Dec 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110162; cv=none; b=XH61ZlEfZSNTo6JN0UoF8HDL6zLLnmJqzbajfVuL8Z0ryS5jKreT/qBPmlP2wA6reK+A+nWdSjak3Cplx2GFe2vUn+abvHEhk/zxvqyDZlUlzxcplv1lbWMPQvqkvPm+uJW227pxw7nbFqm01RJTugpUDA/Jx0k7RSiRxjZw9EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110162; c=relaxed/simple;
	bh=UkHFRZSAs6a6NEj8Y5Ft9CZKNqClbG8UOUWLgxKUVHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OZKK3khFH9Vds+1dMRc9m11RE3f1cKh2uvni5v8NQBbknyiXK2+Br8CvomOvUZB+dOAMtPEIJy4Wzjx06yAizIvdLrnp7Zx6kdfhHg3eq2fB2qf3q4Jjr4FFKYn+bNtFSbjqQwewxmByvB5W3gkdxtrm7uZb+hAjHBV5smqOfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUIa6Jam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A817CC4CEFB;
	Tue, 30 Dec 2025 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767110160;
	bh=UkHFRZSAs6a6NEj8Y5Ft9CZKNqClbG8UOUWLgxKUVHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GUIa6JamdBBpQ9zkvBPppxn/ea0oIXgoVIWDL7SCrL2zpHOJP6TAhBv5TIEtac6bU
	 CkZI9sx5SHYVstkOzeB9PBZpx5WGxxp6sLWjCk8FBS1R79OUZuqLS89ZjD5QROwXmh
	 x5iM6ZmoYXsb2o4gMQ0+A8POaaek9JJb3/zzGjix88T0tYWcjf0jyz9N62lvT2hCPr
	 ONdjd9L72n92BvnS0OK0TZ/pzLbCJmJBtDLucOQuKRQfOI+EvB7GZ1eKYkyV+DgvV3
	 5E6wgbgshnmw/BOcLxiG/gdKnpUBfYGILb1hcYYv7V9iQZlGEQ2P9sN/WK2+8RDJqA
	 g3+hTXIOXbNqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "j.turek" <jakub.turek@elsta.tech>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] serial: xilinx_uartps: fix rs485 delay_rts_after_send
Date: Tue, 30 Dec 2025 10:55:56 -0500
Message-ID: <20251230155556.2289800-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251230155556.2289800-1-sashal@kernel.org>
References: <2025122923-amaretto-output-f3dc@gregkh>
 <20251230155556.2289800-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "j.turek" <jakub.turek@elsta.tech>

[ Upstream commit 267ee93c417e685d9f8e079e41c70ba6ee4df5a5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/xilinx_uartps.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 1d4646c40855..239d28489841 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -431,10 +431,17 @@ static void cdns_uart_handle_tx(void *dev_id)
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
 
@@ -451,13 +458,6 @@ static void cdns_uart_handle_tx(void *dev_id)
 
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
-- 
2.51.0



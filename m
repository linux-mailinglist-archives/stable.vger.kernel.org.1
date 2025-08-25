Return-Path: <stable+bounces-172811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C57B33AB8
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 11:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30B371884942
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 09:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C6F2C0F64;
	Mon, 25 Aug 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+JCGrRu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kBjqm/nb"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DD72BDC25;
	Mon, 25 Aug 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113811; cv=none; b=aqVOKupJOJpzOhYddDsF28Xqg5aCtxl52+mT0Gl/WnBdN2TT8kNP+SutAE2HsPpQL5kQOPiVmN9OD9RxgpxWjCDAWCl0yXb0drxp+MVgq4lxZzez9ZUnVFR89R8brIAsK8LtpRS11TbMsTarJG1OIKHSWONqjrsMTERHx83JDBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113811; c=relaxed/simple;
	bh=Vi8IsWr8sfqjbSpr0TipQn/bFejpu2MbrNdIRDZf5cY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZyHDlVPCRbWX2cvaVapwxi7oqBJY3Opo6QOt79F5tQAfiSEBoATOoLamcLOgKXXquxmEUjpM9FjYdpo6BYLbodjzxgz52zjmj75f2lIk6p8AuqTvYpoz+2BceytkqlcD0SkubRRX8gQz0Y5nScaftuY+4uPHHXAX4KucqTiA+xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+JCGrRu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kBjqm/nb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756113808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9vNDsLG8yRQa1f6yiPV69gzJlsO/fR4VPwef6lF3Q/U=;
	b=I+JCGrRuTkBXJyOjaoU9QWAA4kZlP0Lgfc/c+WCo5W2su7hCCnrHCrVXr7dBZEAe43RVRq
	JdnQ7o+vYKyA2NBspzDlzFQ7sEx5LCr8s/kPk56c9ZOFo8cG/QEcqpiWqgNR8rK41wcqrG
	9SKGNFiOgZcHlVS3pHOxhCWgwqMbh/Valsbe3MG8McUcbcjJEQITKlfEelwUMFjB6iU69q
	QlkJxDj7nSodK8pgyAcOv/WqXq2eMdLouLEvXKaH6oEvpCVjT57cFv5hbfCdDQx84MX3u3
	YQgcpA7Aw6xBC9uBP7a7BcRMRyXRZoasZnKbm5YkjFytlnd/WkImbpNCJpD19A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756113808;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9vNDsLG8yRQa1f6yiPV69gzJlsO/fR4VPwef6lF3Q/U=;
	b=kBjqm/nbuSN7K/X1C+X5U8O2yenC79h6hEgl2XO2Df5ot8rKSbv214FL63nBVU6GkyIk04
	PC+kSM6j62iFuuBg==
To: Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-serial@vger.kernel.org
Cc: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: uartps: do not deassert RS485 RTS GPIO prematurely
Date: Mon, 25 Aug 2025 11:22:51 +0200
Message-Id: <20250825092251.1444274-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After all bytes to be transmitted have been written to the FIFO
register, the hardware might still be busy actually sending them.

Thus, wait for the TX FIFO to be empty before starting the timer for the
RTS after send delay.

Cc: stable@vger.kernel.org
Fixes: fccc9d9233f9 ("tty: serial: uartps: Add rs485 support to uartps driver")
Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
Changes in v2:
- Add cc stable
- Add timeout

 drivers/tty/serial/xilinx_uartps.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index fe457bf1e15bb..e1dd3843d563c 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -429,7 +429,7 @@ static void cdns_uart_handle_tx(void *dev_id)
 	struct uart_port *port = (struct uart_port *)dev_id;
 	struct cdns_uart *cdns_uart = port->private_data;
 	struct tty_port *tport = &port->state->port;
-	unsigned int numbytes;
+	unsigned int numbytes, tmout;
 	unsigned char ch;
 
 	if (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port)) {
@@ -454,6 +454,13 @@ static void cdns_uart_handle_tx(void *dev_id)
 
 	if (cdns_uart->port->rs485.flags & SER_RS485_ENABLED &&
 	    (kfifo_is_empty(&tport->xmit_fifo) || uart_tx_stopped(port))) {
+		/* Wait for the tx fifo to be actually empty */
+		for (tmout = 1000000; tmout; tmout--) {
+			if (cdns_uart_tx_empty(port) == TIOCSER_TEMT)
+				break;
+			udelay(1);
+		}
+
 		hrtimer_update_function(&cdns_uart->tx_timer, cdns_rs485_rx_callback);
 		hrtimer_start(&cdns_uart->tx_timer,
 			      ns_to_ktime(cdns_calc_after_tx_delay(cdns_uart)), HRTIMER_MODE_REL);
-- 
2.39.5



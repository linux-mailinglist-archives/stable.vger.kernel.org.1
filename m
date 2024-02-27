Return-Path: <stable+bounces-24514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9A88694DF
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:57:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4271C24E3A
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E413B7A0;
	Tue, 27 Feb 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="s4qMaRjn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5843B54BD4;
	Tue, 27 Feb 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042220; cv=none; b=ISdhDy9w45mEW/VvPJUyqBsRK7kpr5sIxuFpA9AsU8kW4UrmVmWpXtAW9LNJvYcwsh7sEu6MnAQDcXaOUO5HxU6zlH29xLIW7I2illXg+FzxB7pPIYFT17/GPXfFVL+gbie+MuZdbz7S9Rmnh3jGxINEHbKBBLDnIilmZUaZzgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042220; c=relaxed/simple;
	bh=lzhqZBOeanCTpcUtFtV4OqQtLvvQuvgpOUJ3KpV2duo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggMZlOZhSDtk6j+nkqUNrhZ81elBbH93hfn10HxEAvHLJ9lFWyTXXl1qhR//Rxy2FXlI4aWvY877Xa81jdbqS4RyIsjLbnLYQDuR1D8iOEoolXJUtOfzBvWXZpmU46ZAywxu+ZVsCUUAWTFkjHlscjnQK97h+EsrgeYTch3AQcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=s4qMaRjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9796C433F1;
	Tue, 27 Feb 2024 13:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709042220;
	bh=lzhqZBOeanCTpcUtFtV4OqQtLvvQuvgpOUJ3KpV2duo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s4qMaRjnl0xPVuX1XTwprAoYAhXYhqnT5kvU8cBCDESTotLah2L5vyE3N6+V29IFz
	 jjO68MnSxuX0dnUv4qWaa3vGBEeE5zTTQefZvGEcxzlbRKYBpb3qpwGAn9VLkv75Ak
	 gXLbLs8DFG5TPJ0+YkxLGUowPn2k8Mn9z4eg2NBc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH 6.6 182/299] serial: amba-pl011: Fix DMA transmission in RS485 mode
Date: Tue, 27 Feb 2024 14:24:53 +0100
Message-ID: <20240227131631.700631637@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131625.847743063@linuxfoundation.org>
References: <20240227131625.847743063@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lino Sanfilippo <l.sanfilippo@kunbus.com>

commit 3b69e32e151bc4a4e3c785cbdb1f918d5ee337ed upstream.

When DMA is used in RS485 mode make sure that the UARTs tx section is
enabled before the DMA buffers are queued for transmission.

Cc: stable@vger.kernel.org
Fixes: 8d479237727c ("serial: amba-pl011: add RS485 support")
Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Link: https://lore.kernel.org/r/20240216224709.9928-2-l.sanfilippo@kunbus.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/amba-pl011.c |   60 ++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1345,11 +1345,41 @@ static void pl011_start_tx_pio(struct ua
 	}
 }
 
+static void pl011_rs485_tx_start(struct uart_amba_port *uap)
+{
+	struct uart_port *port = &uap->port;
+	u32 cr;
+
+	/* Enable transmitter */
+	cr = pl011_read(uap, REG_CR);
+	cr |= UART011_CR_TXE;
+
+	/* Disable receiver if half-duplex */
+	if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
+		cr &= ~UART011_CR_RXE;
+
+	if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
+		cr &= ~UART011_CR_RTS;
+	else
+		cr |= UART011_CR_RTS;
+
+	pl011_write(cr, uap, REG_CR);
+
+	if (port->rs485.delay_rts_before_send)
+		mdelay(port->rs485.delay_rts_before_send);
+
+	uap->rs485_tx_started = true;
+}
+
 static void pl011_start_tx(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
+	if ((uap->port.rs485.flags & SER_RS485_ENABLED) &&
+	    !uap->rs485_tx_started)
+		pl011_rs485_tx_start(uap);
+
 	if (!pl011_dma_tx_start(uap))
 		pl011_start_tx_pio(uap);
 }
@@ -1431,42 +1461,12 @@ static bool pl011_tx_char(struct uart_am
 	return true;
 }
 
-static void pl011_rs485_tx_start(struct uart_amba_port *uap)
-{
-	struct uart_port *port = &uap->port;
-	u32 cr;
-
-	/* Enable transmitter */
-	cr = pl011_read(uap, REG_CR);
-	cr |= UART011_CR_TXE;
-
-	/* Disable receiver if half-duplex */
-	if (!(port->rs485.flags & SER_RS485_RX_DURING_TX))
-		cr &= ~UART011_CR_RXE;
-
-	if (port->rs485.flags & SER_RS485_RTS_ON_SEND)
-		cr &= ~UART011_CR_RTS;
-	else
-		cr |= UART011_CR_RTS;
-
-	pl011_write(cr, uap, REG_CR);
-
-	if (port->rs485.delay_rts_before_send)
-		mdelay(port->rs485.delay_rts_before_send);
-
-	uap->rs485_tx_started = true;
-}
-
 /* Returns true if tx interrupts have to be (kept) enabled  */
 static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq)
 {
 	struct circ_buf *xmit = &uap->port.state->xmit;
 	int count = uap->fifosize >> 1;
 
-	if ((uap->port.rs485.flags & SER_RS485_ENABLED) &&
-	    !uap->rs485_tx_started)
-		pl011_rs485_tx_start(uap);
-
 	if (uap->port.x_char) {
 		if (!pl011_tx_char(uap, uap->port.x_char, from_irq))
 			return true;




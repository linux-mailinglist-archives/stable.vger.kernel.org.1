Return-Path: <stable+bounces-5515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C0180D36B
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9285A1F21835
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E774D582;
	Mon, 11 Dec 2023 17:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="X96dM4g3"
X-Original-To: stable@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBBEE9;
	Mon, 11 Dec 2023 09:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=RCNf4eOZsNZBVrawgicgoHTfnt8dk8reDpBLuDlxyRQ=; b=X96dM4g3l4No577Bf7WIWEpoad
	XmPG7kYFvJXG6KjP3FqpW4K9cG3oU3sd8YON/mQMbLyB5y17Y6n28gCfwrjFIUdhsWV6frA7EJaJ1
	14/MVS8kUVkG/JsrSaIi/u0LbhuncEMp7md/1r5yo6rxmqoKlsh32260jX9+a9S/bUNg=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:56730 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rCjr5-0003yC-EK; Mon, 11 Dec 2023 12:14:08 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	hvilleneuve@dimonoff.com,
	jringle@gridpoint.com,
	tomasz.mon@camlingroup.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	stable@vger.kernel.org
Date: Mon, 11 Dec 2023 12:13:53 -0500
Message-Id: <20231211171353.2901416-7-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211171353.2901416-1-hugo@hugovil.com>
References: <20231211171353.2901416-1-hugo@hugovil.com>
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
Subject: [PATCH v2 6/6] serial: sc16is7xx: fix unconditional activation of THRI interrupt
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Commit cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop") changed
behavior to unconditionnaly set the THRI interrupt in sc16is7xx_tx_proc().

For example when sending a 65 bytes message, and assuming the Tx FIFO is
initially empty, sc16is7xx_handle_tx() will write the first 64 bytes of the
message to the FIFO and sc16is7xx_tx_proc() will then activate THRI. When
the THRI IRQ is fired, the driver will write the remaining byte of the
message to the FIFO, and disable THRI by calling sc16is7xx_stop_tx().

When sending a 2 bytes message, sc16is7xx_handle_tx() will write the 2
bytes of the message to the FIFO and call sc16is7xx_stop_tx(), disabling
THRI. After sc16is7xx_handle_tx() exits, control returns to
sc16is7xx_tx_proc() which will unconditionally set THRI. When the THRI IRQ
is fired, the driver simply acknowledges the interrupt and does nothing
more, since all the data has already been written to the FIFO. This results
in 2 register writes and 4 register reads all for nothing and taking
precious cycles from the I2C/SPI bus.

Fix this by enabling the THRI interrupt only when we fill the Tx FIFO to
its maximum capacity and there are remaining bytes to send in the message.

Fixes: cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")
Cc: stable@vger.kernel.org
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 7e4b9b52841d..e40e4a99277e 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -687,6 +687,8 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 
 	if (uart_circ_empty(xmit))
 		sc16is7xx_stop_tx(port);
+	else
+		sc16is7xx_ier_set(port, SC16IS7XX_IER_THRI_BIT);
 	uart_port_unlock_irqrestore(port, flags);
 }
 
@@ -815,7 +817,6 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 {
 	struct uart_port *port = &(to_sc16is7xx_one(ws, tx_work)->port);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
-	unsigned long flags;
 
 	if ((port->rs485.flags & SER_RS485_ENABLED) &&
 	    (port->rs485.delay_rts_before_send > 0))
@@ -824,10 +825,6 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	mutex_lock(&one->efr_lock);
 	sc16is7xx_handle_tx(port);
 	mutex_unlock(&one->efr_lock);
-
-	uart_port_lock_irqsave(port, &flags);
-	sc16is7xx_ier_set(port, SC16IS7XX_IER_THRI_BIT);
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
-- 
2.39.2



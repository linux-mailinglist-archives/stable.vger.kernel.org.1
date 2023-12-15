Return-Path: <stable+bounces-6825-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3802081490B
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 14:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2D071F237CF
	for <lists+stable@lfdr.de>; Fri, 15 Dec 2023 13:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4212DB89;
	Fri, 15 Dec 2023 13:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BxgnCdqW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FA331598
	for <stable@vger.kernel.org>; Fri, 15 Dec 2023 13:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2BD5C433C8;
	Fri, 15 Dec 2023 13:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702646478;
	bh=zjLZEtbLVZaBf7Zk4LDwRoMfAFakOVvXResPp9km9bY=;
	h=Subject:To:From:Date:From;
	b=BxgnCdqWLa2WiZFilvisiy1mtNloXFc5WuKGp/3Jv+d15aQb4IPZwLiTGKx3/Ms79
	 qrN26W7V5h7LwSl6VJcIWRJwMn5SFRCfS907oJyJw8D93/UmSQiSPYQHPkoFc9mgFE
	 V6ZCxLh0t6L3wfiCi2cIt6p0b6r6HuqUZl2TYxCI=
Subject: patch "serial: sc16is7xx: fix unconditional activation of THRI interrupt" added to tty-testing
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 Dec 2023 14:20:55 +0100
Message-ID: <2023121555-bulb-broadside-cf8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: sc16is7xx: fix unconditional activation of THRI interrupt

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 9915753037eba7135b209fef4f2afeca841af816 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 11 Dec 2023 12:13:53 -0500
Subject: serial: sc16is7xx: fix unconditional activation of THRI interrupt

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
Cc:  <stable@vger.kernel.org>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Link: https://lore.kernel.org/r/20231211171353.2901416-7-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.43.0




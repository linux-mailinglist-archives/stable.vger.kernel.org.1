Return-Path: <stable+bounces-16020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 745EC83E735
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 00:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DF51C27F02
	for <lists+stable@lfdr.de>; Fri, 26 Jan 2024 23:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3DE2557A;
	Fri, 26 Jan 2024 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="spF4uBmn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CABE24B30
	for <stable@vger.kernel.org>; Fri, 26 Jan 2024 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706312843; cv=none; b=BHZXiihj4et0pqaKhSowWkUEvtyrCN2HlU5VthvfyCuzr11Nv57SkCv5orJ16CBVb+OKQ3VvndM6EHKhD2J0OlE7YJfD0v56VmUILTc7FdVV1sqMeexz9XuutI/S1+RIBce57kRPRM036jLISpbz9OX4kk80tqQEFGDbcYo98eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706312843; c=relaxed/simple;
	bh=Biu5j5QQC6WMz+cQftlgujfSXdjAoYss5PIm1VNn5D4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Buj0kyllxrhx2kwZ0ejaycuzkGASSKcQJGJn/PHPvq5Tk+OFeGCS+HgZzRzvV4r24bKo70QByJAQZFTJZ1Fary5AGzD+6BxDEIdjZgMMAa4ospL+57QSuGyV8TH+l8X3/wUPcUzFWGxf7YCJzWcPxtx9TKL/+0VZVjl64jC3x6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=spF4uBmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD585C433F1;
	Fri, 26 Jan 2024 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706312842;
	bh=Biu5j5QQC6WMz+cQftlgujfSXdjAoYss5PIm1VNn5D4=;
	h=Subject:To:Cc:From:Date:From;
	b=spF4uBmnCEMaPYIdj8h3VJRufDJ0TkIsOgNlvJo9LRj2ow3bgTQE49zDaNNN3QSMk
	 gpH6V62dpmKIIuLw8jPLZIcYCtjryASFQelooeK96QHrNFN3ChaLAJWfkqpYoN1bDx
	 32u+cTIxfkwKnT02AsTXtRhAo1Hfvqf26pmqxxCw=
Subject: FAILED: patch "[PATCH] serial: sc16is7xx: fix unconditional activation of THRI" failed to apply to 6.6-stable tree
To: hvilleneuve@dimonoff.com,gregkh@linuxfoundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 26 Jan 2024 15:47:21 -0800
Message-ID: <2024012621-imaging-challenge-bb29@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9915753037eba7135b209fef4f2afeca841af816
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012621-imaging-challenge-bb29@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

9915753037eb ("serial: sc16is7xx: fix unconditional activation of THRI interrupt")
4409df5866b7 ("serial: sc16is7xx: change EFR lock to operate on each channels")
3837a0379533 ("serial: sc16is7xx: improve regmap debugfs by using one regmap per port")
b465848be8a6 ("serial: sc16is7xx: Use port lock wrappers")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9915753037eba7135b209fef4f2afeca841af816 Mon Sep 17 00:00:00 2001
From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Mon, 11 Dec 2023 12:13:53 -0500
Subject: [PATCH] serial: sc16is7xx: fix unconditional activation of THRI
 interrupt

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



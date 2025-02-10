Return-Path: <stable+bounces-114684-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A31B6A2F352
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B803A57AE
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD132580ED;
	Mon, 10 Feb 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sDGHHFtg"
X-Original-To: stable@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12412580DF
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 16:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739204615; cv=none; b=KAhUiZ86SV7UesAAS6AxpaQOGPTQnK7ADxShsVQO8FGP7xY2Z6Ep/ujdwFzMKJL4dwQf7cm2Ul1+n4CwJSF5lsZim9FypcdP4G2vCm1IHADIjVCmv02D6BRwV/lYomxL10pxSPCXWIExeh96NqmhIL9f4R9c5mtdcq5u+bednfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739204615; c=relaxed/simple;
	bh=Rzn8t5va8NpRQH2EPINPYw0RIov2GsAX+pxBrAby6HY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nz5r9GgTLcZbYcHeDKoQvpXzb3vbKvClskqpQC1SrolSGWe831ZAP7EKe79HLfjT/dMp+wYi+7PGHAgBcq6sce9JAcQwExfEAC7/xnXdH5XsqsZrSRjSU4LyUIjT/cCzbvSZX4TPIbdWgvQ2x69L5YBULujSYRX4ieeD+hC9sCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sDGHHFtg; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739204610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q2arHOJIV6WsS55KzoD9Uj3bxGoXyKVwzSE4k4FtXWI=;
	b=sDGHHFtg7fvWlXdFVd0ozPAZBeKzVqrHBoy/Lffqgx5kHAvIqmBFvgaZo0i9CgYb+gVjVs
	dpShaoYXTm+f0mAWfrr5ApfFvIAKlP2UU8ba9TF8b8r0sk7DYwJEeVRhSqz6/Rl5Cgrkfu
	Rs8NBZeNG0VsLbwqEabkY3j8w05Rac0=
From: Sean Anderson <sean.anderson@linux.dev>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: john.ogness@linutronix.de,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 6.6.y] tty: xilinx_uartps: split sysrq handling
Date: Mon, 10 Feb 2025 11:22:52 -0500
Message-Id: <20250210162252.2134752-1-sean.anderson@linux.dev>
In-Reply-To: <2025020949-press-evolve-b900@gregkh>
References: <2025020949-press-evolve-b900@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

lockdep detects the following circular locking dependency:

CPU 0                      CPU 1
========================== ============================
cdns_uart_isr()            printk()
  uart_port_lock(port)       console_lock()
			     cdns_uart_console_write()
                               if (!port->sysrq)
                                 uart_port_lock(port)
  uart_handle_break()
    port->sysrq = ...
  uart_handle_sysrq_char()
    printk()
      console_lock()

The fixed commit attempts to avoid this situation by only taking the
port lock in cdns_uart_console_write if port->sysrq unset. However, if
(as shown above) cdns_uart_console_write runs before port->sysrq is set,
then it will try to take the port lock anyway. This may result in a
deadlock.

Fix this by splitting sysrq handling into two parts. We use the prepare
helper under the port lock and defer handling until we release the lock.

Fixes: 74ea66d4ca06 ("tty: xuartps: Improve sysrq handling")
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Cc: stable@vger.kernel.org # c980248179d: serial: xilinx_uartps: Use port lock wrappers
Acked-by: John Ogness <john.ogness@linutronix.de>
Link: https://lore.kernel.org/r/20250110213822.2107462-1-sean.anderson@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ resolved merge conflicts ]
Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/tty/serial/xilinx_uartps.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 2e5e86a00a77..7f83d2780017 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -268,7 +268,7 @@ static void cdns_uart_handle_rx(void *dev_id, unsigned int isrstatus)
 				continue;
 		}
 
-		if (uart_handle_sysrq_char(port, data))
+		if (uart_prepare_sysrq_char(port, data))
 			continue;
 
 		if (is_rxbs_support) {
@@ -369,7 +369,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 	    !(readl(port->membase + CDNS_UART_CR) & CDNS_UART_CR_RX_DIS))
 		cdns_uart_handle_rx(dev_id, isrstatus);
 
-	spin_unlock(&port->lock);
+	uart_unlock_and_check_sysrq(port);
 	return IRQ_HANDLED;
 }
 
@@ -1229,10 +1229,8 @@ static void cdns_uart_console_write(struct console *co, const char *s,
 	unsigned int imr, ctrl;
 	int locked = 1;
 
-	if (port->sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(port, &flags);
 	else
 		spin_lock_irqsave(&port->lock, flags);
 
-- 
2.35.1.1320.gc452695387.dirty



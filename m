Return-Path: <stable+bounces-114687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EDC0A2F3B5
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 17:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7DB43A3DE9
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7789F1F4616;
	Mon, 10 Feb 2025 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SrBRwNB9"
X-Original-To: stable@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE32580D6
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739205372; cv=none; b=t1R+4MnWPb98i4JJ21YqP3LdChl9CuHQB8W9k+Xxs20OcqSyORZEGzTTSVagvu66A6DkHYTg/c383Omlq5GASIanh2r9RKl1za+GN4HaCUBO5QKeLgdGbn1cP4DvR1FIrvCdDE+rCyJHP04L6GRPiupBZr34Fm3E20q7+RC1Xrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739205372; c=relaxed/simple;
	bh=irSgUq6BFCMIvDCIg6N6du1fRSo0guAVHC4BTgyWdFQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H757dbAAfT5L80HwqHoarRRUDkqKzBnhm+QjwOI/KHmZlAioBKwUFT6VnSDNPR4DJTQfl7r8zNykyJ8JkMAbOMg9JA1Laz/m9l0dRfML/60kcBfw8Xg1vM1gfmXuqcTYJL7KEmdMzQx5sFhhXqxdUYKrCMZOHPQOsms3MKZ7Yks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SrBRwNB9; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739205368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TjWxeJdT3RCVvwHD9ktSqmp7ziMGGCm/jOw9RNlAREE=;
	b=SrBRwNB9Bmlipx8gDcJmNBQTd64vza8XYRgAYD2t5kT7sXeu775zMrRd8rKdcV7N6wF5D3
	kRP7A8LlPRTNpzwR5wlcxdvf0x92wa3o0qMKUAgvB3ki3Np8pKUwYNk+6Uv1zrEED4p6SV
	y30ibadGarm2VygsF+1cBtGE/Tcet/U=
From: Sean Anderson <sean.anderson@linux.dev>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: john.ogness@linutronix.de,
	Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH 6.6.y v2] tty: xilinx_uartps: split sysrq handling
Date: Mon, 10 Feb 2025 11:36:01 -0500
Message-Id: <20250210163602.2136356-1-sean.anderson@linux.dev>
In-Reply-To: <20250210162252.2134752-1-sean.anderson@linux.dev>
References: <20250210162252.2134752-1-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

commit b06f388994500297bb91be60ffaf6825ecfd2afe upstream

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

Changes in v2:
- Add missing "commit ... upstream" line

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



Return-Path: <stable+bounces-213286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBZREuwsgmlFQAMAu9opvQ
	(envelope-from <stable+bounces-213286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:14:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D77FDC953
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6584C3029290
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 17:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D253D4135;
	Tue,  3 Feb 2026 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TgQTzPow"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C739339900D;
	Tue,  3 Feb 2026 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138699; cv=none; b=EedDeQDnJthceuZkExFiVFum8Do2xUauVEWjm9PWPiyMR409G86SdFRsHqrSE1sKgLkbCrWY+skHgKBHkOj3vE0K3rCSt4/Yww0bgHLlvVHaWm1ZFnsxXAx5s0ZFIdgo13Fp6rKEXaf+AfVZ7JPEvJosWlJ9OSoR/VQX0LXtRH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138699; c=relaxed/simple;
	bh=Rr8YWcdvf+lD4/sci2RgBkuBudxzQXyLEVraa7BMbgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNKA7fgR+TUmFnHW26Eo1FRK3DqMD+d1DafTAVxBTgx0lQvZTq6xXSAaUgRo+xsVBbm7u7a1xl6p6iP4Q+TM8NGh8BnPuHVyX9cSZOw6ju6aAyeUkevBI69jcFnuHNJ/mMs0K3GvpGk74g3MWhBlefZu+4fM95TeFdI66USMXj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TgQTzPow; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770138698; x=1801674698;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rr8YWcdvf+lD4/sci2RgBkuBudxzQXyLEVraa7BMbgo=;
  b=TgQTzPowrLSaEqeztoxOzDJuh7nu/mOJq74TzYWBqZgEYqoWm33p7ZQM
   ZMgZ5fEdcsfjM+Rom2d3yY1EictMpej3Jp3eA3R6EwiKf3iyupGUM6mKx
   zqCjCWUW9cAlbAONkYbnnHmW3lmw0uRcY4wyfLL5uJTD6nRZtQL0aMU0w
   E9MvnZ33CJzekNE1N5nKwLYoawewREJg5r1+6ZsdJoi6FUL/ixqLJwbKv
   4gP1qOl0xdhuosSd7NnAkFaz8Ed8/sp6t7Zm9pnrlwrHKg+AIFyejtMHz
   FKrEmK4VSTythTXd6T5/YZEUY/A2jhthfEKtCLlD4XzCO5ld/LxHn10kY
   A==;
X-CSE-ConnectionGUID: 5j5dZg8RRT2ojIp3PoJAZg==
X-CSE-MsgGUID: rr4Al4CvQbyacwk+sTHDrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71295001"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71295001"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:11:37 -0800
X-CSE-ConnectionGUID: U8P0FBLKSIeVzVLir4hsFQ==
X-CSE-MsgGUID: 0nbxCCU0Qj+pKJKPVZkjMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210040585"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:11:33 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: "Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 4/7] serial: 8250_dw: Rework dw8250_handle_irq() locking and IIR handling
Date: Tue,  3 Feb 2026 19:10:46 +0200
Message-Id: <20260203171049.4353-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260203171049.4353-1-ilpo.jarvinen@linux.intel.com>
References: <20260203171049.4353-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,linux.intel.com,163.com,arista.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213286-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7D77FDC953
X-Rspamd-Action: no action

dw8250_handle_irq() takes port's lock multiple times with no good
reason to release it in between and calls serial8250_handle_irq()
that also takes port's lock.

Take port's lock only once in dw8250_handle_irq() and use
serial8250_handle_irq_locked() to avoid releasing port's lock in
between.

As IIR_NO_INT check in serial8250_handle_irq() was outside of port's
lock, it has to be done already in dw8250_handle_irq().

DW UART can, in addition to IIR_NO_INT, report BUSY_DETECT (0x7) which
collided with the IIR_NO_INT (0x1) check in serial8250_handle_irq()
(because & is used instead of ==) meaning that no other work is done by
serial8250_handle_irq() during an BUSY_DETECT interrupt.

This allows reorganizing code in dw8250_handle_irq() to do both
IIR_NO_INT and BUSY_DETECT handling right at the start simplifying
the logic.

Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 37 ++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 7500b1ff1ac1..964750d17186 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -9,6 +9,9 @@
  * LCR is written whilst busy.  If it is, then a busy detect interrupt is
  * raised, the LCR needs to be rewritten and the uart status register read.
  */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -40,6 +43,8 @@
 #define RZN1_UART_RDMACR 0x110 /* DMA Control Register Receive Mode */
 
 /* DesignWare specific register fields */
+#define DW_UART_IIR_IID			GENMASK(3, 0)
+
 #define DW_UART_MCR_SIRE		BIT(6)
 
 /* Renesas specific register fields */
@@ -312,7 +317,19 @@ static int dw8250_handle_irq(struct uart_port *p)
 	bool rx_timeout = (iir & 0x3f) == UART_IIR_RX_TIMEOUT;
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
-	unsigned long flags;
+
+	switch (FIELD_GET(DW_UART_IIR_IID, iir)) {
+	case UART_IIR_NO_INT:
+		return 0;
+
+	case UART_IIR_BUSY:
+		/* Clear the USR */
+		serial_port_in(p, d->pdata->usr_reg);
+
+		return 1;
+	}
+
+	guard(uart_port_lock_irqsave)(p);
 
 	/*
 	 * There are ways to get Designware-based UARTs into a state where
@@ -325,20 +342,15 @@ static int dw8250_handle_irq(struct uart_port *p)
 	 * so we limit the workaround only to non-DMA mode.
 	 */
 	if (!up->dma && rx_timeout) {
-		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
 
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
 			serial_port_in(p, UART_RX);
-
-		uart_port_unlock_irqrestore(p, flags);
 	}
 
 	/* Manually stop the Rx DMA transfer when acting as flow controller */
 	if (quirks & DW_UART_QUIRK_IS_DMA_FC && up->dma && up->dma->rx_running && rx_timeout) {
-		uart_port_lock_irqsave(p, &flags);
 		status = serial_lsr_in(up);
-		uart_port_unlock_irqrestore(p, flags);
 
 		if (status & (UART_LSR_DR | UART_LSR_BI)) {
 			dw8250_writel_ext(p, RZN1_UART_RDMACR, 0);
@@ -346,17 +358,9 @@ static int dw8250_handle_irq(struct uart_port *p)
 		}
 	}
 
-	if (serial8250_handle_irq(p, iir))
-		return 1;
-
-	if ((iir & UART_IIR_BUSY) == UART_IIR_BUSY) {
-		/* Clear the USR */
-		serial_port_in(p, d->pdata->usr_reg);
+	serial8250_handle_irq_locked(p, iir);
 
-		return 1;
-	}
-
-	return 0;
+	return 1;
 }
 
 static void dw8250_clk_work_cb(struct work_struct *work)
@@ -858,6 +862,7 @@ static struct platform_driver dw8250_platform_driver = {
 
 module_platform_driver(dw8250_platform_driver);
 
+MODULE_IMPORT_NS("SERIAL_8250");
 MODULE_AUTHOR("Jamie Iles");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Synopsys DesignWare 8250 serial port driver");
-- 
2.39.5



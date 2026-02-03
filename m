Return-Path: <stable+bounces-213289-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qD7pKnMtgmlFQAMAu9opvQ
	(envelope-from <stable+bounces-213289-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:16:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B5DC9E6
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 317383040453
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 17:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA4B3D4137;
	Tue,  3 Feb 2026 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ig86S//F"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952A530CDBB;
	Tue,  3 Feb 2026 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138728; cv=none; b=RAgb7WAtlgXAhhlj9iIGbVRzbs399OC4gUJlPOwztBJhgd5cM9vrc99OBRJhqwqBxzFcsQut4fmrEVHs+FQ+wglC3Xf2pysmPuS0cLTZbaneBRk2q0DodQqUoJDH2fKp7q8+dBtgAXEGr35sBAquO1GEtC4pWk/1QRsIReHo5y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138728; c=relaxed/simple;
	bh=1k0bLwnVUAs9igKaUE9po7t1sQyNJ2VxhenWhVgPaWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kj3jtag2UP1yds6GxchJgmma4H3TMOJalY/hRngX3ud9s+DMr8yqmPg8khJIlCQXzhbD3yKbJNo+Q+8i7iT1RxVrusT9zI5jGKptZk2qSq0WgEJzGydRkTRgswnjrPoB4Yp6cuYY/gFgr6/ms45qceXjcEnYhkyqjo9jfecmxZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ig86S//F; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770138727; x=1801674727;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1k0bLwnVUAs9igKaUE9po7t1sQyNJ2VxhenWhVgPaWU=;
  b=Ig86S//FbRxBw+r+vLXKwLRvBrATX5tA4HC5H3JnnGtWvkFyARzH8nmB
   QEfihiTzMlrlgs2ekub2EAJx3CwFf6iF+xarZkj44JS29P+5EHh6Dtd/R
   +Yn+UfgcPZg9pWlIqHMjj6i/V2ys2mZqOS+JE8v6ABT7FOl4OTshFSZnC
   p4itubr+L+tbo3g37H0h4Y4XZ3MN/llsfU1N+JqbaTbjluA2hsVwMUzT0
   y8PmjswTqswQrDppwsNgwKcr71c6w5wAQGwOTqCVqsp9va0A2eR+SlFBk
   TFJAqy+l0lt7vBmJnt9vjiKn0UvmC5/iqoy1v5kGS8sLbmjgVEFqncLAm
   w==;
X-CSE-ConnectionGUID: L2VA/WjhSwG3GhUqSVnKLQ==
X-CSE-MsgGUID: cjPoQoM+RDK4VQf1YtrJdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71295060"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71295060"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:12:06 -0800
X-CSE-ConnectionGUID: Z/lvYd34Ra+dFEqS6dh0Zw==
X-CSE-MsgGUID: g9P/dPoDR9iKW9nBVU1cQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210040808"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:12:00 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	qianfan Zhao <qianfanguijin@163.com>,
	Adriana Nicolae <adriana@arista.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Matt Porter <matt.porter@linaro.org>,
	Tim Kryger <tim.kryger@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Markus Mayer <markus.mayer@linaro.org>,
	Jamie Iles <jamie@jamieiles.com>,
	linux-kernel@vger.kernel.org
Cc: "Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 7/7] serial: 8250_dw: Ensure BUSY is deasserted
Date: Tue,  3 Feb 2026 19:10:49 +0200
Message-Id: <20260203171049.4353-8-ilpo.jarvinen@linux.intel.com>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-213289-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,linux.intel.com,163.com,arista.com,linaro.org,jamieiles.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[16];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 0C1B5DC9E6
X-Rspamd-Action: no action

DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
Existance of BUSY depends on uart_16550_compatible, if UART HW is
configured with it those registers can always be written.

There currently is dw8250_force_idle() which attempts to achieve
non-BUSY state by disabling FIFO, however, the solution is unreliable
when Rx keeps getting more and more characters.

Create a sequence of operations that ensures UART cannot keep BUSY
asserted indefinitely. The new sequence relies on enabling loopback mode
temporarily to prevent incoming Rx characters keeping UART BUSY.

Ensure no Tx in ongoing while the UART is switches into the loopback
mode (requires exporting serial8250_fifo_wait_for_lsr_thre() and adding
DMA Tx pause/resume functions).

According to tests performed by Adriana Nicolae <adriana@arista.com>,
simply disabling FIFO or clearing FIFOs only once does not always
ensure BUSY is deasserted but up to two tries may be needed. This could
be related to ongoing Rx of a character (a guess, not known for sure).
Therefore, retry FIFO clearing a few times (retry limit 4 is arbitrary
number but using, e.g., p->fifosize seems overly large). Tests
performed by others did not exhibit similar challenge but it does not
seem harmful to leave the FIFO clearing loop in place for all DW UARTs
with BUSY functionality.

Use the new dw8250_idle_enter/exit() to do divisor writes and LCR
writes. In case of plain LCR writes, opportunistically try to update
LCR first and only invoke dw8250_idle_enter() if the write did not
succeed (it has been observed that in practice most LCR writes do
succeed without complications).

This issue was first reported by qianfan Zhao who put lots of debugging
effort into understanding the solution space.

Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
Fixes: 7d4008ebb1c9 ("tty: add a DesignWare 8250 driver")
Cc: <stable@vger.kernel.org>
Reported-by: qianfan Zhao <qianfanguijin@163.com>
Link: https://lore.kernel.org/linux-serial/289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com/
Reported-by: Adriana Nicolae <adriana@arista.com>
Link: https://lore.kernel.org/linux-serial/20250819182322.3451959-1-adriana@arista.com/
Reported-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250.h      |  25 +++++
 drivers/tty/serial/8250/8250_dw.c   | 163 +++++++++++++++++++++-------
 drivers/tty/serial/8250/8250_port.c |  28 ++---
 3 files changed, 161 insertions(+), 55 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 8caecfc85d93..77fe0588fd6b 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -175,7 +175,9 @@ static unsigned int __maybe_unused serial_icr_read(struct uart_8250_port *up,
 	return value;
 }
 
+void serial8250_clear_fifos(struct uart_8250_port *p);
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
+void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count);
 
 void serial8250_rpm_get(struct uart_8250_port *p);
 void serial8250_rpm_put(struct uart_8250_port *p);
@@ -400,6 +402,26 @@ static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
 
 	return dma && dma->tx_running;
 }
+
+static inline void serial8250_tx_dma_pause(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	if (!dma->tx_running)
+		return;
+
+	dmaengine_pause(dma->txchan);
+}
+
+static inline void serial8250_tx_dma_resume(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	if (!dma->tx_running)
+		return;
+
+	dmaengine_resume(dma->txchan);
+}
 #else
 static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
@@ -421,6 +443,9 @@ static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
 {
 	return false;
 }
+
+static inline void serial8250_tx_dma_pause(struct uart_8250_port *p) { }
+static inline void serial8250_tx_dma_resume(struct uart_8250_port *p) { }
 #endif
 
 static inline int ns16550a_goto_highspeed(struct uart_8250_port *up)
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index edae359b1c3f..315f4315cf69 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/lockdep.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
@@ -47,6 +48,8 @@
 
 #define DW_UART_MCR_SIRE		BIT(6)
 
+#define DW_UART_USR_BUSY		BIT(0)
+
 /* Renesas specific register fields */
 #define RZN1_UART_xDMACR_DMA_EN		BIT(0)
 #define RZN1_UART_xDMACR_1_WORD_BURST	(0 << 1)
@@ -89,6 +92,7 @@ struct dw8250_data {
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+	unsigned int		in_idle:1;
 
 	u8			no_int_count;
 };
@@ -121,78 +125,151 @@ static inline u32 dw8250_modify_msr(struct uart_port *p, unsigned int offset, u3
 	return value;
 }
 
+static void dw8250_idle_exit(struct uart_port *p)
+{
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	if (d->uart_16550_compatible)
+		return;
+
+	if (up->capabilities & UART_CAP_FIFO)
+		serial_port_out(p, UART_FCR, up->fcr);
+	serial_port_out(p, UART_MCR, up->mcr);
+	serial_port_out(p, UART_IER, up->ier);
+
+	/* DMA Rx is restarted by IRQ handler as needed. */
+	if (up->dma)
+		serial8250_tx_dma_resume(up);
+
+	d->in_idle = 0;
+}
+
 /*
- * This function is being called as part of the uart_port::serial_out()
- * routine. Hence, it must not call serial_port_out() or serial_out()
- * against the modified registers here, i.e. LCR.
+ * Ensure BUSY is not asserted. If DW UART is configured with
+ * !uart_16550_compatible, the writes to LCR, DLL, and DLH fail while
+ * BUSY is asserted.
+ *
+ * Context: port's lock must be held
  */
-static void dw8250_force_idle(struct uart_port *p)
+static int dw8250_idle_enter(struct uart_port *p)
 {
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	unsigned int usr_reg = d->pdata ? d->pdata->usr_reg : DW_UART_USR;
 	struct uart_8250_port *up = up_to_u8250p(p);
-	unsigned int lsr;
+	int retries;
+	u32 lsr;
 
-	/*
-	 * The following call currently performs serial_out()
-	 * against the FCR register. Because it differs to LCR
-	 * there will be no infinite loop, but if it ever gets
-	 * modified, we might need a new custom version of it
-	 * that avoids infinite recursion.
-	 */
-	serial8250_clear_and_reinit_fifos(up);
+	lockdep_assert_held_once(&p->lock);
+
+	if (d->uart_16550_compatible)
+		return 0;
+
+	d->in_idle = 1;
+
+	/* Prevent triggering interrupt from RBR filling */
+	serial_port_out(p, UART_IER, 0);
+
+	if (up->dma) {
+		serial8250_rx_dma_flush(up);
+		if (serial8250_tx_dma_running(up))
+			serial8250_tx_dma_pause(up);
+	}
 
 	/*
-	 * With PSLVERR_RESP_EN parameter set to 1, the device generates an
-	 * error response when an attempt to read an empty RBR with FIFO
-	 * enabled.
+	 * Wait until Tx becomes empty + one extra frame time to ensure all bits
+	 * have been sent on the wire.
+	 *
+	 * FIXME: frame_time delay is too long with very low baudrates.
 	 */
-	if (up->fcr & UART_FCR_ENABLE_FIFO) {
-		lsr = serial_port_in(p, UART_LSR);
-		if (!(lsr & UART_LSR_DR))
-			return;
+	serial8250_fifo_wait_for_lsr_thre(up, p->fifosize);
+	ndelay(p->frame_time);
+
+	serial_port_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
+
+	retries = 4;	/* Arbitrary limit, 2 was always enough in tests */
+	do {
+		serial8250_clear_fifos(up);
+		if (!(serial_port_in(p, usr_reg) & DW_UART_USR_BUSY))
+			break;
+		/* FIXME: frame_time delay is too long with very low baudrates. */
+		ndelay(p->frame_time);
+	} while (--retries);
+
+	lsr = serial_lsr_in(up);
+	if (lsr & UART_LSR_DR) {
+		serial_port_in(p, UART_RX);
+		up->lsr_saved_flags = 0;
 	}
 
-	serial_port_in(p, UART_RX);
+	/* Now guaranteed to have BUSY deasserted? Just sanity check */
+	if (serial_port_in(p, usr_reg) & DW_UART_USR_BUSY) {
+		dw8250_idle_exit(p);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+	int ret;
+
+	ret = dw8250_idle_enter(p);
+	if (ret < 0)
+		return;
+
+	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
+	if (!(serial_port_in(p, UART_LCR) & UART_LCR_DLAB))
+		goto idle_failed;
+
+	serial_dl_write(up, quot);
+	serial_port_out(p, UART_LCR, up->lcr);
+
+idle_failed:
+	dw8250_idle_exit(p);
 }
 
 /*
  * This function is being called as part of the uart_port::serial_out()
- * routine. Hence, it must not call serial_port_out() or serial_out()
- * against the modified registers here, i.e. LCR.
+ * routine. Hence, special care must be taken when serial_port_out() or
+ * serial_out() against the modified registers here, i.e. LCR (d->in_idle is
+ * used to break recursion loop).
  */
 static void dw8250_check_lcr(struct uart_port *p, unsigned int offset, u32 value)
 {
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
-	void __iomem *addr = p->membase + (offset << p->regshift);
-	int tries = 1000;
+	u32 lcr;
+	int ret;
 
 	if (offset != UART_LCR || d->uart_16550_compatible)
 		return;
 
+	lcr = serial_port_in(p, UART_LCR);
+
 	/* Make sure LCR write wasn't ignored */
-	while (tries--) {
-		u32 lcr = serial_port_in(p, offset);
+	if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
+		return;
 
-		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
-			return;
+	if (d->in_idle)
+		goto write_err;
 
-		dw8250_force_idle(p);
+	ret = dw8250_idle_enter(p);
+	if (ret < 0)
+		goto write_err;
 
-#ifdef CONFIG_64BIT
-		if (p->type == PORT_OCTEON)
-			__raw_writeq(value & 0xff, addr);
-		else
-#endif
-		if (p->iotype == UPIO_MEM32)
-			writel(value, addr);
-		else if (p->iotype == UPIO_MEM32BE)
-			iowrite32be(value, addr);
-		else
-			writeb(value, addr);
-	}
+	serial_port_out(p, UART_LCR, value);
+	dw8250_idle_exit(p);
+	return;
+
+write_err:
 	/*
 	 * FIXME: this deadlocks if port->lock is already held
 	 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
 	 */
+	return;		/* Silences "label at the end of compound statement" */
 }
 
 /*
@@ -632,8 +709,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->type		= PORT_8250;
 	p->flags	= UPF_FIXED_PORT;
 	p->dev		= dev;
+
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
+	p->set_divisor	= dw8250_set_divisor;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fb0b8397cd4b..8b31b72e4676 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -489,7 +489,7 @@ serial_port_out_sync(struct uart_port *p, int offset, int value)
 /*
  * FIFO support.
  */
-static void serial8250_clear_fifos(struct uart_8250_port *p)
+void serial8250_clear_fifos(struct uart_8250_port *p)
 {
 	if (p->capabilities & UART_CAP_FIFO) {
 		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
@@ -498,6 +498,7 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
 		serial_out(p, UART_FCR, 0);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(serial8250_clear_fifos, "SERIAL_8250");
 
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
@@ -3200,6 +3201,17 @@ void serial8250_set_defaults(struct uart_8250_port *up)
 }
 EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 
+void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (wait_for_lsr(up, UART_LSR_THRE))
+			return;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(serial8250_fifo_wait_for_lsr_thre, "SERIAL_8250");
+
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
 static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
@@ -3241,16 +3253,6 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
-static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
-{
-	unsigned int i;
-
-	for (i = 0; i < count; i++) {
-		if (wait_for_lsr(up, UART_LSR_THRE))
-			return;
-	}
-}
-
 /*
  * Print a string to the serial port using the device FIFO
  *
@@ -3269,7 +3271,7 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 
 	while (s != end) {
 		/* Allow timeout for each byte of a possibly full FIFO */
-		fifo_wait_for_lsr(up, fifosize);
+		serial8250_fifo_wait_for_lsr_thre(up, fifosize);
 
 		for (i = 0; i < fifosize && s != end; ++i) {
 			if (*s == '\n' && !cr_sent) {
@@ -3287,7 +3289,7 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 	 * Allow timeout for each byte written since the caller will only wait
 	 * for UART_LSR_BOTH_EMPTY using the timeout of a single character
 	 */
-	fifo_wait_for_lsr(up, tx_count);
+	serial8250_fifo_wait_for_lsr_thre(up, tx_count);
 }
 
 /*
-- 
2.39.5



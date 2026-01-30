Return-Path: <stable+bounces-212879-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJNRMtmyfGmbOQIAu9opvQ
	(envelope-from <stable+bounces-212879-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:32:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 82093BB0D0
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28AC13013B68
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 13:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C614F2E6CD3;
	Fri, 30 Jan 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U1DJlcSB"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126DE2EA73D;
	Fri, 30 Jan 2026 13:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779800; cv=none; b=WW2hNToFkn60kelLLqxOIuIGyZiTrYVgPYj2ywry/dQc52Q8ooiuzNnFD5F5v522bYW4BbqUeQo2DuyIlnQss1O9fOcDW8FA4CuBxE0vWSx7LKtkigomV4wehtnhm1FtABsjCn/diOt/gwR92J7L9zOpG7KCpX2/bqNQ2+EIAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779800; c=relaxed/simple;
	bh=oqSvYyhsg1rP5XEyhn2CaU83vEPrBpKnSEx1QJV5kGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jdG2swhTXOx4L1wDfHPxbSpLWjsxC0yrCLaC2cgvOPwk832AlsqMMThmS+piJ+KHZv5wkf2PkwEAXw/FkjYxZha/eY8XnWoYAwWgxeGzvFVRTSQQRfMH8FHTeEHPchBygpZgo2GLbgMCqS5FCuqsOEhMl5cyvJ6DctvDz9sP2l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U1DJlcSB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769779799; x=1801315799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oqSvYyhsg1rP5XEyhn2CaU83vEPrBpKnSEx1QJV5kGg=;
  b=U1DJlcSB99UvHCCJDbp5hjAs4MqUKCal36/2WQDGp/KLlOXK5uMBSrxG
   CrD2xhkbAG4l98zOc8lyhxV2Ft4hSBTXRZVvYF94bzwqDc1TfpOvCTDKL
   0aRQFrjqAjlHd4u57ApxjkxDWw7vmBNZmDgtSYzIyTPxomY05+WE3a8qg
   ciog+qMO6SRQPVyiE06mAu4ESSwe1HG8ot97dV6gUfq1ZXLJaEjwA0+GM
   1EDB9HcTxKN827KWVRXL87odQlTunmvQoWXqXG1TcuJ+ymyIfndIyc91F
   Izr2WagGLzaLnY+rUfCJ0JIzo8gRBV6LXv389+7od4Zc9EdIYG5VZ8PrK
   w==;
X-CSE-ConnectionGUID: Xj6vm3ImRQy3bKl2JXnSyw==
X-CSE-MsgGUID: 89nGze9bRbG+CKGnzmnL6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="70230248"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="70230248"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 05:29:58 -0800
X-CSE-ConnectionGUID: 8X5G4ERrSr+CsagAfB+DrQ==
X-CSE-MsgGUID: gwg8dDZgTTqH5yEBkDhiwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="209271606"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 05:29:54 -0800
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
Subject: [PATCH v3 5/7] serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
Date: Fri, 30 Jan 2026 15:28:55 +0200
Message-Id: <20260130132857.13124-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260130132857.13124-1-ilpo.jarvinen@linux.intel.com>
References: <20260130132857.13124-1-ilpo.jarvinen@linux.intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212879-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linuxfoundation.org,kernel.org,vger.kernel.org,linux.intel.com,163.com,arista.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 82093BB0D0
X-Rspamd-Action: no action

INTC10EE UART can end up into an interrupt storm where it reports
IIR_NO_INT (0x1). If the storm happens during active UART operation, it
is promptly stopped by IIR value change due to Rx or Tx events.
However, when there is no activity, either due to idle serial line or
due to specific circumstances such as during shutdown that writes
IER=0, there is nothing to stop the storm.

During shutdown the storm is particularly problematic because
serial8250_do_shutdown() calls synchronize_irq() that will hang in
waiting for the storm to finish which never happens.

This problem can also result in triggering a warning:

  irq 45: nobody cared (try booting with the "irqpoll" option)
  [...snip...]
  handlers:
    serial8250_interrupt
  Disabling IRQ #45

Normal means to reset interrupt status by reading LSR, MSR, USR, or RX
register do not result in the UART deasserting the IRQ.

Add a quirk to INTC10EE UARTs to enable Tx interrupts if UART's Tx is
currently empty and inactive. Rework IIR_NO_INT to keep track of the
number of consecutive IIR_NO_INT, and on fourth one perform the quirk.
Enabling Tx interrupts should change IIR value from IIR_NO_INT to
IIR_THRI which has been observed to stop the storm.

Fixes: e92fad024929 ("serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART")
Cc: stable@vger.kernel.org
Reported-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 67 +++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 964750d17186..edae359b1c3f 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -61,6 +61,13 @@
 #define DW_UART_QUIRK_IS_DMA_FC		BIT(3)
 #define DW_UART_QUIRK_APMC0D08		BIT(4)
 #define DW_UART_QUIRK_CPR_VALUE		BIT(5)
+#define DW_UART_QUIRK_IER_KICK		BIT(6)
+
+/*
+ * Number of consecutive IIR_NO_INT interrupts required to trigger interrupt
+ * storm prevention code.
+ */
+#define DW_UART_QUIRK_IER_KICK_THRES	4
 
 struct dw8250_platform_data {
 	u8 usr_reg;
@@ -82,6 +89,8 @@ struct dw8250_data {
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+
+	u8			no_int_count;
 };
 
 static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
@@ -308,6 +317,29 @@ static u32 dw8250_serial_in32be(struct uart_port *p, unsigned int offset)
        return dw8250_modify_msr(p, offset, value);
 }
 
+/*
+ * INTC10EE UART can IRQ storm while reporting IIR_NO_INT. Inducing IIR value
+ * change has been observed to break the storm.
+ *
+ * If Tx is empty (THRE asserted), we use here IER_THRI to cause IIR_NO_INT ->
+ * IIR_THRI transition.
+ */
+static void dw8250_quirk_ier_kick(struct uart_port *p)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+	u32 lsr;
+
+	if (up->ier & UART_IER_THRI)
+		return;
+
+	lsr = serial_lsr_in(up);
+	if (!(lsr & UART_LSR_THRE))
+		return;
+
+	serial_port_out(p, UART_IER, up->ier | UART_IER_THRI);
+	serial_port_in(p, UART_LCR);		/* safe, no side-effects */
+	serial_port_out(p, UART_IER, up->ier);
+}
 
 static int dw8250_handle_irq(struct uart_port *p)
 {
@@ -318,18 +350,30 @@ static int dw8250_handle_irq(struct uart_port *p)
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
 
+	guard(uart_port_lock_irqsave)(p);
+
 	switch (FIELD_GET(DW_UART_IIR_IID, iir)) {
 	case UART_IIR_NO_INT:
+		if (d->uart_16550_compatible || up->dma)
+			return 0;
+
+		if (quirks & DW_UART_QUIRK_IER_KICK &&
+		    d->no_int_count == (DW_UART_QUIRK_IER_KICK_THRES - 1))
+			dw8250_quirk_ier_kick(p);
+		d->no_int_count = (d->no_int_count + 1) % DW_UART_QUIRK_IER_KICK_THRES;
+
 		return 0;
 
 	case UART_IIR_BUSY:
 		/* Clear the USR */
 		serial_port_in(p, d->pdata->usr_reg);
 
+		d->no_int_count = 0;
+
 		return 1;
 	}
 
-	guard(uart_port_lock_irqsave)(p);
+	d->no_int_count = 0;
 
 	/*
 	 * There are ways to get Designware-based UARTs into a state where
@@ -562,6 +606,14 @@ static void dw8250_reset_control_assert(void *data)
 	reset_control_assert(data);
 }
 
+static void dw8250_shutdown(struct uart_port *port)
+{
+	struct dw8250_data *d = to_dw8250_data(port->private_data);
+
+	serial8250_do_shutdown(port);
+	d->no_int_count = 0;
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -685,10 +737,12 @@ static int dw8250_probe(struct platform_device *pdev)
 		dw8250_quirks(p, data);
 
 	/* If the Busy Functionality is not implemented, don't handle it */
-	if (data->uart_16550_compatible)
+	if (data->uart_16550_compatible) {
 		p->handle_irq = NULL;
-	else if (data->pdata)
+	} else if (data->pdata) {
 		p->handle_irq = dw8250_handle_irq;
+		p->shutdown = dw8250_shutdown;
+	}
 
 	dw8250_setup_dma_filter(p, data);
 
@@ -815,6 +869,11 @@ static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
 };
 
+static const struct dw8250_platform_data dw8250_intc10ee = {
+	.usr_reg = DW_UART_USR,
+	.quirks = DW_UART_QUIRK_IER_KICK,
+};
+
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
@@ -844,7 +903,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
-	{ "INTC10EE", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INTC10EE", (kernel_ulong_t)&dw8250_intc10ee },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
2.39.5



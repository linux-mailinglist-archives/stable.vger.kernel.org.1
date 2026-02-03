Return-Path: <stable+bounces-213287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WM+sCAYtgmlFQAMAu9opvQ
	(envelope-from <stable+bounces-213287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:14:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC8ADC96A
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 097EB300FECC
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 17:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA563D4139;
	Tue,  3 Feb 2026 17:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jM1gXMX8"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676AA39900D;
	Tue,  3 Feb 2026 17:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138706; cv=none; b=t4aYELAOZltJzT6MjFEJGdHSwHBCEz8zV2ZUtGmfOCOcslDnT3XoRfym4pWf/FwO/wG5i0TEdQnSTdUI+6imchCMOFz33AeQ9rBqgdOMw0us7ctRGfSwIqkad5Y/77gfNm/6AoY9uyEz+TJW7KJ5xYliTbxz2H33L3Sj3QWoE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138706; c=relaxed/simple;
	bh=oqSvYyhsg1rP5XEyhn2CaU83vEPrBpKnSEx1QJV5kGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ABhBb4NMhQIMS9UGFFsirBjjooMJbOkZppBkUxTOTl3GS4619gd7tebDppU/gk+Wilb6spuu6A0qdkgupZ0UdvAejmvZnT/jYmluKn5TD1olab31ICDUAKkaK05Apn4uINxxkS7HfGu6gkxUsvAF3AnHjzvfN+s/Wgkaw6fvtNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jM1gXMX8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770138705; x=1801674705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oqSvYyhsg1rP5XEyhn2CaU83vEPrBpKnSEx1QJV5kGg=;
  b=jM1gXMX8XkCE8UNgSaus5t1FsFRLptEz2JFyFPbAUU0stwkU0T5UCvBq
   X0BpLFhIBTE4mVHeN9u7oF52WYuNFFRL5XcKxPcKsaJoMvGOdZjkaBdrz
   3KdIrYGZHqnHzkqOphk9BBk76PiCvyneE9mHhDMOoWFCmuIwhqZFEm/QJ
   FoltY7uFgwBdjCkkR7+QUr+9MsgNVyEl45eog9VkbLsTfauu3jmEEzdM2
   kP1FUeTfOuDDgJYB4cC8s5bER7FNAsVZ3LUfYssERAw8gQ+VIVVrKVFlV
   c6FzIUMCngEo2fO1dLClRmyBH4FQhInwa2r09N/Fj7HMGD/ETwEOMd+lQ
   g==;
X-CSE-ConnectionGUID: RbWSbkRVSlmst2aekum0Fg==
X-CSE-MsgGUID: P7qYGgu0Tiae1qsnFtEV4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71295023"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71295023"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:11:45 -0800
X-CSE-ConnectionGUID: 9a/X+wqmT4qnrXJWp9nQQw==
X-CSE-MsgGUID: eC0DfsclQoSeX1yf2lLWjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210040776"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:11:42 -0800
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
Subject: [PATCH v4 5/7] serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
Date: Tue,  3 Feb 2026 19:10:47 +0200
Message-Id: <20260203171049.4353-6-ilpo.jarvinen@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-213287-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 3CC8ADC96A
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



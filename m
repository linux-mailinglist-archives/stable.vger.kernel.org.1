Return-Path: <stable+bounces-212876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEnbN2CyfGmbOQIAu9opvQ
	(envelope-from <stable+bounces-212876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:30:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9F1BB067
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 14:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54C5430157FC
	for <lists+stable@lfdr.de>; Fri, 30 Jan 2026 13:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A822E172D;
	Fri, 30 Jan 2026 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OcL0n2Mu"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5132E03F5;
	Fri, 30 Jan 2026 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779772; cv=none; b=VxdgeIFkSD7lxBtIFCT1KDblCyHxMNiUJRosHKjZ2QxRhi5rkMdjRcOahp4waoq1LQIuJD7sF4lROtGR8QZBioz5O/IFmK8NPPYM3xYTT0koG8SbEnNsIdcVfEf/xpISkj6sAzgE4lyFfsOJcP2+VFp+Rjm364YapFJlsI5mk+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779772; c=relaxed/simple;
	bh=SDHf+A0k6bK0v2kpFgTGPbdfB2E7Jjwj09y2K2i+MZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owLhsvrZ96yOpraRMrkKsMWf66VK60R8e1zOYj7IUg/BTlToOtWEnjlWHdt/cVEjXVSqRCuS827Zpe+A+msj7S1ZI/r9aTygHFbZXEtWKWIBQJjtR40bHRukwF/EGmWeHk5WI/018yZgu7rqtynanltHVQpnHZ0dn1/fRErsk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OcL0n2Mu; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769779772; x=1801315772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SDHf+A0k6bK0v2kpFgTGPbdfB2E7Jjwj09y2K2i+MZA=;
  b=OcL0n2MuAg0787YXYFn1f0oT64gb8d82e9g29l5mzdKG3zid6JCkd1ea
   o2BwK47mC/yHOgu0XYvJgbv/Hm2OwbXU1P4EhnTjXaXOKYbyaoUvI6Hlc
   AKLKotsHIOafEiQL0+6tXP9UWkvm1toOC4pR6twSnH95g5/M5MkY9WdN4
   GTqAZu8u6HjKp5xPUls2tsOWf3FIwLljJl3gaqoNvsZ/FWsLLYFZuGxEW
   2Fgi3bv6Rc8eboyRY3uNFmHgzDCY3LoTyCDTn2nuDDiB907fNE/IPz82B
   E2K0Xsjb5Hyc8pK4+Mb99bh/ZdnT7d5N+te7Apc4IcpMkk9NvRFLImi3C
   g==;
X-CSE-ConnectionGUID: McNdTPuZSXGSeem3vAopBA==
X-CSE-MsgGUID: uSVxfOLgSC6hAwQ8MQeHvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11686"; a="74882377"
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="74882377"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 05:29:31 -0800
X-CSE-ConnectionGUID: E1nYXLZ2RwmhlZnzJMWnUQ==
X-CSE-MsgGUID: u3n5sBqJSR238SW7NRpFDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,263,1763452800"; 
   d="scan'208";a="209103796"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 05:29:26 -0800
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
Subject: [PATCH v3 2/7] serial: 8250_dw: Avoid unnecessary LCR writes
Date: Fri, 30 Jan 2026 15:28:52 +0200
Message-Id: <20260130132857.13124-3-ilpo.jarvinen@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-212876-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Queue-Id: 5D9F1BB067
X-Rspamd-Action: no action

When DW UART is configured with BUSY flag, LCR writes may not always
succeed which can make any LCR write complex and very expensive.
Performing write directly can trigger IRQ and the driver has to perform
complex and distruptive sequence while retrying the write.

Therefore, it's better to avoid doing LCR write that would not change
the value of the LCR register. Add LCR write avoidance code into the
8250_dw driver's .serial_out() functions.

Reported-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Bandal, Shankar" <shankar.bandal@intel.com>
Tested-by: "Murthy, Shanth" <shanth.murthy@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/8250/8250_dw.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 27af83f0ff46..7500b1ff1ac1 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -181,6 +181,22 @@ static void dw8250_check_lcr(struct uart_port *p, unsigned int offset, u32 value
 	 */
 }
 
+/*
+ * With BUSY, LCR writes can be very expensive (IRQ + complex retry logic).
+ * If the write does not change the value of the LCR register, skip it entirely.
+ */
+static bool dw8250_can_skip_reg_write(struct uart_port *p, unsigned int offset, u32 value)
+{
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	u32 lcr;
+
+	if (offset != UART_LCR || d->uart_16550_compatible)
+		return false;
+
+	lcr = serial_port_in(p, offset);
+	return lcr == value;
+}
+
 /* Returns once the transmitter is empty or we run out of retries */
 static void dw8250_tx_wait_empty(struct uart_port *p)
 {
@@ -207,12 +223,18 @@ static void dw8250_tx_wait_empty(struct uart_port *p)
 
 static void dw8250_serial_out(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	writeb(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
 
 static void dw8250_serial_out38x(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	/* Allow the TX to drain before we reconfigure */
 	if (offset == UART_LCR)
 		dw8250_tx_wait_empty(p);
@@ -237,6 +259,9 @@ static u32 dw8250_serial_inq(struct uart_port *p, unsigned int offset)
 
 static void dw8250_serial_outq(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	value &= 0xff;
 	__raw_writeq(value, p->membase + (offset << p->regshift));
 	/* Read back to ensure register write ordering. */
@@ -248,6 +273,9 @@ static void dw8250_serial_outq(struct uart_port *p, unsigned int offset, u32 val
 
 static void dw8250_serial_out32(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	writel(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
@@ -261,6 +289,9 @@ static u32 dw8250_serial_in32(struct uart_port *p, unsigned int offset)
 
 static void dw8250_serial_out32be(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	iowrite32be(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
-- 
2.39.5



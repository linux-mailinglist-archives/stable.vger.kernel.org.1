Return-Path: <stable+bounces-213284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK3LBKAsgmlFQAMAu9opvQ
	(envelope-from <stable+bounces-213284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:13:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2108DDC920
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 18:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB27530187A3
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 17:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8908C30CDBB;
	Tue,  3 Feb 2026 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PE2Wyiue"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7680639900D;
	Tue,  3 Feb 2026 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770138680; cv=none; b=jCvC7jpc9wht3TbA/c1tDI+oFBG7MssEI/6g9qoM2zYdMEd2i7z6RgLT0XO4FJegnQFVbwwSV6HSqwvo4h8ijqD+FuTSVIs0Vi7J6aFinss5OQxbMvBaJrst5Z2cU5btEPXq5R8+fGvGL+abe34DkVYczhRVLB+K72u1fGZqWQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770138680; c=relaxed/simple;
	bh=SDHf+A0k6bK0v2kpFgTGPbdfB2E7Jjwj09y2K2i+MZA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qp08GQlnTH0bT0QFfXCXrHKLFzZ+/n+bJEUCVNKXYi7Kxp6uKvFEgo6bwXYlfUHRz+nDHavfDYeWyWT0rTqTxavyjvkwNNvIqiB4dNIRh5YJF34JXIT95fXpKzxip8x5qgkwU4/WvsFM+wnKUUg7szqYEblnGms6wJsluYLvcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PE2Wyiue; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770138678; x=1801674678;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SDHf+A0k6bK0v2kpFgTGPbdfB2E7Jjwj09y2K2i+MZA=;
  b=PE2WyiuecyRvcGQyldE4TVckgP6HpVrh2emRYgG9cRuglBsFkiK0gArf
   +b2YlIrdyGvOKqyaqqD+rGpIF/ASeE6i8/VOnmPKiZfQ0vU6nD4w58vPe
   uYfOjfmOUEfF4bDCFS7DJhqibt9WUlOcJNQhp4jrtC3z5e4eQx+fpXqKj
   H2Jesw5ozXfaE8/ntrRBJKpsv57Yx9h0fcyqFadmru1KwMeDZjMtiqXAO
   aYnRx6/Trm9URIo9Szbc7AbxEWo6EqvquaMpGq+sbWa8A/iBQurdzQFfc
   cjaGnmiL2K7Sk0AUoBGASoleTd+mYrPze8hJVLZ/eIQ4E5oAwMFAE+D0h
   A==;
X-CSE-ConnectionGUID: ikTGuzCeQFqKp6fCiGKrTw==
X-CSE-MsgGUID: i0/xy754QZGwszJ9jNwORg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71220790"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="71220790"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:11:18 -0800
X-CSE-ConnectionGUID: pyd54vgKTV2uH6if2xD7LQ==
X-CSE-MsgGUID: 46RXGBMdRNSQ71UnabMTLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="240589495"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:11:14 -0800
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
Subject: [PATCH v4 2/7] serial: 8250_dw: Avoid unnecessary LCR writes
Date: Tue,  3 Feb 2026 19:10:44 +0200
Message-Id: <20260203171049.4353-3-ilpo.jarvinen@linux.intel.com>
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
	TAGGED_FROM(0.00)[bounces-213284-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: 2108DDC920
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



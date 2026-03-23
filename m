Return-Path: <stable+bounces-228280-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELbZBc9LwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228280-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:18:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BA82F4284
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34F9E30ACE5F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BA0286417;
	Mon, 23 Mar 2026 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bvCt/Z5w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31C33AD523;
	Mon, 23 Mar 2026 14:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274673; cv=none; b=NVMBnOeXX+M5dXs7dW8MqGisGzt76wBX7KeOFL+CbHIR4VvCyKT+lKUg4o6flPR3vAZ5ZlldJisDNP1eDcSlKXL8hhDhkzpNf9Y56QzduZQSwcRQ9kiNJbpgvQK4fw9OXGK950C2OUjZjC8lFbJDhd9+7cTiyFK1P5QYOsA/RA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274673; c=relaxed/simple;
	bh=YyZQrcVKc1JRCCSvnCvpTM9vMSREpgR8QS2BEyvpXIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNCrlefE3ENDmB1ZHPXbsbhKRYIaUqeBjqQsn7f3SQAiwEIN85YOoWvzqwf9+yonH0YcqwFuqwNX9KMZzD+4+EGLO6gHa9ObXbLa4UqOVtSm4oNNzuyNJztW4o8Uefy/o0/+wmj1AROBxrZMX5HPrxgQ4rcv64k9B+KcsiMCdq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bvCt/Z5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E18C4CEF7;
	Mon, 23 Mar 2026 14:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274673;
	bh=YyZQrcVKc1JRCCSvnCvpTM9vMSREpgR8QS2BEyvpXIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bvCt/Z5w7NI+RyoVRbZUzqhe1txw7MS9pcsfP+nrWDXA2U50Y1OsQwzUmsmWQt5rV
	 Gew0KLy26YuJzKl3/z3H9qUBSOlq9px5Om+JgmfyrCEfSK8wiNoxsNkmKghEu26pq3
	 Km9ONX2/RQotMjXeaciRt03c1Np0tRD0a3844B8Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Bandal, Shankar" <shankar.bandal@intel.com>,
	"Murthy, Shanth" <shanth.murthy@intel.com>,
	stable <stable@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.18 071/212] serial: 8250_dw: Avoid unnecessary LCR writes
Date: Mon, 23 Mar 2026 14:44:52 +0100
Message-ID: <20260323134506.012136665@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_FROM(0.00)[bounces-228280-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E6BA82F4284
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit 8002d6d6d0d8a36a7d6ca523b17a51cb0fa7c3c3 upstream.

When DW UART is configured with BUSY flag, LCR writes may not always
succeed which can make any LCR write complex and very expensive.
Performing write directly can trigger IRQ and the driver has to perform
complex and distruptive sequence while retrying the write.

Therefore, it's better to avoid doing LCR write that would not change
the value of the LCR register. Add LCR write avoidance code into the
8250_dw driver's .serial_out() functions.

Reported-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Murthy, Shanth <shanth.murthy@intel.com>
Cc: stable <stable@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260203171049.4353-3-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/8250/8250_dw.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -181,6 +181,22 @@ static void dw8250_check_lcr(struct uart
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
@@ -207,12 +223,18 @@ static void dw8250_tx_wait_empty(struct
 
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
@@ -237,6 +259,9 @@ static u32 dw8250_serial_inq(struct uart
 
 static void dw8250_serial_outq(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	value &= 0xff;
 	__raw_writeq(value, p->membase + (offset << p->regshift));
 	/* Read back to ensure register write ordering. */
@@ -248,6 +273,9 @@ static void dw8250_serial_outq(struct ua
 
 static void dw8250_serial_out32(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	writel(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
@@ -261,6 +289,9 @@ static u32 dw8250_serial_in32(struct uar
 
 static void dw8250_serial_out32be(struct uart_port *p, unsigned int offset, u32 value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	iowrite32be(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }




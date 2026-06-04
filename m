Return-Path: <stable+bounces-260395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hZwGEyNXIWr5EAEAu9opvQ
	(envelope-from <stable+bounces-260395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:44:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD57063F264
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:44:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Z9ioRrLw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260395-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260395-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B32CD3022978
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A8A403EB6;
	Thu,  4 Jun 2026 10:44:21 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4A404895
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:44:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780569861; cv=none; b=E0VHutHrdAQNVMyMLdR4CziXQVHDufKu00+YLg7ZjgA4Zr/Pn7cz7Y0ibTF0CojTYC5H16vZpa8yYRqPiStsnkmieUR+zABQey+tFuC9fGIp8Zzkg9QJeSkrybKMhFtEXiJ+98PaQ1JSkmi970RMLIuguFxMyfWdW1jkuUVFI1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780569861; c=relaxed/simple;
	bh=OpN5ZCTta+2CFDTOPTnMiuIvtpw6F+hyxNYkfa8jiKI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VQI86lRpdOBBN5TP1DOsIBjUYjb9bprl6Rj2kPVipc70/Cik//wArU/UnVfsUkLz7Hw8nXyZcTp6tMgZqlQNfP/IdyNvBbObQJDpXaObd0Ty2oegZ4URaUsIxZlVIFrq3JtnwzyCUot3tymYPeBxv62v5GlRQ6DxrpFS2mby2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z9ioRrLw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278D71F00893;
	Thu,  4 Jun 2026 10:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780569859;
	bh=mEonAA0GE+4xsmjyLmatBr08jWAYGRkB+jpFF8lj5KY=;
	h=Subject:To:Cc:From:Date;
	b=Z9ioRrLwTk1tLxV4m2OQBt6oeJkN2UIAzDSSKxMhhwtO4fwh1NZ2EfgzIu/n2mWwr
	 DhuULNDrblBfOkATtO7hMpwyRiA0CebKqGWudxztwJ1b/QsKerBsXWjca+85H1NaYf
	 Xos705ihwXw4AMyBITTB3nWONtDA7ZR9yHoYkQqM=
Subject: FAILED: patch "[PATCH] tty: serial: samsung: Remove redundant port lock acquisition" failed to apply to 6.1-stable tree
To: tudor.ambarus@linaro.org,gregkh@linuxfoundation.org,john.ogness@linutronix.de,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:41:28 +0200
Message-ID: <2026060428-showdown-storeroom-5e99@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260395-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:tudor.ambarus@linaro.org,m:gregkh@linuxfoundation.org,m:john.ogness@linutronix.de,m:stable@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD57063F264


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a3bb136bff5e6a5e48cdd813246c9c4686feaaa9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060428-showdown-storeroom-5e99@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a3bb136bff5e6a5e48cdd813246c9c4686feaaa9 Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 15 May 2026 12:41:21 +0000
Subject: [PATCH] tty: serial: samsung: Remove redundant port lock acquisition
 in rx helpers

Sashiko identified a deadlock when the console flow is engaged [1].

When console flow control is enabled (UPF_CONS_FLOW),
s3c24xx_serial_stop_tx() calls s3c24xx_serial_rx_enable() and
s3c24xx_serial_start_tx() calls s3c24xx_serial_rx_disable().

The serial core framework invokes the .stop_tx() and .start_tx()
callbacks with the port->lock spinlock already held. Furthermore, all
internal driver paths that invoke stop_tx (such as the DMA TX
completion handler s3c24xx_serial_tx_dma_complete() or the PIO TX IRQ
handler s3c24xx_serial_tx_irq()) also acquire port->lock prior to
calling it. (Note that s3c24xx_serial_start_tx() is only invoked by the
serial core).

However, s3c24xx_serial_rx_enable() and s3c24xx_serial_rx_disable()
unconditionally attempt to acquire port->lock again using
uart_port_lock_irqsave(). Since spinlocks are not recursive, this
causes a deadlock on the same CPU when console flow control is engaged.

Remove the redundant lock acquisition from both rx helper functions.

Cc: stable <stable@kernel.org>
Fixes: b497549a035c ("[ARM] S3C24XX: Split serial driver into core and per-cpu drivers")
Reported-by: John Ogness <john.ogness@linutronix.de>
Closes: https://sashiko.dev/#/patchset/20260506121606.5805-1-john.ogness%40linutronix.de [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://patch.msgid.link/20260515-samsung-tty-flow-control-deadlock-v1-1-93255edbc9bc@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index e27806bf2cf3..17cd5bb100b1 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -245,12 +245,9 @@ static bool s3c24xx_serial_txempty_nofifo(const struct uart_port *port)
 static void s3c24xx_serial_rx_enable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long flags;
 	int count = 10000;
 	u32 ucon, ufcon;
 
-	uart_port_lock_irqsave(port, &flags);
-
 	while (--count && !s3c24xx_serial_txempty_nofifo(port))
 		udelay(100);
 
@@ -263,23 +260,18 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 1;
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_rx_disable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long flags;
 	u32 ucon;
 
-	uart_port_lock_irqsave(port, &flags);
-
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~S3C2410_UCON_RXIRQMODE;
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 0;
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_stop_tx(struct uart_port *port)



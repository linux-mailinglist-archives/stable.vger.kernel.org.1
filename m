Return-Path: <stable+bounces-260807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nEVqALclI2q9jQEAu9opvQ
	(envelope-from <stable+bounces-260807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:38:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D1664AFD8
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:38:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MnmwpaXn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260807-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260807-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 379D7301FD59
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1664404BCE;
	Fri,  5 Jun 2026 19:38:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB68D357739
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:38:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688308; cv=none; b=Hi1eIWs7ZtjKZetXMJrYkz3fyiFAzAYg7nzwK74OsVqSqXF5Qlxo3rLheYdPcIv9bc2/Xctidwx5/1jUgT4vd/dphIWJlvzSYiB35PnwAG7XlzHSxcDOFqaJpXKPsxt7M2LOkR3THKxxTOmaAPVga+MfUX3aUwndrSzpJYO6UbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688308; c=relaxed/simple;
	bh=+GuaE5CWl/At4cVwobgWmEJXDOtiRTTGI83H93gi43g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzbDlOE5cqiQiLG1jxoKWPBdcyWMLjpGpeUzrQ6l7chwIbyOMeBAg1HEeFXLYUPYn9+X8w0YVyMb2ZtrP7bdY7fC41PiO6U2DaPmqjaJtU/BmnBEFeOibj0tCp+XhBSJyH6z27Q5FdsIpFOcIG7x2uWM2JEuaUb5XfqDHRYsX9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnmwpaXn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025E31F0089A;
	Fri,  5 Jun 2026 19:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688307;
	bh=gAGQumzm3W1a+pXTIsDcs0W5mx9lbyJqR+3f/MwYKGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MnmwpaXnRCZ7CL6KlSJTqd/5D/rqxn11tuslb+t4mRfQNPPUE4jY5/pEXAmlxxIIR
	 wmM2KTnMASPm+wY/gG3UNVg+kEgIf7xu5XwJeeurtSt1H2hJi3Zo45E992BBb8s8Kt
	 3CLxjYY6yGE+A8sQaexriu4UGrjy/Dy+RA/vEwlQ9iyHSpy8l1BWh4CbQBtQyyFrxB
	 zX4469VOWb/q0dv8h/2I1Z9yKI7M8kxsz7LXOaFz64HQbgi78gz3ZxKuePah8XRGyM
	 hUmYSRZ6+1wRSdrT8vJbGBKfEEM9oP5KWKL+AjKJM2uYjLWRLF0KKzjy3hs2FRmjkm
	 y0BRCvkoxv0sQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	stable <stable@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] tty: serial: samsung: Remove redundant port lock acquisition in rx helpers
Date: Fri,  5 Jun 2026 15:38:23 -0400
Message-ID: <20260605193823.2169333-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605193823.2169333-1-sashal@kernel.org>
References: <2026060429-earflap-scope-57c7@gregkh>
 <20260605193823.2169333-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260807-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:tudor.ambarus@linaro.org,m:stable@kernel.org,m:john.ogness@linutronix.de,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,vger.kernel.org:from_smtp,sashiko.dev:url,linuxfoundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65D1664AFD8

From: Tudor Ambarus <tudor.ambarus@linaro.org>

[ Upstream commit a3bb136bff5e6a5e48cdd813246c9c4686feaaa9 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/samsung_tty.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index 1639a6a67e70b4..661e9af32c3290 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -241,12 +241,9 @@ static int s3c24xx_serial_has_interrupt_mask(struct uart_port *port)
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
 
@@ -259,23 +256,18 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
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
-- 
2.53.0



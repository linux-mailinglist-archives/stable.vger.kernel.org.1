Return-Path: <stable+bounces-265926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xawVF9OSMWp+nAUAu9opvQ
	(envelope-from <stable+bounces-265926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:15:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD49693F7B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:15:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=oJtmPBou;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265926-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-265926-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44E2F3090F9B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B76A47A0A9;
	Tue, 16 Jun 2026 18:15:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D4D47AF43;
	Tue, 16 Jun 2026 18:15:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781633726; cv=none; b=RN2zHkZ23iurdedH9hvpdJAzrIXkcnd73S/J5ObC6tjGExdBVZs671eRjbIUh9zsGbRVpPDmfLg6L3subaPMzFOIC6uyclWM9gwTbn524JtAMBSSjxAzOs4qW1DkNG3eyKIoIAGyc8UC2L6ZY6+y4TiIMWVkgrwLqgCk27NNwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781633726; c=relaxed/simple;
	bh=80C885eq/KyvDf9ofhFly7f0dnidf8xt6slzNnsoNZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eplydyWM+rDHYqI1a57r7RbJ4KVR52LViF40hAoLZiVqQIAYn7SENx+Z49rlwMbwirt+vUTNxE3ZTLBsGYKHqfE+AdBwodOBzboWMgF2ORKEjkpdclV3gkTzzS7WQFWJjHk6YHihG9UQ94NnMndZPvessJxxJHcFO0mgaZRDzRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oJtmPBou; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AC61F000E9;
	Tue, 16 Jun 2026 18:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781633724;
	bh=2GBqNKGEooGNRySeT9etNErUf5foKal3/XmoFzO/C00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oJtmPBouAxk/PjRreMbQfCFm87B2v1Y6rDrmNUMUlq4H+/H8RqyL/jSCyNFIZ+1RV
	 CuLlCZrou8oHtJVTCQ9xh1/ZOk5tMufn0gjxSQUKAD9kngrHhUPd26JnbhYgTHfkeQ
	 HgPYZyr4degN4D3JYVeTCZdlua2Q87NQWQ8Ggiog=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 5.15 134/411] serial: zs: Switch to using channel reset
Date: Tue, 16 Jun 2026 20:26:12 +0530
Message-ID: <20260616145107.471950122@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145100.376842714@linuxfoundation.org>
References: <20260616145100.376842714@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265926-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:macro@orcam.me.uk,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[orcam.me.uk:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CD49693F7B

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@orcam.me.uk>

commit 8572955630f30948837088aa98bcbe0532d1ceac upstream.

Switch the driver to using the channel reset rather than hardware reset,
simplifying handling by removing an interference between channels that
causes the other channel to become uninitialised afterwards.

There is little difference between the two kinds of reset in terms of
register settings that result, and we initialise the whole register set
right away anyway.  However this prevents a hang from happening should
the console output handler in the firmware try to access the other port
whose transmitter has been disabled and line parameters messed up.

For example this will happen if the keyboard port (port A) is chosen for
the system console, unusually but not insanely for a headless system, as
the port is wired to a standard DA-15 connector and an adapter can be
easily made.  Or with the next change in place this would happen for the
regular console port (port B), since the keyboard port (port A) will be
initialised first.

Just remove the unnecessary complication then, a channel reset is good
enough.  We still need the initialisation marker, now per channel rather
than per SCC, as for the console port zs_reset() will be called twice:
once early on via zs_serial_console_init() for the console setup only,
and then again via zs_config_port() as the port is associated with a TTY
device.

Fixes: 8b4a40809e53 ("zs: move to the serial subsystem")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v2.6.23+
Link: https://patch.msgid.link/alpine.DEB.2.21.2605062323430.46195@angie.orcam.me.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/zs.c |    7 ++++---
 drivers/tty/serial/zs.h |    2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -831,21 +831,22 @@ static void zs_shutdown(struct uart_port
 
 static void zs_reset(struct zs_port *zport)
 {
+	struct zs_port *zport_a = &zport->scc->zport[ZS_CHAN_A];
 	struct zs_scc *scc = zport->scc;
 	int irq;
 	unsigned long flags;
 
 	spin_lock_irqsave(&scc->zlock, flags);
 	irq = !irqs_disabled_flags(flags);
-	if (!scc->initialised) {
+	if (!zport->initialised) {
 		/* Reset the pointer first, just in case...  */
 		read_zsreg(zport, R0);
 		/* And let the current transmission finish.  */
 		zs_line_drain(zport, irq);
-		write_zsreg(zport, R9, FHWRES);
+		write_zsreg(zport, R9, zport == zport_a ? CHRA : CHRB);
 		udelay(10);
 		write_zsreg(zport, R9, 0);
-		scc->initialised = 1;
+		zport->initialised = 1;
 	}
 	load_zsregs(zport, zport->regs, irq);
 	spin_unlock_irqrestore(&scc->zlock, flags);
--- a/drivers/tty/serial/zs.h
+++ b/drivers/tty/serial/zs.h
@@ -22,6 +22,7 @@
 struct zs_port {
 	struct zs_scc	*scc;			/* Containing SCC.  */
 	struct uart_port port;			/* Underlying UART.  */
+	int		initialised;		/* For the console port.  */
 
 	int		clk_mode;		/* May be 1, 16, 32, or 64.  */
 
@@ -41,7 +42,6 @@ struct zs_scc {
 	struct zs_port	zport[2];
 	spinlock_t	zlock;
 	atomic_t	irq_guard;
-	int		initialised;
 };
 
 #endif /* __KERNEL__ */




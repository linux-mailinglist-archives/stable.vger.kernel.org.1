Return-Path: <stable+bounces-261773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5c3LGmZOJWqZGgIAu9opvQ
	(envelope-from <stable+bounces-261773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:56:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 061CD65024D
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:56:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=VO6jKHAz;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261773-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-261773-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BA1B630058DC
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C0E330337;
	Sun,  7 Jun 2026 10:56:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66293242DF;
	Sun,  7 Jun 2026 10:56:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829791; cv=none; b=u/oIPEs9u7pfTQGtZ8K/Z7sD1DJ+1YIcmjikdZO8FWLsvbjC8bw2a6toisp+WlrhAU14A00HcNmgG4J9a68x06/Pd4rL3uIuoThzUc8l7ktNl00NJ0PE5luTCfIRWwR9B2fwKq3h70GnqNTmxyDXk4ZdDFV14wu/957SBip5d6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829791; c=relaxed/simple;
	bh=oOz6zIJVW5vougcmp6SPqYiNTNgJ1fUFVdtm7sPZiGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aont/8UreW9CVzSq5GdyWZ4i8bGgf/kmT3NmFX4y7q3nxaZ62WEaovJfr/AADW8ySQQs0I2DtoQg0NjlkCAWqpYCYNUAihk+7lRdyFWoGnQuQGF0z/LQSlKE+1xYbcS8YMjYVQUrZfRfYanp+2zem4vlYZ0xX98rJ5thnTfPftE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VO6jKHAz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFC01F00893;
	Sun,  7 Jun 2026 10:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829790;
	bh=l/Z9j7wsnOa0HPpzkwIU4z/uPGo/7Ls+LyUV/j3HTIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VO6jKHAzFUEAWwJaDiJjeoOKV2BWhWin4eq+kQDFIkfE7x3iX2boaBfo6xmC9COGy
	 n+l/7RLXrofTdZqrf+6YbjxdBqQ+AwHxnFaImCybsgQzx9uRNbxFLZ30lRAULGM0/f
	 ULxXZVC2Pmbun+DvHXM/Ddt8RwBwT2UDx/B6/KlE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH 7.0 313/332] serial: zs: Switch to using channel reset
Date: Sun,  7 Jun 2026 12:01:22 +0200
Message-ID: <20260607095739.598280615@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095728.031258202@linuxfoundation.org>
References: <20260607095728.031258202@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261773-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:macro@orcam.me.uk,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,orcam.me.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 061CD65024D

7.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -832,21 +832,22 @@ static void zs_shutdown(struct uart_port
 
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




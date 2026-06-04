Return-Path: <stable+bounces-260445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WIdtDM1ZIWoZEwEAu9opvQ
	(envelope-from <stable+bounces-260445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:56:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8104063F3AD
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:56:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=OIdH9Rsy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260445-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260445-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CA0830297BD
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F45403E9B;
	Thu,  4 Jun 2026 10:53:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE2E3FF1DB
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:53:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570409; cv=none; b=l1ELAX6Nn7Xfa3keGcbZa4UNoO/tKtJH/ZggIzDcJclD8lRb8wlaNBGys0AyHmkyJS3zCX9ZQrZJXyQHBkwknhnR71eCOTZnp/1lZxBz9uq6Y1B84pghhBSSXc9PCjp6093bdP+JeLsKStGOAKEKkq8M4u4jNHC4pqoIMH6PBLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570409; c=relaxed/simple;
	bh=m9idKmc58Bm5QVNzuaNcB3VBL+/HXdxHW2KezkWwnTc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=alAmbTrv58nq0HjlkiRYmy89BJLf5l6kqHlwrIRHoNKSEE765vCxTs1HV5UJk1VeEnV/Of+koQ3kQnEWxKB2S36i44j6tzcL7feItG3UeFIa3SrykVYGxKUks612fEHplxQ11BFE3u41IZCoJu9KdgceG+jYBaJGBdvel2fDPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OIdH9Rsy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667301F00893;
	Thu,  4 Jun 2026 10:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570408;
	bh=8rtu2JAt6tzO4vfHF2poSBRnCUVpnZ9l2aDzZe1iDJA=;
	h=Subject:To:Cc:From:Date;
	b=OIdH9RsyBZNE3tKXQIkj88JDK8J1ZhJqiOcR8BW5HIaCJ1jmrGe4nSPN9sB4+Q7bO
	 n0bFu2it4oWOciZ2qFAcmDUT0dBhAtoDYyFuEoUOZECg/UuGSOQELNcWvCekbeiv0b
	 Me+Bo2AxnQxtx1rKhpQE7R77E115HyxW2FyQ6+ow=
Subject: FAILED: patch "[PATCH] serial: altera_jtaguart: handle uart_add_one_port() failures" failed to apply to 5.10-stable tree
To: mhun512@gmail.com,ae878000@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:52:23 +0200
Message-ID: <2026060423-confiding-sandpit-f19a@gregkh>
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
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260445-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,linuxfoundation.org,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:ae878000@gmail.com,m:gregkh@linuxfoundation.org,m:stable@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 8104063F3AD


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x ea66be25f0e934f49d24cd0c5845d13cdba3520b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060423-confiding-sandpit-f19a@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ea66be25f0e934f49d24cd0c5845d13cdba3520b Mon Sep 17 00:00:00 2001
From: Myeonghun Pak <mhun512@gmail.com>
Date: Tue, 12 May 2026 15:56:57 +0900
Subject: [PATCH] serial: altera_jtaguart: handle uart_add_one_port() failures

altera_jtaguart_probe() maps the register window before registering the
UART port, but it ignores failures from uart_add_one_port(). If port
registration fails, probe still returns success and the mapping remains
live until a later remove path that is not part of probe failure cleanup.

Return the uart_add_one_port() error and unmap the register window on
that failure path.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 5bcd601049c6 ("serial: Add driver for the Altera JTAG UART")
Cc: stable <stable@kernel.org>
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Link: https://patch.msgid.link/20260512065837.79528-1-mhun512@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index d47a62d1c9f7..20f079fe11d8 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -379,6 +379,7 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	struct resource *res_mem;
 	int i = pdev->id;
 	int irq;
+	int ret;
 
 	/* -1 emphasizes that the platform must have one port, no .N suffix */
 	if (i == -1)
@@ -418,7 +419,11 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->dev = &pdev->dev;
 
-	uart_add_one_port(&altera_jtaguart_driver, port);
+	ret = uart_add_one_port(&altera_jtaguart_driver, port);
+	if (ret) {
+		iounmap(port->membase);
+		return ret;
+	}
 
 	return 0;
 }



Return-Path: <stable+bounces-261705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id leQSIdpNJWpjGgIAu9opvQ
	(envelope-from <stable+bounces-261705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:54:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DE965019F
	for <lists+stable@lfdr.de>; Sun, 07 Jun 2026 12:54:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=2qZCKGE0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-261705-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-261705-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BDC3303670A
	for <lists+stable@lfdr.de>; Sun,  7 Jun 2026 10:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1D32E7390;
	Sun,  7 Jun 2026 10:52:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6704071DD;
	Sun,  7 Jun 2026 10:52:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780829537; cv=none; b=ofmKVgi4ijhO4NYWJOUSxM1OCex2Xa/9IibmPAgYTiekmn3nj1l+ZZZ5e7KrWXHG0Pf56apePoK+qQ5a5glvq/f5tYKWdBS6h8bX9Ce+u2ZNm9/T9t5i4BaEhTXP2vCk+WyfblmxjS0FjF1GDnpnBIijz7SWpdCGfFH3MOuKRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780829537; c=relaxed/simple;
	bh=cCTTLtE+Ai7YfN3WPyIxSVXsiMWLG4NOdRFbm8CGi4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YFKyCtK92TGdbzhK6BjrKgeamR7O2kjBwmqWa+A+6MlcOIcvHNeaneJm9a0b6w2Qk0LF/pM4lj37pV+XLLHlDkTEDaSvI4IgkHWySbgclwp8aqrIXj4GQDwbeQjcwxHxUzIItyFOhTBrB5lnYSg9Gu2qPjL4XdyWumvPivQbYkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2qZCKGE0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37E51F00898;
	Sun,  7 Jun 2026 10:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780829536;
	bh=xr/P37NH7QGZaA3Z55Gn4nfSc0jB2EC50UMLCE993ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2qZCKGE0laZ0xJcWptxOfUokBqEmxW70/X0qI20yPWvY9wdnzZcurnmea0ESmEGSC
	 5uPPQ00mlyTgKOX5E1fN5HF768M4f1dmQgDWtr2lQyZRlz17aZCqFryBcxnBkMtUOl
	 msKlhVav+Jb9xdZSIocaq35R9G01+3AtrTG3i+34=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.18 238/315] USB: serial: keyspan: fix missing indat transfer sanity check
Date: Sun,  7 Jun 2026 12:00:25 +0200
Message-ID: <20260607095736.311064782@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260607095727.528828913@linuxfoundation.org>
References: <20260607095727.528828913@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-261705-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:johan@kernel.org,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:from_mime,linuxfoundation.org:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E5DE965019F

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit ab8336a7e414f018430aa1af3a46944032f7ff96 upstream.

Add the missing sanity check on the size of usa49wg indat transfers to
avoid parsing stale or uninitialised slab data.

Fixes: 0ca1268e109a ("USB Serial Keyspan: add support for USA-49WG & USA-28XG")
Cc: stable@vger.kernel.org	# 2.6.23
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/keyspan.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -1187,6 +1187,10 @@ static void usa49wg_indat_callback(struc
 	len = 0;
 
 	while (i < urb->actual_length) {
+		if (urb->actual_length - i < 3) {
+			dev_warn_ratelimited(&urb->dev->dev, "malformed indat packet\n");
+			break;
+		}
 
 		/* Check port number from message */
 		if (data[i] >= serial->num_ports) {




Return-Path: <stable+bounces-268424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mwsvLAcoPWpPyAgAu9opvQ
	(envelope-from <stable+bounces-268424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:07:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FEA6C5E89
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:07:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=Fs2Rmyod;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268424-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-268424-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2A30B30422FD
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713202D73AE;
	Thu, 25 Jun 2026 13:06:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9F2BE026;
	Thu, 25 Jun 2026 13:06:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392807; cv=none; b=q14NXkDVYSZr4IGQqMth+14gXccuFe+S5J9fIrl8dbyjn0HSFIvh9OIuzTy0NgIZWMjLCwGfRK1ip7Hwlqj9U5eqdJVf8Q0s8s8H/gGTz6OfyTr+DFO1kRdh1ar9k9ZKuncrledWUZK37Q71f7qqEB230ekY7rNDX5cwD1SE9p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392807; c=relaxed/simple;
	bh=atMv3rrfWEw9wssIcSaYKXLlr3+V48pVzFA2YhUw0q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TugQww4HkDfotRS51XQNhLQWjNJQqgwi0hCoceBx+rYsDlEVnhvgKj8J/KEpL05h3qkg+GkY6CwVFJjZGomekO94eTL+Bw+MpqHyo+mnud6nTEaboLdWb74MeTokghGW3CFx7fUBGcLWqYSnMX/JtBbsuoqqM+yxJIIjEzqzYBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fs2Rmyod; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F081F000E9;
	Thu, 25 Jun 2026 13:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392806;
	bh=juO0ywVZJHlQMjqwqI9fx3KoZmTgAwLSNybaGlUqTGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fs2RmyodjZOvfcspQzvy6K1tl2+s9jQrrMecCVElCq1TRfcd69ZjFgRPo/WsyxhpG
	 7jrX4dS7m655DBIv3go/LHQIrJcLkOMVHK2SZLBqcf0tJYRZvIWfPAwxwTrL1m3sIS
	 vXl9w8ptm2MMWYfwA3szMOTnVCwuLa+nuQPJo44o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: [PATCH 6.18 21/60] rose: set SOCK_DESTROY in rose_kill_by_device() for prompt cleanup
Date: Thu, 25 Jun 2026 14:03:06 +0100
Message-ID: <20260625125648.647768526@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>
References: <20260625125645.554579168@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268424-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:bernard.f6bvp@gmail.com,m:bernardf6bvp@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58FEA6C5E89

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bernard Pidoux <bernard.f6bvp@gmail.com>

commit 741a4863ad570889c75f7a8e404567d8f3e46335 upstream.

When rose_kill_by_device() is called (via NETDEV_DOWN on module exit
or interface removal), it calls rose_disconnect() which transitions
sockets to ROSE_STATE_0 and sets SOCK_DEAD.  However,
rose_heartbeat_expiry() only calls rose_destroy_socket() at
ROSE_STATE_0 if SOCK_DESTROY is set -- the SOCK_DEAD path is reserved
for TCP_LISTEN sockets.  Without SOCK_DESTROY, orphaned sockets in
ROSE_STATE_2 (clearing) loop indefinitely in the heartbeat without
ever being freed, keeping the module use-count elevated and blocking
modprobe -r rose until the T1 timer (up to 200 s) expires.

Set SOCK_DESTROY immediately after rose_disconnect() so the heartbeat
destroys the socket at its next tick (within 5 s), allowing clean
module unload.

Signed-off-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rose/af_rose.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -211,6 +211,11 @@ start:
 		spin_lock_bh(&rose_list_lock);
 		if (rose->device == dev) {
 			rose_disconnect(sk, ENETUNREACH, ROSE_OUT_OF_ORDER, 0);
+			/* Mark for destruction so rose_heartbeat_expiry()
+			 * cleans up the socket at its next tick rather than
+			 * looping forever in ROSE_STATE_0 with no owner.
+			 */
+			sock_set_flag(sk, SOCK_DESTROY);
 			if (rose->neighbour)
 				rose_neigh_put(rose->neighbour);
 			netdev_put(rose->device, &rose->dev_tracker);




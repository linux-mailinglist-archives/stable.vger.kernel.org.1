Return-Path: <stable+bounces-268414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l20vFGsoPWqHyAgAu9opvQ
	(envelope-from <stable+bounces-268414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:08:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B906C5F19
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:08:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pGkZEOWf;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268414-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268414-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 399913055C65
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93942BE026;
	Thu, 25 Jun 2026 13:06:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233528751B;
	Thu, 25 Jun 2026 13:06:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392774; cv=none; b=ZKm8SJ1wiSK5eJJDy/xtp9SZUmY0gUsHp+k6kn0eB+U5G8c7/mw6Fy++GbxZ6kEyFlk797HkRIqPX0D0UC/TyzQ/a385F8SmQQnVcErQmhoebmo9OBz0Jp47UHrp5wU6oYKraRKNyEaGgK7hkX2Fa7zvZ3pvi+z2HQJ2ZJeKnfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392774; c=relaxed/simple;
	bh=dv093LzPFyea7NcOgtfJycCKzCjQheFZAw+l9INRx8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzv50Tjx0Rkv6Pao16+W6FQwaKZwnkEwS6y7gYyrMGKw+QxS0OXq02+Tk3/NItA7lEtSM4zRFgItBJNWYrQCzNudNwnElS/EF38RhkZzlznA9ZJwe4zy3FzNz74mmN+hbHRQ7MG+fC9+UmG4cByu/vyCF1NLpq4+Di9Zs7m5mgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pGkZEOWf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E411F000E9;
	Thu, 25 Jun 2026 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392773;
	bh=URR9NyxMbe3CqJMsrj9kuZRrD+Kom+xlGQgS+lpYtjg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pGkZEOWfiO4bfqSIJVXk03vtak4RfyjpQaoJlFJfF/Cf2ACfBUV9oiPYxn/HHcP5X
	 BYl2mjJX/HBWN3y34Nm2wufQeCfLT8dIcrIwcyUF1Ma3MNvkIIIOk11v3KIpKLSdh9
	 NnFdEJtEYOr8XkpqPhSqmV8Yz3InqxJ1w4098bhA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: [PATCH 6.18 19/60] rose: fix netdev double-hold in rose_rx_call_request()
Date: Thu, 25 Jun 2026 14:03:04 +0100
Message-ID: <20260625125648.362185651@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268414-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92B906C5F19

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bernard Pidoux <bernard.f6bvp@gmail.com>

commit c675277c3ba0d2310e0825577d58308c39931e14 upstream.

rose_rx_call_request() used netdev_tracker_alloc() after assigning
make_rose->device, intending to take ownership of the reference passed
by the caller.  But every caller -- rose_route_frame() and
rose_loopback_timer() -- already calls dev_put() for its own hold after
the function returns, so the socket ended up with a tracker entry
pointing at a reference that had already been released.

The result was spurious refcount_t warnings ("saturated", "decrement
hit 0") on every incoming CALL_REQUEST, leading to refcount corruption
and eventual silent freeze.

Replace netdev_tracker_alloc() with netdev_hold() so that
rose_rx_call_request() acquires its own independent reference.  Each
caller retains its own hold from rose_dev_get() and releases it via
dev_put() as before; socket cleanup releases the socket's separate hold
via netdev_put().

Signed-off-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/rose/af_rose.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -1078,9 +1078,11 @@ int rose_rx_call_request(struct sk_buff
 		make_rose->source_digis[n] = facilities.source_digis[n];
 	make_rose->neighbour     = neigh;
 	make_rose->device        = dev;
-	/* Caller got a reference for us. */
-	netdev_tracker_alloc(make_rose->device, &make_rose->dev_tracker,
-			     GFP_ATOMIC);
+	/* Take an independent reference for this socket; callers keep their
+	 * own reference (from rose_dev_get / dev_hold) and will release it
+	 * themselves via dev_put().
+	 */
+	netdev_hold(make_rose->device, &make_rose->dev_tracker, GFP_ATOMIC);
 	make_rose->facilities    = facilities;
 
 	rose_neigh_hold(make_rose->neighbour);




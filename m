Return-Path: <stable+bounces-233951-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aN8iMQGQ1mmiGQgAu9opvQ
	(envelope-from <stable+bounces-233951-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:27:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B1B3BF86B
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 19:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A10E63074A33
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 17:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60E53D6CA7;
	Wed,  8 Apr 2026 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pnRliNSf";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RwALqI/1"
X-Original-To: stable@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151233537FC;
	Wed,  8 Apr 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669095; cv=none; b=duDK6a7btAaytZ7s7I+BLF1P3W7z/58n+VqciANhHIDZJRUJbIwZFD8dPp+dzpJjaBWDXCZTcDew+ar6q4mJgcMEdPgFFMOwEljVyrrtsias4RBZqCgSYf+Qf3vVhIWR+XvirSxxoNep4xVVo1gaqz7q7z1TojCSjsGq6hDcXWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669095; c=relaxed/simple;
	bh=bz6DeQbiP7xoXyOE9h5UCwgEAp8Gh8vLP0VgCf2MbRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nu/uOMlDQPr9Xo3mwwNCrVGbEWwm6+zWa/zUlYo43uCLfGAKNEy2UVd4u9olbdYZ6Pnbn/mV4NYFiA9KQagPdeHwzJ+fyBLTh8J/KPaQDLoXYsx12Lo647sDKceWV9EWVr97i14W9hd5vssu5xM6KXLfzQPiw5iUgt53yEnf6oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pnRliNSf; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RwALqI/1; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4frVLX26PdzB151;
	Wed,  8 Apr 2026 19:24:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775669092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7CucOw+3o0ShETswcg1eFTVDQgnIGwB/8Mftn1DdDHE=;
	b=pnRliNSfEyOp/DOwaTPiiOGmDQwuRS4xDACZ/kIIr6CbaDCjPJARHztl9xCsPmznRXcism
	8cbZimUtQUlPUxVBYFUtCH6fTGKJEvEo18hQUbtrL01O9G5wt4q7PWR3+J4JW8XAATWpEC
	yvfmocU3YB8MY75uBolnFEElirDrw/yENjeBEeC8lK2OW1OtS4c4+LtzgICnTHzkzaz1pH
	XiKq0qGrx4q2hvGlUByIOa0qXii0K0csuLlTyskO7WcgxCeHnvQM14QuUxz1PexN2uLz9b
	a8irHW3D6Y0B94w3mPSdmjf3jdwDzVbIjIzKAb8MGj2VB9ZLw0G//NZHW1Qrew==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="RwALqI/1";
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775669090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7CucOw+3o0ShETswcg1eFTVDQgnIGwB/8Mftn1DdDHE=;
	b=RwALqI/14CCu85sz1xVtVyM3VM5w8lP6eqiht6G5cuJO0r4XKo4BaVq/kVM1bF9XykQENR
	1i9ZQADdq3WopDOAqO59ORNWI1NxpzxSjbGjyckEsuFVQ5hvOCVXcuuF2kzXTERlk7xfT1
	R9EZPnYhDVHjhyidLUIxqtoPVqa8yQBxDDZQsh4GDXT5gg9xkcdJZW+RwYsbgGzukUjgZV
	0rJL1CM1dMWQq44O9mSHm6eH5N7NZv6+9W7CJ3DPd/kNo46zjmqgtwS5CWbwiIrvZ+xqN1
	EjWwfSm5qVBkF6XgDj2nadYKQcyvM3/2cVDgnXN6JH4rUNOuiZuySsApWe/bZQ==
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jreuter@yaina.de,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: hamradio: scc: validate bufsize in SIOCSCCSMEM ioctl
Date: Thu,  9 Apr 2026 01:23:58 +0800
Message-ID: <20260408172358.281186-3-mashiro.chen@mailbox.org>
In-Reply-To: <20260408172358.281186-1-mashiro.chen@mailbox.org>
References: <20260408172358.281186-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 16c0321e162ddce80c2
X-MBO-RS-META: ks1jgtkanugppeu46kqs3zddtnpm51yh
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233951-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23B1B3BF86B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SIOCSCCSMEM ioctl copies a scc_mem_config from user space and
assigns its bufsize field directly to scc->stat.bufsize without any
range validation:

  scc->stat.bufsize = memcfg.bufsize;

If a privileged user (CAP_SYS_RAWIO) sets bufsize to 0, the receive
interrupt handler later calls dev_alloc_skb(0) and immediately writes
a KISS type byte via skb_put_u8() into a zero-capacity socket buffer,
corrupting the adjacent skb_shared_info region.

The scc.c comment already states the buffer must not exceed 4096 bytes,
but this limit is never enforced.  Add a bounds check that rejects values
outside the range [16, 4096], consistent with the documented constraint
and large enough to hold at least one KISS header byte plus useful data.

Cc: stable@vger.kernel.org
Cc: linux-hams@vger.kernel.org
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/scc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/hamradio/scc.c b/drivers/net/hamradio/scc.c
index ae5048efde686a..fd3ff3f4311df2 100644
--- a/drivers/net/hamradio/scc.c
+++ b/drivers/net/hamradio/scc.c
@@ -1909,6 +1909,8 @@ static int scc_net_siocdevprivate(struct net_device *dev,
 			if (!capable(CAP_SYS_RAWIO)) return -EPERM;
 			if (!arg || copy_from_user(&memcfg, arg, sizeof(memcfg)))
 				return -EINVAL;
+			if (memcfg.bufsize < 16 || memcfg.bufsize > 4096)
+				return -EINVAL;
 			scc->stat.bufsize   = memcfg.bufsize;
 			return 0;
 		
-- 
2.53.0



Return-Path: <stable+bounces-267414-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5YFiKrlZNWrStgYAu9opvQ
	(envelope-from <stable+bounces-267414-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 17:01:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E246A68CD
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 17:01:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0leil.net header.s=20231125 header.b=h+5Dw14Q;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267414-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267414-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=0leil.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BAA43038F7F
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8313B6C09;
	Fri, 19 Jun 2026 14:59:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04E3B5851
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 14:59:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881168; cv=none; b=i7Jzf0wVN02R7AI6Qduz+Hjp2cd+xri62pzVtSS0mxM2pJVAr2uwIYiQMix1BBBwOZwfcUIMOjJPZXbV2rOkmIESp54rO81AOSjivgfyhYxWgI3NLwhiJZvfpzcGMjX8JOUAMOrEaaJYtvlrbAfLpI7z2Gk92/qfo4W03oKSOE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881168; c=relaxed/simple;
	bh=yglbh/ko3WoD4Ha3M/0f4dEcA2Cyt3V1t9gYbNOd06w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Og8lBXPVYKKL/wSjpcHpGf/Tkn6vSN869te1CcCHY1mouf2pzwMqxyU9lHPtxoFcBv04RBZ/U2/XuLOtbNlIhk7E4Y7gyrWh9bpSdfa6ho1u6c/uYbb+tzb9G3fxXBrt9RHzO0P9n7HsZGS5SCqI2784aCqUxoJVihapTrjh5to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=h+5Dw14Q; arc=none smtp.client-ip=45.157.188.9
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ghgjL4R27zL6b;
	Fri, 19 Jun 2026 16:59:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781881158;
	bh=wwLjRlMMmwUKNGLVfdcwXRcz/C9FEnOvnLZ2rnPQ8+A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=h+5Dw14QYX1DikArA6O/elyhCxSSXmykCXnhYeNg7spugL9/XnMLtRWhdtD15EJpC
	 dvqv2OkBVUUtWNynBS1BjyFs7z1rWwh/ZigS0/CURwZKlLhCeNXICq57dWpXbgg/Uv
	 KdNSKBq6CPi1kbg7YYXIWGcg3ZxatKjgYs3SNzBZKyQncJcH9Xr6gQBW5nVZsiQFk5
	 x0LBrdV1JbxcUJUXk4R7fi4eMBYhuB4RrtTCzQ9uEzjQ9/GqjEfyCAN8UnMWdyZ5K+
	 cm1/l7DkPz8HIAvskWqqGn/mXeOaWHpWlTka26fEmZzutQXvs4dTUDevgh9QnHGtrU
	 xmdB1IRVwGXWQ==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ghgjK4R3DzqQm;
	Fri, 19 Jun 2026 16:59:17 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 19 Jun 2026 16:58:47 +0200
Subject: [PATCH 6.12.y 7/7] eventpoll: fix ep_remove struct eventpoll /
 struct file UAF
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-6-12-cve-2026-46242-v1-7-e15a6de43c11@cherry.de>
References: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
In-Reply-To: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Soheil Hassas Yeganeh <soheil@google.com>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>, 
 Jaeyoung Chung <jjy600901@snu.ac.kr>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[0leil.net,reject];
	R_DKIM_ALLOW(-0.20)[0leil.net:s=20231125];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:dave@stgolabs.net,m:akpm@linux-foundation.org,m:soheil@google.com,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:quentin.schulz@cherry.de,m:jjy600901@snu.ac.kr,s:lists@lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[snu.ac.kr:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[foss@0leil.net,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-267414-lists,stable=lfdr.de,kernel];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[foss@0leil.net,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[0leil.net:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0leil.net:dkim,0leil.net:from_mime,cherry.de:mid,cherry.de:email,msgid.link:url,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86E246A68CD

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit a6dc643c69311677c574a0f17a3f4d66a5f3744b ]

ep_remove() (via ep_remove_file()) cleared file->f_ep under
file->f_lock but then kept using @file inside the critical section
(is_file_epoll(), hlist_del_rcu() through the head, spin_unlock).
A concurrent __fput() taking the eventpoll_release() fastpath in
that window observed the transient NULL, skipped
eventpoll_release_file() and ran to f_op->release / file_free().

For the epoll-watches-epoll case, f_op->release is
ep_eventpoll_release() -> ep_clear_and_put() -> ep_free(), which
kfree()s the watched struct eventpoll. Its embedded ->refs
hlist_head is exactly where epi->fllink.pprev points, so the
subsequent hlist_del_rcu()'s "*pprev = next" scribbles into freed
kmalloc-192 memory.

In addition, struct file is SLAB_TYPESAFE_BY_RCU, so the slot
backing @file could be recycled by alloc_empty_file() --
reinitializing f_lock and f_ep -- while ep_remove() is still
nominally inside that lock. The upshot is an attacker-controllable
kmem_cache_free() against the wrong slab cache.

Pin @file via epi_fget() at the top of ep_remove() and gate the
critical section on the pin succeeding. With the pin held @file
cannot reach refcount zero, which holds __fput() off and
transitively keeps the watched struct eventpoll alive across the
hlist_del_rcu() and the f_lock use, closing both UAFs.

If the pin fails @file has already reached refcount zero and its
__fput() is in flight. Because we bailed before clearing f_ep,
that path takes the eventpoll_release() slow path into
eventpoll_release_file() and blocks on ep->mtx until the waiter
side's ep_clear_and_put() drops it. The bailed epi's share of
ep->refcount stays intact, so the trailing ep_refcount_dec_and_test()
in ep_clear_and_put() cannot free the eventpoll out from under
eventpoll_release_file(); the orphaned epi is then cleaned up
there.

A successful pin also proves we are not racing
eventpoll_release_file() on this epi, so drop the now-redundant
re-check of epi->dying under f_lock. The cheap lockless
READ_ONCE(epi->dying) fast-path bailout stays.

Fixes: 58c9b016e128 ("epoll: use refcount to reduce ep_mutex contention")
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-6-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 fs/eventpoll.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 2993b76c21f68..22605fbc12ded 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -883,22 +883,26 @@ static bool ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
  */
 static void ep_remove(struct eventpoll *ep, struct epitem *epi)
 {
-	struct file *file = epi->ffd.file;
+	struct file *file __free(fput) = NULL;
 
 	lockdep_assert_irqs_enabled();
 	lockdep_assert_held(&ep->mtx);
 
 	ep_unregister_pollwait(ep, epi);
 
-	/* sync with eventpoll_release_file() */
+	/* cheap sync with eventpoll_release_file() */
 	if (unlikely(READ_ONCE(epi->dying)))
 		return;
 
-	spin_lock(&file->f_lock);
-	if (epi->dying) {
-		spin_unlock(&file->f_lock);
+	/*
+	 * If we manage to grab a reference it means we're not in
+	 * eventpoll_release_file() and aren't going to be.
+	 */
+	file = epi_fget(epi);
+	if (!file)
 		return;
-	}
+
+	spin_lock(&file->f_lock);
 	ep_remove_file(ep, epi, file);
 
 	if (ep_remove_epi(ep, epi))

-- 
2.54.0



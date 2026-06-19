Return-Path: <stable+bounces-267413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KiW+NlhaNWogtwYAu9opvQ
	(envelope-from <stable+bounces-267413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 17:03:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA606A6901
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 17:03:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0leil.net header.s=20231125 header.b=b8TcXXOq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267413-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-267413-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=0leil.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D39730702FB
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3563B27C1;
	Fri, 19 Jun 2026 14:59:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324363B42F0
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 14:59:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881165; cv=none; b=g3vyCJ0MnRxxyVkae8H1Vajn7F+t3Xwe+CxaQLjG6fu/cROjXspEMk25CJPntJmWA6KhgUjcQp6Wk1kkXdzNOWxW/s9BrgRlcjl3XD65PyLGhVgQmoREyoIHofs6x/vGTXBK6b2PJ5xXJ44mwZZfnLBqwjmH51zUIjDto37UbfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881165; c=relaxed/simple;
	bh=idKatyHpz1go9bIbf3jZ6tG+Z3hQCRgwhZMsTk3yPZ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WUpwFbxQSi7f6lqZcxkktG6BMiC5MQpqfqWOadxbpp2yVQQ8r3PlFHdnyRYrcgGsiNu/eyl9rNBPH/8QmApIlzYSYkDa5j/z/lbkOomJKSVXT3hdOjz0ZweYJwS83VPgBo4GU+XhQCydqpwoU6TiJfxCWOrqH24ukBka1bCcPQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=b8TcXXOq; arc=none smtp.client-ip=84.16.66.171
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ghgjJ1vR4zLdy;
	Fri, 19 Jun 2026 16:59:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781881155;
	bh=ft+WUEpY5Jl+zP8xTr99HycF/Iu4+O2nsE0oBel9RDA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b8TcXXOqeZHMstT/wTj0mRZQ3OR7u1Ef+UaUUt8Omm7DLXi8vylgWjw95PUIsWFnq
	 a63nSGHl0NqiJT3Q+ILaCbVbXhiFuvx2KCClmy6lSAmZovUk8hUMrISZROVGmxKRTI
	 FZl3LSWLMmtIPZ2P0MWdHeu58gAQIaW+XqCAknl0v/zh/dbrbfKOoF8BZdApyf6vLz
	 a4rA/w7CGzNykDKMFMRT32UrsgWuKwqMpJyF7RCVFry+zdWWE9NUsCSEuqkZZNg1XE
	 e82Y17k7PFdiaLk5/ebO4M4yv/Sc9tskoWv+muXYycEx3H6S18qUhwZd3HIQ2MW5oN
	 Ya64DTNVbViRw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ghgjH2Wltzvm1;
	Fri, 19 Jun 2026 16:59:15 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 19 Jun 2026 16:58:44 +0200
Subject: [PATCH 6.12.y 4/7] eventpoll: drop vestigial __ prefix from
 ep_remove_{file,epi}()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-6-12-cve-2026-46242-v1-4-e15a6de43c11@cherry.de>
References: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
In-Reply-To: <20260619-6-12-cve-2026-46242-v1-0-e15a6de43c11@cherry.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Soheil Hassas Yeganeh <soheil@google.com>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[0leil.net,reject];
	R_DKIM_ALLOW(-0.20)[0leil.net:s=20231125];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267413-lists,stable=lfdr.de,kernel];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:dave@stgolabs.net,m:akpm@linux-foundation.org,m:soheil@google.com,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:quentin.schulz@cherry.de,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[foss@0leil.net,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[0leil.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[foss@0leil.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0leil.net:dkim,0leil.net:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,cherry.de:mid,cherry.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8EA606A6901

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 0feaf644f7180c4a91b6b405a881afbfd958f1cf ]

With __ep_remove() gone, the double-underscore on __ep_remove_file()
and __ep_remove_epi() no longer contrasts with a __-less parent and
just reads as noise. Rename both to ep_remove_file() and
ep_remove_epi(). No functional change.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 fs/eventpoll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 3ac8a26c3522f..dc747f382dd95 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -801,7 +801,7 @@ static void ep_free(struct eventpoll *ep)
  * Called with &file->f_lock held,
  * returns with it released
  */
-static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi,
+static void ep_remove_file(struct eventpoll *ep, struct epitem *epi,
 			     struct file *file)
 {
 	struct epitems_head *to_free = NULL;
@@ -825,7 +825,7 @@ static void __ep_remove_file(struct eventpoll *ep, struct epitem *epi,
 	free_ephead(to_free);
 }
 
-static bool __ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
+static bool ep_remove_epi(struct eventpoll *ep, struct epitem *epi)
 {
 	lockdep_assert_held(&ep->mtx);
 
@@ -871,9 +871,9 @@ static void ep_remove_safe(struct eventpoll *ep, struct epitem *epi)
 		spin_unlock(&file->f_lock);
 		return;
 	}
-	__ep_remove_file(ep, epi, file);
+	ep_remove_file(ep, epi, file);
 
-	if (__ep_remove_epi(ep, epi))
+	if (ep_remove_epi(ep, epi))
 		WARN_ON_ONCE(ep_refcount_dec_and_test(ep));
 }
 
@@ -1118,8 +1118,8 @@ void eventpoll_release_file(struct file *file)
 		ep_unregister_pollwait(ep, epi);
 
 		spin_lock(&file->f_lock);
-		__ep_remove_file(ep, epi, file);
-		dispose = __ep_remove_epi(ep, epi);
+		ep_remove_file(ep, epi, file);
+		dispose = ep_remove_epi(ep, epi);
 
 		mutex_unlock(&ep->mtx);
 

-- 
2.54.0



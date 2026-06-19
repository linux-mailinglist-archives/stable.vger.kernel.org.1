Return-Path: <stable+bounces-267419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BWWCGVFbNWqYtwYAu9opvQ
	(envelope-from <stable+bounces-267419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 17:08:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B24926A698E
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 17:08:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=0leil.net header.s=20231125 header.b="WgHAB/Bz";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267419-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267419-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=0leil.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 446E4306F504
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 15:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E0A285CAE;
	Fri, 19 Jun 2026 15:05:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776DA1548C
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 15:05:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881525; cv=none; b=FgI5HJ92spzrvWyqbMxWhI2fNcs0A+FoczOlsffVTGUMQKP8WbmA2gzkIWnFdE1TM+ClTjBkO70rVQi+KF/ODDcxQoxfc0TLvpod2LX9VsZ+tj92eVZkJUE6X5Ho97Z2ppKpfYSjOjRPHltnMfaJWpOVJ7fYw1qbx8PoX0tfKjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881525; c=relaxed/simple;
	bh=qmeX7o2PSIdFaYetB3jwp9rcy8mSQ4DDIyvk55ce06g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=je60WZsZaxoFumbpBBxFiKGO/+Jo+qOHrI/QD9N8xPqcQPZhZc3Jus4zytxAl5EOcKOAxIW+cS/ZwXh7PVwMsRM37t1SQmq7aZVT71Kr1d+Q0DG3F4vgbURKAT7rL3J7LIcnSgTNuCEH2+spRQ5sNVeufMdICTTnLQpdoePb3og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=0leil.net; spf=pass smtp.mailfrom=0leil.net; dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.b=WgHAB/Bz; arc=none smtp.client-ip=83.166.143.168
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ghgjG01KKzB1W;
	Fri, 19 Jun 2026 16:59:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
	s=20231125; t=1781881153;
	bh=I1fl3xZLGNmoO3Uzab7rNKlp5eIAP62khOZs741ziQw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WgHAB/BzLl+CldA4F6N9/ETzgPc4ZvqMcQTfG1r1eC4QCGd/UwVKl7l8cVee9wo+T
	 riJNCISiqHOxSKbf8Cnsac+rmuDaIYi2t845+vI/jxqvLHJ/FhzDQAjwfjf9uVF6d/
	 FcHDXx8dbHE0U1sCgLNQg47QhFILkJG82+vIImdLE82A+OncrLOxH6OGix9CfuxZCi
	 IYK+5Y3w+/eKQzJZUz8K7N+0q9dM+0ae/HifusOprtzULpZ20gIocu5Cr5ypO/iYx/
	 JQe6yfYWG8sKBVn5Ub6XZxVS4++0FLG7aw7EHbuItwZlAyH6DIGvLOjRVHl46wJiqY
	 zztcR2ZedTh5A==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ghgjD6YwPztCd;
	Fri, 19 Jun 2026 16:59:12 +0200 (CEST)
From: Quentin Schulz <foss+kernel@0leil.net>
Date: Fri, 19 Jun 2026 16:58:41 +0200
Subject: [PATCH 6.12.y 1/7] eventpoll: use hlist_is_singular_node() in
 __ep_remove()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-6-12-cve-2026-46242-v1-1-e15a6de43c11@cherry.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267419-lists,stable=lfdr.de,kernel];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:dave@stgolabs.net,m:akpm@linux-foundation.org,m:soheil@google.com,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:quentin.schulz@cherry.de,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[foss@0leil.net,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[0leil.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,cherry.de:mid,cherry.de:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0leil.net:dkim,0leil.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B24926A698E

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 3d9fd0abc94d8cd430cc7cd7d37ce5e5aae2cd2b ]

Replace the open-coded "epi is the only entry in file->f_ep" check
with hlist_is_singular_node(). Same semantics, and the helper avoids
the head-cacheline access in the common false case.

Link: https://patch.msgid.link/20260423-work-epoll-uaf-v1-1-2470f9eec0f5@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: a6dc643c6931 ("eventpoll: fix ep_remove struct eventpoll / struct file UAF")
Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 fs/eventpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index a860cb54658a3..8f9dc2f4891ff 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -827,7 +827,7 @@ static bool __ep_remove(struct eventpoll *ep, struct epitem *epi, bool force)
 
 	to_free = NULL;
 	head = file->f_ep;
-	if (head->first == &epi->fllink && !epi->fllink.next) {
+	if (hlist_is_singular_node(&epi->fllink, head)) {
 		/* See eventpoll_release() for details. */
 		WRITE_ONCE(file->f_ep, NULL);
 		if (!is_file_epoll(file)) {

-- 
2.54.0



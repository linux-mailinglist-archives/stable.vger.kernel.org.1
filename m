Return-Path: <stable+bounces-265134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hiqdLKyDMWpnlQUAu9opvQ
	(envelope-from <stable+bounces-265134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:11:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55384692D41
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:11:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=i6cyt0DR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265134-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-265134-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92D0B307B894
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038DE47AF56;
	Tue, 16 Jun 2026 17:07:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B264447B41C;
	Tue, 16 Jun 2026 17:07:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629642; cv=none; b=jxXPal+wFs1YnUnwu0OV70LFrqMbbvrEBtvuh4Wz/GM3fnjgh9VL7gjuEvzpAfTnqE0c6VsSlpsYghM1jEF+CZ/0uoCAq1PNNYfDyH5gr/0e3KAUdoeOBJMtAp24GWCO7plz7x9KIdpmooelcIqngF/qgocGZTk9Q5mKr7ZMRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629642; c=relaxed/simple;
	bh=hp5y/2RffP0FCgpTrvYpYSHzRqffZvCpwkSqLX5HyL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W+xgHHs7HLCu+IEkZgmRsOWY4jl58IZrdSF0tmQRjyY1Y/SaSCYN11KT5q41YidsLeUvoud5ArOCZOkCrSF9dOq/2GQxGyzIUPCIMMWTHxuTjTA++v/8hMAMh9vVLZ7UG/JuUpjHb9HQub93qpywQOGliZacx4K9PMlnW+N3WwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i6cyt0DR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE8D1F000E9;
	Tue, 16 Jun 2026 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629641;
	bh=kEp4/WFwEzAsx71xIUbIAuBjOX3wKRzJCFFNZHf69pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i6cyt0DRTFJUSWjDPymyjj17XGW2rODSTyB9K/IU3SSabOXSxNdMwItWq2PAA2Lk1
	 SFchi5m0yEnW5D1ECFm5/tr4SZDMJI2Cxt1fBwb1WLZWXZrkrzIAQNoskm+XOnDvMh
	 Pu2yHGNNtylqIknNJsGh+NQF4oQIWMiXT5vZa6x8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6 324/452] inet: frags: fix use-after-free caused by the fqdir_pre_exit() flush
Date: Tue, 16 Jun 2026 20:29:11 +0530
Message-ID: <20260616145134.443331608@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-265134-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:edumazet@google.com,m:imv4bel@gmail.com,m:kuba@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 55384692D41

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hyunwoo Kim <imv4bel@gmail.com>

commit 32594b09854970d7ba83eb2dc8c69a2edd158c8e upstream.

On netns teardown, fqdir_pre_exit() walks the fqdir rhashtable and
flushes every fragment queue that is not yet complete using
inet_frag_queue_flush(). That helper frees all the skbs queued on the
fragment queue but does not set INET_FRAG_COMPLETE, and leaves
q->fragments_tail and q->last_run_head pointing at the freed skbs.
The queue itself stays in the rhashtable.

fqdir_pre_exit() first lowers high_thresh to 0 to stop new queue lookups,
but it cannot stop a fragment that already obtained the queue through
inet_frag_find() earlier and stalled just before taking the queue lock.
Once that fragment resumes after the flush and takes the queue lock,
it passes the INET_FRAG_COMPLETE check and then dereferences the freed
fragments_tail. inet_frag_queue_insert() reads FRAG_CB() and ->len of
that pointer and, on the append path, writes ->next_frag, causing a
slab use-after-free. IPv6, nf_conntrack_reasm6 and 6lowpan reassembly
share the same flush path and are affected as well.

Reset rb_fragments, fragments_tail and last_run_head in
inet_frag_queue_flush() so a flushed queue no longer points at the
freed skbs. A fragment that resumes after the flush and takes the
queue lock then finds an empty queue and starts a new run instead of
dereferencing the freed fragments_tail. ip_frag_reinit() already
performed this reset after its own flush, so drop the now duplicate
code there.

Cc: stable@vger.kernel.org
Fixes: 006a5035b495 ("inet: frags: flush pending skbs in fqdir_pre_exit()")
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Link: https://patch.msgid.link/ah6ukYq5G98LshdA@v4bel
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/inet_fragment.c |    3 +++
 net/ipv4/ip_fragment.c   |    3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -329,6 +329,9 @@ void inet_frag_queue_flush(struct inet_f
 	reason = reason ?: SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
 	sum = inet_frag_rbtree_purge(&q->rb_fragments, reason);
 	sub_frag_mem_limit(q->fqdir, sum);
+	q->rb_fragments = RB_ROOT;
+	q->fragments_tail = NULL;
+	q->last_run_head = NULL;
 }
 EXPORT_SYMBOL(inet_frag_queue_flush);
 
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -265,9 +265,6 @@ static int ip_frag_reinit(struct ipq *qp
 	qp->q.flags = 0;
 	qp->q.len = 0;
 	qp->q.meat = 0;
-	qp->q.rb_fragments = RB_ROOT;
-	qp->q.fragments_tail = NULL;
-	qp->q.last_run_head = NULL;
 	qp->iif = 0;
 	qp->ecn = 0;
 




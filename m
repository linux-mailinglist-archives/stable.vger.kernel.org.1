Return-Path: <stable+bounces-256575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EENYNlddGWpevwgAu9opvQ
	(envelope-from <stable+bounces-256575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:33:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8C05FFFE6
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8FD23032594
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 09:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8D03BD64D;
	Fri, 29 May 2026 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="kN2tBpio"
X-Original-To: stable@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149A3BC668
	for <stable@vger.kernel.org>; Fri, 29 May 2026 09:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047015; cv=none; b=nJNof9DFLg1Cv78Ud11IHzRLvshUTJMcOWyFYK0n+vUtttPqc1kSpy0IczOmOTCUjdzFWmU5y3CVv54bgbehAgWY6FSuFDZ6B9Kngt8eMLlqkkGFGRQ80t4jOZE7jnMZhwOJdQdSaBfgTb5pmvPithswEAtysOTMWOWwwXMl+ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047015; c=relaxed/simple;
	bh=qSvczT+bjzucv/v/GHRqJvvSvFXJTdploNDOPc6zt2U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=LuTl2U/VP1Gq1ziUmjGq2AQ1WKD/6Rdy7wgEPDr9DCTmiN3SsLdWPfIbzFRDa1Sr4bTlBIbEnEx4Pu57KjeNI93w/g6hqxfId40zMIr277EdTir1B4b9+UWEkwENN2vXXqqfpCr00737nqNOgvSAul5uEB9w7R1ERljV5b+8d8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=kN2tBpio; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=kN2tBpioaD5d1TKz1gYqszyUZ3UAxC++Nar3MaLBBfxWBxQTNGtBcMuE2euRHVKqlxu2jcaHlZyJ8
	 T/GknarmKQE47sOf0P2aDXJS82nF040vtGtdzCeKPTPVbcPexPMNkrARGnyN0Lo75p3mAjMAp6436d
	 YqsaWwrXwr43sDOQ=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[183.241.249.24])
	by rmsmtp-lg-appmail-14-12003 (RichMail) with SMTP id 2ee36a195c97935-159fe;
	Fri, 29 May 2026 17:30:01 +0800 (CST)
X-RM-TRANSID:2ee36a195c97935-159fe
From: Rajani Kantha <681739313@139.com>
To: kuba@kernel.org,
	edumazet@google.com,
	stable@vger.kernel.org
Subject: [PATCH 6.12.y 2/2] inet: frags: flush pending skbs in fqdir_pre_exit()
Date: Fri, 29 May 2026 17:29:52 +0800
Message-Id: <20260529092952.2555-3-681739313@139.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260529092952.2555-1-681739313@139.com>
References: <20260529092952.2555-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256575-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.689];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,139.com:mid,139.com:email,msgid.link:url,ip_defrag.sh:url]
X-Rspamd-Queue-Id: 3E8C05FFFE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 006a5035b495dec008805df249f92c22c89c3d2e ]

We have been seeing occasional deadlocks on pernet_ops_rwsem since
September in NIPA. The stuck task was usually modprobe (often loading
a driver like ipvlan), trying to take the lock as a Writer.
lockdep does not track readers for rwsems so the read wasn't obvious
from the reports.

On closer inspection the Reader holding the lock was conntrack looping
forever in nf_conntrack_cleanup_net_list(). Based on past experience
with occasional NIPA crashes I looked thru the tests which run before
the crash and noticed that the crash follows ip_defrag.sh. An immediate
red flag. Scouring thru (de)fragmentation queues reveals skbs sitting
around, holding conntrack references.

The problem is that since conntrack depends on nf_defrag_ipv6,
nf_defrag_ipv6 will load first. Since nf_defrag_ipv6 loads first its
netns exit hooks run _after_ conntrack's netns exit hook.

Flush all fragment queue SKBs during fqdir_pre_exit() to release
conntrack references before conntrack cleanup runs. Also flush
the queues in timer expiry handlers when they discover fqdir->dead
is set, in case packet sneaks in while we're running the pre_exit
flush.

The commit under Fixes is not exactly the culprit, but I think
previously the timer firing would eventually unblock the spinning
conntrack.

Fixes: d5dd88794a13 ("inet: fix various use-after-free in defrags units")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20251207010942.1672972-4-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 include/net/inet_frag.h  | 13 +------------
 include/net/ipv6_frag.h  |  9 ++++++---
 net/ipv4/inet_fragment.c | 36 ++++++++++++++++++++++++++++++++++++
 net/ipv4/ip_fragment.c   | 12 +++++++-----
 4 files changed, 50 insertions(+), 20 deletions(-)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 94edc0e130d2..fcabb34fff35 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -123,18 +123,7 @@ void inet_frags_fini(struct inet_frags *);
 
 int fqdir_init(struct fqdir **fqdirp, struct inet_frags *f, struct net *net);
 
-static inline void fqdir_pre_exit(struct fqdir *fqdir)
-{
-	/* Prevent creation of new frags.
-	 * Pairs with READ_ONCE() in inet_frag_find().
-	 */
-	WRITE_ONCE(fqdir->high_thresh, 0);
-
-	/* Pairs with READ_ONCE() in inet_frag_kill(), ip_expire()
-	 * and ip6frag_expire_frag_queue().
-	 */
-	WRITE_ONCE(fqdir->dead, true);
-}
+void fqdir_pre_exit(struct fqdir *fqdir);
 void fqdir_exit(struct fqdir *fqdir);
 
 void inet_frag_kill(struct inet_frag_queue *q);
diff --git a/include/net/ipv6_frag.h b/include/net/ipv6_frag.h
index 7321ffe3a108..df61b98b5215 100644
--- a/include/net/ipv6_frag.h
+++ b/include/net/ipv6_frag.h
@@ -68,9 +68,6 @@ ip6frag_expire_frag_queue(struct net *net, struct frag_queue *fq)
 	struct sk_buff *head;
 
 	rcu_read_lock();
-	/* Paired with the WRITE_ONCE() in fqdir_pre_exit(). */
-	if (READ_ONCE(fq->q.fqdir->dead))
-		goto out_rcu_unlock;
 	spin_lock(&fq->q.lock);
 
 	if (fq->q.flags & INET_FRAG_COMPLETE)
@@ -79,6 +76,12 @@ ip6frag_expire_frag_queue(struct net *net, struct frag_queue *fq)
 	fq->q.flags |= INET_FRAG_DROP;
 	inet_frag_kill(&fq->q);
 
+	/* Paired with the WRITE_ONCE() in fqdir_pre_exit(). */
+	if (READ_ONCE(fq->q.fqdir->dead)) {
+		inet_frag_queue_flush(&fq->q, 0);
+		goto out;
+	}
+
 	dev = dev_get_by_index_rcu(net, fq->iif);
 	if (!dev)
 		goto out;
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 706409063377..f9cf20b21a07 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -219,6 +219,41 @@ static int __init inet_frag_wq_init(void)
 
 pure_initcall(inet_frag_wq_init);
 
+void fqdir_pre_exit(struct fqdir *fqdir)
+{
+	struct inet_frag_queue *fq;
+	struct rhashtable_iter hti;
+
+	/* Prevent creation of new frags.
+	 * Pairs with READ_ONCE() in inet_frag_find().
+	 */
+	WRITE_ONCE(fqdir->high_thresh, 0);
+
+	/* Pairs with READ_ONCE() in inet_frag_kill(), ip_expire()
+	 * and ip6frag_expire_frag_queue().
+	 */
+	WRITE_ONCE(fqdir->dead, true);
+
+	rhashtable_walk_enter(&fqdir->rhashtable, &hti);
+	rhashtable_walk_start(&hti);
+
+	while ((fq = rhashtable_walk_next(&hti))) {
+		if (IS_ERR(fq)) {
+			if (PTR_ERR(fq) != -EAGAIN)
+				break;
+			continue;
+		}
+		spin_lock_bh(&fq->lock);
+		if (!(fq->flags & INET_FRAG_COMPLETE))
+			inet_frag_queue_flush(fq, 0);
+		spin_unlock_bh(&fq->lock);
+	}
+
+	rhashtable_walk_stop(&hti);
+	rhashtable_walk_exit(&hti);
+}
+EXPORT_SYMBOL(fqdir_pre_exit);
+
 void fqdir_exit(struct fqdir *fqdir)
 {
 	INIT_WORK(&fqdir->destroy_work, fqdir_work_fn);
@@ -291,6 +326,7 @@ void inet_frag_queue_flush(struct inet_frag_queue *q,
 {
 	unsigned int sum;
 
+	reason = reason ?: SKB_DROP_REASON_FRAG_REASM_TIMEOUT;
 	sum = inet_frag_rbtree_purge(&q->rb_fragments, reason);
 	sub_frag_mem_limit(q->fqdir, sum);
 }
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index eb5f6060b85d..124c0d64d420 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -148,11 +148,6 @@ static void ip_expire(struct timer_list *t)
 	net = qp->q.fqdir->net;
 
 	rcu_read_lock();
-
-	/* Paired with WRITE_ONCE() in fqdir_pre_exit(). */
-	if (READ_ONCE(qp->q.fqdir->dead))
-		goto out_rcu_unlock;
-
 	spin_lock(&qp->q.lock);
 
 	if (qp->q.flags & INET_FRAG_COMPLETE)
@@ -160,6 +155,13 @@ static void ip_expire(struct timer_list *t)
 
 	qp->q.flags |= INET_FRAG_DROP;
 	ipq_kill(qp);
+
+	/* Paired with WRITE_ONCE() in fqdir_pre_exit(). */
+	if (READ_ONCE(qp->q.fqdir->dead)) {
+		inet_frag_queue_flush(&qp->q, 0);
+		goto out;
+	}
+
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMTIMEOUT);
 
-- 
2.17.1




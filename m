Return-Path: <stable+bounces-256593-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC5yBdtqGWrGwQgAu9opvQ
	(envelope-from <stable+bounces-256593-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:30:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2D5600D52
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0A73303E209
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 903873A987B;
	Fri, 29 May 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="RLY4ZpCD"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523433C5522
	for <stable@vger.kernel.org>; Fri, 29 May 2026 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050257; cv=none; b=eNVUehIlssRHl9mrtfKawd2yQyrEsAMJl47ikEcTmX2333SBfG/xOcQB9i8AaRPxk82MOREzjfi42w2p+PL2y4MAD5LIK8bHA62PmVJ60TDN0gKIkGxEM5IbgSb3dsmCQQ0W+LJRIVkeQ09XYOKkzTga+3aL0F+4FcQJuqEAUN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050257; c=relaxed/simple;
	bh=keYjF0n0a2Z/eCP5ps2EBizq6iTpDJLf+tNydm3iP6w=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=Tiqwm9bu6lO+ENVubaEuPFGQx9zHuu4SiRRKYxFOQZqXkUp6fnB1k2QrIO060UWz7SbUaLqQi4UILSog2q7Kbj1X1mEXMmUnk850kVBSezteanySgqWbvGfb72OwWdCkBOkkvMxdktsym07e2Syoz8mj43EiocplIIBCslOc1gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=RLY4ZpCD; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=RLY4ZpCDfkyh5zpTFrenzhIgjScZ767Q89H9ys6jv4agpGKAeiY5besTBZwoScFicQ8uN376rKtPG
	 8IcCE3jEfrzZVkMmD6FhDMnd2cIMkvyxVKFxgS4+h5y20pg3ial7tzs8SQeVRy5idbcIevFiohRTTA
	 LzPG8gqPwidOXSh0=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[183.241.249.24])
	by rmsmtp-lg-appmail-03-12081 (RichMail) with SMTP id 2f316a19694936d-17460;
	Fri, 29 May 2026 18:24:11 +0800 (CST)
X-RM-TRANSID:2f316a19694936d-17460
From: Rajani Kantha <681739313@139.com>
To: kuba@kernel.org,
	edumazet@google.com,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y 2/2] inet: frags: flush pending skbs in fqdir_pre_exit()
Date: Fri, 29 May 2026 18:24:09 +0800
Message-Id: <20260529102409.3042-3-681739313@139.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260529102409.3042-1-681739313@139.com>
References: <20260529102409.3042-1-681739313@139.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256593-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[139.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.687];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,139.com:mid,139.com:email,ip_defrag.sh:url]
X-Rspamd-Queue-Id: 8E2D5600D52
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
index 1e390d24f114..8cf88882d65e 100644
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
index 7214d5bcc647..f5b5aa036cc6 100644
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




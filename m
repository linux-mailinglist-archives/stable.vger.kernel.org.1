Return-Path: <stable+bounces-256591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMbEE9hqGWrGwQgAu9opvQ
	(envelope-from <stable+bounces-256591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:30:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D10600D49
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 65481302A1A5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8498F3BED2D;
	Fri, 29 May 2026 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="i189woRt"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98453C345F
	for <stable@vger.kernel.org>; Fri, 29 May 2026 10:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050257; cv=none; b=kMj8RTN2VZIBZREzeOcSAVgyblmd0Cjkv9D6uGktvQd/FitWW4ugDQshIJj/ThsEr/5qMln4jf0H0l6fcim/YzhDhjGD537R++TyVEIcl3ATy4K98km++x85xNblMzGs+9/dwb9sOmyVKQCoOi6EfYtdKyW3GJnZVhufA4TuRWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050257; c=relaxed/simple;
	bh=shKujnPhjFiYFJGW8SVIXhc/Yi+U0+NsC/IXThEHEqc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=O87AKBbyfKBq5U2IponX/1FqFkPN37T6b84q0vHiMqlavPt8xoHeqNN3vm/YD97PNv/WCf1MFxGSOTeFerPiYRrL7Ent0i1SoOPmKvo9qoGRlptfcaXb6/FEXYbuC/16UhDUlxTpaKVbl9GqGhh+OGusXIhxQJgZL3PbKtg1Mms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=i189woRt; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=i189woRt1dVX6sU4pCNlourrzx5xwSzpzZ3dKojNmUgUklhnTcfp72R3GdiZ00nNPVMbOtYc9RXBi
	 gD3OZcMXEdD5nMGvalVEnhz22p9WAieE/DNtZkIy2mFw0GcBUk+LdOXOdHsAN7FKqmZun5FA72HkWi
	 A2j8dN8G0qDCosbs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[183.241.249.24])
	by rmsmtp-lg-appmail-03-12081 (RichMail) with SMTP id 2f316a19694936d-1745f;
	Fri, 29 May 2026 18:24:11 +0800 (CST)
X-RM-TRANSID:2f316a19694936d-1745f
From: Rajani Kantha <681739313@139.com>
To: kuba@kernel.org,
	edumazet@google.com,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y 1/2] inet: frags: add inet_frag_queue_flush()
Date: Fri, 29 May 2026 18:24:08 +0800
Message-Id: <20260529102409.3042-2-681739313@139.com>
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
	TAGGED_FROM(0.00)[bounces-256591-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.558];
	FREEMAIL_FROM(0.00)[139.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,139.com:mid,139.com:email]
X-Rspamd-Queue-Id: D4D10600D49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 1231eec6994be29d6bb5c303dfa54731ed9fc0e6 ]

Instead of exporting inet_frag_rbtree_purge() which requires that
caller takes care of memory accounting, add a new helper. We will
need to call it from a few places in the next patch.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20251207010942.1672972-3-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 include/net/inet_frag.h  |  5 ++---
 net/ipv4/inet_fragment.c | 15 ++++++++++++---
 net/ipv4/ip_fragment.c   |  6 +-----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 5af6eb14c5db..94edc0e130d2 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -141,9 +141,8 @@ void inet_frag_kill(struct inet_frag_queue *q);
 void inet_frag_destroy(struct inet_frag_queue *q);
 struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key);
 
-/* Free all skbs in the queue; return the sum of their truesizes. */
-unsigned int inet_frag_rbtree_purge(struct rb_root *root,
-				    enum skb_drop_reason reason);
+void inet_frag_queue_flush(struct inet_frag_queue *q,
+			   enum skb_drop_reason reason);
 
 static inline void inet_frag_put(struct inet_frag_queue *q)
 {
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 496308c02384..1e390d24f114 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -264,8 +264,8 @@ static void inet_frag_destroy_rcu(struct rcu_head *head)
 	kmem_cache_free(f->frags_cachep, q);
 }
 
-unsigned int inet_frag_rbtree_purge(struct rb_root *root,
-				    enum skb_drop_reason reason)
+static unsigned int
+inet_frag_rbtree_purge(struct rb_root *root, enum skb_drop_reason reason)
 {
 	struct rb_node *p = rb_first(root);
 	unsigned int sum = 0;
@@ -285,7 +285,16 @@ unsigned int inet_frag_rbtree_purge(struct rb_root *root,
 	}
 	return sum;
 }
-EXPORT_SYMBOL(inet_frag_rbtree_purge);
+
+void inet_frag_queue_flush(struct inet_frag_queue *q,
+			   enum skb_drop_reason reason)
+{
+	unsigned int sum;
+
+	sum = inet_frag_rbtree_purge(&q->rb_fragments, reason);
+	sub_frag_mem_limit(q->fqdir, sum);
+}
+EXPORT_SYMBOL(inet_frag_queue_flush);
 
 void inet_frag_destroy(struct inet_frag_queue *q)
 {
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 484edc8513e4..7214d5bcc647 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -253,16 +253,12 @@ static int ip_frag_too_far(struct ipq *qp)
 
 static int ip_frag_reinit(struct ipq *qp)
 {
-	unsigned int sum_truesize = 0;
-
 	if (!mod_timer(&qp->q.timer, jiffies + qp->q.fqdir->timeout)) {
 		refcount_inc(&qp->q.refcnt);
 		return -ETIMEDOUT;
 	}
 
-	sum_truesize = inet_frag_rbtree_purge(&qp->q.rb_fragments,
-					      SKB_DROP_REASON_FRAG_TOO_FAR);
-	sub_frag_mem_limit(qp->q.fqdir, sum_truesize);
+	inet_frag_queue_flush(&qp->q, SKB_DROP_REASON_FRAG_TOO_FAR);
 
 	qp->q.flags = 0;
 	qp->q.len = 0;
-- 
2.17.1




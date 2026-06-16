Return-Path: <stable+bounces-264864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /th1Jb5/MWq7kwUAu9opvQ
	(envelope-from <stable+bounces-264864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:54:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2B1692906
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:54:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=e4RbV1PF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264864-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264864-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC41B302B9C5
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABBE47279B;
	Tue, 16 Jun 2026 16:44:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8102F745E;
	Tue, 16 Jun 2026 16:44:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628291; cv=none; b=ecnfnDu++ZGcGg5ICrEGjP/vSHnlIrKySRBitCI6Vv4Z4LnmHQsw5M4yWU4BMUKJwEO4bKE6qmMOeSzN/0qbQEqDBtdZAo/3s2VoxvtsSBMrQg/x38YcMPaJbSvq3PpXdLVXkd0BdqZ1MSdYanbr5aPJw973+xp9a7/fJrc4DYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628291; c=relaxed/simple;
	bh=9Ms2/AOQJ21mnM0u/bZZF8bfcZ53zEh3oIvL++CZub4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHGtuhlhVR//2zipiS7B+oU1a4mCpfla6bIR1AmImspNKwh+41WKjEgNYDKQ2hFWb/IgpA5EZxmKzBcvnXTDFFF0Yge+9/ujaHy8mlAPUX4ewLDqDBTwUqHWHVmymWYA9oj5zaSrC/8vFy36b/CNKpvpy/Zy8pNLIHWA/+7T6yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e4RbV1PF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE3D1F000E9;
	Tue, 16 Jun 2026 16:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781628290;
	bh=+GlUeeZcUnoLpYbYe2e6z4ODrLyfz7Xwlj+Ytn+q0EU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e4RbV1PFOMapKy5WelCdp0u79WcuHykLDgxOW7uoXtUSjG+X4Coaw9AB4Rlidbsak
	 EcE/nCozNifJyxS2a5B8ElwfG/4tRAmN0/VdgGrKFaiIbxIBTPPt5LSdezGg3D9IlV
	 ams/ev+WqQE3SngRGIrjQ405uceVEcsrYMgmsnao=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Rajani Kantha <681739313@139.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 067/452] inet: frags: add inet_frag_queue_flush()
Date: Tue, 16 Jun 2026 20:24:54 +0530
Message-ID: <20260616145121.458781338@linuxfoundation.org>
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
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[139.com:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264864-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:edumazet@google.com,m:kuba@kernel.org,m:681739313@139.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,kernel.org,139.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,139.com:email,msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8F2B1692906

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 1231eec6994be29d6bb5c303dfa54731ed9fc0e6 ]

Instead of exporting inet_frag_rbtree_purge() which requires that
caller takes care of memory accounting, add a new helper. We will
need to call it from a few places in the next patch.

Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20251207010942.1672972-3-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/inet_frag.h  |  5 ++---
 net/ipv4/inet_fragment.c | 15 ++++++++++++---
 net/ipv4/ip_fragment.c   |  6 +-----
 3 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 5af6eb14c5db15..94edc0e130d2c4 100644
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
index 496308c0238485..1e390d24f11440 100644
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
index 484edc8513e4b7..7214d5bcc647e5 100644
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
2.53.0





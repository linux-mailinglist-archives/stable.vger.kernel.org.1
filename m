Return-Path: <stable+bounces-91172-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB97D9BECCD
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EE61B223CE
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB0E1DE4CA;
	Wed,  6 Nov 2024 12:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TB0gEk2r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE001E04B2;
	Wed,  6 Nov 2024 12:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730897953; cv=none; b=tWKYiabq7jubxvgyjVRbNPHsmZ9IlZRhW0q9eUA4rAj6i3drNOr0mgE95GoSWxyfx6qlHl0zSVmjdWF7pSSjmp2sUGmm5VtstUPUrXOBAGyhVJ3NfaB6gdaWH7htUQri6HDULAKLu3Wax6UlMTlXO61Hbkeyh+ZUl1QrhFLj1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730897953; c=relaxed/simple;
	bh=RHmKrboBd280PbmfQ4gdh2hXzgNKY4s0nr+HBMF0FwQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQmUzbEOnOm/5Srdu3rqJx9LNV/Lih87N07QNPkr1ILDQ+CNxu4XOK+FLcvJRiMwWeNgtWmxMH46BPpkA++cJJ5ID91lvoRvmNx8Xrsrc2qIF1sTwAnQWHvn6kaK9MpS8yKynt2jDfPNdJOG9YuSormMmwMc/ravUi0yrvEpOv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TB0gEk2r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750A8C4CECD;
	Wed,  6 Nov 2024 12:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730897952;
	bh=RHmKrboBd280PbmfQ4gdh2hXzgNKY4s0nr+HBMF0FwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TB0gEk2r4Yd14z6Q1ZKQe0//MbkWoteIrSYCuk083GwP0YG2NdQeWg0VuRPkShbTo
	 JuxXQU0XS4d/BQlvDUGukToigwQqkjbGshPbfOovJPczrdzvTysGURUogAQKjcOgqe
	 S/d5IantHp18/u7pMyinMKDwKHg85Svzi7myJJHU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	xingwei lee <xrivendell7@gmail.com>,
	yue sun <samsun1006219@gmail.com>,
	syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com,
	Florian Westphal <fw@strlen.de>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Subject: [PATCH 5.4 028/462] inet: inet_defrag: prevent sk release while still in use
Date: Wed,  6 Nov 2024 12:58:41 +0100
Message-ID: <20241106120332.212918859@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 18685451fc4e546fc0e718580d32df3c0e5c8272 upstream.

ip_local_out() and other functions can pass skb->sk as function argument.

If the skb is a fragment and reassembly happens before such function call
returns, the sk must not be released.

This affects skb fragments reassembled via netfilter or similar
modules, e.g. openvswitch or ct_act.c, when run as part of tx pipeline.

Eric Dumazet made an initial analysis of this bug.  Quoting Eric:
  Calling ip_defrag() in output path is also implying skb_orphan(),
  which is buggy because output path relies on sk not disappearing.

  A relevant old patch about the issue was :
  8282f27449bf ("inet: frag: Always orphan skbs inside ip_defrag()")

  [..]

  net/ipv4/ip_output.c depends on skb->sk being set, and probably to an
  inet socket, not an arbitrary one.

  If we orphan the packet in ipvlan, then downstream things like FQ
  packet scheduler will not work properly.

  We need to change ip_defrag() to only use skb_orphan() when really
  needed, ie whenever frag_list is going to be used.

Eric suggested to stash sk in fragment queue and made an initial patch.
However there is a problem with this:

If skb is refragmented again right after, ip_do_fragment() will copy
head->sk to the new fragments, and sets up destructor to sock_wfree.
IOW, we have no choice but to fix up sk_wmem accouting to reflect the
fully reassembled skb, else wmem will underflow.

This change moves the orphan down into the core, to last possible moment.
As ip_defrag_offset is aliased with sk_buff->sk member, we must move the
offset into the FRAG_CB, else skb->sk gets clobbered.

This allows to delay the orphaning long enough to learn if the skb has
to be queued or if the skb is completing the reasm queue.

In the former case, things work as before, skb is orphaned.  This is
safe because skb gets queued/stolen and won't continue past reasm engine.

In the latter case, we will steal the skb->sk reference, reattach it to
the head skb, and fix up wmem accouting when inet_frag inflates truesize.

Fixes: 7026b1ddb6b8 ("netfilter: Pass socket pointer down through okfn().")
Diagnosed-by: Eric Dumazet <edumazet@google.com>
Reported-by: xingwei lee <xrivendell7@gmail.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Reported-by: syzbot+e5167d7144a62715044c@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240326101845.30836-1-fw@strlen.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h                  |    5 --
 net/core/sock_destructor.h              |   12 +++++
 net/ipv4/inet_fragment.c                |   70 ++++++++++++++++++++++++++------
 net/ipv4/ip_fragment.c                  |    2 
 net/ipv6/netfilter/nf_conntrack_reasm.c |    2 
 5 files changed, 72 insertions(+), 19 deletions(-)
 create mode 100644 net/core/sock_destructor.h

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -704,10 +704,7 @@ struct sk_buff {
 		struct list_head	list;
 	};
 
-	union {
-		struct sock		*sk;
-		int			ip_defrag_offset;
-	};
+	struct sock		*sk;
 
 	union {
 		ktime_t		tstamp;
--- /dev/null
+++ b/net/core/sock_destructor.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _NET_CORE_SOCK_DESTRUCTOR_H
+#define _NET_CORE_SOCK_DESTRUCTOR_H
+#include <net/tcp.h>
+
+static inline bool is_skb_wmem(const struct sk_buff *skb)
+{
+	return skb->destructor == sock_wfree ||
+	       skb->destructor == __sock_wfree ||
+	       (IS_ENABLED(CONFIG_INET) && skb->destructor == tcp_wfree);
+}
+#endif
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -24,6 +24,8 @@
 #include <net/ip.h>
 #include <net/ipv6.h>
 
+#include "../core/sock_destructor.h"
+
 /* Use skb->cb to track consecutive/adjacent fragments coming at
  * the end of the queue. Nodes in the rb-tree queue will
  * contain "runs" of one or more adjacent fragments.
@@ -39,6 +41,7 @@ struct ipfrag_skb_cb {
 	};
 	struct sk_buff		*next_frag;
 	int			frag_run_len;
+	int			ip_defrag_offset;
 };
 
 #define FRAG_CB(skb)		((struct ipfrag_skb_cb *)((skb)->cb))
@@ -359,12 +362,12 @@ int inet_frag_queue_insert(struct inet_f
 	 */
 	if (!last)
 		fragrun_create(q, skb);  /* First fragment. */
-	else if (last->ip_defrag_offset + last->len < end) {
+	else if (FRAG_CB(last)->ip_defrag_offset + last->len < end) {
 		/* This is the common case: skb goes to the end. */
 		/* Detect and discard overlaps. */
-		if (offset < last->ip_defrag_offset + last->len)
+		if (offset < FRAG_CB(last)->ip_defrag_offset + last->len)
 			return IPFRAG_OVERLAP;
-		if (offset == last->ip_defrag_offset + last->len)
+		if (offset == FRAG_CB(last)->ip_defrag_offset + last->len)
 			fragrun_append_to_last(q, skb);
 		else
 			fragrun_create(q, skb);
@@ -381,13 +384,13 @@ int inet_frag_queue_insert(struct inet_f
 
 			parent = *rbn;
 			curr = rb_to_skb(parent);
-			curr_run_end = curr->ip_defrag_offset +
+			curr_run_end = FRAG_CB(curr)->ip_defrag_offset +
 					FRAG_CB(curr)->frag_run_len;
-			if (end <= curr->ip_defrag_offset)
+			if (end <= FRAG_CB(curr)->ip_defrag_offset)
 				rbn = &parent->rb_left;
 			else if (offset >= curr_run_end)
 				rbn = &parent->rb_right;
-			else if (offset >= curr->ip_defrag_offset &&
+			else if (offset >= FRAG_CB(curr)->ip_defrag_offset &&
 				 end <= curr_run_end)
 				return IPFRAG_DUP;
 			else
@@ -401,7 +404,7 @@ int inet_frag_queue_insert(struct inet_f
 		rb_insert_color(&skb->rbnode, &q->rb_fragments);
 	}
 
-	skb->ip_defrag_offset = offset;
+	FRAG_CB(skb)->ip_defrag_offset = offset;
 
 	return IPFRAG_OK;
 }
@@ -411,13 +414,28 @@ void *inet_frag_reasm_prepare(struct ine
 			      struct sk_buff *parent)
 {
 	struct sk_buff *fp, *head = skb_rb_first(&q->rb_fragments);
-	struct sk_buff **nextp;
+	void (*destructor)(struct sk_buff *);
+	unsigned int orig_truesize = 0;
+	struct sk_buff **nextp = NULL;
+	struct sock *sk = skb->sk;
 	int delta;
 
+	if (sk && is_skb_wmem(skb)) {
+		/* TX: skb->sk might have been passed as argument to
+		 * dst->output and must remain valid until tx completes.
+		 *
+		 * Move sk to reassembled skb and fix up wmem accounting.
+		 */
+		orig_truesize = skb->truesize;
+		destructor = skb->destructor;
+	}
+
 	if (head != skb) {
 		fp = skb_clone(skb, GFP_ATOMIC);
-		if (!fp)
-			return NULL;
+		if (!fp) {
+			head = skb;
+			goto out_restore_sk;
+		}
 		FRAG_CB(fp)->next_frag = FRAG_CB(skb)->next_frag;
 		if (RB_EMPTY_NODE(&skb->rbnode))
 			FRAG_CB(parent)->next_frag = fp;
@@ -426,6 +444,12 @@ void *inet_frag_reasm_prepare(struct ine
 					&q->rb_fragments);
 		if (q->fragments_tail == skb)
 			q->fragments_tail = fp;
+
+		if (orig_truesize) {
+			/* prevent skb_morph from releasing sk */
+			skb->sk = NULL;
+			skb->destructor = NULL;
+		}
 		skb_morph(skb, head);
 		FRAG_CB(skb)->next_frag = FRAG_CB(head)->next_frag;
 		rb_replace_node(&head->rbnode, &skb->rbnode,
@@ -433,13 +457,13 @@ void *inet_frag_reasm_prepare(struct ine
 		consume_skb(head);
 		head = skb;
 	}
-	WARN_ON(head->ip_defrag_offset != 0);
+	WARN_ON(FRAG_CB(head)->ip_defrag_offset != 0);
 
 	delta = -head->truesize;
 
 	/* Head of list must not be cloned. */
 	if (skb_unclone(head, GFP_ATOMIC))
-		return NULL;
+		goto out_restore_sk;
 
 	delta += head->truesize;
 	if (delta)
@@ -455,7 +479,7 @@ void *inet_frag_reasm_prepare(struct ine
 
 		clone = alloc_skb(0, GFP_ATOMIC);
 		if (!clone)
-			return NULL;
+			goto out_restore_sk;
 		skb_shinfo(clone)->frag_list = skb_shinfo(head)->frag_list;
 		skb_frag_list_init(head);
 		for (i = 0; i < skb_shinfo(head)->nr_frags; i++)
@@ -472,6 +496,21 @@ void *inet_frag_reasm_prepare(struct ine
 		nextp = &skb_shinfo(head)->frag_list;
 	}
 
+out_restore_sk:
+	if (orig_truesize) {
+		int ts_delta = head->truesize - orig_truesize;
+
+		/* if this reassembled skb is fragmented later,
+		 * fraglist skbs will get skb->sk assigned from head->sk,
+		 * and each frag skb will be released via sock_wfree.
+		 *
+		 * Update sk_wmem_alloc.
+		 */
+		head->sk = sk;
+		head->destructor = destructor;
+		refcount_add(ts_delta, &sk->sk_wmem_alloc);
+	}
+
 	return nextp;
 }
 EXPORT_SYMBOL(inet_frag_reasm_prepare);
@@ -479,6 +518,8 @@ EXPORT_SYMBOL(inet_frag_reasm_prepare);
 void inet_frag_reasm_finish(struct inet_frag_queue *q, struct sk_buff *head,
 			    void *reasm_data, bool try_coalesce)
 {
+	struct sock *sk = is_skb_wmem(head) ? head->sk : NULL;
+	const unsigned int head_truesize = head->truesize;
 	struct sk_buff **nextp = (struct sk_buff **)reasm_data;
 	struct rb_node *rbn;
 	struct sk_buff *fp;
@@ -541,6 +582,9 @@ void inet_frag_reasm_finish(struct inet_
 	skb_mark_not_on_list(head);
 	head->prev = NULL;
 	head->tstamp = q->stamp;
+
+	if (sk)
+		refcount_add(sum_truesize - head_truesize, &sk->sk_wmem_alloc);
 }
 EXPORT_SYMBOL(inet_frag_reasm_finish);
 
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -377,6 +377,7 @@ static int ip_frag_queue(struct ipq *qp,
 	}
 
 	skb_dst_drop(skb);
+	skb_orphan(skb);
 	return -EINPROGRESS;
 
 insert_error:
@@ -479,7 +480,6 @@ int ip_defrag(struct net *net, struct sk
 	struct ipq *qp;
 
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);
-	skb_orphan(skb);
 
 	/* Lookup (or create) queue header */
 	qp = ip_find(net, ip_hdr(skb), user, vif);
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -296,6 +296,7 @@ static int nf_ct_frag6_queue(struct frag
 	}
 
 	skb_dst_drop(skb);
+	skb_orphan(skb);
 	return -EINPROGRESS;
 
 insert_error:
@@ -461,7 +462,6 @@ int nf_ct_frag6_gather(struct net *net,
 	hdr = ipv6_hdr(skb);
 	fhdr = (struct frag_hdr *)skb_transport_header(skb);
 
-	skb_orphan(skb);
 	fq = fq_find(net, fhdr->identification, user, hdr,
 		     skb->dev ? skb->dev->ifindex : 0);
 	if (fq == NULL) {




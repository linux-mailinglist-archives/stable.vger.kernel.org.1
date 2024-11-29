Return-Path: <stable+bounces-94233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B3E9D3BA7
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 14:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02AA5283B79
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 13:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F41D1BD9F7;
	Wed, 20 Nov 2024 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YR44vHZt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89E1AB6EF;
	Wed, 20 Nov 2024 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107575; cv=none; b=nnUpykR0tUjsTxP/6P5GdhxPWwf9fJ2hmITeu/LMM0cHJEwiIAXHb78bJ8ZHSzNaGM/+/j2S0zwqVLqKRBlJfn3+PACTuhXO+mXeEmGNraTNUBLnOp0uLQX6IqjhiULgIajdzYLe/bY0vr3E8/qt9DHCT1aqwjS6pqLbFtm8VoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107575; c=relaxed/simple;
	bh=o0T+LTfhBYDssSMUAsqsNOqQIl2971IstzxTZRhWARU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2NzXnRHtoEKsR27vqc3oO3JCPUi/dbDNs0Nld6PoH4T3vrp2uODzAY7pdl0t3AeVj9dUV984h0/lmhgAWvVa4y6WAGOOQbLi+sxaJVhNRlywm9pyTaeZddyVbXa7MxEkHB3RJnUR+rzfoHlLE+g2TJIr0xFAH+fqWOk5xaRSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YR44vHZt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2970C4CECD;
	Wed, 20 Nov 2024 12:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1732107574;
	bh=o0T+LTfhBYDssSMUAsqsNOqQIl2971IstzxTZRhWARU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YR44vHZtfyLps2/2ripaJhHjxIR1tK+mK98hr7gZ/7FbUqEpLMdZjsu44HPNsvy9m
	 zDcQHcPH52LostDYgFSMsYfwYVUQhZpuvh/gyNJ/EzTiKYZow+pM+/jO6QNHsBxkr4
	 chQbj/NjWgu+Os/vgY0F8Sl+ODU5HHOnmGrYQ+Xk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pedro Tammela <pctammela@mojatatu.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 15/82] net/sched: cls_u32: replace int refcounts with proper refcounts
Date: Wed, 20 Nov 2024 13:56:25 +0100
Message-ID: <20241120125629.957976276@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120125629.623666563@linuxfoundation.org>
References: <20241120125629.623666563@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 6b78debe1c07e6aa3c91ca0b1384bf3cb8217c50 ]

Proper refcounts will always warn splat when something goes wrong,
be it underflow, saturation or object resurrection. As these are always
a source of bugs, use it in cls_u32 as a safeguard to prevent/catch issues.
Another benefit is that the refcount API self documents the code, making
clear when transitions to dead are expected.

For such an update we had to make minor adaptations on u32 to fit the refcount
API. First we set explicitly to '1' when objects are created, then the
objects are alive until a 1 -> 0 happens, which is then released appropriately.

The above made clear some redundant operations in the u32 code
around the root_ht handling that were removed. The root_ht is created
with a refcnt set to 1. Then when it's associated with tcf_proto it increments the refcnt to 2.
Throughout the entire code the root_ht is an exceptional case and can never be referenced,
therefore the refcnt never incremented/decremented.
Its lifetime is always bound to tcf_proto, meaning if you delete tcf_proto
the root_ht is deleted as well. The code made up for the fact that root_ht refcnt is 2 and did
a double decrement to free it, which is not a fit for the refcount API.

Even though refcount_t is implemented using atomics, we should observe
a negligible control plane impact.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Link: https://lore.kernel.org/r/20231114141856.974326-2-pctammela@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 73af53d82076 ("net: sched: cls_u32: Fix u32's systematic failure to free IDR entries for hnodes.")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sched/cls_u32.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index 6663e971a13e7..b3531f458adaf 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -71,7 +71,7 @@ struct tc_u_hnode {
 	struct tc_u_hnode __rcu	*next;
 	u32			handle;
 	u32			prio;
-	int			refcnt;
+	refcount_t		refcnt;
 	unsigned int		divisor;
 	struct idr		handle_idr;
 	bool			is_root;
@@ -86,7 +86,7 @@ struct tc_u_hnode {
 struct tc_u_common {
 	struct tc_u_hnode __rcu	*hlist;
 	void			*ptr;
-	int			refcnt;
+	refcount_t		refcnt;
 	struct idr		handle_idr;
 	struct hlist_node	hnode;
 	long			knodes;
@@ -359,7 +359,7 @@ static int u32_init(struct tcf_proto *tp)
 	if (root_ht == NULL)
 		return -ENOBUFS;
 
-	root_ht->refcnt++;
+	refcount_set(&root_ht->refcnt, 1);
 	root_ht->handle = tp_c ? gen_new_htid(tp_c, root_ht) : 0x80000000;
 	root_ht->prio = tp->prio;
 	root_ht->is_root = true;
@@ -371,18 +371,20 @@ static int u32_init(struct tcf_proto *tp)
 			kfree(root_ht);
 			return -ENOBUFS;
 		}
+		refcount_set(&tp_c->refcnt, 1);
 		tp_c->ptr = key;
 		INIT_HLIST_NODE(&tp_c->hnode);
 		idr_init(&tp_c->handle_idr);
 
 		hlist_add_head(&tp_c->hnode, tc_u_hash(key));
+	} else {
+		refcount_inc(&tp_c->refcnt);
 	}
 
-	tp_c->refcnt++;
 	RCU_INIT_POINTER(root_ht->next, tp_c->hlist);
 	rcu_assign_pointer(tp_c->hlist, root_ht);
 
-	root_ht->refcnt++;
+	/* root_ht must be destroyed when tcf_proto is destroyed */
 	rcu_assign_pointer(tp->root, root_ht);
 	tp->data = tp_c;
 	return 0;
@@ -393,7 +395,7 @@ static void __u32_destroy_key(struct tc_u_knode *n)
 	struct tc_u_hnode *ht = rtnl_dereference(n->ht_down);
 
 	tcf_exts_destroy(&n->exts);
-	if (ht && --ht->refcnt == 0)
+	if (ht && refcount_dec_and_test(&ht->refcnt))
 		kfree(ht);
 	kfree(n);
 }
@@ -601,8 +603,6 @@ static int u32_destroy_hnode(struct tcf_proto *tp, struct tc_u_hnode *ht,
 	struct tc_u_hnode __rcu **hn;
 	struct tc_u_hnode *phn;
 
-	WARN_ON(--ht->refcnt);
-
 	u32_clear_hnode(tp, ht, extack);
 
 	hn = &tp_c->hlist;
@@ -630,10 +630,10 @@ static void u32_destroy(struct tcf_proto *tp, bool rtnl_held,
 
 	WARN_ON(root_ht == NULL);
 
-	if (root_ht && --root_ht->refcnt == 1)
+	if (root_ht && refcount_dec_and_test(&root_ht->refcnt))
 		u32_destroy_hnode(tp, root_ht, extack);
 
-	if (--tp_c->refcnt == 0) {
+	if (refcount_dec_and_test(&tp_c->refcnt)) {
 		struct tc_u_hnode *ht;
 
 		hlist_del(&tp_c->hnode);
@@ -645,7 +645,7 @@ static void u32_destroy(struct tcf_proto *tp, bool rtnl_held,
 			/* u32_destroy_key() will later free ht for us, if it's
 			 * still referenced by some knode
 			 */
-			if (--ht->refcnt == 0)
+			if (refcount_dec_and_test(&ht->refcnt))
 				kfree_rcu(ht, rcu);
 		}
 
@@ -674,7 +674,7 @@ static int u32_delete(struct tcf_proto *tp, void *arg, bool *last,
 		return -EINVAL;
 	}
 
-	if (ht->refcnt == 1) {
+	if (refcount_dec_if_one(&ht->refcnt)) {
 		u32_destroy_hnode(tp, ht, extack);
 	} else {
 		NL_SET_ERR_MSG_MOD(extack, "Can not delete in-use filter");
@@ -682,7 +682,7 @@ static int u32_delete(struct tcf_proto *tp, void *arg, bool *last,
 	}
 
 out:
-	*last = tp_c->refcnt == 1 && tp_c->knodes == 0;
+	*last = refcount_read(&tp_c->refcnt) == 1 && tp_c->knodes == 0;
 	return ret;
 }
 
@@ -766,14 +766,14 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
 				NL_SET_ERR_MSG_MOD(extack, "Not linking to root node");
 				return -EINVAL;
 			}
-			ht_down->refcnt++;
+			refcount_inc(&ht_down->refcnt);
 		}
 
 		ht_old = rtnl_dereference(n->ht_down);
 		rcu_assign_pointer(n->ht_down, ht_down);
 
 		if (ht_old)
-			ht_old->refcnt--;
+			refcount_dec(&ht_old->refcnt);
 	}
 
 	if (ifindex >= 0)
@@ -852,7 +852,7 @@ static struct tc_u_knode *u32_init_knode(struct net *net, struct tcf_proto *tp,
 
 	/* bump reference count as long as we hold pointer to structure */
 	if (ht)
-		ht->refcnt++;
+		refcount_inc(&ht->refcnt);
 
 	return new;
 }
@@ -932,7 +932,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 
 				ht_old = rtnl_dereference(n->ht_down);
 				if (ht_old)
-					ht_old->refcnt++;
+					refcount_inc(&ht_old->refcnt);
 			}
 			__u32_destroy_key(new);
 			return err;
@@ -980,7 +980,7 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
 				return err;
 			}
 		}
-		ht->refcnt = 1;
+		refcount_set(&ht->refcnt, 1);
 		ht->divisor = divisor;
 		ht->handle = handle;
 		ht->prio = tp->prio;
-- 
2.43.0





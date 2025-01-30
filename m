Return-Path: <stable+bounces-111553-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E405A22FB4
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796D73A2933
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF0E1E9B00;
	Thu, 30 Jan 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XBzjOwh1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8DE1DDC22;
	Thu, 30 Jan 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247072; cv=none; b=XkG4D+P2P4Dbx774reffMraNlSZA5ix2xK8JtiUF/DFEAcvfyZguZEGZtnsdVcngxPZIR62vIN/x3B7boDLz6D0qxjJlXZwKNXXdL5J4KC1IaGqi4C8ipqkW3fTOTY8u30DpVCukyC6jDsJ4HOpJloeCcLveJjp5Z/kjfgmjwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247072; c=relaxed/simple;
	bh=l2HO871PnC/gMzUE6ioSzgQzMWFAm5EvTWNcKz+2g1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CUdbDASeA2iKb6Wl8asrJ/fC9PtTZbObCDnZCcQShGxuEWzWx5d8J5jT2+5FvFhYjsC6aL5WFvQTtl5KC82MuvDlhfg+SmZPs77rl9LJ/PQoBrrpmGOG6GNAGxmszrjrRnVe8lH89VdTllCKSNQBtnWA2y4nEe1J8u2Vig30gzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XBzjOwh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A986DC4CEE0;
	Thu, 30 Jan 2025 14:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738247072;
	bh=l2HO871PnC/gMzUE6ioSzgQzMWFAm5EvTWNcKz+2g1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XBzjOwh1gYYGNmxMq9yCaDpik0iYiOnX/VtMbUHTJP0wW9z5kJsGVkq8xP2ZDeJBU
	 djSKLzXNy7Fac8PlEtHiuaJlaMCPQwl7r/3mWg75pnM1Z/MfdwckosHV/o7Lqp4V31
	 W1h3+tE8vi1bRPSJiI4ezU9kVx3f2vi4cIqPnhPM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yajun Deng <yajun.deng@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 073/133] net: net_namespace: Optimize the code
Date: Thu, 30 Jan 2025 15:01:02 +0100
Message-ID: <20250130140145.455758822@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140142.491490528@linuxfoundation.org>
References: <20250130140142.491490528@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yajun Deng <yajun.deng@linux.dev>

[ Upstream commit 41467d2ff4dfe1837cbb0f45e2088e6e787580c6 ]

There is only one caller for ops_free(), so inline it.
Separate net_drop_ns() and net_free(), so the net_free()
can be called directly.
Add free_exit_list() helper function for free net_exit_list.

====================
v2:
 - v1 does not apply, rebase it.
====================

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 46841c7053e6 ("gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/net_namespace.c | 52 +++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 6192a05ebcce2..ef19a0eaa55aa 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -113,7 +113,7 @@ static int net_assign_generic(struct net *net, unsigned int id, void *data)
 	}
 
 	ng = net_alloc_generic();
-	if (ng == NULL)
+	if (!ng)
 		return -ENOMEM;
 
 	/*
@@ -170,13 +170,6 @@ static int ops_init(const struct pernet_operations *ops, struct net *net)
 	return err;
 }
 
-static void ops_free(const struct pernet_operations *ops, struct net *net)
-{
-	if (ops->id && ops->size) {
-		kfree(net_generic(net, *ops->id));
-	}
-}
-
 static void ops_pre_exit_list(const struct pernet_operations *ops,
 			      struct list_head *net_exit_list)
 {
@@ -208,7 +201,7 @@ static void ops_free_list(const struct pernet_operations *ops,
 	struct net *net;
 	if (ops->size && ops->id) {
 		list_for_each_entry(net, net_exit_list, exit_list)
-			ops_free(ops, net);
+			kfree(net_generic(net, *ops->id));
 	}
 }
 
@@ -454,15 +447,18 @@ static struct net *net_alloc(void)
 
 static void net_free(struct net *net)
 {
-	kfree(rcu_access_pointer(net->gen));
-	kmem_cache_free(net_cachep, net);
+	if (refcount_dec_and_test(&net->passive)) {
+		kfree(rcu_access_pointer(net->gen));
+		kmem_cache_free(net_cachep, net);
+	}
 }
 
 void net_drop_ns(void *p)
 {
-	struct net *ns = p;
-	if (ns && refcount_dec_and_test(&ns->passive))
-		net_free(ns);
+	struct net *net = (struct net *)p;
+
+	if (net)
+		net_free(net);
 }
 
 struct net *copy_net_ns(unsigned long flags,
@@ -502,7 +498,7 @@ struct net *copy_net_ns(unsigned long flags,
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(user_ns);
-		net_drop_ns(net);
+		net_free(net);
 dec_ucounts:
 		dec_net_namespaces(ucounts);
 		return ERR_PTR(rv);
@@ -636,7 +632,7 @@ static void cleanup_net(struct work_struct *work)
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(net->user_ns);
-		net_drop_ns(net);
+		net_free(net);
 	}
 }
 
@@ -1160,6 +1156,14 @@ static int __init net_ns_init(void)
 
 pure_initcall(net_ns_init);
 
+static void free_exit_list(struct pernet_operations *ops, struct list_head *net_exit_list)
+{
+	ops_pre_exit_list(ops, net_exit_list);
+	synchronize_rcu();
+	ops_exit_list(ops, net_exit_list);
+	ops_free_list(ops, net_exit_list);
+}
+
 #ifdef CONFIG_NET_NS
 static int __register_pernet_operations(struct list_head *list,
 					struct pernet_operations *ops)
@@ -1185,10 +1189,7 @@ static int __register_pernet_operations(struct list_head *list,
 out_undo:
 	/* If I have an error cleanup all namespaces I initialized */
 	list_del(&ops->list);
-	ops_pre_exit_list(ops, &net_exit_list);
-	synchronize_rcu();
-	ops_exit_list(ops, &net_exit_list);
-	ops_free_list(ops, &net_exit_list);
+	free_exit_list(ops, &net_exit_list);
 	return error;
 }
 
@@ -1201,10 +1202,8 @@ static void __unregister_pernet_operations(struct pernet_operations *ops)
 	/* See comment in __register_pernet_operations() */
 	for_each_net(net)
 		list_add_tail(&net->exit_list, &net_exit_list);
-	ops_pre_exit_list(ops, &net_exit_list);
-	synchronize_rcu();
-	ops_exit_list(ops, &net_exit_list);
-	ops_free_list(ops, &net_exit_list);
+
+	free_exit_list(ops, &net_exit_list);
 }
 
 #else
@@ -1227,10 +1226,7 @@ static void __unregister_pernet_operations(struct pernet_operations *ops)
 	} else {
 		LIST_HEAD(net_exit_list);
 		list_add(&init_net.exit_list, &net_exit_list);
-		ops_pre_exit_list(ops, &net_exit_list);
-		synchronize_rcu();
-		ops_exit_list(ops, &net_exit_list);
-		ops_free_list(ops, &net_exit_list);
+		free_exit_list(ops, &net_exit_list);
 	}
 }
 
-- 
2.39.5





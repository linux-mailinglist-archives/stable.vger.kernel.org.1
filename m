Return-Path: <stable+bounces-63483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FBE941927
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D913287CEB
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09091A6199;
	Tue, 30 Jul 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KNHFOHjX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D01A616E;
	Tue, 30 Jul 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356974; cv=none; b=eSHPCvU1yDZjDNChdET8ca2IHL2KHhXFmCX8kam6MwQlp72Cb/DGDJLu0zpaW61t7vHql1vHl3wAtTN/QaazZOwujevGbE5V/4dvdit9zL4Vdwh2h3YN0dPD4WJAG9+V2MlZI4qSHcnl/s1P2bliI/s3uKgq+V3CbVglDGpYPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356974; c=relaxed/simple;
	bh=/llFOH5KYFgURQUWgZFlNf3M9pEl31Jfy1Bkxbua3f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrvKxCm0JoH6/nBvUCLDAA+vvJb2svHmnsEKWR9mWrkja4zpa89YEoy1yVEF53CxvC4jTRPX9v3nzvo0I7cpMsbcgyWXTp4PR9Uh5NZ5SDIyJ+7+GD3bmC2kJDdLDqe3Y5ErAd0cYqIajR/cKIUH1B7w4HRFk8OEatu/mmbz5c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KNHFOHjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA68C32782;
	Tue, 30 Jul 2024 16:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722356974;
	bh=/llFOH5KYFgURQUWgZFlNf3M9pEl31Jfy1Bkxbua3f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNHFOHjXjlRUZejLEF8My6Z28jw0W/EJG1n8ChB13oEZ7cJmPfLgGpjpBjnK2HyAt
	 Y207kP1ybPlKWpS2tb74ko3JOGKtGvmh68051vi3gh9vTlWXqjuYcg45j2/eaTtao9
	 Slr0KfRXSAuKk0PPJUXXgIwv9MtnvkLU04IunO/s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 206/809] xfrm: Fix unregister netdevice hang on hardware offload.
Date: Tue, 30 Jul 2024 17:41:22 +0200
Message-ID: <20240730151732.744187839@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit 07b87f9eea0c30675084d50c82532d20168da009 ]

When offloading xfrm states to hardware, the offloading
device is attached to the skbs secpath. If a skb is free
is deferred, an unregister netdevice hangs because the
netdevice is still refcounted.

Fix this by removing the netdevice from the xfrm states
when the netdevice is unregistered. To find all xfrm states
that need to be cleared we add another list where skbs
linked to that are unlinked from the lists (deleted)
but not yet freed.

Fixes: d77e38e612a0 ("xfrm: Add an IPsec hardware offloading API")
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xfrm.h    | 36 +++++++------------------
 net/xfrm/xfrm_state.c | 61 +++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 28 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 77ebf5bcf0b90..7d4c2235252c7 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -178,7 +178,10 @@ struct xfrm_state {
 		struct hlist_node	gclist;
 		struct hlist_node	bydst;
 	};
-	struct hlist_node	bysrc;
+	union {
+		struct hlist_node	dev_gclist;
+		struct hlist_node	bysrc;
+	};
 	struct hlist_node	byspi;
 	struct hlist_node	byseq;
 
@@ -1588,7 +1591,7 @@ void xfrm_state_update_stats(struct net *net);
 static inline void xfrm_dev_state_update_stats(struct xfrm_state *x)
 {
 	struct xfrm_dev_offload *xdo = &x->xso;
-	struct net_device *dev = xdo->dev;
+	struct net_device *dev = READ_ONCE(xdo->dev);
 
 	if (dev && dev->xfrmdev_ops &&
 	    dev->xfrmdev_ops->xdo_dev_state_update_stats)
@@ -1946,13 +1949,16 @@ int xfrm_dev_policy_add(struct net *net, struct xfrm_policy *xp,
 			struct xfrm_user_offload *xuo, u8 dir,
 			struct netlink_ext_ack *extack);
 bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x);
+void xfrm_dev_state_delete(struct xfrm_state *x);
+void xfrm_dev_state_free(struct xfrm_state *x);
 
 static inline void xfrm_dev_state_advance_esn(struct xfrm_state *x)
 {
 	struct xfrm_dev_offload *xso = &x->xso;
+	struct net_device *dev = READ_ONCE(xso->dev);
 
-	if (xso->dev && xso->dev->xfrmdev_ops->xdo_dev_state_advance_esn)
-		xso->dev->xfrmdev_ops->xdo_dev_state_advance_esn(x);
+	if (dev && dev->xfrmdev_ops->xdo_dev_state_advance_esn)
+		dev->xfrmdev_ops->xdo_dev_state_advance_esn(x);
 }
 
 static inline bool xfrm_dst_offload_ok(struct dst_entry *dst)
@@ -1973,28 +1979,6 @@ static inline bool xfrm_dst_offload_ok(struct dst_entry *dst)
 	return false;
 }
 
-static inline void xfrm_dev_state_delete(struct xfrm_state *x)
-{
-	struct xfrm_dev_offload *xso = &x->xso;
-
-	if (xso->dev)
-		xso->dev->xfrmdev_ops->xdo_dev_state_delete(x);
-}
-
-static inline void xfrm_dev_state_free(struct xfrm_state *x)
-{
-	struct xfrm_dev_offload *xso = &x->xso;
-	struct net_device *dev = xso->dev;
-
-	if (dev && dev->xfrmdev_ops) {
-		if (dev->xfrmdev_ops->xdo_dev_state_free)
-			dev->xfrmdev_ops->xdo_dev_state_free(x);
-		xso->dev = NULL;
-		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
-		netdev_put(dev, &xso->dev_tracker);
-	}
-}
-
 static inline void xfrm_dev_policy_delete(struct xfrm_policy *x)
 {
 	struct xfrm_dev_offload *xdo = &x->xdo;
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 649bb739df0dd..d531d2a1fae28 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -49,6 +49,7 @@ static struct kmem_cache *xfrm_state_cache __ro_after_init;
 
 static DECLARE_WORK(xfrm_state_gc_work, xfrm_state_gc_task);
 static HLIST_HEAD(xfrm_state_gc_list);
+static HLIST_HEAD(xfrm_state_dev_gc_list);
 
 static inline bool xfrm_state_hold_rcu(struct xfrm_state __rcu *x)
 {
@@ -214,6 +215,7 @@ static DEFINE_SPINLOCK(xfrm_state_afinfo_lock);
 static struct xfrm_state_afinfo __rcu *xfrm_state_afinfo[NPROTO];
 
 static DEFINE_SPINLOCK(xfrm_state_gc_lock);
+static DEFINE_SPINLOCK(xfrm_state_dev_gc_lock);
 
 int __xfrm_state_delete(struct xfrm_state *x);
 
@@ -683,6 +685,40 @@ struct xfrm_state *xfrm_state_alloc(struct net *net)
 }
 EXPORT_SYMBOL(xfrm_state_alloc);
 
+#ifdef CONFIG_XFRM_OFFLOAD
+void xfrm_dev_state_delete(struct xfrm_state *x)
+{
+	struct xfrm_dev_offload *xso = &x->xso;
+	struct net_device *dev = READ_ONCE(xso->dev);
+
+	if (dev) {
+		dev->xfrmdev_ops->xdo_dev_state_delete(x);
+		spin_lock_bh(&xfrm_state_dev_gc_lock);
+		hlist_add_head(&x->dev_gclist, &xfrm_state_dev_gc_list);
+		spin_unlock_bh(&xfrm_state_dev_gc_lock);
+	}
+}
+
+void xfrm_dev_state_free(struct xfrm_state *x)
+{
+	struct xfrm_dev_offload *xso = &x->xso;
+	struct net_device *dev = READ_ONCE(xso->dev);
+
+	if (dev && dev->xfrmdev_ops) {
+		spin_lock_bh(&xfrm_state_dev_gc_lock);
+		if (!hlist_unhashed(&x->dev_gclist))
+			hlist_del(&x->dev_gclist);
+		spin_unlock_bh(&xfrm_state_dev_gc_lock);
+
+		if (dev->xfrmdev_ops->xdo_dev_state_free)
+			dev->xfrmdev_ops->xdo_dev_state_free(x);
+		WRITE_ONCE(xso->dev, NULL);
+		xso->type = XFRM_DEV_OFFLOAD_UNSPECIFIED;
+		netdev_put(dev, &xso->dev_tracker);
+	}
+}
+#endif
+
 void __xfrm_state_destroy(struct xfrm_state *x, bool sync)
 {
 	WARN_ON(x->km.state != XFRM_STATE_DEAD);
@@ -848,6 +884,9 @@ EXPORT_SYMBOL(xfrm_state_flush);
 
 int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid)
 {
+	struct xfrm_state *x;
+	struct hlist_node *tmp;
+	struct xfrm_dev_offload *xso;
 	int i, err = 0, cnt = 0;
 
 	spin_lock_bh(&net->xfrm.xfrm_state_lock);
@@ -857,8 +896,6 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 
 	err = -ESRCH;
 	for (i = 0; i <= net->xfrm.state_hmask; i++) {
-		struct xfrm_state *x;
-		struct xfrm_dev_offload *xso;
 restart:
 		hlist_for_each_entry(x, net->xfrm.state_bydst+i, bydst) {
 			xso = &x->xso;
@@ -868,6 +905,8 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 				spin_unlock_bh(&net->xfrm.xfrm_state_lock);
 
 				err = xfrm_state_delete(x);
+				xfrm_dev_state_free(x);
+
 				xfrm_audit_state_delete(x, err ? 0 : 1,
 							task_valid);
 				xfrm_state_put(x);
@@ -884,6 +923,24 @@ int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_vali
 
 out:
 	spin_unlock_bh(&net->xfrm.xfrm_state_lock);
+
+	spin_lock_bh(&xfrm_state_dev_gc_lock);
+restart_gc:
+	hlist_for_each_entry_safe(x, tmp, &xfrm_state_dev_gc_list, dev_gclist) {
+		xso = &x->xso;
+
+		if (xso->dev == dev) {
+			spin_unlock_bh(&xfrm_state_dev_gc_lock);
+			xfrm_dev_state_free(x);
+			spin_lock_bh(&xfrm_state_dev_gc_lock);
+			goto restart_gc;
+		}
+
+	}
+	spin_unlock_bh(&xfrm_state_dev_gc_lock);
+
+	xfrm_flush_gc();
+
 	return err;
 }
 EXPORT_SYMBOL(xfrm_dev_state_flush);
-- 
2.43.0





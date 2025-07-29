Return-Path: <stable+bounces-165076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACB6B14F44
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 16:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D4FB3B5BC6
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 14:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51261B4233;
	Tue, 29 Jul 2025 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qOQ4p+jt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE1746E
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799565; cv=none; b=EyCylp0rSJG1Mpl63v9Jjei7prKrHC5EcLysp5MAqO1TsSLwr5JJNexWtqPZ3j+AEGUqhps6DxOUIoWIiulMTzDnc+SMB9B5KOv1H/3bcAbGlXcbgV5P3qQqkdsTVaE0aD3QxE2acv5RR0bdJRLV2CTTICIfFhA/B0NVC67AgUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799565; c=relaxed/simple;
	bh=C2/1+r6WidWDycoxx625S0AH7fZMZ/L3uQpnZ/T07JE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=r3V/RzNZUFmiAAriP2LASplrntQztZhBg9y9mIKmIWc4aqpHs8W31+igOQN8l9a4G5UUAonA1LmhVgv8tB4XBCVqNcTxljGFyne+olgVkbYWl/RE63t81csIFJYmCOW5BzairpqEmFcUTK05MaY1JYXkzWNUYogGDGqOHcOj33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qOQ4p+jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1892C4CEEF;
	Tue, 29 Jul 2025 14:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753799565;
	bh=C2/1+r6WidWDycoxx625S0AH7fZMZ/L3uQpnZ/T07JE=;
	h=Subject:To:Cc:From:Date:From;
	b=qOQ4p+jtEQhBLQ8PKGswgvsqjQTPhFJ7WuAsfooMeRKhnnQUno5SpaKeLX0LX+j5v
	 hk5tP4a8+LB222zJyC1I4vInkadIPBk4XtL/XnZ+IqYKYPImSXaWu+7wLtV13u3oSr
	 HRkGB6kXziUr8PhEu2yUJSm0NK/KEV2FSNw1eJPk=
Subject: FAILED: patch "[PATCH] Revert "xfrm: destroy xfrm_state synchronously on net exit" failed to apply to 5.4-stable tree
To: sd@queasysnail.net,steffen.klassert@secunet.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Jul 2025 16:32:27 +0200
Message-ID: <2025072927-thinly-qualm-24ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 2a198bbec6913ae1c90ec963750003c6213668c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072927-thinly-qualm-24ec@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a198bbec6913ae1c90ec963750003c6213668c7 Mon Sep 17 00:00:00 2001
From: Sabrina Dubroca <sd@queasysnail.net>
Date: Fri, 4 Jul 2025 16:54:34 +0200
Subject: [PATCH] Revert "xfrm: destroy xfrm_state synchronously on net exit
 path"

This reverts commit f75a2804da391571563c4b6b29e7797787332673.

With all states (whether user or kern) removed from the hashtables
during deletion, there's no need for synchronous destruction of
states. xfrm6_tunnel states still need to have been destroyed (which
will be the case when its last user is deleted (not destroyed)) so
that xfrm6_tunnel_free_spi removes it from the per-netns hashtable
before the netns is destroyed.

This has the benefit of skipping one synchronize_rcu per state (in
__xfrm_state_destroy(sync=true)) when we exit a netns.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 91d52a380e37..f3014e4f54fc 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -915,7 +915,7 @@ static inline void xfrm_pols_put(struct xfrm_policy **pols, int npols)
 		xfrm_pol_put(pols[i]);
 }
 
-void __xfrm_state_destroy(struct xfrm_state *, bool);
+void __xfrm_state_destroy(struct xfrm_state *);
 
 static inline void __xfrm_state_put(struct xfrm_state *x)
 {
@@ -925,13 +925,7 @@ static inline void __xfrm_state_put(struct xfrm_state *x)
 static inline void xfrm_state_put(struct xfrm_state *x)
 {
 	if (refcount_dec_and_test(&x->refcnt))
-		__xfrm_state_destroy(x, false);
-}
-
-static inline void xfrm_state_put_sync(struct xfrm_state *x)
-{
-	if (refcount_dec_and_test(&x->refcnt))
-		__xfrm_state_destroy(x, true);
+		__xfrm_state_destroy(x);
 }
 
 static inline void xfrm_state_hold(struct xfrm_state *x)
@@ -1769,7 +1763,7 @@ struct xfrmk_spdinfo {
 
 struct xfrm_state *xfrm_find_acq_byseq(struct net *net, u32 mark, u32 seq, u32 pcpu_num);
 int xfrm_state_delete(struct xfrm_state *x);
-int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync);
+int xfrm_state_flush(struct net *net, u8 proto, bool task_valid);
 int xfrm_dev_state_flush(struct net *net, struct net_device *dev, bool task_valid);
 int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
 			  bool task_valid);
diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
index 7fd8bc08e6eb..5120a763da0d 100644
--- a/net/ipv6/xfrm6_tunnel.c
+++ b/net/ipv6/xfrm6_tunnel.c
@@ -334,7 +334,7 @@ static void __net_exit xfrm6_tunnel_net_exit(struct net *net)
 	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
 	unsigned int i;
 
-	xfrm_state_flush(net, 0, false, true);
+	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
 	xfrm_flush_gc();
 
 	for (i = 0; i < XFRM6_TUNNEL_SPI_BYADDR_HSIZE; i++)
diff --git a/net/key/af_key.c b/net/key/af_key.c
index efc2a91f4c48..b5d761700776 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -1766,7 +1766,7 @@ static int pfkey_flush(struct sock *sk, struct sk_buff *skb, const struct sadb_m
 	if (proto == 0)
 		return -EINVAL;
 
-	err = xfrm_state_flush(net, proto, true, false);
+	err = xfrm_state_flush(net, proto, true);
 	err2 = unicast_flush_resp(sk, hdr);
 	if (err || err2) {
 		if (err == -ESRCH) /* empty table - go quietly */
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index f7110a658897..327a1a6f892c 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -592,7 +592,7 @@ void xfrm_state_free(struct xfrm_state *x)
 }
 EXPORT_SYMBOL(xfrm_state_free);
 
-static void ___xfrm_state_destroy(struct xfrm_state *x)
+static void xfrm_state_gc_destroy(struct xfrm_state *x)
 {
 	if (x->mode_cbs && x->mode_cbs->destroy_state)
 		x->mode_cbs->destroy_state(x);
@@ -631,7 +631,7 @@ static void xfrm_state_gc_task(struct work_struct *work)
 	synchronize_rcu();
 
 	hlist_for_each_entry_safe(x, tmp, &gc_list, gclist)
-		___xfrm_state_destroy(x);
+		xfrm_state_gc_destroy(x);
 }
 
 static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
@@ -795,19 +795,14 @@ void xfrm_dev_state_free(struct xfrm_state *x)
 }
 #endif
 
-void __xfrm_state_destroy(struct xfrm_state *x, bool sync)
+void __xfrm_state_destroy(struct xfrm_state *x)
 {
 	WARN_ON(x->km.state != XFRM_STATE_DEAD);
 
-	if (sync) {
-		synchronize_rcu();
-		___xfrm_state_destroy(x);
-	} else {
-		spin_lock_bh(&xfrm_state_gc_lock);
-		hlist_add_head(&x->gclist, &xfrm_state_gc_list);
-		spin_unlock_bh(&xfrm_state_gc_lock);
-		schedule_work(&xfrm_state_gc_work);
-	}
+	spin_lock_bh(&xfrm_state_gc_lock);
+	hlist_add_head(&x->gclist, &xfrm_state_gc_list);
+	spin_unlock_bh(&xfrm_state_gc_lock);
+	schedule_work(&xfrm_state_gc_work);
 }
 EXPORT_SYMBOL(__xfrm_state_destroy);
 
@@ -922,7 +917,7 @@ xfrm_dev_state_flush_secctx_check(struct net *net, struct net_device *dev, bool
 }
 #endif
 
-int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync)
+int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 {
 	int i, err = 0, cnt = 0;
 
@@ -3283,7 +3278,7 @@ void xfrm_state_fini(struct net *net)
 	unsigned int sz;
 
 	flush_work(&net->xfrm.state_hash_work);
-	xfrm_state_flush(net, 0, false, true);
+	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
 	flush_work(&xfrm_state_gc_work);
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 1db18f470f42..684239018bec 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2635,7 +2635,7 @@ static int xfrm_flush_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct xfrm_usersa_flush *p = nlmsg_data(nlh);
 	int err;
 
-	err = xfrm_state_flush(net, p->proto, true, false);
+	err = xfrm_state_flush(net, p->proto, true);
 	if (err) {
 		if (err == -ESRCH) /* empty table */
 			return 0;



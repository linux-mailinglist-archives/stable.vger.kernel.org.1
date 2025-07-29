Return-Path: <stable+bounces-165146-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0354FB15496
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 23:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 192463ACF7A
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 21:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2E3279917;
	Tue, 29 Jul 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixH1fQSp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A57624DD17
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753823521; cv=none; b=S6Ih7J8faG7yvR+g4FF/sXnYl7T/mXGnHcGjljwNVJ+ZPVk3ZlY9NN/SYYqp/kM8O60w41loBpTOIykzQVVMtYyddbbLtC8Lnr3zkBa/A2ZxuO9RRDaEiqhPmSJQndWBUGoe5Qb0+pJpXakn7DQbTcjHoSGz6J/I5Ikjt+Pn8Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753823521; c=relaxed/simple;
	bh=aDEKQ+QF6+Yq0wpE4iUPhqKXLy709XpES+kfTaGY4nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uFt/fvEkBssjI6QzAKmuVRglbIrSMYiLlg+1N9NwgJc4Rb4VYFgBm2IcfBpTkAmQlkuRzi4WGZWHL72VxM3N4MY+PLrph6zjp1meUJD/DmUlJ/w25/VJG7G+jlSERH7jsH9nd9MPa2H9WaRud1hOuy7M3DKhOe+SX0Ji1ergEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixH1fQSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F389C4CEF7;
	Tue, 29 Jul 2025 21:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753823521;
	bh=aDEKQ+QF6+Yq0wpE4iUPhqKXLy709XpES+kfTaGY4nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ixH1fQSpaiGxfSigCk8YI/Ez7YGprIaJzmOtqxHscC8OI3hTXHKWrsVKr6hsGaUvR
	 /sS+eu20JG7nQh65N1huTRPGwdp6Hkl0O+9PLqxIKEa8MBQRyR4cIxrxIf80Vd4tc4
	 3AT/N03JdMHY9JBFoonjWXLt5kgnRxQZY4T4DwoARwETk21rEH+5R0ItI15jqECL6f
	 p/b0texzjMjFo7RV95Xl6oq5WJDsETCwj0v2QYHINueI1vWLtx6UsmRovp1b+chKK3
	 GUQuGpEw6PVSjmSFHs6t2G3U7LrfG9tS6CfmImPEjRzYBDSTU1uexKc+Yx/x+aif2Q
	 8USI/Wdj9DbCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] Revert "xfrm: destroy xfrm_state synchronously on net exit path"
Date: Tue, 29 Jul 2025 17:11:53 -0400
Message-Id: <20250729211153.2893984-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250729211153.2893984-1-sashal@kernel.org>
References: <2025072924-postbox-exorcism-f636@gregkh>
 <20250729211153.2893984-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 2a198bbec6913ae1c90ec963750003c6213668c7 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/xfrm.h      | 12 +++---------
 net/ipv6/xfrm6_tunnel.c |  2 +-
 net/key/af_key.c        |  2 +-
 net/xfrm/xfrm_state.c   | 23 +++++++++--------------
 net/xfrm/xfrm_user.c    |  2 +-
 5 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index d3bdefdc4a50..8bc9d5c6cb2b 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -850,7 +850,7 @@ static inline void xfrm_pols_put(struct xfrm_policy **pols, int npols)
 		xfrm_pol_put(pols[i]);
 }
 
-void __xfrm_state_destroy(struct xfrm_state *, bool);
+void __xfrm_state_destroy(struct xfrm_state *);
 
 static inline void __xfrm_state_put(struct xfrm_state *x)
 {
@@ -860,13 +860,7 @@ static inline void __xfrm_state_put(struct xfrm_state *x)
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
@@ -1704,7 +1698,7 @@ struct xfrmk_spdinfo {
 
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
index c56bb4f451e6..9dea2b26e506 100644
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
index f791a4f15cee..083e098ae4f9 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -531,7 +531,7 @@ void xfrm_state_free(struct xfrm_state *x)
 }
 EXPORT_SYMBOL(xfrm_state_free);
 
-static void ___xfrm_state_destroy(struct xfrm_state *x)
+static void xfrm_state_gc_destroy(struct xfrm_state *x)
 {
 	hrtimer_cancel(&x->mtimer);
 	del_timer_sync(&x->rtimer);
@@ -569,7 +569,7 @@ static void xfrm_state_gc_task(struct work_struct *work)
 	synchronize_rcu();
 
 	hlist_for_each_entry_safe(x, tmp, &gc_list, gclist)
-		___xfrm_state_destroy(x);
+		xfrm_state_gc_destroy(x);
 }
 
 static enum hrtimer_restart xfrm_timer_handler(struct hrtimer *me)
@@ -732,19 +732,14 @@ void xfrm_dev_state_free(struct xfrm_state *x)
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
 
@@ -859,7 +854,7 @@ xfrm_dev_state_flush_secctx_check(struct net *net, struct net_device *dev, bool
 }
 #endif
 
-int xfrm_state_flush(struct net *net, u8 proto, bool task_valid, bool sync)
+int xfrm_state_flush(struct net *net, u8 proto, bool task_valid)
 {
 	int i, err = 0, cnt = 0;
 
@@ -3204,7 +3199,7 @@ void xfrm_state_fini(struct net *net)
 	unsigned int sz;
 
 	flush_work(&net->xfrm.state_hash_work);
-	xfrm_state_flush(net, 0, false, true);
+	xfrm_state_flush(net, IPSEC_PROTO_ANY, false);
 	flush_work(&xfrm_state_gc_work);
 
 	WARN_ON(!list_empty(&net->xfrm.state_all));
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d41e5642625e..caac78454b54 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -2568,7 +2568,7 @@ static int xfrm_flush_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 	struct xfrm_usersa_flush *p = nlmsg_data(nlh);
 	int err;
 
-	err = xfrm_state_flush(net, p->proto, true, false);
+	err = xfrm_state_flush(net, p->proto, true);
 	if (err) {
 		if (err == -ESRCH) /* empty table */
 			return 0;
-- 
2.39.5



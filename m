Return-Path: <stable+bounces-108528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425ADA0C12C
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 20:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B04B3A49E4
	for <lists+stable@lfdr.de>; Mon, 13 Jan 2025 19:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BDB1B86D5;
	Mon, 13 Jan 2025 19:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJcupsiu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F55F1C5F0B
	for <stable@vger.kernel.org>; Mon, 13 Jan 2025 19:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795842; cv=none; b=Yb0P0lvU6ngBnGP93tmmqOsZYHc6sw3thoZJIA7mj919CkP7fyujZNxahKTlNUimsYD6sfNCHvAzir/s1mjd9nwJuwUE5YsY8ZTRQpWkopg/W/V5QKOP8m5euiIgXCMJSDol6ev24PvbARmeEvGmKC81DAjayeKqkrcMgP+rNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795842; c=relaxed/simple;
	bh=3T5OYywzUAwPBMV1OuBniJk/ZTuvUZqyTf7RfGlfbKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u76BFwai1B8A55vnN+ywX5OYwk8awLnoFEJSGNYKzL8Ts/rARj841nfptYCObrzfHw3xj806EdTQhw00Vmtp1lF0eHilaPohgSY7ukLOlWkrjVxrmoP2lF827jDO1MHK1mDWRHn9cXdV5OCWTNMIbsx9Z3SzDsniIbrSl58OIQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJcupsiu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E11C4CED6;
	Mon, 13 Jan 2025 19:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736795841;
	bh=3T5OYywzUAwPBMV1OuBniJk/ZTuvUZqyTf7RfGlfbKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJcupsiugfo5tYMlXUX0aEpqYuRg5QB184bPmZCDEw3U909jZWQY0stveiLAKB8SR
	 Gb6F7u1C5hKh8yCkP8icsMXXaJrmsQ94tJK9m436PSsdR9cLuDqWi6rJAq4cdEFF+q
	 ve4tPeo4Acs0/Lmr8qcEqoJgKt9szO3MS80aLXojcZIGwlIulhUGzovgzjAFjtPwXG
	 advMAAytX30/aLY0hx1EGxgRiuyGTLK/+43zJr84XFklG1NtpKuny+mhq+l0E2shx5
	 m6+qWqJU6C7FOOPT2A8Hj410GFFAuZjuOXhWOGDw5o0KYuoSpcXuiPXfacCcjce2WQ
	 0gnJAvlPiLFcg==
From: Jakub Kicinski <kuba@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH 6.12.y] netdev: prevent accessing NAPI instances from another namespace
Date: Mon, 13 Jan 2025 11:17:14 -0800
Message-ID: <20250113191714.4036263-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2025011253-citable-monstrous-3ae9@gregkh>
References: <2025011253-citable-monstrous-3ae9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit d1cacd74776895f6435941f86a1130e58f6dd226 ]

The NAPI IDs were not fully exposed to user space prior to the netlink
API, so they were never namespaced. The netlink API must ensure that
at the very least NAPI instance belongs to the same netns as the owner
of the genl sock.

napi_by_id() can become static now, but it needs to move because of
dev_get_by_napi_id().

Cc: stable@vger.kernel.org
Fixes: 1287c1ae0fc2 ("netdev-genl: Support setting per-NAPI config values")
Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Link: https://patch.msgid.link/20250106180137.1861472-1-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c         | 43 +++++++++++++++++++++++++++++-------------
 net/core/dev.h         |  3 ++-
 net/core/netdev-genl.c |  4 +---
 3 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index f3fa8353d262..1867a6a8d76d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -753,6 +753,36 @@ int dev_fill_forward_path(const struct net_device *dev, const u8 *daddr,
 }
 EXPORT_SYMBOL_GPL(dev_fill_forward_path);
 
+/* must be called under rcu_read_lock(), as we dont take a reference */
+static struct napi_struct *napi_by_id(unsigned int napi_id)
+{
+	unsigned int hash = napi_id % HASH_SIZE(napi_hash);
+	struct napi_struct *napi;
+
+	hlist_for_each_entry_rcu(napi, &napi_hash[hash], napi_hash_node)
+		if (napi->napi_id == napi_id)
+			return napi;
+
+	return NULL;
+}
+
+/* must be called under rcu_read_lock(), as we dont take a reference */
+struct napi_struct *netdev_napi_by_id(struct net *net, unsigned int napi_id)
+{
+	struct napi_struct *napi;
+
+	napi = napi_by_id(napi_id);
+	if (!napi)
+		return NULL;
+
+	if (WARN_ON_ONCE(!napi->dev))
+		return NULL;
+	if (!net_eq(net, dev_net(napi->dev)))
+		return NULL;
+
+	return napi;
+}
+
 /**
  *	__dev_get_by_name	- find a device by its name
  *	@net: the applicable net namespace
@@ -6291,19 +6321,6 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 }
 EXPORT_SYMBOL(napi_complete_done);
 
-/* must be called under rcu_read_lock(), as we dont take a reference */
-struct napi_struct *napi_by_id(unsigned int napi_id)
-{
-	unsigned int hash = napi_id % HASH_SIZE(napi_hash);
-	struct napi_struct *napi;
-
-	hlist_for_each_entry_rcu(napi, &napi_hash[hash], napi_hash_node)
-		if (napi->napi_id == napi_id)
-			return napi;
-
-	return NULL;
-}
-
 static void skb_defer_free_flush(struct softnet_data *sd)
 {
 	struct sk_buff *skb, *next;
diff --git a/net/core/dev.h b/net/core/dev.h
index 5654325c5b71..2e3bb7669984 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -22,6 +22,8 @@ struct sd_flow_limit {
 
 extern int netdev_flow_limit_table_len;
 
+struct napi_struct *netdev_napi_by_id(struct net *net, unsigned int napi_id);
+
 #ifdef CONFIG_PROC_FS
 int __init dev_proc_init(void);
 #else
@@ -146,7 +148,6 @@ void xdp_do_check_flushed(struct napi_struct *napi);
 static inline void xdp_do_check_flushed(struct napi_struct *napi) { }
 #endif
 
-struct napi_struct *napi_by_id(unsigned int napi_id);
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 
 #define XMIT_RECURSION_LIMIT	8
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index d58270b48cb2..773bf067e425 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -164,8 +164,6 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	void *hdr;
 	pid_t pid;
 
-	if (WARN_ON_ONCE(!napi->dev))
-		return -EINVAL;
 	if (!(napi->dev->flags & IFF_UP))
 		return 0;
 
@@ -217,7 +215,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 	rtnl_lock();
 	rcu_read_lock();
 
-	napi = napi_by_id(napi_id);
+	napi = netdev_napi_by_id(genl_info_net(info), napi_id);
 	if (napi) {
 		err = netdev_nl_napi_fill_one(rsp, napi, info);
 	} else {
-- 
2.47.1



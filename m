Return-Path: <stable+bounces-107746-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8130A02F63
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 19:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0920C7A0124
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 18:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FE51DF72D;
	Mon,  6 Jan 2025 18:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGxxrFl8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D7D1DF279;
	Mon,  6 Jan 2025 18:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186501; cv=none; b=RbGXBSfyqrFdbrgQpSqUsv8RtMlJ+ZateEPhNGd1SrAc+imn4sCJbKfIVmorTHAy9mfounwCDOIezlYFiwCPgkvrbLz+kjknsqWYTMF6MEnVwcaKNwrQINocxDz7Pd6Xyrkrkb9Sy6QInVL5IWhSqZ8jwddMaDQLoHgnfw7DawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186501; c=relaxed/simple;
	bh=ES3Hn8JKqH4OQ0VaEkExuR3ZULx5S4/3pNmynXMRrPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EEVd4cDuQ6L9Ff38oMwsyHB0NeKx7Idja2gwFQmbyL0EabXvW84NvslQ3gyw45U6/PZGgiKwzxoiM+wEJj5nQ503SfDX7Xm4CgD8GwauZfW4SBY6ldpWV6OWXUVRGq0a6yYqBZkxjpyZ2owgxjN38EG+Xy7zXfH8gjaC+Cd+DEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGxxrFl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520A9C4CEDF;
	Mon,  6 Jan 2025 18:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736186500;
	bh=ES3Hn8JKqH4OQ0VaEkExuR3ZULx5S4/3pNmynXMRrPs=;
	h=From:To:Cc:Subject:Date:From;
	b=fGxxrFl8R37KxmbVgzKKpmGuhUkyNCnpYG2BryOl5k5UbjzcyBNE85NePOwJrgR7k
	 JJpZofyk1u4Ytfzbz4pjIRxo/5NEiYeKtik+n01eFHQRPJiSZhuGxmJvUSOZfCcA7T
	 Q8DGhhczF6wdX2nUdMEt7OfCsZEBOYbCrtAeM2LxBRD5kBDvlsarSFvNaDOImdY34L
	 gUVvsAYJZCOjulaZETfy5G5EdPXSgOiGQ/AEmRMfk3RiOeAB9V86tsvXwKd7EofWj5
	 7GS8c/ml+aw7uAvNTqU9P7fvO0tU3B6faBhv1VskC2AXTTBcoG3MmOMM1YgIVXwnDw
	 pBrB0DBsLLmNw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	stable@vger.kernel.org,
	jdamato@fastly.com,
	almasrymina@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com
Subject: [PATCH net] netdev: prevent accessing NAPI instances from another namespace
Date: Mon,  6 Jan 2025 10:01:36 -0800
Message-ID: <20250106180137.1861472-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NAPI IDs were not fully exposed to user space prior to the netlink
API, so they were never namespaced. The netlink API must ensure that
at the very least NAPI instance belongs to the same netns as the owner
of the genl sock.

napi_by_id() can become static now, but it needs to move because of
dev_get_by_napi_id().

Cc: stable@vger.kernel.org
Fixes: 1287c1ae0fc2 ("netdev-genl: Support setting per-NAPI config values")
Fixes: 27f91aaf49b3 ("netdev-genl: Add netlink framework functions for napi")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Splitting this into fix per-version is a bit tricky, because we need
to replace the napi_by_id() helper with a better one. I'll send the
stable versions manually.

CC: jdamato@fastly.com
CC: almasrymina@google.com
CC: amritha.nambiar@intel.com
CC: sridhar.samudrala@intel.com
---
 net/core/dev.c         | 43 +++++++++++++++++++++++++++++-------------
 net/core/dev.h         |  3 ++-
 net/core/netdev-genl.c |  6 ++----
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7c63d97b13c1..e001df4cb486 100644
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
@@ -6293,19 +6323,6 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
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
index aa91eed55a40..08812a025a9b 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -22,6 +22,8 @@ struct sd_flow_limit {
 
 extern int netdev_flow_limit_table_len;
 
+struct napi_struct *netdev_napi_by_id(struct net *net, unsigned int napi_id);
+
 #ifdef CONFIG_PROC_FS
 int __init dev_proc_init(void);
 #else
@@ -269,7 +271,6 @@ void xdp_do_check_flushed(struct napi_struct *napi);
 static inline void xdp_do_check_flushed(struct napi_struct *napi) { }
 #endif
 
-struct napi_struct *napi_by_id(unsigned int napi_id);
 void kick_defer_list_purge(struct softnet_data *sd, unsigned int cpu);
 
 #define XMIT_RECURSION_LIMIT	8
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 125b660004d3..a3bdaf075b6b 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -167,8 +167,6 @@ netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
 	void *hdr;
 	pid_t pid;
 
-	if (WARN_ON_ONCE(!napi->dev))
-		return -EINVAL;
 	if (!(napi->dev->flags & IFF_UP))
 		return 0;
 
@@ -234,7 +232,7 @@ int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
 	rtnl_lock();
 	rcu_read_lock();
 
-	napi = napi_by_id(napi_id);
+	napi = netdev_napi_by_id(genl_info_net(info), napi_id);
 	if (napi) {
 		err = netdev_nl_napi_fill_one(rsp, napi, info);
 	} else {
@@ -355,7 +353,7 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
 	rtnl_lock();
 	rcu_read_lock();
 
-	napi = napi_by_id(napi_id);
+	napi = netdev_napi_by_id(genl_info_net(info), napi_id);
 	if (napi) {
 		err = netdev_nl_napi_set_config(napi, info);
 	} else {
-- 
2.47.1



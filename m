Return-Path: <stable+bounces-108313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A94C3A0A7ED
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 10:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691137A0756
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1658F17335C;
	Sun, 12 Jan 2025 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YAnvjYad"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F39256D
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736673356; cv=none; b=ADd8bHZTLFo0o0qLaFKlDPBwV6taCF52JkSrmIsixxj66KZ5DRHEbRZ91AFC4bsDLyVOgJucQJaof690WcRKcs86k+tytYlGpFnV1T1vI2P++TpUIz4F02JKbCMtBAXGIeOBQd4qDWLOVzgJolVy93BhU6GS7z3IngpwCt0j00M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736673356; c=relaxed/simple;
	bh=Rgmxnulh2wU0irbCcacDeJDxoRVW3ny2n9XQEZGZH3o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RqLKZwmli5WuBc7+gWCIArfTfVB7wJb+HhgTO2PH0ybfrwiew76vzfux8qQ9i2ntVGYdA4V0vijrJonwrhmUewPJotxBsW2kvdymXcjP3T3fgdDceaPMs4zXwJ55zJQEh2d8c8Gw05wBZqhwl2RhSP9DnE00BReD1LsOEMSreCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YAnvjYad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB99C4CEDF;
	Sun, 12 Jan 2025 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736673356;
	bh=Rgmxnulh2wU0irbCcacDeJDxoRVW3ny2n9XQEZGZH3o=;
	h=Subject:To:Cc:From:Date:From;
	b=YAnvjYadTUY2KbZmw0Vr8gwY0NwVF0qC+lbxnSk57qWN+yZ/i33zfa1mM7pOPkRMB
	 9j/sUYiB52atdtexDtfZVu/krC4J9gJIbpkMnrRUcadfVoAfMTYeHUa0abtv19b/jV
	 DZglmKEopRIS5bQ/xVFGK+rc4HUajphMHZjVAIsU=
Subject: FAILED: patch "[PATCH] netdev: prevent accessing NAPI instances from another" failed to apply to 6.12-stable tree
To: kuba@kernel.org,jdamato@fastly.com,sridhar.samudrala@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 12 Jan 2025 10:15:53 +0100
Message-ID: <2025011253-citable-monstrous-3ae9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d1cacd74776895f6435941f86a1130e58f6dd226
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025011253-citable-monstrous-3ae9@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d1cacd74776895f6435941f86a1130e58f6dd226 Mon Sep 17 00:00:00 2001
From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 6 Jan 2025 10:01:36 -0800
Subject: [PATCH] netdev: prevent accessing NAPI instances from another
 namespace

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

diff --git a/net/core/dev.c b/net/core/dev.c
index faa23042df38..a9f62f5aeb84 100644
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
index d043dee25a68..deb5eae5749f 100644
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



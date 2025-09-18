Return-Path: <stable+bounces-178701-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8655B47FB8
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88A491B2192C
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD526B2AD;
	Sun,  7 Sep 2025 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SCiEqfrS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624A64315A;
	Sun,  7 Sep 2025 20:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757277681; cv=none; b=hi1yTWFzkOlJ0jcbr3QjWo674Is/Rx0/hNIsdsb/DIoIvegb2JAOyuGRpEH54IwKZNRsjyM0NgflmUgMReIbJqINgvQpaM7y8DK/OvyGRa0ihTzScX2tiY9Ndww1RlWkIK1i6pGyXWFu+gXh4wqMkFyKKEs/UwB2dR7CvQVcQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757277681; c=relaxed/simple;
	bh=1e22I0e5Pm7/3wCtdelWSsBv3Dna/vs0JiYJW3WOncc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IO4+65LXVFZc2hk3+aEZBPrM1jEbG90yxFCNkyjG2rnyNznLdKlKRQJxMBZORhVWfGORCiIAZcYr7wJtjirNorpfhG26hKSVSTgwPYdKvx6lqYebHeA6tbSCIkgQR81ukH14g/isQV+7SN3gpSBkIiMt9IhyWgCtTg5PelEEiOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SCiEqfrS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1810C4CEF0;
	Sun,  7 Sep 2025 20:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757277681;
	bh=1e22I0e5Pm7/3wCtdelWSsBv3Dna/vs0JiYJW3WOncc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SCiEqfrSNOjoKKWysQ65qN+BDcojR7kaHcWwtKnQhK0WGtE3cq266CiuKsA5mZ+Xv
	 lOmytM6QAPpPKDWXIqSJ1hHwwTMuNJbyjM4QVosFYPavZ/hcKb2pf2oJD/q5pDvpy0
	 Vim0OZtUnjgH7HTqZDvAYQjmAqpjhXQF4g7H7xQw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Phil Sutter <phil@nwl.cc>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 090/183] netfilter: nf_tables: Introduce NFTA_DEVICE_PREFIX
Date: Sun,  7 Sep 2025 21:58:37 +0200
Message-ID: <20250907195617.926955147@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>
References: <20250907195615.802693401@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 4039ce7ef40474d5ba46f414c50cc7020b9cf8ae ]

This new attribute is supposed to be used instead of NFTA_DEVICE_NAME
for simple wildcard interface specs. It holds a NUL-terminated string
representing an interface name prefix to match on.

While kernel code to distinguish full names from prefixes in
NFTA_DEVICE_NAME is simpler than this solution, reusing the existing
attribute with different semantics leads to confusion between different
versions of kernel and user space though:

* With old kernels, wildcards submitted by user space are accepted yet
  silently treated as regular names.
* With old user space, wildcards submitted by kernel may cause crashes
  since libnftnl expects NUL-termination when there is none.

Using a distinct attribute type sanitizes these situations as the
receiving part detects and rejects the unexpected attribute nested in
*_HOOK_DEVS attributes.

Fixes: 6d07a289504a ("netfilter: nf_tables: Support wildcard netdev hook specs")
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/netfilter/nf_tables_api.c            | 42 +++++++++++++++++-------
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 2beb30be2c5f8..8e0eb832bc01e 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1784,10 +1784,12 @@ enum nft_synproxy_attributes {
  * enum nft_device_attributes - nf_tables device netlink attributes
  *
  * @NFTA_DEVICE_NAME: name of this device (NLA_STRING)
+ * @NFTA_DEVICE_PREFIX: device name prefix, a simple wildcard (NLA_STRING)
  */
 enum nft_devices_attributes {
 	NFTA_DEVICE_UNSPEC,
 	NFTA_DEVICE_NAME,
+	NFTA_DEVICE_PREFIX,
 	__NFTA_DEVICE_MAX
 };
 #define NFTA_DEVICE_MAX		(__NFTA_DEVICE_MAX - 1)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 46ca725d65381..0e86434ca13b0 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1953,6 +1953,18 @@ static int nft_dump_stats(struct sk_buff *skb, struct nft_stats __percpu *stats)
 	return -ENOSPC;
 }
 
+static bool hook_is_prefix(struct nft_hook *hook)
+{
+	return strlen(hook->ifname) >= hook->ifnamelen;
+}
+
+static int nft_nla_put_hook_dev(struct sk_buff *skb, struct nft_hook *hook)
+{
+	int attr = hook_is_prefix(hook) ? NFTA_DEVICE_PREFIX : NFTA_DEVICE_NAME;
+
+	return nla_put_string(skb, attr, hook->ifname);
+}
+
 static int nft_dump_basechain_hook(struct sk_buff *skb,
 				   const struct net *net, int family,
 				   const struct nft_base_chain *basechain,
@@ -1984,16 +1996,15 @@ static int nft_dump_basechain_hook(struct sk_buff *skb,
 			if (!first)
 				first = hook;
 
-			if (nla_put(skb, NFTA_DEVICE_NAME,
-				    hook->ifnamelen, hook->ifname))
+			if (nft_nla_put_hook_dev(skb, hook))
 				goto nla_put_failure;
 			n++;
 		}
 		nla_nest_end(skb, nest_devs);
 
 		if (n == 1 &&
-		    nla_put(skb, NFTA_HOOK_DEV,
-			    first->ifnamelen, first->ifname))
+		    !hook_is_prefix(first) &&
+		    nla_put_string(skb, NFTA_HOOK_DEV, first->ifname))
 			goto nla_put_failure;
 	}
 	nla_nest_end(skb, nest);
@@ -2297,7 +2308,8 @@ void nf_tables_chain_destroy(struct nft_chain *chain)
 }
 
 static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
-					      const struct nlattr *attr)
+					      const struct nlattr *attr,
+					      bool prefix)
 {
 	struct nf_hook_ops *ops;
 	struct net_device *dev;
@@ -2314,7 +2326,8 @@ static struct nft_hook *nft_netdev_hook_alloc(struct net *net,
 	if (err < 0)
 		goto err_hook_free;
 
-	hook->ifnamelen = nla_len(attr);
+	/* include the terminating NUL-char when comparing non-prefixes */
+	hook->ifnamelen = strlen(hook->ifname) + !prefix;
 
 	/* nf_tables_netdev_event() is called under rtnl_mutex, this is
 	 * indirectly serializing all the other holders of the commit_mutex with
@@ -2361,14 +2374,22 @@ static int nf_tables_parse_netdev_hooks(struct net *net,
 	struct nft_hook *hook, *next;
 	const struct nlattr *tmp;
 	int rem, n = 0, err;
+	bool prefix;
 
 	nla_for_each_nested(tmp, attr, rem) {
-		if (nla_type(tmp) != NFTA_DEVICE_NAME) {
+		switch (nla_type(tmp)) {
+		case NFTA_DEVICE_NAME:
+			prefix = false;
+			break;
+		case NFTA_DEVICE_PREFIX:
+			prefix = true;
+			break;
+		default:
 			err = -EINVAL;
 			goto err_hook;
 		}
 
-		hook = nft_netdev_hook_alloc(net, tmp);
+		hook = nft_netdev_hook_alloc(net, tmp, prefix);
 		if (IS_ERR(hook)) {
 			NL_SET_BAD_ATTR(extack, tmp);
 			err = PTR_ERR(hook);
@@ -2414,7 +2435,7 @@ static int nft_chain_parse_netdev(struct net *net, struct nlattr *tb[],
 	int err;
 
 	if (tb[NFTA_HOOK_DEV]) {
-		hook = nft_netdev_hook_alloc(net, tb[NFTA_HOOK_DEV]);
+		hook = nft_netdev_hook_alloc(net, tb[NFTA_HOOK_DEV], false);
 		if (IS_ERR(hook)) {
 			NL_SET_BAD_ATTR(extack, tb[NFTA_HOOK_DEV]);
 			return PTR_ERR(hook);
@@ -9424,8 +9445,7 @@ static int nf_tables_fill_flowtable_info(struct sk_buff *skb, struct net *net,
 
 	list_for_each_entry_rcu(hook, hook_list, list,
 				lockdep_commit_lock_is_held(net)) {
-		if (nla_put(skb, NFTA_DEVICE_NAME,
-			    hook->ifnamelen, hook->ifname))
+		if (nft_nla_put_hook_dev(skb, hook))
 			goto nla_put_failure;
 	}
 	nla_nest_end(skb, nest_devs);
-- 
2.50.1





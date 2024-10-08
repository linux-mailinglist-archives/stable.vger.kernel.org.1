Return-Path: <stable+bounces-81702-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4929948E3
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C6AE282F5A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70F71D26F2;
	Tue,  8 Oct 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0qbLvBOr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9FB1DE8BB;
	Tue,  8 Oct 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728389848; cv=none; b=cXO6uCAXiGDXJ0ktaA1iofhKvKe3bFd664rUDNT6hQzqsiKbGysznH9z1apuCZ/KCX/4H+KG9SsMxoyiq110CK7x5kQcKVlLAxyfeopgs2ZWCAZ9LoZ62UNT7B0rjbBh5NPcyZKB/VMON+2kIiBTpPhzLzvx8n+O+6/T2lEzU68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728389848; c=relaxed/simple;
	bh=WTJFPRt7EgNjksS1pET65rbAEbK16MxY3Q7v421F2OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fx8poXTH31yFKadpEb894lJNbD+cCDr+Rv9NAIvKF2W766CNU8Y75lVpnIAaTwG35b/KNz0K4d7CYIb5Me6cO1GFGaIfRP03dXxbtMYJJOEiqZuSJrtMtOGfPtVh0jyZKz5oFCL1jgNo8ujhBFFhu+NWJzujDXujPG2KOb8cJzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0qbLvBOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53F5C4CEC7;
	Tue,  8 Oct 2024 12:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728389848;
	bh=WTJFPRt7EgNjksS1pET65rbAEbK16MxY3Q7v421F2OI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0qbLvBOrp8rkPT1Nru+8ldgs9LPw/kDFJ6elJPxMR6LAx25gkzcTAvxQtaHbBmxCA
	 YlD2ll53NgOUlMKXI5gq248g7zRAIdBVXg1RCSTr2neQxWNL5a3Fw/+tMLAC/b8Gyd
	 YtdwNhfphn6b1JK8v7uLDxsv8MiqTcUIhGZ1wQCM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 114/482] netpoll: Ensure clean state on setup failures
Date: Tue,  8 Oct 2024 14:02:57 +0200
Message-ID: <20241008115652.794626880@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
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

From: Breno Leitao <leitao@debian.org>

[ Upstream commit ae5a0456e0b4cfd7e61619e55251ffdf1bc7adfb ]

Modify netpoll_setup() and __netpoll_setup() to ensure that the netpoll
structure (np) is left in a clean state if setup fails for any reason.
This prevents carrying over misconfigured fields in case of partial
setup success.

Key changes:
- np->dev is now set only after successful setup, ensuring it's always
  NULL if netpoll is not configured or if netpoll_setup() fails.
- np->local_ip is zeroed if netpoll setup doesn't complete successfully.
- Added DEBUG_NET_WARN_ON_ONCE() checks to catch unexpected states.
- Reordered some operations in __netpoll_setup() for better logical flow.

These changes improve the reliability of netpoll configuration, since it
assures that the structure is fully initialized or totally unset.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20240822111051.179850-2-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/netpoll.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 55bcacf67df3b..e082139004093 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -626,12 +626,9 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 	const struct net_device_ops *ops;
 	int err;
 
-	np->dev = ndev;
-	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
-
 	if (ndev->priv_flags & IFF_DISABLE_NETPOLL) {
 		np_err(np, "%s doesn't support polling, aborting\n",
-		       np->dev_name);
+		       ndev->name);
 		err = -ENOTSUPP;
 		goto out;
 	}
@@ -649,7 +646,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 		refcount_set(&npinfo->refcnt, 1);
 
-		ops = np->dev->netdev_ops;
+		ops = ndev->netdev_ops;
 		if (ops->ndo_netpoll_setup) {
 			err = ops->ndo_netpoll_setup(ndev, npinfo);
 			if (err)
@@ -660,6 +657,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		refcount_inc(&npinfo->refcnt);
 	}
 
+	np->dev = ndev;
+	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
 	npinfo->netpoll = np;
 
 	/* last thing to do is link it to the net device structure */
@@ -677,6 +676,7 @@ EXPORT_SYMBOL_GPL(__netpoll_setup);
 int netpoll_setup(struct netpoll *np)
 {
 	struct net_device *ndev = NULL;
+	bool ip_overwritten = false;
 	struct in_device *in_dev;
 	int err;
 
@@ -741,6 +741,7 @@ int netpoll_setup(struct netpoll *np)
 			}
 
 			np->local_ip.ip = ifa->ifa_local;
+			ip_overwritten = true;
 			np_info(np, "local IP %pI4\n", &np->local_ip.ip);
 		} else {
 #if IS_ENABLED(CONFIG_IPV6)
@@ -757,6 +758,7 @@ int netpoll_setup(struct netpoll *np)
 					    !!(ipv6_addr_type(&np->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
 						continue;
 					np->local_ip.in6 = ifp->addr;
+					ip_overwritten = true;
 					err = 0;
 					break;
 				}
@@ -787,6 +789,9 @@ int netpoll_setup(struct netpoll *np)
 	return 0;
 
 put:
+	DEBUG_NET_WARN_ON_ONCE(np->dev);
+	if (ip_overwritten)
+		memset(&np->local_ip, 0, sizeof(np->local_ip));
 	netdev_put(ndev, &np->dev_tracker);
 unlock:
 	rtnl_unlock();
-- 
2.43.0





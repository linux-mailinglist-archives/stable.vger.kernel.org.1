Return-Path: <stable+bounces-77154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE137985951
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB7128138A
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D490A19F121;
	Wed, 25 Sep 2024 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="spVgSn6o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B719E99D;
	Wed, 25 Sep 2024 11:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264319; cv=none; b=qXM8pP/skOxX3J9ojpV086ROI98wAlRDCPKGtUOpSPHnf6KdXqcLQUx7fidb+55xErIUbE8el/33vRrKQIT6PCSE15YK9V4pyOTzY5ZRm8s3sAgk5MWYltnnQVpL4oI2XComSRyjoHkAtAyC+8l9RXYVmAq89wJKa+t8qvVYWyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264319; c=relaxed/simple;
	bh=5vLw0lE36CRW0d42KeU5Y6tP0n3ToIOt4PYuFdivNFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNdH0hXkdkY8YZJGXbcu8BFzaQeQ1DQiixoHj2ChUGo4OmP6XF739UVRA9O0P/XHHzQUKf0GqgJoPMMw1i4NV6vb7eUVRPYeylrGqdWK4io1eHpmsE++Kj1MaqC95WvjiNx8kuh/oSHWK3VAmj9Qq9/5sVIi4yKMtZXd5l4OogM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=spVgSn6o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65BEC4CEC7;
	Wed, 25 Sep 2024 11:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264319;
	bh=5vLw0lE36CRW0d42KeU5Y6tP0n3ToIOt4PYuFdivNFQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spVgSn6o+svrx+rDpIRtwHBNOuUhelKg3apodRKjiS4w31eLyTxqslIR0kEmMUwj1
	 1R1wDvsHtOV4ZwVSDibpZk6HFvNA6vyYI5hy8Rc1AtD8ha6yJlNI8xiEYRTYvKEMbp
	 NQ5VqJr99yEivYUk0CSgog4WwQdG/sxpDXBsGMkPn3R97ego+RpPB93I+YGNHo66bV
	 NbGcHKw7lD77vdFoBx0qutFNIWMKp1BJL9WvvBAB116iFUHpsbDMBQEgAFJ0bw3HBn
	 YJeugDBWhNabwz2qehF+vjNJsP/tcLl15Z7+upxxL9ykg43JTjjo61VVSqxdPnx7Tg
	 vJ3e777v9S5Qg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 056/244] netpoll: Ensure clean state on setup failures
Date: Wed, 25 Sep 2024 07:24:37 -0400
Message-ID: <20240925113641.1297102-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

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
index d657b042d5a04..930acc87c8c08 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -624,12 +624,9 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
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
@@ -647,7 +644,7 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 
 		refcount_set(&npinfo->refcnt, 1);
 
-		ops = np->dev->netdev_ops;
+		ops = ndev->netdev_ops;
 		if (ops->ndo_netpoll_setup) {
 			err = ops->ndo_netpoll_setup(ndev, npinfo);
 			if (err)
@@ -658,6 +655,8 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
 		refcount_inc(&npinfo->refcnt);
 	}
 
+	np->dev = ndev;
+	strscpy(np->dev_name, ndev->name, IFNAMSIZ);
 	npinfo->netpoll = np;
 
 	/* last thing to do is link it to the net device structure */
@@ -675,6 +674,7 @@ EXPORT_SYMBOL_GPL(__netpoll_setup);
 int netpoll_setup(struct netpoll *np)
 {
 	struct net_device *ndev = NULL;
+	bool ip_overwritten = false;
 	struct in_device *in_dev;
 	int err;
 
@@ -739,6 +739,7 @@ int netpoll_setup(struct netpoll *np)
 			}
 
 			np->local_ip.ip = ifa->ifa_local;
+			ip_overwritten = true;
 			np_info(np, "local IP %pI4\n", &np->local_ip.ip);
 		} else {
 #if IS_ENABLED(CONFIG_IPV6)
@@ -755,6 +756,7 @@ int netpoll_setup(struct netpoll *np)
 					    !!(ipv6_addr_type(&np->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
 						continue;
 					np->local_ip.in6 = ifp->addr;
+					ip_overwritten = true;
 					err = 0;
 					break;
 				}
@@ -785,6 +787,9 @@ int netpoll_setup(struct netpoll *np)
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



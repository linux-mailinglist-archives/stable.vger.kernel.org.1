Return-Path: <stable+bounces-77588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B068985ED9
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D3531C256C4
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DCE21791E;
	Wed, 25 Sep 2024 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pS/avvEO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9FB217915;
	Wed, 25 Sep 2024 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266386; cv=none; b=Q1hRZ70jPjNEASouLl3MMN0mUXUcnYIWqejuWmy+D3QNV5rxAvqSxhB4B89DqvoRRINEiR8xtUenamv4ld8ouxYmOdMH1JBz3sn6ov98ms3pnnzHE/lUE48Ab5xahGd7r0ouX64WDnN/JTSSBixAkqxd+mtfk7Ho19KnwerRURQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266386; c=relaxed/simple;
	bh=lNsX2PUTbrpcPmh4/XGLpB4kD7q++jX5lt21AAe53jE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOaMA1i1BRw0auggqZWAohxxv9+X7mw6Los/HtOlVJ9s5uTyHq+vr3PUcvm/rNAVNLw7RQhIx8kljl6x/VOJ9xeu2yvtvyKX0hj74ZAs75nx5LOGH1Y4DHsR5OxyYwoGZqFWCaYIpSyrFxZ8r98FUvecVG8LogOMUzcgCGxzOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pS/avvEO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCAFC4CEC7;
	Wed, 25 Sep 2024 12:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266386;
	bh=lNsX2PUTbrpcPmh4/XGLpB4kD7q++jX5lt21AAe53jE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pS/avvEOTScCz0juqtOkBYskDkvahkRdDthq2j0LYE2NVq/X0fdomUNheh35UjsOM
	 1pGaTVUVql7OEK4qQS5G29ek0oZMimthX+yZUBiCwmbgIWpyn/SEFcDTo/PcpNnZ+8
	 NYEzk5Z8YKi4V0LNohq1WwMuLSoFx1KQNaGxrQzh84W+Wf8wj6RelxuFOLYLzldzUi
	 LkIti0KfgpKEWghBgqDeHzYGRuBxT3M8ajx6elz1kGda13XNpYmpDMdrmRAb/ICIV4
	 dNIj5GbByvEpbKI9bzKPi/3rxIFO+Cg3unDrFT5A2HA4+acx7pl/3/bOBTctFRKdtC
	 y+6d48Daz70Ew==
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
Subject: [PATCH AUTOSEL 6.6 042/139] netpoll: Ensure clean state on setup failures
Date: Wed, 25 Sep 2024 08:07:42 -0400
Message-ID: <20240925121137.1307574-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
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



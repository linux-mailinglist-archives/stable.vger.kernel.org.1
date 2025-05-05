Return-Path: <stable+bounces-140021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F70AAA3E6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A82E61A8625F
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832A02F94C5;
	Mon,  5 May 2025 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWu7LQ0d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F772857CC;
	Mon,  5 May 2025 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483929; cv=none; b=gpMpXo31T6qkSnYxBpWv3TiQWav9JOE9370uvD/cS+aJ5Z6zlofZhNpIxWc1T+v0OxplRYpp1erq7V9NZZsX3hUItpj/nnZiTgRn7X4+ncny9Rp/fPt178sgSZH4ojVbGC1K88xKjmsN1NsK+rwUfngzPfiBZzpuLLUkES5q7zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483929; c=relaxed/simple;
	bh=vaL5mwua1zaFsHr9MocUj7hGyZB7ywzXaJO0Hoalafk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ev4baBFh2Tn4Lyqnmq9JazGV62ixTn6gBfELGcnkTXfd6kOAul+0H8FbXjXOitkrWAELevBRNdh9aieUu3UddFoK7PpOU6rsJ2pCm1Va880lpcWqFF9D/lhPKak2hvRFvvzVsKHlXk+YyiBQuy6VLBV2/BJgZQ/vz7s1zV8aOp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWu7LQ0d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0622BC4CEEF;
	Mon,  5 May 2025 22:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483929;
	bh=vaL5mwua1zaFsHr9MocUj7hGyZB7ywzXaJO0Hoalafk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RWu7LQ0d2qg+8tvoOv9HFcq6+pV1ZdJwq1atd2LuT+NGbloDtCuT/Ic5oOW7pGckt
	 VBizY+3xyJ91nSH/cXAP1w9tAXFkuc8RJ3q3A9HRMUGfRK2jBPVF0SeGUX6QzYUUco
	 IvTadXAcMOrRAOCRxyBnvmR92cQ1JePDL47bFND6SBkwE2Av1Md7otMel6kedkuLpz
	 Tde+87svggO8vIONTNf5jG+CBlZD3CvVUGy32G3nTxiBP4qQIDiUGgNvLs3tkuggMh
	 AhCMzDkozPUisYPOGVdSGQsh0zK0WlFmyhXEytXokVJwijlfQVzYPZytok8v/7lOtQ
	 8iEhWTmllaN2g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 274/642] ipv4: fib: Hold rtnl_net_lock() in ip_rt_ioctl().
Date: Mon,  5 May 2025 18:08:10 -0400
Message-Id: <20250505221419.2672473-274-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit c0ebe1cdc2cff0dee092a67f2c50377bb5fcf43d ]

ioctl(SIOCADDRT/SIOCDELRT) calls ip_rt_ioctl() to add/remove a route in
the netns of the specified socket.

Let's hold rtnl_net_lock() there.

Note that rtentry_to_fib_config() can be called without rtnl_net_lock()
if we convert rtentry.dev handling to RCU later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Link: https://patch.msgid.link/20250228042328.96624-11-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fib_frontend.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 493c37ce232d3..8470e259d8fd8 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -553,18 +553,16 @@ static int rtentry_to_fib_config(struct net *net, int cmd, struct rtentry *rt,
 			const struct in_ifaddr *ifa;
 			struct in_device *in_dev;
 
-			in_dev = __in_dev_get_rtnl(dev);
+			in_dev = __in_dev_get_rtnl_net(dev);
 			if (!in_dev)
 				return -ENODEV;
 
 			*colon = ':';
 
-			rcu_read_lock();
-			in_dev_for_each_ifa_rcu(ifa, in_dev) {
+			in_dev_for_each_ifa_rtnl_net(net, ifa, in_dev) {
 				if (strcmp(ifa->ifa_label, devname) == 0)
 					break;
 			}
-			rcu_read_unlock();
 
 			if (!ifa)
 				return -ENODEV;
@@ -635,7 +633,7 @@ int ip_rt_ioctl(struct net *net, unsigned int cmd, struct rtentry *rt)
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
 
-		rtnl_lock();
+		rtnl_net_lock(net);
 		err = rtentry_to_fib_config(net, cmd, rt, &cfg);
 		if (err == 0) {
 			struct fib_table *tb;
@@ -659,7 +657,7 @@ int ip_rt_ioctl(struct net *net, unsigned int cmd, struct rtentry *rt)
 			/* allocated by rtentry_to_fib_config() */
 			kfree(cfg.fc_mx);
 		}
-		rtnl_unlock();
+		rtnl_net_unlock(net);
 		return err;
 	}
 	return -EINVAL;
-- 
2.39.5



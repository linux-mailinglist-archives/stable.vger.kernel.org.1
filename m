Return-Path: <stable+bounces-62059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D85893E27F
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14CA61F21ADB
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D5478C7F;
	Sun, 28 Jul 2024 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTeDtkhc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C6BEAD2;
	Sun, 28 Jul 2024 00:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128030; cv=none; b=JFWGAJci4vkB6JFjuP06n6MRX+KfiWDjtICnnyFAt2ArWhsL+U/w/cf0c7hViXGIq9hTMiyMQOhJ61U1/dKtRn5CX8Rw3wmwZjuv4/t4iuDA9HCHq10Ok3BRChOqCYH2UaTZH2yeVMGhyNN29S4V0FOBlHhxksL7cSYlcdhBB5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128030; c=relaxed/simple;
	bh=220QbrQmsHmdXgmCsAxaHI4BJouRP2PaaSJOV5ITXJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Te/VAMe3mYbC9ZkLztdcWPMtSHw9FlYTvI05HAF1pY5zH0/aJQM/vnXrucbYhZtHXL7BZSaQpNS9KRmKG1M6Zts+EsUsMXQ6LO3hbGMHNijpjlVApqeGShyWDSUFzg7zyyHaUqooYJLXoRp7dzqOn14xGcc4QOBBZ7r1B+nxJXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTeDtkhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5109CC32781;
	Sun, 28 Jul 2024 00:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128030;
	bh=220QbrQmsHmdXgmCsAxaHI4BJouRP2PaaSJOV5ITXJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pTeDtkhcRXt6YAfG7uWOh52EE11O3rcVGkjHMBu+F3N4/mmUUPEsqo4SZ/tS+oc7O
	 P45kBVwJdwrdftQpJXWHPiBBI34LIImuhwC7sEuEt8TjSHmhpuaJw+NA7hlDePoyaW
	 /EYgXmgNT+GaWdvZVbR4KNv/KcGp9iSX2riP1o933zNAaQvUD+iTj1SU+Mhn6Fv5iA
	 yNy3uHGpN2xAxpzz6dBGAtokOKXBcrHMzDM5eTpYxPGZXK6imp3REKxPW5KvErDl38
	 zIUtQgg7Dg5LQ4IeHkbKKrQrZcVE289qgs9zbbWmN5o78EwZS6G4w93PguzFZvZyMM
	 jETex9CYPk+9g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	pabeni@redhat.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	amcohen@nvidia.com,
	horms@kernel.org,
	lirongqing@baidu.com,
	juntong.deng@outlook.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 08/27] rtnetlink: move rtnl_lock handling out of af_netlink
Date: Sat, 27 Jul 2024 20:52:51 -0400
Message-ID: <20240728005329.1723272-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 5380d64f8d766576ac5c0f627418b2d0e1d2641f ]

Now that we have an intermediate layer of code for handling
rtnl-level netlink dump quirks, we can move the rtnl_lock
taking there.

For dump handlers with RTNL_FLAG_DUMP_SPLIT_NLM_DONE we can
avoid taking rtnl_lock just to generate NLM_DONE, once again.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/rtnetlink.c     | 9 +++++++--
 net/netlink/af_netlink.c | 2 --
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 4668d67180407..eabfc8290f5e2 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6486,6 +6486,7 @@ static int rtnl_mdb_del(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 static int rtnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 {
+	const bool needs_lock = !(cb->flags & RTNL_FLAG_DUMP_UNLOCKED);
 	rtnl_dumpit_func dumpit = cb->data;
 	int err;
 
@@ -6495,7 +6496,11 @@ static int rtnl_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 	if (!dumpit)
 		return 0;
 
+	if (needs_lock)
+		rtnl_lock();
 	err = dumpit(skb, cb);
+	if (needs_lock)
+		rtnl_unlock();
 
 	/* Old dump handlers used to send NLM_DONE as in a separate recvmsg().
 	 * Some applications which parse netlink manually depend on this.
@@ -6515,7 +6520,8 @@ static int rtnetlink_dump_start(struct sock *ssk, struct sk_buff *skb,
 				const struct nlmsghdr *nlh,
 				struct netlink_dump_control *control)
 {
-	if (control->flags & RTNL_FLAG_DUMP_SPLIT_NLM_DONE) {
+	if (control->flags & RTNL_FLAG_DUMP_SPLIT_NLM_DONE ||
+	    !(control->flags & RTNL_FLAG_DUMP_UNLOCKED)) {
 		WARN_ON(control->data);
 		control->data = control->dump;
 		control->dump = rtnl_dumpit;
@@ -6703,7 +6709,6 @@ static int __net_init rtnetlink_net_init(struct net *net)
 	struct netlink_kernel_cfg cfg = {
 		.groups		= RTNLGRP_MAX,
 		.input		= rtnetlink_rcv,
-		.cb_mutex	= &rtnl_mutex,
 		.flags		= NL_CFG_F_NONROOT_RECV,
 		.bind		= rtnetlink_bind,
 	};
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index fa9c090cf629e..8bbbe75e75dbe 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2330,8 +2330,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 
 		cb->extack = &extack;
 
-		if (cb->flags & RTNL_FLAG_DUMP_UNLOCKED)
-			extra_mutex = NULL;
 		if (extra_mutex)
 			mutex_lock(extra_mutex);
 		nlk->dump_done_errno = cb->dump(skb, cb);
-- 
2.43.0



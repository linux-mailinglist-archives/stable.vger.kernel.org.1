Return-Path: <stable+bounces-140882-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB5EAAAFA8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:21:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EECA73A5365
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEB32FC10D;
	Mon,  5 May 2025 23:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QigJ9k5q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623242F1553;
	Mon,  5 May 2025 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486745; cv=none; b=s2tolm/OQVpTDbdTOk9yLxTBJSLnVsqfRl8/LdCj/+zN97Jcx9KLHl6F4bXSZkjMnC4+8Bgz1E2DM/mDIaQT+J/JqhEpItSkBIy0zuen1F2/W/jrB1TQ+UdlFjSYs6VSjsbvycBphvkimeSJWKFnIMC/HohyiA4172nJjes9klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486745; c=relaxed/simple;
	bh=1iAwpExQ0pLsNJ5i+j+9eFH8gGqdDp6OsXzfHS0ofUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HI4aKxvI5cvYvUCi9YCK5ZfZ3LKNQF0BXMw6SUlbQvU6pKaJx6T7RkFXg8fDbGUwV6wUXAMPMR09YJnEYLA+ZJr1u6WItYfEfThJFfuo+xTJeNdLGDUwfDRoQ4ZAn3vJUJDsistT/4SMV7zWL+msUe8uC0T1UAA8CfMKfpK0Y0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QigJ9k5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7C3C4CEED;
	Mon,  5 May 2025 23:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486743;
	bh=1iAwpExQ0pLsNJ5i+j+9eFH8gGqdDp6OsXzfHS0ofUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QigJ9k5qurmwiF2MjeDsoB67FX/nLlCA7dtBPPGaYulr/O5UiQ1LXW0O1v5Xy8tuq
	 LuDTmE7CLXZB7sZn5jGhbT9fY6FgtFwfT9ODqZeik166MVUFx5EBXWhQVtni1BsGFZ
	 Gwo0blellPuuByCo55QUFAMLcw/mxK4vLRXCQ9bpgB0krf+yTMtCC8Y3WxC2iJdugl
	 Vb/ezcVhL2lxlg7jBmzwzzidS839u1jqCMKGk6Cydt9sPPzsaoWRbgPhH/zIl9eyF3
	 7NqRyB/6z5ogScptPO8gASdqh1/lgiXfBCZpWFnT6Wjf+mGOpevDsKd07ZEy+ncqva
	 Y+PTTsLMUfcUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 180/212] ip: fib_rules: Fetch net from fib_rule in fib[46]_rule_configure().
Date: Mon,  5 May 2025 19:05:52 -0400
Message-Id: <20250505230624.2692522-180-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 5a1ccffd30a08f5a2428cd5fbb3ab03e8eb6c66d ]

The following patch will not set skb->sk from VRF path.

Let's fetch net from fib_rule->fr_net instead of sock_net(skb->sk)
in fib[46]_rule_configure().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://patch.msgid.link/20250207072502.87775-5-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/fib_rules.c  | 4 ++--
 net/ipv6/fib6_rules.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 513f475c6a534..298a9944a3d1e 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -222,9 +222,9 @@ static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 			       struct nlattr **tb,
 			       struct netlink_ext_ack *extack)
 {
-	struct net *net = sock_net(skb->sk);
+	struct fib4_rule *rule4 = (struct fib4_rule *)rule;
+	struct net *net = rule->fr_net;
 	int err = -EINVAL;
-	struct fib4_rule *rule4 = (struct fib4_rule *) rule;
 
 	if (!inet_validate_dscp(frh->tos)) {
 		NL_SET_ERR_MSG(extack,
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 6eeab21512ba9..e0f0c5f8cccda 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -350,9 +350,9 @@ static int fib6_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 			       struct nlattr **tb,
 			       struct netlink_ext_ack *extack)
 {
+	struct fib6_rule *rule6 = (struct fib6_rule *)rule;
+	struct net *net = rule->fr_net;
 	int err = -EINVAL;
-	struct net *net = sock_net(skb->sk);
-	struct fib6_rule *rule6 = (struct fib6_rule *) rule;
 
 	if (!inet_validate_dscp(frh->tos)) {
 		NL_SET_ERR_MSG(extack,
-- 
2.39.5



Return-Path: <stable+bounces-141035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2134AAAD77
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16ED4A1CA6
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2EA3F1563;
	Mon,  5 May 2025 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="us2Fncd2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4513B5B5F;
	Mon,  5 May 2025 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487280; cv=none; b=AfuyG0w35HxKZx+m0havpYVQDjU5Mf3YavX5i5RAvVdW9ic2O1MqqvYQJTDL+iyofZEupHlmLkDcn/j1GlLJuwkj/vKHMkuRUcBNspLqBr3ySlukWcDqHnBAnnF/qO90S/wrOC3Gz/yAa0eB6fkU6A0CMkUEaJ42tqnEhJOSmDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487280; c=relaxed/simple;
	bh=Jx4qvGcPOrBYb8FpQiMhZO8yKo4tpF233BxSMQOtssM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=boaEv25iJKK2l6/HrwIGKdehD6BYwuR6+9F4eAnOwjFloD1vP9sSV8sr2rAI/DM6TabClcIzn+3wsb/tRGhF99uArXfNgEfcbX6ZG4Pl6Z+ioG7tyAQRgySpsie+4JWzOAKnwUZStPEy9jSDcT1+i87KVknatpFuWYSc9odlCbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=us2Fncd2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D995C4CEE4;
	Mon,  5 May 2025 23:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487280;
	bh=Jx4qvGcPOrBYb8FpQiMhZO8yKo4tpF233BxSMQOtssM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=us2Fncd2uist1oA+6eE5/KQDi8fWhWS9TAxwVp3Ss1oxaj5f6hhPJBUO4bvIJb9EM
	 ca6uexe+FwjYnaXJZpQ77Fv525ORC47aLTIgLx94zxSKq01AXzUgCib1uzrHomLiiV
	 6lZiQpKU0qPS4s1rFFo41nlazAcyI+KTF5bI9OleG+YcTUgune/HNluWmpfSQSEVbR
	 2HZkt0N5g6KlXqjnhoHisrAnCNpo5WJ0O2TDwTFXgWRn7MTA4M1rnfNax2stcrYsaC
	 Cx6TYdwHzfvnQm+ITqcuWqAPtigP7EdztWuIWub+gr0jeJwn0v0QqIpssPpCtCwP9k
	 8h9liUA99zMBQ==
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
Subject: [PATCH AUTOSEL 5.10 096/114] ip: fib_rules: Fetch net from fib_rule in fib[46]_rule_configure().
Date: Mon,  5 May 2025 19:17:59 -0400
Message-Id: <20250505231817.2697367-96-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index d279cb8ac1584..a270951386e19 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -226,9 +226,9 @@ static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 			       struct nlattr **tb,
 			       struct netlink_ext_ack *extack)
 {
-	struct net *net = sock_net(skb->sk);
+	struct fib4_rule *rule4 = (struct fib4_rule *)rule;
+	struct net *net = rule->fr_net;
 	int err = -EINVAL;
-	struct fib4_rule *rule4 = (struct fib4_rule *) rule;
 
 	if (frh->tos & ~IPTOS_TOS_MASK) {
 		NL_SET_ERR_MSG(extack, "Invalid tos");
diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index cf9a44fb8243d..0d4e82744921f 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -353,9 +353,9 @@ static int fib6_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 			       struct nlattr **tb,
 			       struct netlink_ext_ack *extack)
 {
+	struct fib6_rule *rule6 = (struct fib6_rule *)rule;
+	struct net *net = rule->fr_net;
 	int err = -EINVAL;
-	struct net *net = sock_net(skb->sk);
-	struct fib6_rule *rule6 = (struct fib6_rule *) rule;
 
 	if (rule->action == FR_ACT_TO_TBL && !rule->l3mdev) {
 		if (rule->table == RT6_TABLE_UNSPEC) {
-- 
2.39.5



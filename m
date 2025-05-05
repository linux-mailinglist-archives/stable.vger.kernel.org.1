Return-Path: <stable+bounces-140786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2308AAAF58
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A4255A4E8F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3BB272E73;
	Mon,  5 May 2025 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LMe6qjPO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3C837AACA;
	Mon,  5 May 2025 23:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486294; cv=none; b=XPLBOWcrPfU7n3+I94QEuGcIAqNb3pretxRcY34+ipRwx7BVIQZr4sXUiQ3zdr7IC6nhu4gVzMW85chwIRP6a4ijhC7st/RzSCKDvAssNINqCmpGqQ88PsXuYLWSb1K3FkDgiafbP3RvgTK3iKEjkCij7B9OdKedduysYBMg0J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486294; c=relaxed/simple;
	bh=1iAwpExQ0pLsNJ5i+j+9eFH8gGqdDp6OsXzfHS0ofUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kcGY7w1Bd+n0kCLc9J2t73341nAd9ZjCmtdstXJ/pos7HVC5LUswIocyCdH54CdRn6Jf1HQ3qrEyv7TLqUuiT4KmMJDSNpdukhhWV6lmxs6FARtUM6B2xIcckC7nBqCsIem6SYbzPVK6Ns36wdxqfCQZ+2KjoZP22YiwvgIEgTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LMe6qjPO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69E8C4CEEF;
	Mon,  5 May 2025 23:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486293;
	bh=1iAwpExQ0pLsNJ5i+j+9eFH8gGqdDp6OsXzfHS0ofUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LMe6qjPO4TWvB/rKatS0YLQEDjQPo9VVx53HL6GyjLfMmM6lZbeodt+8g4Y8pv9Zl
	 HLwys2z6MlUNPAiKHRWHmPNQLVy3WOMKpLtINNWV9dIcZgtgUZS5aq/UypG50BsEcO
	 i5sZ8s1ZqMGpQzifNJvK1cJ+wPSdlXf0az3OuTUqp0tHIDm/5UUg1/pff4AnKw/zgE
	 AxwTwKsN30szMBuwmi6JCAKXP8dYTvymiEzfY9qVS1jpz3dl6RoBiSS0JPNLjeTx84
	 DYV40V2FRDf2MiZEovLiMibkS5M9HA/wToO98nWaysk0fOywr/VR107enNaa5gMZ0Q
	 EyAhuJa4WmCeA==
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
Subject: [PATCH AUTOSEL 6.6 242/294] ip: fib_rules: Fetch net from fib_rule in fib[46]_rule_configure().
Date: Mon,  5 May 2025 18:55:42 -0400
Message-Id: <20250505225634.2688578-242-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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



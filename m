Return-Path: <stable+bounces-141259-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71EFAAB1FD
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EBA51BC6544
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EAD41C4B8;
	Tue,  6 May 2025 00:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkprhr/v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4152D47C0;
	Mon,  5 May 2025 22:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485634; cv=none; b=BpW5dAoGgi6oIg4TXv4b3gYfV+ZbaLCHq1dmqmtm85kF6FU3fo6JmsK85vm+Mtu3dPfW/FHwPFrKbmgoBIGC6FlCAofwuzfbAM8sGH4T5yhoJ5gL0Lp0HiGjHBscNuGfbtSDFlcG7whGxle39Rd2fQq7sAd2jzXbi+fItFVQmFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485634; c=relaxed/simple;
	bh=vpVCrx5nNJhB9WQlEaVF67UnU5UuL0+CmJrcNGgWHYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iW3V6I/DNr27TnGeiqx6FE1XAucyWeiYP2e/IXDxSXW8aafByZE4AuotXRL8whsVDa6VC1QatgnOHvjYM9BU4QrfPDI4HxoMTg8kUyxFNMYXtjTqEhwNDyWUpGsgDFUvo9bcdQeDOZl7j3i0xyqqSIWmFKLZskO+zG2zWCnGWko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkprhr/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D06FC4CEE4;
	Mon,  5 May 2025 22:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485634;
	bh=vpVCrx5nNJhB9WQlEaVF67UnU5UuL0+CmJrcNGgWHYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bkprhr/vWrwQVPCkyxLvCWdwiaDGYLDJRKbPgYET9tnp1rLHkOjSjlocW8hLuxRRd
	 fKmVMER3Ll/94ffLzrl8n0jDekwNkTy3+DxcPRkxUUH9JRfsCZoCIkdDmx/bIQ5Jrf
	 AXFYQcux4ulgJp1PAzubVdCXlmKLwT/g4XyO0HZD7PLZlqjIQDX1Za7PxXVlSceJhy
	 nUkpU+kSNhmQ5S2tfYra2R36sIZwHFQRJNNMn0GEM+BmD/bxQJFurPuRuxb6gfNeFK
	 f9VYaunSj8Vt9pNU0AO/KmC6tYmV+xIo9nJWXxf4TWwU515RkE534TyaG594r28RnJ
	 SCGevEhTRXgrw==
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
Subject: [PATCH AUTOSEL 6.12 397/486] ip: fib_rules: Fetch net from fib_rule in fib[46]_rule_configure().
Date: Mon,  5 May 2025 18:37:53 -0400
Message-Id: <20250505223922.2682012-397-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index b07292d50ee76..4563e5303c1a8 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -245,9 +245,9 @@ static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
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
index 04a9ed5e8310f..29185c9ebd020 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -365,9 +365,9 @@ static int fib6_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
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



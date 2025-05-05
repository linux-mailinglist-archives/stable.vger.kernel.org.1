Return-Path: <stable+bounces-141656-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9A2AAB7D4
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 08:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B6593AA294
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028063A8C11;
	Tue,  6 May 2025 00:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4C04EPw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25328283FF8;
	Mon,  5 May 2025 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487054; cv=none; b=Rvgc93zJPss48MU/q8CfoAhPArf1ohMS4jLb//SZg3Vi80jnkYoXJcB3aj0Qnyh8LQVLKHhm7BaPn9UzS70/3YdmTtJ0Uqi9tK1d94EMSYGtUxtplWo5wImJVnDnOaBtpRTq47J9RjQSo4M8Ty3bBtJZsmcn1pDiD5+kv/cneTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487054; c=relaxed/simple;
	bh=uT80sxbl6B+ZeUHW0YvOEWt/MlAlBh772vVW+fxhIfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iL6bGyPoTjT2erl7B8N7pUPjBWsWNzY8W6bwnPdLACu+I1NRNIBEG+z+IK1dyOZj+6DEwyZhrDvTrq9d0UR75bDBwfCKPc3ZdPPoZEcG9TkTr08+b0DS5+Fw5iMOuhlTUN8levvPMqHPaT2bfIEGNkXWPI2iYgj6Q6AzZODUitU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4C04EPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D237BC4CEEF;
	Mon,  5 May 2025 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487054;
	bh=uT80sxbl6B+ZeUHW0YvOEWt/MlAlBh772vVW+fxhIfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R4C04EPwh6CaRfim7CKv1QDyt4teMfzVop1lK6gtQLN0LqvZd1QlXbEh70EgLWlP0
	 G6D38KCSSHJj7MaS8sDlw/KcLMlO/ciueEUVie2ZS4IzHVT8p6O1PN5sbixCLYz0jp
	 4p+AO7NgAM0YVWLRM45GXN5cgtYbEbA9mHZ+G/+eeQjMHJ7ng0LxZWt70HZ6/CbXRq
	 e6r1H3P0UVas/hYE3EiRXtfwM9yG9WRC5h0W+xTPhMLRnaUfWwpO1b8p1QQ1OqkEf2
	 TdMoTnSEoGzAUL1sC15m/6YUE5D17Z99d311WHiBsVBiMWjzDPQps+sI7l+Ibw3l5f
	 jpEbS09EdKQWw==
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
Subject: [PATCH AUTOSEL 5.15 129/153] ip: fib_rules: Fetch net from fib_rule in fib[46]_rule_configure().
Date: Mon,  5 May 2025 19:12:56 -0400
Message-Id: <20250505231320.2695319-129-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index a4caaead74c1d..a20ef3ab059ca 100644
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



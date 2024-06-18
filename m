Return-Path: <stable+bounces-52853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB0090CF02
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766732819E4
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A431E1BE253;
	Tue, 18 Jun 2024 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qW+ZRN0V"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7EC1BE24C;
	Tue, 18 Jun 2024 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714611; cv=none; b=VAzS6R6tZGoHmaqsPU+ngWXbTeFxVhHXU2b2AbKP4TCIJ108m0yCw0iqfceL0pmO+JQStlQ8pdCOuA5qZM/0ZzQhvPrHX4aAlg85V6C8CTa/TCRruIwGvUADW2SfSjOWpkwqAA+cQTzLci2pkrxxElzsVRT/L6gZxkHRBlvNEQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714611; c=relaxed/simple;
	bh=5omyRClCkTdS8MIQwGuerjGj7Gg1hN8AhaFWJi9Oszg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqUWh2R0dH148y4nOLxkBLmu4tu16UF0vy8m1wWfJguKmFykdMEaDv6tuKGotTeKpiH9eBeMzXpkHpVj8MsV4peeQIYRQXp3U7AntzuowwKSZ2hxd7naQeWjtS8hUk0KTNwxE0tbhlQHAORVbUTqtZghCTvLZSIYPwBGwbsORBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qW+ZRN0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457E8C4AF1D;
	Tue, 18 Jun 2024 12:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714611;
	bh=5omyRClCkTdS8MIQwGuerjGj7Gg1hN8AhaFWJi9Oszg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qW+ZRN0V73cXmNfI7hG+ElTr0fJTLg1ZOCxRJrmyzN1wmVV7OJgscm9fo2ROtkzNA
	 T4p6+Bq85rYm3UFT1JXxyoYinIvlIOptJed/Z24RmJS7CrxwACbO+1IpGUCB/Z59nn
	 lMfa1GT6fvU2HxE13gDQbPg47v4B/F2ZymCw+6LjQgr77QY400DM0r3kreMwNgV/DH
	 r04SJncB6f9eUzI1zCBq30+0sofSpTkS/oIx05KH5LBSaZ47jtjvB9LdOujxQXt3fJ
	 z04lAEfmAHg1Rd1FqF9n/UZAjFe8Hwtd3pefD0evwF1Shl15Sls5RAbeMdc04KJtLF
	 lU+/Zq8yAtqLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	dsahern@kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 7/9] ila: block BH in ila_output()
Date: Tue, 18 Jun 2024 08:43:13 -0400
Message-ID: <20240618124318.3304798-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124318.3304798-1-sashal@kernel.org>
References: <20240618124318.3304798-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.316
Content-Transfer-Encoding: 8bit

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit cf28ff8e4c02e1ffa850755288ac954b6ff0db8c ]

As explained in commit 1378817486d6 ("tipc: block BH
before using dst_cache"), net/core/dst_cache.c
helpers need to be called with BH disabled.

ila_output() is called from lwtunnel_output()
possibly from process context, and under rcu_read_lock().

We might be interrupted by a softirq, re-enter ila_output()
and corrupt dst_cache data structures.

Fix the race by using local_bh_disable().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Link: https://lore.kernel.org/r/20240531132636.2637995-5-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ila/ila_lwt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index 3d56a2fb6f86f..c7630776bd8e8 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -58,7 +58,9 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		return orig_dst->lwtstate->orig_output(net, sk, skb);
 	}
 
+	local_bh_disable();
 	dst = dst_cache_get(&ilwt->dst_cache);
+	local_bh_enable();
 	if (unlikely(!dst)) {
 		struct ipv6hdr *ip6h = ipv6_hdr(skb);
 		struct flowi6 fl6;
@@ -86,8 +88,11 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			goto drop;
 		}
 
-		if (ilwt->connected)
+		if (ilwt->connected) {
+			local_bh_disable();
 			dst_cache_set_ip6(&ilwt->dst_cache, dst, &fl6.saddr);
+			local_bh_enable();
+		}
 	}
 
 	skb_dst_set(skb, dst);
-- 
2.43.0



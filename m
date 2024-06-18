Return-Path: <stable+bounces-52707-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D84A190CC3B
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 14:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAFAC1C22B66
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 12:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC99F15ECD5;
	Tue, 18 Jun 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eukuJcKR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFEA139584;
	Tue, 18 Jun 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714255; cv=none; b=QrdQ7hYzpCdylNpYjxAygOPUfd2YjGPYh0D/s2yNvL/aM2DBVSxYWRgCxCaBt21P7EshMcTfwNonhwrzD7El3pHQ7c7QnuGdzHD1kPKEIkkQSpiyjUlZELhGgILQMieYwexgvsji/voL0288mZKQHNujJ8OXLRvxQzqQiAqfaD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714255; c=relaxed/simple;
	bh=yHfu11Q0TNfcdwLLbOwG08ojnZJ5W0mmaAwpwYhmZxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN7oZFnvbeF5cG4kdV0OTtzzNPp4lsFc2zHfVJLVzJ7zbxg6+HzCAvfkaVxHC5vTGRTLv04AyYnc9XsqtyCBKhk2NY7TCDV+CfUFH8cdObjXvQJOxSFLpUGelF7JkylqapxcFyih7PF/hIvRjKMpYZ60DVvTTaigqtHQZ5kZLsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eukuJcKR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F070C3277B;
	Tue, 18 Jun 2024 12:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714255;
	bh=yHfu11Q0TNfcdwLLbOwG08ojnZJ5W0mmaAwpwYhmZxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eukuJcKRqx1CM4R7adnbj4WElmKUMBcy5rAz1OEsVGw6Vj4UMSmYsyU3NUOZtu0ag
	 GMpVR+vCtSqqp47suQWJaXIWbJB8xyNAQMI6zUGXBOI9JKUShFVibPnGw1CssLJ4Y3
	 4TcBcNkIbBRRpA/qFFHxDPsvUDc6ueK4x46iXiAvYoKcls/C/1rm8n6UzEEm2khltY
	 XznZdJ+rzDEM6qWKD6CIvoyMq8Gybe2zybIq6vKyWrIkragnj0kUrmqFFyC8ha4hcY
	 xSrIgxuk69zDUadrlShv5Jb1ZDgXpaTy7eWrVx6XlVSyI7xJjJS744cA8vlf+W5kKq
	 JvIrHtZQpwySQ==
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
Subject: [PATCH AUTOSEL 6.9 35/44] ila: block BH in ila_output()
Date: Tue, 18 Jun 2024 08:35:16 -0400
Message-ID: <20240618123611.3301370-35-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618123611.3301370-1-sashal@kernel.org>
References: <20240618123611.3301370-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.5
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
index 0601bad798221..ff7e734e335b0 100644
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



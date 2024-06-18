Return-Path: <stable+bounces-52837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 106E090CECA
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 15:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29031C225D8
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 13:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296E51BBBC1;
	Tue, 18 Jun 2024 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm6Y8Bpz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5BA1BB6BA;
	Tue, 18 Jun 2024 12:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718714592; cv=none; b=P4GnzmRgRzIHEOOaZjSyPUuQUuMS1bPAWWAK5d0kToKwNEDxNX3MQZBW+IZy5cFOanG9Iz4Yl2TAXANYfcM4zHlucUG5wTTh36za+6M08m4VYHIweklmVCl8MwgsJcdeHJM5w51YrY33pFq7YNP841pLaM062v739sfiPfUG4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718714592; c=relaxed/simple;
	bh=zo7vGdQmD/9WW6TxmkLYuuXaSiAwi6gfF0+dfbpj6Xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZr3/zi1jdtK599VbESpPpbpGorug5BlGEpxkZ4KXzh8TcMdYXCy0wKp8hzOP+LEcGoOr88WmKmCx+fommbdfKTVB9HnBx6g9YHATPlQ4YbIV36ONgKmOIHoH9OItjZ8VAxM2Yhtw3dl1HGSMsW6Hu+hSabc7h7raXAhRLIM4Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm6Y8Bpz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DCA4C4AF48;
	Tue, 18 Jun 2024 12:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718714592;
	bh=zo7vGdQmD/9WW6TxmkLYuuXaSiAwi6gfF0+dfbpj6Xo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qm6Y8Bpzoilj/zAN8qbrWCfojTFqHvO3uLvBRFtZL5t23F9GRytz/Nbh4UyYJoshr
	 rmA8ncNynLpJFT1Poz9OQ8sNI0gydQc4tsC2UCtDBDOh1n+tzIiTHTKL1UurlAuLCs
	 vlcESK01CvDg0gc+2DAVpZv/w/QRUXNKp7gZhy+TtzUaQk7hf6v+hCAu5c54ObdGh9
	 EhSlfBsVyM+CEBJ05TUsvurS5Uq/naC63PurpZ7bO5QoXqNZA3QcQJCM45E/KbWLWF
	 QZY+nM3Q9Qtw3lkB5IzIFecrJlUYcav/pwN6cGmKKixoySKd571iGBgHFPi//zNauk
	 24CODnO05q7RQ==
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
Subject: [PATCH AUTOSEL 5.4 7/9] ila: block BH in ila_output()
Date: Tue, 18 Jun 2024 08:42:55 -0400
Message-ID: <20240618124300.3304600-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618124300.3304600-1-sashal@kernel.org>
References: <20240618124300.3304600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.278
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
index 422dcc691f71c..6a6a30e82810d 100644
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



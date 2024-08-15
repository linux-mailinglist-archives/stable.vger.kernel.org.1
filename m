Return-Path: <stable+bounces-68569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB7A9532FB
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8DA81F219B6
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5DA1BA86F;
	Thu, 15 Aug 2024 14:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DkS43OHV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEED71AE845;
	Thu, 15 Aug 2024 14:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723730981; cv=none; b=ZQtnWNmhD/DP9VxhsUPInZctjm9a6qT1p47prBCWqzueu8f4B1XGNQiH3C491TNu+jd4/GyUEB36C0wCfzD3ioYT+dzlBOuAAFY6E7I9mRJs2pR0ZvHKiY+49jAmMJDImNlUQeKGcnOeDDkCmbtT2P6Jb7DpUXE/zNhIiblJ74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723730981; c=relaxed/simple;
	bh=WfQ6OM/c4fRM14tyuFfXmJM8Vgke2heQIGWREKRP/Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bzaszW5WLyVOyTvQWV1hhaoT1a1NakYw/M/Qeq0fEBrHjRSqdI0BJnTcmb36XiHDB0UOzb3wzf8efTF7L/Wj7NHv1VxOvAFAIUdGPldHIB+za3Vo2eD8N4UaRzQq0Wy6zBTDOkLMDGMSFZisJfC1dp9oqPq76UyU70oZX7Qfvyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DkS43OHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE11C32786;
	Thu, 15 Aug 2024 14:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723730981;
	bh=WfQ6OM/c4fRM14tyuFfXmJM8Vgke2heQIGWREKRP/Ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DkS43OHVsJgjMNK655OMSv5zqWug/AHPajqt8UB1eQrlDSvOl8W2sm3DUh3BJwFio
	 wx6+/+0AyF4yNJVLTuvS7s+cp/VAccRlbj5g/Yv2YsDeYJ2woGD9+zUHCjRMgdx+7p
	 6H/B71eVv2XqZsxNNf2umsCpyD5YcH3+339R4axI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Dumazet <edumazet@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 22/67] tcp_metrics: optimize tcp_metrics_flush_all()
Date: Thu, 15 Aug 2024 15:25:36 +0200
Message-ID: <20240815131839.187896571@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131838.311442229@linuxfoundation.org>
References: <20240815131838.311442229@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 6532e257aa73645e28dee5b2232cc3c88be62083 ]

This is inspired by several syzbot reports where
tcp_metrics_flush_all() was seen in the traces.

We can avoid acquiring tcp_metrics_lock for empty buckets,
and we should add one cond_resched() to break potential long loops.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Acked-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_metrics.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index b71f94a5932ac..e0883ba709b0b 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -899,11 +899,13 @@ static void tcp_metrics_flush_all(struct net *net)
 	unsigned int row;
 
 	for (row = 0; row < max_rows; row++, hb++) {
-		struct tcp_metrics_block __rcu **pp;
+		struct tcp_metrics_block __rcu **pp = &hb->chain;
 		bool match;
 
+		if (!rcu_access_pointer(*pp))
+			continue;
+
 		spin_lock_bh(&tcp_metrics_lock);
-		pp = &hb->chain;
 		for (tm = deref_locked(*pp); tm; tm = deref_locked(*pp)) {
 			match = net ? net_eq(tm_net(tm), net) :
 				!refcount_read(&tm_net(tm)->ns.count);
@@ -915,6 +917,7 @@ static void tcp_metrics_flush_all(struct net *net)
 			}
 		}
 		spin_unlock_bh(&tcp_metrics_lock);
+		cond_resched();
 	}
 }
 
-- 
2.43.0





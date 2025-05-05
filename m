Return-Path: <stable+bounces-140124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B19FAAAA556
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8070F188A768
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B77930E6BE;
	Mon,  5 May 2025 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn8QAsw8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CE630E6B1;
	Mon,  5 May 2025 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484152; cv=none; b=j+fFAizPDrLSMhtQY+mMuMHBjmJgMQAOV25RCUuYyRY/OZm3iD9i6xbS7nkVjVteP19hm19abr/TTFpoFoko7qNuExIK7QEtDk4/KjMWxgzpEyXZF56iP7va+C+jNHddhy7gGiHSav42gQYqOAGxGxj0E6WTQeC+wHLzKwj+xA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484152; c=relaxed/simple;
	bh=r6VXBcWjshKf1m4KMAmkgbvWe2sqBZuqnd8Fi77EXpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kgJCLplYyArQuS3PNTbRh86oig5WVz+Jf6uhNCs8Hd80u2iB+92D3IuppG7FWQAKRAjExI00J7PecFauumYIRV4dX5k/HuVY78MmyP2mQcmjQXa+X3ohZ4Wj7XRKYlQg8d9DcSlnSAWCPHQ7Y9UL8eIfSh9rN6s1Aw92sqtbnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn8QAsw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CEBC4CEEE;
	Mon,  5 May 2025 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484152;
	bh=r6VXBcWjshKf1m4KMAmkgbvWe2sqBZuqnd8Fi77EXpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fn8QAsw85vF1WggtSBXeh7EUeIT/QbFJinFeI9WtAMlBBVKHyFLVi5Gsqew2m+CAK
	 YV7uAzChV2roFbg+ufc0qgtRsIMkXyRTTa4IctAxa+ZkZbnH+xR3rRvFRi6/2r8GG8
	 daVkRbkmIuVLfg15S6YLWur+s2GulnQFRsnbIIwWH2plEqXUz7mxnIVECAb+O5FYvD
	 Nb4Cfix9bc73uhOqtvczd+5u4cqu+kw9+DUmx1qB+/y5ebSpfZkmAmy4nGTz5iutc6
	 BqDSb8vK74Rl2ThSAaDSU0J4mfZ8gzMeKGHwezG2d74wiqq6q8P9I1zfkr5E4rEuQg
	 oHCF6u1emQ9eQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 377/642] netdevsim: call napi_schedule from a timer context
Date: Mon,  5 May 2025 18:09:53 -0400
Message-Id: <20250505221419.2672473-377-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Breno Leitao <leitao@debian.org>

[ Upstream commit bf3624cf1c3708284c53ed99a1c43f2e104dc2dd ]

The netdevsim driver was experiencing NOHZ tick-stop errors during packet
transmission due to pending softirq work when calling napi_schedule().
This issue was observed when running the netconsole selftest, which
triggered the following error message:

  NOHZ tick-stop error: local softirq work is pending, handler #08!!!

To fix this issue, introduce a timer that schedules napi_schedule()
from a timer context instead of calling it directly from the TX path.

Create an hrtimer for each queue and kick it from the TX path,
which then schedules napi_schedule() from the timer context.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://patch.msgid.link/20250219-netdevsim-v3-1-811e2b8abc4c@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/netdevsim/netdev.c    | 21 ++++++++++++++++++++-
 drivers/net/netdevsim/netdevsim.h |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 42f247cbdceec..e4c0d77849b82 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -87,7 +87,8 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (unlikely(nsim_forward_skb(peer_dev, skb, rq) == NET_RX_DROP))
 		goto out_drop_cnt;
 
-	napi_schedule(&rq->napi);
+	if (!hrtimer_active(&rq->napi_timer))
+		hrtimer_start(&rq->napi_timer, us_to_ktime(5), HRTIMER_MODE_REL);
 
 	rcu_read_unlock();
 	u64_stats_update_begin(&ns->syncp);
@@ -426,6 +427,22 @@ static int nsim_init_napi(struct netdevsim *ns)
 	return err;
 }
 
+static enum hrtimer_restart nsim_napi_schedule(struct hrtimer *timer)
+{
+	struct nsim_rq *rq;
+
+	rq = container_of(timer, struct nsim_rq, napi_timer);
+	napi_schedule(&rq->napi);
+
+	return HRTIMER_NORESTART;
+}
+
+static void nsim_rq_timer_init(struct nsim_rq *rq)
+{
+	hrtimer_init(&rq->napi_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	rq->napi_timer.function = nsim_napi_schedule;
+}
+
 static void nsim_enable_napi(struct netdevsim *ns)
 {
 	struct net_device *dev = ns->netdev;
@@ -615,11 +632,13 @@ static struct nsim_rq *nsim_queue_alloc(void)
 		return NULL;
 
 	skb_queue_head_init(&rq->skb_queue);
+	nsim_rq_timer_init(rq);
 	return rq;
 }
 
 static void nsim_queue_free(struct nsim_rq *rq)
 {
+	hrtimer_cancel(&rq->napi_timer);
 	skb_queue_purge_reason(&rq->skb_queue, SKB_DROP_REASON_QUEUE_PURGE);
 	kfree(rq);
 }
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 96d54c08043d3..e757f85ed8617 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -97,6 +97,7 @@ struct nsim_rq {
 	struct napi_struct napi;
 	struct sk_buff_head skb_queue;
 	struct page_pool *page_pool;
+	struct hrtimer napi_timer;
 };
 
 struct netdevsim {
-- 
2.39.5



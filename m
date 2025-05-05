Return-Path: <stable+bounces-140298-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC87AAA73D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76E8E16EC96
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCF43351F6;
	Mon,  5 May 2025 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DuYj5twa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D53351EC;
	Mon,  5 May 2025 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484588; cv=none; b=PvBQyobmVkX0/y6LlEfHnlvTQONQe8xE79uxQatXYzpkuFOYQ367YBGLqKBpHAkvDPyqxOGr+CNtPycg/KujKaHbLrKapb5TcDrcPUhxnp78sUR6WtkjQaBi82VbX9CRZlkUjMT7AtkpiI6Aq5R6A394qywnmpNPuAWYLATwE0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484588; c=relaxed/simple;
	bh=draOwFBFNcaHflDS1pe0L0aBvAHCvnEuSOQlYQwhciM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rRXheogDXeCC0LeRs1qeDf/1IjlQcg8nODSHtBLe3czF3EZk1eX1zVcFHyODzXH3+MaTAYNdSG71iiM+r7mhms6u/3TGWZclC+nLAG3FM8D5zhiuSqwI6PIaC1tZa3pAYfrITGhNe9xUhh/HwEn/kt7/cOw62w8os0sv5BWcxkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DuYj5twa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66328C4CEE4;
	Mon,  5 May 2025 22:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484588;
	bh=draOwFBFNcaHflDS1pe0L0aBvAHCvnEuSOQlYQwhciM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DuYj5twaY3PlydW/IfIq+JHmScaG86jXKjplAn+q+1QtYKt1GNJEB9Pf3wOHQfccq
	 eMOKzMf32h9ZGEZP4/BHvkqNnYJ4bNTZUkLlEtPJmlGgdrl53XBjAE9DOcVhFra2zv
	 2orpserAH4TcZy3ksJ1Z6z7zQIlSYNlaSXb/5P9FyuSy8ZeqiUI//D6ouHFKO/BSRc
	 z0OkjLC9GzH6TbYMnYx3NfN8eIE+HVBwXBfq4qhGpk+POGOTMtR6funTSIRpgwUC4p
	 noH1ZvLfB9H0SQgvusaEb1ul7w7zfct6gs7cxaCwS/gW1cEj8xO0ae3DYEUMtc4ihR
	 Haw7odDn9LHgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	sdf@fomichev.me,
	ahmed.zaki@intel.com,
	aleksander.lobakin@intel.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 550/642] net: flush_backlog() small changes
Date: Mon,  5 May 2025 18:12:46 -0400
Message-Id: <20250505221419.2672473-550-sashal@kernel.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit cbe08724c18078564abefbf6591078a7c98e5e0f ]

Add READ_ONCE() around reads of skb->dev->reg_state, because
this field can be changed from other threads/cpus.

Instead of calling dev_kfree_skb_irq() and kfree_skb()
while interrupts are masked and locks held,
use a temporary list and use __skb_queue_purge_reason()

Use SKB_DROP_REASON_DEV_READY drop reason to better
describe why these skbs are dropped.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Link: https://patch.msgid.link/20250204144825.316785-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 2f7f5fd9ffec7..77306b522966c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6187,16 +6187,18 @@ EXPORT_SYMBOL(netif_receive_skb_list);
 static void flush_backlog(struct work_struct *work)
 {
 	struct sk_buff *skb, *tmp;
+	struct sk_buff_head list;
 	struct softnet_data *sd;
 
+	__skb_queue_head_init(&list);
 	local_bh_disable();
 	sd = this_cpu_ptr(&softnet_data);
 
 	backlog_lock_irq_disable(sd);
 	skb_queue_walk_safe(&sd->input_pkt_queue, skb, tmp) {
-		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
+		if (READ_ONCE(skb->dev->reg_state) == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->input_pkt_queue);
-			dev_kfree_skb_irq(skb);
+			__skb_queue_tail(&list, skb);
 			rps_input_queue_head_incr(sd);
 		}
 	}
@@ -6204,14 +6206,16 @@ static void flush_backlog(struct work_struct *work)
 
 	local_lock_nested_bh(&softnet_data.process_queue_bh_lock);
 	skb_queue_walk_safe(&sd->process_queue, skb, tmp) {
-		if (skb->dev->reg_state == NETREG_UNREGISTERING) {
+		if (READ_ONCE(skb->dev->reg_state) == NETREG_UNREGISTERING) {
 			__skb_unlink(skb, &sd->process_queue);
-			kfree_skb(skb);
+			__skb_queue_tail(&list, skb);
 			rps_input_queue_head_incr(sd);
 		}
 	}
 	local_unlock_nested_bh(&softnet_data.process_queue_bh_lock);
 	local_bh_enable();
+
+	__skb_queue_purge_reason(&list, SKB_DROP_REASON_DEV_READY);
 }
 
 static bool flush_required(int cpu)
-- 
2.39.5



Return-Path: <stable+bounces-141288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF752AAB257
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C20B3AC615
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAF92D5CFD;
	Tue,  6 May 2025 00:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t/ThmBnN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395701474B8;
	Mon,  5 May 2025 22:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485689; cv=none; b=FVibT3rZT1KA+32GSELJOkgb+RrDPMv323EazPXFBEzieXC3tDxWWtvd8uVfcSp6uGzzVQHyeoUbARMN+p5pWoNXnUwA24myWr3DZ32UgXC6dQCjmMBmMVtrkWExODj6+rs5Hb+Q8FIBWD7Wy4l/va+eFlRscQNv83lGUKry/1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485689; c=relaxed/simple;
	bh=VVgmndga1VaSEzVBYDI4b53/Gvrf7qNKSw0GXrRXzHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CsFfwWa4o2q3em2csac4GgIwReQeAh4EMSnK2jcm19ypuu8EneLN2KKbBOsbiHCtJv1f7mJgVPwka28nqKzwqAm+suqb6tGdOYGbGXli7JTJ4LzAf2MuBAWRT4E2I8/CUC021UWgbMbSAFV3YJqy/rMr13SWbe/oajoLYeNezbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t/ThmBnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03F1C4CEE4;
	Mon,  5 May 2025 22:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485689;
	bh=VVgmndga1VaSEzVBYDI4b53/Gvrf7qNKSw0GXrRXzHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t/ThmBnNDUPoAHYVD/lJUO+OihvSVYG5+UN7EcP9Pr03i2irSnUNO2r/GRYF5lgPK
	 JQbPJvdeS4K8JvJ4i001Rh/iTItO72aV2a6FSNM/wh04saVqIDG1sN0uUd9ca6URO7
	 WrnvoDIlIQBGmgpAssBLEPN2TGb3BWP3jTLVA0NWa6o2XS1Epu8OPB4q+nywKU2Xt9
	 BQibEC6FjovilEvbzs9nAFG4xSgdvDhRId0iYa+PHYHcU4sGa7E9dpZcDzbgHr/zJi
	 7LTPhMA8/qj6TrWD3BoN9YZWl8ExH/la9DVn/ED5KrvFkgafhpqOtZT650IsKk1HIb
	 6o0gVekAfpemg==
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
Subject: [PATCH AUTOSEL 6.12 427/486] net: flush_backlog() small changes
Date: Mon,  5 May 2025 18:38:23 -0400
Message-Id: <20250505223922.2682012-427-sashal@kernel.org>
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
index 7b7b36c43c82c..2ba2160dd093a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6034,16 +6034,18 @@ static DEFINE_PER_CPU(struct work_struct, flush_works);
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
@@ -6051,14 +6053,16 @@ static void flush_backlog(struct work_struct *work)
 
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



Return-Path: <stable+bounces-105166-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DC59F6763
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 14:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6049F165B61
	for <lists+stable@lfdr.de>; Wed, 18 Dec 2024 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803E01EE7C6;
	Wed, 18 Dec 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MPxc0dho"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908961D5CE5
	for <stable@vger.kernel.org>; Wed, 18 Dec 2024 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734528874; cv=none; b=GwEWDAUGyNn0TfhKodiHs5f9nf8Mdbk374uz0NrFZ9F5YIj/f2UzKvRaMJDwanh1qA766GxWSJyZs622gFxynMYuRn+E5U8FK35zJWg5dWNfkpLTSpIGbbTHVf0soNotXG/8WUkeT71B78zXto0DIKXtgEQdrO7sxz0lVE1w87o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734528874; c=relaxed/simple;
	bh=u3ksI8X3LHlmnWlWNsr7oSVKMPEqKsRuUTAg+bTe+00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hdsPTiDSgmZJxvZVT9HOLWnZJWDZm71Oq2xBJ3mfezZzp9zIepm1MdRZKGVjQPLpywHNf1B6o/wGRpg28bIISnov8TekAVu951OALWy1ZiDl2Ss6kl/5rzUwPuqFgGD1aRde3Rts1yQMlKVwFasvCovm3tWUUw2sJqIdQjs/NJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MPxc0dho; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pkaligineedi.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-21632eacb31so44351255ad.0
        for <stable@vger.kernel.org>; Wed, 18 Dec 2024 05:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734528872; x=1735133672; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YwlRUX1jaF5zrf3pwivF6X+hM80Z5phrYRTqYk/3DoI=;
        b=MPxc0dhofPFnXcILg06kG+YRGWPh4xf2Jay20u120zc0dKqN9UxHQ7AMA81rLhgXmb
         ZVqMkn/rIzJH0nSIiQQ3z+EjssO0gXN7iV27NaPDEAJCFAuRmo/JRJqgBG9KLyoExo/J
         zfXhn4kVlf4usRO89FOZIN7PrUnA0Ef20z6MIkhYvZFnQ/OutucxOUuFF1ilYZXAxC34
         lOzOXJIZHHK6HRghsVoS79wZ4NEyWdcvCla3Bi3YeSb4PjzpTZslTx3cvvuIbCnWzR0c
         Y0pOr28Q+UKFULWe+0RbB/OS42OZ9BYI/7vy6OIBWu27DNVF2zOg8iZpVEGPpDiH1wVJ
         X1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734528872; x=1735133672;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YwlRUX1jaF5zrf3pwivF6X+hM80Z5phrYRTqYk/3DoI=;
        b=l6njVLxn1QfKfxkMrzeKIK7E3y2BFcM0xMld8DtFyDnIJUkwj9/O/HnnMjVSEaSRgh
         X+DM2Y7WkWBHBQ5d8KXFpLZUyFro8GnEK8jxyM8ONnO12xaPjDUg1EFdpJbRIQ79U6c1
         a1YnkIMo8uEm8jfj/du67REOloTL7hK/C9xY44Ry37Uj4z4vUI8N26KBTB6qb0yuOqoZ
         jp+vmBD399EKOym3bTm8iJtZ2v2x7JFus7dc1zROwfvoBt5PpZgD2+f6OO3gz1CS3cAH
         7TCwXic3oE1Az7m71JIFIUds3fB/6ESJlu60i4nt+XsWVni8m9oMb3XWuNBP2AMmMSNH
         +jBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaQ4/sz4wFwvIiH3eqyauqQj8zWY/1ac6NhBxEAToBlSrpcTwuWEzj09vx1uWVLYpQEtTJTP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTL2FAfae535UbPAPGpUDEd10SrmHWvL6DqJHr0AfwNA5C3NmP
	4532AoC/RwULAAQSRdqplN6FJJF5S55zffRLzRsrw7vDS5mB9U70PncrV+L504ATDr9zaUfZTAW
	VmcZLZe3xoVVqnRA/3TfeU2JJLQ==
X-Google-Smtp-Source: AGHT+IGoZ3BfldQRegdOBvsvUntzPVMpURPuoWRCP2EtNiBtWfT4ejOfM4mqohMkYW+FU9E8z71bR23/h0c1KA2OAKc=
X-Received: from pgid5.prod.google.com ([2002:a63:ed05:0:b0:7fd:5437:9912])
 (user=pkaligineedi job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dac6:b0:216:1ec6:9888 with SMTP id d9443c01a7336-218d72368afmr37261205ad.33.1734528871967;
 Wed, 18 Dec 2024 05:34:31 -0800 (PST)
Date: Wed, 18 Dec 2024 05:34:14 -0800
In-Reply-To: <20241218133415.3759501-1-pkaligineedi@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241218133415.3759501-1-pkaligineedi@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241218133415.3759501-5-pkaligineedi@google.com>
Subject: [PATCH net 4/5] gve: process XSK TX descriptors as part of RX NAPI
From: Praveen Kaligineedi <pkaligineedi@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, shailend@google.com, willemb@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net, 
	hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	hramamurthy@google.com, joshwash@google.com, ziweixiao@google.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

When busy polling is enabled, xsk_sendmsg for AF_XDP zero copy marks
the NAPI ID corresponding to the memory pool allocated for the socket.
In GVE, this NAPI ID will never correspond to a NAPI ID of one of the
dedicated XDP TX queues registered with the umem because XDP TX is not
set up to share a NAPI with a corresponding RX queue.

This patch moves XSK TX descriptor processing from the TX NAPI to the RX
NAPI, and the gve_xsk_wakeup callback is updated to use the RX NAPI
instead of the TX NAPI, accordingly. The branch on if the wakeup is for
TX is removed, as the NAPI poll should be invoked whether the wakeup is
for TX or for RX.

Fixes: fd8e40321a12 ("gve: Add AF_XDP zero-copy support for GQI-QPL format")
Cc: stable@vger.kernel.org
Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h      |  1 +
 drivers/net/ethernet/google/gve/gve_main.c |  8 +++++
 drivers/net/ethernet/google/gve/gve_tx.c   | 36 +++++++++++++---------
 3 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index dd92949bb214..8167cc5fb0df 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -1140,6 +1140,7 @@ int gve_xdp_xmit_one(struct gve_priv *priv, struct gve_tx_ring *tx,
 void gve_xdp_tx_flush(struct gve_priv *priv, u32 xdp_qid);
 bool gve_tx_poll(struct gve_notify_block *block, int budget);
 bool gve_xdp_poll(struct gve_notify_block *block, int budget);
+int gve_xsk_tx_poll(struct gve_notify_block *block, int budget);
 int gve_tx_alloc_rings_gqi(struct gve_priv *priv,
 			   struct gve_tx_alloc_rings_cfg *cfg);
 void gve_tx_free_rings_gqi(struct gve_priv *priv,
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index e4e8ff4f9f80..5cab7b88610f 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -333,6 +333,14 @@ int gve_napi_poll(struct napi_struct *napi, int budget)
 
 	if (block->rx) {
 		work_done = gve_rx_poll(block, budget);
+
+		/* Poll XSK TX as part of RX NAPI. Setup re-poll based on max of
+		 * TX and RX work done.
+		 */
+		if (priv->xdp_prog)
+			work_done = max_t(int, work_done,
+					  gve_xsk_tx_poll(block, budget));
+
 		reschedule |= work_done == budget;
 	}
 
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 852f8c7e39d2..4350ebd9c2bd 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -981,33 +981,41 @@ static int gve_xsk_tx(struct gve_priv *priv, struct gve_tx_ring *tx,
 	return sent;
 }
 
+int gve_xsk_tx_poll(struct gve_notify_block *rx_block, int budget)
+{
+	struct gve_rx_ring *rx = rx_block->rx;
+	struct gve_priv *priv = rx->gve;
+	struct gve_tx_ring *tx;
+	int sent = 0;
+
+	tx = &priv->tx[gve_xdp_tx_queue_id(priv, rx->q_num)];
+	if (tx->xsk_pool) {
+		sent = gve_xsk_tx(priv, tx, budget);
+
+		u64_stats_update_begin(&tx->statss);
+		tx->xdp_xsk_sent += sent;
+		u64_stats_update_end(&tx->statss);
+		if (xsk_uses_need_wakeup(tx->xsk_pool))
+			xsk_set_tx_need_wakeup(tx->xsk_pool);
+	}
+
+	return sent;
+}
+
 bool gve_xdp_poll(struct gve_notify_block *block, int budget)
 {
 	struct gve_priv *priv = block->priv;
 	struct gve_tx_ring *tx = block->tx;
 	u32 nic_done;
-	bool repoll;
 	u32 to_do;
 
 	/* Find out how much work there is to be done */
 	nic_done = gve_tx_load_event_counter(priv, tx);
 	to_do = min_t(u32, (nic_done - tx->done), budget);
 	gve_clean_xdp_done(priv, tx, to_do);
-	repoll = nic_done != tx->done;
-
-	if (tx->xsk_pool) {
-		int sent = gve_xsk_tx(priv, tx, budget);
-
-		u64_stats_update_begin(&tx->statss);
-		tx->xdp_xsk_sent += sent;
-		u64_stats_update_end(&tx->statss);
-		repoll |= (sent == budget);
-		if (xsk_uses_need_wakeup(tx->xsk_pool))
-			xsk_set_tx_need_wakeup(tx->xsk_pool);
-	}
 
 	/* If we still have work we want to repoll */
-	return repoll;
+	return nic_done != tx->done;
 }
 
 bool gve_tx_poll(struct gve_notify_block *block, int budget)
-- 
2.47.1.613.gc27f4b7a9f-goog



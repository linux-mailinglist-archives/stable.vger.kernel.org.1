Return-Path: <stable+bounces-39755-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA85D8A5495
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 16:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83643281D77
	for <lists+stable@lfdr.de>; Mon, 15 Apr 2024 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E7B7EEFF;
	Mon, 15 Apr 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xgV0T7fI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7691F8565A;
	Mon, 15 Apr 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191716; cv=none; b=E/RG+fDfsQLt0hnCLI+gwSY11WeZ/m4GYFgsHSQcP+pZx4qmKLvzsVrNyY9zWaxSGRGKXsslQtW9ciyBjIkric9PALWfJfuqm1Gx27IGefgavlBDpkewQVx429po6TeJXQ0e9I0aBQCXv76a4OPYYw5iCABeigyQDjugELZ/qsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191716; c=relaxed/simple;
	bh=MwJUl3Y3co6t2uLqX9HxlM6VlEXpy5uyuNnM++Ikt0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GxOf+tBeq8c6nEQc0q+V6z6EkbShMM5rlcoHk0pTo95wJGmqVy0q8pKRZx2sFoTnCaOgRk9hJhMNVbhXZB+4v2v4chFfWVSKHWK8Yx8U6pJSfC+fuN/+q0oQF8thz3BvCrmJ+2fdP6gNjrTeA4y4NsqIgQwRPss/UxAEqHsMi/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xgV0T7fI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5276C2BD10;
	Mon, 15 Apr 2024 14:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713191716;
	bh=MwJUl3Y3co6t2uLqX9HxlM6VlEXpy5uyuNnM++Ikt0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xgV0T7fICGx4+evOQlfWxLFPeV5/q6w1oH15jzO/DlmkkfrANKkrNdX8382SnidFG
	 Gs0mO/SE+YA71yAZUV7dqQhoRBut4BbyMhn5IKjyx7BFjWZd+68h8Gs3N+cdzR236o
	 bmRzTyVuKyrp9QrU72QK/yOFix/dkskniyfI1xQY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 062/122] net/mlx5e: Do not produce metadata freelist entries in Tx port ts WQE xmit
Date: Mon, 15 Apr 2024 16:20:27 +0200
Message-ID: <20240415141955.237092642@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415141953.365222063@linuxfoundation.org>
References: <20240415141953.365222063@linuxfoundation.org>
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

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

[ Upstream commit 86b0ca5b118d3a0bae5e5645a13e66f8a4f6c525 ]

Free Tx port timestamping metadata entries in the NAPI poll context and
consume metadata enties in the WQE xmit path. Do not free a Tx port
timestamping metadata entry in the WQE xmit path even in the error path to
avoid a race between two metadata entry producers.

Fixes: 3178308ad4ca ("net/mlx5e: Make tx_port_ts logic resilient to out-of-order CQEs")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20240409190820.227554-10-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h | 8 +++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c  | 7 +++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
index 7b700d0f956a8..b171cd8f11e04 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h
@@ -95,9 +95,15 @@ static inline void mlx5e_ptp_metadata_fifo_push(struct mlx5e_ptp_metadata_fifo *
 }
 
 static inline u8
+mlx5e_ptp_metadata_fifo_peek(struct mlx5e_ptp_metadata_fifo *fifo)
+{
+	return fifo->data[fifo->mask & fifo->cc];
+}
+
+static inline void
 mlx5e_ptp_metadata_fifo_pop(struct mlx5e_ptp_metadata_fifo *fifo)
 {
-	return fifo->data[fifo->mask & fifo->cc++];
+	fifo->cc++;
 }
 
 static inline void
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 1ead69c5f5fa3..24cbd44dae93c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -398,6 +398,8 @@ mlx5e_txwqe_complete(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		     (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))) {
 		u8 metadata_index = be32_to_cpu(eseg->flow_table_metadata);
 
+		mlx5e_ptp_metadata_fifo_pop(&sq->ptpsq->metadata_freelist);
+
 		mlx5e_skb_cb_hwtstamp_init(skb);
 		mlx5e_ptp_metadata_map_put(&sq->ptpsq->metadata_map, skb,
 					   metadata_index);
@@ -496,9 +498,6 @@ mlx5e_sq_xmit_wqe(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 
 err_drop:
 	stats->dropped++;
-	if (unlikely(sq->ptpsq && (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP)))
-		mlx5e_ptp_metadata_fifo_push(&sq->ptpsq->metadata_freelist,
-					     be32_to_cpu(eseg->flow_table_metadata));
 	dev_kfree_skb_any(skb);
 	mlx5e_tx_flush(sq);
 }
@@ -657,7 +656,7 @@ static void mlx5e_cqe_ts_id_eseg(struct mlx5e_ptpsq *ptpsq, struct sk_buff *skb,
 {
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
 		eseg->flow_table_metadata =
-			cpu_to_be32(mlx5e_ptp_metadata_fifo_pop(&ptpsq->metadata_freelist));
+			cpu_to_be32(mlx5e_ptp_metadata_fifo_peek(&ptpsq->metadata_freelist));
 }
 
 static void mlx5e_txwqe_build_eseg(struct mlx5e_priv *priv, struct mlx5e_txqsq *sq,
-- 
2.43.0





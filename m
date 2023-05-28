Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BC3713ABA
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 18:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjE1Quu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 12:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjE1Qut (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 12:50:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1D1BE
        for <stable@vger.kernel.org>; Sun, 28 May 2023 09:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AE5160B26
        for <stable@vger.kernel.org>; Sun, 28 May 2023 16:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E3AC433EF;
        Sun, 28 May 2023 16:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685292647;
        bh=uL7SLYHDbhw4SArQF+d+AdlxPZpNbtFdEid581YsQ7E=;
        h=Subject:To:Cc:From:Date:From;
        b=MbTrNlPIOybOChi3cFpJs4y1TgUN7kK/ehtLbEtR+1hJTHtlWPj1kPzFj/N4GO6QS
         yXIdpjN8CVqgSAq9dOt22TEt0kaa1UpOradWILijQM0Sj0UQ7dQ0YNirAVGd5JNDDh
         +j5dxPIjGShlnRIxzQdAAvnMZnWX9nouvWuGh0RY=
Subject: FAILED: patch "[PATCH] net/mlx5e: Fix SQ wake logic in ptp napi_poll context" failed to apply to 5.15-stable tree
To:     rrameshbabu@nvidia.com, saeedm@nvidia.com, tariqt@nvidia.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sun, 28 May 2023 17:50:00 +0100
Message-ID: <2023052800-antennae-collected-11b6@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7aa50380191635e5897a773f272829cc961a2be5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023052800-antennae-collected-11b6@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

7aa503801916 ("net/mlx5e: Fix SQ wake logic in ptp napi_poll context")
19b43a432e3e ("net/mlx5e: Extend SKB room check to include PTP-SQ")
b8d91145ed7c ("net/mlx5e: Fix wrong calculation of header index in HW_GRO")
92552d3abd32 ("net/mlx5e: HW_GRO cqe handler implementation")
64509b052525 ("net/mlx5e: Add data path for SHAMPO feature")
f97d5c2a453e ("net/mlx5e: Add handle SHAMPO cqe support")
e5ca8fb08ab2 ("net/mlx5e: Add control path for SHAMPO feature")
eaee12f04692 ("net/mlx5e: Rename TIR lro functions to TIR packet merge functions")
50f477fe9933 ("net/mlx5e: Rename lro_timeout to packet_merge_timeout")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7aa50380191635e5897a773f272829cc961a2be5 Mon Sep 17 00:00:00 2001
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Date: Tue, 21 Feb 2023 16:18:48 -0800
Subject: [PATCH] net/mlx5e: Fix SQ wake logic in ptp napi_poll context

Check in the mlx5e_ptp_poll_ts_cq context if the ptp tx sq should be woken
up. Before change, the ptp tx sq may never wake up if the ptp tx ts skb
fifo is full when mlx5e_poll_tx_cq checks if the queue should be woken up.

Fixes: 1880bc4e4a96 ("net/mlx5e: Add TX port timestamp support")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index eb5abd0e55d9..3cbebfba582b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -175,6 +175,8 @@ static bool mlx5e_ptp_poll_ts_cq(struct mlx5e_cq *cq, int budget)
 	/* ensure cq space is freed before enabling more cqes */
 	wmb();
 
+	mlx5e_txqsq_wake(&ptpsq->txqsq);
+
 	return work_done == budget;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 47381e949f1f..879d698b6119 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -193,6 +193,8 @@ static inline u16 mlx5e_txqsq_get_next_pi(struct mlx5e_txqsq *sq, u16 size)
 	return pi;
 }
 
+void mlx5e_txqsq_wake(struct mlx5e_txqsq *sq);
+
 static inline u16 mlx5e_shampo_get_cqe_header_index(struct mlx5e_rq *rq, struct mlx5_cqe64 *cqe)
 {
 	return be16_to_cpu(cqe->shampo.header_entry_index) & (rq->mpwqe.shampo->hd_per_wq - 1);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index df5e780e8e6a..c7eb6b238c2b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -762,6 +762,17 @@ static void mlx5e_tx_wi_consume_fifo_skbs(struct mlx5e_txqsq *sq, struct mlx5e_t
 	}
 }
 
+void mlx5e_txqsq_wake(struct mlx5e_txqsq *sq)
+{
+	if (netif_tx_queue_stopped(sq->txq) &&
+	    mlx5e_wqc_has_room_for(&sq->wq, sq->cc, sq->pc, sq->stop_room) &&
+	    mlx5e_ptpsq_fifo_has_room(sq) &&
+	    !test_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state)) {
+		netif_tx_wake_queue(sq->txq);
+		sq->stats->wake++;
+	}
+}
+
 bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 {
 	struct mlx5e_sq_stats *stats;
@@ -861,13 +872,7 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 
 	netdev_tx_completed_queue(sq->txq, npkts, nbytes);
 
-	if (netif_tx_queue_stopped(sq->txq) &&
-	    mlx5e_wqc_has_room_for(&sq->wq, sq->cc, sq->pc, sq->stop_room) &&
-	    mlx5e_ptpsq_fifo_has_room(sq) &&
-	    !test_bit(MLX5E_SQ_STATE_RECOVERING, &sq->state)) {
-		netif_tx_wake_queue(sq->txq);
-		stats->wake++;
-	}
+	mlx5e_txqsq_wake(sq);
 
 	return (i == MLX5E_TX_CQ_POLL_BUDGET);
 }


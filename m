Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C11E719DA7
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbjFANZY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjFANZF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:25:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BF3E51
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAA2864472
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02881C433D2;
        Thu,  1 Jun 2023 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625882;
        bh=6WHCp0vcFycMP43T7Nkn5gQAUU7gsOx3eeV0ZDV63XY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lp+gc01HuBC1VmHXJ5a3g9KesfrY9tOERlk8moorUSDZpgGklahhbMAA62DtRlAob
         f5FsPRL4wm3AZgCokj3rqgZuOjlNvAiZ3guhvwuwB6uB/LBKq85FknbvygYq9xgDal
         tA+u2PXdFmKXoIvPC4Eu14J3WwrHqH8HToK8UbFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 30/42] net/mlx5e: Fix SQ wake logic in ptp napi_poll context
Date:   Thu,  1 Jun 2023 14:21:17 +0100
Message-Id: <20230601131938.068906471@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
References: <20230601131936.699199833@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

[ Upstream commit 7aa50380191635e5897a773f272829cc961a2be5 ]

Check in the mlx5e_ptp_poll_ts_cq context if the ptp tx sq should be woken
up. Before change, the ptp tx sq may never wake up if the ptp tx ts skb
fifo is full when mlx5e_poll_tx_cq checks if the queue should be woken up.

Fixes: 1880bc4e4a96 ("net/mlx5e: Add TX port timestamp support")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  2 ++
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  2 ++
 .../net/ethernet/mellanox/mlx5/core/en_tx.c   | 19 ++++++++++++-------
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 3a86f66d12955..ee95cc3a03786 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -126,6 +126,8 @@ static bool mlx5e_ptp_poll_ts_cq(struct mlx5e_cq *cq, int budget)
 	/* ensure cq space is freed before enabling more cqes */
 	wmb();
 
+	mlx5e_txqsq_wake(&ptpsq->txqsq);
+
 	return work_done == budget;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index f5c872043bcbd..cf62d1f6d7f20 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -172,6 +172,8 @@ static inline u16 mlx5e_txqsq_get_next_pi(struct mlx5e_txqsq *sq, u16 size)
 	return pi;
 }
 
+void mlx5e_txqsq_wake(struct mlx5e_txqsq *sq);
+
 struct mlx5e_icosq_wqe_info {
 	u8 wqe_type;
 	u8 num_wqebbs;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index e18fa5ae0fd84..6813279b57f89 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -810,6 +810,17 @@ static void mlx5e_tx_wi_consume_fifo_skbs(struct mlx5e_txqsq *sq, struct mlx5e_t
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
@@ -909,13 +920,7 @@ bool mlx5e_poll_tx_cq(struct mlx5e_cq *cq, int napi_budget)
 
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
-- 
2.39.2




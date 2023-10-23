Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D907D3195
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjJWLKq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjJWLKq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:10:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAB4D6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:10:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FEAC433C9;
        Mon, 23 Oct 2023 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059441;
        bh=W32Im1qK4OJpU1ia68lYQCj6V+4wFTJMlff7od89btM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nlih3G5Ylam4uhAG8DiFJxKlVHC9gXGsX2d3wLPPTd1yKzExs7x/HgeIgZ6tepnxT
         3UHQniRFKrpSQ6FtBdyNax7ZeifqLgVie7f8+LvjjmBn+7cuEn5+BXvGbiPEdaP6la
         whh42oCaKuc5SsG5pQkBVbM6dn9kBdj9PprAvK+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Mason <clm@fb.com>,
        Dragos Tatulea <dtatulea@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 152/241] net/mlx5e: RX, Fix page_pool allocation failure recovery for legacy rq
Date:   Mon, 23 Oct 2023 12:55:38 +0200
Message-ID: <20231023104837.576066327@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit ef9369e9c30846f5e052a11ccc70e1f6b8dc557a ]

When a page allocation fails during refill in mlx5e_refill_rx_wqes, the
page will be released again on the next refill call. This triggers the
page_pool negative page fragment count warning below:

 [  338.326070] WARNING: CPU: 4 PID: 0 at include/net/page_pool/helpers.h:130 mlx5e_page_release_fragmented.isra.0+0x42/0x50 [mlx5_core]
  ...
 [  338.328993] RIP: 0010:mlx5e_page_release_fragmented.isra.0+0x42/0x50 [mlx5_core]
 [  338.329094] Call Trace:
 [  338.329097]  <IRQ>
 [  338.329100]  ? __warn+0x7d/0x120
 [  338.329105]  ? mlx5e_page_release_fragmented.isra.0+0x42/0x50 [mlx5_core]
 [  338.329173]  ? report_bug+0x155/0x180
 [  338.329179]  ? handle_bug+0x3c/0x60
 [  338.329183]  ? exc_invalid_op+0x13/0x60
 [  338.329187]  ? asm_exc_invalid_op+0x16/0x20
 [  338.329192]  ? mlx5e_page_release_fragmented.isra.0+0x42/0x50 [mlx5_core]
 [  338.329259]  mlx5e_post_rx_wqes+0x210/0x5a0 [mlx5_core]
 [  338.329327]  ? mlx5e_poll_rx_cq+0x88/0x6f0 [mlx5_core]
 [  338.329394]  mlx5e_napi_poll+0x127/0x6b0 [mlx5_core]
 [  338.329461]  __napi_poll+0x25/0x1a0
 [  338.329465]  net_rx_action+0x28a/0x300
 [  338.329468]  __do_softirq+0xcd/0x279
 [  338.329473]  irq_exit_rcu+0x6a/0x90
 [  338.329477]  common_interrupt+0x82/0xa0
 [  338.329482]  </IRQ>

This patch fixes the legacy rq case by releasing all allocated fragments
and then setting the skip flag on all released fragments. It is
important to note that the number of released fragments will be higher
than the number of allocated fragments when an allocation error occurs.

Fixes: 3f93f82988bc ("net/mlx5e: RX, Defer page release in legacy rq for better recycling")
Tested-by: Chris Mason <clm@fb.com>
Reported-by: Chris Mason <clm@fb.com>
Closes: https://lore.kernel.org/netdev/117FF31A-7BE0-4050-B2BB-E41F224FF72F@meta.com
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 0b558db1a9455..5df970e6e29d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -457,26 +457,41 @@ static int mlx5e_alloc_rx_wqes(struct mlx5e_rq *rq, u16 ix, int wqe_bulk)
 static int mlx5e_refill_rx_wqes(struct mlx5e_rq *rq, u16 ix, int wqe_bulk)
 {
 	int remaining = wqe_bulk;
-	int i = 0;
+	int total_alloc = 0;
+	int refill_alloc;
+	int refill;
 
 	/* The WQE bulk is split into smaller bulks that are sized
 	 * according to the page pool cache refill size to avoid overflowing
 	 * the page pool cache due to too many page releases at once.
 	 */
 	do {
-		int refill = min_t(u16, rq->wqe.info.refill_unit, remaining);
-		int alloc_count;
+		refill = min_t(u16, rq->wqe.info.refill_unit, remaining);
 
-		mlx5e_free_rx_wqes(rq, ix + i, refill);
-		alloc_count = mlx5e_alloc_rx_wqes(rq, ix + i, refill);
-		i += alloc_count;
-		if (unlikely(alloc_count != refill))
-			break;
+		mlx5e_free_rx_wqes(rq, ix + total_alloc, refill);
+		refill_alloc = mlx5e_alloc_rx_wqes(rq, ix + total_alloc, refill);
+		if (unlikely(refill_alloc != refill))
+			goto err_free;
 
+		total_alloc += refill_alloc;
 		remaining -= refill;
 	} while (remaining);
 
-	return i;
+	return total_alloc;
+
+err_free:
+	mlx5e_free_rx_wqes(rq, ix, total_alloc + refill_alloc);
+
+	for (int i = 0; i < total_alloc + refill; i++) {
+		int j = mlx5_wq_cyc_ctr2ix(&rq->wqe.wq, ix + i);
+		struct mlx5e_wqe_frag_info *frag;
+
+		frag = get_frag(rq, j);
+		for (int k = 0; k < rq->wqe.info.num_frags; k++, frag++)
+			frag->flags |= BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
+	}
+
+	return 0;
 }
 
 static void
-- 
2.40.1




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DED78328D
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjHUUHE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjHUUHE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:07:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE8E3
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:07:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C0BB6498A
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:07:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67DB2C433C8;
        Mon, 21 Aug 2023 20:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648421;
        bh=/vPbDGYMzZ85BVDSSmFTHH4UXOF7Sf+LHKkwZNZe18Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jX2NNjR9P1m8HEY1X2mw+Fe9QKJNbtt11xE/s/rBs8Tz6/n7J6IUg1v2LcpeitIX4
         93hd1idSk8sUYd6Vgm1y+LqgEyzZ8/M/k6y7cadXsXE18+F5e4B3IrMS3A3E+QWzA/
         evSdGDbOWOQg/eFGaEYG6M8My0kaW5AthN/Ea9Eg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dragos Tatulea <dtatulea@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 170/234] net/mlx5e: XDP, Fix fifo overrun on XDP_REDIRECT
Date:   Mon, 21 Aug 2023 21:42:13 +0200
Message-ID: <20230821194136.358490395@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dragos Tatulea <dtatulea@nvidia.com>

[ Upstream commit 34a79876d9f77e971115236bcf7b5d14a8ecf542 ]

Before this fix, running high rate traffic through XDP_REDIRECT
with multibuf could overrun the fifo used to release the
xdp frames after tx completion. This resulted in corrupted data
being consumed on the free side.

The culplirt was a miscalculation of the fifo size: the maximum ratio
between fifo entries / data segments was incorrect. This ratio serves to
calculate the max fifo size for a full sq where each packet uses the
worst case number of entries in the fifo.

This patch fixes the formula and names the constant. It also makes sure
that future values will use a power of 2 number of entries for the fifo
mask to work.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Fixes: 3f734b8c594b ("net/mlx5e: XDP, Use multiple single-entry objects in xdpi_fifo")
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h  | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 8 +++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
index 9e8e6184f9e43..ecfe93a479da8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.h
@@ -84,6 +84,8 @@ enum mlx5e_xdp_xmit_mode {
  * MLX5E_XDP_XMIT_MODE_XSK:
  *    none.
  */
+#define MLX5E_XDP_FIFO_ENTRIES2DS_MAX_RATIO 4
+
 union mlx5e_xdp_info {
 	enum mlx5e_xdp_xmit_mode mode;
 	union {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 7e6d0489854e3..975c82df345cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1298,11 +1298,13 @@ static int mlx5e_alloc_xdpsq_fifo(struct mlx5e_xdpsq *sq, int numa)
 {
 	struct mlx5e_xdp_info_fifo *xdpi_fifo = &sq->db.xdpi_fifo;
 	int wq_sz        = mlx5_wq_cyc_get_size(&sq->wq);
-	int entries = wq_sz * MLX5_SEND_WQEBB_NUM_DS * 2; /* upper bound for maximum num of
-							   * entries of all xmit_modes.
-							   */
+	int entries;
 	size_t size;
 
+	/* upper bound for maximum num of entries of all xmit_modes. */
+	entries = roundup_pow_of_two(wq_sz * MLX5_SEND_WQEBB_NUM_DS *
+				     MLX5E_XDP_FIFO_ENTRIES2DS_MAX_RATIO);
+
 	size = array_size(sizeof(*xdpi_fifo->xi), entries);
 	xdpi_fifo->xi = kvzalloc_node(size, GFP_KERNEL, numa);
 	if (!xdpi_fifo->xi)
-- 
2.40.1




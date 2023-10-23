Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22A27D3196
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbjJWLKu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjJWLKs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:10:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBC0101
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:10:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F955C433C7;
        Mon, 23 Oct 2023 11:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059445;
        bh=Dlot1Hyw4+KRWBHDIQhBCQcD1SOeZanRJzkKkcdr1K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zLv+CMKIZR7/mGmbLcxNIiIjbbimuJdsF0PPy9sfWBksu+9hR4gLwH5mMU4aCwJSf
         olDJfxV2gCVO5veJ2NwUfqKpwFBlwNWk2O4QJye/JCSOqRUUpM0s+5nfoFyRYY+6VF
         LGV2mZqQBZllMRUhg4kGAF2c4S6dp9Bao+VfalSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dragos Tatulea <dtatulea@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 153/241] net/mlx5e: XDP, Fix XDP_REDIRECT mpwqe page fragment leaks on shutdown
Date:   Mon, 23 Oct 2023 12:55:39 +0200
Message-ID: <20231023104837.601609323@linuxfoundation.org>
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

[ Upstream commit aaab619ccd07a32e5b29aa7e59b20de1dcc7a29e ]

When mlx5e_xdp_xmit is called without the XDP_XMIT_FLUSH set it is
possible that it leaves a mpwqe session open. That is ok during runtime:
the session will be closed on the next call to mlx5e_xdp_xmit. But
having a mpwqe session still open at XDP sq close time is problematic:
the pc counter is not updated before flushing the contents of the
xdpi_fifo. This results in leaking page fragments.

The fix is to always close the mpwqe session at the end of
mlx5e_xdp_xmit, regardless of the XDP_XMIT_FLUSH flag being set or not.

Fixes: 5e0d2eef771e ("net/mlx5e: XDP, Support Enhanced Multi-Packet TX WQE")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 40589cebb7730..4fd4c9febab95 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -873,11 +873,11 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	}
 
 out:
-	if (flags & XDP_XMIT_FLUSH) {
-		if (sq->mpwqe.wqe)
-			mlx5e_xdp_mpwqe_complete(sq);
+	if (sq->mpwqe.wqe)
+		mlx5e_xdp_mpwqe_complete(sq);
+
+	if (flags & XDP_XMIT_FLUSH)
 		mlx5e_xmit_xdp_doorbell(sq);
-	}
 
 	return nxmit;
 }
-- 
2.40.1




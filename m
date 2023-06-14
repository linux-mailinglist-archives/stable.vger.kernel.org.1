Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE07726F75
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbjFGU6d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235787AbjFGU6Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:58:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F97213D
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C35364871
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304A8C433B4;
        Wed,  7 Jun 2023 20:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171479;
        bh=iSlFja9u42R8AHxLyVT6VAiSLydoaCfKTXjL7A3yvu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a9I/fCzBH8B8a0kZ8zPCWIXx7YtbbzsmSLR1hqwOo19/8Cpe1s6sHOQ3lYFLh+hsa
         uf+LmzCkcyRCx1ueM1P7tG5ONjwql5VXqhq+lvrGtJXnusXpT7Gh8TXZQLP9tMZck0
         CAYDZO/nZjtlyX1D5bKgE5hPi/fQAwXu44BIasS8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 033/159] net/mlx5e: Fix error handling in mlx5e_refresh_tirs
Date:   Wed,  7 Jun 2023 22:15:36 +0200
Message-ID: <20230607200904.752677491@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200903.652580797@linuxfoundation.org>
References: <20230607200903.652580797@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Saeed Mahameed <saeedm@nvidia.com>

[ Upstream commit b6193d7030e3c59f1d4c75648c9c8fa40cad2bcd ]

Allocation failure is outside the critical lock section and should
return immediately rather than jumping to the unlock section.

Also unlock as soon as required and remove the now redundant jump label.

Fixes: 80a2a9026b24 ("net/mlx5e: Add a lock on tir list")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_common.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 84eb7201c142e..9a28ea165236b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -140,10 +140,8 @@ int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb,
 
 	inlen = MLX5_ST_SZ_BYTES(modify_tir_in);
 	in = kvzalloc(inlen, GFP_KERNEL);
-	if (!in) {
-		err = -ENOMEM;
-		goto out;
-	}
+	if (!in)
+		return -ENOMEM;
 
 	if (enable_uc_lb)
 		lb_flags = MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST;
@@ -161,14 +159,13 @@ int mlx5e_refresh_tirs(struct mlx5e_priv *priv, bool enable_uc_lb,
 		tirn = tir->tirn;
 		err = mlx5_core_modify_tir(mdev, tirn, in);
 		if (err)
-			goto out;
+			break;
 	}
+	mutex_unlock(&mdev->mlx5e_res.hw_objs.td.list_lock);
 
-out:
 	kvfree(in);
 	if (err)
 		netdev_err(priv->netdev, "refresh tir(0x%x) failed, %d\n", tirn, err);
-	mutex_unlock(&mdev->mlx5e_res.hw_objs.td.list_lock);
 
 	return err;
 }
-- 
2.39.2




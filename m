Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC32726B59
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjFGUYj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjFGUYW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:24:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7142F269E
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:23:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC46064383
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:23:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCDDBC433EF;
        Wed,  7 Jun 2023 20:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169387;
        bh=k3w+srZzQc1gdR1Sp+wwZjhUQeZbbITUk4EOOSzJLI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENMQvt2Y/+yaVxCWg44VGfUwVe8hBu5YPwfiG5e4KvSWKBeWYjH2PAPrVxI1y+lF7
         v/H+U4p9ZS5bTkmStjkAr4KTf7p3+QAhGOl4a0q/muKDC9UBfvcQU28ptXcEUJ8NgP
         xKV0fQbaX1tzYREIwAVYmSQUWuyM8ttYY6JaWb+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jianbo Liu <jianbol@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 034/286] net/mlx5e: Move Ethernet driver debugfs to profile init callback
Date:   Wed,  7 Jun 2023 22:12:13 +0200
Message-ID: <20230607200924.144394864@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit c4c24fc30cc417ace332ceceaba4f70f81dcd521 ]

As priv->dfs_root is cleared, and therefore missed, when change
eswitch mode, move the creation of the root debugfs to the init
callback of mlx5e_nic_profile and mlx5e_uplink_rep_profile, and
the destruction to the cleanup callback for symmeter.

Fixes: 288eca60cc31 ("net/mlx5e: Add Ethernet driver debugfs")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 10 +++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c  |  6 ++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a60610c7a7bb7..7c72bed7f81aa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5226,12 +5226,16 @@ static int mlx5e_nic_init(struct mlx5_core_dev *mdev,
 
 	mlx5e_timestamp_init(priv);
 
+	priv->dfs_root = debugfs_create_dir("nic",
+					    mlx5_debugfs_get_dev_root(mdev));
+
 	fs = mlx5e_fs_init(priv->profile, mdev,
 			   !test_bit(MLX5E_STATE_DESTROYING, &priv->state),
 			   priv->dfs_root);
 	if (!fs) {
 		err = -ENOMEM;
 		mlx5_core_err(mdev, "FS initialization failed, %d\n", err);
+		debugfs_remove_recursive(priv->dfs_root);
 		return err;
 	}
 	priv->fs = fs;
@@ -5252,6 +5256,7 @@ static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 	mlx5e_health_destroy_reporters(priv);
 	mlx5e_ktls_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
+	debugfs_remove_recursive(priv->dfs_root);
 	priv->fs = NULL;
 }
 
@@ -5976,9 +5981,6 @@ static int mlx5e_probe(struct auxiliary_device *adev,
 	priv->profile = profile;
 	priv->ppriv = NULL;
 
-	priv->dfs_root = debugfs_create_dir("nic",
-					    mlx5_debugfs_get_dev_root(priv->mdev));
-
 	err = profile->init(mdev, netdev);
 	if (err) {
 		mlx5_core_err(mdev, "mlx5e_nic_profile init failed, %d\n", err);
@@ -6007,7 +6009,6 @@ static int mlx5e_probe(struct auxiliary_device *adev,
 err_profile_cleanup:
 	profile->cleanup(priv);
 err_destroy_netdev:
-	debugfs_remove_recursive(priv->dfs_root);
 	mlx5e_destroy_netdev(priv);
 err_devlink_port_unregister:
 	mlx5e_devlink_port_unregister(mlx5e_dev);
@@ -6027,7 +6028,6 @@ static void mlx5e_remove(struct auxiliary_device *adev)
 	unregister_netdev(priv->netdev);
 	mlx5e_suspend(adev, state);
 	priv->profile->cleanup(priv);
-	debugfs_remove_recursive(priv->dfs_root);
 	mlx5e_destroy_netdev(priv);
 	mlx5e_devlink_port_unregister(mlx5e_dev);
 	mlx5e_destroy_devlink(mlx5e_dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 6e18d91c3d766..992f3f9c11925 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -30,6 +30,7 @@
  * SOFTWARE.
  */
 
+#include <linux/debugfs.h>
 #include <linux/mlx5/fs.h>
 #include <net/switchdev.h>
 #include <net/pkt_cls.h>
@@ -811,11 +812,15 @@ static int mlx5e_init_ul_rep(struct mlx5_core_dev *mdev,
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 
+	priv->dfs_root = debugfs_create_dir("nic",
+					    mlx5_debugfs_get_dev_root(mdev));
+
 	priv->fs = mlx5e_fs_init(priv->profile, mdev,
 				 !test_bit(MLX5E_STATE_DESTROYING, &priv->state),
 				 priv->dfs_root);
 	if (!priv->fs) {
 		netdev_err(priv->netdev, "FS allocation failed\n");
+		debugfs_remove_recursive(priv->dfs_root);
 		return -ENOMEM;
 	}
 
@@ -828,6 +833,7 @@ static int mlx5e_init_ul_rep(struct mlx5_core_dev *mdev,
 static void mlx5e_cleanup_rep(struct mlx5e_priv *priv)
 {
 	mlx5e_fs_cleanup(priv->fs);
+	debugfs_remove_recursive(priv->dfs_root);
 	priv->fs = NULL;
 }
 
-- 
2.39.2




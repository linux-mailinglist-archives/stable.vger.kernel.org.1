Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94F6726F53
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235608AbjFGU5f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235527AbjFGU5e (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:57:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614B710D7
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:57:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFDBA64874
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:57:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF90CC433EF;
        Wed,  7 Jun 2023 20:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171448;
        bh=ucclNngBbka4lq/3zBwzxqDWONRCbthRVruEaIFZ1h0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FjMti6x1E2eZy3cGvELVuh+th0Pa4KiwmKXv7Xmxf+udxm62uGwxGy9vGEb/rLY73
         TUxwUjqdt7qccRk+Rpy/Gqrm2aQC3FWnDufprOWirfLuGF4fTUJTbw3ocKIt/7U/9S
         IwudUZ9yuko5AJ7ARoGgNIMGTVX4RuRmHwcoV6So=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dmytro Linkin <dlinkin@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 014/159] net/mlx5e: Dont attach netdev profile while handling internal error
Date:   Wed,  7 Jun 2023 22:15:17 +0200
Message-ID: <20230607200904.138216630@linuxfoundation.org>
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

From: Dmytro Linkin <dlinkin@nvidia.com>

[ Upstream commit bdf274750fca17b289404ef03453c4070725302c ]

As part of switchdev mode disablement, driver changes port netdevice
profile from uplink to nic. If this process is triggered by health
recovery flow (PCI reset, for ex.) profile attach would fail because all
fw commands aborted when internal error flag is set. As a result, nic
netdevice profile is not attached and driver fails to rollback to uplink
profile, which leave driver in broken state and cause crash later.

To handle broken state do netdevice profile initialization only instead
of full attachment and release mdev resources on driver suspend as
expected. Actual netdevice attachment is done during driver load.

Fixes: c4d7eb57687f ("net/mxl5e: Add change profile method")
Signed-off-by: Dmytro Linkin <dlinkin@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 35 ++++++++++++++++---
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index ec1c667bd145a..82849bed27f4c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5008,8 +5008,8 @@ void mlx5e_detach_netdev(struct mlx5e_priv *priv)
 }
 
 static int
-mlx5e_netdev_attach_profile(struct net_device *netdev, struct mlx5_core_dev *mdev,
-			    const struct mlx5e_profile *new_profile, void *new_ppriv)
+mlx5e_netdev_init_profile(struct net_device *netdev, struct mlx5_core_dev *mdev,
+			  const struct mlx5e_profile *new_profile, void *new_ppriv)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	int err;
@@ -5025,6 +5025,25 @@ mlx5e_netdev_attach_profile(struct net_device *netdev, struct mlx5_core_dev *mde
 	err = new_profile->init(priv->mdev, priv->netdev);
 	if (err)
 		goto priv_cleanup;
+
+	return 0;
+
+priv_cleanup:
+	mlx5e_priv_cleanup(priv);
+	return err;
+}
+
+static int
+mlx5e_netdev_attach_profile(struct net_device *netdev, struct mlx5_core_dev *mdev,
+			    const struct mlx5e_profile *new_profile, void *new_ppriv)
+{
+	struct mlx5e_priv *priv = netdev_priv(netdev);
+	int err;
+
+	err = mlx5e_netdev_init_profile(netdev, mdev, new_profile, new_ppriv);
+	if (err)
+		return err;
+
 	err = mlx5e_attach_netdev(priv);
 	if (err)
 		goto profile_cleanup;
@@ -5032,7 +5051,6 @@ mlx5e_netdev_attach_profile(struct net_device *netdev, struct mlx5_core_dev *mde
 
 profile_cleanup:
 	new_profile->cleanup(priv);
-priv_cleanup:
 	mlx5e_priv_cleanup(priv);
 	return err;
 }
@@ -5051,6 +5069,12 @@ int mlx5e_netdev_change_profile(struct mlx5e_priv *priv,
 	priv->profile->cleanup(priv);
 	mlx5e_priv_cleanup(priv);
 
+	if (mdev->state == MLX5_DEVICE_STATE_INTERNAL_ERROR) {
+		mlx5e_netdev_init_profile(netdev, mdev, new_profile, new_ppriv);
+		set_bit(MLX5E_STATE_DESTROYING, &priv->state);
+		return -EIO;
+	}
+
 	err = mlx5e_netdev_attach_profile(netdev, mdev, new_profile, new_ppriv);
 	if (err) { /* roll back to original profile */
 		netdev_warn(netdev, "%s: new profile init failed, %d\n", __func__, err);
@@ -5110,8 +5134,11 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
 	struct net_device *netdev = priv->netdev;
 	struct mlx5_core_dev *mdev = priv->mdev;
 
-	if (!netif_device_present(netdev))
+	if (!netif_device_present(netdev)) {
+		if (test_bit(MLX5E_STATE_DESTROYING, &priv->state))
+			mlx5e_destroy_mdev_resources(mdev);
 		return -ENODEV;
+	}
 
 	mlx5e_detach_netdev(priv);
 	mlx5e_destroy_mdev_resources(mdev);
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62473726CF4
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjFGUiG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbjFGUiF (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:38:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B272680
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DECB645B5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE7EC433EF;
        Wed,  7 Jun 2023 20:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170268;
        bh=QJ1v6E+J2n4TiuZWj8TF8X3xrvx/vpaVZthwk8v0VEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwneQpMB4rYqXgnqJ9gBMaE4x6koxDxKlfK7fqW0qjSzhopqP+GjIh4RlDYnhfUrZ
         ww71nHSf7cuplf0nOkmqhgZ5D3XX6PhmF92RHReLJVXnYpYP7/KiMkiSJw+X/kl2Jr
         0ABYIoYEdxst0dmyuJp2zfZ5GzN8Ve4HxGIjDoOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dmytro Linkin <dlinkin@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 020/225] net/mlx5e: Dont attach netdev profile while handling internal error
Date:   Wed,  7 Jun 2023 22:13:33 +0200
Message-ID: <20230607200914.969019076@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
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
index 94d010e2d5efd..4e7daa382bc05 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5745,8 +5745,8 @@ void mlx5e_detach_netdev(struct mlx5e_priv *priv)
 }
 
 static int
-mlx5e_netdev_attach_profile(struct net_device *netdev, struct mlx5_core_dev *mdev,
-			    const struct mlx5e_profile *new_profile, void *new_ppriv)
+mlx5e_netdev_init_profile(struct net_device *netdev, struct mlx5_core_dev *mdev,
+			  const struct mlx5e_profile *new_profile, void *new_ppriv)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	int err;
@@ -5762,6 +5762,25 @@ mlx5e_netdev_attach_profile(struct net_device *netdev, struct mlx5_core_dev *mde
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
@@ -5769,7 +5788,6 @@ mlx5e_netdev_attach_profile(struct net_device *netdev, struct mlx5_core_dev *mde
 
 profile_cleanup:
 	new_profile->cleanup(priv);
-priv_cleanup:
 	mlx5e_priv_cleanup(priv);
 	return err;
 }
@@ -5788,6 +5806,12 @@ int mlx5e_netdev_change_profile(struct mlx5e_priv *priv,
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
@@ -5847,8 +5871,11 @@ static int mlx5e_suspend(struct auxiliary_device *adev, pm_message_t state)
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




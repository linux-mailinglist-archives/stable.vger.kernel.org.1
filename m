Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4B86FA56C
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbjEHKJT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234130AbjEHKJS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B723292B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:09:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BA6B623A3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B832C4339B;
        Mon,  8 May 2023 10:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540555;
        bh=anjo1FWnJEc0Ivk2Jg1ow0y644fL/3UfMVYP6lROKsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FXtmce3ULdRLEeXJsmn0TRxZOTJqSkjrWJ+/unV9SRmP6bBsjGZkWJXvgLpYyO29V
         YVmLGuFIP+MFmhGGli6/2895Q+tumZgEzf8xxXgMrXuvFNWl8NePBpI/XIfyOZs04g
         WImY7LIh0pE0cAv+bKlb8rzWuNJnmGG1KOuzIDpo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiri Pirko <jiri@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 382/611] net/mlx5: Suspend auxiliary devices only in case of PCI device suspend
Date:   Mon,  8 May 2023 11:43:44 +0200
Message-Id: <20230508094434.737523299@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jiri Pirko <jiri@nvidia.com>

[ Upstream commit 72ed5d5624af384eaf74d84915810d54486a75e2 ]

The original behavior introduced by commit c6acd629eec7 ("net/mlx5e: Add
support for devlink-port in non-representors mode") correctly
re-instantiated uplink devlink port and related netdevice during devlink
reload. However with migration to auxiliary devices, this behaviour
changed.

Restore the original behaviour and tear down auxiliary devices
completely during devlink reload.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Stable-dep-of: dfad99750c0f ("net/mlx5: Use recovery timeout on sync reset flow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c    |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/devlink.c    |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/fw_reset.c   |  4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/health.c |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c   | 16 ++++++++--------
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h  |  6 +++---
 .../ethernet/mellanox/mlx5/core/sf/dev/driver.c  |  2 +-
 7 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/dev.c b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
index 0571e40c6ee5f..02bb9d43ff9c4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -396,7 +396,7 @@ int mlx5_attach_device(struct mlx5_core_dev *dev)
 	return ret;
 }
 
-void mlx5_detach_device(struct mlx5_core_dev *dev)
+void mlx5_detach_device(struct mlx5_core_dev *dev, bool suspend)
 {
 	struct mlx5_priv *priv = &dev->priv;
 	struct auxiliary_device *adev;
@@ -426,7 +426,7 @@ void mlx5_detach_device(struct mlx5_core_dev *dev)
 
 		adrv = to_auxiliary_drv(adev->dev.driver);
 
-		if (adrv->suspend) {
+		if (adrv->suspend && suspend) {
 			adrv->suspend(adev, pm);
 			continue;
 		}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 97e9ec44a759b..7f1f813b2f2d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -108,7 +108,7 @@ static int mlx5_devlink_reload_fw_activate(struct devlink *devlink, struct netli
 	if (err)
 		return err;
 
-	mlx5_unload_one_devl_locked(dev);
+	mlx5_unload_one_devl_locked(dev, true);
 	err = mlx5_health_wait_pci_up(dev);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "FW activate aborted, PCI reads fail after reset");
@@ -166,7 +166,7 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 
 	switch (action) {
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
-		mlx5_unload_one_devl_locked(dev);
+		mlx5_unload_one_devl_locked(dev, false);
 		break;
 	case DEVLINK_RELOAD_ACTION_FW_ACTIVATE:
 		if (limit == DEVLINK_RELOAD_LIMIT_NO_RESET)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index a1f460c9d3cde..2ef42d76ac6a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -150,7 +150,7 @@ static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev)
 	if (test_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags)) {
 		complete(&fw_reset->done);
 	} else {
-		mlx5_unload_one(dev);
+		mlx5_unload_one(dev, false);
 		if (mlx5_health_wait_pci_up(dev))
 			mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
 		else
@@ -484,7 +484,7 @@ int mlx5_fw_reset_wait_reset_done(struct mlx5_core_dev *dev)
 	}
 	err = fw_reset->ret;
 	if (test_and_clear_bit(MLX5_FW_RESET_FLAGS_RELOAD_REQUIRED, &fw_reset->reset_flags)) {
-		mlx5_unload_one_devl_locked(dev);
+		mlx5_unload_one_devl_locked(dev, false);
 		mlx5_load_one_devl_locked(dev, false);
 	}
 out:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index 879555ba847dd..e42e4ac231c64 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -699,7 +699,7 @@ static void mlx5_fw_fatal_reporter_err_work(struct work_struct *work)
 		 * requests from the kernel.
 		 */
 		mlx5_core_err(dev, "Driver is in error state. Unloading\n");
-		mlx5_unload_one(dev);
+		mlx5_unload_one(dev, false);
 	}
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 31841f4307fee..4c72cb3ac30cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1495,12 +1495,12 @@ int mlx5_load_one(struct mlx5_core_dev *dev)
 	return ret;
 }
 
-void mlx5_unload_one_devl_locked(struct mlx5_core_dev *dev)
+void mlx5_unload_one_devl_locked(struct mlx5_core_dev *dev, bool suspend)
 {
 	devl_assert_locked(priv_to_devlink(dev));
 	mutex_lock(&dev->intf_state_mutex);
 
-	mlx5_detach_device(dev);
+	mlx5_detach_device(dev, suspend);
 
 	if (!test_bit(MLX5_INTERFACE_STATE_UP, &dev->intf_state)) {
 		mlx5_core_warn(dev, "%s: interface is down, NOP\n",
@@ -1515,12 +1515,12 @@ void mlx5_unload_one_devl_locked(struct mlx5_core_dev *dev)
 	mutex_unlock(&dev->intf_state_mutex);
 }
 
-void mlx5_unload_one(struct mlx5_core_dev *dev)
+void mlx5_unload_one(struct mlx5_core_dev *dev, bool suspend)
 {
 	struct devlink *devlink = priv_to_devlink(dev);
 
 	devl_lock(devlink);
-	mlx5_unload_one_devl_locked(dev);
+	mlx5_unload_one_devl_locked(dev, suspend);
 	devl_unlock(devlink);
 }
 
@@ -1793,7 +1793,7 @@ static pci_ers_result_t mlx5_pci_err_detected(struct pci_dev *pdev,
 
 	mlx5_enter_error_state(dev, false);
 	mlx5_error_sw_reset(dev);
-	mlx5_unload_one(dev);
+	mlx5_unload_one(dev, true);
 	mlx5_drain_health_wq(dev);
 	mlx5_pci_disable_device(dev);
 
@@ -1949,7 +1949,7 @@ static void shutdown(struct pci_dev *pdev)
 	set_bit(MLX5_BREAK_FW_WAIT, &dev->intf_state);
 	err = mlx5_try_fast_unload(dev);
 	if (err)
-		mlx5_unload_one(dev);
+		mlx5_unload_one(dev, false);
 	mlx5_pci_disable_device(dev);
 }
 
@@ -1957,7 +1957,7 @@ static int mlx5_suspend(struct pci_dev *pdev, pm_message_t state)
 {
 	struct mlx5_core_dev *dev = pci_get_drvdata(pdev);
 
-	mlx5_unload_one(dev);
+	mlx5_unload_one(dev, true);
 
 	return 0;
 }
@@ -2000,7 +2000,7 @@ MODULE_DEVICE_TABLE(pci, mlx5_core_pci_table);
 void mlx5_disable_device(struct mlx5_core_dev *dev)
 {
 	mlx5_error_sw_reset(dev);
-	mlx5_unload_one_devl_locked(dev);
+	mlx5_unload_one_devl_locked(dev, false);
 }
 
 int mlx5_recover_device(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index c57e0fc4bab1f..02fef8b2d268a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -236,7 +236,7 @@ void mlx5_adev_cleanup(struct mlx5_core_dev *dev);
 int mlx5_adev_init(struct mlx5_core_dev *dev);
 
 int mlx5_attach_device(struct mlx5_core_dev *dev);
-void mlx5_detach_device(struct mlx5_core_dev *dev);
+void mlx5_detach_device(struct mlx5_core_dev *dev, bool suspend);
 int mlx5_register_device(struct mlx5_core_dev *dev);
 void mlx5_unregister_device(struct mlx5_core_dev *dev);
 struct mlx5_core_dev *mlx5_get_next_phys_dev_lag(struct mlx5_core_dev *dev);
@@ -319,8 +319,8 @@ int mlx5_mdev_init(struct mlx5_core_dev *dev, int profile_idx);
 void mlx5_mdev_uninit(struct mlx5_core_dev *dev);
 int mlx5_init_one(struct mlx5_core_dev *dev);
 void mlx5_uninit_one(struct mlx5_core_dev *dev);
-void mlx5_unload_one(struct mlx5_core_dev *dev);
-void mlx5_unload_one_devl_locked(struct mlx5_core_dev *dev);
+void mlx5_unload_one(struct mlx5_core_dev *dev, bool suspend);
+void mlx5_unload_one_devl_locked(struct mlx5_core_dev *dev, bool suspend);
 int mlx5_load_one(struct mlx5_core_dev *dev);
 int mlx5_load_one_devl_locked(struct mlx5_core_dev *dev, bool recovery);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index 7b4783ce213e2..a7377619ba6f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -74,7 +74,7 @@ static void mlx5_sf_dev_shutdown(struct auxiliary_device *adev)
 {
 	struct mlx5_sf_dev *sf_dev = container_of(adev, struct mlx5_sf_dev, adev);
 
-	mlx5_unload_one(sf_dev->mdev);
+	mlx5_unload_one(sf_dev->mdev, false);
 }
 
 static const struct auxiliary_device_id mlx5_sf_dev_id_table[] = {
-- 
2.39.2




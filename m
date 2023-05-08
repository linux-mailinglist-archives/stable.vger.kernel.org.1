Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2547E6FA574
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbjEHKJj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjEHKJj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7465135124
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:09:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED50D623A3
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:09:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAE2C433D2;
        Mon,  8 May 2023 10:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540576;
        bh=O9E6wDXKVgCnNBLP9qRkPzoM3u6ZZYhy04M4gYai58E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d/qm2+theVF4rRQp4CODUdPwCHwTPQk+tjbtq+MiLyPba5z7ErCjCS5pLyvLVzAkk
         AhHe+kP2h9MqX6MuoWGdAc6fZgqui60WRQ/33oHTZZw4AEREpOkl8cgYDTvzIALG3g
         RUcFOKm04pRCYiWufuwK3R1/eH+bPNJdcC6jOApo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Moshe Shemesh <moshe@nvidia.com>,
        Maher Sanalla <msanalla@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 384/611] net/mlx5: Use recovery timeout on sync reset flow
Date:   Mon,  8 May 2023 11:43:46 +0200
Message-Id: <20230508094434.794944266@linuxfoundation.org>
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

From: Moshe Shemesh <moshe@nvidia.com>

[ Upstream commit dfad99750c0f83b0242572a573afa2c055f85b36 ]

Use the same timeout for sync reset flow and health recovery flow, since
the former involves driver's recovery from firmware reset, which is
similar to health recovery. Otherwise, in some cases, such as a firmware
upgrade on the DPU, the firmware pre-init bit may not be ready within
current timeout and the driver will abort loading back after reset.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Fixes: 37ca95e62ee2 ("net/mlx5: Increase FW pre-init timeout for health recovery")
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 7f1f813b2f2d9..3749eb83d9e53 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -200,7 +200,7 @@ static int mlx5_devlink_reload_up(struct devlink *devlink, enum devlink_reload_a
 			break;
 		/* On fw_activate action, also driver is reloaded and reinit performed */
 		*actions_performed |= BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT);
-		ret = mlx5_load_one_devl_locked(dev, false);
+		ret = mlx5_load_one_devl_locked(dev, true);
 		break;
 	default:
 		/* Unsupported action should not get to this function */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 2b74729180394..d219f8417d93a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -154,7 +154,7 @@ static void mlx5_fw_reset_complete_reload(struct mlx5_core_dev *dev)
 		if (mlx5_health_wait_pci_up(dev))
 			mlx5_core_err(dev, "reset reload flow aborted, PCI reads still not working\n");
 		else
-			mlx5_load_one(dev, false);
+			mlx5_load_one(dev, true);
 		devlink_remote_reload_actions_performed(priv_to_devlink(dev), 0,
 							BIT(DEVLINK_RELOAD_ACTION_DRIVER_REINIT) |
 							BIT(DEVLINK_RELOAD_ACTION_FW_ACTIVATE));
@@ -485,7 +485,7 @@ int mlx5_fw_reset_wait_reset_done(struct mlx5_core_dev *dev)
 	err = fw_reset->ret;
 	if (test_and_clear_bit(MLX5_FW_RESET_FLAGS_RELOAD_REQUIRED, &fw_reset->reset_flags)) {
 		mlx5_unload_one_devl_locked(dev, false);
-		mlx5_load_one_devl_locked(dev, false);
+		mlx5_load_one_devl_locked(dev, true);
 	}
 out:
 	clear_bit(MLX5_FW_RESET_FLAGS_PENDING_COMP, &fw_reset->reset_flags);
-- 
2.39.2




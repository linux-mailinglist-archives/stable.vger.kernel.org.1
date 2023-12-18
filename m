Return-Path: <stable+bounces-7258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958C08171A5
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEE72836C1
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975B6129ED2;
	Mon, 18 Dec 2023 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AogHJv5J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E501D13B;
	Mon, 18 Dec 2023 13:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC08DC433C7;
	Mon, 18 Dec 2023 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907983;
	bh=vS9h8ogKtzfAlK9ZdGYxzzRu8OOx5/GytjSk7uDzMoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AogHJv5JwAoSOTsKPqdm2SIc62W7AVTsASNB3vn6H15yKjCoJMsdfVEwqCr8UOgPN
	 7WaxF2aVAUhuFGC2BQW1yIB0holLYcuD3NpVuCI+uqLkOJLm8Mbthz+5kgEpCUkRLW
	 GVNQx/csM+pVA8um1kCqc6BeTjz+1scm6Smq8ipY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jianbo Liu <jianbol@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 011/166] net/mlx5e: Reduce eswitch mode_lock protection context
Date: Mon, 18 Dec 2023 14:49:37 +0100
Message-ID: <20231218135105.461387312@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135104.927894164@linuxfoundation.org>
References: <20231218135104.927894164@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit baac8351f74c543896b8fd40138b7ad9365587a3 ]

Currently eswitch mode_lock is so heavy, for example, it's locked
during the whole process of the mode change, which may need to hold
other locks. As the mode_lock is also used by IPSec to block mode and
encap change now, it is easy to cause lock dependency.

Since some of protections are also done by devlink lock, the eswitch
mode_lock is not needed at those places, and thus the possibility of
lockdep issue is reduced.

Fixes: c8e350e62fc5 ("net/mlx5e: Make TC and IPsec offloads mutually exclusive on a netdev")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  9 +++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 35 ++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  2 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 38 +++++++++++--------
 4 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 6dc60be2a697c..03f69c485a006 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -1834,8 +1834,11 @@ static int mlx5e_ipsec_block_tc_offload(struct mlx5_core_dev *mdev)
 	struct mlx5_eswitch *esw = mdev->priv.eswitch;
 	int err = 0;
 
-	if (esw)
-		down_write(&esw->mode_lock);
+	if (esw) {
+		err = mlx5_esw_lock(esw);
+		if (err)
+			return err;
+	}
 
 	if (mdev->num_block_ipsec) {
 		err = -EBUSY;
@@ -1846,7 +1849,7 @@ static int mlx5e_ipsec_block_tc_offload(struct mlx5_core_dev *mdev)
 
 unlock:
 	if (esw)
-		up_write(&esw->mode_lock);
+		mlx5_esw_unlock(esw);
 
 	return err;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 8d0b915a31214..3047d7015c525 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1463,7 +1463,7 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 {
 	int err;
 
-	lockdep_assert_held(&esw->mode_lock);
+	devl_assert_locked(priv_to_devlink(esw->dev));
 
 	if (!MLX5_CAP_ESW_FLOWTABLE_FDB(esw->dev, ft_support)) {
 		esw_warn(esw->dev, "FDB is not supported, aborting ...\n");
@@ -1531,7 +1531,6 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
 	if (toggle_lag)
 		mlx5_lag_disable_change(esw->dev);
 
-	down_write(&esw->mode_lock);
 	if (!mlx5_esw_is_fdb_created(esw)) {
 		ret = mlx5_eswitch_enable_locked(esw, num_vfs);
 	} else {
@@ -1554,8 +1553,6 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs)
 		}
 	}
 
-	up_write(&esw->mode_lock);
-
 	if (toggle_lag)
 		mlx5_lag_enable_change(esw->dev);
 
@@ -1569,12 +1566,11 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
 		return;
 
 	devl_assert_locked(priv_to_devlink(esw->dev));
-	down_write(&esw->mode_lock);
 	/* If driver is unloaded, this function is called twice by remove_one()
 	 * and mlx5_unload(). Prevent the second call.
 	 */
 	if (!esw->esw_funcs.num_vfs && !esw->esw_funcs.num_ec_vfs && !clear_vf)
-		goto unlock;
+		return;
 
 	esw_info(esw->dev, "Unload vfs: mode(%s), nvfs(%d), necvfs(%d), active vports(%d)\n",
 		 esw->mode == MLX5_ESWITCH_LEGACY ? "LEGACY" : "OFFLOADS",
@@ -1603,9 +1599,6 @@ void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf)
 		esw->esw_funcs.num_vfs = 0;
 	else
 		esw->esw_funcs.num_ec_vfs = 0;
-
-unlock:
-	up_write(&esw->mode_lock);
 }
 
 /* Free resources for corresponding eswitch mode. It is called by devlink
@@ -1647,10 +1640,8 @@ void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
 
 	devl_assert_locked(priv_to_devlink(esw->dev));
 	mlx5_lag_disable_change(esw->dev);
-	down_write(&esw->mode_lock);
 	mlx5_eswitch_disable_locked(esw);
 	esw->mode = MLX5_ESWITCH_LEGACY;
-	up_write(&esw->mode_lock);
 	mlx5_lag_enable_change(esw->dev);
 }
 
@@ -2254,8 +2245,13 @@ bool mlx5_esw_hold(struct mlx5_core_dev *mdev)
 	if (!mlx5_esw_allowed(esw))
 		return true;
 
-	if (down_read_trylock(&esw->mode_lock) != 0)
+	if (down_read_trylock(&esw->mode_lock) != 0) {
+		if (esw->eswitch_operation_in_progress) {
+			up_read(&esw->mode_lock);
+			return false;
+		}
 		return true;
+	}
 
 	return false;
 }
@@ -2312,7 +2308,8 @@ int mlx5_esw_try_lock(struct mlx5_eswitch *esw)
 	if (down_write_trylock(&esw->mode_lock) == 0)
 		return -EINVAL;
 
-	if (atomic64_read(&esw->user_count) > 0) {
+	if (esw->eswitch_operation_in_progress ||
+	    atomic64_read(&esw->user_count) > 0) {
 		up_write(&esw->mode_lock);
 		return -EBUSY;
 	}
@@ -2320,6 +2317,18 @@ int mlx5_esw_try_lock(struct mlx5_eswitch *esw)
 	return esw->mode;
 }
 
+int mlx5_esw_lock(struct mlx5_eswitch *esw)
+{
+	down_write(&esw->mode_lock);
+
+	if (esw->eswitch_operation_in_progress) {
+		up_write(&esw->mode_lock);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
 /**
  * mlx5_esw_unlock() - Release write lock on esw mode lock
  * @esw: eswitch device.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 37ab66e7b403f..b674b57d05aad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -383,6 +383,7 @@ struct mlx5_eswitch {
 	struct xarray paired;
 	struct mlx5_devcom_comp_dev *devcom;
 	u16 enabled_ipsec_vf_count;
+	bool eswitch_operation_in_progress;
 };
 
 void esw_offloads_disable(struct mlx5_eswitch *esw);
@@ -827,6 +828,7 @@ void mlx5_esw_release(struct mlx5_core_dev *dev);
 void mlx5_esw_get(struct mlx5_core_dev *dev);
 void mlx5_esw_put(struct mlx5_core_dev *dev);
 int mlx5_esw_try_lock(struct mlx5_eswitch *esw);
+int mlx5_esw_lock(struct mlx5_eswitch *esw);
 void mlx5_esw_unlock(struct mlx5_eswitch *esw);
 
 void esw_vport_change_handle_locked(struct mlx5_vport *vport);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 88236e75fd901..bf78eeca401be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3733,13 +3733,16 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		goto unlock;
 	}
 
+	esw->eswitch_operation_in_progress = true;
+	up_write(&esw->mode_lock);
+
 	mlx5_eswitch_disable_locked(esw);
 	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV) {
 		if (mlx5_devlink_trap_get_num_active(esw->dev)) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "Can't change mode while devlink traps are active");
 			err = -EOPNOTSUPP;
-			goto unlock;
+			goto skip;
 		}
 		err = esw_offloads_start(esw, extack);
 	} else if (mode == DEVLINK_ESWITCH_MODE_LEGACY) {
@@ -3749,6 +3752,9 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		err = -EINVAL;
 	}
 
+skip:
+	down_write(&esw->mode_lock);
+	esw->eswitch_operation_in_progress = false;
 unlock:
 	mlx5_esw_unlock(esw);
 enable_lag:
@@ -3759,16 +3765,12 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 int mlx5_devlink_eswitch_mode_get(struct devlink *devlink, u16 *mode)
 {
 	struct mlx5_eswitch *esw;
-	int err;
 
 	esw = mlx5_devlink_eswitch_get(devlink);
 	if (IS_ERR(esw))
 		return PTR_ERR(esw);
 
-	down_read(&esw->mode_lock);
-	err = esw_mode_to_devlink(esw->mode, mode);
-	up_read(&esw->mode_lock);
-	return err;
+	return esw_mode_to_devlink(esw->mode, mode);
 }
 
 static int mlx5_esw_vports_inline_set(struct mlx5_eswitch *esw, u8 mlx5_mode,
@@ -3862,11 +3864,15 @@ int mlx5_devlink_eswitch_inline_mode_set(struct devlink *devlink, u8 mode,
 	if (err)
 		goto out;
 
+	esw->eswitch_operation_in_progress = true;
+	up_write(&esw->mode_lock);
+
 	err = mlx5_esw_vports_inline_set(esw, mlx5_mode, extack);
-	if (err)
-		goto out;
+	if (!err)
+		esw->offloads.inline_mode = mlx5_mode;
 
-	esw->offloads.inline_mode = mlx5_mode;
+	down_write(&esw->mode_lock);
+	esw->eswitch_operation_in_progress = false;
 	up_write(&esw->mode_lock);
 	return 0;
 
@@ -3878,16 +3884,12 @@ int mlx5_devlink_eswitch_inline_mode_set(struct devlink *devlink, u8 mode,
 int mlx5_devlink_eswitch_inline_mode_get(struct devlink *devlink, u8 *mode)
 {
 	struct mlx5_eswitch *esw;
-	int err;
 
 	esw = mlx5_devlink_eswitch_get(devlink);
 	if (IS_ERR(esw))
 		return PTR_ERR(esw);
 
-	down_read(&esw->mode_lock);
-	err = esw_inline_mode_to_devlink(esw->offloads.inline_mode, mode);
-	up_read(&esw->mode_lock);
-	return err;
+	return esw_inline_mode_to_devlink(esw->offloads.inline_mode, mode);
 }
 
 bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev)
@@ -3969,6 +3971,9 @@ int mlx5_devlink_eswitch_encap_mode_set(struct devlink *devlink,
 		goto unlock;
 	}
 
+	esw->eswitch_operation_in_progress = true;
+	up_write(&esw->mode_lock);
+
 	esw_destroy_offloads_fdb_tables(esw);
 
 	esw->offloads.encap = encap;
@@ -3982,6 +3987,9 @@ int mlx5_devlink_eswitch_encap_mode_set(struct devlink *devlink,
 		(void)esw_create_offloads_fdb_tables(esw);
 	}
 
+	down_write(&esw->mode_lock);
+	esw->eswitch_operation_in_progress = false;
+
 unlock:
 	up_write(&esw->mode_lock);
 	return err;
@@ -3996,9 +4004,7 @@ int mlx5_devlink_eswitch_encap_mode_get(struct devlink *devlink,
 	if (IS_ERR(esw))
 		return PTR_ERR(esw);
 
-	down_read(&esw->mode_lock);
 	*encap = esw->offloads.encap;
-	up_read(&esw->mode_lock);
 	return 0;
 }
 
-- 
2.43.0





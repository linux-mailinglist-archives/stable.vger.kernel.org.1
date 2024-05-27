Return-Path: <stable+bounces-46826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCAB8D0B6E
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51E46B22951
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E50361FCD;
	Mon, 27 May 2024 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Iy9RVng7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0806517E90E;
	Mon, 27 May 2024 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836954; cv=none; b=nu9Zafl+eElgyhul0UuDPGbBI6JFYo5gRxcfjh7QR1wCXaQCYXtv7UURgRxziL4cknzxhPK+InXDaJIeyfzWgPtYD9riVI07B6FNWIvpQ0Vi2AHl7sA1lcvKFRxU4fH4NJ4lVh2pbP6z6+Xa2KPCkAxm3Mnqku9hoayhtkb/yRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836954; c=relaxed/simple;
	bh=yk+uYyyFMcMYDfOafL+6i0D3mqU685zHbOJaL3+DtS4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8DxwU4IwXAUpNGHZuo8WyBPt2WL5stfLevqWEHXxoDX4JW+CXJ/WBSHFMnBeZBLpDuVMJOnBhWpn8dp/wWcLRPlkDfpeOg7fnMiYYa4qBIwV9Qm3RJstGSifJWZG3NgL+lrWO9BjfaVQoB+Os4HTD/PiXUecrdu2q9BhQWTHQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Iy9RVng7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5CCC2BBFC;
	Mon, 27 May 2024 19:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836953;
	bh=yk+uYyyFMcMYDfOafL+6i0D3mqU685zHbOJaL3+DtS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iy9RVng7HuGbyk6ISFCKMjfmUvpc66ZE4iDswICu9d5ySdMO1MPZkGr8mUcSvHSNk
	 gNX4Lgg9deDL3Osoz5+7KMf0whezDC9G26953cyDYcYINqPklUuX4QhQjNZ67SqzTG
	 0FyjNzZUuEVW8l7pvI5JJFihvcOlGqlziPk0pemw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mark Bloch <mbloch@nvidia.com>,
	Maher Sanalla <msanalla@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 253/427] net/mlx5: Reload only IB representors upon lag disable/enable
Date: Mon, 27 May 2024 20:55:00 +0200
Message-ID: <20240527185626.185445386@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maher Sanalla <msanalla@nvidia.com>

[ Upstream commit 0f06228d4a2dcc1fca5b3ddb0eefa09c05b102c4 ]

On lag disable, the bond IB device along with all of its
representors are destroyed, and then the slaves' representors get reloaded.

In case the slave IB representor load fails, the eswitch error flow
unloads all representors, including ethernet representors, where the
netdevs get detached and removed from lag bond. Such flow is inaccurate
as the lag driver is not responsible for loading/unloading ethernet
representors. Furthermore, the flow described above begins by holding
lag lock to prevent bond changes during disable flow. However, when
reaching the ethernet representors detachment from lag, the lag lock is
required again, triggering the following deadlock:

Call trace:
__switch_to+0xf4/0x148
__schedule+0x2c8/0x7d0
schedule+0x50/0xe0
schedule_preempt_disabled+0x18/0x28
__mutex_lock.isra.13+0x2b8/0x570
__mutex_lock_slowpath+0x1c/0x28
mutex_lock+0x4c/0x68
mlx5_lag_remove_netdev+0x3c/0x1a0 [mlx5_core]
mlx5e_uplink_rep_disable+0x70/0xa0 [mlx5_core]
mlx5e_detach_netdev+0x6c/0xb0 [mlx5_core]
mlx5e_netdev_change_profile+0x44/0x138 [mlx5_core]
mlx5e_netdev_attach_nic_profile+0x28/0x38 [mlx5_core]
mlx5e_vport_rep_unload+0x184/0x1b8 [mlx5_core]
mlx5_esw_offloads_rep_load+0xd8/0xe0 [mlx5_core]
mlx5_eswitch_reload_reps+0x74/0xd0 [mlx5_core]
mlx5_disable_lag+0x130/0x138 [mlx5_core]
mlx5_lag_disable_change+0x6c/0x70 [mlx5_core] // hold ldev->lock
mlx5_devlink_eswitch_mode_set+0xc0/0x410 [mlx5_core]
devlink_nl_cmd_eswitch_set_doit+0xdc/0x180
genl_family_rcv_msg_doit.isra.17+0xe8/0x138
genl_rcv_msg+0xe4/0x220
netlink_rcv_skb+0x44/0x108
genl_rcv+0x40/0x58
netlink_unicast+0x198/0x268
netlink_sendmsg+0x1d4/0x418
sock_sendmsg+0x54/0x60
__sys_sendto+0xf4/0x120
__arm64_sys_sendto+0x30/0x40
el0_svc_common+0x8c/0x120
do_el0_svc+0x30/0xa0
el0_svc+0x20/0x30
el0_sync_handler+0x90/0xb8
el0_sync+0x160/0x180

Thus, upon lag enable/disable, load and unload only the IB representors
of the slaves preventing the deadlock mentioned above.

While at it, refactor the mlx5_esw_offloads_rep_load() function to have
a static helper method for its internal logic, in symmetry with the
representor unload design.

Fixes: 598fe77df855 ("net/mlx5: Lag, Create shared FDB when in switchdev mode")
Co-developed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240509112951.590184-4-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  4 +--
 .../mellanox/mlx5/core/eswitch_offloads.c     | 28 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c |  6 ++--
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |  4 +--
 4 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 349e28a6dd8df..ef55674876cb4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -833,7 +833,7 @@ int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
 					     struct mlx5_eswitch *slave_esw, int max_slaves);
 void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 					      struct mlx5_eswitch *slave_esw);
-int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw);
+int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw);
 
 bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev);
 void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev);
@@ -925,7 +925,7 @@ mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 static inline int mlx5_eswitch_get_npeers(struct mlx5_eswitch *esw) { return 0; }
 
 static inline int
-mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
+mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 {
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 844d3e3a65ddf..e8caf12f4c4f8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2502,6 +2502,16 @@ void esw_offloads_cleanup(struct mlx5_eswitch *esw)
 	esw_offloads_cleanup_reps(esw);
 }
 
+static int __esw_offloads_load_rep(struct mlx5_eswitch *esw,
+				   struct mlx5_eswitch_rep *rep, u8 rep_type)
+{
+	if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
+			   REP_REGISTERED, REP_LOADED) == REP_REGISTERED)
+		return esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
+
+	return 0;
+}
+
 static void __esw_offloads_unload_rep(struct mlx5_eswitch *esw,
 				      struct mlx5_eswitch_rep *rep, u8 rep_type)
 {
@@ -2526,13 +2536,11 @@ static int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num)
 	int err;
 
 	rep = mlx5_eswitch_get_rep(esw, vport_num);
-	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++)
-		if (atomic_cmpxchg(&rep->rep_data[rep_type].state,
-				   REP_REGISTERED, REP_LOADED) == REP_REGISTERED) {
-			err = esw->offloads.rep_ops[rep_type]->load(esw->dev, rep);
-			if (err)
-				goto err_reps;
-		}
+	for (rep_type = 0; rep_type < NUM_REP_TYPES; rep_type++) {
+		err = __esw_offloads_load_rep(esw, rep, rep_type);
+		if (err)
+			goto err_reps;
+	}
 
 	return 0;
 
@@ -3277,7 +3285,7 @@ static void esw_destroy_offloads_acl_tables(struct mlx5_eswitch *esw)
 		esw_vport_destroy_offloads_acl_tables(esw, vport);
 }
 
-int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
+int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 {
 	struct mlx5_eswitch_rep *rep;
 	unsigned long i;
@@ -3290,13 +3298,13 @@ int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
 	if (atomic_read(&rep->rep_data[REP_ETH].state) != REP_LOADED)
 		return 0;
 
-	ret = mlx5_esw_offloads_rep_load(esw, MLX5_VPORT_UPLINK);
+	ret = __esw_offloads_load_rep(esw, rep, REP_IB);
 	if (ret)
 		return ret;
 
 	mlx5_esw_for_each_rep(esw, i, rep) {
 		if (atomic_read(&rep->rep_data[REP_ETH].state) == REP_LOADED)
-			mlx5_esw_offloads_rep_load(esw, rep->vport);
+			__esw_offloads_load_rep(esw, rep, REP_IB);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index 69d482f7c5a29..37598d116f3b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -814,7 +814,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 	if (shared_fdb)
 		for (i = 0; i < ldev->ports; i++)
 			if (!(ldev->pf[i].dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_ALL_ADEV))
-				mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+				mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 }
 
 static bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev)
@@ -922,7 +922,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 			mlx5_rescan_drivers_locked(dev0);
 
 			for (i = 0; i < ldev->ports; i++) {
-				err = mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+				err = mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 				if (err)
 					break;
 			}
@@ -933,7 +933,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 				mlx5_deactivate_lag(ldev);
 				mlx5_lag_add_devices(ldev);
 				for (i = 0; i < ldev->ports; i++)
-					mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+					mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 				mlx5_core_err(dev0, "Failed to enable lag\n");
 				return;
 			}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index 82889f30506ea..571ea26edd0ca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -99,7 +99,7 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 	dev0->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
 	mlx5_rescan_drivers_locked(dev0);
 	for (i = 0; i < ldev->ports; i++) {
-		err = mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+		err = mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 		if (err)
 			goto err_rescan_drivers;
 	}
@@ -113,7 +113,7 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 err_add_devices:
 	mlx5_lag_add_devices(ldev);
 	for (i = 0; i < ldev->ports; i++)
-		mlx5_eswitch_reload_reps(ldev->pf[i].dev->priv.eswitch);
+		mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 	mlx5_mpesw_metadata_cleanup(ldev);
 	return err;
 }
-- 
2.43.0





Return-Path: <stable+bounces-49116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F648FEBED
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F171C24311
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24841E886;
	Thu,  6 Jun 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ez9rTSoZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13ED1AC220;
	Thu,  6 Jun 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683309; cv=none; b=IjaLfByehwP91HVgLhKpOCWP9kcJwwv39tHEecvM90hWgwXYY67K6eZ9h9TbMG+B9CWDkhAGSWMHoh77u9FfYjEh4xFA5V3yPuuagcpJ0O/9cKebWLeWpdJbifxV1uGWSflUEzTbQ4PQ/POg0Hs1m7pr6IyMz0mYyqh3ils3tD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683309; c=relaxed/simple;
	bh=zObzfjlMTizUj+5lKNkdZyKqr80uTFdwNm34s6Su/gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uw6Fb6lv1cOJjFvzquBzxdjqi6FHIatYgMopE770Tk9749GVb3LKtq+qvDDphxEzOhOk5zLszASabBUI7DjSFKVqtgonGaZJmc4Y84iM5bG5sm22esf3fp+DMIIFrmQ8d5GxoR9gMNkFS6Ip4wXUo86BSmZ5DJUTkHgEXpMYTxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ez9rTSoZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914B3C2BD10;
	Thu,  6 Jun 2024 14:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683309;
	bh=zObzfjlMTizUj+5lKNkdZyKqr80uTFdwNm34s6Su/gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ez9rTSoZGhQ/MyiebhgYMx6/vdQ/Gh8Owa1w5lr2NAjSUrLClEz57ibtqavYmUjdu
	 gsrQ3vskINw/Cl8nW0CWXP9/3pqkgzHERt8jgUI+ZHaFKYQpThdgi70PiItUCHhHte
	 O2zcecFaUpka2gVfrLgqJ5WLliWu8sbcz/qHqRew=
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
Subject: [PATCH 6.6 250/744] net/mlx5: Reload only IB representors upon lag disable/enable
Date: Thu,  6 Jun 2024 15:58:42 +0200
Message-ID: <20240606131740.415941062@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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
index b4eb17141edf3..9b771b572593b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -840,7 +840,7 @@ int mlx5_eswitch_offloads_single_fdb_add_one(struct mlx5_eswitch *master_esw,
 					     struct mlx5_eswitch *slave_esw, int max_slaves);
 void mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 					      struct mlx5_eswitch *slave_esw);
-int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw);
+int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw);
 
 bool mlx5_eswitch_block_encap(struct mlx5_core_dev *dev);
 void mlx5_eswitch_unblock_encap(struct mlx5_core_dev *dev);
@@ -932,7 +932,7 @@ mlx5_eswitch_offloads_single_fdb_del_one(struct mlx5_eswitch *master_esw,
 static inline int mlx5_eswitch_get_npeers(struct mlx5_eswitch *esw) { return 0; }
 
 static inline int
-mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
+mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 {
 	return 0;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index e3cce110e52fd..58529d1a98b37 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2501,6 +2501,16 @@ void esw_offloads_cleanup(struct mlx5_eswitch *esw)
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
@@ -2525,13 +2535,11 @@ static int mlx5_esw_offloads_rep_load(struct mlx5_eswitch *esw, u16 vport_num)
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
 
@@ -3276,7 +3284,7 @@ static void esw_destroy_offloads_acl_tables(struct mlx5_eswitch *esw)
 		esw_vport_destroy_offloads_acl_tables(esw, vport);
 }
 
-int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
+int mlx5_eswitch_reload_ib_reps(struct mlx5_eswitch *esw)
 {
 	struct mlx5_eswitch_rep *rep;
 	unsigned long i;
@@ -3289,13 +3297,13 @@ int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
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
index e51cac1e1811e..9b05061a759cc 100644
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
index 0857eebf4f07b..6b0413a3987ce 100644
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





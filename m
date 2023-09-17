Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC827A39A1
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240125AbjIQTwD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240177AbjIQTvw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:51:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17196191
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:51:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C311C433C7;
        Sun, 17 Sep 2023 19:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980302;
        bh=ayTrQ1NoHQKL+3H+hDVVhkkUrJvtqbPoT9lLQjBL1vo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hGctXBGxUieMD0fVI+qa6WH8GZUTpUGjOAqRZzYuTagI12xiDU8gIPMJHFxDg+KAq
         K0aLrfgdW/p5ousOg4K+acNDsTycUOACGuAx4R2ohd60uFBIcdSVJsWdoyL6lwiVKC
         7YYHJcqVfDLcPn+nolZ+r9KJIa/2gm7NRy1NBOJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bodong Wang <bodong@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 152/285] mlx5/core: E-Switch, Create ACL FT for eswitch manager in switchdev mode
Date:   Sun, 17 Sep 2023 21:12:32 +0200
Message-ID: <20230917191056.945483055@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bodong Wang <bodong@nvidia.com>

[ Upstream commit 344134609a564f28b3cc81ca6650319ccd5d8961 ]

ACL flow table is required in switchdev mode when metadata is enabled,
driver creates such table when loading each vport. However, not every
vport is loaded in switchdev mode. Such as ECPF if it's the eswitch manager.
In this case, ACL flow table is still needed.

To make it modularized, create ACL flow table for eswitch manager as
default and skip such operations when loading manager vport.

Also, there is no need to load the eswitch manager vport in switchdev mode.
This means there is no need to load it on regular connect-x HCAs where
the PF is the eswitch manager. This will avoid creating duplicate ACL
flow table for host PF vport.

Fixes: 29bcb6e4fe70 ("net/mlx5e: E-Switch, Use metadata for vport matching in send-to-vport rules")
Fixes: eb8e9fae0a22 ("mlx5/core: E-Switch, Allocate ECPF vport if it's an eswitch manager")
Fixes: 5019833d661f ("net/mlx5: E-switch, Introduce helper function to enable/disable vports")
Signed-off-by: Bodong Wang <bodong@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 21 ++++++--
 .../mellanox/mlx5/core/eswitch_offloads.c     | 49 +++++++++++++------
 2 files changed, 51 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 591184d892af6..6e9b1b183190d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1212,12 +1212,19 @@ int
 mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 				 enum mlx5_eswitch_vport_event enabled_events)
 {
+	bool pf_needed;
 	int ret;
 
+	pf_needed = mlx5_core_is_ecpf_esw_manager(esw->dev) ||
+		    esw->mode == MLX5_ESWITCH_LEGACY;
+
 	/* Enable PF vport */
-	ret = mlx5_eswitch_load_pf_vf_vport(esw, MLX5_VPORT_PF, enabled_events);
-	if (ret)
-		return ret;
+	if (pf_needed) {
+		ret = mlx5_eswitch_load_pf_vf_vport(esw, MLX5_VPORT_PF,
+						    enabled_events);
+		if (ret)
+			return ret;
+	}
 
 	/* Enable external host PF HCA */
 	ret = host_pf_enable_hca(esw->dev);
@@ -1253,7 +1260,8 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 ecpf_err:
 	host_pf_disable_hca(esw->dev);
 pf_hca_err:
-	mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
+	if (pf_needed)
+		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
 	return ret;
 }
 
@@ -1271,7 +1279,10 @@ void mlx5_eswitch_disable_pf_vf_vports(struct mlx5_eswitch *esw)
 	}
 
 	host_pf_disable_hca(esw->dev);
-	mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
+
+	if (mlx5_core_is_ecpf_esw_manager(esw->dev) ||
+	    esw->mode == MLX5_ESWITCH_LEGACY)
+		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
 }
 
 static void mlx5_eswitch_get_devlink_param(struct mlx5_eswitch *esw)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 2f8bab73643e2..1ad5a72dcc3fd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3092,26 +3092,47 @@ esw_vport_destroy_offloads_acl_tables(struct mlx5_eswitch *esw,
 	esw_acl_ingress_ofld_cleanup(esw, vport);
 }
 
-static int esw_create_uplink_offloads_acl_tables(struct mlx5_eswitch *esw)
+static int esw_create_offloads_acl_tables(struct mlx5_eswitch *esw)
 {
-	struct mlx5_vport *vport;
+	struct mlx5_vport *uplink, *manager;
+	int ret;
 
-	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
-	if (IS_ERR(vport))
-		return PTR_ERR(vport);
+	uplink = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
+	if (IS_ERR(uplink))
+		return PTR_ERR(uplink);
+
+	ret = esw_vport_create_offloads_acl_tables(esw, uplink);
+	if (ret)
+		return ret;
+
+	manager = mlx5_eswitch_get_vport(esw, esw->manager_vport);
+	if (IS_ERR(manager)) {
+		ret = PTR_ERR(manager);
+		goto err_manager;
+	}
 
-	return esw_vport_create_offloads_acl_tables(esw, vport);
+	ret = esw_vport_create_offloads_acl_tables(esw, manager);
+	if (ret)
+		goto err_manager;
+
+	return 0;
+
+err_manager:
+	esw_vport_destroy_offloads_acl_tables(esw, uplink);
+	return ret;
 }
 
-static void esw_destroy_uplink_offloads_acl_tables(struct mlx5_eswitch *esw)
+static void esw_destroy_offloads_acl_tables(struct mlx5_eswitch *esw)
 {
 	struct mlx5_vport *vport;
 
-	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
-	if (IS_ERR(vport))
-		return;
+	vport = mlx5_eswitch_get_vport(esw, esw->manager_vport);
+	if (!IS_ERR(vport))
+		esw_vport_destroy_offloads_acl_tables(esw, vport);
 
-	esw_vport_destroy_offloads_acl_tables(esw, vport);
+	vport = mlx5_eswitch_get_vport(esw, MLX5_VPORT_UPLINK);
+	if (!IS_ERR(vport))
+		esw_vport_destroy_offloads_acl_tables(esw, vport);
 }
 
 int mlx5_eswitch_reload_reps(struct mlx5_eswitch *esw)
@@ -3156,7 +3177,7 @@ static int esw_offloads_steering_init(struct mlx5_eswitch *esw)
 	}
 	esw->fdb_table.offloads.indir = indir;
 
-	err = esw_create_uplink_offloads_acl_tables(esw);
+	err = esw_create_offloads_acl_tables(esw);
 	if (err)
 		goto create_acl_err;
 
@@ -3197,7 +3218,7 @@ static int esw_offloads_steering_init(struct mlx5_eswitch *esw)
 create_restore_err:
 	esw_destroy_offloads_table(esw);
 create_offloads_err:
-	esw_destroy_uplink_offloads_acl_tables(esw);
+	esw_destroy_offloads_acl_tables(esw);
 create_acl_err:
 	mlx5_esw_indir_table_destroy(esw->fdb_table.offloads.indir);
 create_indir_err:
@@ -3213,7 +3234,7 @@ static void esw_offloads_steering_cleanup(struct mlx5_eswitch *esw)
 	esw_destroy_offloads_fdb_tables(esw);
 	esw_destroy_restore_table(esw);
 	esw_destroy_offloads_table(esw);
-	esw_destroy_uplink_offloads_acl_tables(esw);
+	esw_destroy_offloads_acl_tables(esw);
 	mlx5_esw_indir_table_destroy(esw->fdb_table.offloads.indir);
 	mutex_destroy(&esw->fdb_table.offloads.vports.lock);
 }
-- 
2.40.1




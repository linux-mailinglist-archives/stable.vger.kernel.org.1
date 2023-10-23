Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF947D32F7
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjJWLZZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbjJWLZY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:25:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EFCFD
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:25:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E93C433C7;
        Mon, 23 Oct 2023 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698060321;
        bh=B5/betQe2hIp2hYxYZeYiAhLjWgS4hEhkSfILdEM43o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DoQAgdQMndrWRtGoF9jzMwiwwY7FUZNoX6e1WuC4hWuXW1SKRDPGUSVbbBern5SII
         H5u0MIHRuLflJA0vj6znttj7o6DXV9DNMtuwk1xPu3jDeslaUJSGkqbiwfQBfvOnIl
         VNSaVs+Q5SlMK4rOGnndK/0TaHusKpxqN/q2eGcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Shay Drory <shayd@nvidia.com>,
        Mark Bloch <mbloch@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 132/196] net/mlx5: E-switch, register event handler before arming the event
Date:   Mon, 23 Oct 2023 12:56:37 +0200
Message-ID: <20231023104832.224137955@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104828.488041585@linuxfoundation.org>
References: <20231023104828.488041585@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit 7624e58a8b3a251e3e5108b32f2183b34453db32 ]

Currently, mlx5 is registering event handler for vport context change
event some time after arming the event. this can lead to missing an
event, which will result in wrong rules in the FDB.
Hence, register the event handler before arming the event.

This solution is valid since FW is sending vport context change event
only on vports which SW armed, and SW arming the vport when enabling
it, which is done after the FDB has been created.

Fixes: 6933a9379559 ("net/mlx5: E-Switch, Use async events chain")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c   | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 4b9d567c8f473..48939c72b5925 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -969,11 +969,8 @@ const u32 *mlx5_esw_query_functions(struct mlx5_core_dev *dev)
 	return ERR_PTR(err);
 }
 
-static void mlx5_eswitch_event_handlers_register(struct mlx5_eswitch *esw)
+static void mlx5_eswitch_event_handler_register(struct mlx5_eswitch *esw)
 {
-	MLX5_NB_INIT(&esw->nb, eswitch_vport_event, NIC_VPORT_CHANGE);
-	mlx5_eq_notifier_register(esw->dev, &esw->nb);
-
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS && mlx5_eswitch_is_funcs_handler(esw->dev)) {
 		MLX5_NB_INIT(&esw->esw_funcs.nb, mlx5_esw_funcs_changed_handler,
 			     ESW_FUNCTIONS_CHANGED);
@@ -981,13 +978,11 @@ static void mlx5_eswitch_event_handlers_register(struct mlx5_eswitch *esw)
 	}
 }
 
-static void mlx5_eswitch_event_handlers_unregister(struct mlx5_eswitch *esw)
+static void mlx5_eswitch_event_handler_unregister(struct mlx5_eswitch *esw)
 {
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS && mlx5_eswitch_is_funcs_handler(esw->dev))
 		mlx5_eq_notifier_unregister(esw->dev, &esw->esw_funcs.nb);
 
-	mlx5_eq_notifier_unregister(esw->dev, &esw->nb);
-
 	flush_workqueue(esw->work_queue);
 }
 
@@ -1273,6 +1268,9 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 
 	mlx5_eswitch_update_num_of_vfs(esw, num_vfs);
 
+	MLX5_NB_INIT(&esw->nb, eswitch_vport_event, NIC_VPORT_CHANGE);
+	mlx5_eq_notifier_register(esw->dev, &esw->nb);
+
 	if (esw->mode == MLX5_ESWITCH_LEGACY) {
 		err = esw_legacy_enable(esw);
 	} else {
@@ -1285,7 +1283,7 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 
 	esw->fdb_table.flags |= MLX5_ESW_FDB_CREATED;
 
-	mlx5_eswitch_event_handlers_register(esw);
+	mlx5_eswitch_event_handler_register(esw);
 
 	esw_info(esw->dev, "Enable: mode(%s), nvfs(%d), active vports(%d)\n",
 		 esw->mode == MLX5_ESWITCH_LEGACY ? "LEGACY" : "OFFLOADS",
@@ -1394,7 +1392,8 @@ void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw)
 	 */
 	mlx5_esw_mode_change_notify(esw, MLX5_ESWITCH_LEGACY);
 
-	mlx5_eswitch_event_handlers_unregister(esw);
+	mlx5_eq_notifier_unregister(esw->dev, &esw->nb);
+	mlx5_eswitch_event_handler_unregister(esw);
 
 	esw_info(esw->dev, "Disable: mode(%s), nvfs(%d), active vports(%d)\n",
 		 esw->mode == MLX5_ESWITCH_LEGACY ? "LEGACY" : "OFFLOADS",
-- 
2.40.1




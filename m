Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ADA7E23F6
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjKFNQm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbjKFNQl (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:16:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE0EF3
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:16:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABDAC433C7;
        Mon,  6 Nov 2023 13:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276598;
        bh=Fq6DtAkth+1duKIYRtXzPe1IbfuDLwCn/3k1EzDrzsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gjvMERDjCh0LtK/gO0qsLM40G3sKd4tEcuoqD/6jMx14XT7D38iv6p7WJTYfAjpNl
         oqo4DHIEIu4Ww6MQpNORL0TggKI59RECE+9mdetxguC4sLnAF8yvo1kOM7dSru0M5x
         SFvti26zeU5KLMYybvnT2hO02v7XbulFLHpeFTuQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Vlad Buslov <vladbu@nvidia.com>,
        Jianbo Liu <jianbol@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 33/88] net/mlx5: Bridge, fix peer entry ageing in LAG mode
Date:   Mon,  6 Nov 2023 14:03:27 +0100
Message-ID: <20231106130307.007507734@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vlad Buslov <vladbu@nvidia.com>

[ Upstream commit 7a3ce8074878a68a75ceacec93d9ae05906eec86 ]

With current implementation in single FDB LAG mode all packets are
processed by eswitch 0 rules. As such, 'peer' FDB entries receive the
packets for rules of other eswitches and are responsible for updating the
main entry by sending SWITCHDEV_FDB_ADD_TO_BRIDGE notification from their
background update wq task. However, this introduces a race condition when
non-zero eswitch instance decides to delete a FDB entry, sends
SWITCHDEV_FDB_DEL_TO_BRIDGE notification, but another eswitch's update task
refreshes the same entry concurrently while its async delete work is still
pending on the workque. In such case another SWITCHDEV_FDB_ADD_TO_BRIDGE
event may be generated and entry will remain stuck in FDB marked as
'offloaded' since no more SWITCHDEV_FDB_DEL_TO_BRIDGE notifications are
sent for deleting the peer entries.

Fix the issue by synchronously marking deleted entries with
MLX5_ESW_BRIDGE_FLAG_DELETED flag and skipping them in background update
job.

Signed-off-by: Vlad Buslov <vladbu@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/en/rep/bridge.c        | 11 ++++++++
 .../ethernet/mellanox/mlx5/core/esw/bridge.c  | 25 ++++++++++++++++++-
 .../ethernet/mellanox/mlx5/core/esw/bridge.h  |  3 +++
 .../mellanox/mlx5/core/esw/bridge_priv.h      |  1 +
 4 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index 5608002465734..285c13edc09f0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -463,6 +463,17 @@ static int mlx5_esw_bridge_switchdev_event(struct notifier_block *nb,
 		/* only handle the event on peers */
 		if (mlx5_esw_bridge_is_local(dev, rep, esw))
 			break;
+
+		fdb_info = container_of(info,
+					struct switchdev_notifier_fdb_info,
+					info);
+		/* Mark for deletion to prevent the update wq task from
+		 * spuriously refreshing the entry which would mark it again as
+		 * offloaded in SW bridge. After this fallthrough to regular
+		 * async delete code.
+		 */
+		mlx5_esw_bridge_fdb_mark_deleted(dev, vport_num, esw_owner_vhca_id, br_offloads,
+						 fdb_info);
 		fallthrough;
 	case SWITCHDEV_FDB_ADD_TO_DEVICE:
 	case SWITCHDEV_FDB_DEL_TO_DEVICE:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
index f4fe1daa4afd5..de1ed59239da8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.c
@@ -1748,6 +1748,28 @@ void mlx5_esw_bridge_fdb_update_used(struct net_device *dev, u16 vport_num, u16
 	entry->lastuse = jiffies;
 }
 
+void mlx5_esw_bridge_fdb_mark_deleted(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
+				      struct mlx5_esw_bridge_offloads *br_offloads,
+				      struct switchdev_notifier_fdb_info *fdb_info)
+{
+	struct mlx5_esw_bridge_fdb_entry *entry;
+	struct mlx5_esw_bridge *bridge;
+
+	bridge = mlx5_esw_bridge_from_port_lookup(vport_num, esw_owner_vhca_id, br_offloads);
+	if (!bridge)
+		return;
+
+	entry = mlx5_esw_bridge_fdb_lookup(bridge, fdb_info->addr, fdb_info->vid);
+	if (!entry) {
+		esw_debug(br_offloads->esw->dev,
+			  "FDB mark deleted entry with specified key not found (MAC=%pM,vid=%u,vport=%u)\n",
+			  fdb_info->addr, fdb_info->vid, vport_num);
+		return;
+	}
+
+	entry->flags |= MLX5_ESW_BRIDGE_FLAG_DELETED;
+}
+
 void mlx5_esw_bridge_fdb_create(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
 				struct mlx5_esw_bridge_offloads *br_offloads,
 				struct switchdev_notifier_fdb_info *fdb_info)
@@ -1810,7 +1832,8 @@ void mlx5_esw_bridge_update(struct mlx5_esw_bridge_offloads *br_offloads)
 			unsigned long lastuse =
 				(unsigned long)mlx5_fc_query_lastuse(entry->ingress_counter);
 
-			if (entry->flags & MLX5_ESW_BRIDGE_FLAG_ADDED_BY_USER)
+			if (entry->flags & (MLX5_ESW_BRIDGE_FLAG_ADDED_BY_USER |
+					    MLX5_ESW_BRIDGE_FLAG_DELETED))
 				continue;
 
 			if (time_after(lastuse, entry->lastuse))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
index c2c7c70d99eb7..d6f5391619930 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge.h
@@ -62,6 +62,9 @@ int mlx5_esw_bridge_vport_peer_unlink(struct net_device *br_netdev, u16 vport_nu
 void mlx5_esw_bridge_fdb_update_used(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
 				     struct mlx5_esw_bridge_offloads *br_offloads,
 				     struct switchdev_notifier_fdb_info *fdb_info);
+void mlx5_esw_bridge_fdb_mark_deleted(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
+				      struct mlx5_esw_bridge_offloads *br_offloads,
+				      struct switchdev_notifier_fdb_info *fdb_info);
 void mlx5_esw_bridge_fdb_create(struct net_device *dev, u16 vport_num, u16 esw_owner_vhca_id,
 				struct mlx5_esw_bridge_offloads *br_offloads,
 				struct switchdev_notifier_fdb_info *fdb_info);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h
index 4911cc32161b4..7c251af566c6f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/bridge_priv.h
@@ -133,6 +133,7 @@ struct mlx5_esw_bridge_mdb_key {
 enum {
 	MLX5_ESW_BRIDGE_FLAG_ADDED_BY_USER = BIT(0),
 	MLX5_ESW_BRIDGE_FLAG_PEER = BIT(1),
+	MLX5_ESW_BRIDGE_FLAG_DELETED = BIT(2),
 };
 
 enum {
-- 
2.42.0




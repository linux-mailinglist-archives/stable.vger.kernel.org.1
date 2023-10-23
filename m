Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EC97D3179
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjJWLJf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjJWLJf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:09:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE67DC2
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:09:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08ED5C433C7;
        Mon, 23 Oct 2023 11:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059372;
        bh=Z/pKTflNtGeXr2t8UWZdBjF7NhHlzpzvAMri5hezy/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TGym+TqpGmMefFeGGUT99kOeWBKhWSNaG9zQWSrWuXTXT5IHdH3Ya15LSVHkZo0cn
         4t5H84jOdDbFNqPIi/UFFwaUxzaMg1e9hCr3yXIFrw+V5OHklia4xhFt08xQJXFyFP
         +4WD69/IFpALZYd7nkGbRqdYwdvIRBv0Q3vNm08o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Patrisious Haddad <phaddad@nvidia.com>,
        Amir Tzin <amirtz@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 156/241] net/mlx5e: Fix VF representors reporting zero counters to "ip -s" command
Date:   Mon, 23 Oct 2023 12:55:42 +0200
Message-ID: <20231023104837.675945130@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Tzin <amirtz@nvidia.com>

[ Upstream commit 80f1241484dd1b1d4eab1a0211d52ec2bd83e2f1 ]

Although vf_vport entry of struct mlx5e_stats is never updated, its
values are mistakenly copied to the caller structure in the VF
representor .ndo_get_stat_64 callback mlx5e_rep_get_stats(). Remove
redundant entry and use the updated one, rep_stats, instead.

Fixes: 64b68e369649 ("net/mlx5: Refactor and expand rep vport stat group")
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.h | 11 ++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  5 +++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 5bdd2d09a8d5c..0cd44ef190058 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -704,7 +704,7 @@ mlx5e_rep_get_stats(struct net_device *dev, struct rtnl_link_stats64 *stats)
 
 	/* update HW stats in background for next time */
 	mlx5e_queue_update_stats(priv);
-	memcpy(stats, &priv->stats.vf_vport, sizeof(*stats));
+	mlx5e_stats_copy_rep_stats(stats, &priv->stats.rep_stats);
 }
 
 static int mlx5e_rep_change_mtu(struct net_device *netdev, int new_mtu)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 1ff8a06027dcf..67938b4ea1b90 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -475,11 +475,20 @@ struct mlx5e_stats {
 	struct mlx5e_vnic_env_stats vnic;
 	struct mlx5e_vport_stats vport;
 	struct mlx5e_pport_stats pport;
-	struct rtnl_link_stats64 vf_vport;
 	struct mlx5e_pcie_stats pcie;
 	struct mlx5e_rep_stats rep_stats;
 };
 
+static inline void mlx5e_stats_copy_rep_stats(struct rtnl_link_stats64 *vf_vport,
+					      struct mlx5e_rep_stats *rep_stats)
+{
+	memset(vf_vport, 0, sizeof(*vf_vport));
+	vf_vport->rx_packets = rep_stats->vport_rx_packets;
+	vf_vport->tx_packets = rep_stats->vport_tx_packets;
+	vf_vport->rx_bytes = rep_stats->vport_rx_bytes;
+	vf_vport->tx_bytes = rep_stats->vport_tx_bytes;
+}
+
 extern mlx5e_stats_grp_t mlx5e_nic_stats_grps[];
 unsigned int mlx5e_nic_stats_grps_num(struct mlx5e_priv *priv);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 4b22a91482cec..5797d8607633e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -4931,7 +4931,8 @@ static int scan_tc_matchall_fdb_actions(struct mlx5e_priv *priv,
 			if (err)
 				return err;
 
-			rpriv->prev_vf_vport_stats = priv->stats.vf_vport;
+			mlx5e_stats_copy_rep_stats(&rpriv->prev_vf_vport_stats,
+						   &priv->stats.rep_stats);
 			break;
 		default:
 			NL_SET_ERR_MSG_MOD(extack, "mlx5 supports only police action for matchall");
@@ -4971,7 +4972,7 @@ void mlx5e_tc_stats_matchall(struct mlx5e_priv *priv,
 	u64 dbytes;
 	u64 dpkts;
 
-	cur_stats = priv->stats.vf_vport;
+	mlx5e_stats_copy_rep_stats(&cur_stats, &priv->stats.rep_stats);
 	dpkts = cur_stats.rx_packets - rpriv->prev_vf_vport_stats.rx_packets;
 	dbytes = cur_stats.rx_bytes - rpriv->prev_vf_vport_stats.rx_bytes;
 	rpriv->prev_vf_vport_stats = cur_stats;
-- 
2.40.1




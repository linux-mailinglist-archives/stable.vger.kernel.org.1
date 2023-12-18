Return-Path: <stable+bounces-7275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37AFC8171CB
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE1222842C0
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC773788D;
	Mon, 18 Dec 2023 14:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jl9KtiOD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B961D13B;
	Mon, 18 Dec 2023 14:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034CAC433C8;
	Mon, 18 Dec 2023 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908029;
	bh=ha7DwolEqwHHx5XeEhXnbjEq9k7keJrqZOnQZ8E8Vgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jl9KtiODyK2KHwqtt4raHv4kXguUHBXBsAfAbONOFcMMYFU/WzKony3uGpN+fPOhs
	 xhKamV4uw8RibI5QYQQNI8xSygb3wBM71QjgFhj1xOJXJkUEiElHdYox1MNTBIV9Np
	 S0irqvj+0EhcrD3PIEmcixhVkkwLpzCUNnBRC7cM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Patrisious Haddad <phaddad@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 009/166] net/mlx5e: Unify esw and normal IPsec status table creation/destruction
Date: Mon, 18 Dec 2023 14:49:35 +0100
Message-ID: <20231218135105.373904971@linuxfoundation.org>
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

From: Patrisious Haddad <phaddad@nvidia.com>

[ Upstream commit 94af50c0a9bb961fe93cf0fdd14eb0883da86721 ]

Change normal IPsec flow to use the same creation/destruction functions
for status flow table as that of ESW, which first of all refines the
code to have less code duplication.

And more importantly, the ESW status table handles IPsec syndrome
checks at steering by HW, which is more efficient than the previous
behaviour we had where it was copied to WQE meta data and checked
by the driver.

Fixes: 1762f132d542 ("net/mlx5e: Support IPsec packet offload for RX in switchdev mode")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 187 +++++++++++++-----
 .../mellanox/mlx5/core/esw/ipsec_fs.c         | 152 --------------
 .../mellanox/mlx5/core/esw/ipsec_fs.h         |  15 --
 3 files changed, 141 insertions(+), 213 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 7dba4221993f0..fc6aca7c05a48 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -128,63 +128,166 @@ static struct mlx5_flow_table *ipsec_ft_create(struct mlx5_flow_namespace *ns,
 	return mlx5_create_auto_grouped_flow_table(ns, &ft_attr);
 }
 
-static int ipsec_status_rule(struct mlx5_core_dev *mdev,
-			     struct mlx5e_ipsec_rx *rx,
-			     struct mlx5_flow_destination *dest)
+static void ipsec_rx_status_drop_destroy(struct mlx5e_ipsec *ipsec,
+					 struct mlx5e_ipsec_rx *rx)
 {
-	u8 action[MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)] = {};
+	mlx5_del_flow_rules(rx->status_drop.rule);
+	mlx5_destroy_flow_group(rx->status_drop.group);
+	mlx5_fc_destroy(ipsec->mdev, rx->status_drop_cnt);
+}
+
+static void ipsec_rx_status_pass_destroy(struct mlx5e_ipsec *ipsec,
+					 struct mlx5e_ipsec_rx *rx)
+{
+	mlx5_del_flow_rules(rx->status.rule);
+
+	if (rx != ipsec->rx_esw)
+		return;
+
+#ifdef CONFIG_MLX5_ESWITCH
+	mlx5_chains_put_table(esw_chains(ipsec->mdev->priv.eswitch), 0, 1, 0);
+#endif
+}
+
+static int ipsec_rx_status_drop_create(struct mlx5e_ipsec *ipsec,
+				       struct mlx5e_ipsec_rx *rx)
+{
+	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
+	struct mlx5_flow_table *ft = rx->ft.status;
+	struct mlx5_core_dev *mdev = ipsec->mdev;
+	struct mlx5_flow_destination dest = {};
 	struct mlx5_flow_act flow_act = {};
-	struct mlx5_modify_hdr *modify_hdr;
-	struct mlx5_flow_handle *fte;
+	struct mlx5_flow_handle *rule;
+	struct mlx5_fc *flow_counter;
 	struct mlx5_flow_spec *spec;
-	int err;
+	struct mlx5_flow_group *g;
+	u32 *flow_group_in;
+	int err = 0;
 
+	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
-	if (!spec)
-		return -ENOMEM;
+	if (!flow_group_in || !spec) {
+		err = -ENOMEM;
+		goto err_out;
+	}
 
-	/* Action to copy 7 bit ipsec_syndrome to regB[24:30] */
-	MLX5_SET(copy_action_in, action, action_type, MLX5_ACTION_TYPE_COPY);
-	MLX5_SET(copy_action_in, action, src_field, MLX5_ACTION_IN_FIELD_IPSEC_SYNDROME);
-	MLX5_SET(copy_action_in, action, src_offset, 0);
-	MLX5_SET(copy_action_in, action, length, 7);
-	MLX5_SET(copy_action_in, action, dst_field, MLX5_ACTION_IN_FIELD_METADATA_REG_B);
-	MLX5_SET(copy_action_in, action, dst_offset, 24);
+	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, ft->max_fte - 1);
+	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, ft->max_fte - 1);
+	g = mlx5_create_flow_group(ft, flow_group_in);
+	if (IS_ERR(g)) {
+		err = PTR_ERR(g);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop flow group, err=%d\n", err);
+		goto err_out;
+	}
 
-	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_KERNEL,
-					      1, action);
+	flow_counter = mlx5_fc_create(mdev, false);
+	if (IS_ERR(flow_counter)) {
+		err = PTR_ERR(flow_counter);
+		mlx5_core_err(mdev,
+			      "Failed to add ipsec rx status drop rule counter, err=%d\n", err);
+		goto err_cnt;
+	}
 
-	if (IS_ERR(modify_hdr)) {
-		err = PTR_ERR(modify_hdr);
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
+	dest.counter_id = mlx5_fc_id(flow_counter);
+	if (rx == ipsec->rx_esw)
+		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
+	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
 		mlx5_core_err(mdev,
-			      "fail to alloc ipsec copy modify_header_id err=%d\n", err);
-		goto out_spec;
+			      "Failed to add ipsec rx status drop rule, err=%d\n", err);
+		goto err_rule;
 	}
 
-	/* create fte */
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_MOD_HDR |
-			  MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
+	rx->status_drop.group = g;
+	rx->status_drop.rule = rule;
+	rx->status_drop_cnt = flow_counter;
+
+	kvfree(flow_group_in);
+	kvfree(spec);
+	return 0;
+
+err_rule:
+	mlx5_fc_destroy(mdev, flow_counter);
+err_cnt:
+	mlx5_destroy_flow_group(g);
+err_out:
+	kvfree(flow_group_in);
+	kvfree(spec);
+	return err;
+}
+
+static int ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
+				       struct mlx5e_ipsec_rx *rx,
+				       struct mlx5_flow_destination *dest)
+{
+	struct mlx5_flow_act flow_act = {};
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
+	int err;
+
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+			 misc_parameters_2.ipsec_syndrome);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 misc_parameters_2.ipsec_syndrome, 0);
+	if (rx == ipsec->rx_esw)
+		spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
+	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+	flow_act.flags = FLOW_ACT_NO_APPEND;
+	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
 			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	flow_act.modify_hdr = modify_hdr;
-	fte = mlx5_add_flow_rules(rx->ft.status, spec, &flow_act, dest, 2);
-	if (IS_ERR(fte)) {
-		err = PTR_ERR(fte);
-		mlx5_core_err(mdev, "fail to add ipsec rx err copy rule err=%d\n", err);
-		goto out;
+	rule = mlx5_add_flow_rules(rx->ft.status, spec, &flow_act, dest, 2);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_warn(ipsec->mdev,
+			       "Failed to add ipsec rx status pass rule, err=%d\n", err);
+		goto err_rule;
 	}
 
+	rx->status.rule = rule;
 	kvfree(spec);
-	rx->status.rule = fte;
-	rx->status.modify_hdr = modify_hdr;
 	return 0;
 
-out:
-	mlx5_modify_header_dealloc(mdev, modify_hdr);
-out_spec:
+err_rule:
 	kvfree(spec);
 	return err;
 }
 
+static void mlx5_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
+					 struct mlx5e_ipsec_rx *rx)
+{
+	ipsec_rx_status_pass_destroy(ipsec, rx);
+	ipsec_rx_status_drop_destroy(ipsec, rx);
+}
+
+static int mlx5_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
+				       struct mlx5e_ipsec_rx *rx,
+				       struct mlx5_flow_destination *dest)
+{
+	int err;
+
+	err = ipsec_rx_status_drop_create(ipsec, rx);
+	if (err)
+		return err;
+
+	err = ipsec_rx_status_pass_create(ipsec, rx, dest);
+	if (err)
+		goto err_pass_create;
+
+	return 0;
+
+err_pass_create:
+	ipsec_rx_status_drop_destroy(ipsec, rx);
+	return err;
+}
+
 static int ipsec_miss_create(struct mlx5_core_dev *mdev,
 			     struct mlx5_flow_table *ft,
 			     struct mlx5e_ipsec_miss *miss,
@@ -256,12 +359,7 @@ static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 	mlx5_destroy_flow_table(rx->ft.sa);
 	if (rx->allow_tunnel_mode)
 		mlx5_eswitch_unblock_encap(mdev);
-	if (rx == ipsec->rx_esw) {
-		mlx5_esw_ipsec_rx_status_destroy(ipsec, rx);
-	} else {
-		mlx5_del_flow_rules(rx->status.rule);
-		mlx5_modify_header_dealloc(mdev, rx->status.modify_hdr);
-	}
+	mlx5_ipsec_rx_status_destroy(ipsec, rx);
 	mlx5_destroy_flow_table(rx->ft.status);
 
 	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family);
@@ -351,10 +449,7 @@ static int rx_create(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 
 	dest[1].type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
 	dest[1].counter_id = mlx5_fc_id(rx->fc->cnt);
-	if (rx == ipsec->rx_esw)
-		err = mlx5_esw_ipsec_rx_status_create(ipsec, rx, dest);
-	else
-		err = ipsec_status_rule(mdev, rx, dest);
+	err = mlx5_ipsec_rx_status_create(ipsec, rx, dest);
 	if (err)
 		goto err_add;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 095f31f380fa3..13b5916b64e22 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -21,158 +21,6 @@ enum {
 	MLX5_ESW_IPSEC_TX_ESP_FT_CNT_LEVEL,
 };
 
-static void esw_ipsec_rx_status_drop_destroy(struct mlx5e_ipsec *ipsec,
-					     struct mlx5e_ipsec_rx *rx)
-{
-	mlx5_del_flow_rules(rx->status_drop.rule);
-	mlx5_destroy_flow_group(rx->status_drop.group);
-	mlx5_fc_destroy(ipsec->mdev, rx->status_drop_cnt);
-}
-
-static void esw_ipsec_rx_status_pass_destroy(struct mlx5e_ipsec *ipsec,
-					     struct mlx5e_ipsec_rx *rx)
-{
-	mlx5_del_flow_rules(rx->status.rule);
-	mlx5_chains_put_table(esw_chains(ipsec->mdev->priv.eswitch), 0, 1, 0);
-}
-
-static int esw_ipsec_rx_status_drop_create(struct mlx5e_ipsec *ipsec,
-					   struct mlx5e_ipsec_rx *rx)
-{
-	int inlen = MLX5_ST_SZ_BYTES(create_flow_group_in);
-	struct mlx5_flow_table *ft = rx->ft.status;
-	struct mlx5_core_dev *mdev = ipsec->mdev;
-	struct mlx5_flow_destination dest = {};
-	struct mlx5_flow_act flow_act = {};
-	struct mlx5_flow_handle *rule;
-	struct mlx5_fc *flow_counter;
-	struct mlx5_flow_spec *spec;
-	struct mlx5_flow_group *g;
-	u32 *flow_group_in;
-	int err = 0;
-
-	flow_group_in = kvzalloc(inlen, GFP_KERNEL);
-	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
-	if (!flow_group_in || !spec) {
-		err = -ENOMEM;
-		goto err_out;
-	}
-
-	MLX5_SET(create_flow_group_in, flow_group_in, start_flow_index, ft->max_fte - 1);
-	MLX5_SET(create_flow_group_in, flow_group_in, end_flow_index, ft->max_fte - 1);
-	g = mlx5_create_flow_group(ft, flow_group_in);
-	if (IS_ERR(g)) {
-		err = PTR_ERR(g);
-		mlx5_core_err(mdev,
-			      "Failed to add ipsec rx status drop flow group, err=%d\n", err);
-		goto err_out;
-	}
-
-	flow_counter = mlx5_fc_create(mdev, false);
-	if (IS_ERR(flow_counter)) {
-		err = PTR_ERR(flow_counter);
-		mlx5_core_err(mdev,
-			      "Failed to add ipsec rx status drop rule counter, err=%d\n", err);
-		goto err_cnt;
-	}
-
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_DROP | MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	dest.type = MLX5_FLOW_DESTINATION_TYPE_COUNTER;
-	dest.counter_id = mlx5_fc_id(flow_counter);
-	spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
-	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
-	if (IS_ERR(rule)) {
-		err = PTR_ERR(rule);
-		mlx5_core_err(mdev,
-			      "Failed to add ipsec rx status drop rule, err=%d\n", err);
-		goto err_rule;
-	}
-
-	rx->status_drop.group = g;
-	rx->status_drop.rule = rule;
-	rx->status_drop_cnt = flow_counter;
-
-	kvfree(flow_group_in);
-	kvfree(spec);
-	return 0;
-
-err_rule:
-	mlx5_fc_destroy(mdev, flow_counter);
-err_cnt:
-	mlx5_destroy_flow_group(g);
-err_out:
-	kvfree(flow_group_in);
-	kvfree(spec);
-	return err;
-}
-
-static int esw_ipsec_rx_status_pass_create(struct mlx5e_ipsec *ipsec,
-					   struct mlx5e_ipsec_rx *rx,
-					   struct mlx5_flow_destination *dest)
-{
-	struct mlx5_flow_act flow_act = {};
-	struct mlx5_flow_handle *rule;
-	struct mlx5_flow_spec *spec;
-	int err;
-
-	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
-	if (!spec)
-		return -ENOMEM;
-
-	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
-			 misc_parameters_2.ipsec_syndrome);
-	MLX5_SET(fte_match_param, spec->match_value,
-		 misc_parameters_2.ipsec_syndrome, 0);
-	spec->flow_context.flow_source = MLX5_FLOW_CONTEXT_FLOW_SOURCE_UPLINK;
-	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
-	flow_act.flags = FLOW_ACT_NO_APPEND;
-	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
-			  MLX5_FLOW_CONTEXT_ACTION_COUNT;
-	rule = mlx5_add_flow_rules(rx->ft.status, spec, &flow_act, dest, 2);
-	if (IS_ERR(rule)) {
-		err = PTR_ERR(rule);
-		mlx5_core_warn(ipsec->mdev,
-			       "Failed to add ipsec rx status pass rule, err=%d\n", err);
-		goto err_rule;
-	}
-
-	rx->status.rule = rule;
-	kvfree(spec);
-	return 0;
-
-err_rule:
-	kvfree(spec);
-	return err;
-}
-
-void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
-				      struct mlx5e_ipsec_rx *rx)
-{
-	esw_ipsec_rx_status_pass_destroy(ipsec, rx);
-	esw_ipsec_rx_status_drop_destroy(ipsec, rx);
-}
-
-int mlx5_esw_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
-				    struct mlx5e_ipsec_rx *rx,
-				    struct mlx5_flow_destination *dest)
-{
-	int err;
-
-	err = esw_ipsec_rx_status_drop_create(ipsec, rx);
-	if (err)
-		return err;
-
-	err = esw_ipsec_rx_status_pass_create(ipsec, rx, dest);
-	if (err)
-		goto err_pass_create;
-
-	return 0;
-
-err_pass_create:
-	esw_ipsec_rx_status_drop_destroy(ipsec, rx);
-	return err;
-}
-
 void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				       struct mlx5e_ipsec_rx_create_attr *attr)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
index 0c90f7a8b0d32..ac9c65b89166e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
@@ -8,11 +8,6 @@ struct mlx5e_ipsec;
 struct mlx5e_ipsec_sa_entry;
 
 #ifdef CONFIG_MLX5_ESWITCH
-void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
-				      struct mlx5e_ipsec_rx *rx);
-int mlx5_esw_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
-				    struct mlx5e_ipsec_rx *rx,
-				    struct mlx5_flow_destination *dest);
 void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				       struct mlx5e_ipsec_rx_create_attr *attr);
 int mlx5_esw_ipsec_rx_status_pass_dest_get(struct mlx5e_ipsec *ipsec,
@@ -26,16 +21,6 @@ void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				       struct mlx5e_ipsec_tx_create_attr *attr);
 void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev);
 #else
-static inline void mlx5_esw_ipsec_rx_status_destroy(struct mlx5e_ipsec *ipsec,
-						    struct mlx5e_ipsec_rx *rx) {}
-
-static inline int mlx5_esw_ipsec_rx_status_create(struct mlx5e_ipsec *ipsec,
-						  struct mlx5e_ipsec_rx *rx,
-						  struct mlx5_flow_destination *dest)
-{
-	return  -EINVAL;
-}
-
 static inline void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
 						     struct mlx5e_ipsec_rx_create_attr *attr) {}
 
-- 
2.43.0





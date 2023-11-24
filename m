Return-Path: <stable+bounces-2222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026807F8347
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D038B23E45
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2111364C4;
	Fri, 24 Nov 2023 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0cwWE37U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E935F1A;
	Fri, 24 Nov 2023 19:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDD2C433C8;
	Fri, 24 Nov 2023 19:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853353;
	bh=moc7UXIjDC1EmA1OdazR4slxgOskWqIWVrxFIfSRTlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0cwWE37UZwi8nE1aPrtWqzQicLWyRJXHO8YvtxsQuPjkdCNm/XWYRyeia6JNmtFOZ
	 VvormMoGCy8VzbBZby2eFTyMSrqA8wcM7PvEa8naSKfPZvxgOJZdMR0t6Fz+fsyCV0
	 MCAi4RnUGdzUWsH927Q3+FSotPHCED9m4DCKQx/A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Blakey <paulb@nvidia.com>,
	Oz Shlomo <ozsh@nvidia.com>,
	Roi Dayan <roid@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 130/297] net/mlx5e: Refactor mod header management API
Date: Fri, 24 Nov 2023 17:52:52 +0000
Message-ID: <20231124172004.844592839@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Blakey <paulb@nvidia.com>

[ Upstream commit 2c0e5cf5206ecd5da3c6bc5799671c2172713d71 ]

For all mod hdr related functions to reside in a single self contained
component (mod_hdr.c), refactor alloc() and add get_id() so that user
won't rely on internal implementation, and move both to mod_hdr
component.

Rename the prefix to mlx5e_mod_hdr_* as other mod hdr functions.

Signed-off-by: Paul Blakey <paulb@nvidia.com>
Reviewed-by: Oz Shlomo <ozsh@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Stable-dep-of: 0c101a23ca7e ("net/mlx5e: Fix pedit endianness")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlx5/core/en/mod_hdr.c  | 47 ++++++++++
 .../ethernet/mellanox/mlx5/core/en/mod_hdr.h  | 13 +++
 .../mellanox/mlx5/core/en/tc/sample.c         |  5 +-
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 25 ++----
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 90 ++++---------------
 .../net/ethernet/mellanox/mlx5/core/en_tc.h   |  5 --
 .../mellanox/mlx5/core/esw/indir_table.c      |  5 +-
 7 files changed, 90 insertions(+), 100 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.c b/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.c
index 7edde4d536fda..19d05fb4aab2e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.c
@@ -155,3 +155,50 @@ struct mlx5_modify_hdr *mlx5e_mod_hdr_get(struct mlx5e_mod_hdr_handle *mh)
 	return mh->modify_hdr;
 }
 
+char *
+mlx5e_mod_hdr_alloc(struct mlx5_core_dev *mdev, int namespace,
+		    struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts)
+{
+	int new_num_actions, max_hw_actions;
+	size_t new_sz, old_sz;
+	void *ret;
+
+	if (mod_hdr_acts->num_actions < mod_hdr_acts->max_actions)
+		goto out;
+
+	max_hw_actions = mlx5e_mod_hdr_max_actions(mdev, namespace);
+	new_num_actions = min(max_hw_actions,
+			      mod_hdr_acts->actions ?
+			      mod_hdr_acts->max_actions * 2 : 1);
+	if (mod_hdr_acts->max_actions == new_num_actions)
+		return ERR_PTR(-ENOSPC);
+
+	new_sz = MLX5_MH_ACT_SZ * new_num_actions;
+	old_sz = mod_hdr_acts->max_actions * MLX5_MH_ACT_SZ;
+
+	ret = krealloc(mod_hdr_acts->actions, new_sz, GFP_KERNEL);
+	if (!ret)
+		return ERR_PTR(-ENOMEM);
+
+	memset(ret + old_sz, 0, new_sz - old_sz);
+	mod_hdr_acts->actions = ret;
+	mod_hdr_acts->max_actions = new_num_actions;
+
+out:
+	return mod_hdr_acts->actions + (mod_hdr_acts->num_actions * MLX5_MH_ACT_SZ);
+}
+
+void
+mlx5e_mod_hdr_dealloc(struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts)
+{
+	kfree(mod_hdr_acts->actions);
+	mod_hdr_acts->actions = NULL;
+	mod_hdr_acts->num_actions = 0;
+	mod_hdr_acts->max_actions = 0;
+}
+
+char *
+mlx5e_mod_hdr_get_item(struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts, int pos)
+{
+	return mod_hdr_acts->actions + (pos * MLX5_MH_ACT_SZ);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.h b/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.h
index 33b23d8f91828..b8cd1a7a31be6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/mod_hdr.h
@@ -15,6 +15,11 @@ struct mlx5e_tc_mod_hdr_acts {
 	void *actions;
 };
 
+char *mlx5e_mod_hdr_alloc(struct mlx5_core_dev *mdev, int namespace,
+			  struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts);
+void mlx5e_mod_hdr_dealloc(struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts);
+char *mlx5e_mod_hdr_get_item(struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts, int pos);
+
 struct mlx5e_mod_hdr_handle *
 mlx5e_mod_hdr_attach(struct mlx5_core_dev *mdev,
 		     struct mod_hdr_tbl *tbl,
@@ -28,4 +33,12 @@ struct mlx5_modify_hdr *mlx5e_mod_hdr_get(struct mlx5e_mod_hdr_handle *mh);
 void mlx5e_mod_hdr_tbl_init(struct mod_hdr_tbl *tbl);
 void mlx5e_mod_hdr_tbl_destroy(struct mod_hdr_tbl *tbl);
 
+static inline int mlx5e_mod_hdr_max_actions(struct mlx5_core_dev *mdev, int namespace)
+{
+	if (namespace == MLX5_FLOW_NAMESPACE_FDB) /* FDB offloading */
+		return MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, max_modify_header_actions);
+	else /* namespace is MLX5_FLOW_NAMESPACE_KERNEL - NIC offloading */
+		return MLX5_CAP_FLOWTABLE_NIC_RX(mdev, max_modify_header_actions);
+}
+
 #endif /* __MLX5E_EN_MOD_HDR_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
index 6552ecee3f9b9..d08723a444e3f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
@@ -5,6 +5,7 @@
 #include <net/psample.h>
 #include "en/mapping.h"
 #include "en/tc/post_act.h"
+#include "en/mod_hdr.h"
 #include "sample.h"
 #include "eswitch.h"
 #include "en_tc.h"
@@ -255,12 +256,12 @@ sample_modify_hdr_get(struct mlx5_core_dev *mdev, u32 obj_id,
 		goto err_modify_hdr;
 	}
 
-	dealloc_mod_hdr_actions(&mod_acts);
+	mlx5e_mod_hdr_dealloc(&mod_acts);
 	return modify_hdr;
 
 err_modify_hdr:
 err_post_act:
-	dealloc_mod_hdr_actions(&mod_acts);
+	mlx5e_mod_hdr_dealloc(&mod_acts);
 err_set_regc0:
 	return ERR_PTR(err);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 94200f2dd92b0..80a49d7af05d6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -609,22 +609,15 @@ mlx5_tc_ct_entry_create_nat(struct mlx5_tc_ct_priv *ct_priv,
 	struct flow_action *flow_action = &flow_rule->action;
 	struct mlx5_core_dev *mdev = ct_priv->dev;
 	struct flow_action_entry *act;
-	size_t action_size;
 	char *modact;
 	int err, i;
 
-	action_size = MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto);
-
 	flow_action_for_each(i, act, flow_action) {
 		switch (act->id) {
 		case FLOW_ACTION_MANGLE: {
-			err = alloc_mod_hdr_actions(mdev, ct_priv->ns_type,
-						    mod_acts);
-			if (err)
-				return err;
-
-			modact = mod_acts->actions +
-				 mod_acts->num_actions * action_size;
+			modact = mlx5e_mod_hdr_alloc(mdev, ct_priv->ns_type, mod_acts);
+			if (IS_ERR(modact))
+				return PTR_ERR(modact);
 
 			err = mlx5_tc_ct_parse_mangle_to_mod_act(act, modact);
 			if (err)
@@ -707,11 +700,11 @@ mlx5_tc_ct_entry_create_mod_hdr(struct mlx5_tc_ct_priv *ct_priv,
 		attr->modify_hdr = mlx5e_mod_hdr_get(*mh);
 	}
 
-	dealloc_mod_hdr_actions(&mod_acts);
+	mlx5e_mod_hdr_dealloc(&mod_acts);
 	return 0;
 
 err_mapping:
-	dealloc_mod_hdr_actions(&mod_acts);
+	mlx5e_mod_hdr_dealloc(&mod_acts);
 	mlx5_put_label_mapping(ct_priv, attr->ct_attr.ct_labels_id);
 	return err;
 }
@@ -1463,7 +1456,7 @@ static int tc_ct_pre_ct_add_rules(struct mlx5_ct_ft *ct_ft,
 	}
 	pre_ct->miss_rule = rule;
 
-	dealloc_mod_hdr_actions(&pre_mod_acts);
+	mlx5e_mod_hdr_dealloc(&pre_mod_acts);
 	kvfree(spec);
 	return 0;
 
@@ -1472,7 +1465,7 @@ static int tc_ct_pre_ct_add_rules(struct mlx5_ct_ft *ct_ft,
 err_flow_rule:
 	mlx5_modify_header_dealloc(dev, pre_ct->modify_hdr);
 err_mapping:
-	dealloc_mod_hdr_actions(&pre_mod_acts);
+	mlx5e_mod_hdr_dealloc(&pre_mod_acts);
 	kvfree(spec);
 	return err;
 }
@@ -1872,14 +1865,14 @@ __mlx5_tc_ct_flow_offload(struct mlx5_tc_ct_priv *ct_priv,
 	}
 
 	attr->ct_attr.ct_flow = ct_flow;
-	dealloc_mod_hdr_actions(&pre_mod_acts);
+	mlx5e_mod_hdr_dealloc(&pre_mod_acts);
 
 	return ct_flow->pre_ct_rule;
 
 err_insert_orig:
 	mlx5_modify_header_dealloc(priv->mdev, pre_ct_attr->modify_hdr);
 err_mapping:
-	dealloc_mod_hdr_actions(&pre_mod_acts);
+	mlx5e_mod_hdr_dealloc(&pre_mod_acts);
 	mlx5_chains_put_chain_mapping(ct_priv->chains, ct_flow->chain_mapping);
 err_get_chain:
 	kfree(ct_flow->pre_ct_attr);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 433602f871bd4..39fa0fa21e33c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -71,7 +71,6 @@
 #include "lag_mp.h"
 
 #define nic_chains(priv) ((priv)->fs.tc.chains)
-#define MLX5_MH_ACT_SZ MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto)
 
 #define MLX5E_TC_TABLE_NUM_GROUPS 4
 #define MLX5E_TC_TABLE_MAX_GROUP_SIZE BIT(18)
@@ -209,12 +208,9 @@ mlx5e_tc_match_to_reg_set_and_get_id(struct mlx5_core_dev *mdev,
 	char *modact;
 	int err;
 
-	err = alloc_mod_hdr_actions(mdev, ns, mod_hdr_acts);
-	if (err)
-		return err;
-
-	modact = mod_hdr_acts->actions +
-		 (mod_hdr_acts->num_actions * MLX5_MH_ACT_SZ);
+	modact = mlx5e_mod_hdr_alloc(mdev, ns, mod_hdr_acts);
+	if (IS_ERR(modact))
+		return PTR_ERR(modact);
 
 	/* Firmware has 5bit length field and 0 means 32bits */
 	if (mlen == 32)
@@ -316,7 +312,7 @@ void mlx5e_tc_match_to_reg_mod_hdr_change(struct mlx5_core_dev *mdev,
 	int mlen = mlx5e_tc_attr_to_reg_mappings[type].mlen;
 	char *modact;
 
-	modact = mod_hdr_acts->actions + (act_id * MLX5_MH_ACT_SZ);
+	modact = mlx5e_mod_hdr_get_item(mod_hdr_acts, act_id);
 
 	/* Firmware has 5bit length field and 0 means 32bits */
 	if (mlen == 32)
@@ -1059,7 +1055,7 @@ mlx5e_tc_add_nic_flow(struct mlx5e_priv *priv,
 
 	if (attr->action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) {
 		err = mlx5e_attach_mod_hdr(priv, flow, parse_attr);
-		dealloc_mod_hdr_actions(&parse_attr->mod_hdr_acts);
+		mlx5e_mod_hdr_dealloc(&parse_attr->mod_hdr_acts);
 		if (err)
 			return err;
 	}
@@ -1557,7 +1553,7 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
 	mlx5_tc_ct_match_del(get_ct_priv(priv), &flow->attr->ct_attr);
 
 	if (attr->action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) {
-		dealloc_mod_hdr_actions(&attr->parse_attr->mod_hdr_acts);
+		mlx5e_mod_hdr_dealloc(&attr->parse_attr->mod_hdr_acts);
 		if (vf_tun && attr->modify_hdr)
 			mlx5_modify_header_dealloc(priv->mdev, attr->modify_hdr);
 		else
@@ -2803,13 +2799,12 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 				struct netlink_ext_ack *extack)
 {
 	struct pedit_headers *set_masks, *add_masks, *set_vals, *add_vals;
-	int i, action_size, first, last, next_z;
 	void *headers_c, *headers_v, *action, *vals_p;
 	u32 *s_masks_p, *a_masks_p, s_mask, a_mask;
 	struct mlx5e_tc_mod_hdr_acts *mod_acts;
-	struct mlx5_fields *f;
 	unsigned long mask, field_mask;
-	int err;
+	int i, first, last, next_z;
+	struct mlx5_fields *f;
 	u8 cmd;
 
 	mod_acts = &parse_attr->mod_hdr_acts;
@@ -2821,8 +2816,6 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 	set_vals = &hdrs[0].vals;
 	add_vals = &hdrs[1].vals;
 
-	action_size = MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto);
-
 	for (i = 0; i < ARRAY_SIZE(fields); i++) {
 		bool skip;
 
@@ -2890,18 +2883,16 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 			return -EOPNOTSUPP;
 		}
 
-		err = alloc_mod_hdr_actions(priv->mdev, namespace, mod_acts);
-		if (err) {
+		action = mlx5e_mod_hdr_alloc(priv->mdev, namespace, mod_acts);
+		if (IS_ERR(action)) {
 			NL_SET_ERR_MSG_MOD(extack,
 					   "too many pedit actions, can't offload");
 			mlx5_core_warn(priv->mdev,
 				       "mlx5: parsed %d pedit actions, can't do more\n",
 				       mod_acts->num_actions);
-			return err;
+			return PTR_ERR(action);
 		}
 
-		action = mod_acts->actions +
-			 (mod_acts->num_actions * action_size);
 		MLX5_SET(set_action_in, action, action_type, cmd);
 		MLX5_SET(set_action_in, action, field, f->field);
 
@@ -2931,57 +2922,6 @@ static int offload_pedit_fields(struct mlx5e_priv *priv,
 	return 0;
 }
 
-static int mlx5e_flow_namespace_max_modify_action(struct mlx5_core_dev *mdev,
-						  int namespace)
-{
-	if (namespace == MLX5_FLOW_NAMESPACE_FDB) /* FDB offloading */
-		return MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, max_modify_header_actions);
-	else /* namespace is MLX5_FLOW_NAMESPACE_KERNEL - NIC offloading */
-		return MLX5_CAP_FLOWTABLE_NIC_RX(mdev, max_modify_header_actions);
-}
-
-int alloc_mod_hdr_actions(struct mlx5_core_dev *mdev,
-			  int namespace,
-			  struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts)
-{
-	int action_size, new_num_actions, max_hw_actions;
-	size_t new_sz, old_sz;
-	void *ret;
-
-	if (mod_hdr_acts->num_actions < mod_hdr_acts->max_actions)
-		return 0;
-
-	action_size = MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto);
-
-	max_hw_actions = mlx5e_flow_namespace_max_modify_action(mdev,
-								namespace);
-	new_num_actions = min(max_hw_actions,
-			      mod_hdr_acts->actions ?
-			      mod_hdr_acts->max_actions * 2 : 1);
-	if (mod_hdr_acts->max_actions == new_num_actions)
-		return -ENOSPC;
-
-	new_sz = action_size * new_num_actions;
-	old_sz = mod_hdr_acts->max_actions * action_size;
-	ret = krealloc(mod_hdr_acts->actions, new_sz, GFP_KERNEL);
-	if (!ret)
-		return -ENOMEM;
-
-	memset(ret + old_sz, 0, new_sz - old_sz);
-	mod_hdr_acts->actions = ret;
-	mod_hdr_acts->max_actions = new_num_actions;
-
-	return 0;
-}
-
-void dealloc_mod_hdr_actions(struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts)
-{
-	kfree(mod_hdr_acts->actions);
-	mod_hdr_acts->actions = NULL;
-	mod_hdr_acts->num_actions = 0;
-	mod_hdr_acts->max_actions = 0;
-}
-
 static const struct pedit_headers zero_masks = {};
 
 static int
@@ -3004,7 +2944,7 @@ parse_pedit_to_modify_hdr(struct mlx5e_priv *priv,
 		goto out_err;
 	}
 
-	if (!mlx5e_flow_namespace_max_modify_action(priv->mdev, namespace)) {
+	if (!mlx5e_mod_hdr_max_actions(priv->mdev, namespace)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "The pedit offload action is not supported");
 		goto out_err;
@@ -3096,7 +3036,7 @@ static int alloc_tc_pedit_action(struct mlx5e_priv *priv, int namespace,
 	return 0;
 
 out_dealloc_parsed_actions:
-	dealloc_mod_hdr_actions(&parse_attr->mod_hdr_acts);
+	mlx5e_mod_hdr_dealloc(&parse_attr->mod_hdr_acts);
 	return err;
 }
 
@@ -3529,7 +3469,7 @@ actions_prepare_mod_hdr_actions(struct mlx5e_priv *priv,
 		return 0;
 
 	attr->action &= ~MLX5_FLOW_CONTEXT_ACTION_MOD_HDR;
-	dealloc_mod_hdr_actions(&parse_attr->mod_hdr_acts);
+	mlx5e_mod_hdr_dealloc(&parse_attr->mod_hdr_acts);
 
 	if (ns_type != MLX5_FLOW_NAMESPACE_FDB)
 		return 0;
@@ -4613,7 +4553,7 @@ mlx5e_add_nic_flow(struct mlx5e_priv *priv,
 
 err_free:
 	flow_flag_set(flow, FAILED);
-	dealloc_mod_hdr_actions(&parse_attr->mod_hdr_acts);
+	mlx5e_mod_hdr_dealloc(&parse_attr->mod_hdr_acts);
 	mlx5e_flow_put(priv, flow);
 out:
 	return err;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
index f48af82781f88..26a85a11eb6ca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
@@ -244,11 +244,6 @@ int mlx5e_tc_add_flow_mod_hdr(struct mlx5e_priv *priv,
 			      struct mlx5e_tc_flow *flow,
 			      struct mlx5_flow_attr *attr);
 
-int alloc_mod_hdr_actions(struct mlx5_core_dev *mdev,
-			  int namespace,
-			  struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts);
-void dealloc_mod_hdr_actions(struct mlx5e_tc_mod_hdr_acts *mod_hdr_acts);
-
 struct mlx5e_tc_flow;
 u32 mlx5e_tc_get_flow_tun_id(struct mlx5e_tc_flow *flow);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/indir_table.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/indir_table.c
index 425c91814b34f..c275fe028b6d8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/indir_table.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/indir_table.c
@@ -14,6 +14,7 @@
 #include "fs_core.h"
 #include "esw/indir_table.h"
 #include "lib/fs_chains.h"
+#include "en/mod_hdr.h"
 
 #define MLX5_ESW_INDIR_TABLE_SIZE 128
 #define MLX5_ESW_INDIR_TABLE_RECIRC_IDX_MAX (MLX5_ESW_INDIR_TABLE_SIZE - 2)
@@ -226,7 +227,7 @@ static int mlx5_esw_indir_table_rule_get(struct mlx5_eswitch *esw,
 		goto err_handle;
 	}
 
-	dealloc_mod_hdr_actions(&mod_acts);
+	mlx5e_mod_hdr_dealloc(&mod_acts);
 	rule->handle = handle;
 	rule->vni = esw_attr->rx_tun_attr->vni;
 	rule->mh = flow_act.modify_hdr;
@@ -243,7 +244,7 @@ static int mlx5_esw_indir_table_rule_get(struct mlx5_eswitch *esw,
 	mlx5_modify_header_dealloc(esw->dev, flow_act.modify_hdr);
 err_mod_hdr_alloc:
 err_mod_hdr_regc1:
-	dealloc_mod_hdr_actions(&mod_acts);
+	mlx5e_mod_hdr_dealloc(&mod_acts);
 err_mod_hdr_regc0:
 err_ethertype:
 	kfree(rule);
-- 
2.42.0





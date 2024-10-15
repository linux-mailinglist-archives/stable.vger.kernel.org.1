Return-Path: <stable+bounces-85200-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1E399E625
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C6828748B
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 11:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E1B1E7666;
	Tue, 15 Oct 2024 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YyAwfuMa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350BE1D9A42;
	Tue, 15 Oct 2024 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992304; cv=none; b=khTGYZDkwHuZwWBedY/0xALud2KBhAniBNyu6KTzkX4ugptI7EfB1hXc6l2c/GSl/gPbTBcD0Fn849pBFllveNWvBLU/+gVdihFx1DE/hftaCKtmVVu96RUNJjSqIrP6SlAztQlIq9qNgxOJj5v3dCw8Wi6w6gtTdVvLzyUG53I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992304; c=relaxed/simple;
	bh=Ig3OSyzCPp/Upi4PE+j00XT7PdbS0V+6cxOv3/69RpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ma0aakdHMWHVPPLSM+CeCBtHL+Hu0KjKOFLTZSSQAfnhR1WrmbUZqcr2X01glQb7Z/2l66QaEhOAAdoSspQUaYqk872SMbVQtg4Thk8MqLNuWxKVneEHODPEll1wUP/P0q7fZvHCKUj+NCdVTVxwsOR89WTYOiDh4oNa4mgte0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YyAwfuMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F996C4CEC6;
	Tue, 15 Oct 2024 11:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728992303;
	bh=Ig3OSyzCPp/Upi4PE+j00XT7PdbS0V+6cxOv3/69RpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YyAwfuMaOJJSBi7mJBnxO5ZjVK5QsC/yIlLLT5qTqwH6bvbKx9r8epm9745khtEgA
	 SV/8a+vEor6J+XTkzDls/qk+jMlS6Pc9i0H3xSZRpmSUDR8+h5REqz/xfIZAZh+s5a
	 +pO0WI7dOWAcpD3h6gwncWTKKvy+t1b+MebAbet8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 046/691] net/mlx5: Add support to create match definer
Date: Tue, 15 Oct 2024 13:19:54 +0200
Message-ID: <20241015112442.172464520@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015112440.309539031@linuxfoundation.org>
References: <20241015112440.309539031@linuxfoundation.org>
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

From: Maor Gottlieb <maorg@nvidia.com>

[ Upstream commit e7e2519e3632396a25031b7e828ed35332e5dd07 ]

Introduce new APIs to create and destroy flow matcher
for given format id.

Flow match definer object is used for defining the fields and
mask used for the hash calculation. User should mask the desired
fields like done in the match criteria.

This object is assigned to flow group of type hash. In this flow
group type, packets lookup is done based on the hash result.

This patch also adds the required bits to create such flow group.

Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Stable-dep-of: 452ef7f86036 ("net/mlx5: Add missing masks and QoS bit masks for scheduling elements")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.c  |  57 ++++
 .../net/ethernet/mellanox/mlx5/core/fs_cmd.h  |   4 +
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  46 +++
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |   5 +
 .../mellanox/mlx5/core/steering/fs_dr.c       |  15 +
 include/linux/mlx5/fs.h                       |   8 +
 include/linux/mlx5/mlx5_ifc.h                 | 272 ++++++++++++++++--
 7 files changed, 380 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 7db8df64a60e..57e1fa2fe5f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -185,6 +185,20 @@ static int mlx5_cmd_set_slave_root_fdb(struct mlx5_core_dev *master,
 	return mlx5_cmd_exec(slave, in, sizeof(in), out, sizeof(out));
 }
 
+static int
+mlx5_cmd_stub_destroy_match_definer(struct mlx5_flow_root_namespace *ns,
+				    int definer_id)
+{
+	return 0;
+}
+
+static int
+mlx5_cmd_stub_create_match_definer(struct mlx5_flow_root_namespace *ns,
+				   u16 format_id, u32 *match_mask)
+{
+	return 0;
+}
+
 static int mlx5_cmd_update_root_ft(struct mlx5_flow_root_namespace *ns,
 				   struct mlx5_flow_table *ft, u32 underlay_qpn,
 				   bool disconnect)
@@ -909,6 +923,45 @@ static void mlx5_cmd_modify_header_dealloc(struct mlx5_flow_root_namespace *ns,
 	mlx5_cmd_exec_in(dev, dealloc_modify_header_context, in);
 }
 
+static int mlx5_cmd_destroy_match_definer(struct mlx5_flow_root_namespace *ns,
+					  int definer_id)
+{
+	u32 in[MLX5_ST_SZ_DW(general_obj_in_cmd_hdr)] = {};
+	u32 out[MLX5_ST_SZ_DW(general_obj_out_cmd_hdr)];
+
+	MLX5_SET(general_obj_in_cmd_hdr, in, opcode,
+		 MLX5_CMD_OP_DESTROY_GENERAL_OBJECT);
+	MLX5_SET(general_obj_in_cmd_hdr, in, obj_type,
+		 MLX5_OBJ_TYPE_MATCH_DEFINER);
+	MLX5_SET(general_obj_in_cmd_hdr, in, obj_id, definer_id);
+
+	return mlx5_cmd_exec(ns->dev, in, sizeof(in), out, sizeof(out));
+}
+
+static int mlx5_cmd_create_match_definer(struct mlx5_flow_root_namespace *ns,
+					 u16 format_id, u32 *match_mask)
+{
+	u32 out[MLX5_ST_SZ_DW(create_match_definer_out)] = {};
+	u32 in[MLX5_ST_SZ_DW(create_match_definer_in)] = {};
+	struct mlx5_core_dev *dev = ns->dev;
+	void *ptr;
+	int err;
+
+	MLX5_SET(create_match_definer_in, in, general_obj_in_cmd_hdr.opcode,
+		 MLX5_CMD_OP_CREATE_GENERAL_OBJECT);
+	MLX5_SET(create_match_definer_in, in, general_obj_in_cmd_hdr.obj_type,
+		 MLX5_OBJ_TYPE_MATCH_DEFINER);
+
+	ptr = MLX5_ADDR_OF(create_match_definer_in, in, obj_context);
+	MLX5_SET(match_definer, ptr, format_id, format_id);
+
+	ptr = MLX5_ADDR_OF(match_definer, ptr, match_mask);
+	memcpy(ptr, match_mask, MLX5_FLD_SZ_BYTES(match_definer, match_mask));
+
+	err = mlx5_cmd_exec_inout(dev, create_match_definer, in, out);
+	return err ? err : MLX5_GET(general_obj_out_cmd_hdr, out, obj_id);
+}
+
 static const struct mlx5_flow_cmds mlx5_flow_cmds = {
 	.create_flow_table = mlx5_cmd_create_flow_table,
 	.destroy_flow_table = mlx5_cmd_destroy_flow_table,
@@ -923,6 +976,8 @@ static const struct mlx5_flow_cmds mlx5_flow_cmds = {
 	.packet_reformat_dealloc = mlx5_cmd_packet_reformat_dealloc,
 	.modify_header_alloc = mlx5_cmd_modify_header_alloc,
 	.modify_header_dealloc = mlx5_cmd_modify_header_dealloc,
+	.create_match_definer = mlx5_cmd_create_match_definer,
+	.destroy_match_definer = mlx5_cmd_destroy_match_definer,
 	.set_peer = mlx5_cmd_stub_set_peer,
 	.create_ns = mlx5_cmd_stub_create_ns,
 	.destroy_ns = mlx5_cmd_stub_destroy_ns,
@@ -942,6 +997,8 @@ static const struct mlx5_flow_cmds mlx5_flow_cmd_stubs = {
 	.packet_reformat_dealloc = mlx5_cmd_stub_packet_reformat_dealloc,
 	.modify_header_alloc = mlx5_cmd_stub_modify_header_alloc,
 	.modify_header_dealloc = mlx5_cmd_stub_modify_header_dealloc,
+	.create_match_definer = mlx5_cmd_stub_create_match_definer,
+	.destroy_match_definer = mlx5_cmd_stub_destroy_match_definer,
 	.set_peer = mlx5_cmd_stub_set_peer,
 	.create_ns = mlx5_cmd_stub_create_ns,
 	.destroy_ns = mlx5_cmd_stub_destroy_ns,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
index 5ecd33cdc087..220ec632d35a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h
@@ -97,6 +97,10 @@ struct mlx5_flow_cmds {
 
 	int (*create_ns)(struct mlx5_flow_root_namespace *ns);
 	int (*destroy_ns)(struct mlx5_flow_root_namespace *ns);
+	int (*create_match_definer)(struct mlx5_flow_root_namespace *ns,
+				    u16 format_id, u32 *match_mask);
+	int (*destroy_match_definer)(struct mlx5_flow_root_namespace *ns,
+				     int definer_id);
 };
 
 int mlx5_cmd_fc_alloc(struct mlx5_core_dev *dev, u32 *id);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index a55cacb988ac..fbfa5637714d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3319,6 +3319,52 @@ void mlx5_packet_reformat_dealloc(struct mlx5_core_dev *dev,
 }
 EXPORT_SYMBOL(mlx5_packet_reformat_dealloc);
 
+int mlx5_get_match_definer_id(struct mlx5_flow_definer *definer)
+{
+	return definer->id;
+}
+
+struct mlx5_flow_definer *
+mlx5_create_match_definer(struct mlx5_core_dev *dev,
+			  enum mlx5_flow_namespace_type ns_type, u16 format_id,
+			  u32 *match_mask)
+{
+	struct mlx5_flow_root_namespace *root;
+	struct mlx5_flow_definer *definer;
+	int id;
+
+	root = get_root_namespace(dev, ns_type);
+	if (!root)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	definer = kzalloc(sizeof(*definer), GFP_KERNEL);
+	if (!definer)
+		return ERR_PTR(-ENOMEM);
+
+	definer->ns_type = ns_type;
+	id = root->cmds->create_match_definer(root, format_id, match_mask);
+	if (id < 0) {
+		mlx5_core_warn(root->dev, "Failed to create match definer (%d)\n", id);
+		kfree(definer);
+		return ERR_PTR(id);
+	}
+	definer->id = id;
+	return definer;
+}
+
+void mlx5_destroy_match_definer(struct mlx5_core_dev *dev,
+				struct mlx5_flow_definer *definer)
+{
+	struct mlx5_flow_root_namespace *root;
+
+	root = get_root_namespace(dev, definer->ns_type);
+	if (WARN_ON(!root))
+		return;
+
+	root->cmds->destroy_match_definer(root, definer->id);
+	kfree(definer);
+}
+
 int mlx5_flow_namespace_set_peer(struct mlx5_flow_root_namespace *ns,
 				 struct mlx5_flow_root_namespace *peer_ns)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 98240badc342..67cf3cbb8618 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -49,6 +49,11 @@
 #define FDB_TC_MAX_PRIO 16
 #define FDB_TC_LEVELS_PER_PRIO 2
 
+struct mlx5_flow_definer {
+	enum mlx5_flow_namespace_type ns_type;
+	u32 id;
+};
+
 struct mlx5_modify_hdr {
 	enum mlx5_flow_namespace_type ns_type;
 	union {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
index 0553ee1fe80a..5d22a28294d5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/fs_dr.c
@@ -626,6 +626,19 @@ static void mlx5_cmd_dr_modify_header_dealloc(struct mlx5_flow_root_namespace *n
 	mlx5dr_action_destroy(modify_hdr->action.dr_action);
 }
 
+static int
+mlx5_cmd_dr_destroy_match_definer(struct mlx5_flow_root_namespace *ns,
+				  int definer_id)
+{
+	return -EOPNOTSUPP;
+}
+
+static int mlx5_cmd_dr_create_match_definer(struct mlx5_flow_root_namespace *ns,
+					    u16 format_id, u32 *match_mask)
+{
+	return -EOPNOTSUPP;
+}
+
 static int mlx5_cmd_dr_delete_fte(struct mlx5_flow_root_namespace *ns,
 				  struct mlx5_flow_table *ft,
 				  struct fs_fte *fte)
@@ -728,6 +741,8 @@ static const struct mlx5_flow_cmds mlx5_flow_cmds_dr = {
 	.packet_reformat_dealloc = mlx5_cmd_dr_packet_reformat_dealloc,
 	.modify_header_alloc = mlx5_cmd_dr_modify_header_alloc,
 	.modify_header_dealloc = mlx5_cmd_dr_modify_header_dealloc,
+	.create_match_definer = mlx5_cmd_dr_create_match_definer,
+	.destroy_match_definer = mlx5_cmd_dr_destroy_match_definer,
 	.set_peer = mlx5_cmd_dr_set_peer,
 	.create_ns = mlx5_cmd_dr_create_ns,
 	.destroy_ns = mlx5_cmd_dr_destroy_ns,
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 0106c67e8ccb..0e43f0fb6d73 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -97,6 +97,7 @@ enum {
 
 struct mlx5_pkt_reformat;
 struct mlx5_modify_hdr;
+struct mlx5_flow_definer;
 struct mlx5_flow_table;
 struct mlx5_flow_group;
 struct mlx5_flow_namespace;
@@ -257,6 +258,13 @@ struct mlx5_modify_hdr *mlx5_modify_header_alloc(struct mlx5_core_dev *dev,
 						 void *modify_actions);
 void mlx5_modify_header_dealloc(struct mlx5_core_dev *dev,
 				struct mlx5_modify_hdr *modify_hdr);
+struct mlx5_flow_definer *
+mlx5_create_match_definer(struct mlx5_core_dev *dev,
+			  enum mlx5_flow_namespace_type ns_type, u16 format_id,
+			  u32 *match_mask);
+void mlx5_destroy_match_definer(struct mlx5_core_dev *dev,
+				struct mlx5_flow_definer *definer);
+int mlx5_get_match_definer_id(struct mlx5_flow_definer *definer);
 
 struct mlx5_pkt_reformat_params {
 	int type;
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index b89992e8a3c8..5151573da9b2 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -94,6 +94,7 @@ enum {
 enum {
 	MLX5_OBJ_TYPE_GENEVE_TLV_OPT = 0x000b,
 	MLX5_OBJ_TYPE_VIRTIO_NET_Q = 0x000d,
+	MLX5_OBJ_TYPE_MATCH_DEFINER = 0x0018,
 	MLX5_OBJ_TYPE_MKEY = 0xff01,
 	MLX5_OBJ_TYPE_QP = 0xff02,
 	MLX5_OBJ_TYPE_PSV = 0xff03,
@@ -1719,7 +1720,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         flex_parser_id_outer_first_mpls_over_gre[0x4];
 	u8         flex_parser_id_outer_first_mpls_over_udp_label[0x4];
 
-	u8	   reserved_at_6e0[0x10];
+	u8         max_num_match_definer[0x10];
 	u8	   sf_base_id[0x10];
 
 	u8         flex_parser_id_gtpu_dw_2[0x4];
@@ -1734,7 +1735,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 
 	u8	   reserved_at_760[0x20];
 	u8	   vhca_tunnel_commands[0x40];
-	u8	   reserved_at_7c0[0x40];
+	u8         match_definer_format_supported[0x40];
 };
 
 struct mlx5_ifc_cmd_hca_cap_2_bits {
@@ -5618,6 +5619,236 @@ struct mlx5_ifc_query_fte_in_bits {
 	u8         reserved_at_120[0xe0];
 };
 
+struct mlx5_ifc_match_definer_format_0_bits {
+	u8         reserved_at_0[0x100];
+
+	u8         metadata_reg_c_0[0x20];
+
+	u8         metadata_reg_c_1[0x20];
+
+	u8         outer_dmac_47_16[0x20];
+
+	u8         outer_dmac_15_0[0x10];
+	u8         outer_ethertype[0x10];
+
+	u8         reserved_at_180[0x1];
+	u8         sx_sniffer[0x1];
+	u8         functional_lb[0x1];
+	u8         outer_ip_frag[0x1];
+	u8         outer_qp_type[0x2];
+	u8         outer_encap_type[0x2];
+	u8         port_number[0x2];
+	u8         outer_l3_type[0x2];
+	u8         outer_l4_type[0x2];
+	u8         outer_first_vlan_type[0x2];
+	u8         outer_first_vlan_prio[0x3];
+	u8         outer_first_vlan_cfi[0x1];
+	u8         outer_first_vlan_vid[0xc];
+
+	u8         outer_l4_type_ext[0x4];
+	u8         reserved_at_1a4[0x2];
+	u8         outer_ipsec_layer[0x2];
+	u8         outer_l2_type[0x2];
+	u8         force_lb[0x1];
+	u8         outer_l2_ok[0x1];
+	u8         outer_l3_ok[0x1];
+	u8         outer_l4_ok[0x1];
+	u8         outer_second_vlan_type[0x2];
+	u8         outer_second_vlan_prio[0x3];
+	u8         outer_second_vlan_cfi[0x1];
+	u8         outer_second_vlan_vid[0xc];
+
+	u8         outer_smac_47_16[0x20];
+
+	u8         outer_smac_15_0[0x10];
+	u8         inner_ipv4_checksum_ok[0x1];
+	u8         inner_l4_checksum_ok[0x1];
+	u8         outer_ipv4_checksum_ok[0x1];
+	u8         outer_l4_checksum_ok[0x1];
+	u8         inner_l3_ok[0x1];
+	u8         inner_l4_ok[0x1];
+	u8         outer_l3_ok_duplicate[0x1];
+	u8         outer_l4_ok_duplicate[0x1];
+	u8         outer_tcp_cwr[0x1];
+	u8         outer_tcp_ece[0x1];
+	u8         outer_tcp_urg[0x1];
+	u8         outer_tcp_ack[0x1];
+	u8         outer_tcp_psh[0x1];
+	u8         outer_tcp_rst[0x1];
+	u8         outer_tcp_syn[0x1];
+	u8         outer_tcp_fin[0x1];
+};
+
+struct mlx5_ifc_match_definer_format_22_bits {
+	u8         reserved_at_0[0x100];
+
+	u8         outer_ip_src_addr[0x20];
+
+	u8         outer_ip_dest_addr[0x20];
+
+	u8         outer_l4_sport[0x10];
+	u8         outer_l4_dport[0x10];
+
+	u8         reserved_at_160[0x1];
+	u8         sx_sniffer[0x1];
+	u8         functional_lb[0x1];
+	u8         outer_ip_frag[0x1];
+	u8         outer_qp_type[0x2];
+	u8         outer_encap_type[0x2];
+	u8         port_number[0x2];
+	u8         outer_l3_type[0x2];
+	u8         outer_l4_type[0x2];
+	u8         outer_first_vlan_type[0x2];
+	u8         outer_first_vlan_prio[0x3];
+	u8         outer_first_vlan_cfi[0x1];
+	u8         outer_first_vlan_vid[0xc];
+
+	u8         metadata_reg_c_0[0x20];
+
+	u8         outer_dmac_47_16[0x20];
+
+	u8         outer_smac_47_16[0x20];
+
+	u8         outer_smac_15_0[0x10];
+	u8         outer_dmac_15_0[0x10];
+};
+
+struct mlx5_ifc_match_definer_format_23_bits {
+	u8         reserved_at_0[0x100];
+
+	u8         inner_ip_src_addr[0x20];
+
+	u8         inner_ip_dest_addr[0x20];
+
+	u8         inner_l4_sport[0x10];
+	u8         inner_l4_dport[0x10];
+
+	u8         reserved_at_160[0x1];
+	u8         sx_sniffer[0x1];
+	u8         functional_lb[0x1];
+	u8         inner_ip_frag[0x1];
+	u8         inner_qp_type[0x2];
+	u8         inner_encap_type[0x2];
+	u8         port_number[0x2];
+	u8         inner_l3_type[0x2];
+	u8         inner_l4_type[0x2];
+	u8         inner_first_vlan_type[0x2];
+	u8         inner_first_vlan_prio[0x3];
+	u8         inner_first_vlan_cfi[0x1];
+	u8         inner_first_vlan_vid[0xc];
+
+	u8         tunnel_header_0[0x20];
+
+	u8         inner_dmac_47_16[0x20];
+
+	u8         inner_smac_47_16[0x20];
+
+	u8         inner_smac_15_0[0x10];
+	u8         inner_dmac_15_0[0x10];
+};
+
+struct mlx5_ifc_match_definer_format_29_bits {
+	u8         reserved_at_0[0xc0];
+
+	u8         outer_ip_dest_addr[0x80];
+
+	u8         outer_ip_src_addr[0x80];
+
+	u8         outer_l4_sport[0x10];
+	u8         outer_l4_dport[0x10];
+
+	u8         reserved_at_1e0[0x20];
+};
+
+struct mlx5_ifc_match_definer_format_30_bits {
+	u8         reserved_at_0[0xa0];
+
+	u8         outer_ip_dest_addr[0x80];
+
+	u8         outer_ip_src_addr[0x80];
+
+	u8         outer_dmac_47_16[0x20];
+
+	u8         outer_smac_47_16[0x20];
+
+	u8         outer_smac_15_0[0x10];
+	u8         outer_dmac_15_0[0x10];
+};
+
+struct mlx5_ifc_match_definer_format_31_bits {
+	u8         reserved_at_0[0xc0];
+
+	u8         inner_ip_dest_addr[0x80];
+
+	u8         inner_ip_src_addr[0x80];
+
+	u8         inner_l4_sport[0x10];
+	u8         inner_l4_dport[0x10];
+
+	u8         reserved_at_1e0[0x20];
+};
+
+struct mlx5_ifc_match_definer_format_32_bits {
+	u8         reserved_at_0[0xa0];
+
+	u8         inner_ip_dest_addr[0x80];
+
+	u8         inner_ip_src_addr[0x80];
+
+	u8         inner_dmac_47_16[0x20];
+
+	u8         inner_smac_47_16[0x20];
+
+	u8         inner_smac_15_0[0x10];
+	u8         inner_dmac_15_0[0x10];
+};
+
+struct mlx5_ifc_match_definer_bits {
+	u8         modify_field_select[0x40];
+
+	u8         reserved_at_40[0x40];
+
+	u8         reserved_at_80[0x10];
+	u8         format_id[0x10];
+
+	u8         reserved_at_a0[0x160];
+
+	u8         match_mask[16][0x20];
+};
+
+struct mlx5_ifc_general_obj_in_cmd_hdr_bits {
+	u8         opcode[0x10];
+	u8         uid[0x10];
+
+	u8         vhca_tunnel_id[0x10];
+	u8         obj_type[0x10];
+
+	u8         obj_id[0x20];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_general_obj_out_cmd_hdr_bits {
+	u8         status[0x8];
+	u8         reserved_at_8[0x18];
+
+	u8         syndrome[0x20];
+
+	u8         obj_id[0x20];
+
+	u8         reserved_at_60[0x20];
+};
+
+struct mlx5_ifc_create_match_definer_in_bits {
+	struct mlx5_ifc_general_obj_in_cmd_hdr_bits general_obj_in_cmd_hdr;
+
+	struct mlx5_ifc_match_definer_bits obj_context;
+};
+
+struct mlx5_ifc_create_match_definer_out_bits {
+	struct mlx5_ifc_general_obj_out_cmd_hdr_bits general_obj_out_cmd_hdr;
+};
+
 enum {
 	MLX5_QUERY_FLOW_GROUP_OUT_MATCH_CRITERIA_ENABLE_OUTER_HEADERS    = 0x0,
 	MLX5_QUERY_FLOW_GROUP_OUT_MATCH_CRITERIA_ENABLE_MISC_PARAMETERS  = 0x1,
@@ -8091,6 +8322,11 @@ struct mlx5_ifc_create_flow_group_out_bits {
 	u8         reserved_at_60[0x20];
 };
 
+enum {
+	MLX5_CREATE_FLOW_GROUP_IN_GROUP_TYPE_TCAM_SUBTABLE  = 0x0,
+	MLX5_CREATE_FLOW_GROUP_IN_GROUP_TYPE_HASH_SPLIT     = 0x1,
+};
+
 enum {
 	MLX5_CREATE_FLOW_GROUP_IN_MATCH_CRITERIA_ENABLE_OUTER_HEADERS     = 0x0,
 	MLX5_CREATE_FLOW_GROUP_IN_MATCH_CRITERIA_ENABLE_MISC_PARAMETERS   = 0x1,
@@ -8112,7 +8348,9 @@ struct mlx5_ifc_create_flow_group_in_bits {
 	u8         reserved_at_60[0x20];
 
 	u8         table_type[0x8];
-	u8         reserved_at_88[0x18];
+	u8         reserved_at_88[0x4];
+	u8         group_type[0x4];
+	u8         reserved_at_90[0x10];
 
 	u8         reserved_at_a0[0x8];
 	u8         table_id[0x18];
@@ -8127,7 +8365,10 @@ struct mlx5_ifc_create_flow_group_in_bits {
 
 	u8         end_flow_index[0x20];
 
-	u8         reserved_at_140[0xa0];
+	u8         reserved_at_140[0x10];
+	u8         match_definer_id[0x10];
+
+	u8         reserved_at_160[0x80];
 
 	u8         reserved_at_1e0[0x18];
 	u8         match_criteria_enable[0x8];
@@ -10617,29 +10858,6 @@ struct mlx5_ifc_dealloc_memic_out_bits {
 	u8         reserved_at_40[0x40];
 };
 
-struct mlx5_ifc_general_obj_in_cmd_hdr_bits {
-	u8         opcode[0x10];
-	u8         uid[0x10];
-
-	u8         vhca_tunnel_id[0x10];
-	u8         obj_type[0x10];
-
-	u8         obj_id[0x20];
-
-	u8         reserved_at_60[0x20];
-};
-
-struct mlx5_ifc_general_obj_out_cmd_hdr_bits {
-	u8         status[0x8];
-	u8         reserved_at_8[0x18];
-
-	u8         syndrome[0x20];
-
-	u8         obj_id[0x20];
-
-	u8         reserved_at_60[0x20];
-};
-
 struct mlx5_ifc_umem_bits {
 	u8         reserved_at_0[0x80];
 
-- 
2.43.0





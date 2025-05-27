Return-Path: <stable+bounces-147445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 458E6AC57AF
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65A58A6480
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E497280035;
	Tue, 27 May 2025 17:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V2ns5a6O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCAF28002F;
	Tue, 27 May 2025 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367364; cv=none; b=DkZj7UrNchxlfOzXGahEVElOYQbuEd1wKF5BD4D/Vcep+LsN6g1c7QWPRLJLgT44hA+8P1J3c5zqxo7wFYRJY8n1ztJtzGhBOZNkb9FVkv4FHDiQkGcaZfxRwjAaX+mCsUp0PywaXKtQ/XqGhSzIpHrblgfrWP5dp5H3KOK5UiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367364; c=relaxed/simple;
	bh=vwdzYrNHgyCKsIF2+s6eWeWyPbI0A/c8DP2fT3tIJd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7HMzzTYZ7LL8Djp2BXRjtDRW1mqS1cvr1xyOErOXJ89CPN8UvoLA+TB/sN+pfNe1uE2mQeTH7FCDkvuqmbyRqFkFXRhJYCRphbHCvjQMS2PdpSsW7LBD9gMr3qjJPGLDdNjmpLVMya+xUQ9/y+uNZ+wDVBbFyVxO2B9tTkWmeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V2ns5a6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AB5C4CEEB;
	Tue, 27 May 2025 17:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367364;
	bh=vwdzYrNHgyCKsIF2+s6eWeWyPbI0A/c8DP2fT3tIJd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V2ns5a6OapNH1uYxgqRalPAabOK7NpImJ4Y+zZRmaMdzeneu0iWw5h93CsON6iyJ9
	 jjJBacQ0xww+wW5lN4vsOdbT+1rAK65v85S/v1RavQyFqLIasXu070KgNk4uptgjBd
	 xi8mvFmK2a56DMHYekSaxX9PItt6/qWFUwEfUG5U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jianbo Liu <jianbol@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 364/783] net/mlx5e: Add correct match to check IPSec syndromes for switchdev mode
Date: Tue, 27 May 2025 18:22:41 +0200
Message-ID: <20250527162527.905506733@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit 85e4a808af2545fefaf18c8fe50071b06fcbdabc ]

In commit dddb49b63d86 ("net/mlx5e: Add IPsec and ASO syndromes check
in HW"), IPSec and ASO syndromes checks after decryption for the
specified ASO object were added. But they are correct only for eswith
in legacy mode. For switchdev mode, metadata register c1 is used to
save the mapped id (not ASO object id). So, need to change the match
accordingly for the check rules in status table.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://patch.msgid.link/20250220213959.504304-4-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 28 ++++++++++++++-----
 .../mellanox/mlx5/core/esw/ipsec_fs.c         | 13 +++++++++
 .../mellanox/mlx5/core/esw/ipsec_fs.h         |  5 ++++
 include/linux/mlx5/eswitch.h                  |  2 ++
 4 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index e7b64679f1219..3cf44fbdf5ee6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -165,6 +165,25 @@ static void ipsec_rx_status_pass_destroy(struct mlx5e_ipsec *ipsec,
 #endif
 }
 
+static void ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
+					struct mlx5e_ipsec_rx *rx,
+					struct mlx5_flow_spec *spec)
+{
+	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
+
+	if (rx == ipsec->rx_esw) {
+		mlx5_esw_ipsec_rx_rule_add_match_obj(sa_entry, spec);
+	} else {
+		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+				 misc_parameters_2.metadata_reg_c_2);
+		MLX5_SET(fte_match_param, spec->match_value,
+			 misc_parameters_2.metadata_reg_c_2,
+			 sa_entry->ipsec_obj_id | BIT(31));
+
+		spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_2;
+	}
+}
+
 static int rx_add_rule_drop_auth_trailer(struct mlx5e_ipsec_sa_entry *sa_entry,
 					 struct mlx5e_ipsec_rx *rx)
 {
@@ -200,11 +219,8 @@ static int rx_add_rule_drop_auth_trailer(struct mlx5e_ipsec_sa_entry *sa_entry,
 
 	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.ipsec_syndrome);
 	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.ipsec_syndrome, 1);
-	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_2);
-	MLX5_SET(fte_match_param, spec->match_value,
-		 misc_parameters_2.metadata_reg_c_2,
-		 sa_entry->ipsec_obj_id | BIT(31));
 	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+	ipsec_rx_rule_add_match_obj(sa_entry, rx, spec);
 	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
@@ -281,10 +297,8 @@ static int rx_add_rule_drop_replay(struct mlx5e_ipsec_sa_entry *sa_entry, struct
 
 	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_4);
 	MLX5_SET(fte_match_param, spec->match_value, misc_parameters_2.metadata_reg_c_4, 1);
-	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, misc_parameters_2.metadata_reg_c_2);
-	MLX5_SET(fte_match_param, spec->match_value,  misc_parameters_2.metadata_reg_c_2,
-		 sa_entry->ipsec_obj_id | BIT(31));
 	spec->match_criteria_enable = MLX5_MATCH_MISC_PARAMETERS_2;
+	ipsec_rx_rule_add_match_obj(sa_entry, rx, spec);
 	rule = mlx5_add_flow_rules(ft, spec, &flow_act, &dest, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index ed977ae75fab8..4bba2884c1c05 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -85,6 +85,19 @@ int mlx5_esw_ipsec_rx_setup_modify_header(struct mlx5e_ipsec_sa_entry *sa_entry,
 	return err;
 }
 
+void mlx5_esw_ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
+					  struct mlx5_flow_spec *spec)
+{
+	MLX5_SET(fte_match_param, spec->match_criteria,
+		 misc_parameters_2.metadata_reg_c_1,
+		 ESW_IPSEC_RX_MAPPED_ID_MATCH_MASK);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 misc_parameters_2.metadata_reg_c_1,
+		 sa_entry->rx_mapped_id << ESW_ZONE_ID_BITS);
+
+	spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_2;
+}
+
 void mlx5_esw_ipsec_rx_id_mapping_remove(struct mlx5e_ipsec_sa_entry *sa_entry)
 {
 	struct mlx5e_ipsec *ipsec = sa_entry->ipsec;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
index ac9c65b89166e..514c15258b1d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h
@@ -20,6 +20,8 @@ int mlx5_esw_ipsec_rx_ipsec_obj_id_search(struct mlx5e_priv *priv, u32 id,
 void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
 				       struct mlx5e_ipsec_tx_create_attr *attr);
 void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev);
+void mlx5_esw_ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
+					  struct mlx5_flow_spec *spec);
 #else
 static inline void mlx5_esw_ipsec_rx_create_attr_set(struct mlx5e_ipsec *ipsec,
 						     struct mlx5e_ipsec_rx_create_attr *attr) {}
@@ -48,5 +50,8 @@ static inline void mlx5_esw_ipsec_tx_create_attr_set(struct mlx5e_ipsec *ipsec,
 						     struct mlx5e_ipsec_tx_create_attr *attr) {}
 
 static inline void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev) {}
+static inline void
+mlx5_esw_ipsec_rx_rule_add_match_obj(struct mlx5e_ipsec_sa_entry *sa_entry,
+				     struct mlx5_flow_spec *spec) {}
 #endif /* CONFIG_MLX5_ESWITCH */
 #endif /* __MLX5_ESW_IPSEC_FS_H__ */
diff --git a/include/linux/mlx5/eswitch.h b/include/linux/mlx5/eswitch.h
index df73a2ccc9af3..67256e776566c 100644
--- a/include/linux/mlx5/eswitch.h
+++ b/include/linux/mlx5/eswitch.h
@@ -147,6 +147,8 @@ u32 mlx5_eswitch_get_vport_metadata_for_set(struct mlx5_eswitch *esw,
 
 /* reuse tun_opts for the mapped ipsec obj id when tun_id is 0 (invalid) */
 #define ESW_IPSEC_RX_MAPPED_ID_MASK GENMASK(ESW_TUN_OPTS_BITS - 1, 0)
+#define ESW_IPSEC_RX_MAPPED_ID_MATCH_MASK \
+	GENMASK(31 - ESW_RESERVED_BITS, ESW_ZONE_ID_BITS)
 
 u8 mlx5_eswitch_mode(const struct mlx5_core_dev *dev);
 u16 mlx5_eswitch_get_total_vports(const struct mlx5_core_dev *dev);
-- 
2.39.5





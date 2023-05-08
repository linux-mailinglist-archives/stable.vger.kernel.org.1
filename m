Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDDD86FA54D
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbjEHKIA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjEHKIA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:08:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A24EEF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:07:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6E9B60F3A
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6CA4C433EF;
        Mon,  8 May 2023 10:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540477;
        bh=LKtJ6YrfbYIHs8+PzmHcT+C3MymehKWSmJjKRTYHQFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKOfgtZmgRROQUWlfe2AD8boNJ2Xzc8OkTIx1cQy7QGF6CEvejEq+uv8aQqxGRcgC
         qIEQWVsK44pczblrzhGIDWezH8qsl7j+ivbNcyYTYHoYBJ/1HglxJIIPKUkmMO1BGo
         7O/A4XWKjZ0sLHjnJ+9F/aLLvd2g4n9uWbrTNM/k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Mi <cmi@nvidia.com>,
        Roi Dayan <roid@nvidia.com>, Maor Dickman <maord@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 378/611] net/mlx5: E-switch, Create per vport table based on devlink encap mode
Date:   Mon,  8 May 2023 11:43:40 +0200
Message-Id: <20230508094434.623912474@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Chris Mi <cmi@nvidia.com>

[ Upstream commit fd745f4c0abe41ebb09d11bf622b054a0f3e7b49 ]

Currently when creating per vport table, create flags are hardcoded.
Devlink encap mode is set based on user input and HW capability.
Create per vport table based on devlink encap mode.

Fixes: c796bb7cd230 ("net/mlx5: E-switch, Generalize per vport table API")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Maor Dickman <maord@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/en/tc/sample.c   |  4 ++--
 .../net/ethernet/mellanox/mlx5/core/esw/vporttbl.c   | 12 +++++++++++-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.h    |  2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c   |  2 +-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
index f2c2c752bd1c3..c57b097275241 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/sample.c
@@ -14,10 +14,10 @@
 
 #define MLX5_ESW_VPORT_TBL_SIZE_SAMPLE (64 * 1024)
 
-static const struct esw_vport_tbl_namespace mlx5_esw_vport_tbl_sample_ns = {
+static struct esw_vport_tbl_namespace mlx5_esw_vport_tbl_sample_ns = {
 	.max_fte = MLX5_ESW_VPORT_TBL_SIZE_SAMPLE,
 	.max_num_groups = 0,    /* default num of groups */
-	.flags = MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT | MLX5_FLOW_TABLE_TUNNEL_EN_DECAP,
+	.flags = 0,
 };
 
 struct mlx5e_tc_psample {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c
index 9e72118f2e4c0..749c3957a1280 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/vporttbl.c
@@ -11,7 +11,7 @@ struct mlx5_vport_key {
 	u16 prio;
 	u16 vport;
 	u16 vhca_id;
-	const struct esw_vport_tbl_namespace *vport_ns;
+	struct esw_vport_tbl_namespace *vport_ns;
 } __packed;
 
 struct mlx5_vport_table {
@@ -21,6 +21,14 @@ struct mlx5_vport_table {
 	struct mlx5_vport_key key;
 };
 
+static void
+esw_vport_tbl_init(struct mlx5_eswitch *esw, struct esw_vport_tbl_namespace *ns)
+{
+	if (esw->offloads.encap != DEVLINK_ESWITCH_ENCAP_MODE_NONE)
+		ns->flags |= (MLX5_FLOW_TABLE_TUNNEL_EN_REFORMAT |
+			      MLX5_FLOW_TABLE_TUNNEL_EN_DECAP);
+}
+
 static struct mlx5_flow_table *
 esw_vport_tbl_create(struct mlx5_eswitch *esw, struct mlx5_flow_namespace *ns,
 		     const struct esw_vport_tbl_namespace *vport_ns)
@@ -80,6 +88,7 @@ mlx5_esw_vporttbl_get(struct mlx5_eswitch *esw, struct mlx5_vport_tbl_attr *attr
 	u32 hkey;
 
 	mutex_lock(&esw->fdb_table.offloads.vports.lock);
+	esw_vport_tbl_init(esw, attr->vport_ns);
 	hkey = flow_attr_to_vport_key(esw, attr, &skey);
 	e = esw_vport_tbl_lookup(esw, &skey, hkey);
 	if (e) {
@@ -127,6 +136,7 @@ mlx5_esw_vporttbl_put(struct mlx5_eswitch *esw, struct mlx5_vport_tbl_attr *attr
 	u32 hkey;
 
 	mutex_lock(&esw->fdb_table.offloads.vports.lock);
+	esw_vport_tbl_init(esw, attr->vport_ns);
 	hkey = flow_attr_to_vport_key(esw, attr, &key);
 	e = esw_vport_tbl_lookup(esw, &key, hkey);
 	if (!e || --e->num_rules)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 5db76af35d3f5..6e6e0864063f1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -668,7 +668,7 @@ struct mlx5_vport_tbl_attr {
 	u32 chain;
 	u16 prio;
 	u16 vport;
-	const struct esw_vport_tbl_namespace *vport_ns;
+	struct esw_vport_tbl_namespace *vport_ns;
 };
 
 struct mlx5_flow_table *
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 64e5b9f29206e..ac8cf1b93e46a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -72,7 +72,7 @@
 
 #define MLX5_ESW_FT_OFFLOADS_DROP_RULE (1)
 
-static const struct esw_vport_tbl_namespace mlx5_esw_vport_tbl_mirror_ns = {
+static struct esw_vport_tbl_namespace mlx5_esw_vport_tbl_mirror_ns = {
 	.max_fte = MLX5_ESW_VPORT_TBL_SIZE,
 	.max_num_groups = MLX5_ESW_VPORT_TBL_NUM_GROUPS,
 	.flags = 0,
-- 
2.39.2




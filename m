Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65919719DEE
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbjFAN1m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbjFAN1d (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5064310F1
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:27:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27B73644CF
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE07C433EF;
        Thu,  1 Jun 2023 13:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626036;
        bh=d0fPLSNHGRqjjVdn/v5Fvl6vNb3lJ1SYI6GOxgU135I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBTsWAQv0MJ/idS1gx62CnW3pLHS8dnmckTDaL+VpbZJF4c12T9GiP9Fk0HYtJNEs
         laBhu5G+AJQY9L7LE0MixDE/AzcQr1b46XzcOyY2Bmsx6PSFovqyxDASwKDCF+nnbu
         ul3JxgoIm/trAzJevoJRBvANw5f1serc8xmfo+A8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Maher Sanalla <msanalla@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 25/45] Revert "net/mlx5: Expose steering dropped packets counter"
Date:   Thu,  1 Jun 2023 14:21:21 +0100
Message-Id: <20230601131939.843077487@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Maher Sanalla <msanalla@nvidia.com>

[ Upstream commit e267b8a52ca5d5e8434929a5e9f5574aed141024 ]

This reverts commit 4fe1b3a5f8fe2fdcedcaba9561e5b0ae5cb1d15b, which
exposes the steering dropped packets counter via debugfs. The upcoming
series will expose the counter via devlink health reporter instead
of debugfs.

Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Stable-dep-of: 8c253dfc89ef ("net/mlx5: E-switch, Devcom, sync devcom events and devcom comp register")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/mellanox/mlx5/core/esw/debugfs.c | 22 +++----------------
 1 file changed, 3 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/debugfs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/debugfs.c
index 3d0bbcca1cb99..2db13c71e88cd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/debugfs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/debugfs.c
@@ -12,11 +12,10 @@ enum vnic_diag_counter {
 	MLX5_VNIC_DIAG_CQ_OVERRUN,
 	MLX5_VNIC_DIAG_INVALID_COMMAND,
 	MLX5_VNIC_DIAG_QOUTA_EXCEEDED_COMMAND,
-	MLX5_VNIC_DIAG_RX_STEERING_DISCARD,
 };
 
 static int mlx5_esw_query_vnic_diag(struct mlx5_vport *vport, enum vnic_diag_counter counter,
-				    u64 *val)
+				    u32 *val)
 {
 	u32 out[MLX5_ST_SZ_DW(query_vnic_env_out)] = {};
 	u32 in[MLX5_ST_SZ_DW(query_vnic_env_in)] = {};
@@ -58,10 +57,6 @@ static int mlx5_esw_query_vnic_diag(struct mlx5_vport *vport, enum vnic_diag_cou
 	case MLX5_VNIC_DIAG_QOUTA_EXCEEDED_COMMAND:
 		*val = MLX5_GET(vnic_diagnostic_statistics, vnic_diag_out, quota_exceeded_command);
 		break;
-	case MLX5_VNIC_DIAG_RX_STEERING_DISCARD:
-		*val = MLX5_GET64(vnic_diagnostic_statistics, vnic_diag_out,
-				  nic_receive_steering_discard);
-		break;
 	}
 
 	return 0;
@@ -70,14 +65,14 @@ static int mlx5_esw_query_vnic_diag(struct mlx5_vport *vport, enum vnic_diag_cou
 static int __show_vnic_diag(struct seq_file *file, struct mlx5_vport *vport,
 			    enum vnic_diag_counter type)
 {
-	u64 val = 0;
+	u32 val = 0;
 	int ret;
 
 	ret = mlx5_esw_query_vnic_diag(vport, type, &val);
 	if (ret)
 		return ret;
 
-	seq_printf(file, "%llu\n", val);
+	seq_printf(file, "%d\n", val);
 	return 0;
 }
 
@@ -117,11 +112,6 @@ static int quota_exceeded_command_show(struct seq_file *file, void *priv)
 	return __show_vnic_diag(file, file->private, MLX5_VNIC_DIAG_QOUTA_EXCEEDED_COMMAND);
 }
 
-static int rx_steering_discard_show(struct seq_file *file, void *priv)
-{
-	return __show_vnic_diag(file, file->private, MLX5_VNIC_DIAG_RX_STEERING_DISCARD);
-}
-
 DEFINE_SHOW_ATTRIBUTE(total_q_under_processor_handle);
 DEFINE_SHOW_ATTRIBUTE(send_queue_priority_update_flow);
 DEFINE_SHOW_ATTRIBUTE(comp_eq_overrun);
@@ -129,7 +119,6 @@ DEFINE_SHOW_ATTRIBUTE(async_eq_overrun);
 DEFINE_SHOW_ATTRIBUTE(cq_overrun);
 DEFINE_SHOW_ATTRIBUTE(invalid_command);
 DEFINE_SHOW_ATTRIBUTE(quota_exceeded_command);
-DEFINE_SHOW_ATTRIBUTE(rx_steering_discard);
 
 void mlx5_esw_vport_debugfs_destroy(struct mlx5_eswitch *esw, u16 vport_num)
 {
@@ -190,9 +179,4 @@ void mlx5_esw_vport_debugfs_create(struct mlx5_eswitch *esw, u16 vport_num, bool
 	if (MLX5_CAP_GEN(esw->dev, quota_exceeded_count))
 		debugfs_create_file("quota_exceeded_command", 0444, vnic_diag, vport,
 				    &quota_exceeded_command_fops);
-
-	if (MLX5_CAP_GEN(esw->dev, nic_receive_steering_discard))
-		debugfs_create_file("rx_steering_discard", 0444, vnic_diag, vport,
-				    &rx_steering_discard_fops);
-
 }
-- 
2.39.2




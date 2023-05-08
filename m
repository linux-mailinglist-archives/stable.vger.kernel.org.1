Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC726FA555
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbjEHKIU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234099AbjEHKIT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:08:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160FD3291D
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:08:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1BE462295
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:08:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F76C433EF;
        Mon,  8 May 2023 10:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540498;
        bh=QxPLpj3IIvVwxGZC7PKYRa8TqIGc9bRtmRrvRImNCzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UKeD0o4ug47cyTOpfPf68miaCHx2sXr6f+AoohzLWdIvGY2juyFhw7wDdVxhtiUY9
         i/s0zEQ9iwqX/qcB6OOXnR8D+Ps3tOQByRYRq25r73rGi+TfisXxgxZCbqxpWl5gM1
         duvp+p021KyT6sVczXpMY4xjbXLYYCwCh4h5VRrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roi Dayan <roid@nvidia.com>,
        Maor Dickman <maord@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 380/611] net/mlx5e: Fix error flow in representor failing to add vport rx rule
Date:   Mon,  8 May 2023 11:43:42 +0200
Message-Id: <20230508094434.680830015@linuxfoundation.org>
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

From: Roi Dayan <roid@nvidia.com>

[ Upstream commit 0a6b069cc60d68d33b4f6e7dd7f1adc3ec749766 ]

On representor init rx error flow the flow steering pointer is being
released so mlx5e_attach_netdev() doesn't have a valid fs pointer
in its error flow. Make sure the pointer is nullified when released
and add a check in mlx5e_fs_cleanup() to verify fs is not null
as representor cleanup callback would be called anyway.

Fixes: af8bbf730068 ("net/mlx5e: Convert mlx5e_flow_steering member of mlx5e_priv to pointer")
Signed-off-by: Roi Dayan <roid@nvidia.com>
Reviewed-by: Maor Dickman <maord@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c   | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c  | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 7cd36f4ac3efc..edbe22d93c992 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -1471,6 +1471,8 @@ struct mlx5e_flow_steering *mlx5e_fs_init(const struct mlx5e_profile *profile,
 
 void mlx5e_fs_cleanup(struct mlx5e_flow_steering *fs)
 {
+	if (!fs)
+		return;
 	mlx5e_fs_ethtool_free(fs);
 	mlx5e_fs_tc_free(fs);
 	mlx5e_fs_vlan_free(fs);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5e01de4c32037..94d010e2d5efd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5201,6 +5201,7 @@ static void mlx5e_nic_cleanup(struct mlx5e_priv *priv)
 	mlx5e_ktls_cleanup(priv);
 	mlx5e_ipsec_cleanup(priv);
 	mlx5e_fs_cleanup(priv->fs);
+	priv->fs = NULL;
 }
 
 static int mlx5e_init_nic_rx(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 0f744131c6869..9bd1a93a512d4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -783,6 +783,7 @@ static void mlx5e_cleanup_rep(struct mlx5e_priv *priv)
 {
 	mlx5e_fs_cleanup(priv->fs);
 	mlx5e_ipsec_cleanup(priv);
+	priv->fs = NULL;
 }
 
 static int mlx5e_create_rep_ttc_table(struct mlx5e_priv *priv)
@@ -949,6 +950,7 @@ static int mlx5e_init_rep_rx(struct mlx5e_priv *priv)
 	priv->rx_res = NULL;
 err_free_fs:
 	mlx5e_fs_cleanup(priv->fs);
+	priv->fs = NULL;
 	return err;
 }
 
-- 
2.39.2




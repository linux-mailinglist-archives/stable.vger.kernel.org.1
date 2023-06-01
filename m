Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF28719DAB
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjFANZh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233721AbjFANZY (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:25:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AB1199
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9022D64477
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF038C433EF;
        Thu,  1 Jun 2023 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625892;
        bh=Zd2jA4L3U9/zqpvf2P2wxL/fkV9XremJKIIbapeu5pU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A+sy/TV/s5ZsHAsWXHGo3SI6jGz2iFzasZdbY4iqgWFBaSQSgcnK/efgmB+aIdnex
         yY7HFZMRi/IEq+uHEdg7NheKFWkY4g47AVDtV2fBgh0nyErsA4c6FyLbhZYlUEdazi
         woRP0WntTc5GAEbtg8QkLSBBomOkCcTRFE8cM7vM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Bloch <mbloch@nvidia.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 08/42] net/mlx5: devcom only supports 2 ports
Date:   Thu,  1 Jun 2023 14:20:55 +0100
Message-Id: <20230601131937.067948452@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131936.699199833@linuxfoundation.org>
References: <20230601131936.699199833@linuxfoundation.org>
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

From: Mark Bloch <mbloch@nvidia.com>

[ Upstream commit 8a6e75e5f57e9ac82268d9bfca3403598d9d0292 ]

Devcom API is intended to be used between 2 devices only add this
implied assumption into the code and check when it's no true.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Stable-dep-of: 691c041bf208 ("net/mlx5e: Fix deadlock in tc route query code")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c | 16 +++++++++-------
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h |  2 ++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index abd066e952286..617eea1b1701b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -14,7 +14,7 @@ static LIST_HEAD(devcom_list);
 struct mlx5_devcom_component {
 	struct {
 		void *data;
-	} device[MLX5_MAX_PORTS];
+	} device[MLX5_DEVCOM_PORTS_SUPPORTED];
 
 	mlx5_devcom_event_handler_t handler;
 	struct rw_semaphore sem;
@@ -25,7 +25,7 @@ struct mlx5_devcom_list {
 	struct list_head list;
 
 	struct mlx5_devcom_component components[MLX5_DEVCOM_NUM_COMPONENTS];
-	struct mlx5_core_dev *devs[MLX5_MAX_PORTS];
+	struct mlx5_core_dev *devs[MLX5_DEVCOM_PORTS_SUPPORTED];
 };
 
 struct mlx5_devcom {
@@ -74,13 +74,15 @@ struct mlx5_devcom *mlx5_devcom_register_device(struct mlx5_core_dev *dev)
 
 	if (!mlx5_core_is_pf(dev))
 		return NULL;
+	if (MLX5_CAP_GEN(dev, num_lag_ports) != MLX5_DEVCOM_PORTS_SUPPORTED)
+		return NULL;
 
 	sguid0 = mlx5_query_nic_system_image_guid(dev);
 	list_for_each_entry(iter, &devcom_list, list) {
 		struct mlx5_core_dev *tmp_dev = NULL;
 
 		idx = -1;
-		for (i = 0; i < MLX5_MAX_PORTS; i++) {
+		for (i = 0; i < MLX5_DEVCOM_PORTS_SUPPORTED; i++) {
 			if (iter->devs[i])
 				tmp_dev = iter->devs[i];
 			else
@@ -135,11 +137,11 @@ void mlx5_devcom_unregister_device(struct mlx5_devcom *devcom)
 
 	kfree(devcom);
 
-	for (i = 0; i < MLX5_MAX_PORTS; i++)
+	for (i = 0; i < MLX5_DEVCOM_PORTS_SUPPORTED; i++)
 		if (priv->devs[i])
 			break;
 
-	if (i != MLX5_MAX_PORTS)
+	if (i != MLX5_DEVCOM_PORTS_SUPPORTED)
 		return;
 
 	list_del(&priv->list);
@@ -192,7 +194,7 @@ int mlx5_devcom_send_event(struct mlx5_devcom *devcom,
 
 	comp = &devcom->priv->components[id];
 	down_write(&comp->sem);
-	for (i = 0; i < MLX5_MAX_PORTS; i++)
+	for (i = 0; i < MLX5_DEVCOM_PORTS_SUPPORTED; i++)
 		if (i != devcom->idx && comp->device[i].data) {
 			err = comp->handler(event, comp->device[i].data,
 					    event_data);
@@ -240,7 +242,7 @@ void *mlx5_devcom_get_peer_data(struct mlx5_devcom *devcom,
 		return NULL;
 	}
 
-	for (i = 0; i < MLX5_MAX_PORTS; i++)
+	for (i = 0; i < MLX5_DEVCOM_PORTS_SUPPORTED; i++)
 		if (i != devcom->idx)
 			break;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index 939d5bf1581b5..94313c18bb647 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -6,6 +6,8 @@
 
 #include <linux/mlx5/driver.h>
 
+#define MLX5_DEVCOM_PORTS_SUPPORTED 2
+
 enum mlx5_devcom_components {
 	MLX5_DEVCOM_ESW_OFFLOADS,
 
-- 
2.39.2




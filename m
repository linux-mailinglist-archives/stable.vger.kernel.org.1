Return-Path: <stable+bounces-41022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23F88AFA0A
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7908284CC7
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C85D1487F4;
	Tue, 23 Apr 2024 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L2qJi7F+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AED91487DD;
	Tue, 23 Apr 2024 21:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908624; cv=none; b=gzifcve+YL5u2cvoM/098cLOejXM/pyuB1qNv4uamx7D1e/uGj3MB/0wD5Y2nTgXQSsgbJbAlzX+cbTOhgc3C8LuXk3yzwXOXzkpOMOyZRcXxHL5+925ed9tCXf8vmg6NviBRZczSJdZIPFJRk6epnhMR7+kk22J8GfvPaVP9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908624; c=relaxed/simple;
	bh=C9/wWXH+SoWWY1JwQGLYtvvf7Ze9PqstVKKwnMxD0FE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lm/Y8YV0rJKEtfR//U0heYBktx8UvVeWVO4LdHOxoVpPYnZYx6TQRl8LGIDY+pi4IgeFxnP26Uvcu5FUuQEh+t5B1+356NIKr5UgPsb5U9afau/WfvBQgDuKshlKvSrJlHgFY6GCvyV16I7wUaHhV825xl2ZNG9G043/3M+nQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L2qJi7F+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D009C32781;
	Tue, 23 Apr 2024 21:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908624;
	bh=C9/wWXH+SoWWY1JwQGLYtvvf7Ze9PqstVKKwnMxD0FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2qJi7F+wUKbv2NkaZTMZvnceMgD2chp21OYnsScVwbcYTWwUUE/m/jDd1PQUe9YJ
	 GHjp777jeSmMkdboD+8GrEyccpjGmBd/6ELRZjJ9+ihuzZkoD/YBwnGrxvBmrVNSUH
	 MN9eqYbwPApLgIS89VQNWw/1MZhcelC8ZbW7M3FM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 099/158] net/mlx5: E-switch, store eswitch pointer before registering devlink_param
Date: Tue, 23 Apr 2024 14:38:56 -0700
Message-ID: <20240423213858.963300158@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213855.696477232@linuxfoundation.org>
References: <20240423213855.696477232@linuxfoundation.org>
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

From: Shay Drory <shayd@nvidia.com>

[ Upstream commit 0553e753ea9ee724acaf6b3dfc7354702af83567 ]

Next patch will move devlink register to be first. Therefore, whenever
mlx5 will register a param, the user will be notified.
In order to notify the user, devlink is using the get() callback of
the param. Hence, resources that are being used by the get() callback
must be set before the devlink param is registered.

Therefore, store eswitch pointer inside mdev before registering the
param.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Link: https://lore.kernel.org/r/20240409190820.227554-2-tariqt@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c        | 9 +++------
 .../net/ethernet/mellanox/mlx5/core/eswitch_offloads.c   | 4 ++++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 3047d7015c525..1789800faaeb6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1868,6 +1868,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto abort;
 
+	dev->priv.eswitch = esw;
 	err = esw_offloads_init(esw);
 	if (err)
 		goto reps_err;
@@ -1892,11 +1893,6 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_BASIC;
 	else
 		esw->offloads.encap = DEVLINK_ESWITCH_ENCAP_MODE_NONE;
-	if (MLX5_ESWITCH_MANAGER(dev) &&
-	    mlx5_esw_vport_match_metadata_supported(esw))
-		esw->flags |= MLX5_ESWITCH_VPORT_MATCH_METADATA;
-
-	dev->priv.eswitch = esw;
 	BLOCKING_INIT_NOTIFIER_HEAD(&esw->n_head);
 
 	esw_info(dev,
@@ -1908,6 +1904,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 
 reps_err:
 	mlx5_esw_vports_cleanup(esw);
+	dev->priv.eswitch = NULL;
 abort:
 	if (esw->work_queue)
 		destroy_workqueue(esw->work_queue);
@@ -1926,7 +1923,6 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 
 	esw_info(esw->dev, "cleanup\n");
 
-	esw->dev->priv.eswitch = NULL;
 	destroy_workqueue(esw->work_queue);
 	WARN_ON(refcount_read(&esw->qos.refcnt));
 	mutex_destroy(&esw->state_lock);
@@ -1937,6 +1933,7 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 	mutex_destroy(&esw->offloads.encap_tbl_lock);
 	mutex_destroy(&esw->offloads.decap_tbl_lock);
 	esw_offloads_cleanup(esw);
+	esw->dev->priv.eswitch = NULL;
 	mlx5_esw_vports_cleanup(esw);
 	debugfs_remove_recursive(esw->debugfs_root);
 	devl_params_unregister(priv_to_devlink(esw->dev), mlx5_eswitch_params,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index baaae628b0a0f..e3cce110e52fd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2476,6 +2476,10 @@ int esw_offloads_init(struct mlx5_eswitch *esw)
 	if (err)
 		return err;
 
+	if (MLX5_ESWITCH_MANAGER(esw->dev) &&
+	    mlx5_esw_vport_match_metadata_supported(esw))
+		esw->flags |= MLX5_ESWITCH_VPORT_MATCH_METADATA;
+
 	err = devl_params_register(priv_to_devlink(esw->dev),
 				   esw_devlink_params,
 				   ARRAY_SIZE(esw_devlink_params));
-- 
2.43.0





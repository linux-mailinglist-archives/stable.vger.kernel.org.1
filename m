Return-Path: <stable+bounces-167852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AFAB231D9
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082917A6011
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28A6280037;
	Tue, 12 Aug 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cbbmAsAP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F581C84C7;
	Tue, 12 Aug 2025 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022208; cv=none; b=BrU0XaSvjV18UbVgtzn7CSEZJk+B1Zc+npx1Jd9t/7wptKOxfQdtGEENpSBqSgCgOTZCA6MHoWK+a9h3t+JMdTHlM81hIaZCw2XJ91TcKpDkdKr6uosFemDu+QiOYUfnplVsbl+CnTOQuPRQfVTQMNY7A3nJNerMejjg3ekNNng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022208; c=relaxed/simple;
	bh=bA4RwKH5iIshKlzCBg12ChdYXUqzA/9W2h2h5Oi2+Bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxWRBZXetEQ8W4zVPBHux84+E8z0EnQARslbvi1BfKJiuu5xPB9NMZizWArVc7YJkW2Oof3gorCfamAH0rxL+hXA95OjT40qYR7BHWYKyIcNd8dYRqAlZsOAvGgS0Ovis/ZlizCY1amFtLQiXNW483fZmT8jixxlZfChQopYGVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cbbmAsAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEFDC4CEF0;
	Tue, 12 Aug 2025 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022208;
	bh=bA4RwKH5iIshKlzCBg12ChdYXUqzA/9W2h2h5Oi2+Bc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cbbmAsAPs4d4gH6tCC+lXOp50ZzenUT7/Cv6Jq5W9gaAdKatiB1CFRdoFznzOjLU2
	 STB1dlB//p/BSpDShp6hIkGaL5rt7UGUQX2x12adB0CALKrvJRn0D9areoOty0Lb6i
	 P5EVQqS0Vi3nd5z1VWXWMqbcALxOI68STvItfbDE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stav Aviram <saviram@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 087/369] net/mlx5: Check device memory pointer before usage
Date: Tue, 12 Aug 2025 19:26:24 +0200
Message-ID: <20250812173018.053014473@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stav Aviram <saviram@nvidia.com>

[ Upstream commit 70f238c902b8c0461ae6fbb8d1a0bbddc4350eea ]

Add a NULL check before accessing device memory to prevent a crash if
dev->dm allocation in mlx5_init_once() fails.

Fixes: c9b9dcb430b3 ("net/mlx5: Move device memory management to mlx5_core")
Signed-off-by: Stav Aviram <saviram@nvidia.com>
Link: https://patch.msgid.link/c88711327f4d74d5cebc730dc629607e989ca187.1751370035.git.leon@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/mlx5/dm.c                  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/main.c   | 3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/dm.c b/drivers/infiniband/hw/mlx5/dm.c
index b4c97fb62abf..9ded2b7c1e31 100644
--- a/drivers/infiniband/hw/mlx5/dm.c
+++ b/drivers/infiniband/hw/mlx5/dm.c
@@ -282,7 +282,7 @@ static struct ib_dm *handle_alloc_dm_memic(struct ib_ucontext *ctx,
 	int err;
 	u64 address;
 
-	if (!MLX5_CAP_DEV_MEM(dm_db->dev, memic))
+	if (!dm_db || !MLX5_CAP_DEV_MEM(dm_db->dev, memic))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
index 7c5516b0a844..8115071c34a4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c
@@ -30,7 +30,7 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 
 	dm = kzalloc(sizeof(*dm), GFP_KERNEL);
 	if (!dm)
-		return ERR_PTR(-ENOMEM);
+		return NULL;
 
 	spin_lock_init(&dm->lock);
 
@@ -96,7 +96,7 @@ struct mlx5_dm *mlx5_dm_create(struct mlx5_core_dev *dev)
 err_steering:
 	kfree(dm);
 
-	return ERR_PTR(-ENOMEM);
+	return NULL;
 }
 
 void mlx5_dm_cleanup(struct mlx5_core_dev *dev)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 5bc947f703b5..11d8739b9497 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1092,9 +1092,6 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	}
 
 	dev->dm = mlx5_dm_create(dev);
-	if (IS_ERR(dev->dm))
-		mlx5_core_warn(dev, "Failed to init device memory %ld\n", PTR_ERR(dev->dm));
-
 	dev->tracer = mlx5_fw_tracer_create(dev);
 	dev->hv_vhca = mlx5_hv_vhca_create(dev);
 	dev->rsc_dump = mlx5_rsc_dump_create(dev);
-- 
2.39.5





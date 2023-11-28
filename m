Return-Path: <stable+bounces-2957-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE1B7FC6D1
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 22:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67BC52862AD
	for <lists+stable@lfdr.de>; Tue, 28 Nov 2023 21:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F444C7D;
	Tue, 28 Nov 2023 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9yyCiXo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F544398;
	Tue, 28 Nov 2023 21:06:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06180C433CC;
	Tue, 28 Nov 2023 21:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205598;
	bh=6+S+VtCUCXVyhj8zoX/JSLLVuCBHCn/YurDvOyWjeYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9yyCiXofmX76IC6WzDmNOlquO5sz25NOzcAdGHGgOYu330jaHF7i5kl9T9bfHWb/
	 SE2kjNvN9i2ka+yDykO5hZyhtUv8uOlvmKk3L6BwPJSJWChyQqnDuKcE7K5WtVo9uA
	 ORv5u6yB/fJps1xBMSgxeFhOgRjvWvEmUkcu7eMK+xcM2zWQ+1M0VAjJDhN1yTG0X1
	 4OLRqlJpIQHRItujcveGqvR23+/H3O4pIS/MoyiUlLFv2l82OnHns+7vITAxLGoAAW
	 a8/3CJ1iBPMkUhNAZoPEmuZAlb64pPRbBW+fWdq6AV3VYC30+g3UuaF+5DQk82TJRu
	 wpH1nnUJ0kA7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org,
	nbd@other.debian.org
Subject: [PATCH AUTOSEL 6.6 11/40] nbd: fold nbd config initialization into nbd_alloc_config()
Date: Tue, 28 Nov 2023 16:05:17 -0500
Message-ID: <20231128210615.875085-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit

From: Li Nan <linan122@huawei.com>

[ Upstream commit 1b59860540a4018e8071dc18d4893ec389506b7d ]

There are no functional changes, make the code cleaner and prepare to
fix null-ptr-dereference while accessing 'nbd->config'.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Link: https://lore.kernel.org/r/20231116162316.1740402-2-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 855fdf5c3b4ea..02f844832d912 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1530,17 +1530,20 @@ static int nbd_ioctl(struct block_device *bdev, blk_mode_t mode,
 	return error;
 }
 
-static struct nbd_config *nbd_alloc_config(void)
+static int nbd_alloc_and_init_config(struct nbd_device *nbd)
 {
 	struct nbd_config *config;
 
+	if (WARN_ON(nbd->config))
+		return -EINVAL;
+
 	if (!try_module_get(THIS_MODULE))
-		return ERR_PTR(-ENODEV);
+		return -ENODEV;
 
 	config = kzalloc(sizeof(struct nbd_config), GFP_NOFS);
 	if (!config) {
 		module_put(THIS_MODULE);
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 
 	atomic_set(&config->recv_threads, 0);
@@ -1548,7 +1551,10 @@ static struct nbd_config *nbd_alloc_config(void)
 	init_waitqueue_head(&config->conn_wait);
 	config->blksize_bits = NBD_DEF_BLKSIZE_BITS;
 	atomic_set(&config->live_connections, 0);
-	return config;
+	nbd->config = config;
+	refcount_set(&nbd->config_refs, 1);
+
+	return 0;
 }
 
 static int nbd_open(struct gendisk *disk, blk_mode_t mode)
@@ -1567,21 +1573,17 @@ static int nbd_open(struct gendisk *disk, blk_mode_t mode)
 		goto out;
 	}
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
-		struct nbd_config *config;
-
 		mutex_lock(&nbd->config_lock);
 		if (refcount_inc_not_zero(&nbd->config_refs)) {
 			mutex_unlock(&nbd->config_lock);
 			goto out;
 		}
-		config = nbd_alloc_config();
-		if (IS_ERR(config)) {
-			ret = PTR_ERR(config);
+		ret = nbd_alloc_and_init_config(nbd);
+		if (ret) {
 			mutex_unlock(&nbd->config_lock);
 			goto out;
 		}
-		nbd->config = config;
-		refcount_set(&nbd->config_refs, 1);
+
 		refcount_inc(&nbd->refs);
 		mutex_unlock(&nbd->config_lock);
 		if (max_part)
@@ -1990,22 +1992,17 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 		pr_err("nbd%d already in use\n", index);
 		return -EBUSY;
 	}
-	if (WARN_ON(nbd->config)) {
-		mutex_unlock(&nbd->config_lock);
-		nbd_put(nbd);
-		return -EINVAL;
-	}
-	config = nbd_alloc_config();
-	if (IS_ERR(config)) {
+
+	ret = nbd_alloc_and_init_config(nbd);
+	if (ret) {
 		mutex_unlock(&nbd->config_lock);
 		nbd_put(nbd);
 		pr_err("couldn't allocate config\n");
-		return PTR_ERR(config);
+		return ret;
 	}
-	nbd->config = config;
-	refcount_set(&nbd->config_refs, 1);
-	set_bit(NBD_RT_BOUND, &config->runtime_flags);
 
+	config = nbd->config;
+	set_bit(NBD_RT_BOUND, &config->runtime_flags);
 	ret = nbd_genl_size_set(info, nbd);
 	if (ret)
 		goto out;
-- 
2.42.0



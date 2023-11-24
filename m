Return-Path: <stable+bounces-1216-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D81F7F7E8F
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE721C213D5
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0425F341AE;
	Fri, 24 Nov 2023 18:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OYiUMjSJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD033CC2;
	Fri, 24 Nov 2023 18:34:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ACEC433C8;
	Fri, 24 Nov 2023 18:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700850847;
	bh=CCTotj3vHCXth1ihqHNSJ7z+j6z80UL24aJ7x669Oks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OYiUMjSJ4RC4OwN4YIDTbH7C9x2Rga9BfLNFabxvoKubHNmbOyhmiy5NQunyh2vUM
	 gnHwjzZ9Qvz79uV+67x1FD9SWxG8BQpTp9kQ2ubuTiA9wMtgrzmwI/zLBu/hXOv0Uh
	 dWocuRMxr5woea8ppTgMewCkjdMivS5yx4RZphjI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 212/491] net/mlx5: Increase size of irq name buffer
Date: Fri, 24 Nov 2023 17:47:28 +0000
Message-ID: <20231124172030.899419921@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172024.664207345@linuxfoundation.org>
References: <20231124172024.664207345@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

[ Upstream commit 3338bebfc26a1e2cebbba82a1cf12c0159608e73 ]

Without increased buffer size, will trigger -Wformat-truncation with W=1
for the snprintf operation writing to the buffer.

    drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c: In function 'mlx5_irq_alloc':
    drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:296:7: error: '@pci:' directive output may be truncated writing 5 bytes into a region of size between 1 and 32 [-Werror=format-truncation=]
      296 |    "%s@pci:%s", name, pci_name(dev->pdev));
          |       ^~~~~
    drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c:295:2: note: 'snprintf' output 6 or more bytes (assuming 37) into a destination of size 32
      295 |  snprintf(irq->name, MLX5_MAX_IRQ_NAME,
          |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
      296 |    "%s@pci:%s", name, pci_name(dev->pdev));
          |    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: ada9f5d00797 ("IB/mlx5: Fix eq names to display nicely in /proc/interrupts")
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6d4ab2e97dcfbcd748ae71761a9d8e5e41cc732c
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Link: https://lore.kernel.org/r/20231114215846.5902-13-saeed@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 6 +++---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index cba2a4afb5fda..235e170c65bb7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -28,7 +28,7 @@
 struct mlx5_irq {
 	struct atomic_notifier_head nh;
 	cpumask_var_t mask;
-	char name[MLX5_MAX_IRQ_NAME];
+	char name[MLX5_MAX_IRQ_FORMATTED_NAME];
 	struct mlx5_irq_pool *pool;
 	int refcount;
 	struct msi_map map;
@@ -289,8 +289,8 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 	else
 		irq_sf_set_name(pool, name, i);
 	ATOMIC_INIT_NOTIFIER_HEAD(&irq->nh);
-	snprintf(irq->name, MLX5_MAX_IRQ_NAME,
-		 "%s@pci:%s", name, pci_name(dev->pdev));
+	snprintf(irq->name, MLX5_MAX_IRQ_FORMATTED_NAME,
+		 MLX5_IRQ_NAME_FORMAT_STR, name, pci_name(dev->pdev));
 	err = request_irq(irq->map.virq, irq_int_handler, 0, irq->name,
 			  &irq->nh);
 	if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h
index d3a77a0ab8488..c4d377f8df308 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h
@@ -7,6 +7,9 @@
 #include <linux/mlx5/driver.h>
 
 #define MLX5_MAX_IRQ_NAME (32)
+#define MLX5_IRQ_NAME_FORMAT_STR ("%s@pci:%s")
+#define MLX5_MAX_IRQ_FORMATTED_NAME \
+	(MLX5_MAX_IRQ_NAME + sizeof(MLX5_IRQ_NAME_FORMAT_STR))
 /* max irq_index is 2047, so four chars */
 #define MLX5_MAX_IRQ_IDX_CHARS (4)
 #define MLX5_EQ_REFS_PER_IRQ (2)
-- 
2.42.0





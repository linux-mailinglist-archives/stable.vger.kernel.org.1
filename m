Return-Path: <stable+bounces-712-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B857F7C3A
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A050B20FD9
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D7A364A4;
	Fri, 24 Nov 2023 18:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zisVhvVd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FA39FFC;
	Fri, 24 Nov 2023 18:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD47C433C7;
	Fri, 24 Nov 2023 18:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849586;
	bh=Z2AQzf7T2wkijK2QSWtL0mykoQ8o7sdh/EQwsb/1bgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zisVhvVdkmTDn+0b0jXgsE0qsblt74+5j2eBjYYxGFFUA4BO7AONJJvQ/imBN5/X4
	 eN8io6YPkBJhKK10IbOd26fwXoEOF144f7KJ72ySYy44TdoS7Ra4OgkE7HRjT8yXvK
	 IuLkO6/yWOF2GVY/Sykbw2n3pyHpx+H37Svp2GOM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maher Sanalla <msanalla@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 216/530] net/mlx5: Free used cpus mask when an IRQ is released
Date: Fri, 24 Nov 2023 17:46:22 +0000
Message-ID: <20231124172034.639557504@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Maher Sanalla <msanalla@nvidia.com>

[ Upstream commit 7d2f74d1d4385a5bcf90618537f16a45121c30ae ]

Each EQ table maintains a cpumask of the already used CPUs that are mapped
to IRQs to ensure that each IRQ gets mapped to a unique CPU.

However, on IRQ release, the said cpumask is not updated by clearing the
CPU from the mask to allow future IRQ request, causing the following
error when a SF is reloaded after it has utilized all CPUs for its IRQs:

mlx5_irq_affinity_request:135:(pid 306010): Didn't find a matching IRQ.
err = -28

Thus, when releasing an IRQ, clear its mapped CPU from the used CPUs
mask, to prevent the case described above.

While at it, move the used cpumask update to the EQ layer as it is more
fitting and preserves symmetricity of the IRQ request/release API.

Fixes: a1772de78d73 ("net/mlx5: Refactor completion IRQ request/release API")
Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Link: https://lore.kernel.org/r/20231114215846.5902-3-saeed@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c  | 25 ++++++++---
 .../mellanox/mlx5/core/irq_affinity.c         | 42 -------------------
 2 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index ea0405e0a43fa..40a6cb052a2da 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -885,11 +885,14 @@ static void comp_irq_release_sf(struct mlx5_core_dev *dev, u16 vecidx)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
 	struct mlx5_irq *irq;
+	int cpu;
 
 	irq = xa_load(&table->comp_irqs, vecidx);
 	if (!irq)
 		return;
 
+	cpu = cpumask_first(mlx5_irq_get_affinity_mask(irq));
+	cpumask_clear_cpu(cpu, &table->used_cpus);
 	xa_erase(&table->comp_irqs, vecidx);
 	mlx5_irq_affinity_irq_release(dev, irq);
 }
@@ -897,16 +900,26 @@ static void comp_irq_release_sf(struct mlx5_core_dev *dev, u16 vecidx)
 static int comp_irq_request_sf(struct mlx5_core_dev *dev, u16 vecidx)
 {
 	struct mlx5_eq_table *table = dev->priv.eq_table;
+	struct mlx5_irq_pool *pool = mlx5_irq_pool_get(dev);
+	struct irq_affinity_desc af_desc = {};
 	struct mlx5_irq *irq;
 
-	irq = mlx5_irq_affinity_irq_request_auto(dev, &table->used_cpus, vecidx);
-	if (IS_ERR(irq)) {
-		/* In case SF irq pool does not exist, fallback to the PF irqs*/
-		if (PTR_ERR(irq) == -ENOENT)
-			return comp_irq_request_pci(dev, vecidx);
+	/* In case SF irq pool does not exist, fallback to the PF irqs*/
+	if (!mlx5_irq_pool_is_sf_pool(pool))
+		return comp_irq_request_pci(dev, vecidx);
 
+	af_desc.is_managed = 1;
+	cpumask_copy(&af_desc.mask, cpu_online_mask);
+	cpumask_andnot(&af_desc.mask, &af_desc.mask, &table->used_cpus);
+	irq = mlx5_irq_affinity_request(pool, &af_desc);
+	if (IS_ERR(irq))
 		return PTR_ERR(irq);
-	}
+
+	cpumask_or(&table->used_cpus, &table->used_cpus, mlx5_irq_get_affinity_mask(irq));
+	mlx5_core_dbg(pool->dev, "IRQ %u mapped to cpu %*pbl, %u EQs on this irq\n",
+		      pci_irq_vector(dev->pdev, mlx5_irq_get_index(irq)),
+		      cpumask_pr_args(mlx5_irq_get_affinity_mask(irq)),
+		      mlx5_irq_read_locked(irq) / MLX5_EQ_REFS_PER_IRQ);
 
 	return xa_err(xa_store(&table->comp_irqs, vecidx, irq, GFP_KERNEL));
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
index 047d5fed5f89e..612e666ec2635 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/irq_affinity.c
@@ -168,45 +168,3 @@ void mlx5_irq_affinity_irq_release(struct mlx5_core_dev *dev, struct mlx5_irq *i
 		if (pool->irqs_per_cpu)
 			cpu_put(pool, cpu);
 }
-
-/**
- * mlx5_irq_affinity_irq_request_auto - request one IRQ for mlx5 device.
- * @dev: mlx5 device that is requesting the IRQ.
- * @used_cpus: cpumask of bounded cpus by the device
- * @vecidx: vector index to request an IRQ for.
- *
- * Each IRQ is bounded to at most 1 CPU.
- * This function is requesting an IRQ according to the default assignment.
- * The default assignment policy is:
- * - request the least loaded IRQ which is not bound to any
- *   CPU of the previous IRQs requested.
- *
- * On success, this function updates used_cpus mask and returns an irq pointer.
- * In case of an error, an appropriate error pointer is returned.
- */
-struct mlx5_irq *mlx5_irq_affinity_irq_request_auto(struct mlx5_core_dev *dev,
-						    struct cpumask *used_cpus, u16 vecidx)
-{
-	struct mlx5_irq_pool *pool = mlx5_irq_pool_get(dev);
-	struct irq_affinity_desc af_desc = {};
-	struct mlx5_irq *irq;
-
-	if (!mlx5_irq_pool_is_sf_pool(pool))
-		return ERR_PTR(-ENOENT);
-
-	af_desc.is_managed = 1;
-	cpumask_copy(&af_desc.mask, cpu_online_mask);
-	cpumask_andnot(&af_desc.mask, &af_desc.mask, used_cpus);
-	irq = mlx5_irq_affinity_request(pool, &af_desc);
-
-	if (IS_ERR(irq))
-		return irq;
-
-	cpumask_or(used_cpus, used_cpus, mlx5_irq_get_affinity_mask(irq));
-	mlx5_core_dbg(pool->dev, "IRQ %u mapped to cpu %*pbl, %u EQs on this irq\n",
-		      pci_irq_vector(dev->pdev, mlx5_irq_get_index(irq)),
-		      cpumask_pr_args(mlx5_irq_get_affinity_mask(irq)),
-		      mlx5_irq_read_locked(irq) / MLX5_EQ_REFS_PER_IRQ);
-
-	return irq;
-}
-- 
2.42.0





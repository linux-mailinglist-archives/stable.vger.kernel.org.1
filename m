Return-Path: <stable+bounces-49734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4228FEE9F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523D31F246E0
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B841C53BD;
	Thu,  6 Jun 2024 14:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MWV9kvVA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E81991DB;
	Thu,  6 Jun 2024 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683683; cv=none; b=O6W1QgwZwABKOtI4/Cw/pI0A5ShwAbPKDf70bpPklTuJRBlcDVCg/HjhANN+ws2SAfQbI0QNp8p/+9EsyyAWVw9GQP2brpwuRwo7yh+7nEtXE+gpF5HSsUveYNa/eoXgDHqImvtWJwFufJ6eSOjN56yaPHZoJVsljILz/IMQNOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683683; c=relaxed/simple;
	bh=A8cE+RFEHXMXjeYi2h6U6eo1JqV0u30qgcYZCZ5IbYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upn2fWTRQCNdEwC2k8MBvPxUHy+Ai3tMxaC1L0KMroftg/O7HFrLbTjiq4rzfMHMmI3TpofrlTpi3EXXmluearQQ6H+RByxpNvolFx+OSm9n30nXg73w+WPFx+Qc7i4HPW6WjM1OW0hQzEZBlzkGf95sv9wUDePn8BzfuOeKhLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MWV9kvVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C95C2BD10;
	Thu,  6 Jun 2024 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683682;
	bh=A8cE+RFEHXMXjeYi2h6U6eo1JqV0u30qgcYZCZ5IbYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWV9kvVAs5u5DqtqO0F28eCaauurO+o1HcwE7xEOrFc24kQlhak826j8HLRq83nJ0
	 V/Of6FauhwVqJfXAc5NDoeblK8drzzhoqfkZ45+6eDCAb3fHz7aBa9l878ZxWuyB68
	 XQBKFMX9j11soMraKemegc4jXOBbGwXlht/T9nF0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 585/744] drm/msm/dpu: make the irq table size static
Date: Thu,  6 Jun 2024 16:04:17 +0200
Message-ID: <20240606131751.230992838@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 56acb1b620e263d3fed8f11f71bf2ab7ce1cae5b ]

The size of the irq table is static, it has MDP_INTR_MAX * 32 interrupt
entries. Provide the fixed length and drop struct_size() statement.

Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Patchwork: https://patchwork.freedesktop.org/patch/550927/
Link: https://lore.kernel.org/r/20230802100426.4184892-6-dmitry.baryshkov@linaro.org
Stable-dep-of: 530f272053a5 ("drm/msm/dpu: Add callback function pointer check before its call")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c | 26 ++++++++-----------
 .../gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h |  6 ++---
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
index 14d374de30c52..3d6d13407dded 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.c
@@ -200,10 +200,9 @@ static const struct dpu_intr_reg dpu_intr_set_7xxx[] = {
 #define DPU_IRQ_REG(irq_idx)	(irq_idx / 32)
 #define DPU_IRQ_MASK(irq_idx)	(BIT(irq_idx % 32))
 
-static inline bool dpu_core_irq_is_valid(struct dpu_hw_intr *intr,
-					 int irq_idx)
+static inline bool dpu_core_irq_is_valid(int irq_idx)
 {
-	return irq_idx >= 0 && irq_idx < intr->total_irqs;
+	return irq_idx >= 0 && irq_idx < DPU_NUM_IRQS;
 }
 
 static inline struct dpu_hw_intr_entry *dpu_core_irq_get_entry(struct dpu_hw_intr *intr,
@@ -305,7 +304,7 @@ static int dpu_hw_intr_enable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
 	if (!intr)
 		return -EINVAL;
 
-	if (!dpu_core_irq_is_valid(intr, irq_idx)) {
+	if (!dpu_core_irq_is_valid(irq_idx)) {
 		pr_err("invalid IRQ index: [%d]\n", irq_idx);
 		return -EINVAL;
 	}
@@ -358,7 +357,7 @@ static int dpu_hw_intr_disable_irq_locked(struct dpu_hw_intr *intr, int irq_idx)
 	if (!intr)
 		return -EINVAL;
 
-	if (!dpu_core_irq_is_valid(intr, irq_idx)) {
+	if (!dpu_core_irq_is_valid(irq_idx)) {
 		pr_err("invalid IRQ index: [%d]\n", irq_idx);
 		return -EINVAL;
 	}
@@ -443,7 +442,7 @@ u32 dpu_core_irq_read(struct dpu_kms *dpu_kms, int irq_idx)
 	if (!intr)
 		return 0;
 
-	if (!dpu_core_irq_is_valid(intr, irq_idx)) {
+	if (!dpu_core_irq_is_valid(irq_idx)) {
 		pr_err("invalid IRQ index: [%d]\n", irq_idx);
 		return 0;
 	}
@@ -470,13 +469,12 @@ struct dpu_hw_intr *dpu_hw_intr_init(void __iomem *addr,
 		const struct dpu_mdss_cfg *m)
 {
 	struct dpu_hw_intr *intr;
-	int nirq = MDP_INTR_MAX * 32;
 	unsigned int i;
 
 	if (!addr || !m)
 		return ERR_PTR(-EINVAL);
 
-	intr = kzalloc(struct_size(intr, irq_tbl, nirq), GFP_KERNEL);
+	intr = kzalloc(sizeof(*intr), GFP_KERNEL);
 	if (!intr)
 		return ERR_PTR(-ENOMEM);
 
@@ -487,8 +485,6 @@ struct dpu_hw_intr *dpu_hw_intr_init(void __iomem *addr,
 
 	intr->hw.blk_addr = addr + m->mdp[0].base;
 
-	intr->total_irqs = nirq;
-
 	intr->irq_mask = BIT(MDP_SSPP_TOP0_INTR) |
 			 BIT(MDP_SSPP_TOP0_INTR2) |
 			 BIT(MDP_SSPP_TOP0_HIST_INTR);
@@ -527,7 +523,7 @@ int dpu_core_irq_register_callback(struct dpu_kms *dpu_kms, int irq_idx,
 		return -EINVAL;
 	}
 
-	if (!dpu_core_irq_is_valid(dpu_kms->hw_intr, irq_idx)) {
+	if (!dpu_core_irq_is_valid(irq_idx)) {
 		DPU_ERROR("invalid IRQ index: [%d]\n", irq_idx);
 		return -EINVAL;
 	}
@@ -566,7 +562,7 @@ int dpu_core_irq_unregister_callback(struct dpu_kms *dpu_kms, int irq_idx)
 	unsigned long irq_flags;
 	int ret;
 
-	if (!dpu_core_irq_is_valid(dpu_kms->hw_intr, irq_idx)) {
+	if (!dpu_core_irq_is_valid(irq_idx)) {
 		DPU_ERROR("invalid IRQ index: [%d]\n", irq_idx);
 		return -EINVAL;
 	}
@@ -601,7 +597,7 @@ static int dpu_debugfs_core_irq_show(struct seq_file *s, void *v)
 	int i, irq_count;
 	void *cb;
 
-	for (i = 0; i < dpu_kms->hw_intr->total_irqs; i++) {
+	for (i = 0; i < DPU_NUM_IRQS; i++) {
 		spin_lock_irqsave(&dpu_kms->hw_intr->irq_lock, irq_flags);
 		irq_entry = dpu_core_irq_get_entry(dpu_kms->hw_intr, i);
 		irq_count = atomic_read(&irq_entry->count);
@@ -636,7 +632,7 @@ void dpu_core_irq_preinstall(struct msm_kms *kms)
 	dpu_disable_all_irqs(dpu_kms);
 	pm_runtime_put_sync(&dpu_kms->pdev->dev);
 
-	for (i = 0; i < dpu_kms->hw_intr->total_irqs; i++) {
+	for (i = 0; i < DPU_NUM_IRQS; i++) {
 		irq_entry = dpu_core_irq_get_entry(dpu_kms->hw_intr, i);
 		atomic_set(&irq_entry->count, 0);
 	}
@@ -652,7 +648,7 @@ void dpu_core_irq_uninstall(struct msm_kms *kms)
 		return;
 
 	pm_runtime_get_sync(&dpu_kms->pdev->dev);
-	for (i = 0; i < dpu_kms->hw_intr->total_irqs; i++) {
+	for (i = 0; i < DPU_NUM_IRQS; i++) {
 		irq_entry = dpu_core_irq_get_entry(dpu_kms->hw_intr, i);
 		if (irq_entry->cb)
 			DPU_ERROR("irq_idx=%d still enabled/registered\n", i);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
index 391fb268ad903..bb775b6a24327 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_interrupts.h
@@ -38,6 +38,8 @@ enum dpu_hw_intr_reg {
 
 #define DPU_IRQ_IDX(reg_idx, offset)	(reg_idx * 32 + offset)
 
+#define DPU_NUM_IRQS		(MDP_INTR_MAX * 32)
+
 struct dpu_hw_intr_entry {
 	void (*cb)(void *arg);
 	void *arg;
@@ -50,7 +52,6 @@ struct dpu_hw_intr_entry {
  * @ops:              function pointer mapping for IRQ handling
  * @cache_irq_mask:   array of IRQ enable masks reg storage created during init
  * @save_irq_status:  array of IRQ status reg storage created during init
- * @total_irqs: total number of irq_idx mapped in the hw_interrupts
  * @irq_lock:         spinlock for accessing IRQ resources
  * @irq_cb_tbl:       array of IRQ callbacks
  */
@@ -58,12 +59,11 @@ struct dpu_hw_intr {
 	struct dpu_hw_blk_reg_map hw;
 	u32 cache_irq_mask[MDP_INTR_MAX];
 	u32 *save_irq_status;
-	u32 total_irqs;
 	spinlock_t irq_lock;
 	unsigned long irq_mask;
 	const struct dpu_intr_reg *intr_set;
 
-	struct dpu_hw_intr_entry irq_tbl[];
+	struct dpu_hw_intr_entry irq_tbl[DPU_NUM_IRQS];
 };
 
 /**
-- 
2.43.0





Return-Path: <stable+bounces-133985-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47939A928D2
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2900D1B6153F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A54225485D;
	Thu, 17 Apr 2025 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jQDTMOHV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC969256C93;
	Thu, 17 Apr 2025 18:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744914744; cv=none; b=U+Gq1yTr/IkrG3bbYT5IVB3UDiW4psF8yvaFg57bHwA+RuGIK9/7BEt80P55V6qd1u9YCWAtku2Jp+XIHQPyrrWclPcoTaYbWkXWFbYqCtb+OWw0LFjw7NvKHmRtbN3WZ228RsD8yT4X1Afth58NMCyXGB1ve91CmIYrrZ/FueE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744914744; c=relaxed/simple;
	bh=uwnnZ2SjKshVTYmia08ObiCOuBJsdE/00FVEpBgATl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjy6qyXN26zdq2+CEUTcPjEtyxhinN5LFFA0MX7VcdJSXOB7vCgqipr8pnep2M5kYMZCbH47y0+1LCnszkWANzKXVskn3icEbTCeQsv+pjZigEz2aPysOewwssNOCD81xFWnDC6oh/uDN3t3rq+jcseTiX+n9TAJrU3Fg4d4toc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jQDTMOHV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3638AC4CEE4;
	Thu, 17 Apr 2025 18:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744914744;
	bh=uwnnZ2SjKshVTYmia08ObiCOuBJsdE/00FVEpBgATl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQDTMOHVo3OYXa39a9uXuo1QmqRq/3wTQoFr2sEVJgx1FOeLjYpGkukPuGo+BEwQ1
	 LGqNoypnBW9YDmbA/LBPsocSLODH94B8HbJUdmEx7EWOZgPgVURb4Kxpm23lhn4tIn
	 uInisuoiLCn6aMcK6UV1ZEdAOUhZ+pz86sUAE29o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 6.13 317/414] iommu/tegra241-cmdqv: Fix warnings due to dmam_free_coherent()
Date: Thu, 17 Apr 2025 19:51:15 +0200
Message-ID: <20250417175124.186493928@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175111.386381660@linuxfoundation.org>
References: <20250417175111.386381660@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolin Chen <nicolinc@nvidia.com>

commit 767e22001dfce64cc03b7def1562338591ab6031 upstream.

Two WARNINGs are observed when SMMU driver rolls back upon failure:
 arm-smmu-v3.9.auto: Failed to register iommu
 arm-smmu-v3.9.auto: probe with driver arm-smmu-v3 failed with error -22
 ------------[ cut here ]------------
 WARNING: CPU: 5 PID: 1 at kernel/dma/mapping.c:74 dmam_free_coherent+0xc0/0xd8
 Call trace:
  dmam_free_coherent+0xc0/0xd8 (P)
  tegra241_vintf_free_lvcmdq+0x74/0x188
  tegra241_cmdqv_remove_vintf+0x60/0x148
  tegra241_cmdqv_remove+0x48/0xc8
  arm_smmu_impl_remove+0x28/0x60
  devm_action_release+0x1c/0x40
 ------------[ cut here ]------------
 128 pages are still in use!
 WARNING: CPU: 16 PID: 1 at mm/page_alloc.c:6902 free_contig_range+0x18c/0x1c8
 Call trace:
  free_contig_range+0x18c/0x1c8 (P)
  cma_release+0x154/0x2f0
  dma_free_contiguous+0x38/0xa0
  dma_direct_free+0x10c/0x248
  dma_free_attrs+0x100/0x290
  dmam_free_coherent+0x78/0xd8
  tegra241_vintf_free_lvcmdq+0x74/0x160
  tegra241_cmdqv_remove+0x98/0x198
  arm_smmu_impl_remove+0x28/0x60
  devm_action_release+0x1c/0x40

This is because the LVCMDQ queue memory are managed by devres, while that
dmam_free_coherent() is called in the context of devm_action_release().

Jason pointed out that "arm_smmu_impl_probe() has mis-ordered the devres
callbacks if ops->device_remove() is going to be manually freeing things
that probe allocated":
https://lore.kernel.org/linux-iommu/20250407174408.GB1722458@nvidia.com/

In fact, tegra241_cmdqv_init_structures() only allocates memory resources
which means any failure that it generates would be similar to -ENOMEM, so
there is no point in having that "falling back to standard SMMU" routine,
as the standard SMMU would likely fail to allocate memory too.

Remove the unwind part in tegra241_cmdqv_init_structures(), and return a
proper error code to ask SMMU driver to call tegra241_cmdqv_remove() via
impl_ops->device_remove(). Then, drop tegra241_vintf_free_lvcmdq() since
devres will take care of that.

Fixes: 483e0bd8883a ("iommu/tegra241-cmdqv: Do not allocate vcmdq until dma_set_mask_and_coherent")
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/20250407201908.172225-1-nicolinc@nvidia.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c |   32 +++----------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -487,17 +487,6 @@ static int tegra241_cmdqv_hw_reset(struc
 
 /* VCMDQ Resource Helpers */
 
-static void tegra241_vcmdq_free_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
-{
-	struct arm_smmu_queue *q = &vcmdq->cmdq.q;
-	size_t nents = 1 << q->llq.max_n_shift;
-	size_t qsz = nents << CMDQ_ENT_SZ_SHIFT;
-
-	if (!q->base)
-		return;
-	dmam_free_coherent(vcmdq->cmdqv->smmu.dev, qsz, q->base, q->base_dma);
-}
-
 static int tegra241_vcmdq_alloc_smmu_cmdq(struct tegra241_vcmdq *vcmdq)
 {
 	struct arm_smmu_device *smmu = &vcmdq->cmdqv->smmu;
@@ -560,7 +549,8 @@ static void tegra241_vintf_free_lvcmdq(s
 	struct tegra241_vcmdq *vcmdq = vintf->lvcmdqs[lidx];
 	char header[64];
 
-	tegra241_vcmdq_free_smmu_cmdq(vcmdq);
+	/* Note that the lvcmdq queue memory space is managed by devres */
+
 	tegra241_vintf_deinit_lvcmdq(vintf, lidx);
 
 	dev_dbg(vintf->cmdqv->dev,
@@ -768,13 +758,13 @@ static int tegra241_cmdqv_init_structure
 
 	vintf = kzalloc(sizeof(*vintf), GFP_KERNEL);
 	if (!vintf)
-		goto out_fallback;
+		return -ENOMEM;
 
 	/* Init VINTF0 for in-kernel use */
 	ret = tegra241_cmdqv_init_vintf(cmdqv, 0, vintf);
 	if (ret) {
 		dev_err(cmdqv->dev, "failed to init vintf0: %d\n", ret);
-		goto free_vintf;
+		return ret;
 	}
 
 	/* Preallocate logical VCMDQs to VINTF0 */
@@ -783,24 +773,12 @@ static int tegra241_cmdqv_init_structure
 
 		vcmdq = tegra241_vintf_alloc_lvcmdq(vintf, lidx);
 		if (IS_ERR(vcmdq))
-			goto free_lvcmdq;
+			return PTR_ERR(vcmdq);
 	}
 
 	/* Now, we are ready to run all the impl ops */
 	smmu->impl_ops = &tegra241_cmdqv_impl_ops;
 	return 0;
-
-free_lvcmdq:
-	for (lidx--; lidx >= 0; lidx--)
-		tegra241_vintf_free_lvcmdq(vintf, lidx);
-	tegra241_cmdqv_deinit_vintf(cmdqv, vintf->idx);
-free_vintf:
-	kfree(vintf);
-out_fallback:
-	dev_info(smmu->impl_dev, "Falling back to standard SMMU CMDQ\n");
-	smmu->options &= ~ARM_SMMU_OPT_TEGRA241_CMDQV;
-	tegra241_cmdqv_remove(smmu);
-	return 0;
 }
 
 #ifdef CONFIG_IOMMU_DEBUGFS




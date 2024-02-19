Return-Path: <stable+bounces-20641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5DA85AAB3
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B07BB2487E
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F02481A7;
	Mon, 19 Feb 2024 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="E4tHugD2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E26481AB
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366520; cv=none; b=OSNNkjRMhpgocTJ7Xnu6lbO5Qk088WrkR5Uu3YK9QJjj0DxHciSNtQsyRMNEbiJ2QBPnu1WZzEX4KiR6E3ytu/u07eu3BuH0x+Wm4lUEL+dcG/vbGhzLoWfmUNsj3WqFnrVydb1R1Ew50Xgm3kwHUSK2kCDRPNANVClH6L5xgB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366520; c=relaxed/simple;
	bh=zAx1u7mq3AYYYAa2Wp+6vsX8IuUCl4i6/92Q5Y0nAwI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=C/RUSSuX3cmpbA4ALieXhozc515U5dpjCGciKFWf7iwjscMSTRQL/CoTAv+QUidWJub9ij/Fe5DnKbr8B6U2km/H5w+Pof+KI+NiAyUESYTIXeXMnuQjTTUxnfircEiNG6APahZ26J4TQHxHvumfYbtLqlQpxF01TDUvYnIunEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=E4tHugD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77728C433F1;
	Mon, 19 Feb 2024 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366520;
	bh=zAx1u7mq3AYYYAa2Wp+6vsX8IuUCl4i6/92Q5Y0nAwI=;
	h=Subject:To:Cc:From:Date:From;
	b=E4tHugD290ZrIN2NMEIHfxYk35fTJ8rXdV2STe+SGoLqwGkQHWO5mh8JfX64U/O7u
	 owantN/HMPxFmEGoikIu7ra8GeFZUWfKfJtLgNaV3gdazCZ6MKoQX50dGN6txSxjWI
	 tfXkly2qfNV1PbjKoDcoke2EO4R+bY8chaA9WMoM=
Subject: FAILED: patch "[PATCH] drm/msm: Wire up tlb ops" failed to apply to 5.15-stable tree
To: robdclark@chromium.org,robin.murphy@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:15:16 +0100
Message-ID: <2024021916-backspace-carbon-b87c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 8c7bfd8262319fd3f127a5380f593ea76f1b88a2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021916-backspace-carbon-b87c@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

8c7bfd826231 ("drm/msm: Wire up tlb ops")
70bccecfcaf6 ("drm/msm/iommu: optimize map/unmap")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c7bfd8262319fd3f127a5380f593ea76f1b88a2 Mon Sep 17 00:00:00 2001
From: Rob Clark <robdclark@chromium.org>
Date: Tue, 13 Feb 2024 09:23:40 -0800
Subject: [PATCH] drm/msm: Wire up tlb ops

The brute force iommu_flush_iotlb_all() was good enough for unmap, but
in some cases a map operation could require removing a table pte entry
to replace with a block entry.  This also requires tlb invalidation.
Missing this was resulting an obscure iova fault on what should be a
valid buffer address.

Thanks to Robin Murphy for helping me understand the cause of the fault.

Cc: Robin Murphy <robin.murphy@arm.com>
Cc: stable@vger.kernel.org
Fixes: b145c6e65eb0 ("drm/msm: Add support to create a local pagetable")
Signed-off-by: Rob Clark <robdclark@chromium.org>
Patchwork: https://patchwork.freedesktop.org/patch/578117/

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 5cc8d358cc97..d5512037c38b 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -21,6 +21,8 @@ struct msm_iommu_pagetable {
 	struct msm_mmu base;
 	struct msm_mmu *parent;
 	struct io_pgtable_ops *pgtbl_ops;
+	const struct iommu_flush_ops *tlb;
+	struct device *iommu_dev;
 	unsigned long pgsize_bitmap;	/* Bitmap of page sizes in use */
 	phys_addr_t ttbr;
 	u32 asid;
@@ -201,11 +203,33 @@ static const struct msm_mmu_funcs pagetable_funcs = {
 
 static void msm_iommu_tlb_flush_all(void *cookie)
 {
+	struct msm_iommu_pagetable *pagetable = cookie;
+	struct adreno_smmu_priv *adreno_smmu;
+
+	if (!pm_runtime_get_if_in_use(pagetable->iommu_dev))
+		return;
+
+	adreno_smmu = dev_get_drvdata(pagetable->parent->dev);
+
+	pagetable->tlb->tlb_flush_all((void *)adreno_smmu->cookie);
+
+	pm_runtime_put_autosuspend(pagetable->iommu_dev);
 }
 
 static void msm_iommu_tlb_flush_walk(unsigned long iova, size_t size,
 		size_t granule, void *cookie)
 {
+	struct msm_iommu_pagetable *pagetable = cookie;
+	struct adreno_smmu_priv *adreno_smmu;
+
+	if (!pm_runtime_get_if_in_use(pagetable->iommu_dev))
+		return;
+
+	adreno_smmu = dev_get_drvdata(pagetable->parent->dev);
+
+	pagetable->tlb->tlb_flush_walk(iova, size, granule, (void *)adreno_smmu->cookie);
+
+	pm_runtime_put_autosuspend(pagetable->iommu_dev);
 }
 
 static void msm_iommu_tlb_add_page(struct iommu_iotlb_gather *gather,
@@ -213,7 +237,7 @@ static void msm_iommu_tlb_add_page(struct iommu_iotlb_gather *gather,
 {
 }
 
-static const struct iommu_flush_ops null_tlb_ops = {
+static const struct iommu_flush_ops tlb_ops = {
 	.tlb_flush_all = msm_iommu_tlb_flush_all,
 	.tlb_flush_walk = msm_iommu_tlb_flush_walk,
 	.tlb_add_page = msm_iommu_tlb_add_page,
@@ -254,10 +278,10 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 
 	/* The incoming cfg will have the TTBR1 quirk enabled */
 	ttbr0_cfg.quirks &= ~IO_PGTABLE_QUIRK_ARM_TTBR1;
-	ttbr0_cfg.tlb = &null_tlb_ops;
+	ttbr0_cfg.tlb = &tlb_ops;
 
 	pagetable->pgtbl_ops = alloc_io_pgtable_ops(ARM_64_LPAE_S1,
-		&ttbr0_cfg, iommu->domain);
+		&ttbr0_cfg, pagetable);
 
 	if (!pagetable->pgtbl_ops) {
 		kfree(pagetable);
@@ -279,6 +303,8 @@ struct msm_mmu *msm_iommu_pagetable_create(struct msm_mmu *parent)
 
 	/* Needed later for TLB flush */
 	pagetable->parent = parent;
+	pagetable->tlb = ttbr1_cfg->tlb;
+	pagetable->iommu_dev = ttbr1_cfg->iommu_dev;
 	pagetable->pgsize_bitmap = ttbr0_cfg.pgsize_bitmap;
 	pagetable->ttbr = ttbr0_cfg.arm_lpae_s1_cfg.ttbr;
 



Return-Path: <stable+bounces-170055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDF9B2A167
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5296B169A7A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA2731A047;
	Mon, 18 Aug 2025 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="brFHw7eM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8C83112DC
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755519160; cv=none; b=RUTfMFTBiaEP+9Wz1fn9GWdBC2d/b5SU/wq53tuPjnIeehyLHkA0/rzXhkQ+qK852CLkd9PBkM9/U94lk3iUKGmGTi3/x7b/LgtHHuV0RR8amdaxXPIa5aBtDCU0bYQz1raGcyg8laz1ZFuWgXz36Lz/kIbEskHhYuCq+XX3X8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755519160; c=relaxed/simple;
	bh=qVkGTxuS+oKgMhqKjsypT84bZVbo5oIIuyWFSg5diwM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HkFGAI8YJsRnHH4HNJ1fBCefsZXWwnuwj3L59BHBv4nJena2v8rq5ABe+3K1Vd1lcuKzXpv/LAF5E7ZLFfTJ2q40KrXmBH/bnIYgnYegoas6rufAuNrgWrJPZrdRrsTfZNEF8iDCwL/ZO9woatJnJ41HiZ+02jTmgw8hxvP6xmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=brFHw7eM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4506C4CEF1;
	Mon, 18 Aug 2025 12:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755519160;
	bh=qVkGTxuS+oKgMhqKjsypT84bZVbo5oIIuyWFSg5diwM=;
	h=Subject:To:Cc:From:Date:From;
	b=brFHw7eMpPOAi9KttsedWqN5Q99Ycy1pyoD6ziGBxIGN3nFQZ6Tao1AwIuIJ3N4no
	 CoYvv1CWKk0Q/19/ZJfNRY79m63oDW5pT5IoxHTrj4N8PnRP+TMeKMejjFv0vLa+Ck
	 ZU6zNAF9Kt7ZTXFSrWMEHCbxfOaf1fjPZuCfguMM=
Subject: FAILED: patch "[PATCH] iommu/vt-d: Make iotlb_sync_map a static property of" failed to apply to 6.12-stable tree
To: baolu.lu@linux.intel.com,jgg@nvidia.com,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 14:12:23 +0200
Message-ID: <2025081823-waking-baritone-c887@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x cee686775f9cd4eae31f3c1f7ec24b2048082667
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081823-waking-baritone-c887@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cee686775f9cd4eae31f3c1f7ec24b2048082667 Mon Sep 17 00:00:00 2001
From: Lu Baolu <baolu.lu@linux.intel.com>
Date: Mon, 21 Jul 2025 13:16:57 +0800
Subject: [PATCH] iommu/vt-d: Make iotlb_sync_map a static property of
 dmar_domain

Commit 12724ce3fe1a ("iommu/vt-d: Optimize iotlb_sync_map for
non-caching/non-RWBF modes") dynamically set iotlb_sync_map. This causes
synchronization issues due to lack of locking on map and attach paths,
racing iommufd userspace operations.

Invalidation changes must precede device attachment to ensure all flushes
complete before hardware walks page tables, preventing coherence issues.

Make domain->iotlb_sync_map static, set once during domain allocation. If
an IOMMU requires iotlb_sync_map but the domain lacks it, attach is
rejected. This won't reduce domain sharing: RWBF and shadowing page table
caching are legacy uses with legacy hardware. Mixed configs (some IOMMUs
in caching mode, others not) are unlikely in real-world scenarios.

Fixes: 12724ce3fe1a ("iommu/vt-d: Optimize iotlb_sync_map for non-caching/non-RWBF modes")
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20250721051657.1695788-1-baolu.lu@linux.intel.com
Signed-off-by: Will Deacon <will@kernel.org>

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 3e774e3bb735..d1791b50f791 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -57,6 +57,8 @@
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
 
+#define rwbf_required(iommu)	(rwbf_quirk || cap_rwbf((iommu)->cap))
+
 /*
  * set to 1 to panic kernel if can't successfully enable VT-d
  * (used when kernel is launched w/ TXT)
@@ -1780,18 +1782,6 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 					  __pa(pgd), flags, old);
 }
 
-static bool domain_need_iotlb_sync_map(struct dmar_domain *domain,
-				       struct intel_iommu *iommu)
-{
-	if (cap_caching_mode(iommu->cap) && intel_domain_is_ss_paging(domain))
-		return true;
-
-	if (rwbf_quirk || cap_rwbf(iommu->cap))
-		return true;
-
-	return false;
-}
-
 static int dmar_domain_attach_device(struct dmar_domain *domain,
 				     struct device *dev)
 {
@@ -1831,8 +1821,6 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		goto out_block_translation;
 
-	domain->iotlb_sync_map |= domain_need_iotlb_sync_map(domain, iommu);
-
 	return 0;
 
 out_block_translation:
@@ -3352,6 +3340,14 @@ intel_iommu_domain_alloc_first_stage(struct device *dev,
 		return ERR_CAST(dmar_domain);
 
 	dmar_domain->domain.ops = &intel_fs_paging_domain_ops;
+	/*
+	 * iotlb sync for map is only needed for legacy implementations that
+	 * explicitly require flushing internal write buffers to ensure memory
+	 * coherence.
+	 */
+	if (rwbf_required(iommu))
+		dmar_domain->iotlb_sync_map = true;
+
 	return &dmar_domain->domain;
 }
 
@@ -3386,6 +3382,14 @@ intel_iommu_domain_alloc_second_stage(struct device *dev,
 	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
 		dmar_domain->domain.dirty_ops = &intel_dirty_ops;
 
+	/*
+	 * Besides the internal write buffer flush, the caching mode used for
+	 * legacy nested translation (which utilizes shadowing page tables)
+	 * also requires iotlb sync on map.
+	 */
+	if (rwbf_required(iommu) || cap_caching_mode(iommu->cap))
+		dmar_domain->iotlb_sync_map = true;
+
 	return &dmar_domain->domain;
 }
 
@@ -3446,6 +3450,11 @@ static int paging_domain_compatible_first_stage(struct dmar_domain *dmar_domain,
 	if (!cap_fl1gp_support(iommu->cap) &&
 	    (dmar_domain->domain.pgsize_bitmap & SZ_1G))
 		return -EINVAL;
+
+	/* iotlb sync on map requirement */
+	if ((rwbf_required(iommu)) && !dmar_domain->iotlb_sync_map)
+		return -EINVAL;
+
 	return 0;
 }
 
@@ -3469,6 +3478,12 @@ paging_domain_compatible_second_stage(struct dmar_domain *dmar_domain,
 		return -EINVAL;
 	if (!(sslps & BIT(1)) && (dmar_domain->domain.pgsize_bitmap & SZ_1G))
 		return -EINVAL;
+
+	/* iotlb sync on map requirement */
+	if ((rwbf_required(iommu) || cap_caching_mode(iommu->cap)) &&
+	    !dmar_domain->iotlb_sync_map)
+		return -EINVAL;
+
 	return 0;
 }
 



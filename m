Return-Path: <stable+bounces-179879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 398A4B7DFDA
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E37F55883C1
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C5F328962;
	Wed, 17 Sep 2025 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="myjkCAme"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DDA2EC0BD;
	Wed, 17 Sep 2025 12:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112694; cv=none; b=ns9COxibdqSrrEpw27stgFf8q0oOK/h50rRNQ0JCMNwAFa7CLwW6QducCP7KPtq8teX8zbFeUg9aaEaVDE83nnpnA/u0iST1yeS+hPAFPAUEC9lmnIZ2B9hXXuXuazL1hh2NtPpkmqndq12Vz8NG2F1rLi6tJ5L3CEYR5kkZ4Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112694; c=relaxed/simple;
	bh=5/UE2hwNfpzAW7/l6FJnarRVxWBSFoF2aZEToBBK/2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tXY8/Sfj9JKNoyFO5k9a7CXnhfqGxHmZSWBj2xVecQUfkiSzTf/iADuaPFRVhvdNz/Lwo7+M+KtDhbUEphgn4hM9bBhcz63VSZGf2FiGxY2hMP9w4LLHJ36/NAhr9YFntppys71mr90+S2Jf+Z/Xw/6hoDqKSwRWJnUmpavYV9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=myjkCAme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CED8C4CEF7;
	Wed, 17 Sep 2025 12:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112694;
	bh=5/UE2hwNfpzAW7/l6FJnarRVxWBSFoF2aZEToBBK/2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=myjkCAmeDdBa20+Ljgm3CQ16n0Zcu0JJwvyASCXqTQcVmPFWPInVxo/bQ3xHwvBuW
	 qDbFFbgsFpebIv5Lmau+0Z2mzUMU/UAYSz+zimxan9pOsxt7gZ9ygAox4h1iaeR6hG
	 bFvENMrdUlgawGNYN9PvT2dZu3jfrVGwJQz0n2sg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 011/189] iommu/vt-d: Create unique domain ops for each stage
Date: Wed, 17 Sep 2025 14:32:01 +0200
Message-ID: <20250917123352.126546069@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

[ Upstream commit b33125296b5047115469b8a3b74c0fdbf4976548 ]

Use the domain ops pointer to tell what kind of domain it is instead of
the internal use_first_level indication. This also protects against
wrongly using a SVA/nested/IDENTITY/BLOCKED domain type in places they
should not be.

The only remaining uses of use_first_level outside the paging domain are in
paging_domain_compatible() and intel_iommu_enforce_cache_coherency().

Thus, remove the useless sets of use_first_level in
intel_svm_domain_alloc() and intel_iommu_domain_alloc_nested(). None of
the unique ops for these domain types ever reference it on their call
chains.

Add a WARN_ON() check in domain_context_mapping_one() as it only works
with second stage.

This is preparation for iommupt which will have different ops for each of
the stages.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/r/5-v3-dbbe6f7e7ae3+124ffe-vtd_prep_jgg@nvidia.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20250714045028.958850-8-baolu.lu@linux.intel.com
Signed-off-by: Will Deacon <will@kernel.org>
Stable-dep-of: cee686775f9c ("iommu/vt-d: Make iotlb_sync_map a static property of dmar_domain")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/cache.c  |  5 +--
 drivers/iommu/intel/iommu.c  | 60 +++++++++++++++++++++++++-----------
 drivers/iommu/intel/iommu.h  | 12 ++++++++
 drivers/iommu/intel/nested.c |  4 +--
 drivers/iommu/intel/svm.c    |  1 -
 5 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/intel/cache.c b/drivers/iommu/intel/cache.c
index c8b79de84d3fb..071f78e67fcba 100644
--- a/drivers/iommu/intel/cache.c
+++ b/drivers/iommu/intel/cache.c
@@ -370,7 +370,7 @@ static void cache_tag_flush_iotlb(struct dmar_domain *domain, struct cache_tag *
 	struct intel_iommu *iommu = tag->iommu;
 	u64 type = DMA_TLB_PSI_FLUSH;
 
-	if (domain->use_first_level) {
+	if (intel_domain_is_fs_paging(domain)) {
 		qi_batch_add_piotlb(iommu, tag->domain_id, tag->pasid, addr,
 				    pages, ih, domain->qi_batch);
 		return;
@@ -529,7 +529,8 @@ void cache_tag_flush_range_np(struct dmar_domain *domain, unsigned long start,
 			qi_batch_flush_descs(iommu, domain->qi_batch);
 		iommu = tag->iommu;
 
-		if (!cap_caching_mode(iommu->cap) || domain->use_first_level) {
+		if (!cap_caching_mode(iommu->cap) ||
+		    intel_domain_is_fs_paging(domain)) {
 			iommu_flush_write_buffer(iommu);
 			continue;
 		}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index f9f16d9bbf0bc..207f87eeb47a2 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1479,6 +1479,9 @@ static int domain_context_mapping_one(struct dmar_domain *domain,
 	struct context_entry *context;
 	int ret;
 
+	if (WARN_ON(!intel_domain_is_ss_paging(domain)))
+		return -EINVAL;
+
 	pr_debug("Set context mapping for %02x:%02x.%d\n",
 		bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
 
@@ -1798,7 +1801,7 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 static bool domain_need_iotlb_sync_map(struct dmar_domain *domain,
 				       struct intel_iommu *iommu)
 {
-	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
+	if (cap_caching_mode(iommu->cap) && intel_domain_is_ss_paging(domain))
 		return true;
 
 	if (rwbf_quirk || cap_rwbf(iommu->cap))
@@ -1830,12 +1833,14 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 
 	if (!sm_supported(iommu))
 		ret = domain_context_mapping(domain, dev);
-	else if (domain->use_first_level)
+	else if (intel_domain_is_fs_paging(domain))
 		ret = domain_setup_first_level(iommu, domain, dev,
 					       IOMMU_NO_PASID, NULL);
-	else
+	else if (intel_domain_is_ss_paging(domain))
 		ret = domain_setup_second_level(iommu, domain, dev,
 						IOMMU_NO_PASID, NULL);
+	else if (WARN_ON(true))
+		ret = -EINVAL;
 
 	if (ret)
 		goto out_block_translation;
@@ -3306,7 +3311,6 @@ static struct dmar_domain *paging_domain_alloc(struct device *dev, bool first_st
 	domain->use_first_level = first_stage;
 
 	domain->domain.type = IOMMU_DOMAIN_UNMANAGED;
-	domain->domain.ops = intel_iommu_ops.default_domain_ops;
 
 	/* calculate the address width */
 	addr_width = agaw_to_width(iommu->agaw);
@@ -3364,6 +3368,8 @@ intel_iommu_domain_alloc_first_stage(struct device *dev,
 	dmar_domain = paging_domain_alloc(dev, true);
 	if (IS_ERR(dmar_domain))
 		return ERR_CAST(dmar_domain);
+
+	dmar_domain->domain.ops = &intel_fs_paging_domain_ops;
 	return &dmar_domain->domain;
 }
 
@@ -3392,6 +3398,7 @@ intel_iommu_domain_alloc_second_stage(struct device *dev,
 	if (IS_ERR(dmar_domain))
 		return ERR_CAST(dmar_domain);
 
+	dmar_domain->domain.ops = &intel_ss_paging_domain_ops;
 	dmar_domain->nested_parent = flags & IOMMU_HWPT_ALLOC_NEST_PARENT;
 
 	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING)
@@ -4110,12 +4117,15 @@ static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
 	if (ret)
 		goto out_remove_dev_pasid;
 
-	if (dmar_domain->use_first_level)
+	if (intel_domain_is_fs_paging(dmar_domain))
 		ret = domain_setup_first_level(iommu, dmar_domain,
 					       dev, pasid, old);
-	else
+	else if (intel_domain_is_ss_paging(dmar_domain))
 		ret = domain_setup_second_level(iommu, dmar_domain,
 						dev, pasid, old);
+	else if (WARN_ON(true))
+		ret = -EINVAL;
+
 	if (ret)
 		goto out_unwind_iopf;
 
@@ -4390,6 +4400,32 @@ static struct iommu_domain identity_domain = {
 	},
 };
 
+const struct iommu_domain_ops intel_fs_paging_domain_ops = {
+	.attach_dev = intel_iommu_attach_device,
+	.set_dev_pasid = intel_iommu_set_dev_pasid,
+	.map_pages = intel_iommu_map_pages,
+	.unmap_pages = intel_iommu_unmap_pages,
+	.iotlb_sync_map = intel_iommu_iotlb_sync_map,
+	.flush_iotlb_all = intel_flush_iotlb_all,
+	.iotlb_sync = intel_iommu_tlb_sync,
+	.iova_to_phys = intel_iommu_iova_to_phys,
+	.free = intel_iommu_domain_free,
+	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+};
+
+const struct iommu_domain_ops intel_ss_paging_domain_ops = {
+	.attach_dev = intel_iommu_attach_device,
+	.set_dev_pasid = intel_iommu_set_dev_pasid,
+	.map_pages = intel_iommu_map_pages,
+	.unmap_pages = intel_iommu_unmap_pages,
+	.iotlb_sync_map = intel_iommu_iotlb_sync_map,
+	.flush_iotlb_all = intel_flush_iotlb_all,
+	.iotlb_sync = intel_iommu_tlb_sync,
+	.iova_to_phys = intel_iommu_iova_to_phys,
+	.free = intel_iommu_domain_free,
+	.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
+};
+
 const struct iommu_ops intel_iommu_ops = {
 	.blocked_domain		= &blocking_domain,
 	.release_domain		= &blocking_domain,
@@ -4407,18 +4443,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.is_attach_deferred	= intel_iommu_is_attach_deferred,
 	.def_domain_type	= device_def_domain_type,
 	.page_response		= intel_iommu_page_response,
-	.default_domain_ops = &(const struct iommu_domain_ops) {
-		.attach_dev		= intel_iommu_attach_device,
-		.set_dev_pasid		= intel_iommu_set_dev_pasid,
-		.map_pages		= intel_iommu_map_pages,
-		.unmap_pages		= intel_iommu_unmap_pages,
-		.iotlb_sync_map		= intel_iommu_iotlb_sync_map,
-		.flush_iotlb_all        = intel_flush_iotlb_all,
-		.iotlb_sync		= intel_iommu_tlb_sync,
-		.iova_to_phys		= intel_iommu_iova_to_phys,
-		.free			= intel_iommu_domain_free,
-		.enforce_cache_coherency = intel_iommu_enforce_cache_coherency,
-	}
 };
 
 static void quirk_iommu_igfx(struct pci_dev *dev)
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 61f42802fe9e9..c699ed8810f23 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -1381,6 +1381,18 @@ struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
 					 u8 devfn, int alloc);
 
 extern const struct iommu_ops intel_iommu_ops;
+extern const struct iommu_domain_ops intel_fs_paging_domain_ops;
+extern const struct iommu_domain_ops intel_ss_paging_domain_ops;
+
+static inline bool intel_domain_is_fs_paging(struct dmar_domain *domain)
+{
+	return domain->domain.ops == &intel_fs_paging_domain_ops;
+}
+
+static inline bool intel_domain_is_ss_paging(struct dmar_domain *domain)
+{
+	return domain->domain.ops == &intel_ss_paging_domain_ops;
+}
 
 #ifdef CONFIG_INTEL_IOMMU
 extern int intel_iommu_sm;
diff --git a/drivers/iommu/intel/nested.c b/drivers/iommu/intel/nested.c
index fc312f649f9ef..1b6ad9c900a5a 100644
--- a/drivers/iommu/intel/nested.c
+++ b/drivers/iommu/intel/nested.c
@@ -216,8 +216,7 @@ intel_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 	/* Must be nested domain */
 	if (user_data->type != IOMMU_HWPT_DATA_VTD_S1)
 		return ERR_PTR(-EOPNOTSUPP);
-	if (parent->ops != intel_iommu_ops.default_domain_ops ||
-	    !s2_domain->nested_parent)
+	if (!intel_domain_is_ss_paging(s2_domain) || !s2_domain->nested_parent)
 		return ERR_PTR(-EINVAL);
 
 	ret = iommu_copy_struct_from_user(&vtd, user_data,
@@ -229,7 +228,6 @@ intel_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	domain->use_first_level = true;
 	domain->s2_domain = s2_domain;
 	domain->s1_cfg = vtd;
 	domain->domain.ops = &intel_nested_domain_ops;
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index f3da596410b5e..3994521f6ea48 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -214,7 +214,6 @@ struct iommu_domain *intel_svm_domain_alloc(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	domain->domain.ops = &intel_svm_domain_ops;
-	domain->use_first_level = true;
 	INIT_LIST_HEAD(&domain->dev_pasids);
 	INIT_LIST_HEAD(&domain->cache_tags);
 	spin_lock_init(&domain->cache_lock);
-- 
2.51.0





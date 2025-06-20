Return-Path: <stable+bounces-154928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E24AE13A1
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 08:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686BE3BE832
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 06:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E73221290;
	Fri, 20 Jun 2025 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PEP80xha"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB8120F091;
	Fri, 20 Jun 2025 06:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750399838; cv=none; b=HcTut1omv6BUL1IpvtKdO29PXTLthkQNFNmVGEBmHTuTfT1eO5kALnPtthPGUlnE2Phmq79mvtaQUq3FIkkclIEMc7sWn6WcDGGWe204RZ6wL9a3cceYLmRvx8lg3s5XSiFqFIdZXXZrMurqWrIGDbilT/MjvLSKf6FxovdciHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750399838; c=relaxed/simple;
	bh=MHJanwY6fC5DvEjyFwwCVe+35ey974zZGBx0Y330LEw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWMRPV6BQyEY+VGb6+waDIOBK/fkg5BNxlAhv0gcYX/Mbiw5IP24MN3ew+XqBI0F/FF0OemlTgEUcmVWDiZs/rMyS/3ywpxOFIMq3oofV9ORTmnlBXvvcY3w+RT/ImbHYksjcrXZJ5DY+/hwkwJywC7Fv+tzgNu9x4AP2VaYqFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PEP80xha; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750399836; x=1781935836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MHJanwY6fC5DvEjyFwwCVe+35ey974zZGBx0Y330LEw=;
  b=PEP80xhaO00lZIAfj5y+Kxs4yNI8PbghidUKbpwZyy81CQUhWHwqrDMi
   PlwemB1YgUrCYqqa/XV1OHHsQgl6sHd1n1Kxg04Pxitg9zEWfN6yKc+nF
   jYmTcJUcIyDVGXyYAvO6Ty5Q3GdNbe7GyitO9P8oGbXZlbP+GDDiNe6rC
   V7nAeABjz6Df6RwAuixXlVPypEevqdP7lEa8EtPjOGChNFQVWOovZnHpt
   aPlwodq4xuFO3W+CZMRq7FGHP6prVSIcEi3m+F/aUemOEKhq2daDFfoaU
   7+4Gg2ZsVf3JesAzt0lWCcZSpWsxmxbKKgvIVQc9dtgQ2L6+Q3sHFb9fQ
   w==;
X-CSE-ConnectionGUID: zINGF7/MSf+gng6hA29Ytg==
X-CSE-MsgGUID: RxtTaD9KQaeW2siec2Ntig==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="52739743"
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="52739743"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 23:10:35 -0700
X-CSE-ConnectionGUID: xuRE8HhTQvmuxZy4+OJG+A==
X-CSE-MsgGUID: YihgLFvVT2SqD8EF48tANA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,250,1744095600"; 
   d="scan'208";a="150412278"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa007.fm.intel.com with ESMTP; 19 Jun 2025 23:10:32 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Enable ATS before cache tag assignment
Date: Fri, 20 Jun 2025 14:08:02 +0800
Message-ID: <20250620060802.3036137-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit <4f1492efb495> ("iommu/vt-d: Revert ATS timing change to fix boot
failure") placed the enabling of ATS in the probe_finalize callback. This
occurs after the default domain attachment, which is when the ATS cache
tag is assigned. Consequently, the device TLB cache tag is missed when the
domain is attached, leading to the device TLB not being invalidated in the
iommu_unmap paths.

Fix it by moving the ATS enabling to the default domain attachment path,
ensuring ATS is enabled before the cache tag assignment.

Fixes: 4f1492efb495 ("iommu/vt-d: Revert ATS timing change to fix boot failure")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7aa3932251b2..863ccb47bcca 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -54,6 +54,7 @@
 				__DOMAIN_MAX_PFN(gaw), (unsigned long)-1))
 #define DOMAIN_MAX_ADDR(gaw)	(((uint64_t)__DOMAIN_MAX_PFN(gaw)) << VTD_PAGE_SHIFT)
 
+static void sm_iommu_enable_pcicaps(struct device *dev);
 static void __init check_tylersburg_isoch(void);
 static int rwbf_quirk;
 
@@ -1825,10 +1826,11 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	else
 		ret = domain_setup_second_level(iommu, domain, dev,
 						IOMMU_NO_PASID, NULL);
-
 	if (ret)
 		goto out_block_translation;
 
+	/* PCI ATS enablement must happen before cache tag assigning. */
+	sm_iommu_enable_pcicaps(dev);
 	ret = cache_tag_assign_domain(domain, dev, IOMMU_NO_PASID);
 	if (ret)
 		goto out_block_translation;
@@ -3765,11 +3767,18 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
 	return ERR_PTR(ret);
 }
 
-static void intel_iommu_probe_finalize(struct device *dev)
+static void sm_iommu_enable_pcicaps(struct device *dev)
 {
 	struct device_domain_info *info = dev_iommu_priv_get(dev);
 	struct intel_iommu *iommu = info->iommu;
 
+	/*
+	 * Called only in iommu_device_register() path when iommu is
+	 * configured in the scalable mode.
+	 */
+	if (!sm_supported(iommu) || READ_ONCE(iommu->iommu.ready))
+		return;
+
 	/*
 	 * The PCIe spec, in its wisdom, declares that the behaviour of the
 	 * device is undefined if you enable PASID support after ATS support.
@@ -3780,7 +3789,7 @@ static void intel_iommu_probe_finalize(struct device *dev)
 	    !pci_enable_pasid(to_pci_dev(dev), info->pasid_supported & ~1))
 		info->pasid_enabled = 1;
 
-	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev))
+	if (!dev_is_real_dma_subdevice(dev))
 		iommu_enable_pci_ats(info);
 	iommu_enable_pci_pri(info);
 }
@@ -4309,6 +4318,7 @@ static int identity_domain_attach_dev(struct iommu_domain *domain, struct device
 		ret = intel_pasid_setup_pass_through(iommu, dev, IOMMU_NO_PASID);
 	else
 		ret = device_setup_pass_through(dev);
+	sm_iommu_enable_pcicaps(dev);
 
 	if (!ret)
 		info->domain_attached = true;
@@ -4359,7 +4369,6 @@ const struct iommu_ops intel_iommu_ops = {
 	.domain_alloc_sva	= intel_svm_domain_alloc,
 	.domain_alloc_nested	= intel_iommu_domain_alloc_nested,
 	.probe_device		= intel_iommu_probe_device,
-	.probe_finalize		= intel_iommu_probe_finalize,
 	.release_device		= intel_iommu_release_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
 	.device_group		= intel_iommu_device_group,
-- 
2.43.0



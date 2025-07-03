Return-Path: <stable+bounces-159278-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBAFAF6896
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 05:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B431C447B8
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 03:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812BE2288EE;
	Thu,  3 Jul 2025 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/9AXaZW"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F7226D02;
	Thu,  3 Jul 2025 03:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751512691; cv=none; b=cUUVtkl+52jnI9xA01X2PZbxkIT5aDwD3ha/+3W5m7Ix/QML+SrLYuBvasyIM0E23U4zh72MFWVe52kSkL/2uNUeAk3OdOhO8Qb+KNTmM8r50mDAJ039CVwPk6aJT7Hew2K+4BoB/1JWyg+kAhig5lawtjuPU6nTUoF4qRMC/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751512691; c=relaxed/simple;
	bh=HqUI1KPm0vQFCo7eoNaYy5FdR+YYqlgXUQ4gK/8aBm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UzynkzSd7cYW8FEJGug/RqJVLMNppcYyj3ptGl0SgIptZDEN5HfV35WBq6fxViNuv2vTDHmSXTUdk8g/gJNSj0eHoLWVs/qwBBJVg2L5lHSqNFCI5LEY6lmREfzKLrC9802dDSSgqNAdmKgFph19CZaeApPItbVYjNpwG/S5M+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/9AXaZW; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751512690; x=1783048690;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HqUI1KPm0vQFCo7eoNaYy5FdR+YYqlgXUQ4gK/8aBm0=;
  b=a/9AXaZWWX6cr/QmoSUx/47zqeqaY+Eeuv2PRBDOiHVo2pIyQzL01QOd
   LAygyOEnYXEbNEctnGYOqTQ+IHmMp47A8kwbT5gFBEnONaTV5PkNcttFX
   RlQK4Y9goywxnCv6Q9ITtSBKXIjJiXC/KCrZgCF8B/vPRZKXOEcAgfXnH
   OVjF80ZjdqUQFjoAA56UzvdRWsWEg2+wEO9I9JB8akWHmEFd32zH3Er80
   q64kC+CgN5Lww+D3GMthGNaes1T8i+mzuUKjOZ7xiBdlaVFlv9Ancfwe0
   /BLVhAXAdrdm7b0N+vCJAiKqY3qgoqRoUh9YSKnUoa7YR3APLjc8lFFpA
   g==;
X-CSE-ConnectionGUID: UmPt4bVKQZusnexT0d2IqA==
X-CSE-MsgGUID: S9k+4XTWQ5iSr71m8texXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="53793040"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="53793040"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 20:18:09 -0700
X-CSE-ConnectionGUID: WjkuFrhFRPe0tvxLm541Jg==
X-CSE-MsgGUID: 4SaYQt3+TeyUNSVmnAX2KQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; 
   d="scan'208";a="153658519"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by orviesa010.jf.intel.com with ESMTP; 02 Jul 2025 20:18:06 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Cc: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Optimize iotlb_sync_map for non-caching/non-RWBF modes
Date: Thu,  3 Jul 2025 11:15:45 +0800
Message-ID: <20250703031545.3378602-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The iotlb_sync_map iommu ops allows drivers to perform necessary cache
flushes when new mappings are established. For the Intel iommu driver,
this callback specifically serves two purposes:

- To flush caches when a second-stage page table is attached to a device
  whose iommu is operating in caching mode (CAP_REG.CM==1).
- To explicitly flush internal write buffers to ensure updates to memory-
  resident remapping structures are visible to hardware (CAP_REG.RWBF==1).

However, in scenarios where neither caching mode nor the RWBF flag is
active, the cache_tag_flush_range_np() helper, which is called in the
iotlb_sync_map path, effectively becomes a no-op.

Despite being a no-op, cache_tag_flush_range_np() involves iterating
through all cache tags of the iommu's attached to the domain, protected
by a spinlock. This unnecessary execution path introduces overhead,
leading to a measurable I/O performance regression. On systems with NVMes
under the same bridge, performance was observed to drop from approximately
~6150 MiB/s down to ~4985 MiB/s.

Introduce a flag in the dmar_domain structure. This flag will only be set
when iotlb_sync_map is required (i.e., when CM or RWBF is set). The
cache_tag_flush_range_np() is called only for domains where this flag is
set.

Reported-by: Ioanna Alifieraki <ioanna-maria.alifieraki@canonical.com>
Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2115738
Link: https://lore.kernel.org/r/20250701171154.52435-1-ioanna-maria.alifieraki@canonical.com
Fixes: 129dab6e1286 ("iommu/vt-d: Use cache_tag_flush_range_np() in iotlb_sync_map")
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 19 ++++++++++++++++++-
 drivers/iommu/intel/iommu.h |  3 +++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 7aa3932251b2..f60201ee4be0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -1796,6 +1796,18 @@ static int domain_setup_first_level(struct intel_iommu *iommu,
 					  (pgd_t *)pgd, flags, old);
 }
 
+static bool domain_need_iotlb_sync_map(struct dmar_domain *domain,
+				       struct intel_iommu *iommu)
+{
+	if (cap_caching_mode(iommu->cap) && !domain->use_first_level)
+		return true;
+
+	if (rwbf_quirk || cap_rwbf(iommu->cap))
+		return true;
+
+	return false;
+}
+
 static int dmar_domain_attach_device(struct dmar_domain *domain,
 				     struct device *dev)
 {
@@ -1833,6 +1845,8 @@ static int dmar_domain_attach_device(struct dmar_domain *domain,
 	if (ret)
 		goto out_block_translation;
 
+	domain->iotlb_sync_map |= domain_need_iotlb_sync_map(domain, iommu);
+
 	return 0;
 
 out_block_translation:
@@ -3945,7 +3959,10 @@ static bool risky_device(struct pci_dev *pdev)
 static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 				      unsigned long iova, size_t size)
 {
-	cache_tag_flush_range_np(to_dmar_domain(domain), iova, iova + size - 1);
+	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
+
+	if (dmar_domain->iotlb_sync_map)
+		cache_tag_flush_range_np(dmar_domain, iova, iova + size - 1);
 
 	return 0;
 }
diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 3ddbcc603de2..7ab2c34a5ecc 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -614,6 +614,9 @@ struct dmar_domain {
 	u8 has_mappings:1;		/* Has mappings configured through
 					 * iommu_map() interface.
 					 */
+	u8 iotlb_sync_map:1;		/* Need to flush IOTLB cache or write
+					 * buffer when creating mappings.
+					 */
 
 	spinlock_t lock;		/* Protect device tracking lists */
 	struct list_head devices;	/* all devices' list */
-- 
2.43.0



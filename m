Return-Path: <stable+bounces-136506-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF262A99FAC
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 05:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD75460B3A
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 03:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13DA1AD3E0;
	Thu, 24 Apr 2025 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5t3RNE+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E70B19D07E;
	Thu, 24 Apr 2025 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745466056; cv=none; b=GrMTUrwbt24YJU0WqpemTywKVchR5OcrAg+UHz98IkLIEvcRbjeRor0qxKOsfGncSIhp5fPbWIKrv8X6D6p41S4CYA1Nx9T+weMA/QFS9j2OMZWCQk1+lisNNw3kTpiABIm6yUHuqwHgz0P8XDuvEJNRi11+Ppvf69bM0OE1q58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745466056; c=relaxed/simple;
	bh=uKeGZXTiEpKR7lAKGA+8xtCMdARCeUMFCu88OGMHDP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQc07Cy4SNLB+EJAXuQTC/3kZLnd//m5DUB7XchIQqJ8vFvCrN1F5whrxEiJhPxG0nN2AmkdelClS4b0wCl2XOtXMbeZD01ADjH+jTrAK/y0KiDLlWlXWGCvfCPqZR1e+UH7b21Swmd2GJg89co+9K8jzj64lJVoIwWB9HFuuyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5t3RNE+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745466055; x=1777002055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uKeGZXTiEpKR7lAKGA+8xtCMdARCeUMFCu88OGMHDP8=;
  b=b5t3RNE+nvqsHKbinQSxzCXsJQ93s6Y1nZJEGF6iJ+Pvs8ys1ArGB924
   OGzlGjgLp4gMS4fqfIoH1Hxc3cdSkmH3QfPGkDFhghumTpRIIV4iHxwMF
   S7fOpll41huF1dKbvuGVsZoIw67vicwqufuLl2Xk8hVXhBuPVXHbW+tZ0
   ib3hLK7DnB4DBmAuDsB78iZ61Ctv2uwi7usatwnk7rRMMFZY0KR1lKXV3
   3z5sCIa4aMc0vVKt1tLqJdBbHeLr6GWUBHHlWZBGh10S5LbImLeJJwubA
   4gmCn1JRp74+pI7oyv/J8T5ej2xZx3rzyyFO6OePJQO8xibrM5aBivHVI
   Q==;
X-CSE-ConnectionGUID: xMY8LroeSWOHH7Xbp/GO1w==
X-CSE-MsgGUID: ZfJ6MweHQMuqsdMFjo8a1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47176767"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47176767"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 20:40:54 -0700
X-CSE-ConnectionGUID: FhJV7mvVT9Gh/lF4+3m1SA==
X-CSE-MsgGUID: Iuc+csmbTYuQg9ZQP9hXvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="155712841"
Received: from allen-box.sh.intel.com ([10.239.159.52])
  by fmviesa002.fm.intel.com with ESMTP; 23 Apr 2025 20:40:50 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	shangsong2@lenovo.com,
	Dave Jiang <dave.jiang@intel.com>
Cc: jack.vogel@oracle.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/1] iommu: Allow attaching static domains in iommu_attach_device_pasid()
Date: Thu, 24 Apr 2025 11:41:23 +0800
Message-ID: <20250424034123.2311362-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The idxd driver attaches the default domain to a PASID of the device to
perform kernel DMA using that PASID. The domain is attached to the
device's PASID through iommu_attach_device_pasid(), which checks if the
domain->owner matches the iommu_ops retrieved from the device. If they
do not match, it returns a failure.

        if (ops != domain->owner || pasid == IOMMU_NO_PASID)
                return -EINVAL;

The static identity domain implemented by the intel iommu driver doesn't
specify the domain owner. Therefore, kernel DMA with PASID doesn't work
for the idxd driver if the device translation mode is set to passthrough.

Generally the owner field of static domains are not set because they are
already part of iommu ops. Add a helper domain_iommu_ops_compatible()
that checks if a domain is compatible with the device's iommu ops. This
helper explicitly allows the static blocked and identity domains associated
with the device's iommu_ops to be considered compatible.

Fixes: 2031c469f816 ("iommu/vt-d: Add support for static identity domain")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220031
Cc: stable@vger.kernel.org
Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://lore.kernel.org/linux-iommu/20250422191554.GC1213339@ziepe.ca/
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/iommu.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

Change log:
v3:
 - Convert all places checking domain->owner to the new helper.
v2: https://lore.kernel.org/linux-iommu/20250423021839.2189204-1-baolu.lu@linux.intel.com/
 - Make the solution generic for all static domains as suggested by
   Jason.
v1: https://lore.kernel.org/linux-iommu/20250422075422.2084548-1-baolu.lu@linux.intel.com/

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4f91a740c15f..b26fc3ed9f01 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2204,6 +2204,19 @@ static void *iommu_make_pasid_array_entry(struct iommu_domain *domain,
 	return xa_tag_pointer(domain, IOMMU_PASID_ARRAY_DOMAIN);
 }
 
+static bool domain_iommu_ops_compatible(const struct iommu_ops *ops,
+					struct iommu_domain *domain)
+{
+	if (domain->owner == ops)
+		return true;
+
+	/* For static domains, owner isn't set. */
+	if (domain == ops->blocked_domain || domain == ops->identity_domain)
+		return true;
+
+	return false;
+}
+
 static int __iommu_attach_group(struct iommu_domain *domain,
 				struct iommu_group *group)
 {
@@ -2214,7 +2227,8 @@ static int __iommu_attach_group(struct iommu_domain *domain,
 		return -EBUSY;
 
 	dev = iommu_group_first_dev(group);
-	if (!dev_has_iommu(dev) || dev_iommu_ops(dev) != domain->owner)
+	if (!dev_has_iommu(dev) ||
+	    !domain_iommu_ops_compatible(dev_iommu_ops(dev), domain))
 		return -EINVAL;
 
 	return __iommu_group_set_domain(group, domain);
@@ -3435,7 +3449,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
 	    !ops->blocked_domain->ops->set_dev_pasid)
 		return -EOPNOTSUPP;
 
-	if (ops != domain->owner || pasid == IOMMU_NO_PASID)
+	if (!domain_iommu_ops_compatible(ops, domain) ||
+	    pasid == IOMMU_NO_PASID)
 		return -EINVAL;
 
 	mutex_lock(&group->mutex);
@@ -3511,7 +3526,7 @@ int iommu_replace_device_pasid(struct iommu_domain *domain,
 	if (!domain->ops->set_dev_pasid)
 		return -EOPNOTSUPP;
 
-	if (dev_iommu_ops(dev) != domain->owner ||
+	if (!domain_iommu_ops_compatible(dev_iommu_ops(dev), domain) ||
 	    pasid == IOMMU_NO_PASID || !handle)
 		return -EINVAL;
 
-- 
2.43.0



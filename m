Return-Path: <stable+bounces-121142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBC3A54160
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 04:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54181892913
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 03:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F47B14A630;
	Thu,  6 Mar 2025 03:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UDEPXgqH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185F886330
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 03:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741232927; cv=none; b=aitZIqYg5RLOb5JF887xJKVyXRJbU5hMiZqCe4vNrco4HnMP69G8mOj7LUBE1FInFVJmYhGYhF84EGYgHShQ5aU0F5gyhX9rYjFZ/mfAwhrtnGQYOuxCETYKdccvx8vxUz0DSolb2uMA4F8gkwNX7R8rXc5kyprqZdyWq4YsLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741232927; c=relaxed/simple;
	bh=hQzWIADl8MOs97ki4tsx8B1iMLSt2qABXVdFurBaStw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A8ANbQ1KhLC81oCEzgBIvgTUNPOMdBJwZ/Adkk56QSI59Qk1iFith1uAQyBncRTq+fnkZ4iGQL6kZUuvYbKeDWaEJoHpF+cdUgvOvJ4XE8RoTdJaU/fjiuROjfuZsk1mmPJUkBp1tTee3uOeopCyqqDfgEtCxukWM7eXowPPv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UDEPXgqH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741232924; x=1772768924;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hQzWIADl8MOs97ki4tsx8B1iMLSt2qABXVdFurBaStw=;
  b=UDEPXgqHDL05Zs0KTudeci5Onw6Mog+IXXd8a6D6xeJbFffdrzmthpaT
   PJrf5H/RnU+TZmN5RiBz7lAfFEDH7ARZvXSPBGe0CDD2QxlsS4+7bw9Lw
   8PlY6SxKwO+EljzLSf5HyhVdPwg6vRaJJrkPmGqaP1wYROkkPVQ7JpusN
   4fGBqyc3s7tR6VSdot92GJ7RAFyuyyejex23HaK01/qPSiOzvfnHehIpz
   55T4yhvBV6hI55QZWTyimdCzfS8w30NeebEQ/3coqcxscMLCqFHdYk9i/
   cJb6S9J4Ymffu00GgQBmXf/R9D6YsfptXvdSJIl0ANmz756TV1mmetwHV
   A==;
X-CSE-ConnectionGUID: ScOqfZiCRW+GUSY6CqBYMQ==
X-CSE-MsgGUID: ohnVOCrgR1mUIJ3gUjxcmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41936751"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="41936751"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 19:48:43 -0800
X-CSE-ConnectionGUID: 6dUZMFb3QcO5yAkHrckgog==
X-CSE-MsgGUID: Ssh2i7yXQSymU0Zy6WZCqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="123811921"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa003.jf.intel.com with ESMTP; 05 Mar 2025 19:48:43 -0800
From: Yi Liu <yi.l.liu@intel.com>
To: kevin.tian@intel.com,
	jgg@nvidia.com
Cc: yi.l.liu@intel.com,
	iommu@lists.linux.dev,
	nicolinc@nvidia.com,
	joro@8bytes.org,
	baolu.lu@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH v2] iommufd: Fail replace if device has not been attached
Date: Wed,  5 Mar 2025 19:48:42 -0800
Message-Id: <20250306034842.5950-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current implementation of iommufd_device_do_replace() implicitly
assumes that the input device has already been attached. However, there
is no explicit check to verify this assumption. If another device within
the same group has been attached, the replace operation might succeed,
but the input device itself may not have been attached yet.

As a result, the input device might not be tracked in the
igroup->device_list, and its reserved IOVA might not be added. Despite
this, the caller might incorrectly assume that the device has been
successfully replaced, which could lead to unexpected behavior or errors.

To address this issue, add a check to ensure that the input device has
been attached before proceeding with the replace operation. This check
will help maintain the integrity of the device tracking system and prevent
potential issues arising from incorrect assumptions about the device's
attachment status.

Fixes: e88d4ec154a8 ("iommufd: Add iommufd_device_replace()")
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
Change log:
v2:
  - Add r-b tag (Kevin)
  - Minor tweaks. I swarpped the order of is_attach check with the
    if (igroup->hwpt == NULL) check, hence no need to add WARN_ON.

v1: https://lore.kernel.org/linux-iommu/20250304120754.12450-1-yi.l.liu@intel.com/
---
 drivers/iommu/iommufd/device.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index b2f0cb909e6d..bd50146e2ad0 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -471,6 +471,17 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 
 /* The device attach/detach/replace helpers for attach_handle */
 
+/* Check if idev is attached to igroup->hwpt */
+static bool iommufd_device_is_attached(struct iommufd_device *idev)
+{
+	struct iommufd_device *cur;
+
+	list_for_each_entry(cur, &idev->igroup->device_list, group_item)
+		if (cur == idev)
+			return true;
+	return false;
+}
+
 static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
 				      struct iommufd_device *idev)
 {
@@ -710,6 +721,11 @@ iommufd_device_do_replace(struct iommufd_device *idev,
 		goto err_unlock;
 	}
 
+	if (!iommufd_device_is_attached(idev)) {
+		rc = -EINVAL;
+		goto err_unlock;
+	}
+
 	if (hwpt == igroup->hwpt) {
 		mutex_unlock(&idev->igroup->lock);
 		return NULL;
-- 
2.34.1



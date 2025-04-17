Return-Path: <stable+bounces-133171-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E29A91E9C
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7F13AA50F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370091ACECB;
	Thu, 17 Apr 2025 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WiKt05ri"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565681F949
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897668; cv=none; b=XHm0dXsSZvDrUe2q4qkRV5t6jlLs8rZ6EbzQrmY2YJif+Cuw8H9bZAYcxyYx5BxobYSljckcetQjlmKRlSdGmEsbC802C64MqD45WSlegx83Uw1w2VRb5jaOjpMMi7nmIhu0j4me3KJUbu9FyvrzPuDRoZh4C7mJ1B888TsaWWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897668; c=relaxed/simple;
	bh=/Hs80MKf5CkJGrNL+++gaVAU0xrUyEdVNR0+mBo+vW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T2WzGTD18uGnglZrJKBPmnwaUwshF9JIWaRQtJyTOjlFHCqC+mekjVCBpp7UTDnzb9viCoxvvxVuTiydIK4ukzN/ZZHZhjg3d7Qn6oHAr1ENB0FZsWjNc4z9bpr5Tu4mC75OHWVXN5FuMjSTor/gc3H9arqdu0UNRLXUXkGfu9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WiKt05ri; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744897667; x=1776433667;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/Hs80MKf5CkJGrNL+++gaVAU0xrUyEdVNR0+mBo+vW4=;
  b=WiKt05ririb+6MEq6kylJNV9cty0NAmwn5jh3uHizvSKXRupjKORp7LN
   F9qI8nxhM4vTyITBY4sGkwdqXpbdxzp9Jk+JMj0JaAhyRXwH6aPuPeuET
   ntrpM1xSDSKmlg8JDfypyqiw9Bq6JfTwY8oGZCn2eoXTmoUxgNNxQNRZZ
   zGpIaQ2QOvr8Udf9GkFC7IfVCuh2rboe2fQApeD0zdamCkbZW0KEqrvoo
   0/euLmVxDyGKcADvBvdPznRSfKVTy9kcbN7JQh1ZhG6e7QeX2WR2+vueP
   3JvBmtcbD9T194t1b8grqY/yVsoBhvxJITuR6PgEPRB8dAkneiRCk18Xa
   g==;
X-CSE-ConnectionGUID: mXy3/XlvTG6LGtZyoH5cMA==
X-CSE-MsgGUID: VlBXXCNgSG68AwiDFEtLIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="57478625"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="57478625"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 06:47:46 -0700
X-CSE-ConnectionGUID: yjhxq3ZITFG6la5BGGa3Sw==
X-CSE-MsgGUID: gz03slprQbq0m6jRGLJzMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="135625078"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by fmviesa005.fm.intel.com with ESMTP; 17 Apr 2025 06:47:45 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: stable@vger.kernel.org
Cc: Yi Liu <yi.l.liu@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.12.y] iommufd: Fail replace if device has not been attached
Date: Thu, 17 Apr 2025 06:47:43 -0700
Message-Id: <20250417134743.205380-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025041701-aerospace-retired-ff75@gregkh>
References: <2025041701-aerospace-retired-ff75@gregkh>
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
Link: https://patch.msgid.link/r/20250306034842.5950-1-yi.l.liu@intel.com
Cc: stable@vger.kernel.org
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
(cherry picked from commit 55c85fa7579dc2e3f5399ef5bad67a44257c1a48)
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/device.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 5fd3dd420290..0d9786d86e3e 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -352,6 +352,19 @@ iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
 	return 0;
 }
 
+/* The device attach/detach/replace helpers for attach_handle */
+
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
 int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
 				struct iommufd_device *idev)
 {
@@ -488,6 +501,11 @@ iommufd_device_do_replace(struct iommufd_device *idev,
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



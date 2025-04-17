Return-Path: <stable+bounces-133124-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112EFA91E2A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01A119E4B0E
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6402459CA;
	Thu, 17 Apr 2025 13:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ARAWV7FH"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F7D24502A
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 13:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897009; cv=none; b=jLTchP1j15FKXw/fzB7IsJwYCJ1z4hv2HrLz4gU6NLhKLkmqvU2C8Sqfgq/pnZaI1KFYVxA/MOCsKubp25B7tICIf6CgqArCEjMsTvbERuCUUvP0szECjHnVlyGYrtK5g6rRycs76N2sxJzQJsgDQbb6xMomXAvOlt//emwEvPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897009; c=relaxed/simple;
	bh=PSSLQ+xVdoyYzzUWbxxN7g3bR0QModSiIopcoEwJ5Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bAyxLtY3k3pyeZ2RO12THu/gQFenceO1L3/925C2cgUIoykIP/Ug8fZQRhbOycEBFWGMZKCHGKmlE2/HhiKfWPRJO/92QSXepQb5oBqyUkHY3YJKJXZedSN6kirU1ALB40CrKEdJg51RXKYdsLDd+J85pR3Uw5vLa4q5ZP08640=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ARAWV7FH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744897006; x=1776433006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSSLQ+xVdoyYzzUWbxxN7g3bR0QModSiIopcoEwJ5Tg=;
  b=ARAWV7FHAgnN2pzg1BL++qjiEQKQGuqULUQe0OOtj4AZ1skXk9h2sHNX
   g0GNHB2h6N7olo8IWYG+FtoHzT2YvY03gDftFPrZ9X3vPKgdR7Ag66XRc
   hv38NQslUVTt365fRF4JQibe9/BCXUEZCpiywTosMT4R15XCzc8mbJaJq
   md/DNMMTmFbcdUoHngqkEnPo9r2sAL9s8yMA4JKdrdzm770zXzJHLoIKB
   TqCyM/PzEYZLB5z6QGRwP1OykAdQ0XK8IX2n3TTO4vyy0/O41CCoj60kS
   RIbKFnDa7Wx+4sEun04QfGmFvMjVJX5lXPxh7GNhrbR7IZ0t+AtV1LsfT
   g==;
X-CSE-ConnectionGUID: vP58JaQ4SPSo24ojTmVLWw==
X-CSE-MsgGUID: YBCiehgITe2BLyKYvKjq0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46368020"
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="46368020"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 06:36:45 -0700
X-CSE-ConnectionGUID: suDKmtLhRPuj0GpbA4xDJg==
X-CSE-MsgGUID: +CGHp8XJTqCH1jGda6nYVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,219,1739865600"; 
   d="scan'208";a="130566502"
Received: from 984fee00a4c6.jf.intel.com ([10.165.58.231])
  by orviesa009.jf.intel.com with ESMTP; 17 Apr 2025 06:36:45 -0700
From: Yi Liu <yi.l.liu@intel.com>
To: stable@vger.kernel.org
Cc: Yi Liu <yi.l.liu@intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.6.y] iommufd: Fail replace if device has not been attached
Date: Thu, 17 Apr 2025 06:36:38 -0700
Message-Id: <20250417133638.115407-1-yi.l.liu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025041701-immovable-patio-2e75@gregkh>
References: <2025041701-immovable-patio-2e75@gregkh>
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
---
 drivers/iommu/iommufd/device.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index ce78c3671539..55866c29fb57 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -407,6 +407,17 @@ iommufd_device_do_attach(struct iommufd_device *idev,
 	return NULL;
 }
 
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
 static struct iommufd_hw_pagetable *
 iommufd_device_do_replace(struct iommufd_device *idev,
 			  struct iommufd_hw_pagetable *hwpt)
@@ -424,6 +435,11 @@ iommufd_device_do_replace(struct iommufd_device *idev,
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



Return-Path: <stable+bounces-72962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB296B111
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 08:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33316281D6D
	for <lists+stable@lfdr.de>; Wed,  4 Sep 2024 06:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD58284A5E;
	Wed,  4 Sep 2024 06:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C8pPL0f0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B849F9D6;
	Wed,  4 Sep 2024 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725430269; cv=none; b=i9NwFhru/uT+jowmCC4KT3L/GT8fObjCVUVBoiYt0zSxtBmE6Dl/HWkUa0/eH/LXTlUh0ZRhHNtLybfN+BgRCa3+cJF3xp+3mo1k4lfD1pHPW3wmRMWrnZSxFmKPQ3AbjkZ0QVXPFT0szBrUCkhPXApYLyfx8EQbI8+fH3XkY9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725430269; c=relaxed/simple;
	bh=aCL6Zb5OWsKvfMi2Mef+7SbyF16Z/0kioNzL8s98yzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dfO2k/8nGMeSKgzXzaEtXxU8OSopDKEpZTiYZGKgLbRjTUBcgO/RwpazMDhLDIvroTWeMnB3FgKlFQeAL5tJ8Jm3AwZmAQB0GTZgeNkCWK9UAyWcm0H6GAMENBXJiwhLWhnMGFFUdF4BnJvmRb71GCZm94GmvsCKAYOOub42rCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C8pPL0f0; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725430267; x=1756966267;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aCL6Zb5OWsKvfMi2Mef+7SbyF16Z/0kioNzL8s98yzY=;
  b=C8pPL0f0bZh+fYb4u05yMbJXBDC0B60FMb9nSHZI3Q0yyJOAZmKKyqQc
   SJBxQcvSIwiQPTJVrUpFESi0Yrzv9cyN7tpzfqfMtZfz+hX4lzedvPJ8c
   L7weEBDA/XeNCa2EWJZGTZ4Np1Fs2NIPqRLr6QwZd4gC95X9bDXxIb2Rt
   HqqjCj3ihueWffCQA7JH3Oo/bGvvmQjiFUtRo77QGWT8PgoMRtnj1FUFv
   2L/5s21oCFZlcXGKpb+fh7UMknLRB91iLXSarmhLGQNL7ZH0SxUah1Xci
   wD2kCL9P2LVWwvSApWmRb6kJenjXVW/qwqOFjb+RQAR01kzSytP7zic1q
   w==;
X-CSE-ConnectionGUID: L4rp+t4TTEmrMIgwx4DfBQ==
X-CSE-MsgGUID: 0B6NOFdNS6KnXQlYgxTC/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24228420"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24228420"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 23:11:07 -0700
X-CSE-ConnectionGUID: KzfF9kMAQ0OqQa6Zrw86Ig==
X-CSE-MsgGUID: 9BOHvZ2FQ4G8g0K6TXpRig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="70018930"
Received: from allen-box.sh.intel.com ([10.239.159.127])
  by orviesa004.jf.intel.com with ESMTP; 03 Sep 2024 23:11:04 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Kevin Tian <kevin.tian@intel.com>
Cc: jani.saarinen@intel.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Lu Baolu <baolu.lu@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] iommu/vt-d: Prevent boot failure with devices requiring ATS
Date: Wed,  4 Sep 2024 14:07:05 +0800
Message-Id: <20240904060705.90452-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SOC-integrated devices on some platforms require their PCI ATS enabled
for operation when the IOMMU is in scalable mode. Those devices are
reported via ACPI/SATC table with the ATC_REQUIRED bit set in the Flags
field.

The PCI subsystem offers the 'pci=noats' kernel command to disable PCI
ATS on all devices. Using 'pci=noat' with devices that require PCI ATS
can cause a conflict, leading to boot failure, especially if the device
is a graphics device.

To prevent this issue, check PCI ATS support before enumerating the IOMMU
devices. If any device requires PCI ATS, but PCI ATS is disabled by
'pci=noats', switch the IOMMU to operate in legacy mode to ensure
successful booting.

Fixes: 97f2f2c5317f ("iommu/vt-d: Enable ATS for the devices in SATC table")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/12036
Cc: stable@vger.kernel.org
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/iommu.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 4aa070cf56e7..8f275e046e91 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3127,10 +3127,26 @@ int dmar_iommu_notify_scope_dev(struct dmar_pci_notify_info *info)
 					(void *)satc + satc->header.length,
 					satc->segment, satcu->devices,
 					satcu->devices_cnt);
-			if (ret > 0)
-				break;
-			else if (ret < 0)
+			if (ret < 0)
 				return ret;
+
+			if (ret > 0) {
+				/*
+				 * The device requires PCI/ATS when the IOMMU
+				 * works in the scalable mode. If PCI/ATS is
+				 * disabled using the pci=noats kernel parameter,
+				 * the IOMMU will default to legacy mode. Users
+				 * are informed of this change.
+				 */
+				if (intel_iommu_sm && satcu->atc_required &&
+				    !pci_ats_supported(info->dev)) {
+					pci_warn(info->dev,
+						 "PCI/ATS not supported, system working in IOMMU legacy mode\n");
+					intel_iommu_sm = 0;
+				}
+
+				break;
+			}
 		} else if (info->event == BUS_NOTIFY_REMOVED_DEVICE) {
 			if (dmar_remove_dev_scope(info, satc->segment,
 					satcu->devices, satcu->devices_cnt))
-- 
2.34.1



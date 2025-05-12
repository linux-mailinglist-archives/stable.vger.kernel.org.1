Return-Path: <stable+bounces-143297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1C0AB3D89
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3FB179C3A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 16:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD33296140;
	Mon, 12 May 2025 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+j7Jfco"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8D429614C
	for <stable@vger.kernel.org>; Mon, 12 May 2025 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066940; cv=none; b=s/prG2s/uF1xd5lDTkXqukX/Bi/1LpGoO5VQHUKSP4AwBkn9+HZVFARw4aS3bK1kqOjPanaKsTkTRahfW6Bg0l3LJ9t+4lhMsBqXt4Y1vONOQdELBr32LVxGHg997UN7oRWHZOXLNmMYfqRaMN33/wv01Z9VN88NRgF0zXC+xSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066940; c=relaxed/simple;
	bh=31SUYSjAre9YyLoszXy4uNoKRPqB95ZMcryjSVmBdcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rKhyRPlhsd+KOLj1oJH5EDiX5Tr0t0xREaaFeu9u9LYeIsVKp5ppynQ0SCA7+jlJlszW0dyY7uybJIpUKgtPSfxNYTTIfjJJydNzD4qKmOIRCdakw95PhVzNnKBSUvE0BueCpdlX0DZa0/qtmQbVYhcm7Vtb+4jRyTCJGstzaVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+j7Jfco; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747066939; x=1778602939;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31SUYSjAre9YyLoszXy4uNoKRPqB95ZMcryjSVmBdcQ=;
  b=R+j7JfcohD9QNjI4DBcsT1hC5R9sa2PIdYWlqoVUiMLnHOgyNmoYsxrO
   qC/aTkm7VQWCJ0I/mYfUPNlnb1SnMEacbVSfnpP9fb9YWPIdX8DetSsgQ
   PpaWBPSAzeNip9LvUohtxVkgO/mzWNotakunS3GvbP7hmhO1DO6jNk2G2
   qUpl1e/GDasXS/l/Rttw6yMOL1/rZj7hjV2+4+zB8YZYIQv+0efCvo/FU
   wQIafDyVwdQWByD7YXIuWQGaJkIbYtVayzhy6+0SDFuqJpkn3QYHj9Bqv
   lODXYPxTfJezETsQzFMjmJ5c9MYfU7RqkUIqKgs51RE2jg0P4cPcYwRJy
   Q==;
X-CSE-ConnectionGUID: +D8hhM7cRZmC91p0oRTfIQ==
X-CSE-MsgGUID: xqBI/GFGSH6ICvvW0/y80Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="59508072"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="59508072"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 09:22:18 -0700
X-CSE-ConnectionGUID: fOQwS9tvSlOiJAWCB0axmA==
X-CSE-MsgGUID: d+2ahvD8SC2Qcw2V47ebHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="142532610"
Received: from unknown (HELO himal-Super-Server.iind.intel.com) ([10.190.239.34])
  by orviesa005.jf.intel.com with ESMTP; 12 May 2025 09:22:16 -0700
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 01/20] drm/gpusvm: Introduce devmem_only flag for allocation
Date: Mon, 12 May 2025 22:17:21 +0530
Message-Id: <20250512164740.466852-2-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250512164740.466852-1-himal.prasad.ghimiray@intel.com>
References: <20250512164740.466852-1-himal.prasad.ghimiray@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a new flag, devmem_only, to the drm_gpusvm structure. The
purpose of this flag is to ensure that the get_pages function allocates
memory exclusively from the device's memory. If the allocation from
device memory fails, the function will return an -EFAULT error.

Required for shared CPU and GPU atomics on certain devices.

v3:
 - s/vram_only/devmem_only/

Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 5 +++++
 include/drm/drm_gpusvm.h     | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index de424e670995..a58d03e6cac2 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1454,6 +1454,11 @@ int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
 				goto err_unmap;
 			}
 
+			if (ctx->devmem_only) {
+				err = -EFAULT;
+				goto err_unmap;
+			}
+
 			addr = dma_map_page(gpusvm->drm->dev,
 					    page, 0,
 					    PAGE_SIZE << order,
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index df120b4d1f83..9fd25fc880a4 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -286,6 +286,7 @@ struct drm_gpusvm {
  * @in_notifier: entering from a MMU notifier
  * @read_only: operating on read-only memory
  * @devmem_possible: possible to use device memory
+ * @devmem_only: use only device memory
  *
  * Context that is DRM GPUSVM is operating in (i.e. user arguments).
  */
@@ -294,6 +295,7 @@ struct drm_gpusvm_ctx {
 	unsigned int in_notifier :1;
 	unsigned int read_only :1;
 	unsigned int devmem_possible :1;
+	unsigned int devmem_only :1;
 };
 
 int drm_gpusvm_init(struct drm_gpusvm *gpusvm,
-- 
2.34.1



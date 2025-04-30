Return-Path: <stable+bounces-139139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3046AAA4A60
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 13:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD8D7B1E49
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD2259C8A;
	Wed, 30 Apr 2025 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UL2zoL6z"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69828248F7D
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014048; cv=none; b=MOn8tWZLxdyUOgMaqn2LLPn85t/KnWafjg/TGnxOXMaxdIB9KNzbzsgfZ0DrMYzp4D9Em0z5HTOTimoSZeEtH7WmnoJXbqNvQ055aebevNlJDtldgxAhsCNaIHXc8Ijl1zXBsyI0ynt/IoollpPJfqjXlaALq0uIZeQe1Hmjc6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014048; c=relaxed/simple;
	bh=6g/WYSnnBOfYZEmjvI9f0/ha43JM0liX/OOFyl/3xqs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MG0B0BTK4xYXMbaWqUQngoap0RJ2tYQzcFEk9HkXar8g1DCfCjFbE/jB8RSWavEBndTr6Cw2iZkq5SxvhJAaBR1Y4mjcEZuPm4QBCBOtFmLlZa2VxrecJYTvoRerm6dFww3iGKuScbKqWwz6K67FoHey3S84d+NTpnYskXNzcZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UL2zoL6z; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746014047; x=1777550047;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6g/WYSnnBOfYZEmjvI9f0/ha43JM0liX/OOFyl/3xqs=;
  b=UL2zoL6zEWc+5kFlodp8vjhAxEII7tXVyjcWfrLEw5X/xhYBWJ4CUAlR
   jGjrrxJvIAHQtFA3cU+lUw1580qZ30CXEYqzvX3vYoYmAj/aoJOS90LMw
   OVawYO1cFDQMggRqLVKrg0oupiQmAkqTwnURz9T5ZN2hCrfFbtAUCImsn
   o91E3sdQHQdzc/CYtZjOianJDYak3lNOuAb5kRA9JshYlw3idKtrzgqEN
   qk//N+u904lrXzmKJ1nwpy8Hm06BVusjlKN2t1NvivmvAFxgxRnO6K22a
   CqR/z0Qlmzl/7UXQjBVOdKmZrW3OL5Fu6otna9wRK5HbE0tXNln4B9svn
   w==;
X-CSE-ConnectionGUID: EvCShSrVSVCcr1cE0Awe1g==
X-CSE-MsgGUID: Kv5c9WlNSS2NZZOsG3QRvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47759917"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47759917"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 04:54:06 -0700
X-CSE-ConnectionGUID: sHwup/UaR9S3CZ3t97lXzQ==
X-CSE-MsgGUID: mCfk3pKBS5i7xi9D15yqpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134050593"
Received: from unknown (HELO himal-Super-Server.iind.intel.com) ([10.190.239.34])
  by fmviesa007.fm.intel.com with ESMTP; 30 Apr 2025 04:54:04 -0700
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	stable@vger.kernel.org
Subject: [PATCH v6 03/20] drm/gpusvm: Add timeslicing support to GPU SVM
Date: Wed, 30 Apr 2025 17:48:55 +0530
Message-Id: <20250430121912.337601-4-himal.prasad.ghimiray@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430121912.337601-1-himal.prasad.ghimiray@intel.com>
References: <20250430121912.337601-1-himal.prasad.ghimiray@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

Add timeslicing support to GPU SVM which will guarantee the GPU a
minimum execution time on piece of physical memory before migration back
to CPU. Intended to implement strict migration policies which require
memory to be in a certain placement for correct execution.

Required for shared CPU and GPU atomics on certain devices.

Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 9 +++++++++
 include/drm/drm_gpusvm.h     | 5 +++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index a58d03e6cac2..c94a8d7a293d 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -1770,6 +1770,8 @@ int drm_gpusvm_migrate_to_devmem(struct drm_gpusvm *gpusvm,
 		goto err_finalize;
 
 	/* Upon success bind devmem allocation to range and zdd */
+	devmem_allocation->timeslice_expiration = get_jiffies_64() +
+		msecs_to_jiffies(ctx->timeslice_ms);
 	zdd->devmem_allocation = devmem_allocation;	/* Owns ref */
 
 err_finalize:
@@ -1990,6 +1992,13 @@ static int __drm_gpusvm_migrate_to_ram(struct vm_area_struct *vas,
 	void *buf;
 	int i, err = 0;
 
+	if (page) {
+		zdd = page->zone_device_data;
+		if (time_before64(get_jiffies_64(),
+				  zdd->devmem_allocation->timeslice_expiration))
+			return 0;
+	}
+
 	start = ALIGN_DOWN(fault_addr, size);
 	end = ALIGN(fault_addr + 1, size);
 
diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
index 653d48dbe1c1..eaf704d3d05e 100644
--- a/include/drm/drm_gpusvm.h
+++ b/include/drm/drm_gpusvm.h
@@ -89,6 +89,7 @@ struct drm_gpusvm_devmem_ops {
  * @ops: Pointer to the operations structure for GPU SVM device memory
  * @dpagemap: The struct drm_pagemap of the pages this allocation belongs to.
  * @size: Size of device memory allocation
+ * @timeslice_expiration: Timeslice expiration in jiffies
  */
 struct drm_gpusvm_devmem {
 	struct device *dev;
@@ -97,6 +98,7 @@ struct drm_gpusvm_devmem {
 	const struct drm_gpusvm_devmem_ops *ops;
 	struct drm_pagemap *dpagemap;
 	size_t size;
+	u64 timeslice_expiration;
 };
 
 /**
@@ -295,6 +297,8 @@ struct drm_gpusvm {
  * @check_pages_threshold: Check CPU pages for present if chunk is less than or
  *                         equal to threshold. If not present, reduce chunk
  *                         size.
+ * @timeslice_ms: The timeslice MS which in minimum time a piece of memory
+ *		  remains with either exclusive GPU or CPU access.
  * @in_notifier: entering from a MMU notifier
  * @read_only: operating on read-only memory
  * @devmem_possible: possible to use device memory
@@ -304,6 +308,7 @@ struct drm_gpusvm {
  */
 struct drm_gpusvm_ctx {
 	unsigned long check_pages_threshold;
+	unsigned long timeslice_ms;
 	unsigned int in_notifier :1;
 	unsigned int read_only :1;
 	unsigned int devmem_possible :1;
-- 
2.34.1



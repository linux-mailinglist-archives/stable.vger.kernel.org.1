Return-Path: <stable+bounces-139137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA23AA4A59
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 13:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AFEE9C64F3
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 11:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF211221557;
	Wed, 30 Apr 2025 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="APE+okQs"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0585248F7D
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 11:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746014045; cv=none; b=HcbhKmXilZDQfVNjZXr6JCr1WoDorU3oE78nqKEapGnl5EFYVweI3ToZhCpm6iqKdw9DwQ6BP9a1+LTOX/Pm0tGd8Mf+CD2zeByDqF7tGPEPHMu0XV4ZPEV9LvGTPmdwA9Z86ImZDm6/azpIPiRULeKrkhD49Ev4zy0L+Uau1NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746014045; c=relaxed/simple;
	bh=tRUJskwSzU6RDw4rLHNZE3XIPWRy1vMISVeR+2fe7Dc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HOlO1wsP7nPScl8UktM3rr5JwSSicS7kofOU1u1uctk/d/2PrLCvNWWSaPYg9Bl9VPxHfhv/dO19ijfLGuXc6rW0EC/5xoPe9jcVZwTmqYpbmG0ypHlqgQq7NvHpMfv34E4eW1ECUdzr1rr93okwJsa+QzMUGzcQREGKZf3rI88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=APE+okQs; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746014043; x=1777550043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tRUJskwSzU6RDw4rLHNZE3XIPWRy1vMISVeR+2fe7Dc=;
  b=APE+okQsk3BesTSB0/AOfc8XDmX/b8gv9hg8ux2QbB5mdGbWnAXkLX9m
   Ui1i3We1cEd6HHf64YRXmjMD2YbnXz/QlWaOCzNA31NZOKHT6lHwQleLg
   VRRjqXJWp5gBOcA5cNTf12v74ZsvyVQalmbYhQecFbivdDqSFe+Bcu0MH
   AUxvKF3nu28cs2ci3QJjekpB3U7EX7WZ1IV7Ptyd6iwSsnPeFclY+fdJq
   mByMOadXFuaHfKhQeHvNZq1zAMX13IbwzOU11ysS0zJUv5b/pv3B3Fcvz
   UVYk5njOfvs9X7ORNZm+lgW5QHUvz3hhB1ANTpB87J9AeV3+KQJoOMS5u
   A==;
X-CSE-ConnectionGUID: kwioH37XTQKffDA7RDq8Eg==
X-CSE-MsgGUID: 88r0FbFZTjOslOh30WhcPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47759907"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47759907"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 04:54:03 -0700
X-CSE-ConnectionGUID: JK74C0TJTIiHkIN4II7WtA==
X-CSE-MsgGUID: jOwMavoWRoWNn23YL+9d6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134050578"
Received: from unknown (HELO himal-Super-Server.iind.intel.com) ([10.190.239.34])
  by fmviesa007.fm.intel.com with ESMTP; 30 Apr 2025 04:54:00 -0700
From: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 01/20] drm/gpusvm: Introduce devmem_only flag for allocation
Date: Wed, 30 Apr 2025 17:48:53 +0530
Message-Id: <20250430121912.337601-2-himal.prasad.ghimiray@intel.com>
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



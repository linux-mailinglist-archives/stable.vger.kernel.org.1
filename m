Return-Path: <stable+bounces-58134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0C29289B0
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 15:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A09C11F23431
	for <lists+stable@lfdr.de>; Fri,  5 Jul 2024 13:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2BF154C11;
	Fri,  5 Jul 2024 13:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mbcch/GG"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FB0153506
	for <stable@vger.kernel.org>; Fri,  5 Jul 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720186136; cv=none; b=p/FuJ7BVom1GFakO5MZspO27rMq7uUpKEOi2n0HSEBDmoRY2JCx2J4iUL/QAaknOhahdctIcymnQPLIF79bQ+Yy5AaDL4hB+rRbJRflyCM6fTl6IDWQ0VAJDzOLFzcOF4DFB4nNGb8E9Mo5XWiFL3KV+t/duXWnjBfx9cy3SM6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720186136; c=relaxed/simple;
	bh=IXCShkJkHmSpR+YhW53DnG/dJjgU3CqWPEEiFkbNVfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PcxwKgeWJdt0E2zqoE1YbSzXUCxy5UibUIMtKg3/Ado16ToIeJ0OqJI7L5a5+hB2bZUkbeaUzXwGy1dEk7FGGIqkTyfymnp6ELB2/WnKFboVPkxD18esYalBYkLkY6948NmnO8pg5rehPFSkdPzPkJNYNAuKM6T1IYm3uNxOCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mbcch/GG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720186135; x=1751722135;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IXCShkJkHmSpR+YhW53DnG/dJjgU3CqWPEEiFkbNVfs=;
  b=mbcch/GG8k5hSMAKsSSZqZOwN4HuH+U7f2tyOvloQvXAj6B+ly+weytT
   XU2/mFjisdD7ZqC356vAiX9+gzdWDD7A9iKRnaOismDBdj0ze0EKpdQas
   DQNrTQrc6/Me6zQxwK3Hv7Mm1L1IKtn+Qx06UwGESWQvMMGxT4MaTKZjY
   DiEJ2fXk4n58RlAT1GZnTNldBVNCihobLwVTCcw2Uft6I0IVji5iFhEee
   O9zDocHsc9zZoO5lMTLNjn5fC7iwNT+9xLBqRqLvFgSoTKWPkPkqwi1Or
   nyo/PBK2OTjAC8knAMM/S/3HWrD09y3ltRUSYOvcAVkJsJY5mnmX4SbQ9
   A==;
X-CSE-ConnectionGUID: Ukc9Yj8kRvKqzjbU9ZfD1Q==
X-CSE-MsgGUID: qQy2mjfrTmGk7ujH1XRjkg==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="21292852"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="21292852"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 06:28:54 -0700
X-CSE-ConnectionGUID: 2cFNoZ0ZR/+mOWEZupQEoQ==
X-CSE-MsgGUID: mK4aBrDKQFqCbikLtVRgYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="46850312"
Received: from maurocar-mobl2.ger.corp.intel.com (HELO fedora..) ([10.245.245.166])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 06:28:50 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Pallavi Mishra <pallavi.mishra@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	dri-devel@lists.freedesktop.org,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Effie Yu <effie.yu@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Jose Souza <jose.souza@intel.com>,
	Michal Mrozek <michal.mrozek@intel.com>,
	stable@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v3] drm/xe: Use write-back caching mode for system memory on DGFX
Date: Fri,  5 Jul 2024 15:28:28 +0200
Message-ID: <20240705132828.27714-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The caching mode for buffer objects with VRAM as a possible
placement was forced to write-combined, regardless of placement.

However, write-combined system memory is expensive to allocate and
even though it is pooled, the pool is expensive to shrink, since
it involves global CPU TLB flushes.

Moreover write-combined system memory from TTM is only reliably
available on x86 and DGFX doesn't have an x86 restriction.

So regardless of the cpu caching mode selected for a bo,
internally use write-back caching mode for system memory on DGFX.

Coherency is maintained, but user-space clients may perceive a
difference in cpu access speeds.

v2:
- Update RB- and Ack tags.
- Rephrase wording in xe_drm.h (Matt Roper)
v3:
- Really rephrase wording.

Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Fixes: 622f709ca629 ("drm/xe/uapi: Add support for CPU caching mode")
Cc: Pallavi Mishra <pallavi.mishra@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Effie Yu <effie.yu@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Jose Souza <jose.souza@intel.com>
Cc: Michal Mrozek <michal.mrozek@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Acked-by: Matthew Auld <matthew.auld@intel.com>
Acked-by: José Roberto de Souza <jose.souza@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Fixes: 622f709ca629 ("drm/xe/uapi: Add support for CPU caching mode")
Acked-by: Michal Mrozek <michal.mrozek@intel.com>
Acked-by: Effie Yu <effie.yu@intel.com> #On chat
---
 drivers/gpu/drm/xe/xe_bo.c       | 47 +++++++++++++++++++-------------
 drivers/gpu/drm/xe/xe_bo_types.h |  3 +-
 include/uapi/drm/xe_drm.h        |  8 +++++-
 3 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 65c696966e96..31192d983d9e 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -343,7 +343,7 @@ static struct ttm_tt *xe_ttm_tt_create(struct ttm_buffer_object *ttm_bo,
 	struct xe_device *xe = xe_bo_device(bo);
 	struct xe_ttm_tt *tt;
 	unsigned long extra_pages;
-	enum ttm_caching caching;
+	enum ttm_caching caching = ttm_cached;
 	int err;
 
 	tt = kzalloc(sizeof(*tt), GFP_KERNEL);
@@ -357,26 +357,35 @@ static struct ttm_tt *xe_ttm_tt_create(struct ttm_buffer_object *ttm_bo,
 		extra_pages = DIV_ROUND_UP(xe_device_ccs_bytes(xe, bo->size),
 					   PAGE_SIZE);
 
-	switch (bo->cpu_caching) {
-	case DRM_XE_GEM_CPU_CACHING_WC:
-		caching = ttm_write_combined;
-		break;
-	default:
-		caching = ttm_cached;
-		break;
-	}
-
-	WARN_ON((bo->flags & XE_BO_FLAG_USER) && !bo->cpu_caching);
-
 	/*
-	 * Display scanout is always non-coherent with the CPU cache.
-	 *
-	 * For Xe_LPG and beyond, PPGTT PTE lookups are also non-coherent and
-	 * require a CPU:WC mapping.
+	 * DGFX system memory is always WB / ttm_cached, since
+	 * other caching modes are only supported on x86. DGFX
+	 * GPU system memory accesses are always coherent with the
+	 * CPU.
 	 */
-	if ((!bo->cpu_caching && bo->flags & XE_BO_FLAG_SCANOUT) ||
-	    (xe->info.graphics_verx100 >= 1270 && bo->flags & XE_BO_FLAG_PAGETABLE))
-		caching = ttm_write_combined;
+	if (!IS_DGFX(xe)) {
+		switch (bo->cpu_caching) {
+		case DRM_XE_GEM_CPU_CACHING_WC:
+			caching = ttm_write_combined;
+			break;
+		default:
+			caching = ttm_cached;
+			break;
+		}
+
+		WARN_ON((bo->flags & XE_BO_FLAG_USER) && !bo->cpu_caching);
+
+		/*
+		 * Display scanout is always non-coherent with the CPU cache.
+		 *
+		 * For Xe_LPG and beyond, PPGTT PTE lookups are also
+		 * non-coherent and require a CPU:WC mapping.
+		 */
+		if ((!bo->cpu_caching && bo->flags & XE_BO_FLAG_SCANOUT) ||
+		    (xe->info.graphics_verx100 >= 1270 &&
+		     bo->flags & XE_BO_FLAG_PAGETABLE))
+			caching = ttm_write_combined;
+	}
 
 	if (bo->flags & XE_BO_FLAG_NEEDS_UC) {
 		/*
diff --git a/drivers/gpu/drm/xe/xe_bo_types.h b/drivers/gpu/drm/xe/xe_bo_types.h
index 02d68873558a..ebc8abf7930a 100644
--- a/drivers/gpu/drm/xe/xe_bo_types.h
+++ b/drivers/gpu/drm/xe/xe_bo_types.h
@@ -68,7 +68,8 @@ struct xe_bo {
 
 	/**
 	 * @cpu_caching: CPU caching mode. Currently only used for userspace
-	 * objects.
+	 * objects. Exceptions are system memory on DGFX, which is always
+	 * WB.
 	 */
 	u16 cpu_caching;
 
diff --git a/include/uapi/drm/xe_drm.h b/include/uapi/drm/xe_drm.h
index 33544ef78d3e..19619d4952a8 100644
--- a/include/uapi/drm/xe_drm.h
+++ b/include/uapi/drm/xe_drm.h
@@ -783,7 +783,13 @@ struct drm_xe_gem_create {
 #define DRM_XE_GEM_CPU_CACHING_WC                      2
 	/**
 	 * @cpu_caching: The CPU caching mode to select for this object. If
-	 * mmaping the object the mode selected here will also be used.
+	 * mmaping the object the mode selected here will also be used. The
+	 * exception is when mapping system memory (including data evicted
+	 * to system) on discrete GPUs. The caching mode selected will
+	 * then be overridden to DRM_XE_GEM_CPU_CACHING_WB, and coherency
+	 * between GPU- and CPU is guaranteed. The caching mode of
+	 * existing CPU-mappings will be updated transparently to
+	 * user-space clients.
 	 */
 	__u16 cpu_caching;
 	/** @pad: MBZ */
-- 
2.44.0



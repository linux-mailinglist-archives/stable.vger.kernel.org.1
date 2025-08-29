Return-Path: <stable+bounces-176697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E6BB3B9FC
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 13:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9532053CB
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 11:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A959B218EB1;
	Fri, 29 Aug 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTAytopF"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5E82BE63D
	for <stable@vger.kernel.org>; Fri, 29 Aug 2025 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756467266; cv=none; b=OgJmHSUpH6AS+TQwAkDDPli0CY85tF7t+L0TfsOxvSOH82VvUsJiOz8gGy1jSKd8Zs7Nec/AyEH/t5Qi8G5X1bnGdnulzFKjpaDI4ebh2hn2iW6+t2YawZQoTp+rXRdov9prP4z0c8HtUUWR5rMgqn3M+XNexgC1T0OrAFA2rI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756467266; c=relaxed/simple;
	bh=/WevGVzQU1u/QeBDwW2EkUF0Gwa3aNVragUk1J2ARhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8pZmc+elIUCQfi+M7jJCcXuPUc7E2QfEuKL+5bvskSjJYioKTiTbvCkg1/EZn1Ro5vIIrHyX6NaOOfIVQNkmSzVT0SzUNG92iMou2AU5XUAySCXQRyesr7fvObSzIml5gT33XstcoL+lPe4qBwBV1JQfkxaWJ4r4S+lXWOdBbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YTAytopF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756467265; x=1788003265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/WevGVzQU1u/QeBDwW2EkUF0Gwa3aNVragUk1J2ARhg=;
  b=YTAytopFCRqfXcLnMf08Y0D0FeKHK29yykShycqLAeARShUNM8EaI0TT
   DpVDN06UeucmTps4qjVSAmuztup+/XVRW14ogPKrhwofuwWTtqoaVAX9K
   Azu5hyguLdMYPUrZX8Bey+QaB7TGyjlPoDQeOcvu6dF/2KGx+9y9Sz4/p
   ItGzgA4iq0ec0NwV5wg8JdHxjMRYCe1tExBoDsq45gps97TZvZFtaH/vQ
   qvcrtwWk5oapog1i2X81g95vEWI1a84F7GOF6SoBX1NA+Ia3w4hMPyzA1
   MZICWoHCdcbO4fMzb560B91nJE9SId+6NHVqK/yGqh98FKq1V9KbzmqOK
   A==;
X-CSE-ConnectionGUID: aVXpV+XKTPaRb4QuD2g5bA==
X-CSE-MsgGUID: jSlrcyNpQFak/zfON1+aNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="69025634"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69025634"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 04:34:24 -0700
X-CSE-ConnectionGUID: 3zFeLtYERpqQC2dcMSfk2Q==
X-CSE-MsgGUID: 8XsDTTMDRGiU3hbmEzf9oA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="170748269"
Received: from agladkov-desk.ger.corp.intel.com (HELO fedora) ([10.245.245.245])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 04:34:22 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org,
	Rodrigo vivi <rodrigo.vivi@intel.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: [PATCH 1/3] drm/xe: Attempt to bring bos back to VRAM after eviction
Date: Fri, 29 Aug 2025 13:33:48 +0200
Message-ID: <20250829113350.40959-2-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829113350.40959-1-thomas.hellstrom@linux.intel.com>
References: <20250829113350.40959-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

VRAM+TT bos that are evicted from VRAM to TT may remain in
TT also after a revalidation following eviction or suspend.

This manifests itself as applications becoming sluggish
after buffer objects get evicted or after a resume from
suspend or hibernation.

If the bo supports placement in both VRAM and TT, and
we are on DGFX, mark the TT placement as fallback. This means
that it is tried only after VRAM + eviction.

This flaw has probably been present since the xe module was
upstreamed but use a Fixes: commit below where backporting is
likely to be simple. For earlier versions we need to open-
code the fallback algorithm in the driver.

v2:
- Remove check for dgfx. (Matthew Auld)
- Update the xe_dma_buf kunit test for the new strategy (CI)
- Allow dma-buf to pin in current placement (CI)
- Make xe_bo_validate() for pinned bos a NOP.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/5995
Fixes: a78a8da51b36 ("drm/ttm: replace busy placement with flags v6")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.9+
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/drm/xe/tests/xe_bo.c      |  2 +-
 drivers/gpu/drm/xe/tests/xe_dma_buf.c | 10 +---------
 drivers/gpu/drm/xe/xe_bo.c            | 16 ++++++++++++----
 drivers/gpu/drm/xe/xe_bo.h            |  2 +-
 drivers/gpu/drm/xe/xe_dma_buf.c       |  2 +-
 5 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/xe/tests/xe_bo.c b/drivers/gpu/drm/xe/tests/xe_bo.c
index bb469096d072..7b40cc8be1c9 100644
--- a/drivers/gpu/drm/xe/tests/xe_bo.c
+++ b/drivers/gpu/drm/xe/tests/xe_bo.c
@@ -236,7 +236,7 @@ static int evict_test_run_tile(struct xe_device *xe, struct xe_tile *tile, struc
 		}
 
 		xe_bo_lock(external, false);
-		err = xe_bo_pin_external(external);
+		err = xe_bo_pin_external(external, false);
 		xe_bo_unlock(external);
 		if (err) {
 			KUNIT_FAIL(test, "external bo pin err=%pe\n",
diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
index cde9530bef8c..3f30d2cef917 100644
--- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
@@ -85,15 +85,7 @@ static void check_residency(struct kunit *test, struct xe_bo *exported,
 		return;
 	}
 
-	/*
-	 * If on different devices, the exporter is kept in system  if
-	 * possible, saving a migration step as the transfer is just
-	 * likely as fast from system memory.
-	 */
-	if (params->mem_mask & XE_BO_FLAG_SYSTEM)
-		KUNIT_EXPECT_TRUE(test, xe_bo_is_mem_type(exported, XE_PL_TT));
-	else
-		KUNIT_EXPECT_TRUE(test, xe_bo_is_mem_type(exported, mem_type));
+	KUNIT_EXPECT_TRUE(test, xe_bo_is_mem_type(exported, mem_type));
 
 	if (params->force_different_devices)
 		KUNIT_EXPECT_TRUE(test, xe_bo_is_mem_type(imported, XE_PL_TT));
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 4faf15d5fa6d..870f43347281 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -188,6 +188,8 @@ static void try_add_system(struct xe_device *xe, struct xe_bo *bo,
 
 		bo->placements[*c] = (struct ttm_place) {
 			.mem_type = XE_PL_TT,
+			.flags = (bo_flags & XE_BO_FLAG_VRAM_MASK) ?
+			TTM_PL_FLAG_FALLBACK : 0,
 		};
 		*c += 1;
 	}
@@ -2322,6 +2324,7 @@ uint64_t vram_region_gpu_offset(struct ttm_resource *res)
 /**
  * xe_bo_pin_external - pin an external BO
  * @bo: buffer object to be pinned
+ * @in_place: Pin in current placement, don't attempt to migrate.
  *
  * Pin an external (not tied to a VM, can be exported via dma-buf / prime FD)
  * BO. Unique call compared to xe_bo_pin as this function has it own set of
@@ -2329,7 +2332,7 @@ uint64_t vram_region_gpu_offset(struct ttm_resource *res)
  *
  * Returns 0 for success, negative error code otherwise.
  */
-int xe_bo_pin_external(struct xe_bo *bo)
+int xe_bo_pin_external(struct xe_bo *bo, bool in_place)
 {
 	struct xe_device *xe = xe_bo_device(bo);
 	int err;
@@ -2338,9 +2341,11 @@ int xe_bo_pin_external(struct xe_bo *bo)
 	xe_assert(xe, xe_bo_is_user(bo));
 
 	if (!xe_bo_is_pinned(bo)) {
-		err = xe_bo_validate(bo, NULL, false);
-		if (err)
-			return err;
+		if (!in_place) {
+			err = xe_bo_validate(bo, NULL, false);
+			if (err)
+				return err;
+		}
 
 		spin_lock(&xe->pinned.lock);
 		list_add_tail(&bo->pinned_link, &xe->pinned.late.external);
@@ -2493,6 +2498,9 @@ int xe_bo_validate(struct xe_bo *bo, struct xe_vm *vm, bool allow_res_evict)
 	};
 	int ret;
 
+	if (xe_bo_is_pinned(bo))
+		return 0;
+
 	if (vm) {
 		lockdep_assert_held(&vm->lock);
 		xe_vm_assert_held(vm);
diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
index 8cce413b5235..cfb1ec266a6d 100644
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -200,7 +200,7 @@ static inline void xe_bo_unlock_vm_held(struct xe_bo *bo)
 	}
 }
 
-int xe_bo_pin_external(struct xe_bo *bo);
+int xe_bo_pin_external(struct xe_bo *bo, bool in_place);
 int xe_bo_pin(struct xe_bo *bo);
 void xe_bo_unpin_external(struct xe_bo *bo);
 void xe_bo_unpin(struct xe_bo *bo);
diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c b/drivers/gpu/drm/xe/xe_dma_buf.c
index 346f857f3837..af64baf872ef 100644
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -72,7 +72,7 @@ static int xe_dma_buf_pin(struct dma_buf_attachment *attach)
 		return ret;
 	}
 
-	ret = xe_bo_pin_external(bo);
+	ret = xe_bo_pin_external(bo, true);
 	xe_assert(xe, !ret);
 
 	return 0;
-- 
2.50.1



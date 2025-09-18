Return-Path: <stable+bounces-179925-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313A4B7E163
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 14:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B09752A4CED
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 12:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587B72FFF87;
	Wed, 17 Sep 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VXUqdMbe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125EA2D7DF2;
	Wed, 17 Sep 2025 12:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758112818; cv=none; b=PbW6LsCkCprf2qU2eEc03FKgdg0deVFKDC/s/R8682ai+6QOiVmBDLCqxXymZlZdu7QQ0zTPDWFldL/X7rD2DhiD4q1uU5CHnswReV8yHJwi5VuXrCjfw7wuaowifLUTEnVL4EQCbNRH7hVql/HS+vXs3BtWXnCqLc0zyMvF4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758112818; c=relaxed/simple;
	bh=Z/Pw1IahDsgtPL4RvLcNhAxbtaxLl2sltAspswXqoxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3qumlIuWLEZ/lT3Urs9mNwCSRL/BwYy5oh+qL5UH7RUtKqXp+hdI2fouhCUwxy38LooYyAdTNHR7WA0lgKhyOgmXjo+65LK9CrScdIbSR60qR9bxFo3ypt2KX1QIjM5m3q7c49Ili7uZiXhjJpxhL+7pcC2s93Yegsugo83Tbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VXUqdMbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83CB3C4CEF0;
	Wed, 17 Sep 2025 12:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758112818;
	bh=Z/Pw1IahDsgtPL4RvLcNhAxbtaxLl2sltAspswXqoxQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VXUqdMbeerpx0xbx1MlE6IedmgiCH6bVJYhhlG5CM8hlwasokr+IglKif/o6aZTGT
	 1ScMrv8k7yWUAwCdkzVBIMbPE6Vxm7HSeRQ2+E2Y/hHUCos7gkVQzmZZqv0d9DR30H
	 8C0aV6xp52WsbwftT7Wsy1AuNDm5Mt23Yp9Ng+WU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.16 085/189] drm/xe: Attempt to bring bos back to VRAM after eviction
Date: Wed, 17 Sep 2025 14:33:15 +0200
Message-ID: <20250917123353.935871050@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
References: <20250917123351.839989757@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Hellström <thomas.hellstrom@linux.intel.com>

commit 5c87fee3c96ce898ad681552404a66c7605193c0 upstream.

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
Link: https://lore.kernel.org/r/20250904160715.2613-2-thomas.hellstrom@linux.intel.com
(cherry picked from commit cb3d7b3b46b799c96b54f8e8fe36794a55a77f0b)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/tests/xe_bo.c      |    2 +-
 drivers/gpu/drm/xe/tests/xe_dma_buf.c |   10 +---------
 drivers/gpu/drm/xe/xe_bo.c            |   16 ++++++++++++----
 drivers/gpu/drm/xe/xe_bo.h            |    2 +-
 drivers/gpu/drm/xe/xe_dma_buf.c       |    2 +-
 5 files changed, 16 insertions(+), 16 deletions(-)

--- a/drivers/gpu/drm/xe/tests/xe_bo.c
+++ b/drivers/gpu/drm/xe/tests/xe_bo.c
@@ -236,7 +236,7 @@ static int evict_test_run_tile(struct xe
 		}
 
 		xe_bo_lock(external, false);
-		err = xe_bo_pin_external(external);
+		err = xe_bo_pin_external(external, false);
 		xe_bo_unlock(external);
 		if (err) {
 			KUNIT_FAIL(test, "external bo pin err=%pe\n",
--- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
@@ -89,15 +89,7 @@ static void check_residency(struct kunit
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
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -184,6 +184,8 @@ static void try_add_system(struct xe_dev
 
 		bo->placements[*c] = (struct ttm_place) {
 			.mem_type = XE_PL_TT,
+			.flags = (bo_flags & XE_BO_FLAG_VRAM_MASK) ?
+			TTM_PL_FLAG_FALLBACK : 0,
 		};
 		*c += 1;
 	}
@@ -2266,6 +2268,7 @@ uint64_t vram_region_gpu_offset(struct t
 /**
  * xe_bo_pin_external - pin an external BO
  * @bo: buffer object to be pinned
+ * @in_place: Pin in current placement, don't attempt to migrate.
  *
  * Pin an external (not tied to a VM, can be exported via dma-buf / prime FD)
  * BO. Unique call compared to xe_bo_pin as this function has it own set of
@@ -2273,7 +2276,7 @@ uint64_t vram_region_gpu_offset(struct t
  *
  * Returns 0 for success, negative error code otherwise.
  */
-int xe_bo_pin_external(struct xe_bo *bo)
+int xe_bo_pin_external(struct xe_bo *bo, bool in_place)
 {
 	struct xe_device *xe = xe_bo_device(bo);
 	int err;
@@ -2282,9 +2285,11 @@ int xe_bo_pin_external(struct xe_bo *bo)
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
@@ -2437,6 +2442,9 @@ int xe_bo_validate(struct xe_bo *bo, str
 	};
 	int ret;
 
+	if (xe_bo_is_pinned(bo))
+		return 0;
+
 	if (vm) {
 		lockdep_assert_held(&vm->lock);
 		xe_vm_assert_held(vm);
--- a/drivers/gpu/drm/xe/xe_bo.h
+++ b/drivers/gpu/drm/xe/xe_bo.h
@@ -201,7 +201,7 @@ static inline void xe_bo_unlock_vm_held(
 	}
 }
 
-int xe_bo_pin_external(struct xe_bo *bo);
+int xe_bo_pin_external(struct xe_bo *bo, bool in_place);
 int xe_bo_pin(struct xe_bo *bo);
 void xe_bo_unpin_external(struct xe_bo *bo);
 void xe_bo_unpin(struct xe_bo *bo);
--- a/drivers/gpu/drm/xe/xe_dma_buf.c
+++ b/drivers/gpu/drm/xe/xe_dma_buf.c
@@ -72,7 +72,7 @@ static int xe_dma_buf_pin(struct dma_buf
 		return ret;
 	}
 
-	ret = xe_bo_pin_external(bo);
+	ret = xe_bo_pin_external(bo, true);
 	xe_assert(xe, !ret);
 
 	return 0;




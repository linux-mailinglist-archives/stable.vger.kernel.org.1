Return-Path: <stable+bounces-93728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98ADA9D05DF
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF416B214E4
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381591DA618;
	Sun, 17 Nov 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bQODCgV7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7BA18054
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875844; cv=none; b=ul4A3Q2lckBqw6UcSu/bRIYGJ+zxlRFcNZlKMcPk44VyeJKCg9nasWmVs2h03t0aDdPIqIqqPetMu4NoEguQi1nip7/Y0CwNe/D9LcBJz1Ir0WF8jUM8xajKXIAfo/fKPBcsTJYPJ/neydCAWumRDYJW5sVgZANL9aFZ4/roJ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875844; c=relaxed/simple;
	bh=z34E9q1w3ZpSWcUDfoaFLsNCglefUbpIzaJr4Mg0ZUo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CIVfrsm9R/Cn4pb/uenc2/wpm+coe4TuNXr+MYB54CUF/QyzxBWFmEfjK8dc61wirxlXXFUorOYjqwVSri+32nB1YgTvdWASeEoDz4Y69DEOnYMVKGiQV/eh7rLcTtlNzfUsORpQ+V+g4XJy+uQsBK2c1nCYqHEm5M3qX8GEQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bQODCgV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09ACFC4CECD;
	Sun, 17 Nov 2024 20:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731875843;
	bh=z34E9q1w3ZpSWcUDfoaFLsNCglefUbpIzaJr4Mg0ZUo=;
	h=Subject:To:Cc:From:Date:From;
	b=bQODCgV74uiJz9EFXMgkNWF7JuRWmTHVmx1O/O6rJcbefVGnhpN5JzouymfX8YdPj
	 VJofxiSFFCQuraWiiRDOA89pXTEctShFoOPDmlpj6/16cGY7gToK0dkV0uP4VIYQMZ
	 E2+JAju3ip/RtcAKlHu4kwDY6cJsldCaCj2d5JlA=
Subject: FAILED: patch "[PATCH] drm/xe: improve hibernation on igpu" failed to apply to 6.11-stable tree
To: matthew.auld@intel.com,lucas.demarchi@intel.com,matthew.brost@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 21:36:58 +0100
Message-ID: <2024111758-jumbo-neon-1b3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 46f1f4b0f3c2a2dff9887de7c66ccc7ef482bd83
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111758-jumbo-neon-1b3c@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 46f1f4b0f3c2a2dff9887de7c66ccc7ef482bd83 Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Fri, 1 Nov 2024 17:01:57 +0000
Subject: [PATCH] drm/xe: improve hibernation on igpu

The GGTT looks to be stored inside stolen memory on igpu which is not
treated as normal RAM.  The core kernel skips this memory range when
creating the hibernation image, therefore when coming back from
hibernation the GGTT programming is lost. This seems to cause issues
with broken resume where GuC FW fails to load:

[drm] *ERROR* GT0: load failed: status = 0x400000A0, time = 10ms, freq = 1250MHz (req 1300MHz), done = -1
[drm] *ERROR* GT0: load failed: status: Reset = 0, BootROM = 0x50, UKernel = 0x00, MIA = 0x00, Auth = 0x01
[drm] *ERROR* GT0: firmware signature verification failed
[drm] *ERROR* CRITICAL: Xe has declared device 0000:00:02.0 as wedged.

Current GGTT users are kernel internal and tracked as pinned, so it
should be possible to hook into the existing save/restore logic that we
use for dgpu, where the actual evict is skipped but on restore we
importantly restore the GGTT programming.  This has been confirmed to
fix hibernation on at least ADL and MTL, though likely all igpu
platforms are affected.

This also means we have a hole in our testing, where the existing s4
tests only really test the driver hooks, and don't go as far as actually
rebooting and restoring from the hibernation image and in turn powering
down RAM (and therefore losing the contents of stolen).

v2 (Brost)
 - Remove extra newline and drop unnecessary parentheses.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/3275
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241101170156.213490-2-matthew.auld@intel.com
(cherry picked from commit f2a6b8e396666d97ada8e8759dfb6a69d8df6380)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 74f68289f74c..2a093540354e 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -948,7 +948,10 @@ int xe_bo_restore_pinned(struct xe_bo *bo)
 	if (WARN_ON(!xe_bo_is_pinned(bo)))
 		return -EINVAL;
 
-	if (WARN_ON(xe_bo_is_vram(bo) || !bo->ttm.ttm))
+	if (WARN_ON(xe_bo_is_vram(bo)))
+		return -EINVAL;
+
+	if (WARN_ON(!bo->ttm.ttm && !xe_bo_is_stolen(bo)))
 		return -EINVAL;
 
 	if (!mem_type_is_vram(place->mem_type))
@@ -1723,6 +1726,7 @@ int xe_bo_pin_external(struct xe_bo *bo)
 
 int xe_bo_pin(struct xe_bo *bo)
 {
+	struct ttm_place *place = &bo->placements[0];
 	struct xe_device *xe = xe_bo_device(bo);
 	int err;
 
@@ -1753,8 +1757,6 @@ int xe_bo_pin(struct xe_bo *bo)
 	 */
 	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
 	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
-		struct ttm_place *place = &(bo->placements[0]);
-
 		if (mem_type_is_vram(place->mem_type)) {
 			xe_assert(xe, place->flags & TTM_PL_FLAG_CONTIGUOUS);
 
@@ -1762,13 +1764,12 @@ int xe_bo_pin(struct xe_bo *bo)
 				       vram_region_gpu_offset(bo->ttm.resource)) >> PAGE_SHIFT;
 			place->lpfn = place->fpfn + (bo->size >> PAGE_SHIFT);
 		}
+	}
 
-		if (mem_type_is_vram(place->mem_type) ||
-		    bo->flags & XE_BO_FLAG_GGTT) {
-			spin_lock(&xe->pinned.lock);
-			list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
-			spin_unlock(&xe->pinned.lock);
-		}
+	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
+		spin_lock(&xe->pinned.lock);
+		list_add_tail(&bo->pinned_link, &xe->pinned.kernel_bo_present);
+		spin_unlock(&xe->pinned.lock);
 	}
 
 	ttm_bo_pin(&bo->ttm);
@@ -1816,24 +1817,18 @@ void xe_bo_unpin_external(struct xe_bo *bo)
 
 void xe_bo_unpin(struct xe_bo *bo)
 {
+	struct ttm_place *place = &bo->placements[0];
 	struct xe_device *xe = xe_bo_device(bo);
 
 	xe_assert(xe, !bo->ttm.base.import_attach);
 	xe_assert(xe, xe_bo_is_pinned(bo));
 
-	if (IS_DGFX(xe) && !(IS_ENABLED(CONFIG_DRM_XE_DEBUG) &&
-	    bo->flags & XE_BO_FLAG_INTERNAL_TEST)) {
-		struct ttm_place *place = &(bo->placements[0]);
-
-		if (mem_type_is_vram(place->mem_type) ||
-		    bo->flags & XE_BO_FLAG_GGTT) {
-			spin_lock(&xe->pinned.lock);
-			xe_assert(xe, !list_empty(&bo->pinned_link));
-			list_del_init(&bo->pinned_link);
-			spin_unlock(&xe->pinned.lock);
-		}
+	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
+		spin_lock(&xe->pinned.lock);
+		xe_assert(xe, !list_empty(&bo->pinned_link));
+		list_del_init(&bo->pinned_link);
+		spin_unlock(&xe->pinned.lock);
 	}
-
 	ttm_bo_unpin(&bo->ttm);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_bo_evict.c b/drivers/gpu/drm/xe/xe_bo_evict.c
index 32043e1e5a86..b01bc20eb90b 100644
--- a/drivers/gpu/drm/xe/xe_bo_evict.c
+++ b/drivers/gpu/drm/xe/xe_bo_evict.c
@@ -34,9 +34,6 @@ int xe_bo_evict_all(struct xe_device *xe)
 	u8 id;
 	int ret;
 
-	if (!IS_DGFX(xe))
-		return 0;
-
 	/* User memory */
 	for (mem_type = XE_PL_VRAM0; mem_type <= XE_PL_VRAM1; ++mem_type) {
 		struct ttm_resource_manager *man =
@@ -125,9 +122,6 @@ int xe_bo_restore_kernel(struct xe_device *xe)
 	struct xe_bo *bo;
 	int ret;
 
-	if (!IS_DGFX(xe))
-		return 0;
-
 	spin_lock(&xe->pinned.lock);
 	for (;;) {
 		bo = list_first_entry_or_null(&xe->pinned.evicted,



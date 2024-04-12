Return-Path: <stable+bounces-39265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E40D8A27CA
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 09:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2CC1F254FF
	for <lists+stable@lfdr.de>; Fri, 12 Apr 2024 07:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F33747A53;
	Fri, 12 Apr 2024 07:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bh0VYYFi"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33154CDF9
	for <stable@vger.kernel.org>; Fri, 12 Apr 2024 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712906119; cv=none; b=mC6o6FBmpTkXhKzSOmTzCpivNRUnIMbWE99uwiOUvRa83eHUZFXyGIdysBynzo2yRuNofibt2hfwswqNb0j1n2ErosAZdRdho6Aur9FZokO0MFXcKgh5SYCpz/Ho+8TxMONT5Yg8wdxJYa/oNAlw6joceGyDRp6/JNQ4Xt29JFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712906119; c=relaxed/simple;
	bh=31vkEXsSKC2rH3gPKy/8HeRb27ArX1kPWFDPshZ4Mp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oH2/lV+oGlS4GbakYC+gAC5S3O0EdfhtkXyKey9DpyGHcRtK8p4nw+UI5rralT0Wpk6ocU2SLn/2XyRjDaYF5vcxFTYf04jHIdWd28d0bOQKbip5At7azKgkI6VzR+ITGGAx4SiWzdtpTblvOgbaW0P/kMzrRJnZfl5PNDjTVqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bh0VYYFi; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712906118; x=1744442118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=31vkEXsSKC2rH3gPKy/8HeRb27ArX1kPWFDPshZ4Mp8=;
  b=bh0VYYFi5h7eARXoWydb00dFRvFHIJuUlOS+yshCKQTH5aNU4TyFUYX2
   XQV137+dE3P82IdGKMQfj1BGtExAIUvNFgk7BUEUhbAd2RHlxeJfV+CXn
   pT4Jn1sdJQpbSqrgSvZh/7BmJu4AJ7350yqYIiEwHVzqhtuN4MkpY1Ns8
   SDB38VdDxpR7BP2gl6qtyRLf6zf2s49qxbirwGFACLomF67EmWyc8V3Mt
   YyJjV5gAHq0gw0N3m0WSHzebrqlkCPJcNDL9db8fJ1ruBTyDNpQhqRpSO
   fLYks5t+47Mi2fDyjVXKRHszgqfvBANhzqmxQxu362MfuAKG/qX9tkLK+
   A==;
X-CSE-ConnectionGUID: zis3qmJXQ1KP7+jCxx1qKA==
X-CSE-MsgGUID: b1RktnfSRne+mhuEshcgTQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="18906498"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="18906498"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 00:15:17 -0700
X-CSE-ConnectionGUID: QbraRSBDSVCUMkwb9vAc3A==
X-CSE-MsgGUID: Zlo6iTpwRDGDEKsTbjAsLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21200041"
Received: from amuszyns-mobl1.ger.corp.intel.com (HELO jkrzyszt-mobl2.intranet) ([10.213.19.168])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 00:15:14 -0700
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: [PATCH 6.7.y] drm/i915/vma: Fix UAF on destroy against retire race
Date: Fri, 12 Apr 2024 09:12:30 +0200
Message-ID: <20240412071500.275976-2-janusz.krzysztofik@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024033027-expensive-footage-f3ea@gregkh>
References: <2024033027-expensive-footage-f3ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Object debugging tools were sporadically reporting illegal attempts to
free a still active i915 VMA object when parking a GT believed to be idle.

[161.359441] ODEBUG: free active (active state 0) object: ffff88811643b958 object type: i915_active hint: __i915_vma_active+0x0/0x50 [i915]
[161.360082] WARNING: CPU: 5 PID: 276 at lib/debugobjects.c:514 debug_print_object+0x80/0xb0
...
[161.360304] CPU: 5 PID: 276 Comm: kworker/5:2 Not tainted 6.5.0-rc1-CI_DRM_13375-g003f860e5577+ #1
[161.360314] Hardware name: Intel Corporation Rocket Lake Client Platform/RocketLake S UDIMM 6L RVP, BIOS RKLSFWI1.R00.3173.A03.2204210138 04/21/2022
[161.360322] Workqueue: i915-unordered __intel_wakeref_put_work [i915]
[161.360592] RIP: 0010:debug_print_object+0x80/0xb0
...
[161.361347] debug_object_free+0xeb/0x110
[161.361362] i915_active_fini+0x14/0x130 [i915]
[161.361866] release_references+0xfe/0x1f0 [i915]
[161.362543] i915_vma_parked+0x1db/0x380 [i915]
[161.363129] __gt_park+0x121/0x230 [i915]
[161.363515] ____intel_wakeref_put_last+0x1f/0x70 [i915]

That has been tracked down to be happening when another thread is
deactivating the VMA inside __active_retire() helper, after the VMA's
active counter has been already decremented to 0, but before deactivation
of the VMA's object is reported to the object debugging tool.

We could prevent from that race by serializing i915_active_fini() with
__active_retire() via ref->tree_lock, but that wouldn't stop the VMA from
being used, e.g. from __i915_vma_retire() called at the end of
__active_retire(), after that VMA has been already freed by a concurrent
i915_vma_destroy() on return from the i915_active_fini().  Then, we should
rather fix the issue at the VMA level, not in i915_active.

Since __i915_vma_parked() is called from __gt_park() on last put of the
GT's wakeref, the issue could be addressed by holding the GT wakeref long
enough for __active_retire() to complete before that wakeref is released
and the GT parked.

I believe the issue was introduced by commit d93939730347 ("drm/i915:
Remove the vma refcount") which moved a call to i915_active_fini() from
a dropped i915_vma_release(), called on last put of the removed VMA kref,
to i915_vma_parked() processing path called on last put of a GT wakeref.
However, its visibility to the object debugging tool was suppressed by a
bug in i915_active that was fixed two weeks later with commit e92eb246feb9
("drm/i915/active: Fix missing debug object activation").

A VMA associated with a request doesn't acquire a GT wakeref by itself.
Instead, it depends on a wakeref held directly by the request's active
intel_context for a GT associated with its VM, and indirectly on that
intel_context's engine wakeref if the engine belongs to the same GT as the
VMA's VM.  Those wakerefs are released asynchronously to VMA deactivation.

Fix the issue by getting a wakeref for the VMA's GT when activating it,
and putting that wakeref only after the VMA is deactivated.  However,
exclude global GTT from that processing path, otherwise the GPU never goes
idle.  Since __i915_vma_retire() may be called from atomic contexts, use
async variant of wakeref put.  Also, to avoid circular locking dependency,
take care of acquiring the wakeref before VM mutex when both are needed.

v7: Add inline comments with justifications for:
    - using untracked variants of intel_gt_pm_get/put() (Nirmoy),
    - using async variant of _put(),
    - not getting the wakeref in case of a global GTT,
    - always getting the first wakeref outside vm->mutex.
v6: Since __i915_vma_active/retire() callbacks are not serialized, storing
    a wakeref tracking handle inside struct i915_vma is not safe, and
    there is no other good place for that.  Use untracked variants of
    intel_gt_pm_get/put_async().
v5: Replace "tile" with "GT" across commit description (Rodrigo),
  - avoid mentioning multi-GT case in commit description (Rodrigo),
  - explain why we need to take a temporary wakeref unconditionally inside
    i915_vma_pin_ww() (Rodrigo).
v4: Refresh on top of commit 5e4e06e4087e ("drm/i915: Track gt pm
    wakerefs") (Andi),
  - for more easy backporting, split out removal of former insufficient
    workarounds and move them to separate patches (Nirmoy).
  - clean up commit message and description a bit.
v3: Identify root cause more precisely, and a commit to blame,
  - identify and drop former workarounds,
  - update commit message and description.
v2: Get the wakeref before VM mutex to avoid circular locking dependency,
  - drop questionable Fixes: tag.

Fixes: d93939730347 ("drm/i915: Remove the vma refcount")
Closes: https://gitlab.freedesktop.org/drm/intel/issues/8875
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: stable@vger.kernel.org # v5.19+
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240305143747.335367-6-janusz.krzysztofik@linux.intel.com
(cherry picked from commit f3c71b2ded5c4367144a810ef25f998fd1d6c381)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit 0e45882ca829b26b915162e8e86dbb1095768e9e)
Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
---
 drivers/gpu/drm/i915/i915_vma.c | 50 ++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_vma.c b/drivers/gpu/drm/i915/i915_vma.c
index d09aad34ba37f..b70715b1411d6 100644
--- a/drivers/gpu/drm/i915/i915_vma.c
+++ b/drivers/gpu/drm/i915/i915_vma.c
@@ -34,6 +34,7 @@
 #include "gt/intel_engine.h"
 #include "gt/intel_engine_heartbeat.h"
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_pm.h"
 #include "gt/intel_gt_requests.h"
 #include "gt/intel_tlb.h"
 
@@ -103,12 +104,42 @@ static inline struct i915_vma *active_to_vma(struct i915_active *ref)
 
 static int __i915_vma_active(struct i915_active *ref)
 {
-	return i915_vma_tryget(active_to_vma(ref)) ? 0 : -ENOENT;
+	struct i915_vma *vma = active_to_vma(ref);
+
+	if (!i915_vma_tryget(vma))
+		return -ENOENT;
+
+	/*
+	 * Exclude global GTT VMA from holding a GT wakeref
+	 * while active, otherwise GPU never goes idle.
+	 */
+	if (!i915_vma_is_ggtt(vma)) {
+		/*
+		 * Since we and our _retire() counterpart can be
+		 * called asynchronously, storing a wakeref tracking
+		 * handle inside struct i915_vma is not safe, and
+		 * there is no other good place for that.  Hence,
+		 * use untracked variants of intel_gt_pm_get/put().
+		 */
+		intel_gt_pm_get_untracked(vma->vm->gt);
+	}
+
+	return 0;
 }
 
 static void __i915_vma_retire(struct i915_active *ref)
 {
-	i915_vma_put(active_to_vma(ref));
+	struct i915_vma *vma = active_to_vma(ref);
+
+	if (!i915_vma_is_ggtt(vma)) {
+		/*
+		 * Since we can be called from atomic contexts,
+		 * use an async variant of intel_gt_pm_put().
+		 */
+		intel_gt_pm_put_async_untracked(vma->vm->gt);
+	}
+
+	i915_vma_put(vma);
 }
 
 static struct i915_vma *
@@ -1404,7 +1435,7 @@ int i915_vma_pin_ww(struct i915_vma *vma, struct i915_gem_ww_ctx *ww,
 	struct i915_vma_work *work = NULL;
 	struct dma_fence *moving = NULL;
 	struct i915_vma_resource *vma_res = NULL;
-	intel_wakeref_t wakeref = 0;
+	intel_wakeref_t wakeref;
 	unsigned int bound;
 	int err;
 
@@ -1424,8 +1455,14 @@ int i915_vma_pin_ww(struct i915_vma *vma, struct i915_gem_ww_ctx *ww,
 	if (err)
 		return err;
 
-	if (flags & PIN_GLOBAL)
-		wakeref = intel_runtime_pm_get(&vma->vm->i915->runtime_pm);
+	/*
+	 * In case of a global GTT, we must hold a runtime-pm wakeref
+	 * while global PTEs are updated.  In other cases, we hold
+	 * the rpm reference while the VMA is active.  Since runtime
+	 * resume may require allocations, which are forbidden inside
+	 * vm->mutex, get the first rpm wakeref outside of the mutex.
+	 */
+	wakeref = intel_runtime_pm_get(&vma->vm->i915->runtime_pm);
 
 	if (flags & vma->vm->bind_async_flags) {
 		/* lock VM */
@@ -1561,8 +1598,7 @@ int i915_vma_pin_ww(struct i915_vma *vma, struct i915_gem_ww_ctx *ww,
 	if (work)
 		dma_fence_work_commit_imm(&work->base);
 err_rpm:
-	if (wakeref)
-		intel_runtime_pm_put(&vma->vm->i915->runtime_pm, wakeref);
+	intel_runtime_pm_put(&vma->vm->i915->runtime_pm, wakeref);
 
 	if (moving)
 		dma_fence_put(moving);
-- 
2.44.0



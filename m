Return-Path: <stable+bounces-94644-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 534949D651E
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 22:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFB67B22DC7
	for <lists+stable@lfdr.de>; Fri, 22 Nov 2024 21:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8198B186612;
	Fri, 22 Nov 2024 21:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XlH8kI0t"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE7818BC0D
	for <stable@vger.kernel.org>; Fri, 22 Nov 2024 21:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732309666; cv=none; b=mMMYl3umnxJSrnrN7yONBR4B76dJhm3D7jAi3s0V/hMoxpuiz1uQyKnubGVSGMarCyIm8Itpn6RftaVbXfR+iB1poMySrcnugxil2ZhZRualnuFV9goj1BQn1zYrIR0kVWQYXbTS4SKxclGtdUdTOVQK7nJz85uotkjTO7VLFIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732309666; c=relaxed/simple;
	bh=jrkGSAdxBz6zwkwuui6q5+n4q6IYCgwuHd0De/eG0i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2kRwEfLp/xWOT09qKqT3C0h3VOq413y8jA2Ltfl+KCkR6cyzyQV3yxojxGHB3O1ogVxjGsg2BAoSeSiXYOgsyd+pWsXMNi9SDMRhYukChFfcJXSnuoGYD5wQWlnYdRDRzGKZ/h1Pdu91GPwSWqshrCEoPN9l4wyJszfDifJdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XlH8kI0t; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732309664; x=1763845664;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jrkGSAdxBz6zwkwuui6q5+n4q6IYCgwuHd0De/eG0i4=;
  b=XlH8kI0tCrya7/4qlhuuW8Uqy6CQATXEXEyBr5Pp5/uZT+Xb8RvB57Uh
   oWlXw7J7KYGHwZK3IBSm0PpvwLps688uQ8+k6d1A+HDVVypRDjNeBadYp
   mreAb51JURT8vLZbcPjgSuqW3BhiUZSq5eTrLri5dvzXVXRJkB2Q8/RqI
   u5Z5jTLRBUDpLX53YGhY4ZKh30r3CwcfwUf9qazIDliMNw6W/TT0mYvw9
   ta5f1A27bYE1ZNwVtVtG9HI5VL+oBPU3MfYJP8+c9ah6F+B5klzGm47LF
   3I1D2GbZ8hAtiyrl8xKSvwFkmhRqWYJKnwoSE3BEWbiv/28vr6B41H/oL
   g==;
X-CSE-ConnectionGUID: JianagN/SuyPSjjR3OXgmg==
X-CSE-MsgGUID: UsrTjPe1SLuf1zX6pHDKJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43878261"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="43878261"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:40 -0800
X-CSE-ConnectionGUID: epuK0tOaTTOOhWdKFoexiQ==
X-CSE-MsgGUID: GUIy8qMcRNCE9bq5aHUVfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="95457203"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.196])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 13:07:40 -0800
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: stable@vger.kernel.org
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Akshata Jahagirdar <akshata.jahagirdar@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 07/31] drm/xe/migrate: Add kunit to test clear functionality
Date: Fri, 22 Nov 2024 13:06:55 -0800
Message-ID: <20241122210719.213373-8-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122210719.213373-1-lucas.demarchi@intel.com>
References: <20241122210719.213373-1-lucas.demarchi@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Akshata Jahagirdar <akshata.jahagirdar@intel.com>

commit 54f07cfc016226c3959e0b3b7ed306124d986ce4 upstream.

This test verifies if the main and ccs data are cleared during bo creation.
The motivation to use Kunit instead of IGT is that, although we can verify
whether the data is zero following bo creation,
we cannot confirm whether the zero value after bo creation is the result of
our clear function or simply because the initial data present was zero.

v2: Updated the mutex_lock and unlock logic,
    Changed out_unlock to out_put. (Matt)

v3: Added missing dma_fence_put(). (Nirmoy)

v4: Rebase.

v5: Add missing bo_put(), bo_unlock() calls. (Matt Auld)

Signed-off-by: Akshata Jahagirdar <akshata.jahagirdar@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Acked-by: Nirmoy Das <nirmoy.das@intel.com>
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/c07603439b88cfc99e78c0e2069327e65d5aa87d.1721250309.git.akshata.jahagirdar@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 drivers/gpu/drm/xe/tests/xe_migrate.c | 276 ++++++++++++++++++++++++++
 1 file changed, 276 insertions(+)

diff --git a/drivers/gpu/drm/xe/tests/xe_migrate.c b/drivers/gpu/drm/xe/tests/xe_migrate.c
index 0de0e0c666230..353b908845f7d 100644
--- a/drivers/gpu/drm/xe/tests/xe_migrate.c
+++ b/drivers/gpu/drm/xe/tests/xe_migrate.c
@@ -358,8 +358,284 @@ static void xe_migrate_sanity_kunit(struct kunit *test)
 	xe_call_for_each_device(migrate_test_run_device);
 }
 
+static struct dma_fence *blt_copy(struct xe_tile *tile,
+				  struct xe_bo *src_bo, struct xe_bo *dst_bo,
+				  bool copy_only_ccs, const char *str, struct kunit *test)
+{
+	struct xe_gt *gt = tile->primary_gt;
+	struct xe_migrate *m = tile->migrate;
+	struct xe_device *xe = gt_to_xe(gt);
+	struct dma_fence *fence = NULL;
+	u64 size = src_bo->size;
+	struct xe_res_cursor src_it, dst_it;
+	struct ttm_resource *src = src_bo->ttm.resource, *dst = dst_bo->ttm.resource;
+	u64 src_L0_ofs, dst_L0_ofs;
+	u32 src_L0_pt, dst_L0_pt;
+	u64 src_L0, dst_L0;
+	int err;
+	bool src_is_vram = mem_type_is_vram(src->mem_type);
+	bool dst_is_vram = mem_type_is_vram(dst->mem_type);
+
+	if (!src_is_vram)
+		xe_res_first_sg(xe_bo_sg(src_bo), 0, size, &src_it);
+	else
+		xe_res_first(src, 0, size, &src_it);
+
+	if (!dst_is_vram)
+		xe_res_first_sg(xe_bo_sg(dst_bo), 0, size, &dst_it);
+	else
+		xe_res_first(dst, 0, size, &dst_it);
+
+	while (size) {
+		u32 batch_size = 2; /* arb_clear() + MI_BATCH_BUFFER_END */
+		struct xe_sched_job *job;
+		struct xe_bb *bb;
+		u32 flush_flags = 0;
+		u32 update_idx;
+		u32 avail_pts = max_mem_transfer_per_pass(xe) / LEVEL0_PAGE_TABLE_ENCODE_SIZE;
+
+		src_L0 = xe_migrate_res_sizes(m, &src_it);
+		dst_L0 = xe_migrate_res_sizes(m, &dst_it);
+
+		src_L0 = min(src_L0, dst_L0);
+
+		batch_size += pte_update_size(m, src_is_vram, src_is_vram, src, &src_it, &src_L0,
+					      &src_L0_ofs, &src_L0_pt, 0, 0,
+					      avail_pts);
+
+		batch_size += pte_update_size(m, dst_is_vram, dst_is_vram, dst, &dst_it, &src_L0,
+					      &dst_L0_ofs, &dst_L0_pt, 0,
+					      avail_pts, avail_pts);
+
+		/* Add copy commands size here */
+		batch_size += ((copy_only_ccs) ? 0 : EMIT_COPY_DW) +
+			((xe_device_has_flat_ccs(xe) && copy_only_ccs) ? EMIT_COPY_CCS_DW : 0);
+
+		bb = xe_bb_new(gt, batch_size, xe->info.has_usm);
+		if (IS_ERR(bb)) {
+			err = PTR_ERR(bb);
+			goto err_sync;
+		}
+
+		if (src_is_vram)
+			xe_res_next(&src_it, src_L0);
+		else
+			emit_pte(m, bb, src_L0_pt, src_is_vram, false,
+				 &src_it, src_L0, src);
+
+		if (dst_is_vram)
+			xe_res_next(&dst_it, src_L0);
+		else
+			emit_pte(m, bb, dst_L0_pt, dst_is_vram, false,
+				 &dst_it, src_L0, dst);
+
+		bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
+		update_idx = bb->len;
+		if (!copy_only_ccs)
+			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
+
+		if (copy_only_ccs)
+			flush_flags = xe_migrate_ccs_copy(m, bb, src_L0_ofs,
+							  src_is_vram, dst_L0_ofs,
+							  dst_is_vram, src_L0, dst_L0_ofs,
+							  copy_only_ccs);
+
+		job = xe_bb_create_migration_job(m->q, bb,
+						 xe_migrate_batch_base(m, xe->info.has_usm),
+						 update_idx);
+		if (IS_ERR(job)) {
+			err = PTR_ERR(job);
+			goto err;
+		}
+
+		xe_sched_job_add_migrate_flush(job, flush_flags);
+
+		mutex_lock(&m->job_mutex);
+		xe_sched_job_arm(job);
+		dma_fence_put(fence);
+		fence = dma_fence_get(&job->drm.s_fence->finished);
+		xe_sched_job_push(job);
+
+		dma_fence_put(m->fence);
+		m->fence = dma_fence_get(fence);
+
+		mutex_unlock(&m->job_mutex);
+
+		xe_bb_free(bb, fence);
+		size -= src_L0;
+		continue;
+
+err:
+		xe_bb_free(bb, NULL);
+
+err_sync:
+		if (fence) {
+			dma_fence_wait(fence, false);
+			dma_fence_put(fence);
+		}
+		return ERR_PTR(err);
+	}
+
+	return fence;
+}
+
+static void test_clear(struct xe_device *xe, struct xe_tile *tile,
+		       struct xe_bo *sys_bo, struct xe_bo *vram_bo, struct kunit *test)
+{
+	struct dma_fence *fence;
+	u64 expected, retval;
+
+	expected = 0xd0d0d0d0d0d0d0d0;
+	xe_map_memset(xe, &sys_bo->vmap, 0, 0xd0, sys_bo->size);
+
+	fence = blt_copy(tile, sys_bo, vram_bo, false, "Blit copy from sysmem to vram", test);
+	if (!sanity_fence_failed(xe, fence, "Blit copy from sysmem to vram", test)) {
+		retval = xe_map_rd(xe, &vram_bo->vmap, 0, u64);
+		if (retval == expected)
+			KUNIT_FAIL(test, "Sanity check failed: VRAM must have compressed value\n");
+	}
+	dma_fence_put(fence);
+
+	fence = blt_copy(tile, vram_bo, sys_bo, false, "Blit copy from vram to sysmem", test);
+	if (!sanity_fence_failed(xe, fence, "Blit copy from vram to sysmem", test)) {
+		retval = xe_map_rd(xe, &sys_bo->vmap, 0, u64);
+		check(retval, expected, "Decompressed value must be equal to initial value", test);
+		retval = xe_map_rd(xe, &sys_bo->vmap, sys_bo->size - 8, u64);
+		check(retval, expected, "Decompressed value must be equal to initial value", test);
+	}
+	dma_fence_put(fence);
+
+	kunit_info(test, "Clear vram buffer object\n");
+	expected = 0x0000000000000000;
+	fence = xe_migrate_clear(tile->migrate, vram_bo, vram_bo->ttm.resource);
+	if (sanity_fence_failed(xe, fence, "Clear vram_bo", test))
+		return;
+	dma_fence_put(fence);
+
+	fence = blt_copy(tile, vram_bo, sys_bo,
+			 false, "Blit copy from vram to sysmem", test);
+	if (!sanity_fence_failed(xe, fence, "Clear main buffer data", test)) {
+		retval = xe_map_rd(xe, &sys_bo->vmap, 0, u64);
+		check(retval, expected, "Clear main buffer first value", test);
+		retval = xe_map_rd(xe, &sys_bo->vmap, sys_bo->size - 8, u64);
+		check(retval, expected, "Clear main buffer last value", test);
+	}
+	dma_fence_put(fence);
+
+	fence = blt_copy(tile, vram_bo, sys_bo,
+			 true, "Blit surf copy from vram to sysmem", test);
+	if (!sanity_fence_failed(xe, fence, "Clear ccs buffer data", test)) {
+		retval = xe_map_rd(xe, &sys_bo->vmap, 0, u64);
+		check(retval, expected, "Clear ccs data first value", test);
+		retval = xe_map_rd(xe, &sys_bo->vmap, sys_bo->size - 8, u64);
+		check(retval, expected, "Clear ccs data last value", test);
+	}
+	dma_fence_put(fence);
+}
+
+static void validate_ccs_test_run_tile(struct xe_device *xe, struct xe_tile *tile,
+				       struct kunit *test)
+{
+	struct xe_bo *sys_bo, *vram_bo;
+	unsigned int bo_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile);
+	long ret;
+
+	sys_bo = xe_bo_create_user(xe, NULL, NULL, SZ_4M,
+				   DRM_XE_GEM_CPU_CACHING_WC, ttm_bo_type_device,
+				   XE_BO_FLAG_SYSTEM | XE_BO_FLAG_NEEDS_CPU_ACCESS);
+
+	if (IS_ERR(sys_bo)) {
+		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
+			   PTR_ERR(sys_bo));
+		return;
+	}
+
+	xe_bo_lock(sys_bo, false);
+	ret = xe_bo_validate(sys_bo, NULL, false);
+	if (ret) {
+		KUNIT_FAIL(test, "Failed to validate system bo for: %li\n", ret);
+		goto free_sysbo;
+	}
+
+	ret = xe_bo_vmap(sys_bo);
+	if (ret) {
+		KUNIT_FAIL(test, "Failed to vmap system bo: %li\n", ret);
+		goto free_sysbo;
+	}
+	xe_bo_unlock(sys_bo);
+
+	vram_bo = xe_bo_create_user(xe, NULL, NULL, SZ_4M, DRM_XE_GEM_CPU_CACHING_WC,
+				    ttm_bo_type_device, bo_flags | XE_BO_FLAG_NEEDS_CPU_ACCESS);
+	if (IS_ERR(vram_bo)) {
+		KUNIT_FAIL(test, "xe_bo_create() failed with err=%ld\n",
+			   PTR_ERR(vram_bo));
+		return;
+	}
+
+	xe_bo_lock(vram_bo, false);
+	ret = xe_bo_validate(vram_bo, NULL, false);
+	if (ret) {
+		KUNIT_FAIL(test, "Failed to validate vram bo for: %li\n", ret);
+		goto free_vrambo;
+	}
+
+	ret = xe_bo_vmap(vram_bo);
+	if (ret) {
+		KUNIT_FAIL(test, "Failed to vmap vram bo: %li\n", ret);
+		goto free_vrambo;
+	}
+
+	test_clear(xe, tile, sys_bo, vram_bo, test);
+	xe_bo_unlock(vram_bo);
+
+	xe_bo_lock(vram_bo, false);
+	xe_bo_vunmap(vram_bo);
+	xe_bo_unlock(vram_bo);
+
+	xe_bo_lock(sys_bo, false);
+	xe_bo_vunmap(sys_bo);
+	xe_bo_unlock(sys_bo);
+free_vrambo:
+	xe_bo_put(vram_bo);
+free_sysbo:
+	xe_bo_put(sys_bo);
+}
+
+static int validate_ccs_test_run_device(struct xe_device *xe)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct xe_tile *tile;
+	int id;
+
+	if (!xe_device_has_flat_ccs(xe)) {
+		kunit_info(test, "Skipping non-flat-ccs device.\n");
+		return 0;
+	}
+
+	if (!(GRAPHICS_VER(xe) >= 20 && IS_DGFX(xe))) {
+		kunit_info(test, "Skipping non-xe2 discrete device %s.\n",
+			   dev_name(xe->drm.dev));
+		return 0;
+	}
+
+	xe_pm_runtime_get(xe);
+
+	for_each_tile(tile, xe, id)
+		validate_ccs_test_run_tile(xe, tile, test);
+
+	xe_pm_runtime_put(xe);
+
+	return 0;
+}
+
+static void xe_validate_ccs_kunit(struct kunit *test)
+{
+	xe_call_for_each_device(validate_ccs_test_run_device);
+}
+
 static struct kunit_case xe_migrate_tests[] = {
 	KUNIT_CASE(xe_migrate_sanity_kunit),
+	KUNIT_CASE(xe_validate_ccs_kunit),
 	{}
 };
 
-- 
2.47.0



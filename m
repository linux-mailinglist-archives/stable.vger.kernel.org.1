Return-Path: <stable+bounces-67493-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8498995073D
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9CD283460
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63BE19B3DD;
	Tue, 13 Aug 2024 14:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIZoYOgx"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDB53A8CE
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558310; cv=none; b=cj3eN8GYqEDWmANRabqWwj9B5jBIROZUeMHFkRFJNRWZ3UMhyXmXLo8dOYc6bdfDLnSRBnCAHhigM8DgUViT6Brm7BBh2cT1NRaulS0wo4r8jL3lXxL6huWk0NnrtsmITZtJ3LgrQjhQW1ZOb0NjDWK9PFZUCrUCnjscBEIaeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558310; c=relaxed/simple;
	bh=qmDTKDrBnKCOG9en881x7qpNLaU5Au7Aj5HyXMVWqts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgt1zp91WTnl7EihBen7KOKMEp+YKcfHoGfkpz9yviRy6MBMRTKwu4Ee/jZLT57m7/JvfUpXCey/wGFzrXXnOInKbBWXaP4OEy5JBFt7MJcwv1E9nqW9+5Ex4NiVkQAwDgDcI21fPPmWZz408itHtST2fiRxuRRPe2F7viGXFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIZoYOgx; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723558308; x=1755094308;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qmDTKDrBnKCOG9en881x7qpNLaU5Au7Aj5HyXMVWqts=;
  b=UIZoYOgxZpPI/Nghkb7w2v017SXJaSM5ofDRcqc4R/wCtvevDuRmkYa+
   0EfqSJ6MkD3rgvYgLP6cpgdee6ioerCgeRJd1hL6csYRvUTOHd7dn7Qrf
   WNgOmAJcglL47AP0mHAnjb84EUtU3NGwajpNT8KLomKmDMMCSj4nK7IbX
   IGD+whO9eG/w9Vt5SDfNGq3n46VhLFkFn2TInaB0j3kazN3ivpJGjtnTZ
   kUYGWkwys746vhjIDWsoprNy058ItVYuTX8HjsNGR++98AOC8IOgUK0fv
   IGJ5+EyDJuLRmGXfF26sYvqHmhdK9lYOP5hPhwrMGov+Hvulvnll79lX0
   Q==;
X-CSE-ConnectionGUID: LHv7IpYNSP2Ki4merL/rJA==
X-CSE-MsgGUID: xaI1iitdQ6mHv9MhoA0rXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="33128710"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="33128710"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:11:48 -0700
X-CSE-ConnectionGUID: JT3hbogpTTOMV4DgZnwiRA==
X-CSE-MsgGUID: BULwqVsuR/eEPPoXY9P3nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="58764822"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO intel.com) ([10.245.246.4])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:11:45 -0700
From: Andi Shyti <andi.shyti@linux.intel.com>
To: stable@vger.kernel.org
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	Jann Horn <jannh@google.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <Jonathan.cavitt@intel.com>
Subject: [PATCH 5.4.y] drm/i915/gem: Fix Virtual Memory mapping boundaries calculation
Date: Tue, 13 Aug 2024 16:11:17 +0200
Message-ID: <20240813141117.25002-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081221-moisture-vaseline-cb8b@gregkh>
References: <2024081221-moisture-vaseline-cb8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 8bdd9ef7e9b1b2a73e394712b72b22055e0e26c3 upstream.

Calculating the size of the mapped area as the lesser value
between the requested size and the actual size does not consider
the partial mapping offset. This can cause page fault access.

Fix the calculation of the starting and ending addresses, the
total size is now deduced from the difference between the end and
start addresses.

Additionally, the calculations have been rewritten in a clearer
and more understandable form.

Fixes: c58305af1835 ("drm/i915: Use remap_io_mapping() to prefault all PTE in a single pass")
Reported-by: Jann Horn <jannh@google.com>
Co-developed-by: Chris Wilson <chris.p.wilson@linux.intel.com>
Signed-off-by: Chris Wilson <chris.p.wilson@linux.intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: <stable@vger.kernel.org> # v4.9+
Reviewed-by: Jann Horn <jannh@google.com>
Reviewed-by: Jonathan Cavitt <Jonathan.cavitt@intel.com>
[Joonas: Add Requires: tag]
Requires: 60a2066c5005 ("drm/i915/gem: Adjust vma offset for framebuffer mmap offset")
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240802083850.103694-3-andi.shyti@linux.intel.com
(cherry picked from commit 97b6784753da06d9d40232328efc5c5367e53417)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_mman.c | 47 +++++++++++++++++++++---
 1 file changed, 42 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index 876f59098f7e..b6cc358adc2c 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -196,6 +196,39 @@ compute_partial_view(const struct drm_i915_gem_object *obj,
 	return view;
 }
 
+static void set_address_limits(struct vm_area_struct *area,
+			       struct i915_vma *vma,
+			       unsigned long *start_vaddr,
+			       unsigned long *end_vaddr)
+{
+	unsigned long vm_start, vm_end, vma_size; /* user's memory parameters */
+	long start, end; /* memory boundaries */
+
+	/*
+	 * Let's move into the ">> PAGE_SHIFT"
+	 * domain to be sure not to lose bits
+	 */
+	vm_start = area->vm_start >> PAGE_SHIFT;
+	vm_end = area->vm_end >> PAGE_SHIFT;
+	vma_size = vma->size >> PAGE_SHIFT;
+
+	/*
+	 * Calculate the memory boundaries by considering the offset
+	 * provided by the user during memory mapping and the offset
+	 * provided for the partial mapping.
+	 */
+	start = vm_start;
+	start += vma->ggtt_view.partial.offset;
+	end = start + vma_size;
+
+	start = max_t(long, start, vm_start);
+	end = min_t(long, end, vm_end);
+
+	/* Let's move back into the "<< PAGE_SHIFT" domain */
+	*start_vaddr = (unsigned long)start << PAGE_SHIFT;
+	*end_vaddr = (unsigned long)end << PAGE_SHIFT;
+}
+
 /**
  * i915_gem_fault - fault a page into the GTT
  * @vmf: fault info
@@ -224,9 +257,11 @@ vm_fault_t i915_gem_fault(struct vm_fault *vmf)
 	struct intel_runtime_pm *rpm = &i915->runtime_pm;
 	struct i915_ggtt *ggtt = &i915->ggtt;
 	bool write = area->vm_flags & VM_WRITE;
+	unsigned long start, end; /* memory boundaries */
 	intel_wakeref_t wakeref;
 	struct i915_vma *vma;
 	pgoff_t page_offset;
+	unsigned long pfn;
 	int srcu;
 	int ret;
 
@@ -295,12 +330,14 @@ vm_fault_t i915_gem_fault(struct vm_fault *vmf)
 	if (ret)
 		goto err_unpin;
 
+	set_address_limits(area, vma, &start, &end);
+
+	pfn = (ggtt->gmadr.start + i915_ggtt_offset(vma)) >> PAGE_SHIFT;
+	pfn += (start - area->vm_start) >> PAGE_SHIFT;
+	pfn -= vma->ggtt_view.partial.offset;
+
 	/* Finally, remap it using the new GTT offset */
-	ret = remap_io_mapping(area,
-			       area->vm_start + (vma->ggtt_view.partial.offset << PAGE_SHIFT),
-			       (ggtt->gmadr.start + vma->node.start) >> PAGE_SHIFT,
-			       min_t(u64, vma->size, area->vm_end - area->vm_start),
-			       &ggtt->iomap);
+	ret = remap_io_mapping(area, start, pfn, end - start, &ggtt->iomap);
 	if (ret)
 		goto err_fence;
 
-- 
2.45.2



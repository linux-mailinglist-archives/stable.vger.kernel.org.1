Return-Path: <stable+bounces-67494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66086950757
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 16:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A6D51C22E08
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 14:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9631D17A583;
	Tue, 13 Aug 2024 14:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQhW0tJm"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A501719D064
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723558496; cv=none; b=kjkQJ96iYDfRd3iOTgfl3Rc2iZiMoqvkPf5ZuJSk85Y8fZymK+488mG8kV5piiciKmuqke4E2nE+UIeeitgYWynqbA9pyNXErATRzMnlQXWFK1CrgK58b4Dv8ebaXNEcC3QzEg5DCSAmCokeIShQudB0XC3KodtQ4L68aLUHtlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723558496; c=relaxed/simple;
	bh=S4wJhBLWBjzh315Civm2opr6BrCG0ASI4T+Ol1OYXoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKkziLvUojci5W14puA6ryR54Rleq7MurgIwIVEp+88CGH5qu/OL3zQMsUxhga5RcDKPZrwqdRFV178oSEj5iTeL/OX97LPj/2fQwmTcGyIgq+L3JpC0EekvmfzlwQF0+Vxx+YCyRx5WNelbr2GWhItP0B/DtV2WaQUOaHFRGbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQhW0tJm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723558494; x=1755094494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S4wJhBLWBjzh315Civm2opr6BrCG0ASI4T+Ol1OYXoE=;
  b=IQhW0tJmv334n/Vbqk2d8hYofQTH0r1Bi5e04a+NoHY4t1DKowkGHhJe
   J7HM+TkyrWZH9MRmssrQ97rLk4rmOV3lQHDtyJq+MzhyFDhgD/mTaFr80
   8IIieHyxuccqcvioqDk1eOHt4D/wli7Vk6yBg48MUgGrmkvnP7i/69Mwv
   R0t8Pcq1SJBphAAYzAMN6RlwPrE9bpc1i5pLXkfcMNDbvaHl7r/lkX2PV
   AozWTXOo+VdNDbzCqVKRk7a8Zpr+nvUHYddA6EVGmSn2D9y85ACG0euvG
   hg3d2KSnEFpFN8UCP4FvxR/FUaej91PY6CN9VzaLYW+eNZDmrbRmcX6/p
   g==;
X-CSE-ConnectionGUID: fIhFr6plQeyGgeYl7uvZBw==
X-CSE-MsgGUID: 5evWg67uQ3GUKrmomRwsuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="21281745"
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="21281745"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:14:53 -0700
X-CSE-ConnectionGUID: R3HaACckQ+m0Bs4ctjn0FQ==
X-CSE-MsgGUID: rFHM/gSzQgumeaC1QmpP9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,286,1716274800"; 
   d="scan'208";a="59237713"
Received: from mwiniars-desk2.ger.corp.intel.com (HELO intel.com) ([10.245.246.4])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 07:14:50 -0700
From: Andi Shyti <andi.shyti@linux.intel.com>
To: stable@vger.kernel.org
Cc: Andi Shyti <andi.shyti@linux.intel.com>,
	Jann Horn <jannh@google.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Jonathan Cavitt <Jonathan.cavitt@intel.com>
Subject: [PATCH 4.19.y] drm/i915/gem: Fix Virtual Memory mapping boundaries calculation
Date: Tue, 13 Aug 2024 16:14:36 +0200
Message-ID: <20240813141436.25278-1-andi.shyti@linux.intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <2024081222-process-suspect-d983@gregkh>
References: <2024081222-process-suspect-d983@gregkh>
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
 drivers/gpu/drm/i915/i915_gem.c | 48 +++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 5b0d6d8b3ab8..d9cdd351caa4 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -2009,6 +2009,40 @@ compute_partial_view(struct drm_i915_gem_object *obj,
 	return view;
 }
 
+static void set_address_limits(struct vm_area_struct *area,
+                              struct i915_vma *vma,
+                              unsigned long *start_vaddr,
+                              unsigned long *end_vaddr)
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
+	start -= obj_offset;
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
@@ -2036,8 +2070,10 @@ vm_fault_t i915_gem_fault(struct vm_fault *vmf)
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	struct i915_ggtt *ggtt = &dev_priv->ggtt;
 	bool write = !!(vmf->flags & FAULT_FLAG_WRITE);
+	unsigned long start, end; /* memory boundaries */
 	struct i915_vma *vma;
 	pgoff_t page_offset;
+	unsigned long pfn;
 	int ret;
 
 	/* Sanity check that we allow writing into this object */
@@ -2119,12 +2155,14 @@ vm_fault_t i915_gem_fault(struct vm_fault *vmf)
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



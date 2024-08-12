Return-Path: <stable+bounces-66414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FD894E9B7
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 11:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCA2B210B0
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F2516CD19;
	Mon, 12 Aug 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wpMwh1gJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F203820323
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723454790; cv=none; b=EMT3lUXHgeBmqHiNj0mzz+oIG9qFAxzUVD9IUykgG+kE6730NMTbTTUj3q80Xk+1j7Em6kju2eMWlnV9a2ftWXFjEluF0G0jUR71KRpswLPv8vacqOE528234NTAgJqwlhUFVO2wTmQpVWcqn+yI81qc/jpcOlhrzlJpoHC3ovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723454790; c=relaxed/simple;
	bh=0/BRPG0/KFGAs7qzAySH3HdTODmmf3MSKtr4rUJkaOM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bfXRB5QnAmH5mOoKkDZum/zN2xcG/D5SFFn/478amSR/Qz5sFU/7TYVM0N0/Fe3vrHAUa0W5PIa4cml94MMgvu06U2miM45of7y45TZj8OQqS1ny4Vkocntxqnnqu2kNUKPLGMLDUnwe5Zz5hgV5gDASRk7iewgsl155ecolvAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wpMwh1gJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A68BC32782;
	Mon, 12 Aug 2024 09:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723454789;
	bh=0/BRPG0/KFGAs7qzAySH3HdTODmmf3MSKtr4rUJkaOM=;
	h=Subject:To:Cc:From:Date:From;
	b=wpMwh1gJde+y0oWbkYPv6Gg5ZPI+hlPJpazg7DIQqJseOvs5SZmIDrZvRFRujfysW
	 9oR9hfjH1u9/eOY27QlE4XDRYlGrpqgFOwci/CEREQh3Hn5d9zpkdmk87O0AGnzv0s
	 03klojIgUR3P2nHg3PU5KVziLGWKkbMsR6ik+Cl0=
Subject: FAILED: patch "[PATCH] drm/i915/gem: Fix Virtual Memory mapping boundaries" failed to apply to 5.10-stable tree
To: andi.shyti@linux.intel.com,Jonathan.cavitt@intel.com,chris.p.wilson@linux.intel.com,jannh@google.com,joonas.lahtinen@linux.intel.com,matthew.auld@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 11:26:20 +0200
Message-ID: <2024081220-brethren-diagnoses-2569@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8bdd9ef7e9b1b2a73e394712b72b22055e0e26c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081220-brethren-diagnoses-2569@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

8bdd9ef7e9b1 ("drm/i915/gem: Fix Virtual Memory mapping boundaries calculation")
8e4ee5e87ce6 ("drm/i915: Wrap all access to i915_vma.node.start|size")
3bb6a44251b4 ("drm/i915: Rename ggtt_view as gtt_view")
d976521a995a ("drm/i915: extend i915_vma_pin_iomap()")
d63ddca7c581 ("drm/i915: Update tiled blits selftest")
a0ed9c95cce6 ("drm/i915/gt: Use XY_FAST_COLOR_BLT to clear obj on graphics ver 12+")
fd5803e5eebe ("drm/i915/gt: use engine instance directly for offset")
892bfb8a604d ("drm/i915/fbdev: fixup setting screen_size")
c674c5b9342e ("drm/i915/xehp: CCS should use RCS setup functions")
30b9d1b3ef37 ("drm/i915: add I915_BO_ALLOC_GPU_ONLY")
3312a4ac8a46 ("drm/i915/ttm: require mappable by default")
8fbf28934acf ("drm/i915/ttm: fixup the mock_bo")
db927686e43f ("Merge drm/drm-next into drm-intel-gt-next")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bdd9ef7e9b1b2a73e394712b72b22055e0e26c3 Mon Sep 17 00:00:00 2001
From: Andi Shyti <andi.shyti@linux.intel.com>
Date: Fri, 2 Aug 2024 10:38:50 +0200
Subject: [PATCH] drm/i915/gem: Fix Virtual Memory mapping boundaries
 calculation

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

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_mman.c b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
index ce10dd259812..cac6d4184506 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_mman.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_mman.c
@@ -290,6 +290,41 @@ static vm_fault_t vm_fault_cpu(struct vm_fault *vmf)
 	return i915_error_to_vmf_fault(err);
 }
 
+static void set_address_limits(struct vm_area_struct *area,
+			       struct i915_vma *vma,
+			       unsigned long obj_offset,
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
+	start -= obj_offset;
+	start += vma->gtt_view.partial.offset;
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
 static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
 {
 #define MIN_CHUNK_PAGES (SZ_1M >> PAGE_SHIFT)
@@ -302,14 +337,18 @@ static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
 	struct i915_ggtt *ggtt = to_gt(i915)->ggtt;
 	bool write = area->vm_flags & VM_WRITE;
 	struct i915_gem_ww_ctx ww;
+	unsigned long obj_offset;
+	unsigned long start, end; /* memory boundaries */
 	intel_wakeref_t wakeref;
 	struct i915_vma *vma;
 	pgoff_t page_offset;
+	unsigned long pfn;
 	int srcu;
 	int ret;
 
-	/* We don't use vmf->pgoff since that has the fake offset */
+	obj_offset = area->vm_pgoff - drm_vma_node_start(&mmo->vma_node);
 	page_offset = (vmf->address - area->vm_start) >> PAGE_SHIFT;
+	page_offset += obj_offset;
 
 	trace_i915_gem_object_fault(obj, page_offset, true, write);
 
@@ -402,12 +441,14 @@ static vm_fault_t vm_fault_gtt(struct vm_fault *vmf)
 	if (ret)
 		goto err_unpin;
 
+	set_address_limits(area, vma, obj_offset, &start, &end);
+
+	pfn = (ggtt->gmadr.start + i915_ggtt_offset(vma)) >> PAGE_SHIFT;
+	pfn += (start - area->vm_start) >> PAGE_SHIFT;
+	pfn += obj_offset - vma->gtt_view.partial.offset;
+
 	/* Finally, remap it using the new GTT offset */
-	ret = remap_io_mapping(area,
-			       area->vm_start + (vma->gtt_view.partial.offset << PAGE_SHIFT),
-			       (ggtt->gmadr.start + i915_ggtt_offset(vma)) >> PAGE_SHIFT,
-			       min_t(u64, vma->size, area->vm_end - area->vm_start),
-			       &ggtt->iomap);
+	ret = remap_io_mapping(area, start, pfn, end - start, &ggtt->iomap);
 	if (ret)
 		goto err_fence;
 



Return-Path: <stable+bounces-121777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B843BA59C43
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2DB07A31B1
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625DF230BEC;
	Mon, 10 Mar 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ce7adK62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E00223099F;
	Mon, 10 Mar 2025 17:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626599; cv=none; b=ICIPx98LgFPF+RnI3PCKXOt6T2YDi47DXugvMZVtimoFXjhSoCph4DFpPt1Yc5nDbvu7ltKgVjqnhp9qmSpSv0sZKfvPePNFmr083JN0aVjOr6IM00s/SQi/M4VOuO7/eQhjIj3385rPdLWbSalgSsd7wcEHX4qD4ZA34UG6oPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626599; c=relaxed/simple;
	bh=r1FdqbGTDIAYsbvbBntMHVgDG9NnAS8HHpfcQc9p1Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ddaYvwHwlC0pKSJ/Nn/zeh4WcL0a9cZhfOjArybYy/RQKYu1zZDrD9YWfiFNR7jCizJanNptcE3+WjlShucEmd6H/8gpKo9/t1t/xRcKFA6ODOjTOotQaZAeS5eB69nqsHkZXyZhgvGWQemhJ/jNyhGpxjO1aEjxJR2YBgYrZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ce7adK62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990D1C4CEE5;
	Mon, 10 Mar 2025 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741626599;
	bh=r1FdqbGTDIAYsbvbBntMHVgDG9NnAS8HHpfcQc9p1Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ce7adK62VbOnsyPCZKPdzZ6QToUeqFSkxpxEaibV1gRs4oLQjg6JIEhbzwiEBphRz
	 U17s5Sx2jbrWkeYBMwyn9zqVtV48KzBOeUVOaD3jOJvniGuMRgpP6jUiibK3P9OSm7
	 Ow7A6jj0nYuun+L3xXr2h9r6xcs8iaAwEqNEfHWE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 6.13 048/207] drm/xe: Add staging tree for VM binds
Date: Mon, 10 Mar 2025 18:04:01 +0100
Message-ID: <20250310170449.675371556@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>
References: <20250310170447.729440535@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Brost <matthew.brost@intel.com>

commit ae482ec8cd1a85bde3307f71921a7780086fbec0 upstream.

Concurrent VM bind staging and zapping of PTEs from a userptr notifier
do not work because the view of PTEs is not stable. VM binds cannot
acquire the notifier lock during staging, as memory allocations are
required. To resolve this race condition, use a staging tree for VM
binds that is committed only under the userptr notifier lock during the
final step of the bind. This ensures a consistent view of the PTEs in
the userptr notifier.

A follow up may only use staging for VM in fault mode as this is the
only mode in which the above race exists.

v3:
 - Drop zap PTE change (Thomas)
 - s/xe_pt_entry/xe_pt_entry_staging (Thomas)

Suggested-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: <stable@vger.kernel.org>
Fixes: e8babb280b5e ("drm/xe: Convert multiple bind ops into single job")
Fixes: a708f6501c69 ("drm/xe: Update PT layer with better error handling")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250228073058.59510-5-thomas.hellstrom@linux.intel.com
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
(cherry picked from commit 6f39b0c5ef0385eae586760d10b9767168037aa5)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_pt.c      |   58 +++++++++++++++++++++++++++-------------
 drivers/gpu/drm/xe/xe_pt_walk.c |    3 +-
 drivers/gpu/drm/xe/xe_pt_walk.h |    4 ++
 3 files changed, 46 insertions(+), 19 deletions(-)

--- a/drivers/gpu/drm/xe/xe_pt.c
+++ b/drivers/gpu/drm/xe/xe_pt.c
@@ -28,6 +28,8 @@ struct xe_pt_dir {
 	struct xe_pt pt;
 	/** @children: Array of page-table child nodes */
 	struct xe_ptw *children[XE_PDES];
+	/** @staging: Array of page-table staging nodes */
+	struct xe_ptw *staging[XE_PDES];
 };
 
 #if IS_ENABLED(CONFIG_DRM_XE_DEBUG_VM)
@@ -48,9 +50,10 @@ static struct xe_pt_dir *as_xe_pt_dir(st
 	return container_of(pt, struct xe_pt_dir, pt);
 }
 
-static struct xe_pt *xe_pt_entry(struct xe_pt_dir *pt_dir, unsigned int index)
+static struct xe_pt *
+xe_pt_entry_staging(struct xe_pt_dir *pt_dir, unsigned int index)
 {
-	return container_of(pt_dir->children[index], struct xe_pt, base);
+	return container_of(pt_dir->staging[index], struct xe_pt, base);
 }
 
 static u64 __xe_pt_empty_pte(struct xe_tile *tile, struct xe_vm *vm,
@@ -125,6 +128,7 @@ struct xe_pt *xe_pt_create(struct xe_vm
 	}
 	pt->bo = bo;
 	pt->base.children = level ? as_xe_pt_dir(pt)->children : NULL;
+	pt->base.staging = level ? as_xe_pt_dir(pt)->staging : NULL;
 
 	if (vm->xef)
 		xe_drm_client_add_bo(vm->xef->client, pt->bo);
@@ -205,8 +209,8 @@ void xe_pt_destroy(struct xe_pt *pt, u32
 		struct xe_pt_dir *pt_dir = as_xe_pt_dir(pt);
 
 		for (i = 0; i < XE_PDES; i++) {
-			if (xe_pt_entry(pt_dir, i))
-				xe_pt_destroy(xe_pt_entry(pt_dir, i), flags,
+			if (xe_pt_entry_staging(pt_dir, i))
+				xe_pt_destroy(xe_pt_entry_staging(pt_dir, i), flags,
 					      deferred);
 		}
 	}
@@ -375,8 +379,10 @@ xe_pt_insert_entry(struct xe_pt_stage_bi
 		/* Continue building a non-connected subtree. */
 		struct iosys_map *map = &parent->bo->vmap;
 
-		if (unlikely(xe_child))
+		if (unlikely(xe_child)) {
 			parent->base.children[offset] = &xe_child->base;
+			parent->base.staging[offset] = &xe_child->base;
+		}
 
 		xe_pt_write(xe_walk->vm->xe, map, offset, pte);
 		parent->num_live++;
@@ -613,6 +619,7 @@ xe_pt_stage_bind(struct xe_tile *tile, s
 			.ops = &xe_pt_stage_bind_ops,
 			.shifts = xe_normal_pt_shifts,
 			.max_level = XE_PT_HIGHEST_LEVEL,
+			.staging = true,
 		},
 		.vm = xe_vma_vm(vma),
 		.tile = tile,
@@ -872,7 +879,7 @@ static void xe_pt_cancel_bind(struct xe_
 	}
 }
 
-static void xe_pt_commit_locks_assert(struct xe_vma *vma)
+static void xe_pt_commit_prepare_locks_assert(struct xe_vma *vma)
 {
 	struct xe_vm *vm = xe_vma_vm(vma);
 
@@ -884,6 +891,16 @@ static void xe_pt_commit_locks_assert(st
 	xe_vm_assert_held(vm);
 }
 
+static void xe_pt_commit_locks_assert(struct xe_vma *vma)
+{
+	struct xe_vm *vm = xe_vma_vm(vma);
+
+	xe_pt_commit_prepare_locks_assert(vma);
+
+	if (xe_vma_is_userptr(vma))
+		lockdep_assert_held_read(&vm->userptr.notifier_lock);
+}
+
 static void xe_pt_commit(struct xe_vma *vma,
 			 struct xe_vm_pgtable_update *entries,
 			 u32 num_entries, struct llist_head *deferred)
@@ -894,13 +911,17 @@ static void xe_pt_commit(struct xe_vma *
 
 	for (i = 0; i < num_entries; i++) {
 		struct xe_pt *pt = entries[i].pt;
+		struct xe_pt_dir *pt_dir;
 
 		if (!pt->level)
 			continue;
 
+		pt_dir = as_xe_pt_dir(pt);
 		for (j = 0; j < entries[i].qwords; j++) {
 			struct xe_pt *oldpte = entries[i].pt_entries[j].pt;
+			int j_ = j + entries[i].ofs;
 
+			pt_dir->children[j_] = pt_dir->staging[j_];
 			xe_pt_destroy(oldpte, xe_vma_vm(vma)->flags, deferred);
 		}
 	}
@@ -912,7 +933,7 @@ static void xe_pt_abort_bind(struct xe_v
 {
 	int i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = num_entries - 1; i >= 0; --i) {
 		struct xe_pt *pt = entries[i].pt;
@@ -927,10 +948,10 @@ static void xe_pt_abort_bind(struct xe_v
 		pt_dir = as_xe_pt_dir(pt);
 		for (j = 0; j < entries[i].qwords; j++) {
 			u32 j_ = j + entries[i].ofs;
-			struct xe_pt *newpte = xe_pt_entry(pt_dir, j_);
+			struct xe_pt *newpte = xe_pt_entry_staging(pt_dir, j_);
 			struct xe_pt *oldpte = entries[i].pt_entries[j].pt;
 
-			pt_dir->children[j_] = oldpte ? &oldpte->base : 0;
+			pt_dir->staging[j_] = oldpte ? &oldpte->base : 0;
 			xe_pt_destroy(newpte, xe_vma_vm(vma)->flags, NULL);
 		}
 	}
@@ -942,7 +963,7 @@ static void xe_pt_commit_prepare_bind(st
 {
 	u32 i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = 0; i < num_entries; i++) {
 		struct xe_pt *pt = entries[i].pt;
@@ -960,10 +981,10 @@ static void xe_pt_commit_prepare_bind(st
 			struct xe_pt *newpte = entries[i].pt_entries[j].pt;
 			struct xe_pt *oldpte = NULL;
 
-			if (xe_pt_entry(pt_dir, j_))
-				oldpte = xe_pt_entry(pt_dir, j_);
+			if (xe_pt_entry_staging(pt_dir, j_))
+				oldpte = xe_pt_entry_staging(pt_dir, j_);
 
-			pt_dir->children[j_] = &newpte->base;
+			pt_dir->staging[j_] = &newpte->base;
 			entries[i].pt_entries[j].pt = oldpte;
 		}
 	}
@@ -1513,6 +1534,7 @@ static unsigned int xe_pt_stage_unbind(s
 			.ops = &xe_pt_stage_unbind_ops,
 			.shifts = xe_normal_pt_shifts,
 			.max_level = XE_PT_HIGHEST_LEVEL,
+			.staging = true,
 		},
 		.tile = tile,
 		.modified_start = xe_vma_start(vma),
@@ -1554,7 +1576,7 @@ static void xe_pt_abort_unbind(struct xe
 {
 	int i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = num_entries - 1; i >= 0; --i) {
 		struct xe_vm_pgtable_update *entry = &entries[i];
@@ -1567,7 +1589,7 @@ static void xe_pt_abort_unbind(struct xe
 			continue;
 
 		for (j = entry->ofs; j < entry->ofs + entry->qwords; j++)
-			pt_dir->children[j] =
+			pt_dir->staging[j] =
 				entries[i].pt_entries[j - entry->ofs].pt ?
 				&entries[i].pt_entries[j - entry->ofs].pt->base : NULL;
 	}
@@ -1580,7 +1602,7 @@ xe_pt_commit_prepare_unbind(struct xe_vm
 {
 	int i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = 0; i < num_entries; ++i) {
 		struct xe_vm_pgtable_update *entry = &entries[i];
@@ -1594,8 +1616,8 @@ xe_pt_commit_prepare_unbind(struct xe_vm
 		pt_dir = as_xe_pt_dir(pt);
 		for (j = entry->ofs; j < entry->ofs + entry->qwords; j++) {
 			entry->pt_entries[j - entry->ofs].pt =
-				xe_pt_entry(pt_dir, j);
-			pt_dir->children[j] = NULL;
+				xe_pt_entry_staging(pt_dir, j);
+			pt_dir->staging[j] = NULL;
 		}
 	}
 }
--- a/drivers/gpu/drm/xe/xe_pt_walk.c
+++ b/drivers/gpu/drm/xe/xe_pt_walk.c
@@ -74,7 +74,8 @@ int xe_pt_walk_range(struct xe_ptw *pare
 		     u64 addr, u64 end, struct xe_pt_walk *walk)
 {
 	pgoff_t offset = xe_pt_offset(addr, level, walk);
-	struct xe_ptw **entries = parent->children ? parent->children : NULL;
+	struct xe_ptw **entries = walk->staging ? (parent->staging ?: NULL) :
+		(parent->children ?: NULL);
 	const struct xe_pt_walk_ops *ops = walk->ops;
 	enum page_walk_action action;
 	struct xe_ptw *child;
--- a/drivers/gpu/drm/xe/xe_pt_walk.h
+++ b/drivers/gpu/drm/xe/xe_pt_walk.h
@@ -11,12 +11,14 @@
 /**
  * struct xe_ptw - base class for driver pagetable subclassing.
  * @children: Pointer to an array of children if any.
+ * @staging: Pointer to an array of staging if any.
  *
  * Drivers could subclass this, and if it's a page-directory, typically
  * embed an array of xe_ptw pointers.
  */
 struct xe_ptw {
 	struct xe_ptw **children;
+	struct xe_ptw **staging;
 };
 
 /**
@@ -41,6 +43,8 @@ struct xe_pt_walk {
 	 * as shared pagetables.
 	 */
 	bool shared_pt_mode;
+	/** @staging: Walk staging PT structure */
+	bool staging;
 };
 
 /**




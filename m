Return-Path: <stable+bounces-119898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B52C1A49235
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF1C18925CD
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABBD1CAA74;
	Fri, 28 Feb 2025 07:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NfSl3h+W"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A47970825
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 07:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727881; cv=none; b=AI3r9mBfr+sT3ILqiqg8h53Nj3cXSDPSEzPm9WKK4DX/HiYw4kuALFcUIyu+oXLv4Rap0Xgd1xfGoo7uPPAP8ikiOYncoUHlWegoJMTMVXEhzW7V4k7q8LC4QbUV9vZdpcoPU+cVLvnP9+O6LSlLBTs9wISFNHALsGXVx29z/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727881; c=relaxed/simple;
	bh=7Hc/U+gqA4FlOazKuSdpTL+ujCRbt+jRcDQvgZbJQHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3fgk5LT5P5Y9DgpMm1f66D/dhJeA1YQIgR9Z3uKOWJw6Nx4/7x/uVjjIFZFi+O4DD6xidrjOrBwHmqSm8E7YxxVbMktlvys6oLoERNd4ap0tu1MpYiHDNnli/TFoxys9xgWtvlPF0rGf/0uqBVw7f3+FPzsx9B0WcosXka1hM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NfSl3h+W; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740727880; x=1772263880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Hc/U+gqA4FlOazKuSdpTL+ujCRbt+jRcDQvgZbJQHg=;
  b=NfSl3h+WSNnGIg3Ko1gYWNMYPs4Ck8OoTavcBHz/1f3mbZw9rCc0kK1X
   FwdNw2Cq3gCMmBOXjt40B0PfLcNeBWlzXdKsHfXAVZ23UslnZGr22su/2
   0WhKaQ3oS7ph37sANey71FIKIviHDYtV9HxEs+MkJyoFBlPesoUgJMyRC
   TO/iQoE9P2pHWpcpwfrXhAcd+fT8c79BPxy+AH6l/3qai37J3QOrkmisf
   1Vt6hiaj3KCUpvmA7BaqE2ZyVhMq/EevgW1LMprselXXX1n7cwbaaBiMG
   EUfXKAwBOpuVEh3Ai/CI5ung4OPi6FKOXMZWFVdwpZKNm4V107JsEpwLq
   A==;
X-CSE-ConnectionGUID: F/vpFWivRZmW8xwCC93vuA==
X-CSE-MsgGUID: lL9m23glSuCvBX9hFufSPA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45297777"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; 
   d="scan'208";a="45297777"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:31:19 -0800
X-CSE-ConnectionGUID: HwlYDRC/Seqx1hzzQU10ZQ==
X-CSE-MsgGUID: z3e+NkdySqe5WEcdp7Zpmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121386259"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO fedora..) ([10.245.246.232])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 23:31:18 -0800
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] drm/xe: Add staging tree for VM binds
Date: Fri, 28 Feb 2025 08:30:58 +0100
Message-ID: <20250228073058.59510-5-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228073058.59510-1-thomas.hellstrom@linux.intel.com>
References: <20250228073058.59510-1-thomas.hellstrom@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

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
---
 drivers/gpu/drm/xe/xe_pt.c      | 58 +++++++++++++++++++++++----------
 drivers/gpu/drm/xe/xe_pt_walk.c |  3 +-
 drivers/gpu/drm/xe/xe_pt_walk.h |  4 +++
 3 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
index 12a627a23eb4..dc24baa84092 100644
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
@@ -48,9 +50,10 @@ static struct xe_pt_dir *as_xe_pt_dir(struct xe_pt *pt)
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
@@ -125,6 +128,7 @@ struct xe_pt *xe_pt_create(struct xe_vm *vm, struct xe_tile *tile,
 	}
 	pt->bo = bo;
 	pt->base.children = level ? as_xe_pt_dir(pt)->children : NULL;
+	pt->base.staging = level ? as_xe_pt_dir(pt)->staging : NULL;
 
 	if (vm->xef)
 		xe_drm_client_add_bo(vm->xef->client, pt->bo);
@@ -206,8 +210,8 @@ void xe_pt_destroy(struct xe_pt *pt, u32 flags, struct llist_head *deferred)
 		struct xe_pt_dir *pt_dir = as_xe_pt_dir(pt);
 
 		for (i = 0; i < XE_PDES; i++) {
-			if (xe_pt_entry(pt_dir, i))
-				xe_pt_destroy(xe_pt_entry(pt_dir, i), flags,
+			if (xe_pt_entry_staging(pt_dir, i))
+				xe_pt_destroy(xe_pt_entry_staging(pt_dir, i), flags,
 					      deferred);
 		}
 	}
@@ -376,8 +380,10 @@ xe_pt_insert_entry(struct xe_pt_stage_bind_walk *xe_walk, struct xe_pt *parent,
 		/* Continue building a non-connected subtree. */
 		struct iosys_map *map = &parent->bo->vmap;
 
-		if (unlikely(xe_child))
+		if (unlikely(xe_child)) {
 			parent->base.children[offset] = &xe_child->base;
+			parent->base.staging[offset] = &xe_child->base;
+		}
 
 		xe_pt_write(xe_walk->vm->xe, map, offset, pte);
 		parent->num_live++;
@@ -614,6 +620,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
 			.ops = &xe_pt_stage_bind_ops,
 			.shifts = xe_normal_pt_shifts,
 			.max_level = XE_PT_HIGHEST_LEVEL,
+			.staging = true,
 		},
 		.vm = xe_vma_vm(vma),
 		.tile = tile,
@@ -873,7 +880,7 @@ static void xe_pt_cancel_bind(struct xe_vma *vma,
 	}
 }
 
-static void xe_pt_commit_locks_assert(struct xe_vma *vma)
+static void xe_pt_commit_prepare_locks_assert(struct xe_vma *vma)
 {
 	struct xe_vm *vm = xe_vma_vm(vma);
 
@@ -885,6 +892,16 @@ static void xe_pt_commit_locks_assert(struct xe_vma *vma)
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
@@ -895,13 +912,17 @@ static void xe_pt_commit(struct xe_vma *vma,
 
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
@@ -913,7 +934,7 @@ static void xe_pt_abort_bind(struct xe_vma *vma,
 {
 	int i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = num_entries - 1; i >= 0; --i) {
 		struct xe_pt *pt = entries[i].pt;
@@ -928,10 +949,10 @@ static void xe_pt_abort_bind(struct xe_vma *vma,
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
@@ -943,7 +964,7 @@ static void xe_pt_commit_prepare_bind(struct xe_vma *vma,
 {
 	u32 i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = 0; i < num_entries; i++) {
 		struct xe_pt *pt = entries[i].pt;
@@ -961,10 +982,10 @@ static void xe_pt_commit_prepare_bind(struct xe_vma *vma,
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
@@ -1494,6 +1515,7 @@ static unsigned int xe_pt_stage_unbind(struct xe_tile *tile, struct xe_vma *vma,
 			.ops = &xe_pt_stage_unbind_ops,
 			.shifts = xe_normal_pt_shifts,
 			.max_level = XE_PT_HIGHEST_LEVEL,
+			.staging = true,
 		},
 		.tile = tile,
 		.modified_start = xe_vma_start(vma),
@@ -1535,7 +1557,7 @@ static void xe_pt_abort_unbind(struct xe_vma *vma,
 {
 	int i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = num_entries - 1; i >= 0; --i) {
 		struct xe_vm_pgtable_update *entry = &entries[i];
@@ -1548,7 +1570,7 @@ static void xe_pt_abort_unbind(struct xe_vma *vma,
 			continue;
 
 		for (j = entry->ofs; j < entry->ofs + entry->qwords; j++)
-			pt_dir->children[j] =
+			pt_dir->staging[j] =
 				entries[i].pt_entries[j - entry->ofs].pt ?
 				&entries[i].pt_entries[j - entry->ofs].pt->base : NULL;
 	}
@@ -1561,7 +1583,7 @@ xe_pt_commit_prepare_unbind(struct xe_vma *vma,
 {
 	int i, j;
 
-	xe_pt_commit_locks_assert(vma);
+	xe_pt_commit_prepare_locks_assert(vma);
 
 	for (i = 0; i < num_entries; ++i) {
 		struct xe_vm_pgtable_update *entry = &entries[i];
@@ -1575,8 +1597,8 @@ xe_pt_commit_prepare_unbind(struct xe_vma *vma,
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
diff --git a/drivers/gpu/drm/xe/xe_pt_walk.c b/drivers/gpu/drm/xe/xe_pt_walk.c
index b8b3d2aea492..be602a763ff3 100644
--- a/drivers/gpu/drm/xe/xe_pt_walk.c
+++ b/drivers/gpu/drm/xe/xe_pt_walk.c
@@ -74,7 +74,8 @@ int xe_pt_walk_range(struct xe_ptw *parent, unsigned int level,
 		     u64 addr, u64 end, struct xe_pt_walk *walk)
 {
 	pgoff_t offset = xe_pt_offset(addr, level, walk);
-	struct xe_ptw **entries = parent->children ? parent->children : NULL;
+	struct xe_ptw **entries = walk->staging ? (parent->staging ?: NULL) :
+		(parent->children ?: NULL);
 	const struct xe_pt_walk_ops *ops = walk->ops;
 	enum page_walk_action action;
 	struct xe_ptw *child;
diff --git a/drivers/gpu/drm/xe/xe_pt_walk.h b/drivers/gpu/drm/xe/xe_pt_walk.h
index 5ecc4d2f0f65..5c02c244f7de 100644
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
-- 
2.48.1



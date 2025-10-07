Return-Path: <stable+bounces-183566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA5FBC2CD3
	for <lists+stable@lfdr.de>; Tue, 07 Oct 2025 23:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F2D19A19CC
	for <lists+stable@lfdr.de>; Tue,  7 Oct 2025 21:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E612494D8;
	Tue,  7 Oct 2025 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0z9xIjsg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA871246BB7;
	Tue,  7 Oct 2025 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759874005; cv=none; b=m5m6BAGHclOqfxj0ET7KPJh7ZIggmjKhB6uiREY+XAH/EVtlz+9+E68eK1IlwnNX9RzZW+NfkSEQtFeIVq9aCvKM5pQyv1nyAe5mQFXXP0uBqORAV0AD3YMKh20P1vB/mCyXBzQTh7rLyD8EjlYqyiwmTn1n7MgUdSyguYHo8qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759874005; c=relaxed/simple;
	bh=okTtg+KeoWVUc3MEEXJT9sF3H7Hq+pWjuiMXXLui/R0=;
	h=Date:To:From:Subject:Message-Id; b=oV6L2Wcm5Igswig6Bg2FR9GYjoBM4vvmp+TR4QhOTm0mVK3OCn+EAUu/2IIGP2mRrmneP8qgsZupt00Dj+So/aiYo7ozyBuWOsOuSikqM5EIDBzwxjNswsjr+nl0ZpuzfNs6wh8TzsReAyYp1Lp9fViAmeFtY1eqltJQkmNNOdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0z9xIjsg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73E38C4CEF1;
	Tue,  7 Oct 2025 21:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1759874004;
	bh=okTtg+KeoWVUc3MEEXJT9sF3H7Hq+pWjuiMXXLui/R0=;
	h=Date:To:From:Subject:From;
	b=0z9xIjsgZK4bp1VBYdijeOD7CeI2GIBcGGt0hdeWIvLzfvNhWWyQQuY6SlIVDJ9i3
	 3yHQgyOCj2JEbUhUIK+nn8h5qEfvVkdTj5/KFbaiwxJ4AF7kIeJkHt6W0WDWPHiHWV
	 kSDmqPst8mWsKAh/omdbSjOTl4/cFlG2l9mWd2OY=
Date: Tue, 07 Oct 2025 14:53:23 -0700
To: mm-commits@vger.kernel.org,yang.yang29@zte.com.cn,wang.yaxin@zte.com.cn,tujinjiang@huawei.com,stable@vger.kernel.org,shr@devkernel.io,david@redhat.com,xu.xin16@zte.com.cn,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: + mm-ksm-fix-exec-fork-inheritance-support-for-prctl.patch added to mm-new branch
Message-Id: <20251007215324.73E38C4CEF1@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The patch titled
     Subject: mm/ksm: fix exec/fork inheritance support for prctl
has been added to the -mm mm-new branch.  Its filename is
     mm-ksm-fix-exec-fork-inheritance-support-for-prctl.patch

This patch will shortly appear at
     https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-ksm-fix-exec-fork-inheritance-support-for-prctl.patch

This patch will later appear in the mm-new branch at
    git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

Note, mm-new is a provisional staging ground for work-in-progress
patches, and acceptance into mm-new is a notification for others take
notice and to finish up reviews.  Please do not hesitate to respond to
review feedback and post updated versions to replace or incrementally
fixup patches in mm-new.

Before you just go and hit "reply", please:
   a) Consider who else should be cc'ed
   b) Prefer to cc a suitable mailing list as well
   c) Ideally: find the original patch on the mailing list and do a
      reply-to-all to that, adding suitable additional cc's

*** Remember to use Documentation/process/submit-checklist.rst when testing your code ***

The -mm tree is included into linux-next via the mm-everything
branch at git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
and is updated there every 2-3 working days

------------------------------------------------------
From: xu xin <xu.xin16@zte.com.cn>
Subject: mm/ksm: fix exec/fork inheritance support for prctl
Date: Tue, 7 Oct 2025 18:28:21 +0800 (CST)

Patch series "ksm: fix exec/fork inheritance", v2.

This series fixes exec/fork inheritance.  See the detailed description of
the issue below.


This patch (of 2):

Background
==========

commit d7597f59d1d33 ("mm: add new api to enable ksm per process")
introduced MMF_VM_MERGE_ANY for mm->flags, and allowed user to set it by
prctl() so that the process's VMAs are forcibly scanned by ksmd. 

Subsequently, the 3c6f33b7273a ("mm/ksm: support fork/exec for prctl")
supported inheriting the MMF_VM_MERGE_ANY flag when a task calls execve().

Finally, commit 3a9e567ca45fb ("mm/ksm: fix ksm exec support for prctl")
fixed the issue that ksmd doesn't scan the mm_struct with MMF_VM_MERGE_ANY
by adding the mm_slot to ksm_mm_head in __bprm_mm_init().

Problem
=======

In some extreme scenarios, however, this inheritance of MMF_VM_MERGE_ANY
during exec/fork can fail.  For example, when the scanning frequency of
ksmd is tuned extremely high, a process carrying MMF_VM_MERGE_ANY may
still fail to pass it to the newly exec'd process.  This happens because
ksm_execve() is executed too early in the do_execve flow (prematurely
adding the new mm_struct to the ksm_mm_slot list).

As a result, before do_execve completes, ksmd may have already performed a
scan and found that this new mm_struct has no VM_MERGEABLE VMAs, thus
clearing its MMF_VM_MERGE_ANY flag.  Consequently, when the new program
executes, the flag MMF_VM_MERGE_ANY inheritance missed.

Root reason
===========

commit d7597f59d1d33 ("mm: add new api to enable ksm per process") clear
the flag MMF_VM_MERGE_ANY when ksmd found no VM_MERGEABLE VMAs.

Solution
========

Firstly, Don't clear MMF_VM_MERGE_ANY when ksmd found no VM_MERGEABLE
VMAs, because perhaps their mm_struct has just been added to ksm_mm_slot
list, and its process has not yet officially started running or has not
yet performed mmap/brk to allocate anonymous VMAS.

Secondly, recheck MMF_VM_MERGEABLE again if a process takes
MMF_VM_MERGE_ANY, and create a mm_slot and join it into ksm_scan_list
again.

Link: https://lkml.kernel.org/r/20251007182504440BJgK8VXRHh8TD7IGSUIY4@zte.com.cn
Link: https://lkml.kernel.org/r/20251007182821572h_SoFqYZXEP1mvWI4n9VL@zte.com.cn
Fixes: 3c6f33b7273a ("mm/ksm: support fork/exec for prctl")
Fixes: d7597f59d1d3 ("mm: add new api to enable ksm per process")
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Cc: Stefan Roesch <shr@devkernel.io>
Cc: David Hildenbrand <david@redhat.com>
Cc: Jinjiang Tu <tujinjiang@huawei.com>
Cc: Wang Yaxin <wang.yaxin@zte.com.cn>
Cc: Yang Yang <yang.yang29@zte.com.cn>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 include/linux/ksm.h |    4 ++--
 mm/ksm.c            |   20 +++++++++++++++++---
 2 files changed, 19 insertions(+), 5 deletions(-)

--- a/include/linux/ksm.h~mm-ksm-fix-exec-fork-inheritance-support-for-prctl
+++ a/include/linux/ksm.h
@@ -17,7 +17,7 @@
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, vm_flags_t *vm_flags);
-vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
+vm_flags_t ksm_vma_flags(struct mm_struct *mm, const struct file *file,
 			 vm_flags_t vm_flags);
 int ksm_enable_merge_any(struct mm_struct *mm);
 int ksm_disable_merge_any(struct mm_struct *mm);
@@ -103,7 +103,7 @@ bool ksm_process_mergeable(struct mm_str
 
 #else  /* !CONFIG_KSM */
 
-static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
+static inline vm_flags_t ksm_vma_flags(struct mm_struct *mm,
 		const struct file *file, vm_flags_t vm_flags)
 {
 	return vm_flags;
--- a/mm/ksm.c~mm-ksm-fix-exec-fork-inheritance-support-for-prctl
+++ a/mm/ksm.c
@@ -2617,8 +2617,14 @@ no_vmas:
 		spin_unlock(&ksm_mmlist_lock);
 
 		mm_slot_free(mm_slot_cache, mm_slot);
+		/*
+		 * Only clear MMF_VM_MERGEABLE. We must not clear
+		 * MMF_VM_MERGE_ANY, because for those MMF_VM_MERGE_ANY process,
+		 * perhaps their mm_struct has just been added to ksm_mm_slot
+		 * list, and its process has not yet officially started running
+		 * or has not yet performed mmap/brk to allocate anonymous VMAS.
+		 */
 		mm_flags_clear(MMF_VM_MERGEABLE, mm);
-		mm_flags_clear(MMF_VM_MERGE_ANY, mm);
 		mmap_read_unlock(mm);
 		mmdrop(mm);
 	} else {
@@ -2736,12 +2742,20 @@ static int __ksm_del_vma(struct vm_area_
  *
  * Returns: @vm_flags possibly updated to mark mergeable.
  */
-vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
+vm_flags_t ksm_vma_flags(struct mm_struct *mm, const struct file *file,
 			 vm_flags_t vm_flags)
 {
 	if (mm_flags_test(MMF_VM_MERGE_ANY, mm) &&
-	    __ksm_should_add_vma(file, vm_flags))
+	    __ksm_should_add_vma(file, vm_flags)) {
 		vm_flags |= VM_MERGEABLE;
+		/*
+		 * Generally, the flags here always include MMF_VM_MERGEABLE.
+		 * However, in rare cases, this flag may be cleared by ksmd who
+		 * scans a cycle without finding any mergeable vma.
+		 */
+		if (unlikely(!mm_flags_test(MMF_VM_MERGEABLE, mm)))
+			__ksm_enter(mm);
+	}
 
 	return vm_flags;
 }
_

Patches currently in -mm which might be from xu.xin16@zte.com.cn are

mm-ksm-fix-exec-fork-inheritance-support-for-prctl.patch
selftests-update-ksm-inheritation-tests-for-prctl-fork-exec.patch



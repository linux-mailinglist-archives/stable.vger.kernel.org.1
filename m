Return-Path: <stable+bounces-203538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 573BECE6B1D
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 13:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61CB43009F7B
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 12:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5113101C7;
	Mon, 29 Dec 2025 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fM2noeus"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF61D30FF30
	for <stable@vger.kernel.org>; Mon, 29 Dec 2025 12:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767011548; cv=none; b=aFW4bZ+J7McfJ+oTe9bOz0b2UM6yLhjbMOw4JrpG9DEbUveF/dpZ8VVsZmxBxynNp8VbISXADzn+np4+jZ4LP1Mq5hvlJ8PI/krlPmdVK9SI08anOmvbhSpxM+VjVlh83X/XkAcWItQHpKnGUrUzi7fo3iobbv2q3Lk0AitnMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767011548; c=relaxed/simple;
	bh=qFYv6F6Cq2JK0fPCpUagMssDZ1tF6mN+b2ZgHQkbv18=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mqm+nuKMFaMu4umTcu0Wgj5nsMdCWpZk4DUxAqnaWJ7yK5/mTuS2esffUbOz/H70dqix3FcqSsb+wuBRNxOLZNB39JFIhBRMHUiTZ32EppwG/nLx/fVlPW6nDq6n4txT1o0N/8jqHW96sDuz+6yLwiAIK3kacyUBkHRDwr8kkL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fM2noeus; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C932C16AAE;
	Mon, 29 Dec 2025 12:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767011547;
	bh=qFYv6F6Cq2JK0fPCpUagMssDZ1tF6mN+b2ZgHQkbv18=;
	h=Subject:To:Cc:From:Date:From;
	b=fM2noeusDu3xHEHhlyE+WeljqQyxDTmDEtGSGqdEIsJ5VHIbRs0MbMNkifPWHfvtL
	 tgG4c2GgHPG4myvf8pwQFX89u5PmdK5Uvn3p4VPZeMCTXvhaHP6KSWR78AMo1nqTRg
	 oEkclP2jXDnTxwpM4ecjPjnDaR7wAhhonOXWvr5Q=
Subject: FAILED: patch "[PATCH] mm/ksm: fix exec/fork inheritance support for prctl" failed to apply to 6.12-stable tree
To: xu.xin16@zte.com.cn,akpm@linux-foundation.org,david@redhat.com,shr@devkernel.io,stable@vger.kernel.org,tujinjiang@huawei.com,wang.yaxin@zte.com.cn,yang.yang29@zte.com.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Dec 2025 13:32:24 +0100
Message-ID: <2025122924-reproach-foster-4189@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 590c03ca6a3fbb114396673314e2aa483839608b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025122924-reproach-foster-4189@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 590c03ca6a3fbb114396673314e2aa483839608b Mon Sep 17 00:00:00 2001
From: xu xin <xu.xin16@zte.com.cn>
Date: Tue, 7 Oct 2025 18:28:21 +0800
Subject: [PATCH] mm/ksm: fix exec/fork inheritance support for prctl

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

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 067538fc4d58..c982694c987b 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -17,7 +17,7 @@
 #ifdef CONFIG_KSM
 int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		unsigned long end, int advice, vm_flags_t *vm_flags);
-vm_flags_t ksm_vma_flags(const struct mm_struct *mm, const struct file *file,
+vm_flags_t ksm_vma_flags(struct mm_struct *mm, const struct file *file,
 			 vm_flags_t vm_flags);
 int ksm_enable_merge_any(struct mm_struct *mm);
 int ksm_disable_merge_any(struct mm_struct *mm);
@@ -103,7 +103,7 @@ bool ksm_process_mergeable(struct mm_struct *mm);
 
 #else  /* !CONFIG_KSM */
 
-static inline vm_flags_t ksm_vma_flags(const struct mm_struct *mm,
+static inline vm_flags_t ksm_vma_flags(struct mm_struct *mm,
 		const struct file *file, vm_flags_t vm_flags)
 {
 	return vm_flags;
diff --git a/mm/ksm.c b/mm/ksm.c
index cdefba633856..4f672f4f2140 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2712,8 +2712,14 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
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
@@ -2831,12 +2837,20 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
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



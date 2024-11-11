Return-Path: <stable+bounces-92110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F32E9C3D87
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 12:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534751C21DBE
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726C715C15C;
	Mon, 11 Nov 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d7XxklVl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367A139578
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325110; cv=none; b=WmIcH1OlLU4wosesicGZGgBpTHtVDULXE6GzDBvnGcpg+2BFgE7n6VKmbM0XIwfPqBfceInN7IEVexTtVjofv6H7drUeKmWfxkWd5vg4iVc2IuyQxg91ow91QS3unuVvWOIA+z7syWv97s6iW38aJoykadhvEWKTpNPdwozKzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325110; c=relaxed/simple;
	bh=0XGYPsdeEChfAL3kZZm3IOmIsIyOZPvXz62L0Cm8T8k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QFGh+89kW+S9+KERmbvcBB79DwclN8JNqnokPvM1JSilkZdidw1D4hSWGzFaCvJvi91WwDxfJ4If4Rh1E5g/vX18aLje433efDy4r9Q4WUDolBEuSbBTIDh8ETArSQhRWadLd9Av1zpGAHwwEszqAccCIIRrmC4m6lqdWRIag0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d7XxklVl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982E3C4CECF;
	Mon, 11 Nov 2024 11:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731325110;
	bh=0XGYPsdeEChfAL3kZZm3IOmIsIyOZPvXz62L0Cm8T8k=;
	h=Subject:To:Cc:From:Date:From;
	b=d7XxklVl7IS/8A0uYDBeDGBA09I/C2t1PZKZp+JaRHEWnd8pugesD8/KxdESfqnao
	 ntz99d/xIApvcOo6GfO31FyaRE6xMrXTbdx7NdgwR2fJq40i8vdePKCeTv6PPk7P9I
	 wOJmgILiKBw8rWyYIc4Ip0KnC09kzVmebFfBde3I=
Subject: FAILED: patch "[PATCH] mm: refactor map_deny_write_exec()" failed to apply to 5.15-stable tree
To: lorenzo.stoakes@oracle.com,James.Bottomley@HansenPartnership.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org,andreas@gaisler.com,broonie@kernel.org,catalin.marinas@arm.com,davem@davemloft.net,deller@gmx.de,jannh@google.com,peterx@redhat.com,stable@vger.kernel.org,torvalds@linux-foundation.org,vbabka@suse.cz,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Nov 2024 12:38:12 +0100
Message-ID: <2024111112-headless-facelift-4a02@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0fb4a7ad270b3b209e510eb9dc5b07bf02b7edaf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111112-headless-facelift-4a02@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0fb4a7ad270b3b209e510eb9dc5b07bf02b7edaf Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 29 Oct 2024 18:11:46 +0000
Subject: [PATCH] mm: refactor map_deny_write_exec()

Refactor the map_deny_write_exec() to not unnecessarily require a VMA
parameter but rather to accept VMA flags parameters, which allows us to
use this function early in mmap_region() in a subsequent commit.

While we're here, we refactor the function to be more readable and add
some additional documentation.

Link: https://lkml.kernel.org/r/6be8bb59cd7c68006ebb006eb9d8dc27104b1f70.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Jann Horn <jannh@google.com>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/mman.h b/include/linux/mman.h
index bcb201ab7a41..8ddca62d6460 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -188,16 +188,31 @@ static inline bool arch_memory_deny_write_exec_supported(void)
  *
  *	d)	mmap(PROT_READ | PROT_EXEC)
  *		mmap(PROT_READ | PROT_EXEC | PROT_BTI)
+ *
+ * This is only applicable if the user has set the Memory-Deny-Write-Execute
+ * (MDWE) protection mask for the current process.
+ *
+ * @old specifies the VMA flags the VMA originally possessed, and @new the ones
+ * we propose to set.
+ *
+ * Return: false if proposed change is OK, true if not ok and should be denied.
  */
-static inline bool map_deny_write_exec(struct vm_area_struct *vma,  unsigned long vm_flags)
+static inline bool map_deny_write_exec(unsigned long old, unsigned long new)
 {
+	/* If MDWE is disabled, we have nothing to deny. */
 	if (!test_bit(MMF_HAS_MDWE, &current->mm->flags))
 		return false;
 
-	if ((vm_flags & VM_EXEC) && (vm_flags & VM_WRITE))
+	/* If the new VMA is not executable, we have nothing to deny. */
+	if (!(new & VM_EXEC))
+		return false;
+
+	/* Under MDWE we do not accept newly writably executable VMAs... */
+	if (new & VM_WRITE)
 		return true;
 
-	if (!(vma->vm_flags & VM_EXEC) && (vm_flags & VM_EXEC))
+	/* ...nor previously non-executable VMAs becoming executable. */
+	if (!(old & VM_EXEC))
 		return true;
 
 	return false;
diff --git a/mm/mmap.c b/mm/mmap.c
index ac0604f146f6..ab71d4c3464c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1505,7 +1505,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 		vma_set_anonymous(vma);
 	}
 
-	if (map_deny_write_exec(vma, vma->vm_flags)) {
+	if (map_deny_write_exec(vma->vm_flags, vma->vm_flags)) {
 		error = -EACCES;
 		goto close_and_free_vma;
 	}
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 0c5d6d06107d..6f450af3252e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -810,7 +810,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 			break;
 		}
 
-		if (map_deny_write_exec(vma, newflags)) {
+		if (map_deny_write_exec(vma->vm_flags, newflags)) {
 			error = -EACCES;
 			break;
 		}
diff --git a/mm/vma.h b/mm/vma.h
index 75558b5e9c8c..d58068c0ff2e 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -42,7 +42,7 @@ struct vma_munmap_struct {
 	int vma_count;                  /* Number of vmas that will be removed */
 	bool unlock;                    /* Unlock after the munmap */
 	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
-	/* 1 byte hole */
+	/* 2 byte hole */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
 	unsigned long nr_accounted;     /* Number of VM_ACCOUNT pages */



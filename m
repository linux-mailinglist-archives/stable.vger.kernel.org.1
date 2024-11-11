Return-Path: <stable+bounces-92106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862E9C3D84
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 12:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DF92B2395E
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2505515A84E;
	Mon, 11 Nov 2024 11:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yxz/PHa/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AB915C15C
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 11:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325096; cv=none; b=J9sD1OkGr+fhX7sI697tzhQMLp8hrkB6O6ZeRfh7WyYc0vul+/Z27SqrLa23f5ErUAb3yf85ceUFOJJ4CZnq4htWxyB+FZ11CZqFIVspjKZ0ypJFR3n/gl/Xmuk0w+9pbA5QPSwV+PEpj3dZ4tJ0r0y0p08P2wyJq1Q/JNvJZ4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325096; c=relaxed/simple;
	bh=+D8yvyngtvFS7Lib2gNP31FovR5WOQvMcxgSPP0fjMo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Qv1u93rjN9LTAYJifTzlDJqgj3pmGbRUdKVApFdYHamPouZaN35CbEt1bcUgLpAbEozlJ3swk2jnrZzPI7InGzZ67EMr+XTG6XmWFx3wRnmGgtLfWbh0W8326ohPSUHnhyg80Qn1R7S4Qf5XrvoFvlSeAzt5SUZk/520VGTNOR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yxz/PHa/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01548C4CECF;
	Mon, 11 Nov 2024 11:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731325096;
	bh=+D8yvyngtvFS7Lib2gNP31FovR5WOQvMcxgSPP0fjMo=;
	h=Subject:To:Cc:From:Date:From;
	b=Yxz/PHa/xPgCfxvo/xCNwNk012PQIS2F4Wu3H3W9hYt1J5eqNK+7oS9w+KLLA/3fm
	 EeAOAXJnbmNYBRCbQIG/Rpmja4wGK3WwB3Yy8RLGHxAfY0sG1QO0I5EvWHSvwR+Nh2
	 kYW41ZIMe2q+0ByK2Z1FYZkMFD05QE0hKJ3XzRdA=
Subject: FAILED: patch "[PATCH] mm: unconditionally close VMAs on error" failed to apply to 5.10-stable tree
To: lorenzo.stoakes@oracle.com,James.Bottomley@HansenPartnership.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org,andreas@gaisler.com,broonie@kernel.org,catalin.marinas@arm.com,davem@davemloft.net,deller@gmx.de,jannh@google.com,peterx@redhat.com,stable@vger.kernel.org,torvalds@linux-foundation.org,vbabka@suse.cz,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Nov 2024 12:37:58 +0100
Message-ID: <2024111157-muster-engaging-dad6@gregkh>
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
git cherry-pick -x 4080ef1579b2413435413988d14ac8c68e4d42c8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111157-muster-engaging-dad6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4080ef1579b2413435413988d14ac8c68e4d42c8 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 29 Oct 2024 18:11:45 +0000
Subject: [PATCH] mm: unconditionally close VMAs on error

Incorrect invocation of VMA callbacks when the VMA is no longer in a
consistent state is bug prone and risky to perform.

With regards to the important vm_ops->close() callback We have gone to
great lengths to try to track whether or not we ought to close VMAs.

Rather than doing so and risking making a mistake somewhere, instead
unconditionally close and reset vma->vm_ops to an empty dummy operations
set with a NULL .close operator.

We introduce a new function to do so - vma_close() - and simplify existing
vms logic which tracked whether we needed to close or not.

This simplifies the logic, avoids incorrect double-calling of the .close()
callback and allows us to update error paths to simply call vma_close()
unconditionally - making VMA closure idempotent.

Link: https://lkml.kernel.org/r/28e89dda96f68c505cb6f8e9fc9b57c3e9f74b42.1730224667.git.lorenzo.stoakes@oracle.com
Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() fails")
Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reported-by: Jann Horn <jannh@google.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
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

diff --git a/mm/internal.h b/mm/internal.h
index 4eab2961e69c..64c2eb0b160e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -135,6 +135,24 @@ static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
 	return err;
 }
 
+/*
+ * If the VMA has a close hook then close it, and since closing it might leave
+ * it in an inconsistent state which makes the use of any hooks suspect, clear
+ * them down by installing dummy empty hooks.
+ */
+static inline void vma_close(struct vm_area_struct *vma)
+{
+	if (vma->vm_ops && vma->vm_ops->close) {
+		vma->vm_ops->close(vma);
+
+		/*
+		 * The mapping is in an inconsistent state, and no further hooks
+		 * may be invoked upon it.
+		 */
+		vma->vm_ops = &vma_dummy_vm_ops;
+	}
+}
+
 #ifdef CONFIG_MMU
 
 /* Flags for folio_pte_batch(). */
diff --git a/mm/mmap.c b/mm/mmap.c
index 6e3b25f7728f..ac0604f146f6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1573,8 +1573,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	return addr;
 
 close_and_free_vma:
-	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 
 	if (file || vma->vm_file) {
 unmap_and_free_vma:
@@ -1934,7 +1933,7 @@ void exit_mmap(struct mm_struct *mm)
 	do {
 		if (vma->vm_flags & VM_ACCOUNT)
 			nr_accounted += vma_pages(vma);
-		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
+		remove_vma(vma, /* unreachable = */ true);
 		count++;
 		cond_resched();
 		vma = vma_next(&vmi);
diff --git a/mm/nommu.c b/mm/nommu.c
index f9ccc02458ec..635d028d647b 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -589,8 +589,7 @@ static int delete_vma_from_mm(struct vm_area_struct *vma)
  */
 static void delete_vma(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	if (vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	put_nommu_region(vma->vm_region);
diff --git a/mm/vma.c b/mm/vma.c
index b21ffec33f8e..7621384d64cf 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -323,11 +323,10 @@ static bool can_vma_merge_right(struct vma_merge_struct *vmg,
 /*
  * Close a vm structure and free it.
  */
-void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
+void remove_vma(struct vm_area_struct *vma, bool unreachable)
 {
 	might_sleep();
-	if (!closed && vma->vm_ops && vma->vm_ops->close)
-		vma->vm_ops->close(vma);
+	vma_close(vma);
 	if (vma->vm_file)
 		fput(vma->vm_file);
 	mpol_put(vma_policy(vma));
@@ -1115,9 +1114,7 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
 	vms_clear_ptes(vms, mas_detach, true);
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		if (vma->vm_ops && vma->vm_ops->close)
-			vma->vm_ops->close(vma);
-	vms->closed_vm_ops = true;
+		vma_close(vma);
 }
 
 /*
@@ -1160,7 +1157,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
 	/* Remove and clean up vmas */
 	mas_set(mas_detach, 0);
 	mas_for_each(mas_detach, vma, ULONG_MAX)
-		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
+		remove_vma(vma, /* unreachable = */ false);
 
 	vm_unacct_memory(vms->nr_accounted);
 	validate_mm(mm);
@@ -1684,8 +1681,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
 	return new_vma;
 
 out_vma_link:
-	if (new_vma->vm_ops && new_vma->vm_ops->close)
-		new_vma->vm_ops->close(new_vma);
+	vma_close(new_vma);
 
 	if (new_vma->vm_file)
 		fput(new_vma->vm_file);
diff --git a/mm/vma.h b/mm/vma.h
index 55457cb68200..75558b5e9c8c 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -42,7 +42,6 @@ struct vma_munmap_struct {
 	int vma_count;                  /* Number of vmas that will be removed */
 	bool unlock;                    /* Unlock after the munmap */
 	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
-	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
 	/* 1 byte hole */
 	unsigned long nr_pages;         /* Number of pages being removed */
 	unsigned long locked_vm;        /* Number of locked pages */
@@ -198,7 +197,6 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
 	vms->unmap_start = FIRST_USER_ADDRESS;
 	vms->unmap_end = USER_PGTABLES_CEILING;
 	vms->clear_ptes = false;
-	vms->closed_vm_ops = false;
 }
 #endif
 
@@ -269,7 +267,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
 		  unsigned long start, size_t len, struct list_head *uf,
 		  bool unlock);
 
-void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
+void remove_vma(struct vm_area_struct *vma, bool unreachable);
 
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);



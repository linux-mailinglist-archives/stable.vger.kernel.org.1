Return-Path: <stable+bounces-92098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE509C3D78
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 12:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8B11F211BB
	for <lists+stable@lfdr.de>; Mon, 11 Nov 2024 11:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFE415C13F;
	Mon, 11 Nov 2024 11:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jtSLSN0y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4C915A84E
	for <stable@vger.kernel.org>; Mon, 11 Nov 2024 11:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325069; cv=none; b=YV87phbC7qZ04vMIQEMf0kHL/phJbQZ82taEAJ/WZCgbO5eBXCsFcGLt+YrF6uRHW5IcH30twItdMmuxhv1sqJ6edgNkdnJ1PM862HJVYkJneFcOND6/oCiojTEa2oHf1JNAkKZXcXW6S9q4IQTX+jh8D1upLqPKBNBQtUrcVdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325069; c=relaxed/simple;
	bh=aNESIpHnT3/GOMsPFztKbAfg4qYBI44/fO6SjaPF3z0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mVpu/ohrydOymPUyYmxTdkCW1eYg8KX1P2cbfkRxXqwYyjtZu0k5pD2NbjqOKaytMpJ2Yb8GkQ7PGHyNSg4Yvw4Rdq5uT0RMxOAcMLlfzfhmBOWEQwjvYCkpvv8acyx2Mxwflz6tUV2Q8tIxjBVVXXJ2XNaILlV+eYI9S/Tl0E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jtSLSN0y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B57C4CECF;
	Mon, 11 Nov 2024 11:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731325068;
	bh=aNESIpHnT3/GOMsPFztKbAfg4qYBI44/fO6SjaPF3z0=;
	h=Subject:To:Cc:From:Date:From;
	b=jtSLSN0yFhLsrWETlFtIGM5P+Uzjmq45rcysdpmgpanAnF7JneVnAQ2VEkqrwEbl2
	 O0JYSzpW4iv3kBAEQHtCcUURxw4a1DjnKK+y6NR4hYaiO8hFh3Ys7dw3qbEPGrerjk
	 OO0ASB3Ox474Qjk9V5+ihY0edxBexHIkh1mf1OgI=
Subject: FAILED: patch "[PATCH] mm: avoid unsafe VMA hook invocation when error arises on" failed to apply to 6.6-stable tree
To: lorenzo.stoakes@oracle.com,James.Bottomley@HansenPartnership.com,Liam.Howlett@oracle.com,akpm@linux-foundation.org,andreas@gaisler.com,broonie@kernel.org,catalin.marinas@arm.com,davem@davemloft.net,deller@gmx.de,jannh@google.com,peterx@redhat.com,stable@vger.kernel.org,torvalds@linux-foundation.org,vbabka@suse.cz,will@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 11 Nov 2024 12:37:42 +0100
Message-ID: <2024111142-caucasian-bauble-c88c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3dd6ed34ce1f2356a77fb88edafb5ec96784e3cf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111142-caucasian-bauble-c88c@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3dd6ed34ce1f2356a77fb88edafb5ec96784e3cf Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 29 Oct 2024 18:11:44 +0000
Subject: [PATCH] mm: avoid unsafe VMA hook invocation when error arises on
 mmap hook

Patch series "fix error handling in mmap_region() and refactor
(hotfixes)", v4.

mmap_region() is somewhat terrifying, with spaghetti-like control flow and
numerous means by which issues can arise and incomplete state, memory
leaks and other unpleasantness can occur.

A large amount of the complexity arises from trying to handle errors late
in the process of mapping a VMA, which forms the basis of recently
observed issues with resource leaks and observable inconsistent state.

This series goes to great lengths to simplify how mmap_region() works and
to avoid unwinding errors late on in the process of setting up the VMA for
the new mapping, and equally avoids such operations occurring while the
VMA is in an inconsistent state.

The patches in this series comprise the minimal changes required to
resolve existing issues in mmap_region() error handling, in order that
they can be hotfixed and backported.  There is additionally a follow up
series which goes further, separated out from the v1 series and sent and
updated separately.


This patch (of 5):

After an attempted mmap() fails, we are no longer in a situation where we
can safely interact with VMA hooks.  This is currently not enforced,
meaning that we need complicated handling to ensure we do not incorrectly
call these hooks.

We can avoid the whole issue by treating the VMA as suspect the moment
that the file->f_ops->mmap() function reports an error by replacing
whatever VMA operations were installed with a dummy empty set of VMA
operations.

We do so through a new helper function internal to mm - mmap_file() -
which is both more logically named than the existing call_mmap() function
and correctly isolates handling of the vm_op reassignment to mm.

All the existing invocations of call_mmap() outside of mm are ultimately
nested within the call_mmap() from mm, which we now replace.

It is therefore safe to leave call_mmap() in place as a convenience
function (and to avoid churn).  The invokers are:

     ovl_file_operations -> mmap -> ovl_mmap() -> backing_file_mmap()
    coda_file_operations -> mmap -> coda_file_mmap()
     shm_file_operations -> shm_mmap()
shm_file_operations_huge -> shm_mmap()
            dma_buf_fops -> dma_buf_mmap_internal -> i915_dmabuf_ops
	                    -> i915_gem_dmabuf_mmap()

None of these callers interact with vm_ops or mappings in a problematic
way on error, quickly exiting out.

Link: https://lkml.kernel.org/r/cover.1730224667.git.lorenzo.stoakes@oracle.com
Link: https://lkml.kernel.org/r/d41fd763496fd0048a962f3fd9407dc72dd4fd86.1730224667.git.lorenzo.stoakes@oracle.com
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

diff --git a/mm/internal.h b/mm/internal.h
index 16c1f3cd599e..4eab2961e69c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -108,6 +108,33 @@ static inline void *folio_raw_mapping(const struct folio *folio)
 	return (void *)(mapping & ~PAGE_MAPPING_FLAGS);
 }
 
+/*
+ * This is a file-backed mapping, and is about to be memory mapped - invoke its
+ * mmap hook and safely handle error conditions. On error, VMA hooks will be
+ * mutated.
+ *
+ * @file: File which backs the mapping.
+ * @vma:  VMA which we are mapping.
+ *
+ * Returns: 0 if success, error otherwise.
+ */
+static inline int mmap_file(struct file *file, struct vm_area_struct *vma)
+{
+	int err = call_mmap(file, vma);
+
+	if (likely(!err))
+		return 0;
+
+	/*
+	 * OK, we tried to call the file hook for mmap(), but an error
+	 * arose. The mapping is in an inconsistent state and we most not invoke
+	 * any further hooks on it.
+	 */
+	vma->vm_ops = &vma_dummy_vm_ops;
+
+	return err;
+}
+
 #ifdef CONFIG_MMU
 
 /* Flags for folio_pte_batch(). */
diff --git a/mm/mmap.c b/mm/mmap.c
index 9841b41e3c76..6e3b25f7728f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1422,7 +1422,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 	/*
 	 * clear PTEs while the vma is still in the tree so that rmap
 	 * cannot race with the freeing later in the truncate scenario.
-	 * This is also needed for call_mmap(), which is why vm_ops
+	 * This is also needed for mmap_file(), which is why vm_ops
 	 * close function is called.
 	 */
 	vms_clean_up_area(&vms, &mas_detach);
@@ -1447,7 +1447,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	if (file) {
 		vma->vm_file = get_file(file);
-		error = call_mmap(file, vma);
+		error = mmap_file(file, vma);
 		if (error)
 			goto unmap_and_free_vma;
 
@@ -1470,7 +1470,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 		vma_iter_config(&vmi, addr, end);
 		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
+		 * If vm_flags changed after mmap_file(), we should try merge
 		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags != vma->vm_flags && vmg.prev)) {
diff --git a/mm/nommu.c b/mm/nommu.c
index 385b0c15add8..f9ccc02458ec 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -885,7 +885,7 @@ static int do_mmap_shared_file(struct vm_area_struct *vma)
 {
 	int ret;
 
-	ret = call_mmap(vma->vm_file, vma);
+	ret = mmap_file(vma->vm_file, vma);
 	if (ret == 0) {
 		vma->vm_region->vm_top = vma->vm_region->vm_end;
 		return 0;
@@ -918,7 +918,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
 	 * happy.
 	 */
 	if (capabilities & NOMMU_MAP_DIRECT) {
-		ret = call_mmap(vma->vm_file, vma);
+		ret = mmap_file(vma->vm_file, vma);
 		/* shouldn't return success if we're not sharing */
 		if (WARN_ON_ONCE(!is_nommu_shared_mapping(vma->vm_flags)))
 			ret = -ENOSYS;



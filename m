Return-Path: <stable+bounces-40669-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9FE8AE701
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 14:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6D11C22C6B
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE4126F10;
	Tue, 23 Apr 2024 12:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tubdXQzF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD485C4E
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713876646; cv=none; b=JxU7qCF6Av/H687fy8ikQntC/JmnRSOBNNQ/S9OPPanoezxMSlcsM2kj2yARD4TlFBqECC9F+uuWB/HkhlxzrO1xntHxI50yDf0SLFJuZyluysugQ3g/LubRdf+xp0hwYtOp7ccL4j0gvYGH3u8Rz2wifiXqBBMCFtbjCzZdPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713876646; c=relaxed/simple;
	bh=eFgSxmqq/lzMSJzmggiGNslRHsKv2ybl00NLVQe/BRw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=vEnsttmaABMO9hKr/jGrRVCKhWx8jVlv6/y8XlYblzCKlZGFi9gpEyCCmXVrfRxkf2DKk1yvb2oedZeII5LLHXeOat7axKRmBYnATuF1VivBiMlQYw+a1E34lj6FOoWXGWC5NIo2EHEixNe0S0TuNTQQ9c+p942W+aOQdIuWXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tubdXQzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C19C116B1;
	Tue, 23 Apr 2024 12:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713876646;
	bh=eFgSxmqq/lzMSJzmggiGNslRHsKv2ybl00NLVQe/BRw=;
	h=Subject:To:Cc:From:Date:From;
	b=tubdXQzFsiupICmjBU+TQN/DzTC0PJQktt2oOd6tuDp36RkBzJZjWQgTVn9iFTWgQ
	 nv024cE5PpOiyvTgrMoMVXmi0og4BF12pxUTfHZAKq1wAY9qjXwFRuahFolRspN9Mn
	 HHLJ9YSnUVdvWuTVZI2f92nL6EPwhzd/tKd/xVbE=
Subject: FAILED: patch "[PATCH] mm/madvise: make MADV_POPULATE_(READ|WRITE) handle" failed to apply to 6.1-stable tree
To: david@redhat.com,akpm@linux-foundation.org,djwong@kernel.org,hughd@google.com,jgg@nvidia.com,jhubbard@nvidia.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 23 Apr 2024 05:50:36 -0700
Message-ID: <2024042336-tinfoil-trusting-765e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 631426ba1d45a8672b177ee85ad4cabe760dd131
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024042336-tinfoil-trusting-765e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

631426ba1d45 ("mm/madvise: make MADV_POPULATE_(READ|WRITE) handle VM_FAULT_RETRY properly")
0f20bba1688b ("mm/gup: explicitly define and check internal GUP flags, disallow FOLL_TOUCH")
6cd06ab12d1a ("gup: make the stack expansion warning a bit more targeted")
9471f1f2f502 ("Merge branch 'expand-stack'")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 631426ba1d45a8672b177ee85ad4cabe760dd131 Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Thu, 14 Mar 2024 17:12:59 +0100
Subject: [PATCH] mm/madvise: make MADV_POPULATE_(READ|WRITE) handle
 VM_FAULT_RETRY properly

Darrick reports that in some cases where pread() would fail with -EIO and
mmap()+access would generate a SIGBUS signal, MADV_POPULATE_READ /
MADV_POPULATE_WRITE will keep retrying forever and not fail with -EFAULT.

While the madvise() call can be interrupted by a signal, this is not the
desired behavior.  MADV_POPULATE_READ / MADV_POPULATE_WRITE should behave
like page faults in that case: fail and not retry forever.

A reproducer can be found at [1].

The reason is that __get_user_pages(), as called by
faultin_vma_page_range(), will not handle VM_FAULT_RETRY in a proper way:
it will simply return 0 when VM_FAULT_RETRY happened, making
madvise_populate()->faultin_vma_page_range() retry again and again, never
setting FOLL_TRIED->FAULT_FLAG_TRIED for __get_user_pages().

__get_user_pages_locked() does what we want, but duplicating that logic in
faultin_vma_page_range() feels wrong.

So let's use __get_user_pages_locked() instead, that will detect
VM_FAULT_RETRY and set FOLL_TRIED when retrying, making the fault handler
return VM_FAULT_SIGBUS (VM_FAULT_ERROR) at some point, propagating -EFAULT
from faultin_page() to __get_user_pages(), all the way to
madvise_populate().

But, there is an issue: __get_user_pages_locked() will end up re-taking
the MM lock and then __get_user_pages() will do another VMA lookup.  In
the meantime, the VMA layout could have changed and we'd fail with
different error codes than we'd want to.

As __get_user_pages() will currently do a new VMA lookup either way, let
it do the VMA handling in a different way, controlled by a new
FOLL_MADV_POPULATE flag, effectively moving these checks from
madvise_populate() + faultin_page_range() in there.

With this change, Darricks reproducer properly fails with -EFAULT, as
documented for MADV_POPULATE_READ / MADV_POPULATE_WRITE.

[1] https://lore.kernel.org/all/20240313171936.GN1927156@frogsfrogsfrogs/

Link: https://lkml.kernel.org/r/20240314161300.382526-1-david@redhat.com
Link: https://lkml.kernel.org/r/20240314161300.382526-2-david@redhat.com
Fixes: 4ca9b3859dac ("mm/madvise: introduce MADV_POPULATE_(READ|WRITE) to prefault page tables")
Signed-off-by: David Hildenbrand <david@redhat.com>
Reported-by: Darrick J. Wong <djwong@kernel.org>
Closes: https://lore.kernel.org/all/20240311223815.GW1927156@frogsfrogsfrogs/
Cc: Darrick J. Wong <djwong@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/gup.c b/mm/gup.c
index af8edadc05d1..1611e73b1121 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1206,6 +1206,22 @@ static long __get_user_pages(struct mm_struct *mm,
 
 		/* first iteration or cross vma bound */
 		if (!vma || start >= vma->vm_end) {
+			/*
+			 * MADV_POPULATE_(READ|WRITE) wants to handle VMA
+			 * lookups+error reporting differently.
+			 */
+			if (gup_flags & FOLL_MADV_POPULATE) {
+				vma = vma_lookup(mm, start);
+				if (!vma) {
+					ret = -ENOMEM;
+					goto out;
+				}
+				if (check_vma_flags(vma, gup_flags)) {
+					ret = -EINVAL;
+					goto out;
+				}
+				goto retry;
+			}
 			vma = gup_vma_lookup(mm, start);
 			if (!vma && in_gate_area(mm, start)) {
 				ret = get_gate_page(mm, start & PAGE_MASK,
@@ -1685,35 +1701,35 @@ long populate_vma_page_range(struct vm_area_struct *vma,
 }
 
 /*
- * faultin_vma_page_range() - populate (prefault) page tables inside the
- *			      given VMA range readable/writable
+ * faultin_page_range() - populate (prefault) page tables inside the
+ *			  given range readable/writable
  *
  * This takes care of mlocking the pages, too, if VM_LOCKED is set.
  *
- * @vma: target vma
+ * @mm: the mm to populate page tables in
  * @start: start address
  * @end: end address
  * @write: whether to prefault readable or writable
  * @locked: whether the mmap_lock is still held
  *
- * Returns either number of processed pages in the vma, or a negative error
- * code on error (see __get_user_pages()).
+ * Returns either number of processed pages in the MM, or a negative error
+ * code on error (see __get_user_pages()). Note that this function reports
+ * errors related to VMAs, such as incompatible mappings, as expected by
+ * MADV_POPULATE_(READ|WRITE).
  *
- * vma->vm_mm->mmap_lock must be held. The range must be page-aligned and
- * covered by the VMA. If it's released, *@locked will be set to 0.
+ * The range must be page-aligned.
+ *
+ * mm->mmap_lock must be held. If it's released, *@locked will be set to 0.
  */
-long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
-			    unsigned long end, bool write, int *locked)
+long faultin_page_range(struct mm_struct *mm, unsigned long start,
+			unsigned long end, bool write, int *locked)
 {
-	struct mm_struct *mm = vma->vm_mm;
 	unsigned long nr_pages = (end - start) / PAGE_SIZE;
 	int gup_flags;
 	long ret;
 
 	VM_BUG_ON(!PAGE_ALIGNED(start));
 	VM_BUG_ON(!PAGE_ALIGNED(end));
-	VM_BUG_ON_VMA(start < vma->vm_start, vma);
-	VM_BUG_ON_VMA(end > vma->vm_end, vma);
 	mmap_assert_locked(mm);
 
 	/*
@@ -1725,19 +1741,13 @@ long faultin_vma_page_range(struct vm_area_struct *vma, unsigned long start,
 	 *		  a poisoned page.
 	 * !FOLL_FORCE: Require proper access permissions.
 	 */
-	gup_flags = FOLL_TOUCH | FOLL_HWPOISON | FOLL_UNLOCKABLE;
+	gup_flags = FOLL_TOUCH | FOLL_HWPOISON | FOLL_UNLOCKABLE |
+		    FOLL_MADV_POPULATE;
 	if (write)
 		gup_flags |= FOLL_WRITE;
 
-	/*
-	 * We want to report -EINVAL instead of -EFAULT for any permission
-	 * problems or incompatible mappings.
-	 */
-	if (check_vma_flags(vma, gup_flags))
-		return -EINVAL;
-
-	ret = __get_user_pages(mm, start, nr_pages, gup_flags,
-			       NULL, locked);
+	ret = __get_user_pages_locked(mm, start, nr_pages, NULL, locked,
+				      gup_flags);
 	lru_add_drain();
 	return ret;
 }
diff --git a/mm/internal.h b/mm/internal.h
index 7e486f2c502c..07ad2675a88b 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -686,9 +686,8 @@ struct anon_vma *folio_anon_vma(struct folio *folio);
 void unmap_mapping_folio(struct folio *folio);
 extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *locked);
-extern long faultin_vma_page_range(struct vm_area_struct *vma,
-				   unsigned long start, unsigned long end,
-				   bool write, int *locked);
+extern long faultin_page_range(struct mm_struct *mm, unsigned long start,
+		unsigned long end, bool write, int *locked);
 extern bool mlock_future_ok(struct mm_struct *mm, unsigned long flags,
 			       unsigned long bytes);
 
@@ -1127,10 +1126,13 @@ enum {
 	FOLL_FAST_ONLY = 1 << 20,
 	/* allow unlocking the mmap lock */
 	FOLL_UNLOCKABLE = 1 << 21,
+	/* VMA lookup+checks compatible with MADV_POPULATE_(READ|WRITE) */
+	FOLL_MADV_POPULATE = 1 << 22,
 };
 
 #define INTERNAL_GUP_FLAGS (FOLL_TOUCH | FOLL_TRIED | FOLL_REMOTE | FOLL_PIN | \
-			    FOLL_FAST_ONLY | FOLL_UNLOCKABLE)
+			    FOLL_FAST_ONLY | FOLL_UNLOCKABLE | \
+			    FOLL_MADV_POPULATE)
 
 /*
  * Indicates for which pages that are write-protected in the page table,
diff --git a/mm/madvise.c b/mm/madvise.c
index 44a498c94158..1a073fcc4c0c 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -908,27 +908,14 @@ static long madvise_populate(struct vm_area_struct *vma,
 {
 	const bool write = behavior == MADV_POPULATE_WRITE;
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long tmp_end;
 	int locked = 1;
 	long pages;
 
 	*prev = vma;
 
 	while (start < end) {
-		/*
-		 * We might have temporarily dropped the lock. For example,
-		 * our VMA might have been split.
-		 */
-		if (!vma || start >= vma->vm_end) {
-			vma = vma_lookup(mm, start);
-			if (!vma)
-				return -ENOMEM;
-		}
-
-		tmp_end = min_t(unsigned long, end, vma->vm_end);
 		/* Populate (prefault) page tables readable/writable. */
-		pages = faultin_vma_page_range(vma, start, tmp_end, write,
-					       &locked);
+		pages = faultin_page_range(mm, start, end, write, &locked);
 		if (!locked) {
 			mmap_read_lock(mm);
 			locked = 1;
@@ -949,7 +936,7 @@ static long madvise_populate(struct vm_area_struct *vma,
 				pr_warn_once("%s: unhandled return value: %ld\n",
 					     __func__, pages);
 				fallthrough;
-			case -ENOMEM:
+			case -ENOMEM: /* No VMA or out of memory. */
 				return -ENOMEM;
 			}
 		}



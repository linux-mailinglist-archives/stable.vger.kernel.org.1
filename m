Return-Path: <stable+bounces-195310-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71677C75366
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 261464ED8B7
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BEA33CEB7;
	Thu, 20 Nov 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bJLj6h7Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332363376AA
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654197; cv=none; b=nPfykFPitdN+cjpuGDm68UOCFuhIL4xuI5mSt/VN+wXKL6hq786/NamQQ5RJPBFPVjOJkflK+iY0PKYrDrGqplBVtt9TLljSoS4/0J4ThU3A5u2SyVlqO7sm8mLJNLRzk9LlFItbu30iW9CzqYNYAuBGtsOqQBGenELlwzNiVP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654197; c=relaxed/simple;
	bh=0UM4Gh39WKTNzU+C84CtABpVod25IP29MMxT3/2TtIA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f9TJMGbz75uckWWeGZ+EksHJ4Kw2i8UiP+dK0NgSwr492sGf1/vB+SgvA2kiNrHJpT7jD44KK+xjWMEnvwE17RwvoVnj0+45lJb39eM+U0dVJt+soyF4L7yhybX2fEoKj+2YHnGNEV+9swB2edN8VDTn4jzRLDWBjOf2n/S/PqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bJLj6h7Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8AFC4CEF1;
	Thu, 20 Nov 2025 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763654197;
	bh=0UM4Gh39WKTNzU+C84CtABpVod25IP29MMxT3/2TtIA=;
	h=Subject:To:Cc:From:Date:From;
	b=bJLj6h7Y3FLBz+CB9WelKJ1TmRTNgfQYU1GVyhGRPBz4If001H3tY3CQ8XLyjcbf2
	 R0jDHq9dKNe6opolyIHgnNOBJXFAr0/FBrh8aXASUbhrjEnJ/mtypocJYTfOnKOXt/
	 uqsw/jy+Y5nEMAe+Y16O7Oebjxx5WKQpqGLaJ4ZI=
Subject: FAILED: patch "[PATCH] mm/memory: do not populate page table entries beyond i_size" failed to apply to 6.6-stable tree
To: kas@kernel.org,akpm@linux-foundation.org,baolin.wang@linux.alibaba.com,brauner@kernel.org,david@fromorbit.com,david@redhat.com,djwong@kernel.org,hannes@cmpxchg.org,hughd@google.com,liam.howlett@oracle.com,lorenzo.stoakes@oracle.com,mhocko@suse.com,riel@surriel.com,rppt@kernel.org,shakeel.butt@linux.dev,stable@vger.kernel.org,surenb@google.com,vbabka@suse.cz,viro@zeniv.linux.org.uk,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:56:25 +0100
Message-ID: <2025112025-voucher-hexagram-61bf@gregkh>
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
git cherry-pick -x 74207de2ba10c2973334906822dc94d2e859ffc5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112025-voucher-hexagram-61bf@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 74207de2ba10c2973334906822dc94d2e859ffc5 Mon Sep 17 00:00:00 2001
From: Kiryl Shutsemau <kas@kernel.org>
Date: Mon, 27 Oct 2025 11:56:35 +0000
Subject: [PATCH] mm/memory: do not populate page table entries beyond i_size

Patch series "Fix SIGBUS semantics with large folios", v3.

Accessing memory within a VMA, but beyond i_size rounded up to the next
page size, is supposed to generate SIGBUS.

Darrick reported[1] an xfstests regression in v6.18-rc1.  generic/749
failed due to missing SIGBUS.  This was caused by my recent changes that
try to fault in the whole folio where possible:

        19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
        357b92761d94 ("mm/filemap: map entire large folio faultaround")

These changes did not consider i_size when setting up PTEs, leading to
xfstest breakage.

However, the problem has been present in the kernel for a long time -
since huge tmpfs was introduced in 2016.  The kernel happily maps
PMD-sized folios as PMD without checking i_size.  And huge=always tmpfs
allocates PMD-size folios on any writes.

I considered this corner case when I implemented a large tmpfs, and my
conclusion was that no one in their right mind should rely on receiving a
SIGBUS signal when accessing beyond i_size.  I cannot imagine how it could
be useful for the workload.

But apparently filesystem folks care a lot about preserving strict SIGBUS
semantics.

Generic/749 was introduced last year with reference to POSIX, but no real
workloads were mentioned.  It also acknowledged the tmpfs deviation from
the test case.

POSIX indeed says[3]:

        References within the address range starting at pa and
        continuing for len bytes to whole pages following the end of an
        object shall result in delivery of a SIGBUS signal.

The patchset fixes the regression introduced by recent changes as well as
more subtle SIGBUS breakage due to split failure on truncation.


This patch (of 2):

Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
supposed to generate SIGBUS.

Recent changes attempted to fault in full folio where possible.  They did
not respect i_size, which led to populating PTEs beyond i_size and
breaking SIGBUS semantics.

Darrick reported generic/749 breakage because of this.

However, the problem existed before the recent changes.  With huge=always
tmpfs, any write to a file leads to PMD-size allocation.  Following the
fault-in of the folio will install PMD mapping regardless of i_size.

Fix filemap_map_pages() and finish_fault() to not install:
  - PTEs beyond i_size;
  - PMD mappings across i_size;

Make an exception for shmem/tmpfs that for long time intentionally
mapped with PMDs across i_size.

Link: https://lkml.kernel.org/r/20251027115636.82382-1-kirill@shutemov.name
Link: https://lkml.kernel.org/r/20251027115636.82382-2-kirill@shutemov.name
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
Fixes: 6795801366da ("xfs: Support large folios")
Reported-by: "Darrick J. Wong" <djwong@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/filemap.c b/mm/filemap.c
index 13f0259d993c..2f1e7e283a51 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3681,7 +3681,8 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
 static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			struct folio *folio, unsigned long start,
 			unsigned long addr, unsigned int nr_pages,
-			unsigned long *rss, unsigned short *mmap_miss)
+			unsigned long *rss, unsigned short *mmap_miss,
+			bool can_map_large)
 {
 	unsigned int ref_from_caller = 1;
 	vm_fault_t ret = 0;
@@ -3696,7 +3697,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	 * The folio must not cross VMA or page table boundary.
 	 */
 	addr0 = addr - start * PAGE_SIZE;
-	if (folio_within_vma(folio, vmf->vma) &&
+	if (can_map_large && folio_within_vma(folio, vmf->vma) &&
 	    (addr0 & PMD_MASK) == ((addr0 + folio_size(folio) - 1) & PMD_MASK)) {
 		vmf->pte -= start;
 		page -= start;
@@ -3811,13 +3812,27 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	unsigned long rss = 0;
 	unsigned int nr_pages = 0, folio_type;
 	unsigned short mmap_miss = 0, mmap_miss_saved;
+	bool can_map_large;
 
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
 	if (!folio)
 		goto out;
 
-	if (filemap_map_pmd(vmf, folio, start_pgoff)) {
+	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
+	end_pgoff = min(end_pgoff, file_end);
+
+	/*
+	 * Do not allow to map with PTEs beyond i_size and with PMD
+	 * across i_size to preserve SIGBUS semantics.
+	 *
+	 * Make an exception for shmem/tmpfs that for long time
+	 * intentionally mapped with PMDs across i_size.
+	 */
+	can_map_large = shmem_mapping(mapping) ||
+		file_end >= folio_next_index(folio);
+
+	if (can_map_large && filemap_map_pmd(vmf, folio, start_pgoff)) {
 		ret = VM_FAULT_NOPAGE;
 		goto out;
 	}
@@ -3830,10 +3845,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
-	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
-	if (end_pgoff > file_end)
-		end_pgoff = file_end;
-
 	folio_type = mm_counter_file(folio);
 	do {
 		unsigned long end;
@@ -3850,7 +3861,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		else
 			ret |= filemap_map_folio_range(vmf, folio,
 					xas.xa_index - folio->index, addr,
-					nr_pages, &rss, &mmap_miss);
+					nr_pages, &rss, &mmap_miss,
+					can_map_large);
 
 		folio_unlock(folio);
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
diff --git a/mm/memory.c b/mm/memory.c
index 74b45e258323..b59ae7ce42eb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -65,6 +65,7 @@
 #include <linux/gfp.h>
 #include <linux/migrate.h>
 #include <linux/string.h>
+#include <linux/shmem_fs.h>
 #include <linux/memory-tiers.h>
 #include <linux/debugfs.h>
 #include <linux/userfaultfd_k.h>
@@ -5501,8 +5502,25 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return ret;
 	}
 
+	if (!needs_fallback && vma->vm_file) {
+		struct address_space *mapping = vma->vm_file->f_mapping;
+		pgoff_t file_end;
+
+		file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE);
+
+		/*
+		 * Do not allow to map with PTEs beyond i_size and with PMD
+		 * across i_size to preserve SIGBUS semantics.
+		 *
+		 * Make an exception for shmem/tmpfs that for long time
+		 * intentionally mapped with PMDs across i_size.
+		 */
+		needs_fallback = !shmem_mapping(mapping) &&
+			file_end < folio_next_index(folio);
+	}
+
 	if (pmd_none(*vmf->pmd)) {
-		if (folio_test_pmd_mappable(folio)) {
+		if (!needs_fallback && folio_test_pmd_mappable(folio)) {
 			ret = do_set_pmd(vmf, folio, page);
 			if (ret != VM_FAULT_FALLBACK)
 				return ret;



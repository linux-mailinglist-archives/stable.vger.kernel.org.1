Return-Path: <stable+bounces-196282-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5002C79E10
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 15:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0692B4EE75F
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C02534DB6F;
	Fri, 21 Nov 2025 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ogDIsEsf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBA730E0E2
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763733065; cv=none; b=awWtO8EDtKVQItBOGfr+bamPVoHxJLd9snXPlvdcvY9eub9QSZLdEWBaD6kIDeovSKOrVO4K4M5BSjyhxAribBfnMu0i+hj5wTAIv2tYdKm+5wKAIElOLC6apNDeb0RjbpImzmxfwrJKkEIeAZNedYnbUwlDvfMiwWvusyXSec8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763733065; c=relaxed/simple;
	bh=7rOE4xaKUtKr+57+LpWMqw9XYGQPceA1EeHWkB3DlwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hqjldhmo6MW1PHDVSlxmBdg34DVvfMCxphsrmYBk1V9E3mbar5xFmtNIMpTJPVAXCKW0WqKke01redCYPuw+AFx6dP6SmFb6ZsIIb+SF+r1WJxFmnJjdrtr5WC025Qhux4kaZLjrTc91fVZMNZLLFtdvPDdYz2loSOV/zRbOzkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ogDIsEsf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8386C4CEFB;
	Fri, 21 Nov 2025 13:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763733064;
	bh=7rOE4xaKUtKr+57+LpWMqw9XYGQPceA1EeHWkB3DlwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ogDIsEsf3HLvBcEtLysNQAwJ0of0Rtis0cR+o0ddiWDSFPvIJ/hISpF2KFNtwTZGM
	 W5Gfradt4cP0QyAHfP90ZcQPeg391CfwqKZG5y2uS1RAuod0tpQzkphuPfHsRNILrI
	 48das7Xu6T/RvkZS6nQgsN87xu+S+miqxM8KJOHLXHh8oDIAfso5drXqXLM0IkX3IK
	 6Zh0c+o8xRAnwqv8ortfkxs3EqR2BSVx4gK/Lno88dHCUZW5kAKdyWJFtNns7ZUctD
	 TonTOlRGhKzIE4U8pp7Q8e7W0+NPyJ3eawaCAp+gZjxCs7LFY+IISPxPDv1znL+9ZP
	 K/EE49uvHX9WQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 20C4BF40080;
	Fri, 21 Nov 2025 08:51:03 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 21 Nov 2025 08:51:03 -0500
X-ME-Sender: <xms:Rm4gaZTsYLHvcTNgJlbrX1Q8YFNDD0e5ypT6adizPlIhUKBZDnM90g>
    <xme:Rm4gaeoBRedzk7swvFFnaQRiOpotCzIvXncl7ldjnM_nvyoUdx8mci9LfSxZV9bVy
    yJn9uSEA3XOFQeeYFTZMw1adUlQI-jl30qyoLammmW-Pg4fo277Nlw>
X-ME-Received: <xmr:Rm4gaaXz5TCj_sOugCB2n387N7nGVXJ8X7MtswqqZCIN351U6sxdtJ9la6KMIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepgeejffehvdeltdefteejieehveeuffeuteevhfehvdejieelteffleefleeiffeh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeiudduiedvieehhedqvdekgeeggeejvdekqdhkrghspeepkh
    gvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtrggslhgvsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrsheskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepughjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvihhrohesii
    gvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtohepsggrohhlihhnrdifrghn
    gheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtthhopegsrhgruhhnvghrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghvihgusehfrhhomhhorhgsihhtrdgt
    ohhmpdhrtghpthhtohepuggrvhhiugesrhgvughhrghtrdgtohhmpdhrtghpthhtohephh
    hughhhugesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:Rm4gaU_lXXCtdnNaD0rDueh1JlIrrt1OZ_qL1mwzU4W1HHrhbeMaRw>
    <xmx:R24gaaZVP5YCYKh1g81tY6y0GrY4vZwzQK8zv66GDkBcn-YvMdx9Yw>
    <xmx:R24gaUcyTols_2wp6sTxfF7sID0oNte5zJvnDTgzBiliFGiVt7ES0w>
    <xmx:R24gacpTtaxiuuTKjON_W-Xd8VxvtVrN2WRDnKSowUTfbUT4VA9KTA>
    <xmx:R24gaTDdwqZ59LBz8QyUHr-0pb320sofrC8tq52EuWKdqwhhPG6VSxN1>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Nov 2025 08:51:02 -0500 (EST)
From: Kiryl Shutsemau <kas@kernel.org>
To: stable@vger.kernel.org
Cc: Kiryl Shutsemau <kas@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	Dave Chinner <david@fromorbit.com>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1.y 2/2] mm/memory: do not populate page table entries beyond i_size
Date: Fri, 21 Nov 2025 13:50:57 +0000
Message-ID: <20251121135057.1062568-2-kas@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121135057.1062568-1-kas@kernel.org>
References: <2025112026-substance-senator-8409@gregkh>
 <20251121135057.1062568-1-kas@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 74207de2ba10c2973334906822dc94d2e859ffc5)
Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
---
 mm/filemap.c | 20 +++++++++++++++-----
 mm/memory.c  | 24 +++++++++++++++++++++++-
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index bff0abf4c3a7..3b73e62311ce 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3440,13 +3440,27 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct page *page;
 	unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
 	vm_fault_t ret = 0;
+	bool can_map_large;
 
 	rcu_read_lock();
 	folio = first_map_page(mapping, &xas, end_pgoff);
 	if (!folio)
 		goto out;
 
-	if (filemap_map_pmd(vmf, &folio->page)) {
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
+	if (can_map_large && filemap_map_pmd(vmf, &folio->page)) {
 		ret = VM_FAULT_NOPAGE;
 		goto out;
 	}
@@ -3454,10 +3468,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	addr = vma->vm_start + ((start_pgoff - vma->vm_pgoff) << PAGE_SHIFT);
 	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, addr, &vmf->ptl);
 
-	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
-	if (end_pgoff > file_end)
-		end_pgoff = file_end;
-
 	do {
 again:
 		page = folio_file_page(folio, xas.xa_index);
diff --git a/mm/memory.c b/mm/memory.c
index 454d918449b3..f0b506acfcc5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -67,6 +67,7 @@
 #include <linux/gfp.h>
 #include <linux/migrate.h>
 #include <linux/string.h>
+#include <linux/shmem_fs.h>
 #include <linux/memory-tiers.h>
 #include <linux/debugfs.h>
 #include <linux/userfaultfd_k.h>
@@ -4452,6 +4453,8 @@ static bool vmf_pte_changed(struct vm_fault *vmf)
 vm_fault_t finish_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	bool needs_fallback = false;
+	struct folio *folio;
 	struct page *page;
 	vm_fault_t ret;
 
@@ -4461,6 +4464,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	else
 		page = vmf->page;
 
+	folio = page_folio(page);
+
 	/*
 	 * check even for read faults because we might have lost our CoWed
 	 * page
@@ -4471,8 +4476,25 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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
-		if (PageTransCompound(page)) {
+		if (!needs_fallback && PageTransCompound(page)) {
 			ret = do_set_pmd(vmf, page);
 			if (ret != VM_FAULT_FALLBACK)
 				return ret;
-- 
2.51.0



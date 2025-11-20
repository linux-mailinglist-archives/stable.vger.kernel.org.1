Return-Path: <stable+bounces-195379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A17CAC75E14
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0A9443447F6
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797FB35B125;
	Thu, 20 Nov 2025 18:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxVxvapg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374AE3242C7
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662630; cv=none; b=HaR9d5ksCe3bpsXfKfFbnEyOaqalp2Y0QOEO4bISmehZVcYEfP93TN/ecqCiEgDj96imVQNiVkp/OKoQsmoBkNZl/PGXXdEfJ5Oou9k2WN7Bziavnbwr8NEgyhC9CO5tWu+xIQq5Fl1DrfSluiESxi3z5t+xx7/aL6R7CGragXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662630; c=relaxed/simple;
	bh=QWVeMh8fMWeJvtk9LMQumbs4SADPpV6Vb4blT/fwgjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GR+qSHhTXqZwnvI56rRjDmk6FBxAgFjoGuBUGsIkI3o2ln4fiqKvWKaEFdCGO/atKG11SpxWyjNHp1p4r1Wf4oiy3um73XmBOTfY49NO/WmVNypH2/vVUKso3Y3pJ3m3dn8zcKn4zC3XWxmI6uFuSwvwbqHR7zyJ+qz2CrnmN+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxVxvapg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BCBC4AF0B;
	Thu, 20 Nov 2025 18:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763662628;
	bh=QWVeMh8fMWeJvtk9LMQumbs4SADPpV6Vb4blT/fwgjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxVxvapg4kZk+PO+i8BGONwZ6KurIbtKSY/K0S9IvnuJ1zdwh1bbimBjYrFO1Gjx0
	 72n+k0LEnY60jCBSXuHiUoJIFU85RZCIIntbN/GqjwU3zbz37rdVaeJGz0ZhSLsvGA
	 Zdq47P7UiAMOCESFz/Djqvp7u8/7EHQWLVQF0z9oXmDlnxStO2ghI1LIHwNIQvE7K5
	 Gi+qNEfoO6Nd0cxO/EbSwtkgAYthqaIDviGyqDEkT+VreZYOZWiFLnTOgRArW4QDt3
	 FDOgr6c6vmJKxWyNf/o2sTmrlgpTJXDZP8CksAwHLs8l0yrZcMal/kMLwzXtU/JhQ2
	 PJOfOcBLFhwZA==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 9763EF40070;
	Thu, 20 Nov 2025 13:17:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 20 Nov 2025 13:17:07 -0500
X-ME-Sender: <xms:I1sfad5fuWM8SIGmeTSJ5Iz6H1HQ9nYUQHuP8Nz1fu6EXHLChOC1Hw>
    <xme:I1sfaWyUusK4z9lkYpAA-RdI1sRw-JwXi8h9MmaAtGUzlt9Y-oRbjDqK6NbqmuQGL
    BvuKw98YcnbLMgz5LOuVY1xxL1fVGh0jUMY897Tq7CFs0UiCbBREBo>
X-ME-Received: <xmr:I1sfaf8gbg9AhbrsFx_2a_PWRHINLPKgPLvc4SsBTYmMGeCXjNb31tZTyk17Hg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejjeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:I1sfaaEQEGRjzO7BW2TW9xIVwMIEx66Gp6t1ahHMxTHbM_Sb_xxu_A>
    <xmx:I1sfaZBzn3f1oixhZfl090OVPXdljAv97e0isZ_cC_N-6rWtlVA8UQ>
    <xmx:I1sfaekq01lncTBgd17Vw79sUGgfg6jJXdPFIdqFAJeD3HqY9Cq50g>
    <xmx:I1sfacS8DJ5aem5T_osrn_5ThQknBe1EXlVwP305atuFbvQ9_WeuUQ>
    <xmx:I1sfaaIrw4Pt-ajhP6AFV7410hqukHk6KopIFYY7vVgY075Qk7i0Wtii>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 13:17:07 -0500 (EST)
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
Subject: [PATCH 6.6.y 2/2] mm/memory: do not populate page table entries beyond i_size
Date: Thu, 20 Nov 2025 18:16:57 +0000
Message-ID: <20251120181657.964919-2-kas@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120181657.964919-1-kas@kernel.org>
References: <2025112025-voucher-hexagram-61bf@gregkh>
 <20251120181657.964919-1-kas@kernel.org>
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
index 7d4d3bea4e1e..6e01364a1ca6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3614,13 +3614,27 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	struct folio *folio;
 	vm_fault_t ret = 0;
 	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved;
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
@@ -3633,10 +3647,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
-	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
-	if (end_pgoff > file_end)
-		end_pgoff = file_end;
-
 	do {
 		unsigned long end;
 
diff --git a/mm/memory.c b/mm/memory.c
index 8b80db7115e5..fd917a5bc961 100644
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
@@ -4435,6 +4436,8 @@ static bool vmf_pte_changed(struct vm_fault *vmf)
 vm_fault_t finish_fault(struct vm_fault *vmf)
 {
 	struct vm_area_struct *vma = vmf->vma;
+	bool needs_fallback = false;
+	struct folio *folio;
 	struct page *page;
 	vm_fault_t ret;
 
@@ -4444,6 +4447,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	else
 		page = vmf->page;
 
+	folio = page_folio(page);
+
 	/*
 	 * check even for read faults because we might have lost our CoWed
 	 * page
@@ -4454,8 +4459,25 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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



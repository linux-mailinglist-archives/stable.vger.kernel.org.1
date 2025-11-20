Return-Path: <stable+bounces-195367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE8DC75917
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 180E2342C39
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865012D94B8;
	Thu, 20 Nov 2025 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb1HZ8s5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAC26ED3D
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 17:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763658605; cv=none; b=alFSB0SVy1vHQ5Az1lmfeUTONih0AcYkjcN96LKZ+EXOgRKL1ROSIxBoHaNWVZXxGgNV6Y8POZf3CsfqkJ1I28nCftgj7WSzmFPdLALp904td038qaRefn2QIcuX3uXmQLyek8miSZOuT57EIxtrbuFtOSrDdE6FF4nDWi8xAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763658605; c=relaxed/simple;
	bh=Q7IhZ/WcTKf0tbZXJwA61O6aYDNBn3lOrDPLLLdbY0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUkFRSCxJkmLm1LFC+ET8uQN56wEWd8xuk+4+yClhTD6CdbqPu/aZ1kETc00bI3tBgiVT56ZXvhetyAvApHvnLxu+qYiJQGxCP5s+tojfmtUJTR+QXgO+EiBHWVp5tgUPF0oztY/qPdYpVTKX2AdAiviw2OV+p1FKgBiEcWNNto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb1HZ8s5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5118C4CEF1;
	Thu, 20 Nov 2025 17:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763658603;
	bh=Q7IhZ/WcTKf0tbZXJwA61O6aYDNBn3lOrDPLLLdbY0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sb1HZ8s5NUwAIsSmxiSxtzKDUqd63+vSvaFZUfqF0UjnDvk00GaJ0hfCC312jdntb
	 CVPrGRn3THS6T4F9HNbwqc3vaSUBGYA6wvY6PesFam8GqX/eH0SP+ck8T8H/sbBAb4
	 hPOojuRSdiMrb7rCY8Pu4A74KAgRJ3IGLfC7wAFVQIBVznhs1bTR4CeHa//xSg06Nc
	 fGXZBCtcXcQE+K/nzRklZrbWWX72LWqxdGTd8ojVyYhRmrUlOQ2URltsTcD1tovtWe
	 sstMFRxt4jMYXTkLmNLH6RiHayMNxTixbiHWvg7k9iryarAo9ObCyMN2mn3vtyY8iu
	 UfwQcSyLA+GGA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 243C0F4006F;
	Thu, 20 Nov 2025 12:10:02 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 20 Nov 2025 12:10:02 -0500
X-ME-Sender: <xms:aUsfabN6PA05D-iYE1c6wERPTKysb0ILkR1iC0bhrEZcB8SU1tkdxQ>
    <xme:aUsfaR1fBCy2y2m_16GFC0zLn4ZUuJCGbdBSLthW4taE2hQE8ISXyMx11f_3E49BC
    6sxqOMguE5l8QQYpMvIEY20nRw51VIpcUNdT49GRKZABv2YJiqsyfg>
X-ME-Received: <xmr:aUsfaVx0IImV602bVDMUUmbKkajMmyngrLvYtZ-_yjotCm41io_Z_YekF5iBMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejieehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:aUsfaTodn-usxBqido6UhBvN64_BEfbyJ5dvvF0Vb13WuxovPT6eEw>
    <xmx:aUsfabVG5f9uAoXAONsjxD0WGvHzQPDHHAMXDyyTSdZDIQWd6euorA>
    <xmx:aUsfaapPXdf-FZ2r5Y6qAKPqD9VbVrUHUYTDkL8uKn0sadmXm-cd0g>
    <xmx:aUsfafHIz278scZW1yvvxMR7s1Wf4HDD9rC5qtz8LouQlwU1gLu5oQ>
    <xmx:aksfacvIO-OjHLzOoio3OT_xtxBw7UMeTa_dvFcQ3o3wH-_I6g3EnqR3>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 12:10:01 -0500 (EST)
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
Subject: [PATCH 6.12.y] mm/memory: do not populate page table entries beyond i_size
Date: Thu, 20 Nov 2025 17:09:58 +0000
Message-ID: <20251120170958.923747-1-kas@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112023-nearest-surname-60bf@gregkh>
References: <2025112023-nearest-surname-60bf@gregkh>
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
 mm/memory.c  | 23 +++++++++++++++++++++--
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ec69fadf014c..d8d9c0f0beb6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3653,13 +3653,27 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	vm_fault_t ret = 0;
 	unsigned long rss = 0;
 	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved, folio_type;
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
@@ -3672,10 +3686,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		goto out;
 	}
 
-	file_end = DIV_ROUND_UP(i_size_read(mapping->host), PAGE_SIZE) - 1;
-	if (end_pgoff > file_end)
-		end_pgoff = file_end;
-
 	folio_type = mm_counter_file(folio);
 	do {
 		unsigned long end;
diff --git a/mm/memory.c b/mm/memory.c
index b6daa0e673a5..090e9c6f9992 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -68,6 +68,7 @@
 #include <linux/gfp.h>
 #include <linux/migrate.h>
 #include <linux/string.h>
+#include <linux/shmem_fs.h>
 #include <linux/memory-tiers.h>
 #include <linux/debugfs.h>
 #include <linux/userfaultfd_k.h>
@@ -5088,6 +5089,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	else
 		page = vmf->page;
 
+	folio = page_folio(page);
+
 	/*
 	 * check even for read faults because we might have lost our CoWed
 	 * page
@@ -5098,8 +5101,25 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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
@@ -5111,7 +5131,6 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 			return VM_FAULT_OOM;
 	}
 
-	folio = page_folio(page);
 	nr_pages = folio_nr_pages(folio);
 
 	/*
-- 
2.51.0



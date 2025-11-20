Return-Path: <stable+bounces-195364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDF1C757C0
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 17:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 167794E1289
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B586369992;
	Thu, 20 Nov 2025 16:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQTBv8D9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8B226F2AB
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763657180; cv=none; b=Sy24ojTiwm2TZr2dosAwGlh0hsfnMUJFTs/ly0B4IhBlZd5teF7kgFMiRjaOoLE8XtqhHfRZwB1zl5DnpKxKRoiMD5GZ0RZDoPkqMPmmFxR3CL+GZLXGMve7u0HEbHbTjHhL+WSNBB3b6gLagrX7wDlHzmx13ZldGU1TAP/iOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763657180; c=relaxed/simple;
	bh=OIDZRc6z50lS8/vY0dunwCxYWDBz6fVZNVZ3yZkHU0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oy0cV0Dvr5f+Wv191E0HwnyyNGHZydE7b3cS/Tx9ErVmwSg0Ir4r7loV6a9AhJTQTTBgnYQwuYwpL3Zay4g8XUUvkws+X4OAMhIgiazhdgRjHSbH6BdoK3uyZf1l+r5RDXi0agOut2HfsvxCKLzmjKEqwGCKCAa7wLffPbaF3KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQTBv8D9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C953C116C6;
	Thu, 20 Nov 2025 16:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763657180;
	bh=OIDZRc6z50lS8/vY0dunwCxYWDBz6fVZNVZ3yZkHU0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fQTBv8D9SutpojvS7XJBW4rCdUZVyXM6qTOgaY4AakXiRw714SXTqicZiVfOtZj48
	 h9ieZ5iT+PxpDDMbNavgrV8gmBiYVOTvl/0gcSjjNajnRp5vOKzhzgI1f23p0548al
	 tU+HTutleR4TbXBaWeWFfFzMLyHJlGud/5iRlq13qNcCJs8gvR9HMKtuT26IVd251G
	 tWGO4hwGA96kUWNBLImkjL8ReEedpErjZf37h3ON0jBHLtixhdbLAFLrzrViIqj6OV
	 xokyD1IP8MnqmveduENTl3FYJbpcSAVPXeseIK0zVMJR888mR35lLrZsjM2Fjt2U+N
	 tQv9XJYWPwqLQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id A61DEF4007A;
	Thu, 20 Nov 2025 11:46:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 20 Nov 2025 11:46:18 -0500
X-ME-Sender: <xms:2kUfafyE6Ad6gUiWVJFGWa-4_3Z1h2apivKqly-_bBCXujW5n_QViA>
    <xme:2kUfaTJWzkEAxW8Cy96sp2B_fS4JKGd91Shb8y3Lx56MZgvqBmp5tjj6w5PMS_FqI
    QKpRxmUglUYpV81hnWEQzH7_nadJR1-IvJPihW5VNehNBUQRtKg1uM>
X-ME-Received: <xmr:2kUfaU2Gd0Gm-Eety-x8WxOPvJ80jyy5h2_KbT16YNq4tLloRlyIQQoUb2EAIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdejiedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2kUfaddG_CoEOpIupR7oaiVtYzyPWfpYkSjSFxmrH4xt0gdmXJrw8A>
    <xmx:2kUfaY4MrzDWX5zotf1EGbZ-MPZ4EZL-KqgPtYXlMcrOR2fi7_56rg>
    <xmx:2kUfaQ-DE3f1RLcGogyEkygo2TdBzftl5ZH-2euwyrloz3TLZp5JUw>
    <xmx:2kUfafJorBitWNubzfyj584wDcBnr_a_gbrpN7GfXoZRw3TWtrO-Ug>
    <xmx:2kUfaTjP2MyOOTeVPW1WzJkKC4xarVzmd8EOE9SCIapLUh4NuLefyPVO>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 11:46:18 -0500 (EST)
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
Subject: [PATCH 6.17.y] mm/memory: do not populate page table entries beyond i_size
Date: Thu, 20 Nov 2025 16:46:12 +0000
Message-ID: <20251120164612.886562-1-kas@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112022-pretender-version-d5b3@gregkh>
References: <2025112022-pretender-version-d5b3@gregkh>
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
 mm/memory.c  | 20 +++++++++++++++++++-
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 751838ef05e5..bef514b60e0b 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3743,13 +3743,27 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
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
@@ -3762,10 +3776,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
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
index 0ba4f6b71847..75f3b66be1d3 100644
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
@@ -5371,8 +5372,25 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
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
-- 
2.51.0



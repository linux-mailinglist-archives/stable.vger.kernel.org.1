Return-Path: <stable+bounces-206424-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E783AD0716B
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 05:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC4F43019B70
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 04:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157CE289367;
	Fri,  9 Jan 2026 04:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TNIG/Gos"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCB6500954
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 04:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767932042; cv=none; b=m48I/KYzJTlATl68mTZxMBhjOPY+dy4p3WQQ4ZHI03qhfrJaErj/CLZbNNfO73medacYpZkU5QNxo43RORfLTaWli7bd1Skm5jHC0nKL+b/mzuLg4BOdlqyNzw6G0Z2tAT1MB8xPgB6PhsehnMkms+jnrWfxi/a4NkJSVVdte6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767932042; c=relaxed/simple;
	bh=DrRom7klkMIepJ/r23WkZLnmYIrBwnkMmo96lSEAU8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kccZRshBIdLYQAqhKyOpXa1oITIL7mha/WOPyvhci+XDzrUjcFOxxLaEblBeXKfRJk7QLbf3Wzf9OJP1WmlbufGzWemQic13LlGDewuYnsD2RmxpAjQZdNAoryMyk8q796+grq5Ms+mYXfS2se8sXHccKi6fgYBRL8bVbMBk5ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TNIG/Gos; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=DMbIllXPZRvlt/Vq1jHDivI39JQ08MkhrR5WF1TvH2M=; b=TNIG/Gosy2N8vxkkL1w8SxcGpu
	oYizC8kZLbTdRLqdJvWI5cPLbizAdoRPGH3i+d0Inra803EuYArZ2q1dmcNg68mszc1SiCDKC1XyR
	Th2098cnOWBF4IN3ovqmBGs5XH/eWj3ZELlAaazikFvy+xH/xKl+Y1NiA0agVANZHKiVKwMAuWSxF
	nW2wQG9Ia0YuPmuF79pfDWKc4VO9Gkj9xz7zmBl0OMkM0cKr+9nZ+mV9F1UOvb/mAgVA02SCrLnZG
	gR8fEIqhYEdpmdc5FQ2U9z3Pp14QiDqqL4KAx5UYSGXscDFP3IHJagfNmwH2zHbvRbwcW09QaTUxI
	AHweH8ig==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve3sh-0000000GCy8-2Ucu;
	Fri, 09 Jan 2026 04:13:47 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Jann Horn <jannh@google.com>,
	linux-mm@kvack.org,
	syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] migrate: Correct lock ordering for hugetlb file folios
Date: Fri,  9 Jan 2026 04:13:42 +0000
Message-ID: <20260109041345.3863089-2-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109041345.3863089-1-willy@infradead.org>
References: <20260109041345.3863089-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot has found a deadlock (analyzed by Lance Yang):

1) Task (5749): Holds folio_lock, then tries to acquire i_mmap_rwsem(read lock).
2) Task (5754): Holds i_mmap_rwsem(write lock), then tries to acquire
folio_lock.

migrate_pages()
  -> migrate_hugetlbs()
    -> unmap_and_move_huge_page()     <- Takes folio_lock!
      -> remove_migration_ptes()
        -> __rmap_walk_file()
          -> i_mmap_lock_read()       <- Waits for i_mmap_rwsem(read lock)!

hugetlbfs_fallocate()
  -> hugetlbfs_punch_hole()           <- Takes i_mmap_rwsem(write lock)!
    -> hugetlbfs_zero_partial_page()
     -> filemap_lock_hugetlb_folio()
      -> filemap_lock_folio()
        -> __filemap_get_folio        <- Waits for folio_lock!

The migration path is the one taking locks in the wrong order according
to the documentation at the top of mm/rmap.c.  So expand the scope of the
existing i_mmap_lock to cover the calls to remove_migration_ptes() too.

This is (mostly) how it used to be after commit c0d0381ade79.  That was
removed by 336bf30eb765 for both file & anon hugetlb pages when it should
only have been removed for anon hugetlb pages.

Fixes: 336bf30eb765 (hugetlbfs: fix anon huge page migration race)
Reported-by: syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/68e9715a.050a0220.1186a4.000d.GAE@google.com
Debugged-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: stable@vger.kernel.org
---
 mm/migrate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 5169f9717f60..4688b9e38cd2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1458,6 +1458,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
+	enum ttu_flags ttu = 0;
 
 	if (folio_ref_count(src) == 1) {
 		/* page was freed from under us. So we are done. */
@@ -1498,8 +1499,6 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 		goto put_anon;
 
 	if (folio_mapped(src)) {
-		enum ttu_flags ttu = 0;
-
 		if (!folio_test_anon(src)) {
 			/*
 			 * In shared mappings, try_to_unmap could potentially
@@ -1516,16 +1515,17 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 
 		try_to_migrate(src, ttu);
 		page_was_mapped = 1;
-
-		if (ttu & TTU_RMAP_LOCKED)
-			i_mmap_unlock_write(mapping);
 	}
 
 	if (!folio_mapped(src))
 		rc = move_to_new_folio(dst, src, mode);
 
 	if (page_was_mapped)
-		remove_migration_ptes(src, !rc ? dst : src, 0);
+		remove_migration_ptes(src, !rc ? dst : src,
+				ttu ? RMP_LOCKED : 0);
+
+	if (ttu & TTU_RMAP_LOCKED)
+		i_mmap_unlock_write(mapping);
 
 unlock_put_anon:
 	folio_unlock(dst);
-- 
2.47.3



Return-Path: <stable+bounces-206423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BD8D07102
	for <lists+stable@lfdr.de>; Fri, 09 Jan 2026 05:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51A9A3030228
	for <lists+stable@lfdr.de>; Fri,  9 Jan 2026 04:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C8529AB1A;
	Fri,  9 Jan 2026 04:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G4sokARz"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB00E1F03D2
	for <stable@vger.kernel.org>; Fri,  9 Jan 2026 04:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767931782; cv=none; b=cVUAwz5xAH3kfhANI8GY2DLm08Eay2NxpA2wgY6JON/HdJ/WyFN5sqvu/WblOHxz9UlMqg0VST6jpcGG+/++r271si/WCGUdezfwUUKyDVaOFqMt4Quu4xdCStQORiDft+7XeozFlaL7zrFGMqfSXBttr0pLU7O0OjWFHqn3xKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767931782; c=relaxed/simple;
	bh=DrRom7klkMIepJ/r23WkZLnmYIrBwnkMmo96lSEAU8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNyKWT3NvJF3zdNrCxd/NYG6wQR2DlzziQlkWQc57BiC141jpHv+IMR83+VhTdxRm6K54FttUpKsUGdESMxKcUdbcqgXobRcoSSz14ayze7SU/TmRU2Tu3FUXV+aSnTRCd7mRi3OhE66IdcdJDedy/gWYE/i5Uu1PL5DN6S5U1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G4sokARz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=DMbIllXPZRvlt/Vq1jHDivI39JQ08MkhrR5WF1TvH2M=; b=G4sokARzEBZNaFfIq+GtnvbKxF
	eSifVHELqbUgliDsEmfxkIf8cqMzLwPE73giMvOVLhFwdQVh37scw8qbprb2NktNZ8P8rv5VErPP+
	LphPdUZRmIkKD1WX820buM+MTWYJkXGaJ1FqSik/WzfvxDKJ1kTp4PL2B6/oTYRhvTeAQwfbA/2Jv
	FQxk2MNrfH8kbgkbUS2faQAu065S6sl89gUPKfOjdEjmmVKSZpYcdQSDyWNU7Kl5IBKYLdDMC9HPu
	WKGmFMDKn53dCAAuMwp70pTCgd/B06DrMkuGYls9CfEWN2NJeQoQErVD3G+vTzRoKbqdoclGD3oJs
	GFvJayBw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve3og-0000000GChm-3RgX;
	Fri, 09 Jan 2026 04:09:38 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: 
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Zi Yan <ziy@nvidia.com>,
	syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] migrate: Correct lock ordering for hugetlb file folios
Date: Fri,  9 Jan 2026 04:09:33 +0000
Message-ID: <20260109040936.3862042-2-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260109040936.3862042-1-willy@infradead.org>
References: <20260109040936.3862042-1-willy@infradead.org>
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



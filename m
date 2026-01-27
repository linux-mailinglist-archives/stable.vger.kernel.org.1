Return-Path: <stable+bounces-211831-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gEGbL/DLeGmNtQEAu9opvQ
	(envelope-from <stable+bounces-211831-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:30:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E7695B58
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AC2730131DA
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88981357A48;
	Tue, 27 Jan 2026 14:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="klIOYXtt"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907B350285
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523893; cv=none; b=NEbXfoN+b91fyvGlsftCPWP+epgcFU/QeS5QmgBeDJ85iAUFYrFdObiu6xm5yD7tJm95U3dwKc52X2wpre8dgmjbodsCLZFyjgglwNQwQZ69CucdRnh7G9G0mfKLEN3m1szE4/BcAa7fUmmwpn1CKdr+smwKvfpL4cUl6F1oiY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523893; c=relaxed/simple;
	bh=YPzFNtlfW4++vbdLyuWLoT3MoQq96AOMwvHVmgq2LP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhgb3KmfZRlQKalE8nkzugX3K6QKHOAHJ05Fto1B1L10GvQBqau0QDJPnddn0MGYARdhAoAT+sC6OT+hwD7e+FLGueFAKPi4Zm9PiMA/DoIAj66NMUJEktETEFiEpr8CP7VVS79OOk42prcM5TU9U11FwCl9MgsTtdrc4HtcUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=klIOYXtt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=MiofUhH/e+86UOwqVLcfN/bdlFcNM5NOwi2IhuUrk3g=; b=klIOYXtta4w7kYDc0F18/97xGA
	jaA3PlLZq7NhFrUGrwtvfl4+G/ZrtgkeQeqOrxo59Z23i85PvvC1gGgmY8MPRgV1u1l8JujpBTlGr
	WcnhDJWBrnPm6mOT+PIh4GPovEONdFOWxBHRf0WtKE9sjtMTeXwQuQAHg8PQzbolGx5E8xCFhuyin
	e461OFgDx3n6yAuR2sGnB0j45MkB/V909XOdY6znE7/5uodXDN0PW/uTmIK1YDodbj4k/GVJdWpIL
	DHbkVsdK1k3scFnzM3pDGvu9GU2Hf5Aqpuz7S40U/UlDZN6QztqtB6ou6kvY8vDc5g8UN1fd54hPF
	EHPCUY3w==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkjzs-00000007YMi-3fWI;
	Tue, 27 Jan 2026 14:24:48 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com,
	Lance Yang <lance.yang@linux.dev>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Alistair Popple <apopple@nvidia.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Jann Horn <jannh@google.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Liam Howlett <liam.howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Rik van Riel <riel@surriel.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.10.y] migrate: correct lock ordering for hugetlb file folios
Date: Tue, 27 Jan 2026 14:24:44 +0000
Message-ID: <20260127142444.1800351-1-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012709-jubilant-divinely-3a32@gregkh>
References: <2026012709-jubilant-divinely-3a32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211831-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[infradead.org,syzkaller.appspotmail.com,linux.dev,kernel.org,nvidia.com,sk.com,gourry.net,google.com,gmail.com,oracle.com,intel.com,surriel.com,suse.cz,linux.alibaba.com,linux-foundation.org];
	DKIM_TRACE(0.00)[infradead.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable,2d9c96466c978346b55f];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[surriel.com:email,infradead.org:email,infradead.org:dkim,infradead.org:mid,sk.com:email,linux.dev:email,alibaba.com:email,intel.com:email,suse.cz:email,nvidia.com:email,gourry.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,oracle.com:email]
X-Rspamd-Queue-Id: 51E7695B58
X-Rspamd-Action: no action

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

The migration path is the one taking locks in the wrong order according to
the documentation at the top of mm/rmap.c.  So expand the scope of the
existing i_mmap_lock to cover the calls to remove_migration_ptes() too.

This is (mostly) how it used to be after commit c0d0381ade79.  That was
removed by 336bf30eb765 for both file & anon hugetlb pages when it should
only have been removed for anon hugetlb pages.

Link: https://lkml.kernel.org/r/20260109041345.3863089-2-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Fixes: 336bf30eb765 ("hugetlbfs: fix anon huge page migration race")
Reported-by: syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/68e9715a.050a0220.1186a4.000d.GAE@google.com
Debugged-by: Lance Yang <lance.yang@linux.dev>
Acked-by: David Hildenbrand (Red Hat) <david@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Gregory Price <gourry@gourry.net>
Cc: Jann Horn <jannh@google.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Rik van Riel <riel@surriel.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit b7880cb166ab62c2409046b2347261abf701530e)
---
 mm/migrate.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index aafad2112ec8..bf59b09455ad 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1289,6 +1289,7 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 	struct page *new_hpage;
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
+	enum ttu_flags ttu = TTU_MIGRATION|TTU_IGNORE_MLOCK;
 
 	/*
 	 * Migratability of hugepages depends on architectures and their size.
@@ -1336,9 +1337,6 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 		goto put_anon;
 
 	if (page_mapped(hpage)) {
-		bool mapping_locked = false;
-		enum ttu_flags ttu = TTU_MIGRATION|TTU_IGNORE_MLOCK;
-
 		if (!PageAnon(hpage)) {
 			/*
 			 * In shared mappings, try_to_unmap could potentially
@@ -1350,15 +1348,11 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 			if (unlikely(!mapping))
 				goto unlock_put_anon;
 
-			mapping_locked = true;
 			ttu |= TTU_RMAP_LOCKED;
 		}
 
 		try_to_unmap(hpage, ttu);
 		page_was_mapped = 1;
-
-		if (mapping_locked)
-			i_mmap_unlock_write(mapping);
 	}
 
 	if (!page_mapped(hpage))
@@ -1366,7 +1360,11 @@ static int unmap_and_move_huge_page(new_page_t get_new_page,
 
 	if (page_was_mapped)
 		remove_migration_ptes(hpage,
-			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage, false);
+			rc == MIGRATEPAGE_SUCCESS ? new_hpage : hpage,
+				(ttu & TTU_RMAP_LOCKED) ? true : false);
+
+	if (ttu & TTU_RMAP_LOCKED)
+		i_mmap_unlock_write(mapping);
 
 unlock_put_anon:
 	unlock_page(new_hpage);
-- 
2.47.3



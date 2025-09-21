Return-Path: <stable+bounces-180814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE02B8DCE3
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 16:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C77921898625
	for <lists+stable@lfdr.de>; Sun, 21 Sep 2025 14:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBAF1A9F97;
	Sun, 21 Sep 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVG9bCyI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3A19DF4D
	for <stable@vger.kernel.org>; Sun, 21 Sep 2025 14:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758465599; cv=none; b=h/f/H5nlyYFGJMee7cE8uanblRiPgRO6e+xSnqdUiYBmhiEXW88KEO16jWDmo9bBqJeUbtUmNTl9lSn9fx9iZaqOLkmeWLfL6w05Z9//vYEemiKFff7lCEm6XlwpYC1mSr8ed/PpM/54Ud30bS+iPl1f2eL2S9vBgH7SLH0mwOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758465599; c=relaxed/simple;
	bh=Fm2Au5vxmYCrZatyRno5/Xy3baHBynsqLtYkWDkNcxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGVlMQe1Zuop979NVwYdf3ffLLxEXu83BskyidZGlLsGLEVfRZjEopSs9/hpK2R/AZRj/32DIS7AlqRueaGimkLNhdqJD4pb/t+IxXdPWpzW/dHO5FIliiTK8z6dpTBNQECHxE9vTRQeRfiWkk9CMH9+DdEOIqYIGef9hwSgVEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uVG9bCyI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0B5C4CEE7;
	Sun, 21 Sep 2025 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758465598;
	bh=Fm2Au5vxmYCrZatyRno5/Xy3baHBynsqLtYkWDkNcxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uVG9bCyIvRIBfn+rRN5Rcx1yxjbJemTjVc0MF077oFC0Fp+DHlUJxG3GNUk0Dotbi
	 W58Ay3hJugAfevmnrY9vQmZqzPe/3pSREH8khg5Wi87e84z6khECOqAJ7ZSvzHyY7P
	 fyobPgp7DoPRxwNKeQpVyowAqkXbkcF36uQihs1e7oirR0skU+G51tg0PleFHtilbj
	 NbhHtz/RZyV8UK2CY5M6VmarSaSt2yNkNA1WAHfOzYydx/gdUHfRkK9PvoWBHGWJ2L
	 q+TxxtqO5M+xBA7Z2GDMiK6Po+OEaVvuu2RwQV91AfzJ2CvYT1vfBsCKdN7fh71wQk
	 5oJQm/8e3T8KA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Shivank Garg <shivankg@amd.com>,
	David Hildenbrand <david@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alistair Popple <apopple@nvidia.com>,
	Dave Kleikamp <shaggy@kernel.org>,
	Donet Tom <donettom@linux.ibm.com>,
	Jane Chu <jane.chu@oracle.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] mm: add folio_expected_ref_count() for reference count calculation
Date: Sun, 21 Sep 2025 10:39:53 -0400
Message-ID: <20250921143954.2925079-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025092158-payee-omega-5893@gregkh>
References: <2025092158-payee-omega-5893@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shivank Garg <shivankg@amd.com>

[ Upstream commit 86ebd50224c0734d965843260d0dc057a9431c61 ]

Patch series " JFS: Implement migrate_folio for jfs_metapage_aops" v5.

This patchset addresses a warning that occurs during memory compaction due
to JFS's missing migrate_folio operation.  The warning was introduced by
commit 7ee3647243e5 ("migrate: Remove call to ->writepage") which added
explicit warnings when filesystem don't implement migrate_folio.

The syzbot reported following [1]:
  jfs_metapage_aops does not implement migrate_folio
  WARNING: CPU: 1 PID: 5861 at mm/migrate.c:955 fallback_migrate_folio mm/migrate.c:953 [inline]
  WARNING: CPU: 1 PID: 5861 at mm/migrate.c:955 move_to_new_folio+0x70e/0x840 mm/migrate.c:1007
  Modules linked in:
  CPU: 1 UID: 0 PID: 5861 Comm: syz-executor280 Not tainted 6.15.0-rc1-next-20250411-syzkaller #0 PREEMPT(full)
  Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
  RIP: 0010:fallback_migrate_folio mm/migrate.c:953 [inline]
  RIP: 0010:move_to_new_folio+0x70e/0x840 mm/migrate.c:1007

To fix this issue, this series implement metapage_migrate_folio() for JFS
which handles both single and multiple metapages per page configurations.

While most filesystems leverage existing migration implementations like
filemap_migrate_folio(), buffer_migrate_folio_norefs() or
buffer_migrate_folio() (which internally used folio_expected_refs()),
JFS's metapage architecture requires special handling of its private data
during migration.  To support this, this series introduce the
folio_expected_ref_count(), which calculates external references to a
folio from page/swap cache, private data, and page table mappings.

This standardized implementation replaces the previous ad-hoc
folio_expected_refs() function and enables JFS to accurately determine
whether a folio has unexpected references before attempting migration.

Implement folio_expected_ref_count() to calculate expected folio reference
counts from:
- Page/swap cache (1 per page)
- Private data (1)
- Page table mappings (1 per map)

While originally needed for page migration operations, this improved
implementation standardizes reference counting by consolidating all
refcount contributors into a single, reusable function that can benefit
any subsystem needing to detect unexpected references to folios.

The folio_expected_ref_count() returns the sum of these external
references without including any reference the caller itself might hold.
Callers comparing against the actual folio_ref_count() must account for
their own references separately.

Link: https://syzkaller.appspot.com/bug?extid=8bb6fd945af4e0ad9299 [1]
Link: https://lkml.kernel.org/r/20250430100150.279751-1-shivankg@amd.com
Link: https://lkml.kernel.org/r/20250430100150.279751-2-shivankg@amd.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Shivank Garg <shivankg@amd.com>
Suggested-by: Matthew Wilcox <willy@infradead.org>
Co-developed-by: David Hildenbrand <david@redhat.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: Donet Tom <donettom@linux.ibm.com>
Cc: Jane Chu <jane.chu@oracle.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Zi Yan <ziy@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 98c6d259319e ("mm/gup: check ref_count instead of lru before migration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mm.h | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 mm/migrate.c       | 22 ++++---------------
 2 files changed, 59 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index deeb535f920c8..41f5c88bdf3bc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2200,6 +2200,61 @@ static inline bool folio_likely_mapped_shared(struct folio *folio)
 	return atomic_read(&folio->_mapcount) > 0;
 }
 
+/**
+ * folio_expected_ref_count - calculate the expected folio refcount
+ * @folio: the folio
+ *
+ * Calculate the expected folio refcount, taking references from the pagecache,
+ * swapcache, PG_private and page table mappings into account. Useful in
+ * combination with folio_ref_count() to detect unexpected references (e.g.,
+ * GUP or other temporary references).
+ *
+ * Does currently not consider references from the LRU cache. If the folio
+ * was isolated from the LRU (which is the case during migration or split),
+ * the LRU cache does not apply.
+ *
+ * Calling this function on an unmapped folio -- !folio_mapped() -- that is
+ * locked will return a stable result.
+ *
+ * Calling this function on a mapped folio will not result in a stable result,
+ * because nothing stops additional page table mappings from coming (e.g.,
+ * fork()) or going (e.g., munmap()).
+ *
+ * Calling this function without the folio lock will also not result in a
+ * stable result: for example, the folio might get dropped from the swapcache
+ * concurrently.
+ *
+ * However, even when called without the folio lock or on a mapped folio,
+ * this function can be used to detect unexpected references early (for example,
+ * if it makes sense to even lock the folio and unmap it).
+ *
+ * The caller must add any reference (e.g., from folio_try_get()) it might be
+ * holding itself to the result.
+ *
+ * Returns the expected folio refcount.
+ */
+static inline int folio_expected_ref_count(const struct folio *folio)
+{
+	const int order = folio_order(folio);
+	int ref_count = 0;
+
+	if (WARN_ON_ONCE(folio_test_slab(folio)))
+		return 0;
+
+	if (folio_test_anon(folio)) {
+		/* One reference per page from the swapcache. */
+		ref_count += folio_test_swapcache(folio) << order;
+	} else if (!((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS)) {
+		/* One reference per page from the pagecache. */
+		ref_count += !!folio->mapping << order;
+		/* One reference from PG_private. */
+		ref_count += folio_test_private(folio);
+	}
+
+	/* One reference per page table mapping. */
+	return ref_count + folio_mapcount(folio);
+}
+
 #ifndef HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
 static inline int arch_make_folio_accessible(struct folio *folio)
 {
diff --git a/mm/migrate.c b/mm/migrate.c
index 25e7438af968a..8619aa884eaa8 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -453,20 +453,6 @@ void pmd_migration_entry_wait(struct mm_struct *mm, pmd_t *pmd)
 }
 #endif
 
-static int folio_expected_refs(struct address_space *mapping,
-		struct folio *folio)
-{
-	int refs = 1;
-	if (!mapping)
-		return refs;
-
-	refs += folio_nr_pages(folio);
-	if (folio_test_private(folio))
-		refs++;
-
-	return refs;
-}
-
 /*
  * Replace the folio in the mapping.
  *
@@ -609,7 +595,7 @@ static int __folio_migrate_mapping(struct address_space *mapping,
 int folio_migrate_mapping(struct address_space *mapping,
 		struct folio *newfolio, struct folio *folio, int extra_count)
 {
-	int expected_count = folio_expected_refs(mapping, folio) + extra_count;
+	int expected_count = folio_expected_ref_count(folio) + extra_count + 1;
 
 	if (folio_ref_count(folio) != expected_count)
 		return -EAGAIN;
@@ -626,7 +612,7 @@ int migrate_huge_page_move_mapping(struct address_space *mapping,
 				   struct folio *dst, struct folio *src)
 {
 	XA_STATE(xas, &mapping->i_pages, folio_index(src));
-	int rc, expected_count = folio_expected_refs(mapping, src);
+	int rc, expected_count = folio_expected_ref_count(src) + 1;
 
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
@@ -756,7 +742,7 @@ static int __migrate_folio(struct address_space *mapping, struct folio *dst,
 			   struct folio *src, void *src_private,
 			   enum migrate_mode mode)
 {
-	int rc, expected_count = folio_expected_refs(mapping, src);
+	int rc, expected_count = folio_expected_ref_count(src) + 1;
 
 	/* Check whether src does not have extra refs before we do more work */
 	if (folio_ref_count(src) != expected_count)
@@ -844,7 +830,7 @@ static int __buffer_migrate_folio(struct address_space *mapping,
 		return migrate_folio(mapping, dst, src, mode);
 
 	/* Check whether page does not have extra refs before we do more work */
-	expected_count = folio_expected_refs(mapping, src);
+	expected_count = folio_expected_ref_count(src) + 1;
 	if (folio_ref_count(src) != expected_count)
 		return -EAGAIN;
 
-- 
2.51.0



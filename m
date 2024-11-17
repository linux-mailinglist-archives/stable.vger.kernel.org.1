Return-Path: <stable+bounces-93727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3E39D05DD
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 21:34:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6872D1F21981
	for <lists+stable@lfdr.de>; Sun, 17 Nov 2024 20:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AEBD1DA618;
	Sun, 17 Nov 2024 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SSj88Dva"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3471CACE0
	for <stable@vger.kernel.org>; Sun, 17 Nov 2024 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731875659; cv=none; b=VzGUYNERH+ZSfInY7yue5zeSpMw5LHXX/k9B1DBeA+75vV6+0l3J9ye3ScKGKjkEznduDEg2g91wWVK3HLorLUxhClQ6woGaUYAqdQ9nDwttl1bjk+TcCYgxgxh1s/x8GQGoBm+raZdVv67ASLAxjjJ8XWJiZm518wd1BvagSIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731875659; c=relaxed/simple;
	bh=hHHCnGpNyElkGdtBRwbJd0c9pYHYVbryYSD61j15KjE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kkhEK9wZK6NvjSax8b34xjmwQ5zLVtQAMl4Stq+Ahwbjt1FjEoTTNmZ6moj6+3cWMur5KFaDSe4Vv9cg1QVvngtnWpHmvtJPgMlIAKHEMGYY1sfO4AVB5n5q2v6DzrQYQoRNLg6UWAw9zOOCgqgeT6IiQ/BsD/CnpIF7uezxN8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SSj88Dva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D386FC4CECD;
	Sun, 17 Nov 2024 20:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731875659;
	bh=hHHCnGpNyElkGdtBRwbJd0c9pYHYVbryYSD61j15KjE=;
	h=Subject:To:Cc:From:Date:From;
	b=SSj88Dva3h0EXF6nX17lNoZEJK3t69VKryehFAYJYiuuUyxAdZg45YojKZ8LL2lFs
	 xthD4fORYBO3mrM6RPQMiv/cFdb1weD2WZJDwZU428Jddi1Hb02AA7rDsAMSvwSJ93
	 MD6JIJ/K8oNJL2YVKY8h+ZwKMgmLO/7gLMPDdYx0=
Subject: FAILED: patch "[PATCH] mm/gup: avoid an unnecessary allocation call for" failed to apply to 6.11-stable tree
To: jhubbard@nvidia.com,airlied@redhat.com,akpm@linux-foundation.org,arnd@arndb.de,daniel.vetter@ffwll.ch,david@redhat.com,dongwon.kim@intel.com,hch@infradead.org,hughd@google.com,jgg@nvidia.com,junxiao.chang@intel.com,kraxel@redhat.com,osalvador@suse.de,peterx@redhat.com,stable@vger.kernel.org,vivek.kasireddy@intel.com,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 17 Nov 2024 21:33:54 +0100
Message-ID: <2024111754-stamina-flyer-1e05@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.11-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.11.y
git checkout FETCH_HEAD
git cherry-pick -x 94efde1d15399f5c88e576923db9bcd422d217f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024111754-stamina-flyer-1e05@gregkh' --subject-prefix 'PATCH 6.11.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 94efde1d15399f5c88e576923db9bcd422d217f2 Mon Sep 17 00:00:00 2001
From: John Hubbard <jhubbard@nvidia.com>
Date: Mon, 4 Nov 2024 19:29:44 -0800
Subject: [PATCH] mm/gup: avoid an unnecessary allocation call for
 FOLL_LONGTERM cases

commit 53ba78de064b ("mm/gup: introduce
check_and_migrate_movable_folios()") created a new constraint on the
pin_user_pages*() API family: a potentially large internal allocation must
now occur, for FOLL_LONGTERM cases.

A user-visible consequence has now appeared: user space can no longer pin
more than 2GB of memory anymore on x86_64.  That's because, on a 4KB
PAGE_SIZE system, when user space tries to (indirectly, via a device
driver that calls pin_user_pages()) pin 2GB, this requires an allocation
of a folio pointers array of MAX_PAGE_ORDER size, which is the limit for
kmalloc().

In addition to the directly visible effect described above, there is also
the problem of adding an unnecessary allocation.  The **pages array
argument has already been allocated, and there is no need for a redundant
**folios array allocation in this case.

Fix this by avoiding the new allocation entirely.  This is done by
referring to either the original page[i] within **pages, or to the
associated folio.  Thanks to David Hildenbrand for suggesting this
approach and for providing the initial implementation (which I've tested
and adjusted slightly) as well.

[jhubbard@nvidia.com: whitespace tweak, per David]
  Link: https://lkml.kernel.org/r/131cf9c8-ebc0-4cbb-b722-22fa8527bf3c@nvidia.com
[jhubbard@nvidia.com: bypass pofs_get_folio(), per Oscar]
  Link: https://lkml.kernel.org/r/c1587c7f-9155-45be-bd62-1e36c0dd6923@nvidia.com
Link: https://lkml.kernel.org/r/20241105032944.141488-2-jhubbard@nvidia.com
Fixes: 53ba78de064b ("mm/gup: introduce check_and_migrate_movable_folios()")
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Cc: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dongwon Kim <dongwon.kim@intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Junxiao Chang <junxiao.chang@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/gup.c b/mm/gup.c
index 4637dab7b54f..ad0c8922dac3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2273,20 +2273,57 @@ struct page *get_dump_page(unsigned long addr)
 #endif /* CONFIG_ELF_CORE */
 
 #ifdef CONFIG_MIGRATION
+
+/*
+ * An array of either pages or folios ("pofs"). Although it may seem tempting to
+ * avoid this complication, by simply interpreting a list of folios as a list of
+ * pages, that approach won't work in the longer term, because eventually the
+ * layouts of struct page and struct folio will become completely different.
+ * Furthermore, this pof approach avoids excessive page_folio() calls.
+ */
+struct pages_or_folios {
+	union {
+		struct page **pages;
+		struct folio **folios;
+		void **entries;
+	};
+	bool has_folios;
+	long nr_entries;
+};
+
+static struct folio *pofs_get_folio(struct pages_or_folios *pofs, long i)
+{
+	if (pofs->has_folios)
+		return pofs->folios[i];
+	return page_folio(pofs->pages[i]);
+}
+
+static void pofs_clear_entry(struct pages_or_folios *pofs, long i)
+{
+	pofs->entries[i] = NULL;
+}
+
+static void pofs_unpin(struct pages_or_folios *pofs)
+{
+	if (pofs->has_folios)
+		unpin_folios(pofs->folios, pofs->nr_entries);
+	else
+		unpin_user_pages(pofs->pages, pofs->nr_entries);
+}
+
 /*
  * Returns the number of collected folios. Return value is always >= 0.
  */
 static unsigned long collect_longterm_unpinnable_folios(
-					struct list_head *movable_folio_list,
-					unsigned long nr_folios,
-					struct folio **folios)
+		struct list_head *movable_folio_list,
+		struct pages_or_folios *pofs)
 {
 	unsigned long i, collected = 0;
 	struct folio *prev_folio = NULL;
 	bool drain_allow = true;
 
-	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = folios[i];
+	for (i = 0; i < pofs->nr_entries; i++) {
+		struct folio *folio = pofs_get_folio(pofs, i);
 
 		if (folio == prev_folio)
 			continue;
@@ -2327,16 +2364,15 @@ static unsigned long collect_longterm_unpinnable_folios(
  * Returns -EAGAIN if all folios were successfully migrated or -errno for
  * failure (or partial success).
  */
-static int migrate_longterm_unpinnable_folios(
-					struct list_head *movable_folio_list,
-					unsigned long nr_folios,
-					struct folio **folios)
+static int
+migrate_longterm_unpinnable_folios(struct list_head *movable_folio_list,
+				   struct pages_or_folios *pofs)
 {
 	int ret;
 	unsigned long i;
 
-	for (i = 0; i < nr_folios; i++) {
-		struct folio *folio = folios[i];
+	for (i = 0; i < pofs->nr_entries; i++) {
+		struct folio *folio = pofs_get_folio(pofs, i);
 
 		if (folio_is_device_coherent(folio)) {
 			/*
@@ -2344,7 +2380,7 @@ static int migrate_longterm_unpinnable_folios(
 			 * convert the pin on the source folio to a normal
 			 * reference.
 			 */
-			folios[i] = NULL;
+			pofs_clear_entry(pofs, i);
 			folio_get(folio);
 			gup_put_folio(folio, 1, FOLL_PIN);
 
@@ -2363,8 +2399,8 @@ static int migrate_longterm_unpinnable_folios(
 		 * calling folio_isolate_lru() which takes a reference so the
 		 * folio won't be freed if it's migrating.
 		 */
-		unpin_folio(folios[i]);
-		folios[i] = NULL;
+		unpin_folio(folio);
+		pofs_clear_entry(pofs, i);
 	}
 
 	if (!list_empty(movable_folio_list)) {
@@ -2387,12 +2423,26 @@ static int migrate_longterm_unpinnable_folios(
 	return -EAGAIN;
 
 err:
-	unpin_folios(folios, nr_folios);
+	pofs_unpin(pofs);
 	putback_movable_pages(movable_folio_list);
 
 	return ret;
 }
 
+static long
+check_and_migrate_movable_pages_or_folios(struct pages_or_folios *pofs)
+{
+	LIST_HEAD(movable_folio_list);
+	unsigned long collected;
+
+	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
+						       pofs);
+	if (!collected)
+		return 0;
+
+	return migrate_longterm_unpinnable_folios(&movable_folio_list, pofs);
+}
+
 /*
  * Check whether all folios are *allowed* to be pinned indefinitely (long term).
  * Rather confusingly, all folios in the range are required to be pinned via
@@ -2417,16 +2467,13 @@ static int migrate_longterm_unpinnable_folios(
 static long check_and_migrate_movable_folios(unsigned long nr_folios,
 					     struct folio **folios)
 {
-	unsigned long collected;
-	LIST_HEAD(movable_folio_list);
+	struct pages_or_folios pofs = {
+		.folios = folios,
+		.has_folios = true,
+		.nr_entries = nr_folios,
+	};
 
-	collected = collect_longterm_unpinnable_folios(&movable_folio_list,
-						       nr_folios, folios);
-	if (!collected)
-		return 0;
-
-	return migrate_longterm_unpinnable_folios(&movable_folio_list,
-						  nr_folios, folios);
+	return check_and_migrate_movable_pages_or_folios(&pofs);
 }
 
 /*
@@ -2436,22 +2483,13 @@ static long check_and_migrate_movable_folios(unsigned long nr_folios,
 static long check_and_migrate_movable_pages(unsigned long nr_pages,
 					    struct page **pages)
 {
-	struct folio **folios;
-	long i, ret;
+	struct pages_or_folios pofs = {
+		.pages = pages,
+		.has_folios = false,
+		.nr_entries = nr_pages,
+	};
 
-	folios = kmalloc_array(nr_pages, sizeof(*folios), GFP_KERNEL);
-	if (!folios) {
-		unpin_user_pages(pages, nr_pages);
-		return -ENOMEM;
-	}
-
-	for (i = 0; i < nr_pages; i++)
-		folios[i] = page_folio(pages[i]);
-
-	ret = check_and_migrate_movable_folios(nr_pages, folios);
-
-	kfree(folios);
-	return ret;
+	return check_and_migrate_movable_pages_or_folios(&pofs);
 }
 #else
 static long check_and_migrate_movable_pages(unsigned long nr_pages,



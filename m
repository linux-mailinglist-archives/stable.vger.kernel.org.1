Return-Path: <stable+bounces-189898-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEB8C0B7E3
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 00:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCBE19C0813
	for <lists+stable@lfdr.de>; Sun, 26 Oct 2025 23:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855A4301011;
	Sun, 26 Oct 2025 23:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4LTeqSH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428262F7444
	for <stable@vger.kernel.org>; Sun, 26 Oct 2025 23:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761522634; cv=none; b=uoFK3UCYZd0I9YwVGuZdCIeC76W7Pw3NnB+DhzWcG/Q0PC5TCu+MCb5zMvYemmeNj9R51zDGDVmSUpjUekegFXyTXAkYf0KmB8mCl0R7pZq3815JAMxBBYGoLT52VfsB0LjfNPvTG4GbFZ2VLXN8+1gn/D7R3a+O5fUCzAjj1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761522634; c=relaxed/simple;
	bh=Rvi+/itkwYCPMs6mJEMa2/X3sMfGbOYx1gVGRJZObpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/799OebyCNiUjkc0jqHin7VFea1+6enkKmfKArL8rYKRXRMCy2xZNxhGqFNbOT/xfUhhEPbHRbwZQ9Pel3g3jO037wl41wG9qHFSBIMuAwxYVVqy9K0iKVBqTD7jmUqOtZcAmKNo5cWCTRjqQ0kpAMrJDxvNpLXZqd/8XmuQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4LTeqSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9E4C4CEE7;
	Sun, 26 Oct 2025 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761522633;
	bh=Rvi+/itkwYCPMs6mJEMa2/X3sMfGbOYx1gVGRJZObpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4LTeqSHWGW+xy0zrXpBctppCIUYOdH+DTdOXS7J/zw0QVWrD8QIJcuiJSK9oOCun
	 oLVWIepEecPomrHwiJYbHUUpN25HwNTSGoKdS2p0Flf5MgIjWps7Mtsy5J4hWtYeNg
	 XcbaPQnyq9mhlzvJqZ8FZOgyve6V2qaWIsBGjexq4SfVwwfBcawONwDRqDbq1x7Kn4
	 pywl6RyMLTiFJowHpvRCGD2UKhOSzEGpdAyt5zUXSBN51BiIb6OTIKBhT6AniYy/5u
	 KVqKBEMTD9W3oR1a6jOFB6NcZqLMoKjbwSny6kLYRe2DXR6wNOKY5InJB3W7zmXhD3
	 pn8jV1+wH56pQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>,
	Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>,
	Alistair Popple <apopple@nvidia.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Byungchul Park <byungchul@sk.com>,
	Chris Mason <clm@fb.com>,
	Christian Brauner <brauner@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Kleikamp <shaggy@kernel.org>,
	David Sterba <dsterba@suse.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9=20rez?= <eperezma@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gregory Price <gourry@gourry.net>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Jason Wang <jasowang@redhat.com>,
	Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mathew Brost <matthew.brost@intel.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Minchan Kim <minchan@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Nicholas Piggin <npiggin@gmail.com>,
	Oscar Salvador <osalvador@suse.de>,
	Rakie Kim <rakie.kim@sk.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Dave Kleikamp <dave.kleikamp@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/3] mm/migrate: remove MIGRATEPAGE_UNMAP
Date: Sun, 26 Oct 2025 19:50:26 -0400
Message-ID: <20251026235028.289288-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102655-unequal-disown-9615@gregkh>
References: <2025102655-unequal-disown-9615@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 95c2908f1a4fd608b1cdbb5acef3572e5d769e1c ]

migrate_folio_unmap() is the only user of MIGRATEPAGE_UNMAP.  We want to
remove MIGRATEPAGE_* completely.

It's rather weird to have a generic MIGRATEPAGE_UNMAP, documented to be
returned from address-space callbacks, when it's only used for an internal
helper.

Let's start by having only a single "success" return value for
migrate_folio_unmap() -- 0 -- by moving the "folio was already freed"
check into the single caller.

There is a remaining comment for PG_isolated, which we renamed to
PG_movable_ops_isolated recently and forgot to update.

While we might still run into that case with zsmalloc, it's something we
want to get rid of soon.  So let's just focus that optimization on real
folios only for now by excluding movable_ops pages.  Note that concurrent
freeing can happen at any time and this "already freed" check is not
relevant for correctness.

[david@redhat.com: no need to pass "reason" to migrate_folio_unmap(), per Lance]
  Link: https://lkml.kernel.org/r/3bb725f8-28d7-4aa2-b75f-af40d5cab280@redhat.com
Link: https://lkml.kernel.org/r/20250811143949.1117439-2-david@redhat.com
Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Benjamin LaHaise <bcrl@kvack.org>
Cc: Byungchul Park <byungchul@sk.com>
Cc: Chris Mason <clm@fb.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dave Kleikamp <shaggy@kernel.org>
Cc: David Sterba <dsterba@suse.com>
Cc: Eugenio Pé rez <eperezma@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Gregory Price <gourry@gourry.net>
Cc: "Huang, Ying" <ying.huang@linux.alibaba.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Jerrin Shaji George <jerrin.shaji-george@broadcom.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mathew Brost <matthew.brost@intel.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 4ba5a8a7faa6 ("vmw_balloon: indicate success when effectively deflating during migration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/migrate.h |  1 -
 mm/migrate.c            | 45 ++++++++++++++++++++---------------------
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 9009e27b5f44c..302f3e95faeaa 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -18,7 +18,6 @@ struct migration_target_control;
  * - zero on page migration success;
  */
 #define MIGRATEPAGE_SUCCESS		0
-#define MIGRATEPAGE_UNMAP		1
 
 /**
  * struct movable_operations - Driver page migration
diff --git a/mm/migrate.c b/mm/migrate.c
index 4ff6eea0ef7ed..e38c933d0c376 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1188,7 +1188,7 @@ static void migrate_folio_done(struct folio *src,
 static int migrate_folio_unmap(new_folio_t get_new_folio,
 		free_folio_t put_new_folio, unsigned long private,
 		struct folio *src, struct folio **dstp, enum migrate_mode mode,
-		enum migrate_reason reason, struct list_head *ret)
+		struct list_head *ret)
 {
 	struct folio *dst;
 	int rc = -EAGAIN;
@@ -1197,16 +1197,6 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 	bool locked = false;
 	bool dst_locked = false;
 
-	if (folio_ref_count(src) == 1) {
-		/* Folio was freed from under us. So we are done. */
-		folio_clear_active(src);
-		folio_clear_unevictable(src);
-		/* free_pages_prepare() will clear PG_isolated. */
-		list_del(&src->lru);
-		migrate_folio_done(src, reason);
-		return MIGRATEPAGE_SUCCESS;
-	}
-
 	dst = get_new_folio(src, private);
 	if (!dst)
 		return -ENOMEM;
@@ -1296,7 +1286,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 
 	if (unlikely(page_has_movable_ops(&src->page))) {
 		__migrate_folio_record(dst, old_page_state, anon_vma);
-		return MIGRATEPAGE_UNMAP;
+		return 0;
 	}
 
 	/*
@@ -1326,7 +1316,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
 
 	if (!folio_mapped(src)) {
 		__migrate_folio_record(dst, old_page_state, anon_vma);
-		return MIGRATEPAGE_UNMAP;
+		return 0;
 	}
 
 out:
@@ -1869,14 +1859,27 @@ static int migrate_pages_batch(struct list_head *from,
 				continue;
 			}
 
+			/*
+			 * If we are holding the last folio reference, the folio
+			 * was freed from under us, so just drop our reference.
+			 */
+			if (likely(!page_has_movable_ops(&folio->page)) &&
+			    folio_ref_count(folio) == 1) {
+				folio_clear_active(folio);
+				folio_clear_unevictable(folio);
+				list_del(&folio->lru);
+				migrate_folio_done(folio, reason);
+				stats->nr_succeeded += nr_pages;
+				stats->nr_thp_succeeded += is_thp;
+				continue;
+			}
+
 			rc = migrate_folio_unmap(get_new_folio, put_new_folio,
-					private, folio, &dst, mode, reason,
-					ret_folios);
+					private, folio, &dst, mode, ret_folios);
 			/*
 			 * The rules are:
-			 *	Success: folio will be freed
-			 *	Unmap: folio will be put on unmap_folios list,
-			 *	       dst folio put on dst_folios list
+			 *	0: folio will be put on unmap_folios list,
+			 *	   dst folio put on dst_folios list
 			 *	-EAGAIN: stay on the from list
 			 *	-ENOMEM: stay on the from list
 			 *	Other errno: put on ret_folios list
@@ -1926,11 +1929,7 @@ static int migrate_pages_batch(struct list_head *from,
 				thp_retry += is_thp;
 				nr_retry_pages += nr_pages;
 				break;
-			case MIGRATEPAGE_SUCCESS:
-				stats->nr_succeeded += nr_pages;
-				stats->nr_thp_succeeded += is_thp;
-				break;
-			case MIGRATEPAGE_UNMAP:
+			case 0:
 				list_move_tail(&folio->lru, &unmap_folios);
 				list_add_tail(&dst->lru, &dst_folios);
 				break;
-- 
2.51.0



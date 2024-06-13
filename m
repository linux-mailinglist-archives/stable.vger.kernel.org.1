Return-Path: <stable+bounces-50877-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8A906D3E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 13:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6239A2868E1
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5760856458;
	Thu, 13 Jun 2024 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oHLotX0k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED1D143C63;
	Thu, 13 Jun 2024 11:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279649; cv=none; b=L0k8B6ZvU18EcqG1/OE/DYxcSxSrrndk31F1Ze/06XN9swHt2kV8Mhnde6ETeMHUFUsRjn0aCw88hVYCcJOhQX0H5ceJCEMxuJd4zgJUQtCJGEeFDn476Rrdqrl6i9byTSgu7pHv6pFRjIYoNeJedJEqAZ2a1hBhh3j/H+7K+V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279649; c=relaxed/simple;
	bh=XilbvPAyu8CnWCUpuK3OsVdh9KITUIP2VvaIZb/gN/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4VmMV633il3Unz1YUyqRAl1h8brY6zGmhKmjCH1WSQ2Q9NZUQKyzUSzzE1DittvbSITq/oNRQbhgRfE2Z0sB7NJiubjX+6K1mQKYrWY6WgqPQVirShiNhxpNG6XgPgLoznoKlYcnWNVPtLwJWwxx+SmeYHvOnp38o+d35pBERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oHLotX0k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897C9C2BBFC;
	Thu, 13 Jun 2024 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718279648;
	bh=XilbvPAyu8CnWCUpuK3OsVdh9KITUIP2VvaIZb/gN/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHLotX0kfCTeRijAr/ofcCleWvybO+EvcN3dMJj5L/GYbeDBiZ5WTcqaEvwh+gVba
	 D+C1wOsfLZPsU8/RnEhJOiuKF71lXelktXkM4DwGpkmbk/V5pROzF39qBxWQp4bkvi
	 vqwZbANfkidr22f4/Ds6wtF9GBTciAdlSteLEkB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	=?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>,
	syzbot+f80b066392366b4af85e@syzkaller.appspotmail.com,
	Chris Mason <clm@fb.com>,
	Filipe Manana <fdmanana@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 6.9 147/157] btrfs: protect folio::private when attaching extent buffer folios
Date: Thu, 13 Jun 2024 13:34:32 +0200
Message-ID: <20240613113233.092133721@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113227.389465891@linuxfoundation.org>
References: <20240613113227.389465891@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <wqu@suse.com>

commit f3a5367c679d31473d3fbb391675055b4792c309 upstream.

[BUG]
Since v6.8 there are rare kernel crashes reported by various people,
the common factor is bad page status error messages like this:

  BUG: Bad page state in process kswapd0  pfn:d6e840
  page: refcount:0 mapcount:0 mapping:000000007512f4f2 index:0x2796c2c7c
  pfn:0xd6e840
  aops:btree_aops ino:1
  flags: 0x17ffffe0000008(uptodate|node=0|zone=2|lastcpupid=0x3fffff)
  page_type: 0xffffffff()
  raw: 0017ffffe0000008 dead000000000100 dead000000000122 ffff88826d0be4c0
  raw: 00000002796c2c7c 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: non-NULL mapping

[CAUSE]
Commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
allocate-then-attach method") changes the sequence when allocating a new
extent buffer.

Previously we always called grab_extent_buffer() under
mapping->i_private_lock, to ensure the safety on modification on
folio::private (which is a pointer to extent buffer for regular
sectorsize).

This can lead to the following race:

Thread A is trying to allocate an extent buffer at bytenr X, with 4
4K pages, meanwhile thread B is trying to release the page at X + 4K
(the second page of the extent buffer at X).

           Thread A                |                 Thread B
-----------------------------------+-------------------------------------
                                   | btree_release_folio()
				   | | This is for the page at X + 4K,
				   | | Not page X.
				   | |
alloc_extent_buffer()              | |- release_extent_buffer()
|- filemap_add_folio() for the     | |  |- atomic_dec_and_test(eb->refs)
|  page at bytenr X (the first     | |  |
|  page).                          | |  |
|  Which returned -EEXIST.         | |  |
|                                  | |  |
|- filemap_lock_folio()            | |  |
|  Returned the first page locked. | |  |
|                                  | |  |
|- grab_extent_buffer()            | |  |
|  |- atomic_inc_not_zero()        | |  |
|  |  Returned false               | |  |
|  |- folio_detach_private()       | |  |- folio_detach_private() for X
|     |- folio_test_private()      | |     |- folio_test_private()
      |  Returned true             | |     |  Returned true
      |- folio_put()               |       |- folio_put()

Now there are two puts on the same folio at folio X, leading to refcount
underflow of the folio X, and eventually causing the BUG_ON() on the
page->mapping.

The condition is not that easy to hit:

- The release must be triggered for the middle page of an eb
  If the release is on the same first page of an eb, page lock would kick
  in and prevent the race.

- folio_detach_private() has a very small race window
  It's only between folio_test_private() and folio_clear_private().

That's exactly when mapping->i_private_lock is used to prevent such race,
and commit 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to
allocate-then-attach method") screwed that up.

At that time, I thought the page lock would kick in as
filemap_release_folio() also requires the page to be locked, but forgot
the filemap_release_folio() only locks one page, not all pages of an
extent buffer.

[FIX]
Move all the code requiring i_private_lock into
attach_eb_folio_to_filemap(), so that everything is done with proper
lock protection.

Furthermore to prevent future problems, add an extra
lockdep_assert_locked() to ensure we're holding the proper lock.

To reproducer that is able to hit the race (takes a few minutes with
instrumented code inserting delays to alloc_extent_buffer()):

  #!/bin/sh
  drop_caches () {
	  while(true); do
		  echo 3 > /proc/sys/vm/drop_caches
		  echo 1 > /proc/sys/vm/compact_memory
	  done
  }

  run_tar () {
	  while(true); do
		  for x in `seq 1 80` ; do
			  tar cf /dev/zero /mnt > /dev/null &
		  done
		  wait
	  done
  }

  mkfs.btrfs -f -d single -m single /dev/vda
  mount -o noatime /dev/vda /mnt
  # create 200,000 files, 1K each
  ./simoop -n 200000 -E -f 1k /mnt
  drop_caches &
  (run_tar)

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/linux-btrfs/CAHk-=wgt362nGfScVOOii8cgKn2LVVHeOvOA7OBwg1OwbuJQcw@mail.gmail.com/
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Link: https://lore.kernel.org/lkml/CABXGCsPktcHQOvKTbPaTwegMExije=Gpgci5NW=hqORo-s7diA@mail.gmail.com/
Reported-by: Toralf Förster <toralf.foerster@gmx.de>
Link: https://lore.kernel.org/linux-btrfs/e8b3311c-9a75-4903-907f-fc0f7a3fe423@gmx.de/
Reported-by: syzbot+f80b066392366b4af85e@syzkaller.appspotmail.com
Fixes: 09e6cef19c9f ("btrfs: refactor alloc_extent_buffer() to allocate-then-attach method")
CC: stable@vger.kernel.org # 6.8+
CC: Chris Mason <clm@fb.com>
Reviewed-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/extent_io.c |   60 ++++++++++++++++++++++++++-------------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3662,6 +3662,8 @@ static struct extent_buffer *grab_extent
 	struct folio *folio = page_folio(page);
 	struct extent_buffer *exists;
 
+	lockdep_assert_held(&page->mapping->i_private_lock);
+
 	/*
 	 * For subpage case, we completely rely on radix tree to ensure we
 	 * don't try to insert two ebs for the same bytenr.  So here we always
@@ -3729,13 +3731,14 @@ static int check_eb_alignment(struct btr
  * The caller needs to free the existing folios and retry using the same order.
  */
 static int attach_eb_folio_to_filemap(struct extent_buffer *eb, int i,
+				      struct btrfs_subpage *prealloc,
 				      struct extent_buffer **found_eb_ret)
 {
 
 	struct btrfs_fs_info *fs_info = eb->fs_info;
 	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	const unsigned long index = eb->start >> PAGE_SHIFT;
-	struct folio *existing_folio;
+	struct folio *existing_folio = NULL;
 	int ret;
 
 	ASSERT(found_eb_ret);
@@ -3747,12 +3750,14 @@ retry:
 	ret = filemap_add_folio(mapping, eb->folios[i], index + i,
 				GFP_NOFS | __GFP_NOFAIL);
 	if (!ret)
-		return 0;
+		goto finish;
 
 	existing_folio = filemap_lock_folio(mapping, index + i);
 	/* The page cache only exists for a very short time, just retry. */
-	if (IS_ERR(existing_folio))
+	if (IS_ERR(existing_folio)) {
+		existing_folio = NULL;
 		goto retry;
+	}
 
 	/* For now, we should only have single-page folios for btree inode. */
 	ASSERT(folio_nr_pages(existing_folio) == 1);
@@ -3763,14 +3768,13 @@ retry:
 		return -EAGAIN;
 	}
 
-	if (fs_info->nodesize < PAGE_SIZE) {
-		/*
-		 * We're going to reuse the existing page, can drop our page
-		 * and subpage structure now.
-		 */
+finish:
+	spin_lock(&mapping->i_private_lock);
+	if (existing_folio && fs_info->nodesize < PAGE_SIZE) {
+		/* We're going to reuse the existing page, can drop our folio now. */
 		__free_page(folio_page(eb->folios[i], 0));
 		eb->folios[i] = existing_folio;
-	} else {
+	} else if (existing_folio) {
 		struct extent_buffer *existing_eb;
 
 		existing_eb = grab_extent_buffer(fs_info,
@@ -3778,6 +3782,7 @@ retry:
 		if (existing_eb) {
 			/* The extent buffer still exists, we can use it directly. */
 			*found_eb_ret = existing_eb;
+			spin_unlock(&mapping->i_private_lock);
 			folio_unlock(existing_folio);
 			folio_put(existing_folio);
 			return 1;
@@ -3786,6 +3791,22 @@ retry:
 		__free_page(folio_page(eb->folios[i], 0));
 		eb->folios[i] = existing_folio;
 	}
+	eb->folio_size = folio_size(eb->folios[i]);
+	eb->folio_shift = folio_shift(eb->folios[i]);
+	/* Should not fail, as we have preallocated the memory. */
+	ret = attach_extent_buffer_folio(eb, eb->folios[i], prealloc);
+	ASSERT(!ret);
+	/*
+	 * To inform we have an extra eb under allocation, so that
+	 * detach_extent_buffer_page() won't release the folio private when the
+	 * eb hasn't been inserted into radix tree yet.
+	 *
+	 * The ref will be decreased when the eb releases the page, in
+	 * detach_extent_buffer_page().  Thus needs no special handling in the
+	 * error path.
+	 */
+	btrfs_folio_inc_eb_refs(fs_info, eb->folios[i]);
+	spin_unlock(&mapping->i_private_lock);
 	return 0;
 }
 
@@ -3797,7 +3818,6 @@ struct extent_buffer *alloc_extent_buffe
 	int attached = 0;
 	struct extent_buffer *eb;
 	struct extent_buffer *existing_eb = NULL;
-	struct address_space *mapping = fs_info->btree_inode->i_mapping;
 	struct btrfs_subpage *prealloc = NULL;
 	u64 lockdep_owner = owner_root;
 	bool page_contig = true;
@@ -3863,7 +3883,7 @@ reallocate:
 	for (int i = 0; i < num_folios; i++) {
 		struct folio *folio;
 
-		ret = attach_eb_folio_to_filemap(eb, i, &existing_eb);
+		ret = attach_eb_folio_to_filemap(eb, i, prealloc, &existing_eb);
 		if (ret > 0) {
 			ASSERT(existing_eb);
 			goto out;
@@ -3900,24 +3920,6 @@ reallocate:
 		 * and free the allocated page.
 		 */
 		folio = eb->folios[i];
-		eb->folio_size = folio_size(folio);
-		eb->folio_shift = folio_shift(folio);
-		spin_lock(&mapping->i_private_lock);
-		/* Should not fail, as we have preallocated the memory */
-		ret = attach_extent_buffer_folio(eb, folio, prealloc);
-		ASSERT(!ret);
-		/*
-		 * To inform we have extra eb under allocation, so that
-		 * detach_extent_buffer_page() won't release the folio private
-		 * when the eb hasn't yet been inserted into radix tree.
-		 *
-		 * The ref will be decreased when the eb released the page, in
-		 * detach_extent_buffer_page().
-		 * Thus needs no special handling in error path.
-		 */
-		btrfs_folio_inc_eb_refs(fs_info, folio);
-		spin_unlock(&mapping->i_private_lock);
-
 		WARN_ON(btrfs_folio_test_dirty(fs_info, folio, eb->start, eb->len));
 
 		/*




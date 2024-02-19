Return-Path: <stable+bounces-20596-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85985A890
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66A131F24E6D
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857453D0CB;
	Mon, 19 Feb 2024 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TZGK9Jj4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302F3CF6B
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359470; cv=none; b=h0RMjGyHfnqGbw872hipHksIseH3pu4X6vcMWIDHqqebH8k6njZaa/5ib2KxtXgBTCh7kJdMlxsIDEqD51hj9IwM6qJoexeglCHgPffh3JY5KFI1qZkf2SJqlh8Rgah/Hpq1k5aaGuI/QQDJlrZ0Gst/AGgOyzXMK4keQzFPI6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359470; c=relaxed/simple;
	bh=G/ns5C7K3bBCOAlbDWhNb+xiauThocRsL4xE9QwimKI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=iJZVPsKmuN5d/FwrwYPKUDZGYePA2ujBHs8gsSBGwBNfpnc5Xvfjl7p5e/+8rqJnr7RLgHxLw7ppsj4SAdr2JRQXJrQ5autbLN6WgzLcj04mCDDQusz9d1R7DkH/eG2HAi1nZZ8IWSnkyLyg1j5VX9b2WkuQKjxKqe3fIY2VzFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TZGK9Jj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43DB1C433F1;
	Mon, 19 Feb 2024 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359469;
	bh=G/ns5C7K3bBCOAlbDWhNb+xiauThocRsL4xE9QwimKI=;
	h=Subject:To:Cc:From:Date:From;
	b=TZGK9Jj4NGp5K4VdUqkAxSLc2uvR5JFjv2e5O3t3aZZgfSupUXqXqanj0UZFcuQ4X
	 78e3v/QUgq/T+d4tBOYzqa5/2IEsxBBIrVnDReXsRAvlual5NIxpcIr/yPg7VDOr5t
	 NrkoPwzECAp8BTG4wofw7FNYuc82lX0S3EhrMm2g=
Subject: FAILED: patch "[PATCH] ext4: convert to exclusive lock while inserting delalloc" failed to apply to 4.19-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:17:30 +0100
Message-ID: <2024021929-surreal-snippet-dc79@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x acf795dc161f3cf481db20f05db4250714e375e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021929-surreal-snippet-dc79@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

acf795dc161f ("ext4: convert to exclusive lock while inserting delalloc extents")
3fcc2b887a1b ("ext4: refactor ext4_da_map_blocks()")
6c120399cde6 ("ext4: make ext4_es_insert_extent() return void")
2a69c450083d ("ext4: using nofail preallocation in ext4_es_insert_extent()")
bda3efaf774f ("ext4: use pre-allocated es in __es_remove_extent()")
95f0b320339a ("ext4: use pre-allocated es in __es_insert_extent()")
73a2f033656b ("ext4: factor out __es_alloc_extent() and __es_free_extent()")
9649eb18c628 ("ext4: add a new helper to check if es must be kept")
8016e29f4362 ("ext4: fast commit recovery path")
5b849b5f96b4 ("jbd2: fast commit recovery path")
aa75f4d3daae ("ext4: main fast-commit commit path")
ff780b91efe9 ("jbd2: add fast commit machinery")
6866d7b3f2bb ("ext4 / jbd2: add fast commit initialization")
995a3ed67fc8 ("ext4: add fast_commit feature and handling for extended mount options")
2d069c0889ef ("ext4: use common helpers in all places reading metadata buffers")
d9befedaafcf ("ext4: clear buffer verified flag if read meta block from disk")
15ed2851b0f4 ("ext4: remove unused argument from ext4_(inc|dec)_count")
3d392b2676bf ("ext4: add prefetch_block_bitmaps mount option")
ab74c7b23f37 ("ext4: indicate via a block bitmap read is prefetched via a tracepoint")
bc71726c7257 ("ext4: abort the filesystem if failed to async write metadata buffer")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From acf795dc161f3cf481db20f05db4250714e375e5 Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Sat, 27 Jan 2024 09:58:01 +0800
Subject: [PATCH] ext4: convert to exclusive lock while inserting delalloc
 extents

ext4_da_map_blocks() only hold i_data_sem in shared mode and i_rwsem
when inserting delalloc extents, it could be raced by another querying
path of ext4_map_blocks() without i_rwsem, .e.g buffered read path.
Suppose we buffered read a file containing just a hole, and without any
cached extents tree, then it is raced by another delayed buffered write
to the same area or the near area belongs to the same hole, and the new
delalloc extent could be overwritten to a hole extent.

 pread()                           pwrite()
  filemap_read_folio()
   ext4_mpage_readpages()
    ext4_map_blocks()
     down_read(i_data_sem)
     ext4_ext_determine_hole()
     //find hole
     ext4_ext_put_gap_in_cache()
      ext4_es_find_extent_range()
      //no delalloc extent
                                    ext4_da_map_blocks()
                                     down_read(i_data_sem)
                                     ext4_insert_delayed_block()
                                     //insert delalloc extent
      ext4_es_insert_extent()
      //overwrite delalloc extent to hole

This race could lead to inconsistent delalloc extents tree and
incorrect reserved space counter. Fix this by converting to hold
i_data_sem in exclusive mode when adding a new delalloc extent in
ext4_da_map_blocks().

Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240127015825.1608160-3-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bbd5ee6dd3f3..b040337501e3 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1703,10 +1703,8 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 	/* Lookup extent status tree firstly */
 	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
-		if (ext4_es_is_hole(&es)) {
-			down_read(&EXT4_I(inode)->i_data_sem);
+		if (ext4_es_is_hole(&es))
 			goto add_delayed;
-		}
 
 		/*
 		 * Delayed extent could be allocated by fallocate.
@@ -1748,8 +1746,10 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		retval = ext4_ext_map_blocks(NULL, inode, map, 0);
 	else
 		retval = ext4_ind_map_blocks(NULL, inode, map, 0);
-	if (retval < 0)
-		goto out_unlock;
+	if (retval < 0) {
+		up_read(&EXT4_I(inode)->i_data_sem);
+		return retval;
+	}
 	if (retval > 0) {
 		unsigned int status;
 
@@ -1765,24 +1765,21 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 				EXTENT_STATUS_UNWRITTEN : EXTENT_STATUS_WRITTEN;
 		ext4_es_insert_extent(inode, map->m_lblk, map->m_len,
 				      map->m_pblk, status);
-		goto out_unlock;
+		up_read(&EXT4_I(inode)->i_data_sem);
+		return retval;
 	}
+	up_read(&EXT4_I(inode)->i_data_sem);
 
 add_delayed:
-	/*
-	 * XXX: __block_prepare_write() unmaps passed block,
-	 * is it OK?
-	 */
+	down_write(&EXT4_I(inode)->i_data_sem);
 	retval = ext4_insert_delayed_block(inode, map->m_lblk);
+	up_write(&EXT4_I(inode)->i_data_sem);
 	if (retval)
-		goto out_unlock;
+		return retval;
 
 	map_bh(bh, inode->i_sb, invalid_block);
 	set_buffer_new(bh);
 	set_buffer_delay(bh);
-
-out_unlock:
-	up_read((&EXT4_I(inode)->i_data_sem));
 	return retval;
 }
 



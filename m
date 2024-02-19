Return-Path: <stable+bounces-20592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 745A085A88C
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 17:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A839288744
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544AA3D54F;
	Mon, 19 Feb 2024 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SHMdd/M0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132213D54A
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 16:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708359457; cv=none; b=eQFFqC8pZf72nWUTG1zIUhDLfNYdxtpBS3kjO0UKeGiebUNU+Wkv7ymFfqGMB9tCKHOcxrd2YuyM2E82RCC3kNr2kBQlxcnIUi8D9nR3Fnqmd+d9Fiwo56mNAVVonSLWCRfoUJw21zqqe0NScTca+R9noBa13e+H0ggVh4fDSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708359457; c=relaxed/simple;
	bh=POENO9blhszSyVyuE5NXq1WBT2uZHn8rLBV32IKSTpw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ozfgyyWQq6Sd95PIA+2kBza/B5LTPf3L5gaabjk6HIpMMiiNNyjd8UwWuUdCrtSHf21iC8RQm60rTfiHehrMt4H8z+uDyz4xRduL5RrZUTX+BzgQM8gfr0JgfSi6y0Z5xeIsyqCjeJeeEEdUdpY198eMolEhSckaxjG0TKrZ16w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SHMdd/M0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F79C433C7;
	Mon, 19 Feb 2024 16:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708359456;
	bh=POENO9blhszSyVyuE5NXq1WBT2uZHn8rLBV32IKSTpw=;
	h=Subject:To:Cc:From:Date:From;
	b=SHMdd/M0pEV1pxi+z4kRJLFGgZfaLBsbNoIgM5NLiSFU1p8ZBNZXFA7g0SjxgZWqM
	 MtrKrK4uhpeNSThEYBZdHehUk/7lCYY7dB5RtR4SBvXJkFXDb2QnLCRCJpJKmgsPah
	 xB3wGEMGsSuGwjsWyfJIueh2pnm+tNOGjgqQ2o4c=
Subject: FAILED: patch "[PATCH] ext4: convert to exclusive lock while inserting delalloc" failed to apply to 6.1-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 17:17:24 +0100
Message-ID: <2024021924-snugly-vineyard-bf17@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x acf795dc161f3cf481db20f05db4250714e375e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021924-snugly-vineyard-bf17@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

acf795dc161f ("ext4: convert to exclusive lock while inserting delalloc extents")
3fcc2b887a1b ("ext4: refactor ext4_da_map_blocks()")
6c120399cde6 ("ext4: make ext4_es_insert_extent() return void")
2a69c450083d ("ext4: using nofail preallocation in ext4_es_insert_extent()")
bda3efaf774f ("ext4: use pre-allocated es in __es_remove_extent()")
95f0b320339a ("ext4: use pre-allocated es in __es_insert_extent()")
73a2f033656b ("ext4: factor out __es_alloc_extent() and __es_free_extent()")
9649eb18c628 ("ext4: add a new helper to check if es must be kept")

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
 



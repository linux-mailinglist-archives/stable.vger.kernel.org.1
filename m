Return-Path: <stable+bounces-62460-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD8693F2B8
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BED71F21BFD
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B34713DDAE;
	Mon, 29 Jul 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gm+3z9+J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7786214D
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249027; cv=none; b=gcjptVfPh2odVcPJl2isKXIP9hfPjMml0542VIYjSlqb8VIfvjFez+ZQrZ77rKZofjU5fNYBbITGfNfoX6EMbr2i/d2P/pVOpUYhdbVA/YmaQw9IknMlh6js1+/CjUcU0WVXGnN1FO252dYvxJ5ufi2n3sXIuPEM/PH3g16ZJz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249027; c=relaxed/simple;
	bh=HbROCJvhSqdf5z7vnarmXoHdfPKJYL6Y/2eKfkH3O1A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JwkQJvVOaEOIhpqvdTxTnRitbMp/yKGtKskyv2chWe78PKe6r0uBVxM0w3613UtGnNlMU9ZLE6vikwkR3h2xtCbrMuG++2NQEVBy/FcAlZWFkSa03fwkj4bUzR5qEgC+08y0Car0QZdFq/qacKb1sW/7RJjATJlvsDZg7mBOqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gm+3z9+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204BEC32786;
	Mon, 29 Jul 2024 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722249027;
	bh=HbROCJvhSqdf5z7vnarmXoHdfPKJYL6Y/2eKfkH3O1A=;
	h=Subject:To:Cc:From:Date:From;
	b=Gm+3z9+JRdZZmrTWX0r+2t/SKtarS1kW9/hVm3dAbeB8gRcetqE2vzrt98nv0+iwT
	 iYUGU1z69iYVuRtrQ1rI4QKTGp7EWu50CP+g998jBuVxBhE8bHjCLIb/Y2LfRx36xj
	 WJENknbAEkVQNqB+KQV+yKMMeMmRJZhnAoyAgnmE=
Subject: FAILED: patch "[PATCH] ext4: check the extent status again before inserting delalloc" failed to apply to 4.19-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:30:11 +0200
Message-ID: <2024072911-elsewhere-latter-afa3@gregkh>
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
git cherry-pick -x 0ea6560abb3bac1ffcfa4bf6b2c4d344fdc27b3c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072911-elsewhere-latter-afa3@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

0ea6560abb3b ("ext4: check the extent status again before inserting delalloc block")
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

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ea6560abb3bac1ffcfa4bf6b2c4d344fdc27b3c Mon Sep 17 00:00:00 2001
From: Zhang Yi <yi.zhang@huawei.com>
Date: Fri, 17 May 2024 20:39:57 +0800
Subject: [PATCH] ext4: check the extent status again before inserting delalloc
 block

ext4_da_map_blocks looks up for any extent entry in the extent status
tree (w/o i_data_sem) and then the looks up for any ondisk extent
mapping (with i_data_sem in read mode).

If it finds a hole in the extent status tree or if it couldn't find any
entry at all, it then takes the i_data_sem in write mode to add a da
entry into the extent status tree. This can actually race with page
mkwrite & fallocate path.

Note that this is ok between
1. ext4 buffered-write path v/s ext4_page_mkwrite(), because of the
   folio lock
2. ext4 buffered write path v/s ext4 fallocate because of the inode
   lock.

But this can race between ext4_page_mkwrite() & ext4 fallocate path

ext4_page_mkwrite()             ext4_fallocate()
 block_page_mkwrite()
  ext4_da_map_blocks()
   //find hole in extent status tree
                                 ext4_alloc_file_blocks()
                                  ext4_map_blocks()
                                   //allocate block and unwritten extent
   ext4_insert_delayed_block()
    ext4_da_reserve_space()
     //reserve one more block
    ext4_es_insert_delayed_block()
     //drop unwritten extent and add delayed extent by mistake

Then, the delalloc extent is wrong until writeback and the extra
reserved block can't be released any more and it triggers below warning:

 EXT4-fs (pmem2): Inode 13 (00000000bbbd4d23): i_reserved_data_blocks(1) not cleared!

Fix the problem by looking up extent status tree again while the
i_data_sem is held in write mode. If it still can't find any entry, then
we insert a new da entry into the extent status tree.

Cc: stable@vger.kernel.org
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20240517124005.347221-3-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 168819b4db01..4b0d64a76e88 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1737,6 +1737,7 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 		if (ext4_es_is_hole(&es))
 			goto add_delayed;
 
+found:
 		/*
 		 * Delayed extent could be allocated by fallocate.
 		 * So we need to check it.
@@ -1781,6 +1782,26 @@ static int ext4_da_map_blocks(struct inode *inode, sector_t iblock,
 
 add_delayed:
 	down_write(&EXT4_I(inode)->i_data_sem);
+	/*
+	 * Page fault path (ext4_page_mkwrite does not take i_rwsem)
+	 * and fallocate path (no folio lock) can race. Make sure we
+	 * lookup the extent status tree here again while i_data_sem
+	 * is held in write mode, before inserting a new da entry in
+	 * the extent status tree.
+	 */
+	if (ext4_es_lookup_extent(inode, iblock, NULL, &es)) {
+		if (!ext4_es_is_hole(&es)) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			goto found;
+		}
+	} else if (!ext4_has_inline_data(inode)) {
+		retval = ext4_map_query_blocks(NULL, inode, map);
+		if (retval) {
+			up_write(&EXT4_I(inode)->i_data_sem);
+			return retval;
+		}
+	}
+
 	retval = ext4_insert_delayed_block(inode, map->m_lblk);
 	up_write(&EXT4_I(inode)->i_data_sem);
 	if (retval)



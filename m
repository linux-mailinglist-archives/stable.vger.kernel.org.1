Return-Path: <stable+bounces-62455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2382593F2B2
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 12:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBFA8282538
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 10:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD181428F2;
	Mon, 29 Jul 2024 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iFnqMM1l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8A714430E
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249011; cv=none; b=XjnS3oCmLpZf8T3woO31O3tzJMVD/lnUWcUFeJemw7RorLR0He/+CUl+xW2l2G1GNmFlaShrrWVTJs9MQk5FE++1mn+VWoAftbnd5gQl/uuT4xIE+F/UGvzfOV2STeTcmG4XphDoFxmpUbyttCVA9yvaZcLxE8QoYcg2PGj8RtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249011; c=relaxed/simple;
	bh=jJU7ZBkPuSYkvmv/0OyoccLBDV7NYPyQsxyqAsNQQjk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QjDqxzCwUlj0fBuJoTinK/TMTuVgqxce6bV9Z+EayDwbnVH9hT+K/ZloaohCUZ58yBP3f0f5tFbCQAI4PQNvgdsbsE3O0AKgCrXUY9eqWELwGtsJVJrVDeX/wfrVnKHqftdH+VvtkFvDLgcw+1dgPUB+FengX1RFoe5uCvM2SB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iFnqMM1l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB96C4AF0A;
	Mon, 29 Jul 2024 10:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722249010;
	bh=jJU7ZBkPuSYkvmv/0OyoccLBDV7NYPyQsxyqAsNQQjk=;
	h=Subject:To:Cc:From:Date:From;
	b=iFnqMM1l2xrE6EeEePWyIOvMp87PSVGjciP2Ti+n1vkFiT1ixGa7BkXm14uUOZAxn
	 tB6ylzC/x8fMm9WNvi7rLq1obrbKecA4NJoN0bxUCRWxcbbVqmAJEaye7Ywe/+VDLK
	 PIJIs58Q+ZFaRBOV+zHKNlDeVbocUaaAHNqP/Cgw=
Subject: FAILED: patch "[PATCH] ext4: check the extent status again before inserting delalloc" failed to apply to 6.6-stable tree
To: yi.zhang@huawei.com,jack@suse.cz,tytso@mit.edu
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 12:30:05 +0200
Message-ID: <2024072904-rule-emblem-471a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0ea6560abb3bac1ffcfa4bf6b2c4d344fdc27b3c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072904-rule-emblem-471a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

0ea6560abb3b ("ext4: check the extent status again before inserting delalloc block")
acf795dc161f ("ext4: convert to exclusive lock while inserting delalloc extents")
3fcc2b887a1b ("ext4: refactor ext4_da_map_blocks()")

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



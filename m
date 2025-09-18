Return-Path: <stable+bounces-172380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3383CB31806
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 14:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5882189E3C4
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 12:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F062FB62B;
	Fri, 22 Aug 2025 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bPfLgHyE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E085626;
	Fri, 22 Aug 2025 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866265; cv=none; b=CMqOn7lWJuXyeDJGwUOIa4bO9EpJMDMbHVP6KDk4YxIF1nGDa3+NrrLvzV83nmbTrf8yAV5frJ4Bc5n8wUo+EcgUk/BR/8J5YKwSsw9nni9WvSEusahDk2A5z5/JPwcRekszUQ1BDQYwh05mY2ljJMmk7Hu7pKSKUkJqLHGdq1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866265; c=relaxed/simple;
	bh=1rDeCbSOahLaSxeD0glOp80VBxHAYT3FU4VxlHzLeJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jbSDsZpj8eMgD3eCWmnoPWqFTkEFSjrJQx64CX40H7z7wxUckFySdKaG2Sy0AnqB0ThcdJGfzdRnFQi9P5ymRBTFPGr9Nzrx4znbTKHU9IWL5LCItUa2dEm3QEBlO3zVEzFal8uu/Upa1CvQyUDI3n5zxF5pET3GnoDr97O7A4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bPfLgHyE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 305C9C4CEED;
	Fri, 22 Aug 2025 12:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755866264;
	bh=1rDeCbSOahLaSxeD0glOp80VBxHAYT3FU4VxlHzLeJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPfLgHyEkoIMVkwBQp2qF7bqpezQDYIzmKTRWz8qudZBPemM9bzJmwwMptRkADL6m
	 7bwBqf62KpJNUdA8TmVrtHbYkAp27JtoRlbi1wv/OzidW8LrpoCAEUpkQ+xd3F8cTf
	 CHgUjU3kuXcIVrY4vXfnWmkBY9fX5aQQkorlsdpE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Tso <tytso@mit.edu>
Subject: [PATCH 6.16 9/9] ext4: replace ext4_writepage_trans_blocks()
Date: Fri, 22 Aug 2025 14:37:09 +0200
Message-ID: <20250822123517.130341321@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822123516.780248736@linuxfoundation.org>
References: <20250822123516.780248736@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

commit 57661f28756c59510e31543520b5b8f5e591f384 upstream.

After ext4 supports large folios, the semantics of reserving credits in
pages is no longer applicable. In most scenarios, reserving credits in
extents is sufficient. Therefore, introduce ext4_chunk_trans_extent()
to replace ext4_writepage_trans_blocks(). move_extent_per_page() is the
only remaining location where we are still processing extents in pages.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250707140814.542883-10-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/ext4.h        |    2 +-
 fs/ext4/extents.c     |    6 +++---
 fs/ext4/inline.c      |    6 +++---
 fs/ext4/inode.c       |   33 +++++++++++++++------------------
 fs/ext4/move_extent.c |    3 ++-
 fs/ext4/xattr.c       |    2 +-
 6 files changed, 25 insertions(+), 27 deletions(-)

--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3064,9 +3064,9 @@ extern int ext4_punch_hole(struct file *
 extern void ext4_set_inode_flags(struct inode *, bool init);
 extern int ext4_alloc_da_blocks(struct inode *inode);
 extern void ext4_set_aops(struct inode *inode);
-extern int ext4_writepage_trans_blocks(struct inode *);
 extern int ext4_normal_submit_inode_data_buffers(struct jbd2_inode *jinode);
 extern int ext4_chunk_trans_blocks(struct inode *, int nrblocks);
+extern int ext4_chunk_trans_extent(struct inode *inode, int nrblocks);
 extern int ext4_meta_trans_blocks(struct inode *inode, int lblocks,
 				  int pextents);
 extern int ext4_zero_partial_blocks(handle_t *handle, struct inode *inode,
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5171,7 +5171,7 @@ ext4_ext_shift_path_extents(struct ext4_
 				credits = depth + 2;
 			}
 
-			restart_credits = ext4_writepage_trans_blocks(inode);
+			restart_credits = ext4_chunk_trans_extent(inode, 0);
 			err = ext4_datasem_ensure_credits(handle, inode, credits,
 					restart_credits, 0);
 			if (err) {
@@ -5431,7 +5431,7 @@ static int ext4_collapse_range(struct fi
 
 	truncate_pagecache(inode, start);
 
-	credits = ext4_writepage_trans_blocks(inode);
+	credits = ext4_chunk_trans_extent(inode, 0);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
@@ -5527,7 +5527,7 @@ static int ext4_insert_range(struct file
 
 	truncate_pagecache(inode, start);
 
-	credits = ext4_writepage_trans_blocks(inode);
+	credits = ext4_chunk_trans_extent(inode, 0);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -570,7 +570,7 @@ static int ext4_convert_inline_data_to_e
 		return 0;
 	}
 
-	needed_blocks = ext4_writepage_trans_blocks(inode);
+	needed_blocks = ext4_chunk_trans_extent(inode, 1);
 
 	ret = ext4_get_inode_loc(inode, &iloc);
 	if (ret)
@@ -1874,7 +1874,7 @@ int ext4_inline_data_truncate(struct ino
 	};
 
 
-	needed_blocks = ext4_writepage_trans_blocks(inode);
+	needed_blocks = ext4_chunk_trans_extent(inode, 1);
 	handle = ext4_journal_start(inode, EXT4_HT_INODE, needed_blocks);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
@@ -1994,7 +1994,7 @@ int ext4_convert_inline_data(struct inod
 			return 0;
 	}
 
-	needed_blocks = ext4_writepage_trans_blocks(inode);
+	needed_blocks = ext4_chunk_trans_extent(inode, 1);
 
 	iloc.bh = NULL;
 	error = ext4_get_inode_loc(inode, &iloc);
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1296,7 +1296,8 @@ static int ext4_write_begin(struct file
 	 * Reserve one block more for addition to orphan list in case
 	 * we allocate blocks but write fails for some reason
 	 */
-	needed_blocks = ext4_writepage_trans_blocks(inode) + 1;
+	needed_blocks = ext4_chunk_trans_extent(inode,
+			ext4_journal_blocks_per_folio(inode)) + 1;
 	index = pos >> PAGE_SHIFT;
 
 	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
@@ -4464,7 +4465,7 @@ int ext4_punch_hole(struct file *file, l
 		return ret;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		credits = ext4_writepage_trans_blocks(inode);
+		credits = ext4_chunk_trans_extent(inode, 2);
 	else
 		credits = ext4_blocks_for_truncate(inode);
 	handle = ext4_journal_start(inode, EXT4_HT_TRUNCATE, credits);
@@ -4613,7 +4614,7 @@ int ext4_truncate(struct inode *inode)
 	}
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		credits = ext4_writepage_trans_blocks(inode);
+		credits = ext4_chunk_trans_extent(inode, 1);
 	else
 		credits = ext4_blocks_for_truncate(inode);
 
@@ -6256,25 +6257,19 @@ int ext4_meta_trans_blocks(struct inode
 }
 
 /*
- * Calculate the total number of credits to reserve to fit
- * the modification of a single pages into a single transaction,
- * which may include multiple chunks of block allocations.
- *
- * This could be called via ext4_write_begin()
- *
- * We need to consider the worse case, when
- * one new block per extent.
+ * Calculate the journal credits for modifying the number of blocks
+ * in a single extent within one transaction. 'nrblocks' is used only
+ * for non-extent inodes. For extent type inodes, 'nrblocks' can be
+ * zero if the exact number of blocks is unknown.
  */
-int ext4_writepage_trans_blocks(struct inode *inode)
+int ext4_chunk_trans_extent(struct inode *inode, int nrblocks)
 {
-	int bpp = ext4_journal_blocks_per_folio(inode);
 	int ret;
 
-	ret = ext4_meta_trans_blocks(inode, bpp, bpp);
-
+	ret = ext4_meta_trans_blocks(inode, nrblocks, 1);
 	/* Account for data blocks for journalled mode */
 	if (ext4_should_journal_data(inode))
-		ret += bpp;
+		ret += nrblocks;
 	return ret;
 }
 
@@ -6652,10 +6647,12 @@ static int ext4_block_page_mkwrite(struc
 	handle_t *handle;
 	loff_t size;
 	unsigned long len;
+	int credits;
 	int ret;
 
-	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE,
-				    ext4_writepage_trans_blocks(inode));
+	credits = ext4_chunk_trans_extent(inode,
+			ext4_journal_blocks_per_folio(inode));
+	handle = ext4_journal_start(inode, EXT4_HT_WRITE_PAGE, credits);
 	if (IS_ERR(handle))
 		return PTR_ERR(handle);
 
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -280,7 +280,8 @@ move_extent_per_page(struct file *o_filp
 	 */
 again:
 	*err = 0;
-	jblocks = ext4_writepage_trans_blocks(orig_inode) * 2;
+	jblocks = ext4_meta_trans_blocks(orig_inode, block_len_in_page,
+					 block_len_in_page) * 2;
 	handle = ext4_journal_start(orig_inode, EXT4_HT_MOVE_EXTENTS, jblocks);
 	if (IS_ERR(handle)) {
 		*err = PTR_ERR(handle);
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -962,7 +962,7 @@ int __ext4_xattr_set_credits(struct supe
 	 * so we need to reserve credits for this eventuality
 	 */
 	if (inode && ext4_has_inline_data(inode))
-		credits += ext4_writepage_trans_blocks(inode) + 1;
+		credits += ext4_chunk_trans_extent(inode, 1) + 1;
 
 	/* We are done if ea_inode feature is not enabled. */
 	if (!ext4_has_feature_ea_inode(sb))




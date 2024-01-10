Return-Path: <stable+bounces-10264-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD6827413
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 16:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E16491C211EA
	for <lists+stable@lfdr.de>; Mon,  8 Jan 2024 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF7952F8E;
	Mon,  8 Jan 2024 15:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qxoflMlA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237FD51C2B;
	Mon,  8 Jan 2024 15:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930A3C43391;
	Mon,  8 Jan 2024 15:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704728505;
	bh=I5UTQo/FWnajpIc4XuuTG5eav+QcBfLLM5C1AGIzcMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qxoflMlAHuKdK2QTTTO/ZmTy2J1JKpxJnfITqy6d9LNKV8Rj5IvSvqg/JX69Q0wPU
	 tY56CvbzS0Qu1dxJxzThpspSbaoci95l64iu7v/AOMTaIo81sjwejEYoPO9tVLpEXP
	 sKekFrAlqRjdjtIw2rPBJZMMJqqnb19CW7qOeN+I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Matthew Wilcox <willy@infradead.org>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	Theodore Tso <tytso@mit.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 098/150] ext4: convert move_extent_per_page() to use folios
Date: Mon,  8 Jan 2024 16:35:49 +0100
Message-ID: <20240108153515.711810659@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108153511.214254205@linuxfoundation.org>
References: <20240108153511.214254205@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vishal Moola (Oracle) <vishal.moola@gmail.com>

[ Upstream commit 6dd8fe86fa84729538d8bed3149faf9c5886bb5b ]

Patch series "Removing the try_to_release_page() wrapper", v3.

This patchset replaces the remaining calls of try_to_release_page() with
the folio equivalent: filemap_release_folio().  This allows us to remove
the wrapper.

This patch (of 4):

Convert move_extent_per_page() to use folios.  This change removes 5 calls
to compound_head() and is in preparation for the removal of the
try_to_release_page() wrapper.

Link: https://lkml.kernel.org/r/20221118073055.55694-1-vishal.moola@gmail.com
Link: https://lkml.kernel.org/r/20221118073055.55694-2-vishal.moola@gmail.com
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 1898efcdbed3 ("block: update the stable_writes flag in bdev_add")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/move_extent.c | 52 ++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 044e34cd835c1..8dbb87edf24c4 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -253,6 +253,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 {
 	struct inode *orig_inode = file_inode(o_filp);
 	struct page *pagep[2] = {NULL, NULL};
+	struct folio *folio[2] = {NULL, NULL};
 	handle_t *handle;
 	ext4_lblk_t orig_blk_offset, donor_blk_offset;
 	unsigned long blocksize = orig_inode->i_sb->s_blocksize;
@@ -313,6 +314,13 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	 * hold page's lock, if it is still the case data copy is not
 	 * necessary, just swap data blocks between orig and donor.
 	 */
+	folio[0] = page_folio(pagep[0]);
+	folio[1] = page_folio(pagep[1]);
+
+	VM_BUG_ON_FOLIO(folio_test_large(folio[0]), folio[0]);
+	VM_BUG_ON_FOLIO(folio_test_large(folio[1]), folio[1]);
+	VM_BUG_ON_FOLIO(folio_nr_pages(folio[0]) != folio_nr_pages(folio[1]), folio[1]);
+
 	if (unwritten) {
 		ext4_double_down_write_data_sem(orig_inode, donor_inode);
 		/* If any of extents in range became initialized we have to
@@ -331,10 +339,10 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 			ext4_double_up_write_data_sem(orig_inode, donor_inode);
 			goto data_copy;
 		}
-		if ((page_has_private(pagep[0]) &&
-		     !try_to_release_page(pagep[0], 0)) ||
-		    (page_has_private(pagep[1]) &&
-		     !try_to_release_page(pagep[1], 0))) {
+		if ((folio_has_private(folio[0]) &&
+		     !filemap_release_folio(folio[0], 0)) ||
+		    (folio_has_private(folio[1]) &&
+		     !filemap_release_folio(folio[1], 0))) {
 			*err = -EBUSY;
 			goto drop_data_sem;
 		}
@@ -344,19 +352,21 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 						   block_len_in_page, 1, err);
 	drop_data_sem:
 		ext4_double_up_write_data_sem(orig_inode, donor_inode);
-		goto unlock_pages;
+		goto unlock_folios;
 	}
 data_copy:
-	*err = mext_page_mkuptodate(pagep[0], from, from + replaced_size);
+	*err = mext_page_mkuptodate(&folio[0]->page, from, from + replaced_size);
 	if (*err)
-		goto unlock_pages;
+		goto unlock_folios;
 
 	/* At this point all buffers in range are uptodate, old mapping layout
 	 * is no longer required, try to drop it now. */
-	if ((page_has_private(pagep[0]) && !try_to_release_page(pagep[0], 0)) ||
-	    (page_has_private(pagep[1]) && !try_to_release_page(pagep[1], 0))) {
+	if ((folio_has_private(folio[0]) &&
+		!filemap_release_folio(folio[0], 0)) ||
+	    (folio_has_private(folio[1]) &&
+		!filemap_release_folio(folio[1], 0))) {
 		*err = -EBUSY;
-		goto unlock_pages;
+		goto unlock_folios;
 	}
 	ext4_double_down_write_data_sem(orig_inode, donor_inode);
 	replaced_count = ext4_swap_extents(handle, orig_inode, donor_inode,
@@ -369,13 +379,13 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 			replaced_size =
 				block_len_in_page << orig_inode->i_blkbits;
 		} else
-			goto unlock_pages;
+			goto unlock_folios;
 	}
 	/* Perform all necessary steps similar write_begin()/write_end()
 	 * but keeping in mind that i_size will not change */
-	if (!page_has_buffers(pagep[0]))
-		create_empty_buffers(pagep[0], 1 << orig_inode->i_blkbits, 0);
-	bh = page_buffers(pagep[0]);
+	if (!folio_buffers(folio[0]))
+		create_empty_buffers(&folio[0]->page, 1 << orig_inode->i_blkbits, 0);
+	bh = folio_buffers(folio[0]);
 	for (i = 0; i < data_offset_in_page; i++)
 		bh = bh->b_this_page;
 	for (i = 0; i < block_len_in_page; i++) {
@@ -385,7 +395,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 		bh = bh->b_this_page;
 	}
 	if (!*err)
-		*err = block_commit_write(pagep[0], from, from + replaced_size);
+		*err = block_commit_write(&folio[0]->page, from, from + replaced_size);
 
 	if (unlikely(*err < 0))
 		goto repair_branches;
@@ -395,11 +405,11 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 	*err = ext4_jbd2_inode_add_write(handle, orig_inode,
 			(loff_t)orig_page_offset << PAGE_SHIFT, replaced_size);
 
-unlock_pages:
-	unlock_page(pagep[0]);
-	put_page(pagep[0]);
-	unlock_page(pagep[1]);
-	put_page(pagep[1]);
+unlock_folios:
+	folio_unlock(folio[0]);
+	folio_put(folio[0]);
+	folio_unlock(folio[1]);
+	folio_put(folio[1]);
 stop_journal:
 	ext4_journal_stop(handle);
 	if (*err == -ENOSPC &&
@@ -430,7 +440,7 @@ move_extent_per_page(struct file *o_filp, struct inode *donor_inode,
 		*err = -EIO;
 	}
 	replaced_count = 0;
-	goto unlock_pages;
+	goto unlock_folios;
 }
 
 /**
-- 
2.43.0





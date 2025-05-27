Return-Path: <stable+bounces-147621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BB8AC5873
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93461BC23EE
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273CC1E25E3;
	Tue, 27 May 2025 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bk1ZchIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D903D7263B;
	Tue, 27 May 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748367911; cv=none; b=iH1nkm4G8QP+g/X2sgo90TIAMQeHBHNTDkhEGjJVKYqQr7yrRV+fl1VJ1IdyJFjQdXnrajn0MERTDYp2apyqmJjx+R7zxgQz+sJ4JwC5yFIQzLPHEarsWIMRfAng/PH4I7rUjMFW/QxJOwpbKcwDDCcvKY5rMoCebIpCL+KyPLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748367911; c=relaxed/simple;
	bh=z/+oevAIL7130CIWqD0kMJjbgfAjgobRXgUv8ICJuI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qi/GU7Ax5eMFNIg2/5L7LBoCgputwfssQKzPuWNPjuGDjBt7/qlKgiuBfYKRoKBzfmTSv4wTyq54wvRDXk7uPBkL4n0FVXWsStihT5hEHkEUcrb/jYWoRCRg4CV+pg7fvxoUDinJdkmVEF4j3evjsJ+hFpFFbiHxoAK6F5qEr+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bk1ZchIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C5FC4CEE9;
	Tue, 27 May 2025 17:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748367911;
	bh=z/+oevAIL7130CIWqD0kMJjbgfAjgobRXgUv8ICJuI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bk1ZchIF/hI96BSENxD23el0Dff5QJJ6Rfx5I1z1mQmKj16yj2cXjL18uM3hv2HKl
	 VXGadPDVGA9mA64XjorzyGJLRi/aeu77hnXrFrXvIAlcc9GZUbuM88F4O6Usxah5hf
	 oseWdQpQwxhwPMRW0+1r8xx93podiSxw8ndw/XlE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 538/783] ext4: remove writable userspace mappings before truncating page cache
Date: Tue, 27 May 2025 18:25:35 +0200
Message-ID: <20250527162535.071527765@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162513.035720581@linuxfoundation.org>
References: <20250527162513.035720581@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 17207d0bb209e8b40f27d7f3f96e82a78af0bf2c ]

When zeroing a range of folios on the filesystem which block size is
less than the page size, the file's mapped blocks within one page will
be marked as unwritten, we should remove writable userspace mappings to
ensure that ext4_page_mkwrite() can be called during subsequent write
access to these partial folios. Otherwise, data written by subsequent
mmap writes may not be saved to disk.

 $mkfs.ext4 -b 1024 /dev/vdb
 $mount /dev/vdb /mnt
 $xfs_io -t -f -c "pwrite -S 0x58 0 4096" -c "mmap -rw 0 4096" \
               -c "mwrite -S 0x5a 2048 2048" -c "fzero 2048 2048" \
               -c "mwrite -S 0x59 2048 2048" -c "close" /mnt/foo

 $od -Ax -t x1z /mnt/foo
 000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
 *
 000800 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59 59
 *
 001000

 $umount /mnt && mount /dev/vdb /mnt
 $od -Ax -t x1z /mnt/foo
 000000 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58 58
 *
 000800 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 *
 001000

Fix this by introducing ext4_truncate_page_cache_block_range() to remove
writable userspace mappings when truncating a partial folio range.
Additionally, move the journal data mode-specific handlers and
truncate_pagecache_range() into this function, allowing it to serve as a
common helper that correctly manages the page cache in preparation for
block range manipulations.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20241220011637.1157197-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h    |  2 ++
 fs/ext4/extents.c | 19 ++++----------
 fs/ext4/inode.c   | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index d4d285d999311..4f81983b79186 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3011,6 +3011,8 @@ extern int ext4_inode_attach_jinode(struct inode *inode);
 extern int ext4_can_truncate(struct inode *inode);
 extern int ext4_truncate(struct inode *);
 extern int ext4_break_layouts(struct inode *);
+extern int ext4_truncate_page_cache_block_range(struct inode *inode,
+						loff_t start, loff_t end);
 extern int ext4_punch_hole(struct file *file, loff_t offset, loff_t length);
 extern void ext4_set_inode_flags(struct inode *, bool init);
 extern int ext4_alloc_da_blocks(struct inode *inode);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a07a98a4b97a5..8dc6b4271b15d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4667,22 +4667,13 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 			goto out_mutex;
 		}
 
-		/*
-		 * For journalled data we need to write (and checkpoint) pages
-		 * before discarding page cache to avoid inconsitent data on
-		 * disk in case of crash before zeroing trans is committed.
-		 */
-		if (ext4_should_journal_data(inode)) {
-			ret = filemap_write_and_wait_range(mapping, start,
-							   end - 1);
-			if (ret) {
-				filemap_invalidate_unlock(mapping);
-				goto out_mutex;
-			}
+		/* Now release the pages and zero block aligned part of pages */
+		ret = ext4_truncate_page_cache_block_range(inode, start, end);
+		if (ret) {
+			filemap_invalidate_unlock(mapping);
+			goto out_mutex;
 		}
 
-		/* Now release the pages and zero block aligned part of pages */
-		truncate_pagecache_range(inode, start, end - 1);
 		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 377fec39b24be..44780bb537f95 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -31,6 +31,7 @@
 #include <linux/writeback.h>
 #include <linux/pagevec.h>
 #include <linux/mpage.h>
+#include <linux/rmap.h>
 #include <linux/namei.h>
 #include <linux/uio.h>
 #include <linux/bio.h>
@@ -3903,6 +3904,68 @@ int ext4_update_disksize_before_punch(struct inode *inode, loff_t offset,
 	return ret;
 }
 
+static inline void ext4_truncate_folio(struct inode *inode,
+				       loff_t start, loff_t end)
+{
+	unsigned long blocksize = i_blocksize(inode);
+	struct folio *folio;
+
+	/* Nothing to be done if no complete block needs to be truncated. */
+	if (round_up(start, blocksize) >= round_down(end, blocksize))
+		return;
+
+	folio = filemap_lock_folio(inode->i_mapping, start >> PAGE_SHIFT);
+	if (IS_ERR(folio))
+		return;
+
+	if (folio_mkclean(folio))
+		folio_mark_dirty(folio);
+	folio_unlock(folio);
+	folio_put(folio);
+}
+
+int ext4_truncate_page_cache_block_range(struct inode *inode,
+					 loff_t start, loff_t end)
+{
+	unsigned long blocksize = i_blocksize(inode);
+	int ret;
+
+	/*
+	 * For journalled data we need to write (and checkpoint) pages
+	 * before discarding page cache to avoid inconsitent data on disk
+	 * in case of crash before freeing or unwritten converting trans
+	 * is committed.
+	 */
+	if (ext4_should_journal_data(inode)) {
+		ret = filemap_write_and_wait_range(inode->i_mapping, start,
+						   end - 1);
+		if (ret)
+			return ret;
+		goto truncate_pagecache;
+	}
+
+	/*
+	 * If the block size is less than the page size, the file's mapped
+	 * blocks within one page could be freed or converted to unwritten.
+	 * So it's necessary to remove writable userspace mappings, and then
+	 * ext4_page_mkwrite() can be called during subsequent write access
+	 * to these partial folios.
+	 */
+	if (!IS_ALIGNED(start | end, PAGE_SIZE) &&
+	    blocksize < PAGE_SIZE && start < inode->i_size) {
+		loff_t page_boundary = round_up(start, PAGE_SIZE);
+
+		ext4_truncate_folio(inode, start, min(page_boundary, end));
+		if (end > page_boundary)
+			ext4_truncate_folio(inode,
+					    round_down(end, PAGE_SIZE), end);
+	}
+
+truncate_pagecache:
+	truncate_pagecache_range(inode, start, end - 1);
+	return 0;
+}
+
 static void ext4_wait_dax_page(struct inode *inode)
 {
 	filemap_invalidate_unlock(inode->i_mapping);
-- 
2.39.5





Return-Path: <stable+bounces-160728-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B5EAFD195
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDDA21C240B9
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9E52E5412;
	Tue,  8 Jul 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LUphe2pc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFC32E337A;
	Tue,  8 Jul 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992512; cv=none; b=MuMdLnjYHBHaNmQEFmO/G6WZ9v5hdED06CJjnsw3yqVID5bndByzjV9dd9YS4QQs8aWekcWTHK3WfzdIl1lOBpT8hfNEHm2y3fG660K1iMAq5HlB6y98c4aA/OrWxuGp/oOXXjwvGrZYNs1a7OVl6yuXXz/HAZN4CbBpHQhKU/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992512; c=relaxed/simple;
	bh=5Sx6vR0sTYgpsKQDWpkAORNwpNPYYUalF7aujYddf0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4wrkPjFEF7tDPcognDSweA1UOe4zCwHoRDT88s82ID6/0he+YjflqrL56qSkjOe9Ks4ERxZGY+ZaGRJSrnnSWBqwX8YouvIZ07h7RM45k0CKIvslFlhABHHetC3yleMZgelhNed/LHdT5f1thgfwk3nVsZKVgn0yPIdFEmUNS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LUphe2pc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AE7C4CEF0;
	Tue,  8 Jul 2025 16:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992512;
	bh=5Sx6vR0sTYgpsKQDWpkAORNwpNPYYUalF7aujYddf0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUphe2pcTJFzCW3Jns+FEZ7F3+UdMv6vEeGKNIA9yxL6ICd7k902KTMJ+DE7vV036
	 rshaFUrGCzM5pnFXuo6TsMjN/oaRomcqY7CHLUbRefOBEImWVh4mrhmC5CwOQR08XK
	 uoW731yi9KfQlEDKVKOlgmsuEZp9oTWsjqR5xCGw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 076/132] f2fs: fix to zero post-eof page
Date: Tue,  8 Jul 2025 18:23:07 +0200
Message-ID: <20250708162232.860519301@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162230.765762963@linuxfoundation.org>
References: <20250708162230.765762963@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit ba8dac350faf16afc129ce6303ca4feaf083ccb1 ]

fstest reports a f2fs bug:

#generic/363 42s ... [failed, exit status 1]- output mismatch (see /share/git/fstests/results//generic/363.out.bad)
#    --- tests/generic/363.out   2025-01-12 21:57:40.271440542 +0800
#    +++ /share/git/fstests/results//generic/363.out.bad 2025-05-19 19:55:58.000000000 +0800
#    @@ -1,2 +1,78 @@
#     QA output created by 363
#     fsx -q -S 0 -e 1 -N 100000
#    +READ BAD DATA: offset = 0xd6fb, size = 0xf044, fname = /mnt/f2fs/junk
#    +OFFSET      GOOD    BAD     RANGE
#    +0x1540d     0x0000  0x2a25  0x0
#    +operation# (mod 256) for the bad data may be 37
#    +0x1540e     0x0000  0x2527  0x1
#    ...
#    (Run 'diff -u /share/git/fstests/tests/generic/363.out /share/git/fstests/results//generic/363.out.bad'  to see the entire diff)
Ran: generic/363
Failures: generic/363
Failed 1 of 1 tests

The root cause is user can update post-eof page via mmap [1], however, f2fs
missed to zero post-eof page in below operations, so, once it expands i_size,
then it will include dummy data locates previous post-eof page, so during
below operations, we need to zero post-eof page.

Operations which can include dummy data after previous i_size after expanding
i_size:
- write
- mapwrite [1]
- truncate
- fallocate
 * preallocate
 * zero_range
 * insert_range
 * collapse_range
- clone_range (doesn’t support in f2fs)
- copy_range (doesn’t support in f2fs)

[1] https://man7.org/linux/man-pages/man2/mmap.2.html 'BUG section'

Cc: stable@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 121849a4dcfda..b73d40f981916 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -36,6 +36,17 @@
 #include <trace/events/f2fs.h>
 #include <uapi/linux/f2fs.h>
 
+static void f2fs_zero_post_eof_page(struct inode *inode, loff_t new_size)
+{
+	loff_t old_size = i_size_read(inode);
+
+	if (old_size >= new_size)
+		return;
+
+	/* zero or drop pages only in range of [old_size, new_size] */
+	truncate_pagecache(inode, old_size);
+}
+
 static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
@@ -103,8 +114,13 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
+	filemap_invalidate_lock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, (folio->index + 1) << PAGE_SHIFT);
+	filemap_invalidate_unlock(inode->i_mapping);
+
 	file_update_time(vmf->vma->vm_file);
 	filemap_invalidate_lock_shared(inode->i_mapping);
+
 	folio_lock(folio);
 	if (unlikely(folio->mapping != inode->i_mapping ||
 			folio_pos(folio) > i_size_read(inode) ||
@@ -1051,6 +1067,8 @@ int f2fs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
 
+		if (attr->ia_size > old_size)
+			f2fs_zero_post_eof_page(inode, attr->ia_size);
 		truncate_setsize(inode, attr->ia_size);
 
 		if (attr->ia_size <= old_size)
@@ -1169,6 +1187,10 @@ static int f2fs_punch_hole(struct inode *inode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
+	filemap_invalidate_lock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, offset + len);
+	filemap_invalidate_unlock(inode->i_mapping);
+
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
 
@@ -1453,6 +1475,8 @@ static int f2fs_do_collapse(struct inode *inode, loff_t offset, loff_t len)
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(inode->i_mapping);
 
+	f2fs_zero_post_eof_page(inode, offset + len);
+
 	f2fs_lock_op(sbi);
 	f2fs_drop_extent_tree(inode);
 	truncate_pagecache(inode, offset);
@@ -1575,6 +1599,10 @@ static int f2fs_zero_range(struct inode *inode, loff_t offset, loff_t len,
 	if (ret)
 		return ret;
 
+	filemap_invalidate_lock(mapping);
+	f2fs_zero_post_eof_page(inode, offset + len);
+	filemap_invalidate_unlock(mapping);
+
 	pg_start = ((unsigned long long) offset) >> PAGE_SHIFT;
 	pg_end = ((unsigned long long) offset + len) >> PAGE_SHIFT;
 
@@ -1706,6 +1734,8 @@ static int f2fs_insert_range(struct inode *inode, loff_t offset, loff_t len)
 	/* avoid gc operation during block exchange */
 	f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 	filemap_invalidate_lock(mapping);
+
+	f2fs_zero_post_eof_page(inode, offset + len);
 	truncate_pagecache(inode, offset);
 
 	while (!ret && idx > pg_start) {
@@ -1761,6 +1791,10 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
 	if (err)
 		return err;
 
+	filemap_invalidate_lock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, offset + len);
+	filemap_invalidate_unlock(inode->i_mapping);
+
 	f2fs_balance_fs(sbi, true);
 
 	pg_start = ((unsigned long long)offset) >> PAGE_SHIFT;
@@ -4674,6 +4708,10 @@ static ssize_t f2fs_write_checks(struct kiocb *iocb, struct iov_iter *from)
 	err = file_modified(file);
 	if (err)
 		return err;
+
+	filemap_invalidate_lock(inode->i_mapping);
+	f2fs_zero_post_eof_page(inode, iocb->ki_pos + iov_iter_count(from));
+	filemap_invalidate_unlock(inode->i_mapping);
 	return count;
 }
 
-- 
2.39.5





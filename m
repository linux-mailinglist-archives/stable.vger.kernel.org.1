Return-Path: <stable+bounces-122902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 132D1A5A1E8
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 19:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93AE189400C
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293D23535D;
	Mon, 10 Mar 2025 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VQQeJ7oy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EE623370D;
	Mon, 10 Mar 2025 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741630470; cv=none; b=WcVAmVcFD8vAZtWduHQ61NlzcAdGzIDW1MB6DomPH3vWDbZIH79TT6bGgbj++YvhxhyIC2vvtE6WdvTDSYoHOG0sc8nfm9uVmKx0uCD6jIYKZtY5f5Dfs7hQGnveVtHqHMInE88PV8P1nwoLvZc/4FTIpqNJBCfdNmVS+1t64GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741630470; c=relaxed/simple;
	bh=kNFBybKdzBiHzmo5epOltPYPefk2B7qLUBGmpIJsseg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIweAJOdvMtX/3igQE+j/X/+KS9nKY7JLT5yaVeHmtTRT3/ePDxgHO2T/osr59t+q5dhooqjmlkkEHjqiECCcLrByaHLogMYHvUrlNjmsmuioq4LU/pnBy6TMxpEqxWJIZEx2zesHoDrpTYGw93pW4Em/iVw6RvAuHH/hputdYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VQQeJ7oy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE62C4CEE5;
	Mon, 10 Mar 2025 18:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741630470;
	bh=kNFBybKdzBiHzmo5epOltPYPefk2B7qLUBGmpIJsseg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQQeJ7oyZTR8LJvFIMgAiUAH2VRebvOywd3WkxTWcGTC31V+wgqW9b/LdsDsn3coq
	 UHaIXpyZKa57uClhoquPBD5DJBP07pg3dywFCnzv2rbq5k5UiYXZF7vTmB/r9Kigdt
	 i4F71gzdUmDjSf5MreCY32S+a9Ac7PGHxfnvJLqQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	syzbot+b2b14916b77acf8626d7@syzkaller.appspotmail.com,
	syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com
Subject: [PATCH 5.15 417/620] nilfs2: do not force clear folio if buffer is referenced
Date: Mon, 10 Mar 2025 18:04:23 +0100
Message-ID: <20250310170602.049030938@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170545.553361750@linuxfoundation.org>
References: <20250310170545.553361750@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

commit ca76bb226bf47ff04c782cacbd299f12ddee1ec1 upstream.

Patch series "nilfs2: protect busy buffer heads from being force-cleared".

This series fixes the buffer head state inconsistency issues reported by
syzbot that occurs when the filesystem is corrupted and falls back to
read-only, and the associated buffer head use-after-free issue.

This patch (of 2):

Syzbot has reported that after nilfs2 detects filesystem corruption and
falls back to read-only, inconsistencies in the buffer state may occur.

One of the inconsistencies is that when nilfs2 calls mark_buffer_dirty()
to set a data or metadata buffer as dirty, but it detects that the buffer
is not in the uptodate state:

 WARNING: CPU: 0 PID: 6049 at fs/buffer.c:1177 mark_buffer_dirty+0x2e5/0x520
  fs/buffer.c:1177
 ...
 Call Trace:
  <TASK>
  nilfs_palloc_commit_alloc_entry+0x4b/0x160 fs/nilfs2/alloc.c:598
  nilfs_ifile_create_inode+0x1dd/0x3a0 fs/nilfs2/ifile.c:73
  nilfs_new_inode+0x254/0x830 fs/nilfs2/inode.c:344
  nilfs_mkdir+0x10d/0x340 fs/nilfs2/namei.c:218
  vfs_mkdir+0x2f9/0x4f0 fs/namei.c:4257
  do_mkdirat+0x264/0x3a0 fs/namei.c:4280
  __do_sys_mkdirat fs/namei.c:4295 [inline]
  __se_sys_mkdirat fs/namei.c:4293 [inline]
  __x64_sys_mkdirat+0x87/0xa0 fs/namei.c:4293
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
  entry_SYSCALL_64_after_hwframe+0x77/0x7f

The other is when nilfs_btree_propagate(), which propagates the dirty
state to the ancestor nodes of a b-tree that point to a dirty buffer,
detects that the origin buffer is not dirty, even though it should be:

 WARNING: CPU: 0 PID: 5245 at fs/nilfs2/btree.c:2089
  nilfs_btree_propagate+0xc79/0xdf0 fs/nilfs2/btree.c:2089
 ...
 Call Trace:
  <TASK>
  nilfs_bmap_propagate+0x75/0x120 fs/nilfs2/bmap.c:345
  nilfs_collect_file_data+0x4d/0xd0 fs/nilfs2/segment.c:587
  nilfs_segctor_apply_buffers+0x184/0x340 fs/nilfs2/segment.c:1006
  nilfs_segctor_scan_file+0x28c/0xa50 fs/nilfs2/segment.c:1045
  nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1216 [inline]
  nilfs_segctor_collect fs/nilfs2/segment.c:1540 [inline]
  nilfs_segctor_do_construct+0x1c28/0x6b90 fs/nilfs2/segment.c:2115
  nilfs_segctor_construct+0x181/0x6b0 fs/nilfs2/segment.c:2479
  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2587 [inline]
  nilfs_segctor_thread+0x69e/0xe80 fs/nilfs2/segment.c:2701
  kthread+0x2f0/0x390 kernel/kthread.c:389
  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
  </TASK>

Both of these issues are caused by the callbacks that handle the
page/folio write requests, forcibly clear various states, including the
working state of the buffers they hold, at unexpected times when they
detect read-only fallback.

Fix these issues by checking if the buffer is referenced before clearing
the page/folio state, and skipping the clear if it is.

[konishi.ryusuke@gmail.com: adjusted for page/folio conversion]
Link: https://lkml.kernel.org/r/20250107200202.6432-1-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/20250107200202.6432-2-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+b2b14916b77acf8626d7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b2b14916b77acf8626d7
Reported-by: syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=d98fd19acd08b36ff422
Fixes: 8c26c4e2694a ("nilfs2: fix issue with flush kernel thread after remount in RO mode because of driver's internal error or metadata corruption")
Tested-by: syzbot+b2b14916b77acf8626d7@syzkaller.appspotmail.com
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/page.c |   35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -388,24 +388,44 @@ void nilfs_clear_dirty_pages(struct addr
 /**
  * nilfs_clear_dirty_page - discard dirty page
  * @page: dirty page that will be discarded
+ *
+ * nilfs_clear_dirty_page() clears working states including dirty state for
+ * the page and its buffers.  If the page has buffers, clear only if it is
+ * confirmed that none of the buffer heads are busy (none have valid
+ * references and none are locked).
  */
 void nilfs_clear_dirty_page(struct page *page)
 {
 	BUG_ON(!PageLocked(page));
 
-	ClearPageUptodate(page);
-	ClearPageMappedToDisk(page);
-	ClearPageChecked(page);
-
 	if (page_has_buffers(page)) {
-		struct buffer_head *bh, *head;
+		struct buffer_head *bh, *head = page_buffers(page);
 		const unsigned long clear_bits =
 			(BIT(BH_Uptodate) | BIT(BH_Dirty) | BIT(BH_Mapped) |
 			 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
 			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
 			 BIT(BH_Delay));
+		bool busy, invalidated = false;
 
-		bh = head = page_buffers(page);
+recheck_buffers:
+		busy = false;
+		bh = head;
+		do {
+			if (atomic_read(&bh->b_count) | buffer_locked(bh)) {
+				busy = true;
+				break;
+			}
+		} while (bh = bh->b_this_page, bh != head);
+
+		if (busy) {
+			if (invalidated)
+				return;
+			invalidate_bh_lrus();
+			invalidated = true;
+			goto recheck_buffers;
+		}
+
+		bh = head;
 		do {
 			lock_buffer(bh);
 			set_mask_bits(&bh->b_state, clear_bits, 0);
@@ -413,6 +433,9 @@ void nilfs_clear_dirty_page(struct page
 		} while (bh = bh->b_this_page, bh != head);
 	}
 
+	ClearPageUptodate(page);
+	ClearPageMappedToDisk(page);
+	ClearPageChecked(page);
 	__nilfs_clear_page_dirty(page);
 }
 




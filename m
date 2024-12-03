Return-Path: <stable+bounces-97350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5649E23C6
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EFC428743B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6310205AC4;
	Tue,  3 Dec 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NtKPeH9h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940BC205AB8;
	Tue,  3 Dec 2024 15:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240232; cv=none; b=UCAo8doa71kgpbtiZL9CM5m2wcuzP4OJ2/Q05a1NmGlHN1zeH5YJTnSTT+SEKLIoXllliH5IOEi0TNcjzRTAG/AlaJATIkNe9k1QKbjd9sL0vtwAdGxkFfRKzfrH2XZ8bMsSbLKzsPLQ/x+Os5alDgpnpDDZWk6VC4L/i4GEE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240232; c=relaxed/simple;
	bh=8nymN4DW5m5gwM5EMjI/fBgWCm8Cnj3EQUklaxg0xJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1QSAcskLEuyKCZ3VeHSIr8mfHaanheRTHyYO7U8lh/jIcES/JgQYzFWB5tpVEBm7FkNTvc1n/snhES3rP9r1h6KiDL6FZykAkozRlsuxLeRAvru6YgdFFEmITyVNjvUq4YMXUfTlu4/fnkB4GgJsLG/YFHcCym0SFmk+VSwics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NtKPeH9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E48C4CECF;
	Tue,  3 Dec 2024 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240232;
	bh=8nymN4DW5m5gwM5EMjI/fBgWCm8Cnj3EQUklaxg0xJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtKPeH9huZVUBb85LWNrw7yLtSjON/8CTYmzgXJa66+799ld9ID8OKJHQbzlDTfQV
	 VhV3GdOyGSDPWNQ3pyrwQ2GVHEU6j3wH6czcJCSrWgyIlTIymbIhJeecMsfhmxmKPI
	 qyQKjfTaQPq37sX3i+fUGTxygBA1F5fdmdYf+sFA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Long Li <leo.lilong@huawei.com>,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 037/826] ext4: fix race in buffer_head read fault injection
Date: Tue,  3 Dec 2024 15:36:04 +0100
Message-ID: <20241203144744.909286734@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Long Li <leo.lilong@huawei.com>

[ Upstream commit 2f3d93e210b9c2866c8b3662adae427d5bf511ec ]

When I enabled ext4 debug for fault injection testing, I encountered the
following warning:

  EXT4-fs error (device sda): ext4_read_inode_bitmap:201: comm fsstress:
         Cannot read inode bitmap - block_group = 8, inode_bitmap = 1051
  WARNING: CPU: 0 PID: 511 at fs/buffer.c:1181 mark_buffer_dirty+0x1b3/0x1d0

The root cause of the issue lies in the improper implementation of ext4's
buffer_head read fault injection. The actual completion of buffer_head
read and the buffer_head fault injection are not atomic, which can lead
to the uptodate flag being cleared on normally used buffer_heads in race
conditions.

[CPU0]           [CPU1]         [CPU2]
ext4_read_inode_bitmap
  ext4_read_bh()
  <bh read complete>
                 ext4_read_inode_bitmap
                   if (buffer_uptodate(bh))
                     return bh
                               jbd2_journal_commit_transaction
                                 __jbd2_journal_refile_buffer
                                   __jbd2_journal_unfile_buffer
                                     __jbd2_journal_temp_unlink_buffer
  ext4_simulate_fail_bh()
    clear_buffer_uptodate
                                      mark_buffer_dirty
                                        <report warning>
                                        WARN_ON_ONCE(!buffer_uptodate(bh))

The best approach would be to perform fault injection in the IO completion
callback function, rather than after IO completion. However, the IO
completion callback function cannot get the fault injection code in sb.

Fix it by passing the result of fault injection into the bh read function,
we simulate faults within the bh read function itself. This requires adding
an extra parameter to the bh read functions that need fault injection.

Fixes: 46f870d690fe ("ext4: simulate various I/O and checksum errors when reading metadata")
Signed-off-by: Long Li <leo.lilong@huawei.com>
Link: https://patch.msgid.link/20240906091746.510163-1-leo.lilong@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/balloc.c      |  4 ++--
 fs/ext4/ext4.h        | 12 ++----------
 fs/ext4/extents.c     |  2 +-
 fs/ext4/ialloc.c      |  5 +++--
 fs/ext4/indirect.c    |  2 +-
 fs/ext4/inode.c       |  4 ++--
 fs/ext4/mmp.c         |  2 +-
 fs/ext4/move_extent.c |  2 +-
 fs/ext4/resize.c      |  2 +-
 fs/ext4/super.c       | 23 +++++++++++++++--------
 10 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 591fb3f710be7..8042ad8738089 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -550,7 +550,8 @@ ext4_read_block_bitmap_nowait(struct super_block *sb, ext4_group_t block_group,
 	trace_ext4_read_block_bitmap_load(sb, block_group, ignore_locked);
 	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO |
 			    (ignore_locked ? REQ_RAHEAD : 0),
-			    ext4_end_bitmap_read);
+			    ext4_end_bitmap_read,
+			    ext4_simulate_fail(sb, EXT4_SIM_BBITMAP_EIO));
 	return bh;
 verify:
 	err = ext4_validate_block_bitmap(sb, desc, block_group, bh);
@@ -577,7 +578,6 @@ int ext4_wait_block_bitmap(struct super_block *sb, ext4_group_t block_group,
 	if (!desc)
 		return -EFSCORRUPTED;
 	wait_on_buffer(bh);
-	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_BBITMAP_EIO);
 	if (!buffer_uptodate(bh)) {
 		ext4_error_err(sb, EIO, "Cannot read block bitmap - "
 			       "block_group = %u, block_bitmap = %llu",
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c2..bbffb76d9a904 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1865,14 +1865,6 @@ static inline bool ext4_simulate_fail(struct super_block *sb,
 	return false;
 }
 
-static inline void ext4_simulate_fail_bh(struct super_block *sb,
-					 struct buffer_head *bh,
-					 unsigned long code)
-{
-	if (!IS_ERR(bh) && ext4_simulate_fail(sb, code))
-		clear_buffer_uptodate(bh);
-}
-
 /*
  * Error number codes for s_{first,last}_error_errno
  *
@@ -3100,9 +3092,9 @@ extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
 extern struct buffer_head *ext4_sb_bread_unmovable(struct super_block *sb,
 						   sector_t block);
 extern void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
-				bh_end_io_t *end_io);
+				bh_end_io_t *end_io, bool simu_fail);
 extern int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
-			bh_end_io_t *end_io);
+			bh_end_io_t *end_io, bool simu_fail);
 extern int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
 extern void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block);
 extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 34e25eee65219..88f98dc440275 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -568,7 +568,7 @@ __read_extent_tree_block(const char *function, unsigned int line,
 
 	if (!bh_uptodate_or_lock(bh)) {
 		trace_ext4_ext_load_extent(inode, pblk, _RET_IP_);
-		err = ext4_read_bh(bh, 0, NULL);
+		err = ext4_read_bh(bh, 0, NULL, false);
 		if (err < 0)
 			goto errout;
 	}
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 7f1a5f90dbbdf..21d228073d795 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -193,8 +193,9 @@ ext4_read_inode_bitmap(struct super_block *sb, ext4_group_t block_group)
 	 * submit the buffer_head for reading
 	 */
 	trace_ext4_load_inode_bitmap(sb, block_group);
-	ext4_read_bh(bh, REQ_META | REQ_PRIO, ext4_end_bitmap_read);
-	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_IBITMAP_EIO);
+	ext4_read_bh(bh, REQ_META | REQ_PRIO,
+		     ext4_end_bitmap_read,
+		     ext4_simulate_fail(sb, EXT4_SIM_IBITMAP_EIO));
 	if (!buffer_uptodate(bh)) {
 		put_bh(bh);
 		ext4_error_err(sb, EIO, "Cannot read inode bitmap - "
diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
index 7404f0935c903..7de327fa7b1c5 100644
--- a/fs/ext4/indirect.c
+++ b/fs/ext4/indirect.c
@@ -170,7 +170,7 @@ static Indirect *ext4_get_branch(struct inode *inode, int depth,
 		}
 
 		if (!bh_uptodate_or_lock(bh)) {
-			if (ext4_read_bh(bh, 0, NULL) < 0) {
+			if (ext4_read_bh(bh, 0, NULL, false) < 0) {
 				put_bh(bh);
 				goto failure;
 			}
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe67..99d09cd9c6a37 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4497,10 +4497,10 @@ static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
 	 * Read the block from disk.
 	 */
 	trace_ext4_load_inode(sb, ino);
-	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL);
+	ext4_read_bh_nowait(bh, REQ_META | REQ_PRIO, NULL,
+			    ext4_simulate_fail(sb, EXT4_SIM_INODE_EIO));
 	blk_finish_plug(&plug);
 	wait_on_buffer(bh);
-	ext4_simulate_fail_bh(sb, bh, EXT4_SIM_INODE_EIO);
 	if (!buffer_uptodate(bh)) {
 		if (ret_block)
 			*ret_block = block;
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index bd946d0c71b70..d64c04ed061ae 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -94,7 +94,7 @@ static int read_mmp_block(struct super_block *sb, struct buffer_head **bh,
 	}
 
 	lock_buffer(*bh);
-	ret = ext4_read_bh(*bh, REQ_META | REQ_PRIO, NULL);
+	ret = ext4_read_bh(*bh, REQ_META | REQ_PRIO, NULL, false);
 	if (ret)
 		goto warn_exit;
 
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index b64661ea6e0ed..898443e98efc9 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -213,7 +213,7 @@ static int mext_page_mkuptodate(struct folio *folio, size_t from, size_t to)
 			unlock_buffer(bh);
 			continue;
 		}
-		ext4_read_bh_nowait(bh, 0, NULL);
+		ext4_read_bh_nowait(bh, 0, NULL, false);
 		nr++;
 	} while (block++, (bh = bh->b_this_page) != head);
 
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index a2704f0643610..72f77f78ae8df 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1300,7 +1300,7 @@ static struct buffer_head *ext4_get_bitmap(struct super_block *sb, __u64 block)
 	if (unlikely(!bh))
 		return NULL;
 	if (!bh_uptodate_or_lock(bh)) {
-		if (ext4_read_bh(bh, 0, NULL) < 0) {
+		if (ext4_read_bh(bh, 0, NULL, false) < 0) {
 			brelse(bh);
 			return NULL;
 		}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4645f16296732..95930e70b8aac 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -161,8 +161,14 @@ MODULE_ALIAS("ext3");
 
 
 static inline void __ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
-				  bh_end_io_t *end_io)
+				  bh_end_io_t *end_io, bool simu_fail)
 {
+	if (simu_fail) {
+		clear_buffer_uptodate(bh);
+		unlock_buffer(bh);
+		return;
+	}
+
 	/*
 	 * buffer's verified bit is no longer valid after reading from
 	 * disk again due to write out error, clear it to make sure we
@@ -176,7 +182,7 @@ static inline void __ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
 }
 
 void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
-			 bh_end_io_t *end_io)
+			 bh_end_io_t *end_io, bool simu_fail)
 {
 	BUG_ON(!buffer_locked(bh));
 
@@ -184,10 +190,11 @@ void ext4_read_bh_nowait(struct buffer_head *bh, blk_opf_t op_flags,
 		unlock_buffer(bh);
 		return;
 	}
-	__ext4_read_bh(bh, op_flags, end_io);
+	__ext4_read_bh(bh, op_flags, end_io, simu_fail);
 }
 
-int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags, bh_end_io_t *end_io)
+int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags,
+		 bh_end_io_t *end_io, bool simu_fail)
 {
 	BUG_ON(!buffer_locked(bh));
 
@@ -196,7 +203,7 @@ int ext4_read_bh(struct buffer_head *bh, blk_opf_t op_flags, bh_end_io_t *end_io
 		return 0;
 	}
 
-	__ext4_read_bh(bh, op_flags, end_io);
+	__ext4_read_bh(bh, op_flags, end_io, simu_fail);
 
 	wait_on_buffer(bh);
 	if (buffer_uptodate(bh))
@@ -208,10 +215,10 @@ int ext4_read_bh_lock(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
 {
 	lock_buffer(bh);
 	if (!wait) {
-		ext4_read_bh_nowait(bh, op_flags, NULL);
+		ext4_read_bh_nowait(bh, op_flags, NULL, false);
 		return 0;
 	}
-	return ext4_read_bh(bh, op_flags, NULL);
+	return ext4_read_bh(bh, op_flags, NULL, false);
 }
 
 /*
@@ -266,7 +273,7 @@ void ext4_sb_breadahead_unmovable(struct super_block *sb, sector_t block)
 
 	if (likely(bh)) {
 		if (trylock_buffer(bh))
-			ext4_read_bh_nowait(bh, REQ_RAHEAD, NULL);
+			ext4_read_bh_nowait(bh, REQ_RAHEAD, NULL, false);
 		brelse(bh);
 	}
 }
-- 
2.43.0





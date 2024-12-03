Return-Path: <stable+bounces-96952-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3665D9E21E0
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0388286B0E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A7A1F6696;
	Tue,  3 Dec 2024 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yALdwC4s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56769646;
	Tue,  3 Dec 2024 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239080; cv=none; b=YtQj1tx0/v2KHfg4itKR+5QEGEhd6ZzTFmAUNOYxRx0pubHibz6mEfvQYSjRRpcAym0jXscZLUqa6lw6VMNW81rg5iN9wKGcCJ2ozOdWyHurjjQCgYxdHF8EHbELi6ftrpJC+T7jlKl6X2WAjr9NUJcew22/V/UWtXHf5jPoquQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239080; c=relaxed/simple;
	bh=Pej+Z4lsAk2C5e+vev4Juylz8paaIAG9oNlbwZIIxYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=unVrDEnbAO8RiTfxhmb6/wmYiexXsETAPJAIGJF/eHFf19u7Wp1xVqMP+AqmA79XhZeLqEM45eUDug5o4OWsRQQRfkMzeMBGOIH3zrUuNBj0Y0YgcsJYiCUmm3DM1x1WiRDUs15rxcHcmYcj9MKhALqvH4bIOeRNNk/l/BaUgcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yALdwC4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C758C4CECF;
	Tue,  3 Dec 2024 15:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239079;
	bh=Pej+Z4lsAk2C5e+vev4Juylz8paaIAG9oNlbwZIIxYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yALdwC4soonAR24ZAJrGT4fO5zyYb8geP1FZtZlxw//8puLviPRg0GhkmSjdIivEP
	 tsDCEyekLuid8FtaDOnfqvplnUihsYWqkmsf1S9yKODult+401vnHNiVQCVj0vuQAK
	 1pBMkgh2KxFRLAlPpKuSS0c1/oln9Bd2pD6zVH+0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Rosenberg <drosen@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 495/817] f2fs: fix to account dirty data in __get_secs_required()
Date: Tue,  3 Dec 2024 15:41:07 +0100
Message-ID: <20241203144015.196321644@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chao Yu <chao@kernel.org>

[ Upstream commit 1acd73edbbfef2c3c5b43cba4006a7797eca7050 ]

It will trigger system panic w/ testcase in [1]:

------------[ cut here ]------------
kernel BUG at fs/f2fs/segment.c:2752!
RIP: 0010:new_curseg+0xc81/0x2110
Call Trace:
 f2fs_allocate_data_block+0x1c91/0x4540
 do_write_page+0x163/0xdf0
 f2fs_outplace_write_data+0x1aa/0x340
 f2fs_do_write_data_page+0x797/0x2280
 f2fs_write_single_data_page+0x16cd/0x2190
 f2fs_write_cache_pages+0x994/0x1c80
 f2fs_write_data_pages+0x9cc/0xea0
 do_writepages+0x194/0x7a0
 filemap_fdatawrite_wbc+0x12b/0x1a0
 __filemap_fdatawrite_range+0xbb/0xf0
 file_write_and_wait_range+0xa1/0x110
 f2fs_do_sync_file+0x26f/0x1c50
 f2fs_sync_file+0x12b/0x1d0
 vfs_fsync_range+0xfa/0x230
 do_fsync+0x3d/0x80
 __x64_sys_fsync+0x37/0x50
 x64_sys_call+0x1e88/0x20d0
 do_syscall_64+0x4b/0x110
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The root cause is if checkpoint_disabling and lfs_mode are both on,
it will trigger OPU for all overwritten data, it may cost more free
segment than expected, so f2fs must account those data correctly to
calculate cosumed free segments later, and return ENOSPC earlier to
avoid run out of free segment during block allocation.

[1] https://lore.kernel.org/fstests/20241015025106.3203676-1-chao@kernel.org/

Fixes: 4354994f097d ("f2fs: checkpoint disabling")
Cc: Daniel Rosenberg <drosen@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/segment.h | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index bfc01a521cb98..c3aeca7e0dde6 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -558,18 +558,21 @@ static inline int reserved_sections(struct f2fs_sb_info *sbi)
 }
 
 static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
-			unsigned int node_blocks, unsigned int dent_blocks)
+			unsigned int node_blocks, unsigned int data_blocks,
+			unsigned int dent_blocks)
 {
 
-	unsigned segno, left_blocks;
+	unsigned int segno, left_blocks, blocks;
 	int i;
 
-	/* check current node sections in the worst case. */
-	for (i = CURSEG_HOT_NODE; i <= CURSEG_COLD_NODE; i++) {
+	/* check current data/node sections in the worst case. */
+	for (i = CURSEG_HOT_DATA; i < NR_PERSISTENT_LOG; i++) {
 		segno = CURSEG_I(sbi, i)->segno;
 		left_blocks = CAP_BLKS_PER_SEC(sbi) -
 				get_ckpt_valid_blocks(sbi, segno, true);
-		if (node_blocks > left_blocks)
+
+		blocks = i <= CURSEG_COLD_DATA ? data_blocks : node_blocks;
+		if (blocks > left_blocks)
 			return false;
 	}
 
@@ -583,8 +586,9 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 }
 
 /*
- * calculate needed sections for dirty node/dentry
- * and call has_curseg_enough_space
+ * calculate needed sections for dirty node/dentry and call
+ * has_curseg_enough_space, please note that, it needs to account
+ * dirty data as well in lfs mode when checkpoint is disabled.
  */
 static inline void __get_secs_required(struct f2fs_sb_info *sbi,
 		unsigned int *lower_p, unsigned int *upper_p, bool *curseg_p)
@@ -593,19 +597,30 @@ static inline void __get_secs_required(struct f2fs_sb_info *sbi,
 					get_pages(sbi, F2FS_DIRTY_DENTS) +
 					get_pages(sbi, F2FS_DIRTY_IMETA);
 	unsigned int total_dent_blocks = get_pages(sbi, F2FS_DIRTY_DENTS);
+	unsigned int total_data_blocks = 0;
 	unsigned int node_secs = total_node_blocks / CAP_BLKS_PER_SEC(sbi);
 	unsigned int dent_secs = total_dent_blocks / CAP_BLKS_PER_SEC(sbi);
+	unsigned int data_secs = 0;
 	unsigned int node_blocks = total_node_blocks % CAP_BLKS_PER_SEC(sbi);
 	unsigned int dent_blocks = total_dent_blocks % CAP_BLKS_PER_SEC(sbi);
+	unsigned int data_blocks = 0;
+
+	if (f2fs_lfs_mode(sbi) &&
+		unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+		total_data_blocks = get_pages(sbi, F2FS_DIRTY_DATA);
+		data_secs = total_data_blocks / CAP_BLKS_PER_SEC(sbi);
+		data_blocks = total_data_blocks % CAP_BLKS_PER_SEC(sbi);
+	}
 
 	if (lower_p)
-		*lower_p = node_secs + dent_secs;
+		*lower_p = node_secs + dent_secs + data_secs;
 	if (upper_p)
 		*upper_p = node_secs + dent_secs +
-			(node_blocks ? 1 : 0) + (dent_blocks ? 1 : 0);
+			(node_blocks ? 1 : 0) + (dent_blocks ? 1 : 0) +
+			(data_blocks ? 1 : 0);
 	if (curseg_p)
 		*curseg_p = has_curseg_enough_space(sbi,
-				node_blocks, dent_blocks);
+				node_blocks, data_blocks, dent_blocks);
 }
 
 static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
-- 
2.43.0





Return-Path: <stable+bounces-99580-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AF49E7255
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FF31885D9D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B969156231;
	Fri,  6 Dec 2024 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TE747uHf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C5148314;
	Fri,  6 Dec 2024 15:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497660; cv=none; b=eT0hFJ83C+0Ca+emLbgdUKOdhV4IZmSHHpWT73D9TClLqzi5fO2wSpX6V7xpu9BFoyn1dxZpd+l3R5IORBIGCrnBkYlJtEU2qX6/WYz9Wf1TncoGkMRYgY1WbhbdiDm1AQ2Z8yIH5/IyJDwvJienTjfytDOVvdPOYuJ4U1iYAIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497660; c=relaxed/simple;
	bh=nwYAqDr98XWFGePUsFXAwWCueAVmrz8yKPVCTqg2wCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Coci32yAOm5owTrE4Z+2oGzJ/PtL9TCu4FUtcCMFtQgM74e4YXEoW7+q64D4KUQlBIt4mcmGDpEeBpyYmkYnOkOqL8DVvVusXQXrc23juQaRB4ANAVXW4EKRROs5jihJZWer1hUeuVfOOgxHN2DdGxxgoPQGOvCFKOy8/09Vrlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TE747uHf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4496DC4CED1;
	Fri,  6 Dec 2024 15:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497660;
	bh=nwYAqDr98XWFGePUsFXAwWCueAVmrz8yKPVCTqg2wCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TE747uHfFfzg4GFzAzT26W7eDIY3egdeKxfp0PU5uBUJamsXzgtUO0DBkpyWcXpA8
	 41lSsto0wkNIaWLJeL+TDsXNepf2QntCNk25asmV8EajI8OE0a4+tGaXY8r4JhdyYG
	 ABOwvSQ76mK2PVDN/HUpQjYGdHmfqGdBIF+SVgg4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Daniel Rosenberg <drosen@google.com>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 347/676] f2fs: fix to account dirty data in __get_secs_required()
Date: Fri,  6 Dec 2024 15:32:46 +0100
Message-ID: <20241206143706.901783175@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 952970166d5da..cd2ec6acc7177 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -559,18 +559,21 @@ static inline int reserved_sections(struct f2fs_sb_info *sbi)
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
 
@@ -584,8 +587,9 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
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
@@ -594,19 +598,30 @@ static inline void __get_secs_required(struct f2fs_sb_info *sbi,
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





Return-Path: <stable+bounces-110430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7C0A1BFDE
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 01:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D66F3A0547
	for <lists+stable@lfdr.de>; Sat, 25 Jan 2025 00:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5036BA53;
	Sat, 25 Jan 2025 00:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KLUpwWex"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AF3DF71
	for <stable@vger.kernel.org>; Sat, 25 Jan 2025 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737765187; cv=none; b=URf3TRT4SWdwD2EYh6uJ6NA4SJ2zU72zUUN58NufeE48PWvGsU9YGmKFPGki4PFRQmE33Dhim0jdEq+yYMRGoPjAzLbDUA5/wydHoDrfzRY88jpsJrXEKRbO6Wmly73NPpTBP6tB45ptZMBKlWzIs3kpqMilgHLZSC99NvDjpco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737765187; c=relaxed/simple;
	bh=7Vcqa/Sq1xQ/ef1M5E+y7F3vr3T4XpT1gL2drmodi8U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTTNA58XKExBsNsQz0eaTAlmnaNb0Ppk0TVspthd0kS9OGqy90zV6/OCMXSuJ/g21BtKnhaxhvgCV5VQlsmr1Q6vDAlhpA5uP36HikznZIQwooZHjG8GgLYYUi56kgGzq5xpVeueMNHg2ptWzJBVaIO4434yYhSK28sXHWWOlCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KLUpwWex; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737765185; x=1769301185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tQJHZc4SuDAGDR/wapKum//Qzy4SEjW+vMpTxosusMY=;
  b=KLUpwWexzmFNIXX7cubaFRVkW4R+lY0CnI7p+UZrWMeWm5yn8FRyc/8J
   N0saJxh9pkIK2/7Ir4DFOv0o4CjE3xWrs2Rg0KmhpEkcYAPXrVmkyT8eG
   Vxya5Y2Qygg+oMk976O4f57aQLj4kFMukMRvmqnj9xaAf8kBRYM817BYq
   w=;
X-IronPort-AV: E=Sophos;i="6.13,232,1732579200"; 
   d="scan'208";a="793546565"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 00:33:04 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:10335]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.215:2525] with esmtp (Farcaster)
 id 47258551-31a7-46bd-8880-141f7051b20a; Sat, 25 Jan 2025 00:33:04 +0000 (UTC)
X-Farcaster-Flow-ID: 47258551-31a7-46bd-8880-141f7051b20a
Received: from EX19D046UWB004.ant.amazon.com (10.13.139.164) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 25 Jan 2025 00:32:58 +0000
Received: from dev-dsk-shaoyi-2b-b6ac9e9c.us-west-2.amazon.com (10.189.91.91)
 by EX19D046UWB004.ant.amazon.com (10.13.139.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 25 Jan 2025 00:32:57 +0000
From: Shaoying Xu <shaoyi@amazon.com>
To: <stable@vger.kernel.org>
CC: <shaoyi@amazon.com>, Theodore Ts'o <tytso@mit.edu>, Anna Pendleton
	<pendleton@google.com>, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH 5.4 1/2] ext4: avoid ext4_error()'s caused by ENOMEM in the truncate path
Date: Sat, 25 Jan 2025 00:31:34 +0000
Message-ID: <20250125003135.11978-2-shaoyi@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250125003135.11978-1-shaoyi@amazon.com>
References: <20250125003135.11978-1-shaoyi@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D046UWB004.ant.amazon.com (10.13.139.164)

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 73c384c0cdaa8ea9ca9ef2d0cff6a25930f1648e ]

We can't fail in the truncate path without requiring an fsck.
Add work around for this by using a combination of retry loops
and the __GFP_NOFAIL flag.

From: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Anna Pendleton <pendleton@google.com>
Reviewed-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Link: https://lore.kernel.org/r/20200507175028.15061-1-pendleton@google.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: c26ab35702f8 ("ext4: fix slab-use-after-free in ext4_split_extent_at()")
[v5.4: resolved contextual conflict in __read_extent_tree_block]
Signed-off-by: Shaoying Xu <shaoyi@amazon.com>
---
 fs/ext4/ext4.h    |  1 +
 fs/ext4/extents.c | 43 +++++++++++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 4d02116193de..44bfa589ed36 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -628,6 +628,7 @@ enum {
  */
 #define EXT4_EX_NOCACHE				0x40000000
 #define EXT4_EX_FORCE_CACHE			0x20000000
+#define EXT4_EX_NOFAIL				0x10000000
 
 /*
  * Flags used by ext4_free_blocks
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0d692025f923..0e16e7c08a42 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -304,11 +304,14 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
 {
 	struct ext4_ext_path *path = *ppath;
 	int unwritten = ext4_ext_is_unwritten(path[path->p_depth].p_ext);
+	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_PRE_IO;
+
+	if (nofail)
+		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
 
 	return ext4_split_extent_at(handle, inode, ppath, lblk, unwritten ?
 			EXT4_EXT_MARK_UNWRIT1|EXT4_EXT_MARK_UNWRIT2 : 0,
-			EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_PRE_IO |
-			(nofail ? EXT4_GET_BLOCKS_METADATA_NOFAIL:0));
+			flags);
 }
 
 /*
@@ -572,9 +575,13 @@ __read_extent_tree_block(const char *function, unsigned int line,
 	struct buffer_head		*bh;
 	int				err;
 	ext4_fsblk_t			pblk;
+	gfp_t                           gfp_flags = __GFP_MOVABLE | GFP_NOFS;
+
+	if (flags & EXT4_EX_NOFAIL)
+		 gfp_flags |= __GFP_NOFAIL;
 
 	pblk = ext4_idx_pblock(idx);
-	bh = sb_getblk_gfp(inode->i_sb, pblk, __GFP_MOVABLE | GFP_NOFS);
+	bh = sb_getblk_gfp(inode->i_sb, pblk, gfp_flags);
 	if (unlikely(!bh))
 		return ERR_PTR(-ENOMEM);
 
@@ -919,6 +926,10 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	struct ext4_ext_path *path = orig_path ? *orig_path : NULL;
 	short int depth, i, ppos = 0;
 	int ret;
+	gfp_t gfp_flags = GFP_NOFS;
+
+	if (flags & EXT4_EX_NOFAIL)
+		gfp_flags |= __GFP_NOFAIL;
 
 	eh = ext_inode_hdr(inode);
 	depth = ext_depth(inode);
@@ -939,7 +950,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 	if (!path) {
 		/* account possible depth increase */
 		path = kcalloc(depth + 2, sizeof(struct ext4_ext_path),
-				GFP_NOFS);
+				gfp_flags);
 		if (unlikely(!path))
 			return ERR_PTR(-ENOMEM);
 		path[0].p_maxdepth = depth + 1;
@@ -1088,9 +1099,13 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	ext4_fsblk_t newblock, oldblock;
 	__le32 border;
 	ext4_fsblk_t *ablocks = NULL; /* array of allocated blocks */
+	gfp_t gfp_flags = GFP_NOFS;
 	int err = 0;
 	size_t ext_size = 0;
 
+	if (flags & EXT4_EX_NOFAIL)
+		gfp_flags |= __GFP_NOFAIL;
+
 	/* make decision: where to split? */
 	/* FIXME: now decision is simplest: at current extent */
 
@@ -1124,7 +1139,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	 * We need this to handle errors and free blocks
 	 * upon them.
 	 */
-	ablocks = kcalloc(depth, sizeof(ext4_fsblk_t), GFP_NOFS);
+	ablocks = kcalloc(depth, sizeof(ext4_fsblk_t), gfp_flags);
 	if (!ablocks)
 		return -ENOMEM;
 
@@ -2110,7 +2125,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	if (next != EXT_MAX_BLOCKS) {
 		ext_debug("next leaf block - %u\n", next);
 		BUG_ON(npath != NULL);
-		npath = ext4_find_extent(inode, next, NULL, 0);
+		npath = ext4_find_extent(inode, next, NULL, gb_flags);
 		if (IS_ERR(npath))
 			return PTR_ERR(npath);
 		BUG_ON(npath->p_depth != path->p_depth);
@@ -3018,7 +3033,8 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		ext4_fsblk_t pblk;
 
 		/* find extent for or closest extent to this block */
-		path = ext4_find_extent(inode, end, NULL, EXT4_EX_NOCACHE);
+		path = ext4_find_extent(inode, end, NULL,
+					EXT4_EX_NOCACHE | EXT4_EX_NOFAIL);
 		if (IS_ERR(path)) {
 			ext4_journal_stop(handle);
 			return PTR_ERR(path);
@@ -3104,7 +3120,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				le16_to_cpu(path[k].p_hdr->eh_entries)+1;
 	} else {
 		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
-			       GFP_NOFS);
+			       GFP_NOFS | __GFP_NOFAIL);
 		if (path == NULL) {
 			ext4_journal_stop(handle);
 			return -ENOMEM;
@@ -3528,7 +3544,7 @@ static int ext4_split_extent(handle_t *handle,
 	 * Update path is required because previous ext4_split_extent_at() may
 	 * result in split of original leaf or extent zeroout.
 	 */
-	path = ext4_find_extent(inode, map->m_lblk, ppath, 0);
+	path = ext4_find_extent(inode, map->m_lblk, ppath, flags);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	depth = ext_depth(inode);
@@ -4650,7 +4666,14 @@ int ext4_ext_truncate(handle_t *handle, struct inode *inode)
 	}
 	if (err)
 		return err;
-	return ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1);
+retry_remove_space:
+	err = ext4_ext_remove_space(inode, last_block, EXT_MAX_BLOCKS - 1);
+	if (err == -ENOMEM) {
+		cond_resched();
+		congestion_wait(BLK_RW_ASYNC, HZ/50);
+		goto retry_remove_space;
+	}
+	return err;
 }
 
 static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
-- 
2.40.1



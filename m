Return-Path: <stable+bounces-148759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C4AACA68D
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 02:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C3D188EB8A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 00:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFF129C8F0;
	Sun,  1 Jun 2025 23:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IU8aaI89"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E3F29C8E9;
	Sun,  1 Jun 2025 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748821268; cv=none; b=ZGhQ6/OlCasFqLWJA7T//sbJXgNuwwE1O6QO4l9Jkz12G78EEzI4wJKFGv+/eLbVGasFuiIdT6mi2iQGAPNPn40BBPQx7u0kcDbNSXmk2XVr4qTUxEG3dv4vq4wL4s0HeyD6icWvzlbBHbJHIIuliM/0hxz66ICrIL4aIlVvfrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748821268; c=relaxed/simple;
	bh=QKapPQGJ2mADa+YKeWbrwZTvRe4mPzQ7TtQ8vUT/deM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GGKM11a2DAVTz38hoRCd5+pftg700a8QeB/Z9/htQmdF7qsHGJvv12zlQAcvwIep/+k60/bDSQ6xDXgJ905odm98O0QRvmmkugzpZxuJcPIyohTijXOtEAvBvspyz9nU5wYw3cJviMJugxQUQJRaCIblhyiwN8jyf0TrbeFSDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IU8aaI89; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F19AC4CEEE;
	Sun,  1 Jun 2025 23:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748821268;
	bh=QKapPQGJ2mADa+YKeWbrwZTvRe4mPzQ7TtQ8vUT/deM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IU8aaI89VZpUzJQQIWGHLTJqIegqfKl50cmCWRW4fI/UsFeHpPQ3o9CcrwA5Z/NCo
	 5j0XtorXMnYGIfEb/O8/CDcr6XrblWkxKEcH/l+BSiQcFOS3zB88OVVmzFSZ5GqpA3
	 hV82ZNPRlqSASl+5gnkoHcfUYELcHBK0OT8v0jtglFsuUe1RQOP5m2KHNytzUwzXDa
	 6/7QZwg4QGathuxmJBs5UQHqtCJLvnEjpIAleolEveZ3/2xXWdFDXsPyjmHttKG/vM
	 KCwuR3lKKiutOt74AxCyMSWwFxLzg0VpQ4vlM1irdSS7ogYFE6Cy1gruXREUD7PU6P
	 WbWU9Q8V5hTXA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 22/58] ext4: ext4: unify EXT4_EX_NOCACHE|NOFAIL flags in ext4_ext_remove_space()
Date: Sun,  1 Jun 2025 19:39:35 -0400
Message-Id: <20250601234012.3516352-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250601234012.3516352-1-sashal@kernel.org>
References: <20250601234012.3516352-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.140
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 53ce42accd2002cc490fc86000ac532530507a74 ]

When removing space, we should use EXT4_EX_NOCACHE because we don't
need to cache extents, and we should also use EXT4_EX_NOFAIL to prevent
metadata inconsistencies that may arise from memory allocation failures.
While ext4_ext_remove_space() already uses these two flags in most
places, they are missing in ext4_ext_search_right() and
read_extent_tree_block() calls. Unify the flags to ensure consistent
behavior throughout the extent removal process.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20250423085257.122685-2-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

Based on my thorough analysis of this commit and the kernel code
context, here is my assessment: **YES** This commit should be backported
to stable kernel trees. ## Detailed Analysis: ### **Nature of the Bug
Fix** This commit addresses an important consistency issue in the ext4
extent removal process. The problem is that `ext4_ext_remove_space()`
inconsistently applies critical flags (`EXT4_EX_NOCACHE |
EXT4_EX_NOFAIL`) across all its `read_extent_tree_block()` calls. ###
**Technical Impact** 1. **`EXT4_EX_NOCACHE`**: Prevents caching of
extents during removal operations. Without this flag in
`ext4_ext_search_right()` calls (lines 1607, 1615), the extent cache
could become polluted with stale entries during space removal,
potentially leading to incorrect block mappings. 2.
**`EXT4_EX_NOFAIL`**: Ensures memory allocation cannot fail during
critical metadata operations. The absence of this flag in the affected
calls could cause metadata inconsistencies if memory allocation fails
during extent tree traversal. ### **Risk Assessment - Low Risk** -
**Small, contained change**: Only adds consistent flag usage across
existing function calls - **No algorithmic changes**: The core logic
remains unchanged - **Well-understood flags**: Both flags are already
used extensively in the same function ### **Comparison with Historical
Commits** **Similar to "YES" commits:** - Like commit #1 (ext4 cache
pollution fix): Addresses extent cache consistency issues - Like commit
#2 (nofail preallocation): Prevents metadata inconsistencies from
allocation failures - Small, targeted fix with clear purpose - Addresses
potential data corruption scenarios **Unlike "NO" commits:** - Not a
cleanup/refactoring (commits #3, #4, #5 were architectural changes) -
Not removing functionality or making API changes - Fixes an actual bug
rather than just code organization ### **Code Evidence** The changes are
in `/fs/ext4/extents.c:1607, 1615, 2980, 2920, 4299`: 1. **Lines 1607,
1615**: `ext4_ext_search_right()` now receives and uses flags parameter
2. **Line 2980**: `read_extent_tree_block()` in the main removal loop
now uses unified flags 3. **Line 2920**: `ext4_ext_search_right()` call
now passes flags consistently 4. **Line 4299**: Non-removal path
correctly passes 0 flags (no change in behavior) ### **Subsystem
Context** From examining the kernel source: - `EXT4_EX_NOCACHE` prevents
extent caching when `depth == 0` (line ~460 in extents.c) -
`EXT4_EX_NOFAIL` adds `__GFP_NOFAIL` to allocation flags (line ~397 in
extents.c) - The function `ext4_ext_remove_space()` is called during
truncation and punch hole operations ### **User Impact** This fixes
potential filesystem corruption during: - File truncation operations -
Punch hole operations - Any extent removal scenarios The inconsistent
flag usage could lead to stale extent cache entries and allocation
failures during critical metadata operations, both of which can cause
filesystem corruption. ### **Conclusion** This is a clear bug fix that
prevents potential filesystem corruption with minimal risk of
regression. It follows the pattern of similar commits that were
successfully backported and addresses a real consistency issue that
could affect filesystem reliability.

 fs/ext4/extents.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 53fd2431062cd..323ac63a71af2 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1536,7 +1536,7 @@ static int ext4_ext_search_left(struct inode *inode,
 static int ext4_ext_search_right(struct inode *inode,
 				 struct ext4_ext_path *path,
 				 ext4_lblk_t *logical, ext4_fsblk_t *phys,
-				 struct ext4_extent *ret_ex)
+				 struct ext4_extent *ret_ex, int flags)
 {
 	struct buffer_head *bh = NULL;
 	struct ext4_extent_header *eh;
@@ -1610,7 +1610,8 @@ static int ext4_ext_search_right(struct inode *inode,
 	ix++;
 	while (++depth < path->p_depth) {
 		/* subtract from p_depth to get proper eh_depth */
-		bh = read_extent_tree_block(inode, ix, path->p_depth - depth, 0);
+		bh = read_extent_tree_block(inode, ix, path->p_depth - depth,
+					    flags);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		eh = ext_block_hdr(bh);
@@ -1618,7 +1619,7 @@ static int ext4_ext_search_right(struct inode *inode,
 		put_bh(bh);
 	}
 
-	bh = read_extent_tree_block(inode, ix, path->p_depth - depth, 0);
+	bh = read_extent_tree_block(inode, ix, path->p_depth - depth, flags);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 	eh = ext_block_hdr(bh);
@@ -2800,6 +2801,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	struct partial_cluster partial;
 	handle_t *handle;
 	int i = 0, err = 0;
+	int flags = EXT4_EX_NOCACHE | EXT4_EX_NOFAIL;
 
 	partial.pclu = 0;
 	partial.lblk = 0;
@@ -2830,8 +2832,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		ext4_fsblk_t pblk;
 
 		/* find extent for or closest extent to this block */
-		path = ext4_find_extent(inode, end, NULL,
-					EXT4_EX_NOCACHE | EXT4_EX_NOFAIL);
+		path = ext4_find_extent(inode, end, NULL, flags);
 		if (IS_ERR(path)) {
 			ext4_journal_stop(handle);
 			return PTR_ERR(path);
@@ -2896,7 +2897,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 			 */
 			lblk = ex_end + 1;
 			err = ext4_ext_search_right(inode, path, &lblk, &pblk,
-						    NULL);
+						    NULL, flags);
 			if (err < 0)
 				goto out;
 			if (pblk) {
@@ -2973,8 +2974,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 				  i + 1, ext4_idx_pblock(path[i].p_idx));
 			memset(path + i + 1, 0, sizeof(*path));
 			bh = read_extent_tree_block(inode, path[i].p_idx,
-						    depth - i - 1,
-						    EXT4_EX_NOCACHE);
+						    depth - i - 1, flags);
 			if (IS_ERR(bh)) {
 				/* should we reset i_size? */
 				err = PTR_ERR(bh);
@@ -4275,7 +4275,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	if (err)
 		goto out;
 	ar.lright = map->m_lblk;
-	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright, &ex2);
+	err = ext4_ext_search_right(inode, path, &ar.lright, &ar.pright,
+				    &ex2, 0);
 	if (err < 0)
 		goto out;
 
-- 
2.39.5



Return-Path: <stable+bounces-219607-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJFpNZb4nmm+YAQAu9opvQ
	(envelope-from <stable+bounces-219607-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:26:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 37DEC19807B
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4C0630D81A2
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7603B8D46;
	Wed, 25 Feb 2026 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzxukc6U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F034234F49A
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025777; cv=none; b=o+AfvdqEUbJI7BXPzHx4Kq1n2ULdvem47QSQ1/y91MFDnP7Da6p8vy1Xsra5vPxB3lUQBuZoZSKdA4ttqLmEAN1hVYMGt3akbsfEn59lIh6BJmq3/C/W5tWKVXnRGI1pIkMImYvoXUWMb8dngLcIYJBqT5JUltfPhqGJIc7JmnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025777; c=relaxed/simple;
	bh=L6ea4vfa/4eDJ29TtQKkFn6mny52OoYJMc0ko//57kI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0TV22nTJ0D8lhmUwtzjgbd7RR2NaED2kNJ/YPnGSk7/JMTvzF4AWOGpTyCf50ixnfq1d0GmMPU354Y94wknWAcYPJA1VeqFgJDc/KqbEQlOaYoGlFxsxIov3ENOQUOs+i7mI7A+RRc8rISsSDg/PjxFfQ2Hdf2FMS0Ltnu+fGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzxukc6U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCBDC19421;
	Wed, 25 Feb 2026 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025776;
	bh=L6ea4vfa/4eDJ29TtQKkFn6mny52OoYJMc0ko//57kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzxukc6UOVq6iINNP8xOSTwjd8DlZfbQsDNkm+omLlGlGn+rkbefDNeAPx/l2VpZH
	 U/R/EAcrN4JoqUTbTn0NaRH02+Li+GxSPXgAqtOTB4OnLA9QQmE9matYBwoXK69nr0
	 ih6vN8IftU/77TS2hYg6XHPN6u2DxJyhJlAsHD0I0Tfd/xu1yw6DI+18T8ug5srbO/
	 pzTSVTEF3VVc5+YFhwFx3yryglklzGAx2GnTMz4rbncNALvA2tD0Kp/OPL9uip2+js
	 54j8q2AfQk92zDG7re7q4NRB4xmwSMgntle9H8DI0mjEnMxCywozitBaytXv3GjBoQ
	 nj8HQqSodV1ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/6] ext4: get rid of ppath in ext4_find_extent()
Date: Wed, 25 Feb 2026 08:22:49 -0500
Message-ID: <20260225132253.222588-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225132253.222588-1-sashal@kernel.org>
References: <2026022428-arrogant-refill-c828@gregkh>
 <20260225132253.222588-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219607-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email,msgid.link:url]
X-Rspamd-Queue-Id: 37DEC19807B
X-Rspamd-Action: no action

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 0be4c0c2f17bd10ae16c852f02d51a6a7b318aca ]

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

Getting rid of ppath in ext4_find_extent() requires its caller to update
ppath. These ppaths will also be dropped later. No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20240822023545.1994557-12-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 79b592e8f1b4 ("ext4: drop extent cache when splitting extent fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h        |  2 +-
 fs/ext4/extents.c     | 55 +++++++++++++++++++++++--------------------
 fs/ext4/move_extent.c |  7 +++---
 3 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 27753291fb7ec..490496adf17cc 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3723,7 +3723,7 @@ extern int ext4_ext_insert_extent(handle_t *, struct inode *,
 				  struct ext4_ext_path **,
 				  struct ext4_extent *, int);
 extern struct ext4_ext_path *ext4_find_extent(struct inode *, ext4_lblk_t,
-					      struct ext4_ext_path **,
+					      struct ext4_ext_path *,
 					      int flags);
 extern void ext4_free_ext_path(struct ext4_ext_path *);
 extern int ext4_ext_check_inode(struct inode *inode);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 8100e20475f30..1285b8edd62fc 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -881,11 +881,10 @@ void ext4_ext_tree_init(handle_t *handle, struct inode *inode)
 
 struct ext4_ext_path *
 ext4_find_extent(struct inode *inode, ext4_lblk_t block,
-		 struct ext4_ext_path **orig_path, int flags)
+		 struct ext4_ext_path *path, int flags)
 {
 	struct ext4_extent_header *eh;
 	struct buffer_head *bh;
-	struct ext4_ext_path *path = orig_path ? *orig_path : NULL;
 	short int depth, i, ppos = 0;
 	int ret;
 	gfp_t gfp_flags = GFP_NOFS;
@@ -906,7 +905,7 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 		ext4_ext_drop_refs(path);
 		if (depth > path[0].p_maxdepth) {
 			kfree(path);
-			*orig_path = path = NULL;
+			path = NULL;
 		}
 	}
 	if (!path) {
@@ -957,14 +956,10 @@ ext4_find_extent(struct inode *inode, ext4_lblk_t block,
 
 	ext4_ext_show_path(inode, path);
 
-	if (orig_path)
-		*orig_path = path;
 	return path;
 
 err:
 	ext4_free_ext_path(path);
-	if (orig_path)
-		*orig_path = NULL;
 	return ERR_PTR(ret);
 }
 
@@ -1429,7 +1424,7 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 		/* refill path */
 		path = ext4_find_extent(inode,
 				    (ext4_lblk_t)le32_to_cpu(newext->ee_block),
-				    ppath, gb_flags);
+				    path, gb_flags);
 		if (IS_ERR(path))
 			err = PTR_ERR(path);
 	} else {
@@ -1441,7 +1436,7 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 		/* refill path */
 		path = ext4_find_extent(inode,
 				   (ext4_lblk_t)le32_to_cpu(newext->ee_block),
-				    ppath, gb_flags);
+				    path, gb_flags);
 		if (IS_ERR(path)) {
 			err = PTR_ERR(path);
 			goto out;
@@ -1457,8 +1452,8 @@ static int ext4_ext_create_new_leaf(handle_t *handle, struct inode *inode,
 			goto repeat;
 		}
 	}
-
 out:
+	*ppath = IS_ERR(path) ? NULL : path;
 	return err;
 }
 
@@ -3245,15 +3240,17 @@ static int ext4_split_extent_at(handle_t *handle,
 	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
 	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
 	 */
-	path = ext4_find_extent(inode, ee_block, ppath,
+	path = ext4_find_extent(inode, ee_block, *ppath,
 				flags | EXT4_EX_NOFAIL);
 	if (IS_ERR(path)) {
 		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
 				 split, PTR_ERR(path));
+		*ppath = NULL;
 		return PTR_ERR(path);
 	}
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
+	*ppath = path;
 
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
 		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
@@ -3363,9 +3360,12 @@ static int ext4_split_extent(handle_t *handle,
 	 * Update path is required because previous ext4_split_extent_at() may
 	 * result in split of original leaf or extent zeroout.
 	 */
-	path = ext4_find_extent(inode, map->m_lblk, ppath, flags);
-	if (IS_ERR(path))
+	path = ext4_find_extent(inode, map->m_lblk, *ppath, flags);
+	if (IS_ERR(path)) {
+		*ppath = NULL;
 		return PTR_ERR(path);
+	}
+	*ppath = path;
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
 	if (!ex) {
@@ -3752,9 +3752,12 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 						 EXT4_GET_BLOCKS_CONVERT);
 		if (err < 0)
 			return err;
-		path = ext4_find_extent(inode, map->m_lblk, ppath, 0);
-		if (IS_ERR(path))
+		path = ext4_find_extent(inode, map->m_lblk, *ppath, 0);
+		if (IS_ERR(path)) {
+			*ppath = NULL;
 			return PTR_ERR(path);
+		}
+		*ppath = path;
 		depth = ext_depth(inode);
 		ex = path[depth].p_ext;
 	}
@@ -3810,9 +3813,12 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN);
 		if (err < 0)
 			return err;
-		path = ext4_find_extent(inode, map->m_lblk, ppath, 0);
-		if (IS_ERR(path))
+		path = ext4_find_extent(inode, map->m_lblk, *ppath, 0);
+		if (IS_ERR(path)) {
+			*ppath = NULL;
 			return PTR_ERR(path);
+		}
+		*ppath = path;
 		depth = ext_depth(inode);
 		ex = path[depth].p_ext;
 		if (!ex) {
@@ -5191,7 +5197,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 	* won't be shifted beyond EXT_MAX_BLOCKS.
 	*/
 	if (SHIFT == SHIFT_LEFT) {
-		path = ext4_find_extent(inode, start - 1, &path,
+		path = ext4_find_extent(inode, start - 1, path,
 					EXT4_EX_NOCACHE);
 		if (IS_ERR(path))
 			return PTR_ERR(path);
@@ -5240,7 +5246,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
 	 * becomes NULL to indicate the end of the loop.
 	 */
 	while (iterator && start <= stop) {
-		path = ext4_find_extent(inode, *iterator, &path,
+		path = ext4_find_extent(inode, *iterator, path,
 					EXT4_EX_NOCACHE);
 		if (IS_ERR(path))
 			return PTR_ERR(path);
@@ -5837,11 +5843,8 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
 
 	/* search for the extent closest to the first block in the cluster */
 	path = ext4_find_extent(inode, EXT4_C2B(sbi, lclu), NULL, 0);
-	if (IS_ERR(path)) {
-		err = PTR_ERR(path);
-		path = NULL;
-		goto out;
-	}
+	if (IS_ERR(path))
+		return PTR_ERR(path);
 
 	depth = ext_depth(inode);
 
@@ -5925,7 +5928,7 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
 		if (ret)
 			goto out;
 
-		path = ext4_find_extent(inode, start, &path, 0);
+		path = ext4_find_extent(inode, start, path, 0);
 		if (IS_ERR(path))
 			return PTR_ERR(path);
 		ex = path[path->p_depth].p_ext;
@@ -5939,7 +5942,7 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
 			if (ret)
 				goto out;
 
-			path = ext4_find_extent(inode, start, &path, 0);
+			path = ext4_find_extent(inode, start, path, 0);
 			if (IS_ERR(path))
 				return PTR_ERR(path);
 			ex = path[path->p_depth].p_ext;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index e01632462db9f..0aff07c570a46 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -26,16 +26,17 @@ static inline int
 get_ext_path(struct inode *inode, ext4_lblk_t lblock,
 		struct ext4_ext_path **ppath)
 {
-	struct ext4_ext_path *path;
+	struct ext4_ext_path *path = *ppath;
 
-	path = ext4_find_extent(inode, lblock, ppath, EXT4_EX_NOCACHE);
+	*ppath = NULL;
+	path = ext4_find_extent(inode, lblock, path, EXT4_EX_NOCACHE);
 	if (IS_ERR(path))
 		return PTR_ERR(path);
 	if (path[ext_depth(inode)].p_ext == NULL) {
 		ext4_free_ext_path(path);
-		*ppath = NULL;
 		return -ENODATA;
 	}
+	*ppath = path;
 	return 0;
 }
 
-- 
2.51.0



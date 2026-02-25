Return-Path: <stable+bounces-219172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aG83APBonmmzVAQAu9opvQ
	(envelope-from <stable+bounces-219172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:13:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A42D319122D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 04:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60551303E756
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2934C296BB6;
	Wed, 25 Feb 2026 03:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UaAzEzJD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1301288C08
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771989229; cv=none; b=mPbH4N4pQpMlobGAoTDgz7VYtMyzA8SeGFw39rYndmhFMpiESkwekNIZQOPea1dt/EmXtzS51izB2fvfQvcHw6EEFcZTKt8SNg9gqoskeN+OtHQ6r5o5JIbPzU/CTsFNM6OvQbJT0VF/Qh0KWyilDLeDqmG4RnLh9hQ/iPyFTTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771989229; c=relaxed/simple;
	bh=NNor9zDAHtWWQ7SQXQQLqKgqSrPhKyVO9jBW+luvw3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s6JvRka5CyuUWO4rJ76nAcFBaqwmOMRvTFp6aucX6+lv9OI4l7zy9i2BUv0DnnWhwdy86M5P6yTntkoPL2W89TcJYWmG5yJzD7BCLwwXZCtQYKxFUW5rinGo9Oqmz+4jP0ZkscV8uo6vm2gfAk647wTP0QWuIRMlRfXJ6ziqj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UaAzEzJD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A121C19422;
	Wed, 25 Feb 2026 03:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771989228;
	bh=NNor9zDAHtWWQ7SQXQQLqKgqSrPhKyVO9jBW+luvw3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UaAzEzJDteT8P4gOJi65mKfMAxGeazgCEDQtrqYEQ7xa1JpU8xJan9B20H5mE+p6M
	 U8/fOrGvyPVEWNyMOuZgafrZGSmt0Lbs5gexIlzom5kVKYUUZKF2ftcNrnLUijzaGQ
	 onwXZ4+lMOBAA5wC++n5BSRegX002SEqkARgBiPHng5PG0VPCjZ1dTPho8eZfPW4T2
	 JcBwkpUqkUIs5EChkomIPqNs98iTFTCU9XB5qJy+n0WeElRuj0Uyh1UrbbuMEMAHoJ
	 /acc2LCnhmganxOTAx4hJEFX3NJyjabrrpiaaZVIyB7NDlbPcfXIafHK8fJn9KhcHL
	 kTx2fYwT7a1pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/7] ext4: get rid of ppath in ext4_ext_insert_extent()
Date: Tue, 24 Feb 2026 22:13:40 -0500
Message-ID: <20260225031343.3858545-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225031343.3858545-1-sashal@kernel.org>
References: <2026022439-revered-giddily-d324@gregkh>
 <20260225031343.3858545-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219172-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: A42D319122D
X-Rspamd-Action: no action

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit f7d1331f16a869c76a5102caebb58e840e1d509c ]

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_ext_insert_extent(), the following is done
here:

 * Free the extents path when an error is encountered.
 * Its caller needs to update ppath if it uses ppath.
 * Free path when npath is used, free npath when it is not used.
 * The got_allocated_blocks label in ext4_ext_map_blocks() does not
   update err now, so err is updated to 0 if the err returned by
   ext4_ext_search_right() is greater than 0 and is about to enter
   got_allocated_blocks.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20240822023545.1994557-15-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 1bf6974822d1 ("ext4: don't zero the entire extent if EXT4_EXT_DATA_PARTIAL_VALID1")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/ext4.h        |  7 ++--
 fs/ext4/extents.c     | 88 ++++++++++++++++++++++++-------------------
 fs/ext4/fast_commit.c |  8 ++--
 fs/ext4/migrate.c     |  5 ++-
 4 files changed, 61 insertions(+), 47 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 490496adf17cc..7449777fabc36 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3719,9 +3719,10 @@ extern int ext4_map_blocks(handle_t *handle, struct inode *inode,
 extern int ext4_ext_calc_credits_for_single_extent(struct inode *inode,
 						   int num,
 						   struct ext4_ext_path *path);
-extern int ext4_ext_insert_extent(handle_t *, struct inode *,
-				  struct ext4_ext_path **,
-				  struct ext4_extent *, int);
+extern struct ext4_ext_path *ext4_ext_insert_extent(
+				handle_t *handle, struct inode *inode,
+				struct ext4_ext_path *path,
+				struct ext4_extent *newext, int gb_flags);
 extern struct ext4_ext_path *ext4_find_extent(struct inode *, ext4_lblk_t,
 					      struct ext4_ext_path *,
 					      int flags);
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 37113982a3329..8a5c1e1207ba7 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1960,16 +1960,15 @@ static unsigned int ext4_ext_check_overlap(struct ext4_sb_info *sbi,
  * inserts requested extent as new one into the tree,
  * creating new leaf in the no-space case.
  */
-int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
-				struct ext4_ext_path **ppath,
-				struct ext4_extent *newext, int gb_flags)
+struct ext4_ext_path *
+ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
+		       struct ext4_ext_path *path,
+		       struct ext4_extent *newext, int gb_flags)
 {
-	struct ext4_ext_path *path = *ppath;
 	struct ext4_extent_header *eh;
 	struct ext4_extent *ex, *fex;
 	struct ext4_extent *nearex; /* nearest extent */
-	struct ext4_ext_path *npath = NULL;
-	int depth, len, err;
+	int depth, len, err = 0;
 	ext4_lblk_t next;
 	int mb_flags = 0, unwritten;
 
@@ -1977,14 +1976,16 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 		mb_flags |= EXT4_MB_DELALLOC_RESERVED;
 	if (unlikely(ext4_ext_get_actual_len(newext) == 0)) {
 		EXT4_ERROR_INODE(inode, "ext4_ext_get_actual_len(newext) == 0");
-		return -EFSCORRUPTED;
+		err = -EFSCORRUPTED;
+		goto errout;
 	}
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
 	eh = path[depth].p_hdr;
 	if (unlikely(path[depth].p_hdr == NULL)) {
 		EXT4_ERROR_INODE(inode, "path[%d].p_hdr == NULL", depth);
-		return -EFSCORRUPTED;
+		err = -EFSCORRUPTED;
+		goto errout;
 	}
 
 	/* try to insert block into found extent and return */
@@ -2022,7 +2023,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 			err = ext4_ext_get_access(handle, inode,
 						  path + depth);
 			if (err)
-				return err;
+				goto errout;
 			unwritten = ext4_ext_is_unwritten(ex);
 			ex->ee_len = cpu_to_le16(ext4_ext_get_actual_len(ex)
 					+ ext4_ext_get_actual_len(newext));
@@ -2047,7 +2048,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 			err = ext4_ext_get_access(handle, inode,
 						  path + depth);
 			if (err)
-				return err;
+				goto errout;
 
 			unwritten = ext4_ext_is_unwritten(ex);
 			ex->ee_block = newext->ee_block;
@@ -2072,21 +2073,26 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	if (le32_to_cpu(newext->ee_block) > le32_to_cpu(fex->ee_block))
 		next = ext4_ext_next_leaf_block(path);
 	if (next != EXT_MAX_BLOCKS) {
+		struct ext4_ext_path *npath;
+
 		ext_debug(inode, "next leaf block - %u\n", next);
-		BUG_ON(npath != NULL);
 		npath = ext4_find_extent(inode, next, NULL, gb_flags);
-		if (IS_ERR(npath))
-			return PTR_ERR(npath);
+		if (IS_ERR(npath)) {
+			err = PTR_ERR(npath);
+			goto errout;
+		}
 		BUG_ON(npath->p_depth != path->p_depth);
 		eh = npath[depth].p_hdr;
 		if (le16_to_cpu(eh->eh_entries) < le16_to_cpu(eh->eh_max)) {
 			ext_debug(inode, "next leaf isn't full(%d)\n",
 				  le16_to_cpu(eh->eh_entries));
+			ext4_free_ext_path(path);
 			path = npath;
 			goto has_space;
 		}
 		ext_debug(inode, "next leaf has no free space(%d,%d)\n",
 			  le16_to_cpu(eh->eh_entries), le16_to_cpu(eh->eh_max));
+		ext4_free_ext_path(npath);
 	}
 
 	/*
@@ -2097,12 +2103,8 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 		mb_flags |= EXT4_MB_USE_RESERVED;
 	path = ext4_ext_create_new_leaf(handle, inode, mb_flags, gb_flags,
 					path, newext);
-	if (IS_ERR(path)) {
-		*ppath = NULL;
-		err = PTR_ERR(path);
-		goto cleanup;
-	}
-	*ppath = path;
+	if (IS_ERR(path))
+		return path;
 	depth = ext_depth(inode);
 	eh = path[depth].p_hdr;
 
@@ -2111,7 +2113,7 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 
 	err = ext4_ext_get_access(handle, inode, path + depth);
 	if (err)
-		goto cleanup;
+		goto errout;
 
 	if (!nearex) {
 		/* there is no extent in this leaf, create first one */
@@ -2169,17 +2171,20 @@ int ext4_ext_insert_extent(handle_t *handle, struct inode *inode,
 	if (!(gb_flags & EXT4_GET_BLOCKS_PRE_IO))
 		ext4_ext_try_to_merge(handle, inode, path, nearex);
 
-
 	/* time to correct all indexes above */
 	err = ext4_ext_correct_indexes(handle, inode, path);
 	if (err)
-		goto cleanup;
+		goto errout;
 
 	err = ext4_ext_dirty(handle, inode, path + path->p_depth);
+	if (err)
+		goto errout;
 
-cleanup:
-	ext4_free_ext_path(npath);
-	return err;
+	return path;
+
+errout:
+	ext4_free_ext_path(path);
+	return ERR_PTR(err);
 }
 
 static int ext4_fill_es_cache_info(struct inode *inode,
@@ -3229,24 +3234,29 @@ static int ext4_split_extent_at(handle_t *handle,
 	if (split_flag & EXT4_EXT_MARK_UNWRIT2)
 		ext4_ext_mark_unwritten(ex2);
 
-	err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
-	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
+	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
+	if (!IS_ERR(path)) {
+		*ppath = path;
 		goto out;
+	}
+	*ppath = NULL;
+	err = PTR_ERR(path);
+	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
+		return err;
 
 	/*
-	 * Update path is required because previous ext4_ext_insert_extent()
-	 * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
-	 * guarantees that ext4_find_extent() will not return -ENOMEM,
-	 * otherwise -ENOMEM will cause a retry in do_writepages(), and a
-	 * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
-	 * an incorrect ee_len causing the i_reserved_data_blocks exception.
+	 * Get a new path to try to zeroout or fix the extent length.
+	 * Using EXT4_EX_NOFAIL guarantees that ext4_find_extent()
+	 * will not return -ENOMEM, otherwise -ENOMEM will cause a
+	 * retry in do_writepages(), and a WARN_ON may be triggered
+	 * in ext4_da_update_reserve_space() due to an incorrect
+	 * ee_len causing the i_reserved_data_blocks exception.
 	 */
-	path = ext4_find_extent(inode, ee_block, *ppath,
+	path = ext4_find_extent(inode, ee_block, NULL,
 				flags | EXT4_EX_NOFAIL);
 	if (IS_ERR(path)) {
 		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
 				 split, PTR_ERR(path));
-		*ppath = NULL;
 		return PTR_ERR(path);
 	}
 	depth = ext_depth(inode);
@@ -3305,7 +3315,7 @@ static int ext4_split_extent_at(handle_t *handle,
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
 	return err;
 out:
-	ext4_ext_show_leaf(inode, *ppath);
+	ext4_ext_show_leaf(inode, path);
 	return err;
 }
 
@@ -4293,6 +4303,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	    get_implied_cluster_alloc(inode->i_sb, map, &ex2, path)) {
 		ar.len = allocated = map->m_len;
 		newblock = map->m_pblk;
+		err = 0;
 		goto got_allocated_blocks;
 	}
 
@@ -4365,8 +4376,9 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 		map->m_flags |= EXT4_MAP_UNWRITTEN;
 	}
 
-	err = ext4_ext_insert_extent(handle, inode, &path, &newex, flags);
-	if (err) {
+	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
+	if (IS_ERR(path)) {
+		err = PTR_ERR(path);
 		if (allocated_clusters) {
 			int fb_flags = 0;
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 94f90032ca561..83a0a78a124a1 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1828,12 +1828,12 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 			if (ext4_ext_is_unwritten(ex))
 				ext4_ext_mark_unwritten(&newex);
 			down_write(&EXT4_I(inode)->i_data_sem);
-			ret = ext4_ext_insert_extent(
-				NULL, inode, &path, &newex, 0);
+			path = ext4_ext_insert_extent(NULL, inode,
+						      path, &newex, 0);
 			up_write((&EXT4_I(inode)->i_data_sem));
-			ext4_free_ext_path(path);
-			if (ret)
+			if (IS_ERR(path))
 				goto out;
+			ext4_free_ext_path(path);
 			goto next;
 		}
 
diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index 0be0467ae6dd2..7a0e429507cf3 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -37,7 +37,6 @@ static int finish_range(handle_t *handle, struct inode *inode,
 	path = ext4_find_extent(inode, lb->first_block, NULL, 0);
 	if (IS_ERR(path)) {
 		retval = PTR_ERR(path);
-		path = NULL;
 		goto err_out;
 	}
 
@@ -53,7 +52,9 @@ static int finish_range(handle_t *handle, struct inode *inode,
 	retval = ext4_datasem_ensure_credits(handle, inode, needed, needed, 0);
 	if (retval < 0)
 		goto err_out;
-	retval = ext4_ext_insert_extent(handle, inode, &path, &newext, 0);
+	path = ext4_ext_insert_extent(handle, inode, path, &newext, 0);
+	if (IS_ERR(path))
+		retval = PTR_ERR(path);
 err_out:
 	up_write((&EXT4_I(inode)->i_data_sem));
 	ext4_free_ext_path(path);
-- 
2.51.0



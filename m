Return-Path: <stable+bounces-219610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLaJJKX4nmm+YAQAu9opvQ
	(envelope-from <stable+bounces-219610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:27:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C32D198099
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 14:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5CB430E5040
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 13:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA253B8D48;
	Wed, 25 Feb 2026 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJYd7v5g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840CE3624AF
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 13:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025779; cv=none; b=kYxfKbj35nG+zFDnz2nZzdE3BdPe9GngSsdKsaIHmUiIMziwh/gBSRjwcE3xBJ+NHlZu+5gPv8fQGI2vrXhraRu3km6TdKhDd+8JtxpLe6qA36/5wkzNcbUgYILRRnIhioaziHQP3N0lhJsAwpwmqEEXj3kDpPmka3cVpbK5sF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025779; c=relaxed/simple;
	bh=uQOClNkXgfTqD0zGwkbrBxGWGu2/9h0tV9yWC1Cvdqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMpXPyACSWxTGhEEOGiE6YKIHmqEia0Szb61LNQO5lN8geVkMKWjV13tgEKPpotsf1NbEMYFj7/LO5CL9TCACHqKeenQ3FUqxGuQj+UtUscgqKYNZ6w0K1bUoMTvXO+J5GYIKiQCcJsBB2cCJRdS1tRleX2S0oK7flvGSvcrLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJYd7v5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2FBC19421;
	Wed, 25 Feb 2026 13:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772025779;
	bh=uQOClNkXgfTqD0zGwkbrBxGWGu2/9h0tV9yWC1Cvdqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJYd7v5gy0MgWvUZovglmTwhzTXggxzngdWCuGdQPMh3r0pspo7s1+gOMTRIAupzQ
	 vS4LSS2frMPKMz5HlUkbF1VgJTFENp8J6XyEnFoicdfobt7FHoQLVQimVHWc/NGQyx
	 1WueAzB5MGpD2JG+eVdHGn4KT4XMWXhKqCP5eYdw7NvvZp88e9XbbULagBkC0L8cE9
	 inI11xHy7uvVY5DBszl1UpLSjMU59aK85JwjKRSaOLL0H/W04MJS+1BLbWT8qI4BX4
	 iBlzmufYitLfBHZoWQzx9Xhe/KLQ3C0xrECYZTp/EocZC1r55X1Ll36o68N643Z2iJ
	 nGAGZN2tf443A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun1@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/6] ext4: get rid of ppath in ext4_split_extent_at()
Date: Wed, 25 Feb 2026 08:22:52 -0500
Message-ID: <20260225132253.222588-5-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-219610-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 0C32D198099
X-Rspamd-Action: no action

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 1de82b1b60d4613753254bf3cbf622a4c02c945c ]

The use of path and ppath is now very confusing, so to make the code more
readable, pass path between functions uniformly, and get rid of ppath.

To get rid of the ppath in ext4_split_extent_at(), the following is done
here:

 * Free the extents path when an error is encountered.
 * Its caller needs to update ppath if it uses ppath.
 * Teach ext4_ext_show_leaf() to skip error pointer.

No functional changes.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20240822023545.1994557-16-libaokun@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 79b592e8f1b4 ("ext4: drop extent cache when splitting extent fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 85 ++++++++++++++++++++++++++---------------------
 1 file changed, 47 insertions(+), 38 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 8a5c1e1207ba7..476fa4bc351a0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -84,12 +84,11 @@ static void ext4_extent_block_csum_set(struct inode *inode,
 	et->et_checksum = ext4_extent_block_csum(inode, eh);
 }
 
-static int ext4_split_extent_at(handle_t *handle,
-			     struct inode *inode,
-			     struct ext4_ext_path **ppath,
-			     ext4_lblk_t split,
-			     int split_flag,
-			     int flags);
+static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
+						  struct inode *inode,
+						  struct ext4_ext_path *path,
+						  ext4_lblk_t split,
+						  int split_flag, int flags);
 
 static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
 {
@@ -335,9 +334,15 @@ ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
 	if (nofail)
 		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
 
-	return ext4_split_extent_at(handle, inode, ppath, lblk, unwritten ?
+	path = ext4_split_extent_at(handle, inode, path, lblk, unwritten ?
 			EXT4_EXT_MARK_UNWRIT1|EXT4_EXT_MARK_UNWRIT2 : 0,
 			flags);
+	if (IS_ERR(path)) {
+		*ppath = NULL;
+		return PTR_ERR(path);
+	}
+	*ppath = path;
+	return 0;
 }
 
 static int
@@ -689,7 +694,7 @@ static void ext4_ext_show_leaf(struct inode *inode, struct ext4_ext_path *path)
 	struct ext4_extent *ex;
 	int i;
 
-	if (!path)
+	if (IS_ERR_OR_NULL(path))
 		return;
 
 	eh = path[depth].p_hdr;
@@ -3155,16 +3160,14 @@ static int ext4_ext_zeroout(struct inode *inode, struct ext4_extent *ex)
  *  a> the extent are splitted into two extent.
  *  b> split is not needed, and just mark the extent.
  *
- * return 0 on success.
+ * Return an extent path pointer on success, or an error pointer on failure.
  */
-static int ext4_split_extent_at(handle_t *handle,
-			     struct inode *inode,
-			     struct ext4_ext_path **ppath,
-			     ext4_lblk_t split,
-			     int split_flag,
-			     int flags)
+static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
+						  struct inode *inode,
+						  struct ext4_ext_path *path,
+						  ext4_lblk_t split,
+						  int split_flag, int flags)
 {
-	struct ext4_ext_path *path = *ppath;
 	ext4_fsblk_t newblock;
 	ext4_lblk_t ee_block;
 	struct ext4_extent *ex, newex, orig_ex, zero_ex;
@@ -3235,14 +3238,12 @@ static int ext4_split_extent_at(handle_t *handle,
 		ext4_ext_mark_unwritten(ex2);
 
 	path = ext4_ext_insert_extent(handle, inode, path, &newex, flags);
-	if (!IS_ERR(path)) {
-		*ppath = path;
+	if (!IS_ERR(path))
 		goto out;
-	}
-	*ppath = NULL;
+
 	err = PTR_ERR(path);
 	if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
-		return err;
+		return path;
 
 	/*
 	 * Get a new path to try to zeroout or fix the extent length.
@@ -3252,16 +3253,14 @@ static int ext4_split_extent_at(handle_t *handle,
 	 * in ext4_da_update_reserve_space() due to an incorrect
 	 * ee_len causing the i_reserved_data_blocks exception.
 	 */
-	path = ext4_find_extent(inode, ee_block, NULL,
-				flags | EXT4_EX_NOFAIL);
+	path = ext4_find_extent(inode, ee_block, NULL, flags | EXT4_EX_NOFAIL);
 	if (IS_ERR(path)) {
 		EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
 				 split, PTR_ERR(path));
-		return PTR_ERR(path);
+		return path;
 	}
 	depth = ext_depth(inode);
 	ex = path[depth].p_ext;
-	*ppath = path;
 
 	if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
 		if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
@@ -3313,10 +3312,13 @@ static int ext4_split_extent_at(handle_t *handle,
 	 * and err is a non-zero error code.
 	 */
 	ext4_ext_dirty(handle, inode, path + path->p_depth);
-	return err;
 out:
+	if (err) {
+		ext4_free_ext_path(path);
+		path = ERR_PTR(err);
+	}
 	ext4_ext_show_leaf(inode, path);
-	return err;
+	return path;
 }
 
 /*
@@ -3360,10 +3362,14 @@ static int ext4_split_extent(handle_t *handle,
 				       EXT4_EXT_MARK_UNWRIT2;
 		if (split_flag & EXT4_EXT_DATA_VALID2)
 			split_flag1 |= EXT4_EXT_DATA_VALID1;
-		err = ext4_split_extent_at(handle, inode, ppath,
+		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk + map->m_len, split_flag1, flags1);
-		if (err)
+		if (IS_ERR(path)) {
+			err = PTR_ERR(path);
+			*ppath = NULL;
 			goto out;
+		}
+		*ppath = path;
 	} else {
 		allocated = ee_len - (map->m_lblk - ee_block);
 	}
@@ -3371,7 +3377,7 @@ static int ext4_split_extent(handle_t *handle,
 	 * Update path is required because previous ext4_split_extent_at() may
 	 * result in split of original leaf or extent zeroout.
 	 */
-	path = ext4_find_extent(inode, map->m_lblk, *ppath, flags);
+	path = ext4_find_extent(inode, map->m_lblk, path, flags);
 	if (IS_ERR(path)) {
 		*ppath = NULL;
 		return PTR_ERR(path);
@@ -3393,13 +3399,17 @@ static int ext4_split_extent(handle_t *handle,
 			split_flag1 |= split_flag & (EXT4_EXT_MAY_ZEROOUT |
 						     EXT4_EXT_MARK_UNWRIT2);
 		}
-		err = ext4_split_extent_at(handle, inode, ppath,
+		path = ext4_split_extent_at(handle, inode, path,
 				map->m_lblk, split_flag1, flags);
-		if (err)
+		if (IS_ERR(path)) {
+			err = PTR_ERR(path);
+			*ppath = NULL;
 			goto out;
+		}
+		*ppath = path;
 	}
 
-	ext4_ext_show_leaf(inode, *ppath);
+	ext4_ext_show_leaf(inode, path);
 out:
 	return err ? err : allocated;
 }
@@ -5594,22 +5604,21 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 			if (ext4_ext_is_unwritten(extent))
 				split_flag = EXT4_EXT_MARK_UNWRIT1 |
 					EXT4_EXT_MARK_UNWRIT2;
-			ret = ext4_split_extent_at(handle, inode, &path,
+			path = ext4_split_extent_at(handle, inode, path,
 					offset_lblk, split_flag,
 					EXT4_EX_NOCACHE |
 					EXT4_GET_BLOCKS_PRE_IO |
 					EXT4_GET_BLOCKS_METADATA_NOFAIL);
 		}
 
-		ext4_free_ext_path(path);
-		if (ret < 0) {
+		if (IS_ERR(path)) {
 			up_write(&EXT4_I(inode)->i_data_sem);
+			ret = PTR_ERR(path);
 			goto out_stop;
 		}
-	} else {
-		ext4_free_ext_path(path);
 	}
 
+	ext4_free_ext_path(path);
 	ext4_es_remove_extent(inode, offset_lblk, EXT_MAX_BLOCKS - offset_lblk);
 
 	/*
-- 
2.51.0



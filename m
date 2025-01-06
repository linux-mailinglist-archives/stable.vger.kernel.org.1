Return-Path: <stable+bounces-107006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE758A029CC
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3F83A669E
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AEC15854A;
	Mon,  6 Jan 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lw03yq2b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45214900B;
	Mon,  6 Jan 2025 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177169; cv=none; b=X2kt+PaiR2dOLJ9dmbcYyzlTNc76Lb4NL9T9W1Vrpx5I/q4xd1kfLQETPUWZ8bpVd6MVZUfwxT2wQL1UDrH0O/L4/7ttrVgPMX1opF+DwVQWKMyMRQu6+ocoXsQ/vMcFzyktn9jyLkwzgYBldGj1ZESOK/aAvPDJ4GVH28LxZgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177169; c=relaxed/simple;
	bh=sGTfLAdONMXLBSf6ftzd2pcubJimg3bEJ36rjhZ8LwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=amj1fn4TFp0uYlcwTLsXKgkwWyKE1EX2/9bFX+PVvwbRBvOtMq8EzCSX6Fk2qRmvx5b0bkJgFLWElbht8vOhsFNz/CHsJ3CELUXdg+wdJ1il6VijG9TI7LWgHf67pxH0BeHWLtZYegS56N8x+zZuwJv7TKiqnRYKXWdt09/eNfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lw03yq2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7875C4CED2;
	Mon,  6 Jan 2025 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736177169;
	bh=sGTfLAdONMXLBSf6ftzd2pcubJimg3bEJ36rjhZ8LwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lw03yq2bSEcAejTpB2OUPiy0dIBJT/29gUGVFpLk0uO9Qhzt9qblAWbK3Z7wdwgTV
	 6WONtNY2pV8w7LnPN+VN1wLzJXyWb57oiw4M+t7hYbXKEJt428AoyTs4C2izWGV6OU
	 HZRLq0roCIT+A17SKNqmvQqS7s+BvaeWprbEMQCw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+1c25748a40fe79b8a119@syzkaller.appspotmail.com,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 057/222] fs/ntfs3: Fix warning in ni_fiemap
Date: Mon,  6 Jan 2025 16:14:21 +0100
Message-ID: <20250106151152.766154473@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit e2705dd3d16d1000f1fd8193d82447065de8c899 ]

Use local runs_tree instead of cached. This way excludes rw_semaphore lock.

Reported-by: syzbot+1c25748a40fe79b8a119@syzkaller.appspotmail.com
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c  |   9 ++--
 fs/ntfs3/frecord.c | 103 +++++++--------------------------------------
 fs/ntfs3/ntfs_fs.h |   3 +-
 3 files changed, 21 insertions(+), 94 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 582628b9b796..e25989dd2c6b 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -978,7 +978,7 @@ int attr_data_get_block(struct ntfs_inode *ni, CLST vcn, CLST clen, CLST *lcn,
 
 	/* Check for compressed frame. */
 	err = attr_is_frame_compressed(ni, attr_b, vcn >> NTFS_LZNT_CUNIT,
-				       &hint);
+				       &hint, run);
 	if (err)
 		goto out;
 
@@ -1534,16 +1534,16 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
  * attr_is_frame_compressed - Used to detect compressed frame.
  *
  * attr - base (primary) attribute segment.
+ * run  - run to use, usually == &ni->file.run.
  * Only base segments contains valid 'attr->nres.c_unit'
  */
 int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
-			     CLST frame, CLST *clst_data)
+			     CLST frame, CLST *clst_data, struct runs_tree *run)
 {
 	int err;
 	u32 clst_frame;
 	CLST clen, lcn, vcn, alen, slen, vcn_next;
 	size_t idx;
-	struct runs_tree *run;
 
 	*clst_data = 0;
 
@@ -1555,7 +1555,6 @@ int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
 
 	clst_frame = 1u << attr->nres.c_unit;
 	vcn = frame * clst_frame;
-	run = &ni->file.run;
 
 	if (!run_lookup_entry(run, vcn, &lcn, &clen, &idx)) {
 		err = attr_load_runs_vcn(ni, attr->type, attr_name(attr),
@@ -1691,7 +1690,7 @@ int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 	if (err)
 		goto out;
 
-	err = attr_is_frame_compressed(ni, attr_b, frame, &clst_data);
+	err = attr_is_frame_compressed(ni, attr_b, frame, &clst_data, run);
 	if (err)
 		goto out;
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 12e03feb3074..3c876c468c2c 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -1900,46 +1900,6 @@ enum REPARSE_SIGN ni_parse_reparse(struct ntfs_inode *ni, struct ATTRIB *attr,
 	return REPARSE_LINK;
 }
 
-/*
- * fiemap_fill_next_extent_k - a copy of fiemap_fill_next_extent
- * but it uses 'fe_k' instead of fieinfo->fi_extents_start
- */
-static int fiemap_fill_next_extent_k(struct fiemap_extent_info *fieinfo,
-				     struct fiemap_extent *fe_k, u64 logical,
-				     u64 phys, u64 len, u32 flags)
-{
-	struct fiemap_extent extent;
-
-	/* only count the extents */
-	if (fieinfo->fi_extents_max == 0) {
-		fieinfo->fi_extents_mapped++;
-		return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
-	}
-
-	if (fieinfo->fi_extents_mapped >= fieinfo->fi_extents_max)
-		return 1;
-
-	if (flags & FIEMAP_EXTENT_DELALLOC)
-		flags |= FIEMAP_EXTENT_UNKNOWN;
-	if (flags & FIEMAP_EXTENT_DATA_ENCRYPTED)
-		flags |= FIEMAP_EXTENT_ENCODED;
-	if (flags & (FIEMAP_EXTENT_DATA_TAIL | FIEMAP_EXTENT_DATA_INLINE))
-		flags |= FIEMAP_EXTENT_NOT_ALIGNED;
-
-	memset(&extent, 0, sizeof(extent));
-	extent.fe_logical = logical;
-	extent.fe_physical = phys;
-	extent.fe_length = len;
-	extent.fe_flags = flags;
-
-	memcpy(fe_k + fieinfo->fi_extents_mapped, &extent, sizeof(extent));
-
-	fieinfo->fi_extents_mapped++;
-	if (fieinfo->fi_extents_mapped == fieinfo->fi_extents_max)
-		return 1;
-	return (flags & FIEMAP_EXTENT_LAST) ? 1 : 0;
-}
-
 /*
  * ni_fiemap - Helper for file_fiemap().
  *
@@ -1950,11 +1910,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	      __u64 vbo, __u64 len)
 {
 	int err = 0;
-	struct fiemap_extent *fe_k = NULL;
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	u8 cluster_bits = sbi->cluster_bits;
-	struct runs_tree *run;
-	struct rw_semaphore *run_lock;
+	struct runs_tree run;
 	struct ATTRIB *attr;
 	CLST vcn = vbo >> cluster_bits;
 	CLST lcn, clen;
@@ -1965,13 +1923,11 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 	u32 flags;
 	bool ok;
 
+	run_init(&run);
 	if (S_ISDIR(ni->vfs_inode.i_mode)) {
-		run = &ni->dir.alloc_run;
 		attr = ni_find_attr(ni, NULL, NULL, ATTR_ALLOC, I30_NAME,
 				    ARRAY_SIZE(I30_NAME), NULL, NULL);
-		run_lock = &ni->dir.run_lock;
 	} else {
-		run = &ni->file.run;
 		attr = ni_find_attr(ni, NULL, NULL, ATTR_DATA, NULL, 0, NULL,
 				    NULL);
 		if (!attr) {
@@ -1986,7 +1942,6 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 				"fiemap is not supported for compressed file (cp -r)");
 			goto out;
 		}
-		run_lock = &ni->file.run_lock;
 	}
 
 	if (!attr || !attr->non_res) {
@@ -1998,51 +1953,33 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		goto out;
 	}
 
-	/*
-	 * To avoid lock problems replace pointer to user memory by pointer to kernel memory.
-	 */
-	fe_k = kmalloc_array(fieinfo->fi_extents_max,
-			     sizeof(struct fiemap_extent),
-			     GFP_NOFS | __GFP_ZERO);
-	if (!fe_k) {
-		err = -ENOMEM;
-		goto out;
-	}
-
 	end = vbo + len;
 	alloc_size = le64_to_cpu(attr->nres.alloc_size);
 	if (end > alloc_size)
 		end = alloc_size;
 
-	down_read(run_lock);
 
 	while (vbo < end) {
 		if (idx == -1) {
-			ok = run_lookup_entry(run, vcn, &lcn, &clen, &idx);
+			ok = run_lookup_entry(&run, vcn, &lcn, &clen, &idx);
 		} else {
 			CLST vcn_next = vcn;
 
-			ok = run_get_entry(run, ++idx, &vcn, &lcn, &clen) &&
+			ok = run_get_entry(&run, ++idx, &vcn, &lcn, &clen) &&
 			     vcn == vcn_next;
 			if (!ok)
 				vcn = vcn_next;
 		}
 
 		if (!ok) {
-			up_read(run_lock);
-			down_write(run_lock);
-
 			err = attr_load_runs_vcn(ni, attr->type,
 						 attr_name(attr),
-						 attr->name_len, run, vcn);
-
-			up_write(run_lock);
-			down_read(run_lock);
+						 attr->name_len, &run, vcn);
 
 			if (err)
 				break;
 
-			ok = run_lookup_entry(run, vcn, &lcn, &clen, &idx);
+			ok = run_lookup_entry(&run, vcn, &lcn, &clen, &idx);
 
 			if (!ok) {
 				err = -EINVAL;
@@ -2067,8 +2004,9 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		} else if (is_attr_compressed(attr)) {
 			CLST clst_data;
 
-			err = attr_is_frame_compressed(
-				ni, attr, vcn >> attr->nres.c_unit, &clst_data);
+			err = attr_is_frame_compressed(ni, attr,
+						       vcn >> attr->nres.c_unit,
+						       &clst_data, &run);
 			if (err)
 				break;
 			if (clst_data < NTFS_LZNT_CLUSTERS)
@@ -2097,8 +2035,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 			if (vbo + dlen >= end)
 				flags |= FIEMAP_EXTENT_LAST;
 
-			err = fiemap_fill_next_extent_k(fieinfo, fe_k, vbo, lbo,
-							dlen, flags);
+			err = fiemap_fill_next_extent(fieinfo, vbo, lbo, dlen,
+						      flags);
 
 			if (err < 0)
 				break;
@@ -2119,8 +2057,7 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		if (vbo + bytes >= end)
 			flags |= FIEMAP_EXTENT_LAST;
 
-		err = fiemap_fill_next_extent_k(fieinfo, fe_k, vbo, lbo, bytes,
-						flags);
+		err = fiemap_fill_next_extent(fieinfo, vbo, lbo, bytes, flags);
 		if (err < 0)
 			break;
 		if (err == 1) {
@@ -2131,19 +2068,8 @@ int ni_fiemap(struct ntfs_inode *ni, struct fiemap_extent_info *fieinfo,
 		vbo += bytes;
 	}
 
-	up_read(run_lock);
-
-	/*
-	 * Copy to user memory out of lock
-	 */
-	if (copy_to_user(fieinfo->fi_extents_start, fe_k,
-			 fieinfo->fi_extents_max *
-				 sizeof(struct fiemap_extent))) {
-		err = -EFAULT;
-	}
-
 out:
-	kfree(fe_k);
+	run_close(&run);
 	return err;
 }
 
@@ -2674,7 +2600,8 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 		down_write(&ni->file.run_lock);
 		run_truncate_around(run, le64_to_cpu(attr->nres.svcn));
 		frame = frame_vbo >> (cluster_bits + NTFS_LZNT_CUNIT);
-		err = attr_is_frame_compressed(ni, attr, frame, &clst_data);
+		err = attr_is_frame_compressed(ni, attr, frame, &clst_data,
+					       run);
 		up_write(&ni->file.run_lock);
 		if (err)
 			goto out1;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index cfe9d3bf07f9..c98e6868bfba 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -446,7 +446,8 @@ int attr_wof_frame_info(struct ntfs_inode *ni, struct ATTRIB *attr,
 			struct runs_tree *run, u64 frame, u64 frames,
 			u8 frame_bits, u32 *ondisk_size, u64 *vbo_data);
 int attr_is_frame_compressed(struct ntfs_inode *ni, struct ATTRIB *attr,
-			     CLST frame, CLST *clst_data);
+			     CLST frame, CLST *clst_data,
+			     struct runs_tree *run);
 int attr_allocate_frame(struct ntfs_inode *ni, CLST frame, size_t compr_size,
 			u64 new_valid);
 int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes);
-- 
2.39.5





Return-Path: <stable+bounces-24000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A637A86923C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40659B22EC1
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE83C13DB83;
	Tue, 27 Feb 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pJG/pSZ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE8C13AA4F;
	Tue, 27 Feb 2024 13:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709040747; cv=none; b=BqME0cV7CyonKExNGDfUEjvKpJ+DEDpabf9WEdRprv6ca/qFi8NY6bxMWF3NYnblovzACF4p5lckQLHdImRFtqwSTBpD65ns9f2IJczkUckRJTQ7RaVcW1y+3zcjpolmrLNGUhc4nroajUb1z1VbXvcnoS2C8qY9kf+MpZbUP4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709040747; c=relaxed/simple;
	bh=fRtJ17tmlGbOdTDCHr+yWWiP9ToZFzYwo86WdX1zWGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q839W4tO2Dpb2+G7h3dGteyWxUGiOU18q+/FNCdKSOMMr7HbUj31tbb8U17ZC+xSH33UEuqiDTNU5zarAJA/luFBJ4q3iT0f2wGMy0Skv9mE8Cingdg3IWMBbK5MkBIUm3o58eeSX8pV6IZWhIvZDyPW0Rz+4vNKrwIliEJ8Aas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pJG/pSZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE29C433F1;
	Tue, 27 Feb 2024 13:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709040747;
	bh=fRtJ17tmlGbOdTDCHr+yWWiP9ToZFzYwo86WdX1zWGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pJG/pSZ+DR1u+UE89IHkS2HJpBEbsI9/qC721wc+dciVHvHJu1guOAE/sHU5o5suz
	 IyAECQCQGZmhz9h9cnt5P6uHwBb3Jtbex63YY2cSFVUVQJ8Fl4a0H06wpVqXCakVJD
	 wsa2cKPYpinVt8N9LByyDG//BsYDHFGw4w3RFPuA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 096/334] fs/ntfs3: Use i_size_read and i_size_write
Date: Tue, 27 Feb 2024 14:19:14 +0100
Message-ID: <20240227131633.604520803@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 4fd6c08a16d7f1ba10212c9ef7bc73218144b463 ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/attrib.c  |  4 ++--
 fs/ntfs3/dir.c     |  2 +-
 fs/ntfs3/file.c    | 11 ++++++-----
 fs/ntfs3/frecord.c | 10 +++++-----
 fs/ntfs3/index.c   |  8 ++++----
 fs/ntfs3/inode.c   |  2 +-
 6 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 646e2dad1b757..7aadf50109994 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -2084,7 +2084,7 @@ int attr_collapse_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 
 	/* Update inode size. */
 	ni->i_valid = valid_size;
-	ni->vfs_inode.i_size = data_size;
+	i_size_write(&ni->vfs_inode, data_size);
 	inode_set_bytes(&ni->vfs_inode, total_size);
 	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
 	mark_inode_dirty(&ni->vfs_inode);
@@ -2499,7 +2499,7 @@ int attr_insert_range(struct ntfs_inode *ni, u64 vbo, u64 bytes)
 	mi_b->dirty = true;
 
 done:
-	ni->vfs_inode.i_size += bytes;
+	i_size_write(&ni->vfs_inode, ni->vfs_inode.i_size + bytes);
 	ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
 	mark_inode_dirty(&ni->vfs_inode);
 
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 9f6dd445eb04d..effa6accf8a85 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -517,7 +517,7 @@ static int ntfs_dir_count(struct inode *dir, bool *is_empty, size_t *dirs,
 	u32 e_size, off, end;
 	size_t drs = 0, fles = 0, bit = 0;
 	struct indx_node *node = NULL;
-	size_t max_indx = ni->vfs_inode.i_size >> ni->dir.index_bits;
+	size_t max_indx = i_size_read(&ni->vfs_inode) >> ni->dir.index_bits;
 
 	if (is_empty)
 		*is_empty = true;
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 07ed3d946e7c5..b702543a87953 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -646,7 +646,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 			if (err)
 				goto out;
 		} else if (new_size > i_size) {
-			inode->i_size = new_size;
+			i_size_write(inode, new_size);
 		}
 	}
 
@@ -696,7 +696,7 @@ int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out;
 		}
 		inode_dio_wait(inode);
-		oldsize = inode->i_size;
+		oldsize = i_size_read(inode);
 		newsize = attr->ia_size;
 
 		if (newsize <= oldsize)
@@ -708,7 +708,7 @@ int ntfs3_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out;
 
 		ni->ni_flags |= NI_FLAG_UPDATE_PARENT;
-		inode->i_size = newsize;
+		i_size_write(inode, newsize);
 	}
 
 	setattr_copy(idmap, inode, attr);
@@ -847,7 +847,7 @@ static ssize_t ntfs_compress_write(struct kiocb *iocb, struct iov_iter *from)
 	size_t count = iov_iter_count(from);
 	loff_t pos = iocb->ki_pos;
 	struct inode *inode = file_inode(file);
-	loff_t i_size = inode->i_size;
+	loff_t i_size = i_size_read(inode);
 	struct address_space *mapping = inode->i_mapping;
 	struct ntfs_inode *ni = ntfs_i(inode);
 	u64 valid = ni->i_valid;
@@ -1177,7 +1177,8 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 		down_write(&ni->file.run_lock);
 
 		err = attr_set_size(ni, ATTR_DATA, NULL, 0, &ni->file.run,
-				    inode->i_size, &ni->i_valid, false, NULL);
+				    i_size_read(inode), &ni->i_valid, false,
+				    NULL);
 
 		up_write(&ni->file.run_lock);
 		ni_unlock(ni);
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 2636ab7640ace..3b42938a9d3b2 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -2099,7 +2099,7 @@ int ni_readpage_cmpr(struct ntfs_inode *ni, struct page *page)
 	gfp_t gfp_mask;
 	struct page *pg;
 
-	if (vbo >= ni->vfs_inode.i_size) {
+	if (vbo >= i_size_read(&ni->vfs_inode)) {
 		SetPageUptodate(page);
 		err = 0;
 		goto out;
@@ -2173,7 +2173,7 @@ int ni_decompress_file(struct ntfs_inode *ni)
 {
 	struct ntfs_sb_info *sbi = ni->mi.sbi;
 	struct inode *inode = &ni->vfs_inode;
-	loff_t i_size = inode->i_size;
+	loff_t i_size = i_size_read(inode);
 	struct address_space *mapping = inode->i_mapping;
 	gfp_t gfp_mask = mapping_gfp_mask(mapping);
 	struct page **pages = NULL;
@@ -2457,6 +2457,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 	struct ATTR_LIST_ENTRY *le = NULL;
 	struct runs_tree *run = &ni->file.run;
 	u64 valid_size = ni->i_valid;
+	loff_t i_size = i_size_read(&ni->vfs_inode);
 	u64 vbo_disk;
 	size_t unc_size;
 	u32 frame_size, i, npages_disk, ondisk_size;
@@ -2548,7 +2549,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 			}
 		}
 
-		frames = (ni->vfs_inode.i_size - 1) >> frame_bits;
+		frames = (i_size - 1) >> frame_bits;
 
 		err = attr_wof_frame_info(ni, attr, run, frame64, frames,
 					  frame_bits, &ondisk_size, &vbo_data);
@@ -2556,8 +2557,7 @@ int ni_read_frame(struct ntfs_inode *ni, u64 frame_vbo, struct page **pages,
 			goto out2;
 
 		if (frame64 == frames) {
-			unc_size = 1 + ((ni->vfs_inode.i_size - 1) &
-					(frame_size - 1));
+			unc_size = 1 + ((i_size - 1) & (frame_size - 1));
 			ondisk_size = attr_size(attr) - vbo_data;
 		} else {
 			unc_size = frame_size;
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index cf92b2433f7a7..daabaad63aaf6 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1462,7 +1462,7 @@ static int indx_create_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 		goto out2;
 
 	if (in->name == I30_NAME) {
-		ni->vfs_inode.i_size = data_size;
+		i_size_write(&ni->vfs_inode, data_size);
 		inode_set_bytes(&ni->vfs_inode, alloc_size);
 	}
 
@@ -1544,7 +1544,7 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 	}
 
 	if (in->name == I30_NAME)
-		ni->vfs_inode.i_size = data_size;
+		i_size_write(&ni->vfs_inode, data_size);
 
 	*vbn = bit << indx->idx2vbn_bits;
 
@@ -2090,7 +2090,7 @@ static int indx_shrink(struct ntfs_index *indx, struct ntfs_inode *ni,
 		return err;
 
 	if (in->name == I30_NAME)
-		ni->vfs_inode.i_size = new_data;
+		i_size_write(&ni->vfs_inode, new_data);
 
 	bpb = bitmap_size(bit);
 	if (bpb * 8 == nbits)
@@ -2576,7 +2576,7 @@ int indx_delete_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		err = attr_set_size(ni, ATTR_ALLOC, in->name, in->name_len,
 				    &indx->alloc_run, 0, NULL, false, NULL);
 		if (in->name == I30_NAME)
-			ni->vfs_inode.i_size = 0;
+			i_size_write(&ni->vfs_inode, 0);
 
 		err = ni_remove_attr(ni, ATTR_ALLOC, in->name, in->name_len,
 				     false, NULL);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 85452a6b1d40a..eb7a8c9fba018 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -985,7 +985,7 @@ int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 		}
 
 		if (pos + err > inode->i_size) {
-			inode->i_size = pos + err;
+			i_size_write(inode, pos + err);
 			dirty = true;
 		}
 
-- 
2.43.0





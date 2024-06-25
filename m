Return-Path: <stable+bounces-55584-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD5391644B
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 11:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FC61C2324C
	for <lists+stable@lfdr.de>; Tue, 25 Jun 2024 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D141814B96D;
	Tue, 25 Jun 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="REpmdd2J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1F714B945;
	Tue, 25 Jun 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309335; cv=none; b=BNIlJ4IXPEkNc7Xow6g1J+2JX5J5N6G1uhTzM8ctKEgEaPv31L3G9lEExMAV07yjdtLyyxAXSgN0JFEWwlTakyVvcFf/5Ui0hRQlBywHzhw2gydYoFQ583eYtCdmtvrWRkoor0yuYAKoN6z9Z+9D79OhxdrmUUGkNqqB93wy8WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309335; c=relaxed/simple;
	bh=a3ruU9sPKaG/GBnS+rdxQMyeeC6ktjulc5fvGJrSgsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ER7wf6YC2/SPMD6CE5vlKsV9VuQLfTPzPYPtWWWyEYn21qmnZ+NQGOGf36T0PP/UTIIzdF0riZbNwjYNviYGzL+b3TVjhT2DCvb7sLTJQ6NL6mtpVkQCofCX6faDqu3NZmFVHn0eStOkEh/+X4OwIRxPrha1SyRdwBVQuU+hcic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=REpmdd2J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1057EC32781;
	Tue, 25 Jun 2024 09:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719309335;
	bh=a3ruU9sPKaG/GBnS+rdxQMyeeC6ktjulc5fvGJrSgsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=REpmdd2JyANk9g1FjcsiyR2MUz55mdKb+CoTw7XUxpgvPjLixFe0lo4xhKD6n+Eqi
	 8gT5aroNqHs11zo+Eq/VhuFSwO4M48jWCIQazQg32XtNLrooNjg8bPrcqEjGGLT+VH
	 FSVFappn4yZX3aYK/lleidG6AlPgU111+mHDKjIc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 174/192] ocfs2: convert to new timestamp accessors
Date: Tue, 25 Jun 2024 11:34:06 +0200
Message-ID: <20240625085543.839128614@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625085537.150087723@linuxfoundation.org>
References: <20240625085537.150087723@linuxfoundation.org>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit fd6acbbc4d1edb218ade7ac0ab1839f9e4fcd094 ]

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/r/20231004185347.80880-54-jlayton@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 8c40984eeb88 ("ocfs2: update inode fsync transaction id in ocfs2_unlink and ocfs2_link")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/acl.c          |  4 ++--
 fs/ocfs2/alloc.c        |  6 +++---
 fs/ocfs2/aops.c         |  6 +++---
 fs/ocfs2/dir.c          |  9 +++++----
 fs/ocfs2/dlmfs/dlmfs.c  |  4 ++--
 fs/ocfs2/dlmglue.c      | 29 ++++++++++++++---------------
 fs/ocfs2/file.c         | 30 ++++++++++++++++--------------
 fs/ocfs2/inode.c        | 28 ++++++++++++++--------------
 fs/ocfs2/move_extents.c |  4 ++--
 fs/ocfs2/namei.c        | 16 ++++++++--------
 fs/ocfs2/refcounttree.c | 12 ++++++------
 fs/ocfs2/xattr.c        |  4 ++--
 12 files changed, 77 insertions(+), 75 deletions(-)

diff --git a/fs/ocfs2/acl.c b/fs/ocfs2/acl.c
index e75137a8e7cb4..62464d194da3f 100644
--- a/fs/ocfs2/acl.c
+++ b/fs/ocfs2/acl.c
@@ -193,8 +193,8 @@ static int ocfs2_acl_set_mode(struct inode *inode, struct buffer_head *di_bh,
 	inode->i_mode = new_mode;
 	inode_set_ctime_current(inode);
 	di->i_mode = cpu_to_le16(inode->i_mode);
-	di->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
-	di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
+	di->i_ctime = cpu_to_le64(inode_get_ctime_sec(inode));
+	di->i_ctime_nsec = cpu_to_le32(inode_get_ctime_nsec(inode));
 	ocfs2_update_inode_fsync_trans(handle, inode, 0);
 
 	ocfs2_journal_dirty(handle, di_bh);
diff --git a/fs/ocfs2/alloc.c b/fs/ocfs2/alloc.c
index aef58f1395c87..f0937902f7b46 100644
--- a/fs/ocfs2/alloc.c
+++ b/fs/ocfs2/alloc.c
@@ -7436,10 +7436,10 @@ int ocfs2_truncate_inline(struct inode *inode, struct buffer_head *di_bh,
 	}
 
 	inode->i_blocks = ocfs2_inode_sector_count(inode);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
-	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
-	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
+	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime_sec(inode));
+	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode_get_ctime_nsec(inode));
 
 	ocfs2_update_inode_fsync_trans(handle, inode, 1);
 	ocfs2_journal_dirty(handle, di_bh);
diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 0fdba30740ab5..6ab03494fc6e7 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -2048,9 +2048,9 @@ int ocfs2_write_end_nolock(struct address_space *mapping,
 		}
 		inode->i_blocks = ocfs2_inode_sector_count(inode);
 		di->i_size = cpu_to_le64((u64)i_size_read(inode));
-		inode->i_mtime = inode_set_ctime_current(inode);
-		di->i_mtime = di->i_ctime = cpu_to_le64(inode->i_mtime.tv_sec);
-		di->i_mtime_nsec = di->i_ctime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+		di->i_mtime = di->i_ctime = cpu_to_le64(inode_get_mtime_sec(inode));
+		di->i_mtime_nsec = di->i_ctime_nsec = cpu_to_le32(inode_get_mtime_nsec(inode));
 		if (handle)
 			ocfs2_update_inode_fsync_trans(handle, inode, 1);
 	}
diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
index 8b123d543e6e2..a14c8fee6ee5e 100644
--- a/fs/ocfs2/dir.c
+++ b/fs/ocfs2/dir.c
@@ -1658,7 +1658,8 @@ int __ocfs2_add_entry(handle_t *handle,
 				offset, ocfs2_dir_trailer_blk_off(dir->i_sb));
 
 		if (ocfs2_dirent_would_fit(de, rec_len)) {
-			dir->i_mtime = inode_set_ctime_current(dir);
+			inode_set_mtime_to_ts(dir,
+					      inode_set_ctime_current(dir));
 			retval = ocfs2_mark_inode_dirty(handle, dir, parent_fe_bh);
 			if (retval < 0) {
 				mlog_errno(retval);
@@ -2962,11 +2963,11 @@ static int ocfs2_expand_inline_dir(struct inode *dir, struct buffer_head *di_bh,
 	ocfs2_dinode_new_extent_list(dir, di);
 
 	i_size_write(dir, sb->s_blocksize);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 
 	di->i_size = cpu_to_le64(sb->s_blocksize);
-	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime(dir).tv_sec);
-	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode_get_ctime(dir).tv_nsec);
+	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime_sec(dir));
+	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode_get_ctime_nsec(dir));
 	ocfs2_update_inode_fsync_trans(handle, dir, 1);
 
 	/*
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 81265123ce6ce..9b57d012fd5cf 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -337,7 +337,7 @@ static struct inode *dlmfs_get_root_inode(struct super_block *sb)
 	if (inode) {
 		inode->i_ino = get_next_ino();
 		inode_init_owner(&nop_mnt_idmap, inode, NULL, mode);
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 		inc_nlink(inode);
 
 		inode->i_fop = &simple_dir_operations;
@@ -360,7 +360,7 @@ static struct inode *dlmfs_get_inode(struct inode *parent,
 
 	inode->i_ino = get_next_ino();
 	inode_init_owner(&nop_mnt_idmap, inode, parent, mode);
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 
 	ip = DLMFS_I(inode);
 	ip->ip_conn = DLMFS_I(parent)->ip_conn;
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index c3e2961ee5db3..64a6ef638495c 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -2162,7 +2162,7 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
 	struct ocfs2_meta_lvb *lvb;
-	struct timespec64 ctime = inode_get_ctime(inode);
+	struct timespec64 ts;
 
 	lvb = ocfs2_dlm_lvb(&lockres->l_lksb);
 
@@ -2183,12 +2183,12 @@ static void __ocfs2_stuff_meta_lvb(struct inode *inode)
 	lvb->lvb_igid      = cpu_to_be32(i_gid_read(inode));
 	lvb->lvb_imode     = cpu_to_be16(inode->i_mode);
 	lvb->lvb_inlink    = cpu_to_be16(inode->i_nlink);
-	lvb->lvb_iatime_packed  =
-		cpu_to_be64(ocfs2_pack_timespec(&inode->i_atime));
-	lvb->lvb_ictime_packed =
-		cpu_to_be64(ocfs2_pack_timespec(&ctime));
-	lvb->lvb_imtime_packed =
-		cpu_to_be64(ocfs2_pack_timespec(&inode->i_mtime));
+	ts = inode_get_atime(inode);
+	lvb->lvb_iatime_packed = cpu_to_be64(ocfs2_pack_timespec(&ts));
+	ts = inode_get_ctime(inode);
+	lvb->lvb_ictime_packed = cpu_to_be64(ocfs2_pack_timespec(&ts));
+	ts = inode_get_mtime(inode);
+	lvb->lvb_imtime_packed = cpu_to_be64(ocfs2_pack_timespec(&ts));
 	lvb->lvb_iattr    = cpu_to_be32(oi->ip_attr);
 	lvb->lvb_idynfeatures = cpu_to_be16(oi->ip_dyn_features);
 	lvb->lvb_igeneration = cpu_to_be32(inode->i_generation);
@@ -2209,7 +2209,7 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
 	struct ocfs2_inode_info *oi = OCFS2_I(inode);
 	struct ocfs2_lock_res *lockres = &oi->ip_inode_lockres;
 	struct ocfs2_meta_lvb *lvb;
-	struct timespec64 ctime;
+	struct timespec64 ts;
 
 	mlog_meta_lvb(0, lockres);
 
@@ -2236,13 +2236,12 @@ static int ocfs2_refresh_inode_from_lvb(struct inode *inode)
 	i_gid_write(inode, be32_to_cpu(lvb->lvb_igid));
 	inode->i_mode    = be16_to_cpu(lvb->lvb_imode);
 	set_nlink(inode, be16_to_cpu(lvb->lvb_inlink));
-	ocfs2_unpack_timespec(&inode->i_atime,
-			      be64_to_cpu(lvb->lvb_iatime_packed));
-	ocfs2_unpack_timespec(&inode->i_mtime,
-			      be64_to_cpu(lvb->lvb_imtime_packed));
-	ocfs2_unpack_timespec(&ctime,
-			      be64_to_cpu(lvb->lvb_ictime_packed));
-	inode_set_ctime_to_ts(inode, ctime);
+	ocfs2_unpack_timespec(&ts, be64_to_cpu(lvb->lvb_iatime_packed));
+	inode_set_atime_to_ts(inode, ts);
+	ocfs2_unpack_timespec(&ts, be64_to_cpu(lvb->lvb_imtime_packed));
+	inode_set_mtime_to_ts(inode, ts);
+	ocfs2_unpack_timespec(&ts, be64_to_cpu(lvb->lvb_ictime_packed));
+	inode_set_ctime_to_ts(inode, ts);
 	spin_unlock(&oi->ip_lock);
 	return 0;
 }
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index f861b8c345e86..8bbe4a2b48a2a 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -233,16 +233,18 @@ int ocfs2_should_update_atime(struct inode *inode,
 
 	if (vfsmnt->mnt_flags & MNT_RELATIME) {
 		struct timespec64 ctime = inode_get_ctime(inode);
+		struct timespec64 atime = inode_get_atime(inode);
+		struct timespec64 mtime = inode_get_mtime(inode);
 
-		if ((timespec64_compare(&inode->i_atime, &inode->i_mtime) <= 0) ||
-		    (timespec64_compare(&inode->i_atime, &ctime) <= 0))
+		if ((timespec64_compare(&atime, &mtime) <= 0) ||
+		    (timespec64_compare(&atime, &ctime) <= 0))
 			return 1;
 
 		return 0;
 	}
 
 	now = current_time(inode);
-	if ((now.tv_sec - inode->i_atime.tv_sec <= osb->s_atime_quantum))
+	if ((now.tv_sec - inode_get_atime_sec(inode) <= osb->s_atime_quantum))
 		return 0;
 	else
 		return 1;
@@ -275,9 +277,9 @@ int ocfs2_update_inode_atime(struct inode *inode,
 	 * have i_rwsem to guard against concurrent changes to other
 	 * inode fields.
 	 */
-	inode->i_atime = current_time(inode);
-	di->i_atime = cpu_to_le64(inode->i_atime.tv_sec);
-	di->i_atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
+	inode_set_atime_to_ts(inode, current_time(inode));
+	di->i_atime = cpu_to_le64(inode_get_atime_sec(inode));
+	di->i_atime_nsec = cpu_to_le32(inode_get_atime_nsec(inode));
 	ocfs2_update_inode_fsync_trans(handle, inode, 0);
 	ocfs2_journal_dirty(handle, bh);
 
@@ -296,7 +298,7 @@ int ocfs2_set_inode_size(handle_t *handle,
 
 	i_size_write(inode, new_i_size);
 	inode->i_blocks = ocfs2_inode_sector_count(inode);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 	status = ocfs2_mark_inode_dirty(handle, inode, fe_bh);
 	if (status < 0) {
@@ -417,12 +419,12 @@ static int ocfs2_orphan_for_truncate(struct ocfs2_super *osb,
 	}
 
 	i_size_write(inode, new_i_size);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 
 	di = (struct ocfs2_dinode *) fe_bh->b_data;
 	di->i_size = cpu_to_le64(new_i_size);
-	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
-	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
+	di->i_ctime = di->i_mtime = cpu_to_le64(inode_get_ctime_sec(inode));
+	di->i_ctime_nsec = di->i_mtime_nsec = cpu_to_le32(inode_get_ctime_nsec(inode));
 	ocfs2_update_inode_fsync_trans(handle, inode, 0);
 
 	ocfs2_journal_dirty(handle, fe_bh);
@@ -821,9 +823,9 @@ static int ocfs2_write_zero_page(struct inode *inode, u64 abs_from,
 	i_size_write(inode, abs_to);
 	inode->i_blocks = ocfs2_inode_sector_count(inode);
 	di->i_size = cpu_to_le64((u64)i_size_read(inode));
-	inode->i_mtime = inode_set_ctime_current(inode);
-	di->i_mtime = di->i_ctime = cpu_to_le64(inode->i_mtime.tv_sec);
-	di->i_ctime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
+	di->i_mtime = di->i_ctime = cpu_to_le64(inode_get_mtime_sec(inode));
+	di->i_ctime_nsec = cpu_to_le32(inode_get_mtime_nsec(inode));
 	di->i_mtime_nsec = di->i_ctime_nsec;
 	if (handle) {
 		ocfs2_journal_dirty(handle, di_bh);
@@ -2042,7 +2044,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 		goto out_inode_unlock;
 	}
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	ret = ocfs2_mark_inode_dirty(handle, inode, di_bh);
 	if (ret < 0)
 		mlog_errno(ret);
diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index e8771600b9304..999111bfc2717 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -302,10 +302,10 @@ void ocfs2_populate_inode(struct inode *inode, struct ocfs2_dinode *fe,
 		inode->i_blocks = ocfs2_inode_sector_count(inode);
 		inode->i_mapping->a_ops = &ocfs2_aops;
 	}
-	inode->i_atime.tv_sec = le64_to_cpu(fe->i_atime);
-	inode->i_atime.tv_nsec = le32_to_cpu(fe->i_atime_nsec);
-	inode->i_mtime.tv_sec = le64_to_cpu(fe->i_mtime);
-	inode->i_mtime.tv_nsec = le32_to_cpu(fe->i_mtime_nsec);
+	inode_set_atime(inode, le64_to_cpu(fe->i_atime),
+		        le32_to_cpu(fe->i_atime_nsec));
+	inode_set_mtime(inode, le64_to_cpu(fe->i_mtime),
+		        le32_to_cpu(fe->i_mtime_nsec));
 	inode_set_ctime(inode, le64_to_cpu(fe->i_ctime),
 		        le32_to_cpu(fe->i_ctime_nsec));
 
@@ -1312,12 +1312,12 @@ int ocfs2_mark_inode_dirty(handle_t *handle,
 	fe->i_uid = cpu_to_le32(i_uid_read(inode));
 	fe->i_gid = cpu_to_le32(i_gid_read(inode));
 	fe->i_mode = cpu_to_le16(inode->i_mode);
-	fe->i_atime = cpu_to_le64(inode->i_atime.tv_sec);
-	fe->i_atime_nsec = cpu_to_le32(inode->i_atime.tv_nsec);
-	fe->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
-	fe->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
-	fe->i_mtime = cpu_to_le64(inode->i_mtime.tv_sec);
-	fe->i_mtime_nsec = cpu_to_le32(inode->i_mtime.tv_nsec);
+	fe->i_atime = cpu_to_le64(inode_get_atime_sec(inode));
+	fe->i_atime_nsec = cpu_to_le32(inode_get_atime_nsec(inode));
+	fe->i_ctime = cpu_to_le64(inode_get_ctime_sec(inode));
+	fe->i_ctime_nsec = cpu_to_le32(inode_get_ctime_nsec(inode));
+	fe->i_mtime = cpu_to_le64(inode_get_mtime_sec(inode));
+	fe->i_mtime_nsec = cpu_to_le32(inode_get_mtime_nsec(inode));
 
 	ocfs2_journal_dirty(handle, bh);
 	ocfs2_update_inode_fsync_trans(handle, inode, 1);
@@ -1348,10 +1348,10 @@ void ocfs2_refresh_inode(struct inode *inode,
 		inode->i_blocks = 0;
 	else
 		inode->i_blocks = ocfs2_inode_sector_count(inode);
-	inode->i_atime.tv_sec = le64_to_cpu(fe->i_atime);
-	inode->i_atime.tv_nsec = le32_to_cpu(fe->i_atime_nsec);
-	inode->i_mtime.tv_sec = le64_to_cpu(fe->i_mtime);
-	inode->i_mtime.tv_nsec = le32_to_cpu(fe->i_mtime_nsec);
+	inode_set_atime(inode, le64_to_cpu(fe->i_atime),
+			le32_to_cpu(fe->i_atime_nsec));
+	inode_set_mtime(inode, le64_to_cpu(fe->i_mtime),
+			le32_to_cpu(fe->i_mtime_nsec));
 	inode_set_ctime(inode, le64_to_cpu(fe->i_ctime),
 			le32_to_cpu(fe->i_ctime_nsec));
 
diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index 05d67968a3a9e..1f9ed117e78b6 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -951,8 +951,8 @@ static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
 
 	di = (struct ocfs2_dinode *)di_bh->b_data;
 	inode_set_ctime_current(inode);
-	di->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
-	di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
+	di->i_ctime = cpu_to_le64(inode_get_ctime_sec(inode));
+	di->i_ctime_nsec = cpu_to_le32(inode_get_ctime_nsec(inode));
 	ocfs2_update_inode_fsync_trans(handle, inode, 0);
 
 	ocfs2_journal_dirty(handle, di_bh);
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 8e648073bf712..791fc5050e46b 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -795,8 +795,8 @@ static int ocfs2_link(struct dentry *old_dentry,
 	inc_nlink(inode);
 	inode_set_ctime_current(inode);
 	ocfs2_set_links_count(fe, inode->i_nlink);
-	fe->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
-	fe->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
+	fe->i_ctime = cpu_to_le64(inode_get_ctime_sec(inode));
+	fe->i_ctime_nsec = cpu_to_le32(inode_get_ctime_nsec(inode));
 	ocfs2_journal_dirty(handle, fe_bh);
 
 	err = ocfs2_add_entry(handle, dentry, inode,
@@ -995,7 +995,7 @@ static int ocfs2_unlink(struct inode *dir,
 	ocfs2_set_links_count(fe, inode->i_nlink);
 	ocfs2_journal_dirty(handle, fe_bh);
 
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	if (S_ISDIR(inode->i_mode))
 		drop_nlink(dir);
 
@@ -1550,8 +1550,8 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 	if (status >= 0) {
 		old_di = (struct ocfs2_dinode *) old_inode_bh->b_data;
 
-		old_di->i_ctime = cpu_to_le64(inode_get_ctime(old_inode).tv_sec);
-		old_di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(old_inode).tv_nsec);
+		old_di->i_ctime = cpu_to_le64(inode_get_ctime_sec(old_inode));
+		old_di->i_ctime_nsec = cpu_to_le32(inode_get_ctime_nsec(old_inode));
 		ocfs2_journal_dirty(handle, old_inode_bh);
 	} else
 		mlog_errno(status);
@@ -1592,7 +1592,7 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 		drop_nlink(new_inode);
 		inode_set_ctime_current(new_inode);
 	}
-	old_dir->i_mtime = inode_set_ctime_current(old_dir);
+	inode_set_mtime_to_ts(old_dir, inode_set_ctime_current(old_dir));
 
 	if (update_dot_dot) {
 		status = ocfs2_update_entry(old_inode, handle,
@@ -1614,8 +1614,8 @@ static int ocfs2_rename(struct mnt_idmap *idmap,
 
 	if (old_dir != new_dir) {
 		/* Keep the same times on both directories.*/
-		new_dir->i_mtime = inode_set_ctime_to_ts(new_dir,
-							 inode_get_ctime(old_dir));
+		inode_set_mtime_to_ts(new_dir,
+				      inode_set_ctime_to_ts(new_dir, inode_get_ctime(old_dir)));
 
 		/*
 		 * This will also pick up the i_nlink change from the
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 25c8ec3c8c3a5..3f80a56d0d603 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -3751,8 +3751,8 @@ static int ocfs2_change_ctime(struct inode *inode,
 	}
 
 	inode_set_ctime_current(inode);
-	di->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
-	di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
+	di->i_ctime = cpu_to_le64(inode_get_ctime_sec(inode));
+	di->i_ctime_nsec = cpu_to_le32(inode_get_ctime_nsec(inode));
 
 	ocfs2_journal_dirty(handle, di_bh);
 
@@ -4075,10 +4075,10 @@ static int ocfs2_complete_reflink(struct inode *s_inode,
 		 */
 		inode_set_ctime_current(t_inode);
 
-		di->i_ctime = cpu_to_le64(inode_get_ctime(t_inode).tv_sec);
-		di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(t_inode).tv_nsec);
+		di->i_ctime = cpu_to_le64(inode_get_ctime_sec(t_inode));
+		di->i_ctime_nsec = cpu_to_le32(inode_get_ctime_nsec(t_inode));
 
-		t_inode->i_mtime = s_inode->i_mtime;
+		inode_set_mtime_to_ts(t_inode, inode_get_mtime(s_inode));
 		di->i_mtime = s_di->i_mtime;
 		di->i_mtime_nsec = s_di->i_mtime_nsec;
 	}
@@ -4456,7 +4456,7 @@ int ocfs2_reflink_update_dest(struct inode *dest,
 	if (newlen > i_size_read(dest))
 		i_size_write(dest, newlen);
 	spin_unlock(&OCFS2_I(dest)->ip_lock);
-	dest->i_mtime = inode_set_ctime_current(dest);
+	inode_set_mtime_to_ts(dest, inode_set_ctime_current(dest));
 
 	ret = ocfs2_mark_inode_dirty(handle, dest, d_bh);
 	if (ret) {
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 6510ad783c912..b562cfef888ad 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -3422,8 +3422,8 @@ static int __ocfs2_xattr_set_handle(struct inode *inode,
 		}
 
 		inode_set_ctime_current(inode);
-		di->i_ctime = cpu_to_le64(inode_get_ctime(inode).tv_sec);
-		di->i_ctime_nsec = cpu_to_le32(inode_get_ctime(inode).tv_nsec);
+		di->i_ctime = cpu_to_le64(inode_get_ctime_sec(inode));
+		di->i_ctime_nsec = cpu_to_le32(inode_get_ctime_nsec(inode));
 		ocfs2_journal_dirty(ctxt->handle, xis->inode_bh);
 	}
 out:
-- 
2.43.0





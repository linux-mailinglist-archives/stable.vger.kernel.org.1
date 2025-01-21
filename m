Return-Path: <stable+bounces-109591-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3B2A1799A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 09:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBAF43AB056
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B144D1BD9CE;
	Tue, 21 Jan 2025 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZcAvET8I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5C71B85D3;
	Tue, 21 Jan 2025 08:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449642; cv=none; b=ppikIJxH3VvLrrTCxSUxG1YW7xjiY/czQIVINQEmCfPFdS54lbPoduzZUb6/hBKEpEIjF9Cgy3vdWh2qB/cocez641UgnNgr4HcsE6usyE/w01GCh/yswznvw9GhWtNnwGYMnP5NG3OXvuDS7y2Bbc+fVs60D+hbTUnyPC9Oucs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449642; c=relaxed/simple;
	bh=BzwYRmI7w1m4UYZXFRMFMW8W7q+QM7ahmrzou0srxqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lMRaOujfD3jX2yQmD1yIpABxSKknsvkNEoRBvqNhgXzyQvNXG6JG1oFL/FF15pdsiQiUd0pi/joHg4MgreevFaPGyfFKLxuHXrCBz/wxAF/NeXnRYJsR2bPMe9pRkTCYX+cKgRHu2mC54hrbD8kEfOWEtl1B2uinkfqj/65gZ5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZcAvET8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79CBCC4CEDF;
	Tue, 21 Jan 2025 08:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737449641;
	bh=BzwYRmI7w1m4UYZXFRMFMW8W7q+QM7ahmrzou0srxqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZcAvET8IPcs+a8ErnDZjEOX+iSriUapjdToCXsOvjafNgL30zkxZF6oi84WAQAntJ
	 HPx30lkAF0tJPlM/2aW6GudWWdDBO7hloW6ibIJiFmKn1UZSP63n8RqLsD+gVGwD7b
	 Oqqv+nlLwTVk4Vg/r7ZtZ4jgO8iXUR+bA8nR3uis=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.73
Date: Tue, 21 Jan 2025 09:53:48 +0100
Message-ID: <2025012132-hardly-catching-d7cc@gregkh>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025012131-euphemism-jingle-8949@gregkh>
References: <2025012131-euphemism-jingle-8949@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index fb4949cac6ff..2ba627f54590 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 72
+SUBLEVEL = 73
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index f14c412c5609..ada3fcc9c6d5 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -371,13 +371,13 @@ int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upperdentry,
 	return err;
 }
 
-struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct inode *realinode,
+struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 				  bool is_upper)
 {
 	struct ovl_fh *fh;
 	int fh_type, dwords;
 	int buflen = MAX_HANDLE_SZ;
-	uuid_t *uuid = &realinode->i_sb->s_uuid;
+	uuid_t *uuid = &real->d_sb->s_uuid;
 	int err;
 
 	/* Make sure the real fid stays 32bit aligned */
@@ -394,8 +394,7 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct inode *realinode,
 	 * the price or reconnecting the dentry.
 	 */
 	dwords = buflen >> 2;
-	fh_type = exportfs_encode_inode_fh(realinode, (void *)fh->fb.fid,
-					   &dwords, NULL, 0);
+	fh_type = exportfs_encode_fh(real, (void *)fh->fb.fid, &dwords, 0);
 	buflen = (dwords << 2);
 
 	err = -EIO;
@@ -427,29 +426,29 @@ struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct inode *realinode,
 	return ERR_PTR(err);
 }
 
-struct ovl_fh *ovl_get_origin_fh(struct ovl_fs *ofs, struct dentry *origin)
+int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
+		   struct dentry *upper)
 {
+	const struct ovl_fh *fh = NULL;
+	int err;
+
 	/*
 	 * When lower layer doesn't support export operations store a 'null' fh,
 	 * so we can use the overlay.origin xattr to distignuish between a copy
 	 * up and a pure upper inode.
 	 */
-	if (!ovl_can_decode_fh(origin->d_sb))
-		return NULL;
-
-	return ovl_encode_real_fh(ofs, d_inode(origin), false);
-}
-
-int ovl_set_origin_fh(struct ovl_fs *ofs, const struct ovl_fh *fh,
-		      struct dentry *upper)
-{
-	int err;
+	if (ovl_can_decode_fh(lower->d_sb)) {
+		fh = ovl_encode_real_fh(ofs, lower, false);
+		if (IS_ERR(fh))
+			return PTR_ERR(fh);
+	}
 
 	/*
 	 * Do not fail when upper doesn't support xattrs.
 	 */
 	err = ovl_check_setxattr(ofs, upper, OVL_XATTR_ORIGIN, fh->buf,
 				 fh ? fh->fb.len : 0, 0);
+	kfree(fh);
 
 	/* Ignore -EPERM from setting "user.*" on symlink/special */
 	return err == -EPERM ? 0 : err;
@@ -462,7 +461,7 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
 	const struct ovl_fh *fh;
 	int err;
 
-	fh = ovl_encode_real_fh(ofs, d_inode(upper), true);
+	fh = ovl_encode_real_fh(ofs, upper, true);
 	if (IS_ERR(fh))
 		return PTR_ERR(fh);
 
@@ -477,7 +476,7 @@ static int ovl_set_upper_fh(struct ovl_fs *ofs, struct dentry *upper,
  *
  * Caller must hold i_mutex on indexdir.
  */
-static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
+static int ovl_create_index(struct dentry *dentry, struct dentry *origin,
 			    struct dentry *upper)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
@@ -503,7 +502,7 @@ static int ovl_create_index(struct dentry *dentry, const struct ovl_fh *fh,
 	if (WARN_ON(ovl_test_flag(OVL_INDEX, d_inode(dentry))))
 		return -EIO;
 
-	err = ovl_get_index_name_fh(fh, &name);
+	err = ovl_get_index_name(ofs, origin, &name);
 	if (err)
 		return err;
 
@@ -542,7 +541,6 @@ struct ovl_copy_up_ctx {
 	struct dentry *destdir;
 	struct qstr destname;
 	struct dentry *workdir;
-	const struct ovl_fh *origin_fh;
 	bool origin;
 	bool indexed;
 	bool metacopy;
@@ -639,7 +637,7 @@ static int ovl_copy_up_metadata(struct ovl_copy_up_ctx *c, struct dentry *temp)
 	 * hard link.
 	 */
 	if (c->origin) {
-		err = ovl_set_origin_fh(ofs, c->origin_fh, temp);
+		err = ovl_set_origin(ofs, c->lowerpath.dentry, temp);
 		if (err)
 			return err;
 	}
@@ -751,7 +749,7 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		goto cleanup;
 
 	if (S_ISDIR(c->stat.mode) && c->indexed) {
-		err = ovl_create_index(c->dentry, c->origin_fh, temp);
+		err = ovl_create_index(c->dentry, c->lowerpath.dentry, temp);
 		if (err)
 			goto cleanup;
 	}
@@ -863,8 +861,6 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 {
 	int err;
 	struct ovl_fs *ofs = OVL_FS(c->dentry->d_sb);
-	struct dentry *origin = c->lowerpath.dentry;
-	struct ovl_fh *fh = NULL;
 	bool to_index = false;
 
 	/*
@@ -881,25 +877,17 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 			to_index = true;
 	}
 
-	if (S_ISDIR(c->stat.mode) || c->stat.nlink == 1 || to_index) {
-		fh = ovl_get_origin_fh(ofs, origin);
-		if (IS_ERR(fh))
-			return PTR_ERR(fh);
-
-		/* origin_fh may be NULL */
-		c->origin_fh = fh;
+	if (S_ISDIR(c->stat.mode) || c->stat.nlink == 1 || to_index)
 		c->origin = true;
-	}
 
 	if (to_index) {
 		c->destdir = ovl_indexdir(c->dentry->d_sb);
-		err = ovl_get_index_name(ofs, origin, &c->destname);
+		err = ovl_get_index_name(ofs, c->lowerpath.dentry, &c->destname);
 		if (err)
-			goto out_free_fh;
+			return err;
 	} else if (WARN_ON(!c->parent)) {
 		/* Disconnected dentry must be copied up to index dir */
-		err = -EIO;
-		goto out_free_fh;
+		return -EIO;
 	} else {
 		/*
 		 * Mark parent "impure" because it may now contain non-pure
@@ -907,7 +895,7 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 		 */
 		err = ovl_set_impure(c->parent, c->destdir);
 		if (err)
-			goto out_free_fh;
+			return err;
 	}
 
 	/* Should we copyup with O_TMPFILE or with workdir? */
@@ -939,8 +927,6 @@ static int ovl_do_copy_up(struct ovl_copy_up_ctx *c)
 out:
 	if (to_index)
 		kfree(c->destname.name);
-out_free_fh:
-	kfree(fh);
 	return err;
 }
 
diff --git a/fs/overlayfs/export.c b/fs/overlayfs/export.c
index 3a17e4366f28..611ff567a1aa 100644
--- a/fs/overlayfs/export.c
+++ b/fs/overlayfs/export.c
@@ -181,37 +181,35 @@ static int ovl_connect_layer(struct dentry *dentry)
  *
  * Return 0 for upper file handle, > 0 for lower file handle or < 0 on error.
  */
-static int ovl_check_encode_origin(struct inode *inode)
+static int ovl_check_encode_origin(struct dentry *dentry)
 {
-	struct ovl_fs *ofs = OVL_FS(inode->i_sb);
+	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	bool decodable = ofs->config.nfs_export;
-	struct dentry *dentry;
-	int err;
 
 	/* No upper layer? */
 	if (!ovl_upper_mnt(ofs))
 		return 1;
 
 	/* Lower file handle for non-upper non-decodable */
-	if (!ovl_inode_upper(inode) && !decodable)
+	if (!ovl_dentry_upper(dentry) && !decodable)
 		return 1;
 
 	/* Upper file handle for pure upper */
-	if (!ovl_inode_lower(inode))
+	if (!ovl_dentry_lower(dentry))
 		return 0;
 
 	/*
 	 * Root is never indexed, so if there's an upper layer, encode upper for
 	 * root.
 	 */
-	if (inode == d_inode(inode->i_sb->s_root))
+	if (dentry == dentry->d_sb->s_root)
 		return 0;
 
 	/*
 	 * Upper decodable file handle for non-indexed upper.
 	 */
-	if (ovl_inode_upper(inode) && decodable &&
-	    !ovl_test_flag(OVL_INDEX, inode))
+	if (ovl_dentry_upper(dentry) && decodable &&
+	    !ovl_test_flag(OVL_INDEX, d_inode(dentry)))
 		return 0;
 
 	/*
@@ -220,23 +218,14 @@ static int ovl_check_encode_origin(struct inode *inode)
 	 * ovl_connect_layer() will try to make origin's layer "connected" by
 	 * copying up a "connectable" ancestor.
 	 */
-	if (!decodable || !S_ISDIR(inode->i_mode))
-		return 1;
-
-	dentry = d_find_any_alias(inode);
-	if (!dentry)
-		return -ENOENT;
-
-	err = ovl_connect_layer(dentry);
-	dput(dentry);
-	if (err < 0)
-		return err;
+	if (d_is_dir(dentry) && decodable)
+		return ovl_connect_layer(dentry);
 
 	/* Lower file handle for indexed and non-upper dir/non-dir */
 	return 1;
 }
 
-static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct inode *inode,
+static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct dentry *dentry,
 			     u32 *fid, int buflen)
 {
 	struct ovl_fh *fh = NULL;
@@ -247,13 +236,13 @@ static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct inode *inode,
 	 * Check if we should encode a lower or upper file handle and maybe
 	 * copy up an ancestor to make lower file handle connectable.
 	 */
-	err = enc_lower = ovl_check_encode_origin(inode);
+	err = enc_lower = ovl_check_encode_origin(dentry);
 	if (enc_lower < 0)
 		goto fail;
 
 	/* Encode an upper or lower file handle */
-	fh = ovl_encode_real_fh(ofs, enc_lower ? ovl_inode_lower(inode) :
-				ovl_inode_upper(inode), !enc_lower);
+	fh = ovl_encode_real_fh(ofs, enc_lower ? ovl_dentry_lower(dentry) :
+				ovl_dentry_upper(dentry), !enc_lower);
 	if (IS_ERR(fh))
 		return PTR_ERR(fh);
 
@@ -267,8 +256,8 @@ static int ovl_dentry_to_fid(struct ovl_fs *ofs, struct inode *inode,
 	return err;
 
 fail:
-	pr_warn_ratelimited("failed to encode file handle (ino=%lu, err=%i)\n",
-			    inode->i_ino, err);
+	pr_warn_ratelimited("failed to encode file handle (%pd2, err=%i)\n",
+			    dentry, err);
 	goto out;
 }
 
@@ -276,13 +265,19 @@ static int ovl_encode_fh(struct inode *inode, u32 *fid, int *max_len,
 			 struct inode *parent)
 {
 	struct ovl_fs *ofs = OVL_FS(inode->i_sb);
+	struct dentry *dentry;
 	int bytes, buflen = *max_len << 2;
 
 	/* TODO: encode connectable file handles */
 	if (parent)
 		return FILEID_INVALID;
 
-	bytes = ovl_dentry_to_fid(ofs, inode, fid, buflen);
+	dentry = d_find_any_alias(inode);
+	if (!dentry)
+		return FILEID_INVALID;
+
+	bytes = ovl_dentry_to_fid(ofs, dentry, fid, buflen);
+	dput(dentry);
 	if (bytes <= 0)
 		return FILEID_INVALID;
 
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 2d2ef671b36b..80391c687c2a 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -507,19 +507,6 @@ static int ovl_verify_fh(struct ovl_fs *ofs, struct dentry *dentry,
 	return err;
 }
 
-int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
-		      enum ovl_xattr ox, const struct ovl_fh *fh,
-		      bool is_upper, bool set)
-{
-	int err;
-
-	err = ovl_verify_fh(ofs, dentry, ox, fh);
-	if (set && err == -ENODATA)
-		err = ovl_setxattr(ofs, dentry, ox, fh->buf, fh->fb.len);
-
-	return err;
-}
-
 /*
  * Verify that @real dentry matches the file handle stored in xattr @name.
  *
@@ -528,22 +515,24 @@ int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
  *
  * Return 0 on match, -ESTALE on mismatch, -ENODATA on no xattr, < 0 on error.
  */
-int ovl_verify_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry,
-			    enum ovl_xattr ox, struct dentry *real,
-			    bool is_upper, bool set)
+int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
+		      enum ovl_xattr ox, struct dentry *real, bool is_upper,
+		      bool set)
 {
 	struct inode *inode;
 	struct ovl_fh *fh;
 	int err;
 
-	fh = ovl_encode_real_fh(ofs, d_inode(real), is_upper);
+	fh = ovl_encode_real_fh(ofs, real, is_upper);
 	err = PTR_ERR(fh);
 	if (IS_ERR(fh)) {
 		fh = NULL;
 		goto fail;
 	}
 
-	err = ovl_verify_set_fh(ofs, dentry, ox, fh, is_upper, set);
+	err = ovl_verify_fh(ofs, dentry, ox, fh);
+	if (set && err == -ENODATA)
+		err = ovl_setxattr(ofs, dentry, ox, fh->buf, fh->fb.len);
 	if (err)
 		goto fail;
 
@@ -559,7 +548,6 @@ int ovl_verify_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry,
 	goto out;
 }
 
-
 /* Get upper dentry from index */
 struct dentry *ovl_index_upper(struct ovl_fs *ofs, struct dentry *index,
 			       bool connected)
@@ -696,7 +684,7 @@ int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index)
 	goto out;
 }
 
-int ovl_get_index_name_fh(const struct ovl_fh *fh, struct qstr *name)
+static int ovl_get_index_name_fh(struct ovl_fh *fh, struct qstr *name)
 {
 	char *n, *s;
 
@@ -732,7 +720,7 @@ int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
 	struct ovl_fh *fh;
 	int err;
 
-	fh = ovl_encode_real_fh(ofs, d_inode(origin), false);
+	fh = ovl_encode_real_fh(ofs, origin, false);
 	if (IS_ERR(fh))
 		return PTR_ERR(fh);
 
@@ -885,27 +873,20 @@ int ovl_path_next(int idx, struct dentry *dentry, struct path *path)
 static int ovl_fix_origin(struct ovl_fs *ofs, struct dentry *dentry,
 			  struct dentry *lower, struct dentry *upper)
 {
-	const struct ovl_fh *fh;
 	int err;
 
 	if (ovl_check_origin_xattr(ofs, upper))
 		return 0;
 
-	fh = ovl_get_origin_fh(ofs, lower);
-	if (IS_ERR(fh))
-		return PTR_ERR(fh);
-
 	err = ovl_want_write(dentry);
 	if (err)
-		goto out;
+		return err;
 
-	err = ovl_set_origin_fh(ofs, fh, upper);
+	err = ovl_set_origin(ofs, lower, upper);
 	if (!err)
 		err = ovl_set_impure(dentry->d_parent, upper->d_parent);
 
 	ovl_drop_write(dentry);
-out:
-	kfree(fh);
 	return err;
 }
 
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index ca63a26a6170..09ca82ed0f8c 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -632,15 +632,11 @@ struct dentry *ovl_decode_real_fh(struct ovl_fs *ofs, struct ovl_fh *fh,
 int ovl_check_origin_fh(struct ovl_fs *ofs, struct ovl_fh *fh, bool connected,
 			struct dentry *upperdentry, struct ovl_path **stackp);
 int ovl_verify_set_fh(struct ovl_fs *ofs, struct dentry *dentry,
-		      enum ovl_xattr ox, const struct ovl_fh *fh,
-		      bool is_upper, bool set);
-int ovl_verify_origin_xattr(struct ovl_fs *ofs, struct dentry *dentry,
-			    enum ovl_xattr ox, struct dentry *real,
-			    bool is_upper, bool set);
+		      enum ovl_xattr ox, struct dentry *real, bool is_upper,
+		      bool set);
 struct dentry *ovl_index_upper(struct ovl_fs *ofs, struct dentry *index,
 			       bool connected);
 int ovl_verify_index(struct ovl_fs *ofs, struct dentry *index);
-int ovl_get_index_name_fh(const struct ovl_fh *fh, struct qstr *name);
 int ovl_get_index_name(struct ovl_fs *ofs, struct dentry *origin,
 		       struct qstr *name);
 struct dentry *ovl_get_index_fh(struct ovl_fs *ofs, struct ovl_fh *fh);
@@ -652,24 +648,17 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			  unsigned int flags);
 bool ovl_lower_positive(struct dentry *dentry);
 
-static inline int ovl_verify_origin_fh(struct ovl_fs *ofs, struct dentry *upper,
-				       const struct ovl_fh *fh, bool set)
-{
-	return ovl_verify_set_fh(ofs, upper, OVL_XATTR_ORIGIN, fh, false, set);
-}
-
 static inline int ovl_verify_origin(struct ovl_fs *ofs, struct dentry *upper,
 				    struct dentry *origin, bool set)
 {
-	return ovl_verify_origin_xattr(ofs, upper, OVL_XATTR_ORIGIN, origin,
-				       false, set);
+	return ovl_verify_set_fh(ofs, upper, OVL_XATTR_ORIGIN, origin,
+				 false, set);
 }
 
 static inline int ovl_verify_upper(struct ovl_fs *ofs, struct dentry *index,
 				   struct dentry *upper, bool set)
 {
-	return ovl_verify_origin_xattr(ofs, index, OVL_XATTR_UPPER, upper,
-				       true, set);
+	return ovl_verify_set_fh(ofs, index, OVL_XATTR_UPPER, upper, true, set);
 }
 
 /* readdir.c */
@@ -832,11 +821,10 @@ int ovl_copy_up_with_data(struct dentry *dentry);
 int ovl_maybe_copy_up(struct dentry *dentry, int flags);
 int ovl_copy_xattr(struct super_block *sb, const struct path *path, struct dentry *new);
 int ovl_set_attr(struct ovl_fs *ofs, struct dentry *upper, struct kstat *stat);
-struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct inode *realinode,
+struct ovl_fh *ovl_encode_real_fh(struct ovl_fs *ofs, struct dentry *real,
 				  bool is_upper);
-struct ovl_fh *ovl_get_origin_fh(struct ovl_fs *ofs, struct dentry *origin);
-int ovl_set_origin_fh(struct ovl_fs *ofs, const struct ovl_fh *fh,
-		      struct dentry *upper);
+int ovl_set_origin(struct ovl_fs *ofs, struct dentry *lower,
+		   struct dentry *upper);
 
 /* export.c */
 extern const struct export_operations ovl_export_operations;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e2574034c3fa..2c056d737c27 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -879,20 +879,15 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 {
 	struct vfsmount *mnt = ovl_upper_mnt(ofs);
 	struct dentry *indexdir;
-	struct dentry *origin = ovl_lowerstack(oe)->dentry;
-	const struct ovl_fh *fh;
 	int err;
 
-	fh = ovl_get_origin_fh(ofs, origin);
-	if (IS_ERR(fh))
-		return PTR_ERR(fh);
-
 	err = mnt_want_write(mnt);
 	if (err)
-		goto out_free_fh;
+		return err;
 
 	/* Verify lower root is upper root origin */
-	err = ovl_verify_origin_fh(ofs, upperpath->dentry, fh, true);
+	err = ovl_verify_origin(ofs, upperpath->dentry,
+				ovl_lowerstack(oe)->dentry, true);
 	if (err) {
 		pr_err("failed to verify upper root origin\n");
 		goto out;
@@ -924,10 +919,9 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 		 * directory entries.
 		 */
 		if (ovl_check_origin_xattr(ofs, ofs->indexdir)) {
-			err = ovl_verify_origin_xattr(ofs, ofs->indexdir,
-						      OVL_XATTR_ORIGIN,
-						      upperpath->dentry, true,
-						      false);
+			err = ovl_verify_set_fh(ofs, ofs->indexdir,
+						OVL_XATTR_ORIGIN,
+						upperpath->dentry, true, false);
 			if (err)
 				pr_err("failed to verify index dir 'origin' xattr\n");
 		}
@@ -945,8 +939,6 @@ static int ovl_get_indexdir(struct super_block *sb, struct ovl_fs *ofs,
 
 out:
 	mnt_drop_write(mnt);
-out_free_fh:
-	kfree(fh);
 	return err;
 }
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 4e6b747e0f2e..0bf3ffcd072f 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -976,18 +976,12 @@ static void ovl_cleanup_index(struct dentry *dentry)
 	struct dentry *index = NULL;
 	struct inode *inode;
 	struct qstr name = { };
-	bool got_write = false;
 	int err;
 
 	err = ovl_get_index_name(ofs, lowerdentry, &name);
 	if (err)
 		goto fail;
 
-	err = ovl_want_write(dentry);
-	if (err)
-		goto fail;
-
-	got_write = true;
 	inode = d_inode(upperdentry);
 	if (!S_ISDIR(inode->i_mode) && inode->i_nlink != 1) {
 		pr_warn_ratelimited("cleanup linked index (%pd2, ino=%lu, nlink=%u)\n",
@@ -1025,8 +1019,6 @@ static void ovl_cleanup_index(struct dentry *dentry)
 		goto fail;
 
 out:
-	if (got_write)
-		ovl_drop_write(dentry);
 	kfree(name.name);
 	dput(index);
 	return;
@@ -1097,8 +1089,6 @@ void ovl_nlink_end(struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 
-	ovl_drop_write(dentry);
-
 	if (ovl_test_flag(OVL_INDEX, inode) && inode->i_nlink == 0) {
 		const struct cred *old_cred;
 


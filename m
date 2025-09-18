Return-Path: <stable+bounces-173554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5F2B35E26
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A505B460D8D
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C74284B5B;
	Tue, 26 Aug 2025 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oIm+HXkD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C8267386;
	Tue, 26 Aug 2025 11:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208550; cv=none; b=RMspUjpNFAU0uHsePwgz+lJlb4t2jZnceZ2KDQJdhU573YzburuXx1ORjuTz/8ieqSqtfmTvhBNiSUXeH+zKa8aX1+wYxon01cQXWD0Rmuzl87mHWAS3VRHu8oRboCEikvacyFA5X47QbQR4A/MOWSE76+1BQKeAFW1nIespWnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208550; c=relaxed/simple;
	bh=VGnn0HnH5p2dyl/yKKTSvnGzaxhtD6CZPLP+ET97WII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/D/7/1OZVJthhOK0UfqiLQIKV3NSJuirn/FaPR5G0EZ/NSwcKgyHlypBtY+ZDS4Mzf70/RTnj3CDGtyYvTZkzjz0x5VM3y8kk7kOK2h+z+Lq/GP+UXV9YR5nmxM+urfiV+5VCGnztxouxCUZgBq4NGExbDbNruqhK7UeURlVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oIm+HXkD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14E02C4CEF1;
	Tue, 26 Aug 2025 11:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756208550;
	bh=VGnn0HnH5p2dyl/yKKTSvnGzaxhtD6CZPLP+ET97WII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oIm+HXkDgekBp2Xj8rVOHaHMUHCcpfEB0DC4s338s8/CAmGprb2Z8slC3KUQDdNx9
	 Og6nak7rSaWb90s4q5cRpdzhtmA8jUOMqJRRj6qA3/OPJo7e+6Cw+O6J3URCK0LYnd
	 DwPzDxZz+u3dt2eWercTmuuSu2RkPkmivxPpL9Vg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 155/322] btrfs: send: avoid path allocation for the current inode when issuing commands
Date: Tue, 26 Aug 2025 13:09:30 +0200
Message-ID: <20250826110919.647069185@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110915.169062587@linuxfoundation.org>
References: <20250826110915.169062587@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 374d45af6435534a11b01b88762323abf03dd755 ]

Whenever we issue a command we allocate a path and then compute it. For
the current inode this is not necessary since we have one preallocated
and computed in the send context structure, so we can use it instead
and avoid allocating and freeing a path.

For example if we have 100 extents to send (100 write commands) for a
file, we are allocating and freeing paths 100 times.

So improve on this by avoiding path allocation and freeing whenever a
command is for the current inode by using the current inode's path
stored in the send context structure.

A test was run before applying this patch and the previous one in the
series:

  "btrfs: send: keep the current inode's path cached"

The test script is the following:

  $ cat test.sh
  #!/bin/bash

  DEV=/dev/nullb0
  MNT=/mnt/nullb0

  mkfs.btrfs -f $DEV > /dev/null
  mount $DEV $MNT

  DIR="$MNT/one/two/three/four"
  FILE="$DIR/foobar"

  mkdir -p $DIR

  # Create some empty files to get a deeper btree and therefore make
  # path computations slower.
  for ((i = 1; i <= 30000; i++)); do
      echo -n > "$DIR/filler_$i"
  done

  for ((i = 0; i < 10000; i += 2)); do
     offset=$(( i * 4096 ))
     xfs_io -f -c "pwrite -S 0xab $offset 4K" $FILE > /dev/null
  done

  btrfs subvolume snapshot -r $MNT $MNT/snap

  start=$(date +%s%N)
  btrfs send -f /dev/null $MNT/snap
  end=$(date +%s%N)

  echo -e "\nsend took $(( (end - start) / 1000000 )) milliseconds"

  umount $MNT

Result before applying the 2 patches:  1121 milliseconds
Result after applying the 2 patches:    815 milliseconds  (-31.6%)

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 005b0a0c24e1 ("btrfs: send: use fallocate for hole punching with send stream v2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/send.c |  215 +++++++++++++++++++++++++-------------------------------
 1 file changed, 97 insertions(+), 118 deletions(-)

--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2623,6 +2623,47 @@ out:
 	return ret;
 }
 
+static struct fs_path *get_cur_inode_path(struct send_ctx *sctx)
+{
+	if (fs_path_len(&sctx->cur_inode_path) == 0) {
+		int ret;
+
+		ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen,
+				   &sctx->cur_inode_path);
+		if (ret < 0)
+			return ERR_PTR(ret);
+	}
+
+	return &sctx->cur_inode_path;
+}
+
+static struct fs_path *get_path_for_command(struct send_ctx *sctx, u64 ino, u64 gen)
+{
+	struct fs_path *path;
+	int ret;
+
+	if (ino == sctx->cur_ino && gen == sctx->cur_inode_gen)
+		return get_cur_inode_path(sctx);
+
+	path = fs_path_alloc();
+	if (!path)
+		return ERR_PTR(-ENOMEM);
+
+	ret = get_cur_path(sctx, ino, gen, path);
+	if (ret < 0) {
+		fs_path_free(path);
+		return ERR_PTR(ret);
+	}
+
+	return path;
+}
+
+static void free_path_for_command(const struct send_ctx *sctx, struct fs_path *path)
+{
+	if (path != &sctx->cur_inode_path)
+		fs_path_free(path);
+}
+
 static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 {
 	struct btrfs_fs_info *fs_info = sctx->send_root->fs_info;
@@ -2631,17 +2672,14 @@ static int send_truncate(struct send_ctx
 
 	btrfs_debug(fs_info, "send_truncate %llu size=%llu", ino, size);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_TRUNCATE);
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_SIZE, size);
 
@@ -2649,7 +2687,7 @@ static int send_truncate(struct send_ctx
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2661,17 +2699,14 @@ static int send_chmod(struct send_ctx *s
 
 	btrfs_debug(fs_info, "send_chmod %llu mode=%llu", ino, mode);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_CHMOD);
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_MODE, mode & 07777);
 
@@ -2679,7 +2714,7 @@ static int send_chmod(struct send_ctx *s
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2694,17 +2729,14 @@ static int send_fileattr(struct send_ctx
 
 	btrfs_debug(fs_info, "send_fileattr %llu fileattr=%llu", ino, fileattr);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_FILEATTR);
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILEATTR, fileattr);
 
@@ -2712,7 +2744,7 @@ static int send_fileattr(struct send_ctx
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2725,17 +2757,14 @@ static int send_chown(struct send_ctx *s
 	btrfs_debug(fs_info, "send_chown %llu uid=%llu, gid=%llu",
 		    ino, uid, gid);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_CHOWN);
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_UID, uid);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_GID, gid);
@@ -2744,7 +2773,7 @@ static int send_chown(struct send_ctx *s
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2761,9 +2790,9 @@ static int send_utimes(struct send_ctx *
 
 	btrfs_debug(fs_info, "send_utimes %llu", ino);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	path = alloc_path_for_send();
 	if (!path) {
@@ -2788,9 +2817,6 @@ static int send_utimes(struct send_ctx *
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_ATIME, eb, &ii->atime);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_MTIME, eb, &ii->mtime);
@@ -2802,7 +2828,7 @@ static int send_utimes(struct send_ctx *
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -4929,13 +4955,9 @@ static int send_set_xattr(struct send_ct
 	struct fs_path *path;
 	int ret;
 
-	path = fs_path_alloc();
-	if (!path)
-		return -ENOMEM;
-
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, path);
-	if (ret < 0)
-		goto out;
+	path = get_cur_inode_path(sctx);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_SET_XATTR);
 	if (ret < 0)
@@ -4949,8 +4971,6 @@ static int send_set_xattr(struct send_ct
 
 tlv_put_failure:
 out:
-	fs_path_free(path);
-
 	return ret;
 }
 
@@ -5008,23 +5028,14 @@ static int __process_deleted_xattr(int n
 				   const char *name, int name_len,
 				   const char *data, int data_len, void *ctx)
 {
-	int ret;
 	struct send_ctx *sctx = ctx;
 	struct fs_path *p;
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto out;
-
-	ret = send_remove_xattr(sctx, p, name, name_len);
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
-out:
-	fs_path_free(p);
-	return ret;
+	return send_remove_xattr(sctx, p, name, name_len);
 }
 
 static int process_new_xattr(struct send_ctx *sctx)
@@ -5257,21 +5268,13 @@ static int process_verity(struct send_ct
 	if (ret < 0)
 		goto iput;
 
-	p = fs_path_alloc();
-	if (!p) {
-		ret = -ENOMEM;
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p)) {
+		ret = PTR_ERR(p);
 		goto iput;
 	}
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto free_path;
 
 	ret = send_verity(sctx, p, sctx->verity_descriptor);
-	if (ret < 0)
-		goto free_path;
-
-free_path:
-	fs_path_free(p);
 iput:
 	iput(inode);
 	return ret;
@@ -5393,31 +5396,25 @@ static int send_write(struct send_ctx *s
 	int ret = 0;
 	struct fs_path *p;
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-
 	btrfs_debug(fs_info, "send_write offset=%llu, len=%d", offset, len);
 
-	ret = begin_cmd(sctx, BTRFS_SEND_C_WRITE);
-	if (ret < 0)
-		goto out;
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
+	ret = begin_cmd(sctx, BTRFS_SEND_C_WRITE);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
 	ret = put_file_data(sctx, offset, len);
 	if (ret < 0)
-		goto out;
+		return ret;
 
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5430,6 +5427,7 @@ static int send_clone(struct send_ctx *s
 {
 	int ret = 0;
 	struct fs_path *p;
+	struct fs_path *cur_inode_path;
 	u64 gen;
 
 	btrfs_debug(sctx->send_root->fs_info,
@@ -5437,6 +5435,10 @@ static int send_clone(struct send_ctx *s
 		    offset, len, btrfs_root_id(clone_root->root),
 		    clone_root->ino, clone_root->offset);
 
+	cur_inode_path = get_cur_inode_path(sctx);
+	if (IS_ERR(cur_inode_path))
+		return PTR_ERR(cur_inode_path);
+
 	p = fs_path_alloc();
 	if (!p)
 		return -ENOMEM;
@@ -5445,13 +5447,9 @@ static int send_clone(struct send_ctx *s
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto out;
-
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_CLONE_LEN, len);
-	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
+	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, cur_inode_path);
 
 	if (clone_root->root == sctx->send_root) {
 		ret = get_inode_gen(sctx->send_root, clone_root->ino, &gen);
@@ -5502,17 +5500,13 @@ static int send_update_extent(struct sen
 	int ret = 0;
 	struct fs_path *p;
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	ret = begin_cmd(sctx, BTRFS_SEND_C_UPDATE_EXTENT);
 	if (ret < 0)
-		goto out;
-
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto out;
+		return ret;
 
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_U64(sctx, BTRFS_SEND_A_FILE_OFFSET, offset);
@@ -5521,8 +5515,6 @@ static int send_update_extent(struct sen
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5551,12 +5543,10 @@ static int send_hole(struct send_ctx *sc
 	if (sctx->flags & BTRFS_SEND_FLAG_NO_FILE_DATA)
 		return send_update_extent(sctx, offset, end - offset);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, p);
-	if (ret < 0)
-		goto tlv_put_failure;
+	p = get_cur_inode_path(sctx);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
+
 	while (offset < end) {
 		u64 len = min(end - offset, read_size);
 
@@ -5577,7 +5567,6 @@ static int send_hole(struct send_ctx *sc
 	}
 	sctx->cur_inode_next_write_offset = offset;
 tlv_put_failure:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5600,9 +5589,9 @@ static int send_encoded_inline_extent(st
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	fspath = fs_path_alloc();
-	if (!fspath) {
-		ret = -ENOMEM;
+	fspath = get_cur_inode_path(sctx);
+	if (IS_ERR(fspath)) {
+		ret = PTR_ERR(fspath);
 		goto out;
 	}
 
@@ -5610,10 +5599,6 @@ static int send_encoded_inline_extent(st
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	ram_bytes = btrfs_file_extent_ram_bytes(leaf, ei);
@@ -5642,7 +5627,6 @@ static int send_encoded_inline_extent(st
 
 tlv_put_failure:
 out:
-	fs_path_free(fspath);
 	iput(inode);
 	return ret;
 }
@@ -5667,9 +5651,9 @@ static int send_encoded_extent(struct se
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
-	fspath = fs_path_alloc();
-	if (!fspath) {
-		ret = -ENOMEM;
+	fspath = get_cur_inode_path(sctx);
+	if (IS_ERR(fspath)) {
+		ret = PTR_ERR(fspath);
 		goto out;
 	}
 
@@ -5677,10 +5661,6 @@ static int send_encoded_extent(struct se
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
@@ -5747,7 +5727,6 @@ static int send_encoded_extent(struct se
 
 tlv_put_failure:
 out:
-	fs_path_free(fspath);
 	iput(inode);
 	return ret;
 }




Return-Path: <stable+bounces-171732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDEAB2B723
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 04:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD081525986
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA3A1D88B4;
	Tue, 19 Aug 2025 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yj+xOzZo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B923287269
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571225; cv=none; b=irIb6peoVGFqy3k0t6XH4Rxx5oqZXtVdiayT1XAxHGCx/zDUBvIYW6PlKQLTNOEhuR0NPjBIbLk16GqcK6o9eVVubC9fveiVrMLJ5xtNm8DWrOqdhr4VofrX0hwraTQ+3c+OQvCg8cArtP5kwmVYyLaY+zBclGmEf8qVxfr7lwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571225; c=relaxed/simple;
	bh=XTELcCcCj4/36E1ejK8Z6vODvpNgxhopgLcyqNmr9Ic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+agJbLBj4a0U09XOF6I/zYgQYfUpDFN+VmZsCKJoW8wPWsUv9rOQwraBeA0ABwTxlPqo6GWvTBomIKZA8rniKOoBCTu8447xTEf7MHHcecUEwDNFevcVfbrHgqdSPIcNpEEDKDyd0I1gSF1Ev06jgK//YnciVHi7IKSKlbpQhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yj+xOzZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DA0C4CEED;
	Tue, 19 Aug 2025 02:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755571225;
	bh=XTELcCcCj4/36E1ejK8Z6vODvpNgxhopgLcyqNmr9Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Yj+xOzZobcf4DRkZ5c6N9CQ3s7pzI2mFVsBP7v50XwnIYEcnNKFbfU4EHSnJ6qo5l
	 cN/tKweREPZClTDSQ+hFATadwkSa5LvR9HEO/sEdBLuAlEXM52Q3NYHnsfZzU4oa/F
	 p88MUtPHV5eIRViFueRAcuvHUYFoF7XzIMvMX4flYjkDwmGUIeCmHbIomAZrNqfpQm
	 3H3/kK4TNEEi/tsaKQMMFa7kfb5P4absxo/59Unwjb3J0F2In/MxEpQOwlTXQK7cxO
	 cfIli+1F0Ffl06gu++Uvk6hCCsMcEQgouvrs7skW2l6FNK9gfir9gewOMyeMQVVFUj
	 2GVkq81JRRPwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] btrfs: send: avoid path allocation for the current inode when issuing commands
Date: Mon, 18 Aug 2025 22:40:18 -0400
Message-ID: <20250819024020.291759-5-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819024020.291759-1-sashal@kernel.org>
References: <2025081840-stomp-enhance-b456@gregkh>
 <20250819024020.291759-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/btrfs/send.c | 215 ++++++++++++++++++++++--------------------------
 1 file changed, 97 insertions(+), 118 deletions(-)

diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 7685b412b35c..05291aeee723 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -2623,6 +2623,47 @@ static int send_subvol_begin(struct send_ctx *sctx)
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
@@ -2631,17 +2672,14 @@ static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 
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
 
@@ -2649,7 +2687,7 @@ static int send_truncate(struct send_ctx *sctx, u64 ino, u64 gen, u64 size)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2661,17 +2699,14 @@ static int send_chmod(struct send_ctx *sctx, u64 ino, u64 gen, u64 mode)
 
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
 
@@ -2679,7 +2714,7 @@ static int send_chmod(struct send_ctx *sctx, u64 ino, u64 gen, u64 mode)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2694,17 +2729,14 @@ static int send_fileattr(struct send_ctx *sctx, u64 ino, u64 gen, u64 fileattr)
 
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
 
@@ -2712,7 +2744,7 @@ static int send_fileattr(struct send_ctx *sctx, u64 ino, u64 gen, u64 fileattr)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2725,17 +2757,14 @@ static int send_chown(struct send_ctx *sctx, u64 ino, u64 gen, u64 uid, u64 gid)
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
@@ -2744,7 +2773,7 @@ static int send_chown(struct send_ctx *sctx, u64 ino, u64 gen, u64 uid, u64 gid)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	return ret;
 }
 
@@ -2761,9 +2790,9 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 
 	btrfs_debug(fs_info, "send_utimes %llu", ino);
 
-	p = fs_path_alloc();
-	if (!p)
-		return -ENOMEM;
+	p = get_path_for_command(sctx, ino, gen);
+	if (IS_ERR(p))
+		return PTR_ERR(p);
 
 	path = alloc_path_for_send();
 	if (!path) {
@@ -2788,9 +2817,6 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, ino, gen, p);
-	if (ret < 0)
-		goto out;
 	TLV_PUT_PATH(sctx, BTRFS_SEND_A_PATH, p);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_ATIME, eb, &ii->atime);
 	TLV_PUT_BTRFS_TIMESPEC(sctx, BTRFS_SEND_A_MTIME, eb, &ii->mtime);
@@ -2802,7 +2828,7 @@ static int send_utimes(struct send_ctx *sctx, u64 ino, u64 gen)
 
 tlv_put_failure:
 out:
-	fs_path_free(p);
+	free_path_for_command(sctx, p);
 	btrfs_free_path(path);
 	return ret;
 }
@@ -4930,13 +4956,9 @@ static int send_set_xattr(struct send_ctx *sctx,
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
@@ -4950,8 +4972,6 @@ static int send_set_xattr(struct send_ctx *sctx,
 
 tlv_put_failure:
 out:
-	fs_path_free(path);
-
 	return ret;
 }
 
@@ -5009,23 +5029,14 @@ static int __process_deleted_xattr(int num, struct btrfs_key *di_key,
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
@@ -5259,21 +5270,13 @@ static int process_verity(struct send_ctx *sctx)
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
@@ -5388,31 +5391,25 @@ static int send_write(struct send_ctx *sctx, u64 offset, u32 len)
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
 
@@ -5425,6 +5422,7 @@ static int send_clone(struct send_ctx *sctx,
 {
 	int ret = 0;
 	struct fs_path *p;
+	struct fs_path *cur_inode_path;
 	u64 gen;
 
 	btrfs_debug(sctx->send_root->fs_info,
@@ -5432,6 +5430,10 @@ static int send_clone(struct send_ctx *sctx,
 		    offset, len, clone_root->root->root_key.objectid,
 		    clone_root->ino, clone_root->offset);
 
+	cur_inode_path = get_cur_inode_path(sctx);
+	if (IS_ERR(cur_inode_path))
+		return PTR_ERR(cur_inode_path);
+
 	p = fs_path_alloc();
 	if (!p)
 		return -ENOMEM;
@@ -5440,13 +5442,9 @@ static int send_clone(struct send_ctx *sctx,
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
@@ -5497,17 +5495,13 @@ static int send_update_extent(struct send_ctx *sctx,
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
@@ -5516,8 +5510,6 @@ static int send_update_extent(struct send_ctx *sctx,
 	ret = send_cmd(sctx);
 
 tlv_put_failure:
-out:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5546,12 +5538,10 @@ static int send_hole(struct send_ctx *sctx, u64 end)
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
 
@@ -5572,7 +5562,6 @@ static int send_hole(struct send_ctx *sctx, u64 end)
 	}
 	sctx->cur_inode_next_write_offset = offset;
 tlv_put_failure:
-	fs_path_free(p);
 	return ret;
 }
 
@@ -5595,9 +5584,9 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
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
 
@@ -5605,10 +5594,6 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	ram_bytes = btrfs_file_extent_ram_bytes(leaf, ei);
@@ -5637,7 +5622,6 @@ static int send_encoded_inline_extent(struct send_ctx *sctx,
 
 tlv_put_failure:
 out:
-	fs_path_free(fspath);
 	iput(inode);
 	return ret;
 }
@@ -5662,9 +5646,9 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
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
 
@@ -5672,10 +5656,6 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 	if (ret < 0)
 		goto out;
 
-	ret = get_cur_path(sctx, sctx->cur_ino, sctx->cur_inode_gen, fspath);
-	if (ret < 0)
-		goto out;
-
 	btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 	ei = btrfs_item_ptr(leaf, path->slots[0], struct btrfs_file_extent_item);
 	disk_bytenr = btrfs_file_extent_disk_bytenr(leaf, ei);
@@ -5742,7 +5722,6 @@ static int send_encoded_extent(struct send_ctx *sctx, struct btrfs_path *path,
 
 tlv_put_failure:
 out:
-	fs_path_free(fspath);
 	iput(inode);
 	return ret;
 }
-- 
2.50.1



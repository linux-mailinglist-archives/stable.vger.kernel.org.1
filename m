Return-Path: <stable+bounces-164540-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56339B0FF02
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 04:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 854DE546AA0
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 02:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6810C1D514B;
	Thu, 24 Jul 2025 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/U4feUH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CBD22097
	for <stable@vger.kernel.org>; Thu, 24 Jul 2025 02:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753325854; cv=none; b=ef/Fs7JEuCUM02J2d+3ZHBAcsoT/NDnZAbSRuOCh4ravas8eCaId/ajIqI5vRHf3aYodcz63b7ZoryIs4rUL3xCgQVgIahSFvrqbCoqhpSuQej/oOW8Hc6LOt6ESiIF8SpbEaldQYdGuHDeulSwoNUxVnuLu79QHB5sUhh8lEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753325854; c=relaxed/simple;
	bh=Xgd9GEW0zp6yLDslY3tB2sGRZsPYsJWVghcY9Jk3GtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=he5pFBEdyedl3gCXOLkrnmtBOgRx3/pPsGWi7xmc2WTzuJeyZWT41ClL9Jsm4m6mgDpppyDVfwqJ3D63LgONpG9AR3NoDrs0HS4W+/jpALmKQ6ezE5NTERLA9Zyn2xILjYg2uVzNPqbeqJxsHdrQGz7pIOkZb499OnFDjkja10Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/U4feUH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC75C4CEEF;
	Thu, 24 Jul 2025 02:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753325854;
	bh=Xgd9GEW0zp6yLDslY3tB2sGRZsPYsJWVghcY9Jk3GtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/U4feUH48/tfuoTB/2yG9vwvH2itclHzqtYiw/A97MU9+AVZAS931ETQuqK5+tSQ
	 okdCRazAZ85VJHSgcKP67LfBl84CCFq6+CQz3EcCIaGaT5DAsNOKnQqQK2/Hkfwe2x
	 gRK0n5E8N13jWp4QlDeEwXZWzy5tOhC01UjakYNtaEwPWvi9UenaIuQcAetNMcEKmu
	 YjCXdecvFi44aHIro1jGJS/GBc8+6i/CEANf0saJk3YNJxoZ6tuDZ9v4POhX+D6W70
	 WSb/rG0KiYcuJhgirf8qv7XY7Z4XJqGlnFyRqNbeovCTkeOuKZk3kxuDzfKsgbD67T
	 vNDZnzk6RhE6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 07/11] ext4: move out inode_lock into ext4_fallocate()
Date: Wed, 23 Jul 2025 22:57:14 -0400
Message-Id: <20250724025718.1277650-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724025718.1277650-1-sashal@kernel.org>
References: <2025062009-junior-thriving-f882@gregkh>
 <20250724025718.1277650-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit ea3f17efd36b56c5839289716ba83eaa85893590 ]

Currently, all five sub-functions of ext4_fallocate() acquire the
inode's i_rwsem at the beginning and release it before exiting. This
process can be simplified by factoring out the management of i_rwsem
into the ext4_fallocate() function.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Link: https://patch.msgid.link/20241220011637.1157197-10-yi.zhang@huaweicloud.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 29ec9bed2395 ("ext4: fix incorrect punch max_end")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/extents.c | 90 +++++++++++++++--------------------------------
 fs/ext4/inode.c   | 13 +++----
 2 files changed, 33 insertions(+), 70 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index eb58f7a1ab5aa..30d412b62d9ed 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4579,23 +4579,18 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	int ret, flags, credits;
 
 	trace_ext4_zero_range(inode, offset, len, mode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
-	inode_lock(inode);
-
-	/*
-	 * Indirect files do not support unwritten extents
-	 */
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
+	/* Indirect files do not support unwritten extents */
+	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
+		return -EOPNOTSUPP;
 
 	if (!(mode & FALLOC_FL_KEEP_SIZE) &&
 	    (end > inode->i_size || end > EXT4_I(inode)->i_disksize)) {
 		new_size = end;
 		ret = inode_newsize_ok(inode, new_size);
 		if (ret)
-			goto out;
+			return ret;
 	}
 
 	/* Wait all existing dio workers, newcomers will block on i_rwsem */
@@ -4603,7 +4598,7 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 	ret = file_modified(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released
@@ -4685,8 +4680,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
@@ -4700,12 +4693,11 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 	int ret;
 
 	trace_ext4_fallocate_enter(inode, offset, len, mode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	start_lblk = offset >> inode->i_blkbits;
 	len_lblk = EXT4_MAX_BLOCKS(len, offset, inode->i_blkbits);
 
-	inode_lock(inode);
-
 	/* We only support preallocation for extent-based files only. */
 	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))) {
 		ret = -EOPNOTSUPP;
@@ -4737,7 +4729,6 @@ static long ext4_do_fallocate(struct file *file, loff_t offset,
 					EXT4_I(inode)->i_sync_tid);
 	}
 out:
-	inode_unlock(inode);
 	trace_ext4_fallocate_exit(inode, offset, len_lblk, ret);
 	return ret;
 }
@@ -4772,9 +4763,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 
 	inode_lock(inode);
 	ret = ext4_convert_inline_data(inode);
-	inode_unlock(inode);
 	if (ret)
-		return ret;
+		goto out_inode_lock;
 
 	if (mode & FALLOC_FL_PUNCH_HOLE)
 		ret = ext4_punch_hole(file, offset, len);
@@ -4786,7 +4776,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		ret = ext4_zero_range(file, offset, len, mode);
 	else
 		ret = ext4_do_fallocate(file, offset, len, mode);
-
+out_inode_lock:
+	inode_unlock(inode);
 	return ret;
 }
 
@@ -5291,36 +5282,27 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	int ret;
 
 	trace_ext4_collapse_range(inode, offset, len);
-
-	inode_lock(inode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	/* Currently just for extent based files */
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		return -EOPNOTSUPP;
 	/* Collapse range works only on fs cluster size aligned regions. */
-	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
-		ret = -EINVAL;
-		goto out;
-	}
-
+	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
+		return -EINVAL;
 	/*
 	 * There is no need to overlap collapse range with EOF, in which case
 	 * it is effectively a truncate operation
 	 */
-	if (end >= inode->i_size) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (end >= inode->i_size)
+		return -EINVAL;
 
 	/* Wait for existing dio to complete */
 	inode_dio_wait(inode);
 
 	ret = file_modified(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -5395,8 +5377,6 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
@@ -5422,39 +5402,27 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	loff_t start;
 
 	trace_ext4_insert_range(inode, offset, len);
-
-	inode_lock(inode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	/* Currently just for extent based files */
-	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)) {
-		ret = -EOPNOTSUPP;
-		goto out;
-	}
-
+	if (!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		return -EOPNOTSUPP;
 	/* Insert range works only on fs cluster size aligned regions. */
-	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb))) {
-		ret = -EINVAL;
-		goto out;
-	}
-
+	if (!IS_ALIGNED(offset | len, EXT4_CLUSTER_SIZE(sb)))
+		return -EINVAL;
 	/* Offset must be less than i_size */
-	if (offset >= inode->i_size) {
-		ret = -EINVAL;
-		goto out;
-	}
-
+	if (offset >= inode->i_size)
+		return -EINVAL;
 	/* Check whether the maximum file size would be exceeded */
-	if (len > inode->i_sb->s_maxbytes - inode->i_size) {
-		ret = -EFBIG;
-		goto out;
-	}
+	if (len > inode->i_sb->s_maxbytes - inode->i_size)
+		return -EFBIG;
 
 	/* Wait for existing dio to complete */
 	inode_dio_wait(inode);
 
 	ret = file_modified(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -5555,8 +5523,6 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index bb68c851b33ad..6f0b1b0bd1af8 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3997,15 +3997,14 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	loff_t end = offset + length;
 	handle_t *handle;
 	unsigned int credits;
-	int ret = 0;
+	int ret;
 
 	trace_ext4_punch_hole(inode, offset, length, 0);
-
-	inode_lock(inode);
+	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	/* No need to punch hole beyond i_size */
 	if (offset >= inode->i_size)
-		goto out;
+		return 0;
 
 	/*
 	 * If the hole extends beyond i_size, set the hole to end after
@@ -4025,7 +4024,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	if (!IS_ALIGNED(offset | end, sb->s_blocksize)) {
 		ret = ext4_inode_attach_jinode(inode);
 		if (ret < 0)
-			goto out;
+			return ret;
 	}
 
 	/* Wait all existing dio workers, newcomers will block on i_rwsem */
@@ -4033,7 +4032,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 
 	ret = file_modified(file);
 	if (ret)
-		goto out;
+		return ret;
 
 	/*
 	 * Prevent page faults from reinstantiating pages we have released from
@@ -4109,8 +4108,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	ext4_journal_stop(handle);
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
-out:
-	inode_unlock(inode);
 	return ret;
 }
 
-- 
2.39.5



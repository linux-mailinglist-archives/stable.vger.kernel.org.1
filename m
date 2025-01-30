Return-Path: <stable+bounces-111393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C42F4A22EF0
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C98363A5656
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8881E7C08;
	Thu, 30 Jan 2025 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bzM5966I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF36C383;
	Thu, 30 Jan 2025 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738246607; cv=none; b=U2G2dXAOc9BS1WNAbz3q7Wul2JQxtLo9oSfN6HFiy7KallMQ+G2zz3exY58mYyjr8FjgdwmYZXcHqFGUH9uI4EsAMP8DZNBpzw9SO0Ul/N9o+ENY9iii1Ey/XNK9uVHVCQkCaT6kbFd58VfVccVAbFrAVM6ZFsnvRSOKF9Ec270=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738246607; c=relaxed/simple;
	bh=PM4hncYBJ0XgCoRxCaYGsWzHRDnnvIiVgcgTgreILgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qum30HzQk8BSd4h6DaPjXytIFF2UoeDZcXx1NpzWGYrhcUXMp8pw1nt2y4IwL21gUtB6uaBQrNoJhVsXRReEOwPJTJE23lZQCH/vrpm7Flj2LiQRzGxPpyJRU0MKK3M9XAnbA072IhJzgcz7EB8V2QDoB8tDDFMVj6bbi/Tp3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bzM5966I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C5FC4CED2;
	Thu, 30 Jan 2025 14:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738246606;
	bh=PM4hncYBJ0XgCoRxCaYGsWzHRDnnvIiVgcgTgreILgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bzM5966I83l7ig0YeyZlyBpO/eWG/JRpQZPyMn4RV/F0E/XV12RyHojxz8rexv1Ju
	 043F+sxZoYPwPv4wxY3VPx5BeoR099L1XbhC+gIfa3KQM28lTwKr9FgzhYifOYCZCq
	 LAenLiZW3LhfBK1OVmXq4Tx/J4Asidci1jPuVvcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.6 23/43] libfs: Replace simple_offset end-of-directory detection
Date: Thu, 30 Jan 2025 14:59:30 +0100
Message-ID: <20250130133459.836881975@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130133458.903274626@linuxfoundation.org>
References: <20250130133458.903274626@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 68a3a65003145644efcbb651e91db249ccd96281 ]

According to getdents(3), the d_off field in each returned directory
entry points to the next entry in the directory. The d_off field in
the last returned entry in the readdir buffer must contain a valid
offset value, but if it points to an actual directory entry, then
readdir/getdents can loop.

This patch introduces a specific fixed offset value that is placed
in the d_off field of the last entry in a directory. Some user space
applications assume that the EOD offset value is larger than the
offsets of real directory entries, so the largest valid offset value
is reserved for this purpose. This new value is never allocated by
simple_offset_add().

When ->iterate_dir() returns, getdents{64} inserts the ctx->pos
value into the d_off field of the last valid entry in the readdir
buffer. When it hits EOD, offset_readdir() sets ctx->pos to the EOD
offset value so the last entry is updated to point to the EOD marker.

When trying to read the entry at the EOD offset, offset_readdir()
terminates immediately.

It is worth noting that using a Maple tree for directory offset
value allocation does not guarantee a 63-bit range of values --
on platforms where "long" is a 32-bit type, the directory offset
value range is still 0..(2^31 - 1). For broad compatibility with
32-bit user space, the largest tmpfs directory cookie value is now
S32_MAX.

Fixes: 796432efab1e ("libfs: getdents() should return 0 after reaching EOD")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Link: https://lore.kernel.org/r/20241228175522.1854234-5-cel@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ cel: adjusted to apply to origin/linux-6.6.y ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/libfs.c |   37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -239,9 +239,15 @@ const struct inode_operations simple_dir
 };
 EXPORT_SYMBOL(simple_dir_inode_operations);
 
-/* 0 is '.', 1 is '..', so always start with offset 2 or more */
+/* simple_offset_add() never assigns these to a dentry */
 enum {
-	DIR_OFFSET_MIN	= 2,
+	DIR_OFFSET_EOD		= S32_MAX,
+};
+
+/* simple_offset_add() allocation range */
+enum {
+	DIR_OFFSET_MIN		= 2,
+	DIR_OFFSET_MAX		= DIR_OFFSET_EOD - 1,
 };
 
 static void offset_set(struct dentry *dentry, u32 offset)
@@ -278,7 +284,8 @@ void simple_offset_init(struct offset_ct
  */
 int simple_offset_add(struct offset_ctx *octx, struct dentry *dentry)
 {
-	static const struct xa_limit limit = XA_LIMIT(DIR_OFFSET_MIN, U32_MAX);
+	static const struct xa_limit limit = XA_LIMIT(DIR_OFFSET_MIN,
+						      DIR_OFFSET_MAX);
 	u32 offset;
 	int ret;
 
@@ -442,8 +449,6 @@ static loff_t offset_dir_llseek(struct f
 		return -EINVAL;
 	}
 
-	/* In this case, ->private_data is protected by f_pos_lock */
-	file->private_data = NULL;
 	return vfs_setpos(file, offset, U32_MAX);
 }
 
@@ -453,7 +458,7 @@ static struct dentry *offset_find_next(s
 	XA_STATE(xas, &octx->xa, offset);
 
 	rcu_read_lock();
-	child = xas_next_entry(&xas, U32_MAX);
+	child = xas_next_entry(&xas, DIR_OFFSET_MAX);
 	if (!child)
 		goto out;
 	spin_lock(&child->d_lock);
@@ -474,7 +479,7 @@ static bool offset_dir_emit(struct dir_c
 			  inode->i_ino, fs_umode_to_dtype(inode->i_mode));
 }
 
-static void *offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
+static void offset_iterate_dir(struct inode *inode, struct dir_context *ctx)
 {
 	struct offset_ctx *octx = inode->i_op->get_offset_ctx(inode);
 	struct dentry *dentry;
@@ -482,7 +487,7 @@ static void *offset_iterate_dir(struct i
 	while (true) {
 		dentry = offset_find_next(octx, ctx->pos);
 		if (!dentry)
-			return ERR_PTR(-ENOENT);
+			goto out_eod;
 
 		if (!offset_dir_emit(ctx, dentry)) {
 			dput(dentry);
@@ -492,7 +497,10 @@ static void *offset_iterate_dir(struct i
 		ctx->pos = dentry2offset(dentry) + 1;
 		dput(dentry);
 	}
-	return NULL;
+	return;
+
+out_eod:
+	ctx->pos = DIR_OFFSET_EOD;
 }
 
 /**
@@ -512,6 +520,8 @@ static void *offset_iterate_dir(struct i
  *
  * On return, @ctx->pos contains an offset that will read the next entry
  * in this directory when offset_readdir() is called again with @ctx.
+ * Caller places this value in the d_off field of the last entry in the
+ * user's buffer.
  *
  * Return values:
  *   %0 - Complete
@@ -524,13 +534,8 @@ static int offset_readdir(struct file *f
 
 	if (!dir_emit_dots(file, ctx))
 		return 0;
-
-	/* In this case, ->private_data is protected by f_pos_lock */
-	if (ctx->pos == DIR_OFFSET_MIN)
-		file->private_data = NULL;
-	else if (file->private_data == ERR_PTR(-ENOENT))
-		return 0;
-	file->private_data = offset_iterate_dir(d_inode(dir), ctx);
+	if (ctx->pos != DIR_OFFSET_EOD)
+		offset_iterate_dir(d_inode(dir), ctx);
 	return 0;
 }
 




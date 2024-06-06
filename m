Return-Path: <stable+bounces-48350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 455298FE89F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15601F2315C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4EFC196D90;
	Thu,  6 Jun 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="chE1lbLW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33C7197534;
	Thu,  6 Jun 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717682916; cv=none; b=UeFZB1WdTbX13snnKGP49DOFACokDwjFvbHzBf7CV1tyIwJTUHNoEVHD7/gmTuUqorzwdL6WHUcDoAmWi6T/j5yss6NDAj7URpGf9eAPEmds48y5786UY+xZADjiPifmO9gnOVpu7Dpx13EANmv+Ntx4hcAankfAowaFVrDD8fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717682916; c=relaxed/simple;
	bh=JguUV0I2z7XYKHcj9c4IYyyWhnN0OP7QQDgCXaUvaTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y7qt20sKe4iiIUhCWz5+hezSxMPiNvsW1w0QZoD0PAuDCidOk1DfKvUebZzW84mKX4+dVtWAUJZynQZshzXNHqUZjHhke7gu7foCBmiEN8OmM+E1vMqXePtM51vyFy1NxcoX+hkyXAUHvAaonHx5fyU+3VnCi1v4+XXWOcTt+l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=chE1lbLW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB62C2BD10;
	Thu,  6 Jun 2024 14:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717682916;
	bh=JguUV0I2z7XYKHcj9c4IYyyWhnN0OP7QQDgCXaUvaTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=chE1lbLWV6IENO7TZ1FyiJKQtL6RSn3L7ppLQx0SnQVAR/Ssqmk5qkLDs2p0d7qxw
	 7RTLCs+HR3qUgP62jNaAO2Z/kL49GF3bhb9Mv2DG4xPhXVV6h5W3uEVrDqgZprMgSG
	 ou1QHZ8P1OBRJMpnlVD0KbZ+NNWJBWFdiJES89z0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 048/374] remove call_{read,write}_iter() functions
Date: Thu,  6 Jun 2024 16:00:27 +0200
Message-ID: <20240606131653.425813661@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
References: <20240606131651.683718371@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miklos Szeredi <mszeredi@redhat.com>

[ Upstream commit 7c98f7cb8fda964fbc60b9307ad35e94735fa35f ]

These have no clear purpose.  This is effectively a revert of commit
bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()").

The patch was created with the help of a coccinelle script.

Fixes: bb7462b6fd64 ("vfs: use helpers for calling f_op->{read,write}_iter()")
Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c              |  4 ++--
 drivers/target/target_core_file.c |  4 ++--
 fs/aio.c                          |  4 ++--
 fs/read_write.c                   | 12 ++++++------
 fs/splice.c                       |  4 ++--
 include/linux/fs.h                | 12 ------------
 io_uring/rw.c                     |  4 ++--
 7 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 28a95fd366fea..93780f41646b7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -445,9 +445,9 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
 	cmd->iocb.ki_ioprio = IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);
 
 	if (rw == ITER_SOURCE)
-		ret = call_write_iter(file, &cmd->iocb, &iter);
+		ret = file->f_op->write_iter(&cmd->iocb, &iter);
 	else
-		ret = call_read_iter(file, &cmd->iocb, &iter);
+		ret = file->f_op->read_iter(&cmd->iocb, &iter);
 
 	lo_rw_aio_do_completion(cmd);
 
diff --git a/drivers/target/target_core_file.c b/drivers/target/target_core_file.c
index 4d447520bab87..94e6cd4e7e43d 100644
--- a/drivers/target/target_core_file.c
+++ b/drivers/target/target_core_file.c
@@ -299,9 +299,9 @@ fd_execute_rw_aio(struct se_cmd *cmd, struct scatterlist *sgl, u32 sgl_nents,
 		aio_cmd->iocb.ki_flags |= IOCB_DSYNC;
 
 	if (is_write)
-		ret = call_write_iter(file, &aio_cmd->iocb, &iter);
+		ret = file->f_op->write_iter(&aio_cmd->iocb, &iter);
 	else
-		ret = call_read_iter(file, &aio_cmd->iocb, &iter);
+		ret = file->f_op->read_iter(&aio_cmd->iocb, &iter);
 
 	if (ret != -EIOCBQUEUED)
 		cmd_rw_aio_complete(&aio_cmd->iocb, ret);
diff --git a/fs/aio.c b/fs/aio.c
index 0f4f531c97800..744c7d1562dce 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1605,7 +1605,7 @@ static int aio_read(struct kiocb *req, const struct iocb *iocb,
 		return ret;
 	ret = rw_verify_area(READ, file, &req->ki_pos, iov_iter_count(&iter));
 	if (!ret)
-		aio_rw_done(req, call_read_iter(file, req, &iter));
+		aio_rw_done(req, file->f_op->read_iter(req, &iter));
 	kfree(iovec);
 	return ret;
 }
@@ -1636,7 +1636,7 @@ static int aio_write(struct kiocb *req, const struct iocb *iocb,
 		if (S_ISREG(file_inode(file)->i_mode))
 			kiocb_start_write(req);
 		req->ki_flags |= IOCB_WRITE;
-		aio_rw_done(req, call_write_iter(file, req, &iter));
+		aio_rw_done(req, file->f_op->write_iter(req, &iter));
 	}
 	kfree(iovec);
 	return ret;
diff --git a/fs/read_write.c b/fs/read_write.c
index d4c036e82b6c3..2de7f6adb33d3 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -392,7 +392,7 @@ static ssize_t new_sync_read(struct file *filp, char __user *buf, size_t len, lo
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_ubuf(&iter, ITER_DEST, buf, len);
 
-	ret = call_read_iter(filp, &kiocb, &iter);
+	ret = filp->f_op->read_iter(&kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
 	if (ppos)
 		*ppos = kiocb.ki_pos;
@@ -494,7 +494,7 @@ static ssize_t new_sync_write(struct file *filp, const char __user *buf, size_t
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 	iov_iter_ubuf(&iter, ITER_SOURCE, (void __user *)buf, len);
 
-	ret = call_write_iter(filp, &kiocb, &iter);
+	ret = filp->f_op->write_iter(&kiocb, &iter);
 	BUG_ON(ret == -EIOCBQUEUED);
 	if (ret > 0 && ppos)
 		*ppos = kiocb.ki_pos;
@@ -736,9 +736,9 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	kiocb.ki_pos = (ppos ? *ppos : 0);
 
 	if (type == READ)
-		ret = call_read_iter(filp, &kiocb, iter);
+		ret = filp->f_op->read_iter(&kiocb, iter);
 	else
-		ret = call_write_iter(filp, &kiocb, iter);
+		ret = filp->f_op->write_iter(&kiocb, iter);
 	BUG_ON(ret == -EIOCBQUEUED);
 	if (ppos)
 		*ppos = kiocb.ki_pos;
@@ -799,7 +799,7 @@ ssize_t vfs_iocb_iter_read(struct file *file, struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
-	ret = call_read_iter(file, iocb, iter);
+	ret = file->f_op->read_iter(iocb, iter);
 out:
 	if (ret >= 0)
 		fsnotify_access(file);
@@ -860,7 +860,7 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 		return ret;
 
 	kiocb_start_write(iocb);
-	ret = call_write_iter(file, iocb, iter);
+	ret = file->f_op->write_iter(iocb, iter);
 	if (ret != -EIOCBQUEUED)
 		kiocb_end_write(iocb);
 	if (ret > 0)
diff --git a/fs/splice.c b/fs/splice.c
index 218e24b1ac401..60aed8de21f85 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -362,7 +362,7 @@ ssize_t copy_splice_read(struct file *in, loff_t *ppos,
 	iov_iter_bvec(&to, ITER_DEST, bv, npages, len);
 	init_sync_kiocb(&kiocb, in);
 	kiocb.ki_pos = *ppos;
-	ret = call_read_iter(in, &kiocb, &to);
+	ret = in->f_op->read_iter(&kiocb, &to);
 
 	if (ret > 0) {
 		keep = DIV_ROUND_UP(ret, PAGE_SIZE);
@@ -740,7 +740,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len - left);
 		init_sync_kiocb(&kiocb, out);
 		kiocb.ki_pos = sd.pos;
-		ret = call_write_iter(out, &kiocb, &from);
+		ret = out->f_op->write_iter(&kiocb, &from);
 		sd.pos = kiocb.ki_pos;
 		if (ret <= 0)
 			break;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b09f141321105..d20b5cbbf65d0 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2098,18 +2098,6 @@ struct inode_operations {
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
 } ____cacheline_aligned;
 
-static inline ssize_t call_read_iter(struct file *file, struct kiocb *kio,
-				     struct iov_iter *iter)
-{
-	return file->f_op->read_iter(kio, iter);
-}
-
-static inline ssize_t call_write_iter(struct file *file, struct kiocb *kio,
-				      struct iov_iter *iter)
-{
-	return file->f_op->write_iter(kio, iter);
-}
-
 static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	return file->f_op->mmap(file, vma);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index c8d48287439e5..29f4aa153ab9b 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -701,7 +701,7 @@ static inline int io_iter_do_read(struct io_rw *rw, struct iov_iter *iter)
 	struct file *file = rw->kiocb.ki_filp;
 
 	if (likely(file->f_op->read_iter))
-		return call_read_iter(file, &rw->kiocb, iter);
+		return file->f_op->read_iter(&rw->kiocb, iter);
 	else if (file->f_op->read)
 		return loop_rw_iter(READ, rw, iter);
 	else
@@ -1054,7 +1054,7 @@ int io_write(struct io_kiocb *req, unsigned int issue_flags)
 	kiocb->ki_flags |= IOCB_WRITE;
 
 	if (likely(req->file->f_op->write_iter))
-		ret2 = call_write_iter(req->file, kiocb, &s->iter);
+		ret2 = req->file->f_op->write_iter(kiocb, &s->iter);
 	else if (req->file->f_op->write)
 		ret2 = loop_rw_iter(WRITE, rw, &s->iter);
 	else
-- 
2.43.0





Return-Path: <stable+bounces-130881-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B491EA80703
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EAF4883619
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150D26B093;
	Tue,  8 Apr 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eLEGL7lw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6A21B87CF;
	Tue,  8 Apr 2025 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114904; cv=none; b=oIzC4schJCxksaZRRo+cg0N4/+dHdNaMCFt2/rJ8Z9SrDvhcyp/iDFM7i9CzgfxRPO4EwpH5XsgPY4U95Olrowptk7RmrER+5FAeGWklAZNHxcfuQrN6iF1xWx44N2qFa4jAUgceyki6FY9J9judBjdSkPOnWOq35cmmdf/AvGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114904; c=relaxed/simple;
	bh=w2Za/xOOOWIf1LYGJ0SnpHbfC3khOsgDQUnpJzOoJMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qXX6Qg0uYyrgWFbV4BymSValaV/NuDXmfhvozf6HgrIGjQBNP0gECRCFO/icvVywuFv4UhHYcudu0A0CEooX/qd5BGUo6KApQLn0DOgCv5gbbLoXBxFdxxsMtalyywOjkZLpX2x+3xuMec1Uf2GU1jIBWHSb4FanbF+1Nn5Z6Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eLEGL7lw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C764C4CEE5;
	Tue,  8 Apr 2025 12:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114904;
	bh=w2Za/xOOOWIf1LYGJ0SnpHbfC3khOsgDQUnpJzOoJMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLEGL7lwoBU6wUOPiVng0iB6jo4UWOR9ffdQ1+OrwDCCYBbDpMVU9UN2t8jf5ON7e
	 cHfBCXVZQpT3DXBInndCprDV1oDm2Fg8178C7HmKjSoPaZKLwNpocEkNAfnox6zTKN
	 RUN5jQwuUV5z3b1vjpAy6U+tc2ElZETartMxEvSQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yuezhang Mo <Yuezhang.Mo@sony.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 278/499] exfat: fix missing shutdown check
Date: Tue,  8 Apr 2025 12:48:10 +0200
Message-ID: <20250408104858.152249815@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yuezhang Mo <Yuezhang.Mo@sony.com>

[ Upstream commit 47e35366bc6fa3cf189a8305bce63992495f3efa ]

xfstests generic/730 test failed because after deleting the device
that still had dirty data, the file could still be read without
returning an error. The reason is the missing shutdown check in
->read_iter.

I also noticed that shutdown checks were missing from ->write_iter,
->splice_read, and ->mmap. This commit adds shutdown checks to all
of them.

Fixes: f761fcdd289d ("exfat: Implement sops->shutdown and ioctl")
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/exfat/file.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 807349d8ea050..841a5b18e3dfd 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -582,6 +582,9 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	loff_t pos = iocb->ki_pos;
 	loff_t valid_size;
 
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
 	inode_lock(inode);
 
 	valid_size = ei->valid_size;
@@ -635,6 +638,16 @@ static ssize_t exfat_file_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 	return ret;
 }
 
+static ssize_t exfat_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
+{
+	struct inode *inode = file_inode(iocb->ki_filp);
+
+	if (unlikely(exfat_forced_shutdown(inode->i_sb)))
+		return -EIO;
+
+	return generic_file_read_iter(iocb, iter);
+}
+
 static vm_fault_t exfat_page_mkwrite(struct vm_fault *vmf)
 {
 	int err;
@@ -672,14 +685,26 @@ static const struct vm_operations_struct exfat_file_vm_ops = {
 
 static int exfat_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	if (unlikely(exfat_forced_shutdown(file_inode(file)->i_sb)))
+		return -EIO;
+
 	file_accessed(file);
 	vma->vm_ops = &exfat_file_vm_ops;
 	return 0;
 }
 
+static ssize_t exfat_splice_read(struct file *in, loff_t *ppos,
+		struct pipe_inode_info *pipe, size_t len, unsigned int flags)
+{
+	if (unlikely(exfat_forced_shutdown(file_inode(in)->i_sb)))
+		return -EIO;
+
+	return filemap_splice_read(in, ppos, pipe, len, flags);
+}
+
 const struct file_operations exfat_file_operations = {
 	.llseek		= generic_file_llseek,
-	.read_iter	= generic_file_read_iter,
+	.read_iter	= exfat_file_read_iter,
 	.write_iter	= exfat_file_write_iter,
 	.unlocked_ioctl = exfat_ioctl,
 #ifdef CONFIG_COMPAT
@@ -687,7 +712,7 @@ const struct file_operations exfat_file_operations = {
 #endif
 	.mmap		= exfat_file_mmap,
 	.fsync		= exfat_file_fsync,
-	.splice_read	= filemap_splice_read,
+	.splice_read	= exfat_splice_read,
 	.splice_write	= iter_file_splice_write,
 };
 
-- 
2.39.5





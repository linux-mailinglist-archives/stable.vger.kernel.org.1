Return-Path: <stable+bounces-111697-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5575DA2305A
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 15:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEAE1882FF5
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC451BB6BC;
	Thu, 30 Jan 2025 14:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rlNY1nxq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FDA13B7A3;
	Thu, 30 Jan 2025 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738247493; cv=none; b=J352qiEp6n4wIxlihxd8oRNLDq0n7b79wStSgdw9hA+VNImtMYNt9FVojiFrzn9Xq32bZ/bkwJUnchYkRQNedVARYq3C4MJK9gHPwP+SmvIjdm2Bqes7U34NZCOU2NmGi3lgHlD3peizFeZoudWIHcxjdSzTkASCMA/NH4deRyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738247493; c=relaxed/simple;
	bh=uIWGd4s6Bvc9MqAZoxg6jpKgZhLfc/6RHzGBTERy6TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eWdRK7Nn7m9rDhTIRtWfZNjLssNB7oZ9GeeJ3YNBnWWIXpeIJHRQgi9Cid6iVwIVOyODL9WU27u6seWh3B2Jes6QLf+mJEuRkSROuJkygOM+3nzNioVZ7HpBREA9z7vcHHzR6olYoBZCD4NA93uL2NPtPeqYe1n3iYTz68DC680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rlNY1nxq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF76C4CED2;
	Thu, 30 Jan 2025 14:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738247492;
	bh=uIWGd4s6Bvc9MqAZoxg6jpKgZhLfc/6RHzGBTERy6TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rlNY1nxq2ljs6uOosNwbA5VDkTtCUGUD6BXsE+Zp2g7+TZriDceuqAtWJcj6lw5Kg
	 /CGdVg6tPMwZ488+xUjVIHB17Z8Fr8FOvSQv3STCm6EfAowqXih42xYQlU14K/E76X
	 AceMcfsrSCqbTKjq7mh0tgqh0QTvwyXmS3hmY0aU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Catherine Hoang <catherine.hoang@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 20/49] xfs: allow read IO and FICLONE to run concurrently
Date: Thu, 30 Jan 2025 15:01:56 +0100
Message-ID: <20250130140134.651541857@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250130140133.825446496@linuxfoundation.org>
References: <20250130140133.825446496@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Catherine Hoang <catherine.hoang@oracle.com>

[ Upstream commit 14a537983b228cb050ceca3a5b743d01315dc4aa ]

One of our VM cluster management products needs to snapshot KVM image
files so that they can be restored in case of failure. Snapshotting is
done by redirecting VM disk writes to a sidecar file and using reflink
on the disk image, specifically the FICLONE ioctl as used by
"cp --reflink". Reflink locks the source and destination files while it
operates, which means that reads from the main vm disk image are blocked,
causing the vm to stall. When an image file is heavily fragmented, the
copy process could take several minutes. Some of the vm image files have
50-100 million extent records, and duplicating that much metadata locks
the file for 30 minutes or more. Having activities suspended for such
a long time in a cluster node could result in node eviction.

Clone operations and read IO do not change any data in the source file,
so they should be able to run concurrently. Demote the exclusive locks
taken by FICLONE to shared locks to allow reads while cloning. While a
clone is in progress, writes will take the IOLOCK_EXCL, so they block
until the clone completes.

Link: https://lore.kernel.org/linux-xfs/8911B94D-DD29-4D6E-B5BC-32EAF1866245@oracle.com/
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_file.c    |   63 ++++++++++++++++++++++++++++++++++++++++-----------
 fs/xfs/xfs_inode.c   |   17 +++++++++++++
 fs/xfs/xfs_inode.h   |    9 +++++++
 fs/xfs/xfs_reflink.c |    4 +++
 4 files changed, 80 insertions(+), 13 deletions(-)

--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -214,6 +214,43 @@ xfs_ilock_iocb(
 	return 0;
 }
 
+static int
+xfs_ilock_iocb_for_write(
+	struct kiocb		*iocb,
+	unsigned int		*lock_mode)
+{
+	ssize_t			ret;
+	struct xfs_inode	*ip = XFS_I(file_inode(iocb->ki_filp));
+
+	ret = xfs_ilock_iocb(iocb, *lock_mode);
+	if (ret)
+		return ret;
+
+	if (*lock_mode == XFS_IOLOCK_EXCL)
+		return 0;
+	if (!xfs_iflags_test(ip, XFS_IREMAPPING))
+		return 0;
+
+	xfs_iunlock(ip, *lock_mode);
+	*lock_mode = XFS_IOLOCK_EXCL;
+	return xfs_ilock_iocb(iocb, *lock_mode);
+}
+
+static unsigned int
+xfs_ilock_for_write_fault(
+	struct xfs_inode	*ip)
+{
+	/* get a shared lock if no remapping in progress */
+	xfs_ilock(ip, XFS_MMAPLOCK_SHARED);
+	if (!xfs_iflags_test(ip, XFS_IREMAPPING))
+		return XFS_MMAPLOCK_SHARED;
+
+	/* wait for remapping to complete */
+	xfs_iunlock(ip, XFS_MMAPLOCK_SHARED);
+	xfs_ilock(ip, XFS_MMAPLOCK_EXCL);
+	return XFS_MMAPLOCK_EXCL;
+}
+
 STATIC ssize_t
 xfs_file_dio_read(
 	struct kiocb		*iocb,
@@ -523,7 +560,7 @@ xfs_file_dio_write_aligned(
 	unsigned int		iolock = XFS_IOLOCK_SHARED;
 	ssize_t			ret;
 
-	ret = xfs_ilock_iocb(iocb, iolock);
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
 	if (ret)
 		return ret;
 	ret = xfs_file_write_checks(iocb, from, &iolock);
@@ -590,7 +627,7 @@ retry_exclusive:
 		flags = IOMAP_DIO_FORCE_WAIT;
 	}
 
-	ret = xfs_ilock_iocb(iocb, iolock);
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
 	if (ret)
 		return ret;
 
@@ -1158,7 +1195,7 @@ xfs_file_remap_range(
 	if (xfs_file_sync_writes(file_in) || xfs_file_sync_writes(file_out))
 		xfs_log_force_inode(dest);
 out_unlock:
-	xfs_iunlock2_io_mmap(src, dest);
+	xfs_iunlock2_remapping(src, dest);
 	if (ret)
 		trace_xfs_reflink_remap_range_error(dest, ret, _RET_IP_);
 	/*
@@ -1313,6 +1350,7 @@ __xfs_filemap_fault(
 	struct inode		*inode = file_inode(vmf->vma->vm_file);
 	struct xfs_inode	*ip = XFS_I(inode);
 	vm_fault_t		ret;
+	unsigned int		lock_mode = 0;
 
 	trace_xfs_filemap_fault(ip, pe_size, write_fault);
 
@@ -1321,25 +1359,24 @@ __xfs_filemap_fault(
 		file_update_time(vmf->vma->vm_file);
 	}
 
+	if (IS_DAX(inode) || write_fault)
+		lock_mode = xfs_ilock_for_write_fault(XFS_I(inode));
+
 	if (IS_DAX(inode)) {
 		pfn_t pfn;
 
-		xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 		ret = xfs_dax_fault(vmf, pe_size, write_fault, &pfn);
 		if (ret & VM_FAULT_NEEDDSYNC)
 			ret = dax_finish_sync_fault(vmf, pe_size, pfn);
-		xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
+	} else if (write_fault) {
+		ret = iomap_page_mkwrite(vmf, &xfs_page_mkwrite_iomap_ops);
 	} else {
-		if (write_fault) {
-			xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
-			ret = iomap_page_mkwrite(vmf,
-					&xfs_page_mkwrite_iomap_ops);
-			xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
-		} else {
-			ret = filemap_fault(vmf);
-		}
+		ret = filemap_fault(vmf);
 	}
 
+	if (lock_mode)
+		xfs_iunlock(XFS_I(inode), lock_mode);
+
 	if (write_fault)
 		sb_end_pagefault(inode->i_sb);
 	return ret;
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3644,6 +3644,23 @@ xfs_iunlock2_io_mmap(
 		inode_unlock(VFS_I(ip1));
 }
 
+/* Drop the MMAPLOCK and the IOLOCK after a remap completes. */
+void
+xfs_iunlock2_remapping(
+	struct xfs_inode	*ip1,
+	struct xfs_inode	*ip2)
+{
+	xfs_iflags_clear(ip1, XFS_IREMAPPING);
+
+	if (ip1 != ip2)
+		xfs_iunlock(ip1, XFS_MMAPLOCK_SHARED);
+	xfs_iunlock(ip2, XFS_MMAPLOCK_EXCL);
+
+	if (ip1 != ip2)
+		inode_unlock_shared(VFS_I(ip1));
+	inode_unlock(VFS_I(ip2));
+}
+
 /*
  * Reload the incore inode list for this inode.  Caller should ensure that
  * the link count cannot change, either by taking ILOCK_SHARED or otherwise
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -347,6 +347,14 @@ static inline bool xfs_inode_has_large_e
 /* Quotacheck is running but inode has not been added to quota counts. */
 #define XFS_IQUOTAUNCHECKED	(1 << 14)
 
+/*
+ * Remap in progress. Callers that wish to update file data while
+ * holding a shared IOLOCK or MMAPLOCK must drop the lock and retake
+ * the lock in exclusive mode. Relocking the file will block until
+ * IREMAPPING is cleared.
+ */
+#define XFS_IREMAPPING		(1U << 15)
+
 /* All inode state flags related to inode reclaim. */
 #define XFS_ALL_IRECLAIM_FLAGS	(XFS_IRECLAIMABLE | \
 				 XFS_IRECLAIM | \
@@ -595,6 +603,7 @@ void xfs_end_io(struct work_struct *work
 
 int xfs_ilock2_io_mmap(struct xfs_inode *ip1, struct xfs_inode *ip2);
 void xfs_iunlock2_io_mmap(struct xfs_inode *ip1, struct xfs_inode *ip2);
+void xfs_iunlock2_remapping(struct xfs_inode *ip1, struct xfs_inode *ip2);
 
 static inline bool
 xfs_inode_unlinked_incomplete(
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1539,6 +1539,10 @@ xfs_reflink_remap_prep(
 	if (ret)
 		goto out_unlock;
 
+	xfs_iflags_set(src, XFS_IREMAPPING);
+	if (inode_in != inode_out)
+		xfs_ilock_demote(src, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
+
 	return 0;
 out_unlock:
 	xfs_iunlock2_io_mmap(src, dest);




Return-Path: <stable+bounces-111220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC61A22435
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 19:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 907573A9606
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 18:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF0D1E102E;
	Wed, 29 Jan 2025 18:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAIxa1zO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295711E0DFE
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738176463; cv=none; b=eP6kuGrn3YmuXAI3cci/rahu8AyypiqK8+tRaF/gEx6U8gu4l88Ynb084JmV5hD1Hr2RLUsqWWxgp2/gR93A2oSvbGmkV+forTcw7lYYuvTByphgHNZHJiSxBFnblcVSCVxP8egqlJpGBrMAHprnqpDku1prrFJXUZLdUPg8CAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738176463; c=relaxed/simple;
	bh=HsRPaOldrwPWdOSxDtRrVEE2qpUiEsSLchbj2YYc998=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DY6jxxJiw1iEJcZrTyUaO2BRsfjvzNsUcpJwtgQdkEcAfM1Qe6YafxENvqYQ4UbVcsS4LDjUvKec1FHpXfc2Nl9INBMohxMCF7oVe6bN75AXb6QujfLQX1QL/sIBJjQiuaOfdG3WMlP+YuZwEUmPWXzFiBCSL3Md7SenucyLF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SAIxa1zO; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2165cb60719so130473215ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738176461; x=1738781261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3n7OrBNqoOEdNIhYXeJ+EJjv0DnK537H8Sy2EB3xTEY=;
        b=SAIxa1zOoefR2PTfE+z3Bw/fHx6KHVL1/u6myKm8CKwHBkKBSaQU612G18TxswbDjj
         /j2YESIl2mYuDqoLPj07vhKTGeYjDJZipBRlGY5CBcydOUfbKa3qpIxN46L+tnmBRjMN
         hBbmNZQFyALOhA6hTEApalVi+feKa4xK99P4Tocek8f/pah2UKB3XgTS5VUtCg7LvFSn
         0KNm+WpncQddv8fxlE4KECyYoW0dG73SOqBvJdRnMK22fZ8OAAI/BYgnIWB+cQdE6vA7
         GeWAwBH8HrkdvN+ijIke8ZSPzcsy8HJ3C/UlA0uEw9A4BpmJhfKGAxZutOVBqxWEsmZK
         Pa+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738176461; x=1738781261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3n7OrBNqoOEdNIhYXeJ+EJjv0DnK537H8Sy2EB3xTEY=;
        b=t/bn8EwLSS15sXqchcoLqR2Zo1WQJTOa3u8VUy5lybz068RXCNZKZHxk66pAzhBG4n
         HnctUg9kU3U2PX/nwKuqBHDr3izCc6cJK6yVnsxLsCKTFaiWKLso54C9HtksqE00txmI
         3ixDinAV/x/47xjLLgRYqo/qj5+uMB87s8BKaqehgV7t+uMN4rWCwhZBMiIMoZ06e/jg
         LG5O1XEJX3a+Ul6/OMz5Qvi3eu79ehsGxyHbbW4dRW8MqX5Iok9V7QLs2ZKZyitJO5fE
         pB8nNzS/7FdHSPeFAeQLRI2Rto6SWvelH0j7/mfxROpIvoqt1mgKec9VWeRU6LCjloZK
         BJwQ==
X-Gm-Message-State: AOJu0YxYQ6N2LhuA0p+pqyCkSzkcAXdLywK27uKsJs6fZPV2WLX0H+6j
	VO9aRzvO0j2o6QS0QcBIa9IoWGE0cHIHyq9Lt5IJaN/AW8moetY7GlGO91na
X-Gm-Gg: ASbGncvUrB4JWE1/dPJyh8UY0yTvmZ3gumWyzoTY1BnRLIAMAdYVD2gJkvN7C37kpjc
	GaWyFFqaEX2sB/9QI4TvOvazITsHApEioWS7/H4TooWL8Dqg3KOvqPMv9Cw/t0m7g4Lv7UfKouA
	YcyaWAQ+am/7XIlfr1wg5dVgQDGWJaQML3qrx+B1o2OI/JGVrYMSIPQAdc+gdPKbcHUSH04FY6e
	H1PENtSDjVvLCU4wf/D8NW3pcBHal45sL1bfd5QB6VDlPfzkozIA9G4PVckrllOn6ItERHcHFrA
	8KzKx3AYKxgKgrGtcsNhsQWtDT79FLDssedB1jL67cM=
X-Google-Smtp-Source: AGHT+IESx/Tf9vc1iCKYUSO2yK7rHxh2NGoUG2tdgGN4wbRpmHgZPrFMozZhxSdLxfKgVAIMvAv2dg==
X-Received: by 2002:a17:902:c951:b0:215:9bc2:42ec with SMTP id d9443c01a7336-21dd7de729bmr54757505ad.47.1738176459732;
        Wed, 29 Jan 2025 10:47:39 -0800 (PST)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:fbc6:64ef:cffe:1cc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da414151fsm103248795ad.121.2025.01.29.10.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 10:47:39 -0800 (PST)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	amir73il@gmail.com,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 09/19] xfs: allow read IO and FICLONE to run concurrently
Date: Wed, 29 Jan 2025 10:47:07 -0800
Message-ID: <20250129184717.80816-10-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
In-Reply-To: <20250129184717.80816-1-leah.rumancik@gmail.com>
References: <20250129184717.80816-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/xfs/xfs_file.c    | 63 +++++++++++++++++++++++++++++++++++---------
 fs/xfs/xfs_inode.c   | 17 ++++++++++++
 fs/xfs/xfs_inode.h   |  9 +++++++
 fs/xfs/xfs_reflink.c |  4 +++
 4 files changed, 80 insertions(+), 13 deletions(-)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 8de40cf63a5b..821cb86a83bd 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -212,10 +212,47 @@ xfs_ilock_iocb(
 	}
 
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
 	struct iov_iter		*to)
 {
@@ -521,11 +558,11 @@ xfs_file_dio_write_aligned(
 	struct iov_iter		*from)
 {
 	unsigned int		iolock = XFS_IOLOCK_SHARED;
 	ssize_t			ret;
 
-	ret = xfs_ilock_iocb(iocb, iolock);
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
 	if (ret)
 		return ret;
 	ret = xfs_file_write_checks(iocb, from, &iolock);
 	if (ret)
 		goto out_unlock;
@@ -588,11 +625,11 @@ xfs_file_dio_write_unaligned(
 retry_exclusive:
 		iolock = XFS_IOLOCK_EXCL;
 		flags = IOMAP_DIO_FORCE_WAIT;
 	}
 
-	ret = xfs_ilock_iocb(iocb, iolock);
+	ret = xfs_ilock_iocb_for_write(iocb, &iolock);
 	if (ret)
 		return ret;
 
 	/*
 	 * We can't properly handle unaligned direct I/O to reflink files yet,
@@ -1156,11 +1193,11 @@ xfs_file_remap_range(
 		goto out_unlock;
 
 	if (xfs_file_sync_writes(file_in) || xfs_file_sync_writes(file_out))
 		xfs_log_force_inode(dest);
 out_unlock:
-	xfs_iunlock2_io_mmap(src, dest);
+	xfs_iunlock2_remapping(src, dest);
 	if (ret)
 		trace_xfs_reflink_remap_range_error(dest, ret, _RET_IP_);
 	/*
 	 * If the caller did not set CAN_SHORTEN, then it is not prepared to
 	 * handle partial results -- either the whole remap succeeds, or we
@@ -1311,37 +1348,37 @@ __xfs_filemap_fault(
 	bool			write_fault)
 {
 	struct inode		*inode = file_inode(vmf->vma->vm_file);
 	struct xfs_inode	*ip = XFS_I(inode);
 	vm_fault_t		ret;
+	unsigned int		lock_mode = 0;
 
 	trace_xfs_filemap_fault(ip, pe_size, write_fault);
 
 	if (write_fault) {
 		sb_start_pagefault(inode->i_sb);
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
 }
 
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 1d32823d5099..dc84c75be852 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -3642,10 +3642,27 @@ xfs_iunlock2_io_mmap(
 	inode_unlock(VFS_I(ip2));
 	if (ip1 != ip2)
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
  * preventing other threads from executing.
  */
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 85395ad2859c..3a81477c7797 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -345,10 +345,18 @@ static inline bool xfs_inode_has_large_extent_counts(struct xfs_inode *ip)
 #define XFS_INACTIVATING	(1 << 13)
 
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
 				 XFS_NEED_INACTIVE | \
 				 XFS_INACTIVATING)
@@ -593,10 +601,11 @@ bool xfs_inode_needs_inactive(struct xfs_inode *ip);
 
 void xfs_end_io(struct work_struct *work);
 
 int xfs_ilock2_io_mmap(struct xfs_inode *ip1, struct xfs_inode *ip2);
 void xfs_iunlock2_io_mmap(struct xfs_inode *ip1, struct xfs_inode *ip2);
+void xfs_iunlock2_remapping(struct xfs_inode *ip1, struct xfs_inode *ip2);
 
 static inline bool
 xfs_inode_unlinked_incomplete(
 	struct xfs_inode	*ip)
 {
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index fe46bce8cae6..004f5a0444be 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1537,10 +1537,14 @@ xfs_reflink_remap_prep(
 		ret = xfs_flush_unmap_range(dest, pos_out, *len);
 	}
 	if (ret)
 		goto out_unlock;
 
+	xfs_iflags_set(src, XFS_IREMAPPING);
+	if (inode_in != inode_out)
+		xfs_ilock_demote(src, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
+
 	return 0;
 out_unlock:
 	xfs_iunlock2_io_mmap(src, dest);
 	return ret;
 }
-- 
2.48.1.362.g079036d154-goog



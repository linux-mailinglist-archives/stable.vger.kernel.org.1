Return-Path: <stable+bounces-142202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD34AAE97B
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F58D1C278A8
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD7431FECCD;
	Wed,  7 May 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aZgvFmQV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9297BFC1D;
	Wed,  7 May 2025 18:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746643523; cv=none; b=Jcc96gcR+lvG3+aLpoCIjtPZstklXBWOQAEUYGL1Qoehz0X4Thr2WBHVxXsQ6mlrS6//Zz8sQEhNBgSeeuNdLbt0Udz8jMTRWQV22PJIqCHbGHaIJsneH6swAraksgp24KOmiCMNv7DwVJY2vMc1gD03RV2qD5/5tYi8cNs8zFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746643523; c=relaxed/simple;
	bh=rq8iAA+QerNDCld7vGn/zQBx5m0b3KJbdk/1zHRSgL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4rOR7ngydCdJOPZXhmDQrcCJOLZ0FKE75+EqN1gORXKGk0yFy34M3AGFXHpmkDZIpBnnmdZGU0aWufWwJT5wNU6FyOisQdzKcjHf77UChJ7fUQWxGT8imNLbF98aVdamhAmJu/PTyQgt1/Krxw2KSyIz0Q7YqJt+dpGA17RxUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aZgvFmQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B27C4CEE2;
	Wed,  7 May 2025 18:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746643523;
	bh=rq8iAA+QerNDCld7vGn/zQBx5m0b3KJbdk/1zHRSgL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aZgvFmQVwhkphID5yQSGPuP0kx0Ji4kHcB/aSmJsLxHIFip1pLCZS4oR83F/fWzGJ
	 0xY0gHr9O698jWXRAKkQEYkEv0gmOPaED1f5PZ0Ue0AIcHuhoksfKnLmjtzj0WNMjf
	 HrbFUJlw/wzk2POd2wuF72ss9QJQlsG7unlxL9LA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Chinner <david@fromorbit.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 33/97] xfs: convert delayed extents to unwritten when zeroing post eof blocks
Date: Wed,  7 May 2025 20:39:08 +0200
Message-ID: <20250507183808.328435090@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183806.987408728@linuxfoundation.org>
References: <20250507183806.987408728@linuxfoundation.org>
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

From: Zhang Yi <yi.zhang@huawei.com>

[ Upstream commit 5ce5674187c345dc31534d2024c09ad8ef29b7ba ]

Current clone operation could be non-atomic if the destination of a file
is beyond EOF, user could get a file with corrupted (zeroed) data on
crash.

The problem is about preallocations. If you write some data into a file:

	[A...B)

and XFS decides to preallocate some post-eof blocks, then it can create
a delayed allocation reservation:

	[A.........D)

The writeback path tries to convert delayed extents to real ones by
allocating blocks. If there aren't enough contiguous free space, we can
end up with two extents, the first real and the second still delalloc:

	[A....C)[C.D)

After that, both the in-memory and the on-disk file sizes are still B.
If we clone into the range [E...F) from another file:

	[A....C)[C.D)      [E...F)

then xfs_reflink_zero_posteof() calls iomap_zero_range() to zero out the
range [B, E) beyond EOF and flush it. Since [C, D) is still a delalloc
extent, its pagecache will be zeroed and both the in-memory and on-disk
size will be updated to D after flushing but before cloning. This is
wrong, because the user can see the size change and read the zeroes
while the clone operation is ongoing.

We need to keep the in-memory and on-disk size before the clone
operation starts, so instead of writing zeroes through the page cache
for delayed ranges beyond EOF, we convert these ranges to unwritten and
invalidate any cached data over that range beyond EOF.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chandan Babu R <chandanbabu@kernel.org>
Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
Acked-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_iomap.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -997,6 +997,24 @@ xfs_buffered_write_iomap_begin(
 	}
 
 	/*
+	 * For zeroing, trim a delalloc extent that extends beyond the EOF
+	 * block.  If it starts beyond the EOF block, convert it to an
+	 * unwritten extent.
+	 */
+	if ((flags & IOMAP_ZERO) && imap.br_startoff <= offset_fsb &&
+	    isnullstartblock(imap.br_startblock)) {
+		xfs_fileoff_t eof_fsb = XFS_B_TO_FSB(mp, XFS_ISIZE(ip));
+
+		if (offset_fsb >= eof_fsb)
+			goto convert_delay;
+		if (end_fsb > eof_fsb) {
+			end_fsb = eof_fsb;
+			xfs_trim_extent(&imap, offset_fsb,
+					end_fsb - offset_fsb);
+		}
+	}
+
+	/*
 	 * Search the COW fork extent list even if we did not find a data fork
 	 * extent.  This serves two purposes: first this implements the
 	 * speculative preallocation using cowextsize, so that we also unshare
@@ -1138,6 +1156,17 @@ found_imap:
 	xfs_iunlock(ip, lockmode);
 	return xfs_bmbt_to_iomap(ip, iomap, &imap, flags, 0, seq);
 
+convert_delay:
+	xfs_iunlock(ip, lockmode);
+	truncate_pagecache(inode, offset);
+	error = xfs_bmapi_convert_delalloc(ip, XFS_DATA_FORK, offset,
+					   iomap, NULL);
+	if (error)
+		return error;
+
+	trace_xfs_iomap_alloc(ip, offset, count, XFS_DATA_FORK, &imap);
+	return 0;
+
 found_cow:
 	seq = xfs_iomap_inode_sequence(ip, 0);
 	if (imap.br_startoff <= offset_fsb) {




Return-Path: <stable+bounces-87217-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2D59A63CF
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5E21F20F35
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3711E884A;
	Mon, 21 Oct 2024 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c+w669zW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2A739FD6;
	Mon, 21 Oct 2024 10:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729506944; cv=none; b=HvnxxVvrIS3VYRZIQKhsBygJZiA7hSJ7fdtOt6wROrZAoo7+Vtp0AuwNPVRFc0LF6/ZgeB4spIeut352Lk+erODgdgni8HoA8uHRYIdwRUsUlihQyviRI4j2nbSj92xTTaC8cKd6OnlemBngm9PW5txQ4xCEquQvovp35YVZ+vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729506944; c=relaxed/simple;
	bh=7OQXBqTOBMXQMw2lrBXQgnEp6U7fHihy5ok+tA0p3FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZT2kZVqcLi5iOXx6SaLBNVipnnyMJadb7MJnCkHDu9GA5oVmboyJxXwuw/2Y4EcZld6armzxbez4W1AXVirwq+tim5eSuzx954vuGyQIjSWxPU0UL0WCD8x9CAj4ZxlxedV5sdxPsUJGIHZdEBtKHtjAsCL/qlm2NTM5cplAZv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c+w669zW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB86FC4CEC3;
	Mon, 21 Oct 2024 10:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729506944;
	bh=7OQXBqTOBMXQMw2lrBXQgnEp6U7fHihy5ok+tA0p3FA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c+w669zWqueu11Bkwc8yKpe6F3eiLMOjijWwJ9ZZHXXFgRnGuLnyJskPD1RGxMQCT
	 YRXj5wKznskFz3uSZPLfhiEWNyBohoj+KGErMsJrWCQejKv9eZV7B8853qKwnntiHT
	 TeebYFvqNJTR2AzwdsXVQ8yt2rTHQI+mRYjXRZA0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	Dave Chinner <david@fromorbit.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Catherine Hoang <catherine.hoang@oracle.com>
Subject: [PATCH 6.6 038/124] xfs: convert delayed extents to unwritten when zeroing post eof blocks
Date: Mon, 21 Oct 2024 12:24:02 +0200
Message-ID: <20241021102258.200070839@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102256.706334758@linuxfoundation.org>
References: <20241021102256.706334758@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhang Yi <yi.zhang@huawei.com>

commit 5ce5674187c345dc31534d2024c09ad8ef29b7ba upstream.

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
Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
Acked-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/xfs/xfs_iomap.c |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1006,6 +1006,24 @@ xfs_buffered_write_iomap_begin(
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
@@ -1150,6 +1168,17 @@ found_imap:
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




Return-Path: <stable+bounces-139238-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6161AAA5762
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 23:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF54E5041CF
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 21:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590932D26AA;
	Wed, 30 Apr 2025 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsVO0YY4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E72D1103
	for <stable@vger.kernel.org>; Wed, 30 Apr 2025 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048445; cv=none; b=eL/8CDMWgQFaJITLYVDxqxozRXPW7Adb5O3DAvwJ0V6rOpDiLB0CP1WrEK303VOHdTgGCvBGBHL3q5ocxZz1vB7M9hAB99vt5I3MXDYIZw+nA25gRykb5r10obZac4eD1WpYvk88TXGDzcITLJOZxTIUf3PvO+NchRZ3BCcoGEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048445; c=relaxed/simple;
	bh=mFfqnfBoU9i2SAImQOfzBlfMi4AgqolkuBHVunIhmcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRJadWQFzWlu2wPJhdW8alWfMpy9/n+MvbXBM42Fl6zrY4c0svWlhq6dGEUaqy94kVJWQbbC9CCdVd2kdXldLTOHwJVONDmcTllRc2tZS//t5lIfJKwHe6SZdaDJJnqI6PSisDIC9+wXNf0tQ0OEoa8n73YVHf1YrTI2w+y9PkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsVO0YY4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-73972a54919so406645b3a.3
        for <stable@vger.kernel.org>; Wed, 30 Apr 2025 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746048443; x=1746653243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY5Ny9zljbiw0TGeRQM8b1V+5hj317rsoDRSbnUEaGM=;
        b=KsVO0YY4QF22OCwL69plG3XBEowSZVignPliU1pTjeubDQ/3pAXcMRDFkmnPCiD5pC
         k0V8JwTARxuwGi5IG/+sB9HX8BMtgnDPtxf0vy4tsdZikQ7MdyoFSY4GHyquDjVpV0/2
         gxS6IbDkj5u1OiVWcjfG+ugTbsVgdN6x3pZpN99Lv7eMJz8WajcLcT9y5TEFX6ld8hPe
         Koczwhi5BhejvZPVYFxN0ii8/wyxluS81yRMFLPrRUMZod07O1ZLMtLNKcHRsxf07Ew/
         FQL3qKqAsITtPpP5mBCANNGAc7njAWEmUb3zkLA4XVLgyjQr/ATasW/zTDkX41MCqcSe
         p6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746048443; x=1746653243;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qY5Ny9zljbiw0TGeRQM8b1V+5hj317rsoDRSbnUEaGM=;
        b=XYZQZ7t3lUgvKeOlUr9jyi4UiuLf1rUUMhPDnXQYvAu+PU+Azy7L/qJd0SZQ04wMV9
         QaxvvvE0Odb4JV5rqHIAbDfWWONnE3VKl9o0s+gZpChLYflKBRnOLhMEqZ+vWV4kgjqj
         QUdeKuN/iOjhXc7Zn6FH2N4Ry8sGyetvlS+Hm3ZgbIVFEzN0HZGL6474dhGRsyVk9K0I
         hGgwOIBU0+C8nyh+7YI+p4YxeiwTGLwWQAYDXAcUWRg90di+i1hOhLnKCWeKTeZhSfpR
         lyNd47QA+D0rSSnYMIrfV45xPNcxWwte/qeDIu1yt3nKpWz7I3Qmqboq0TaDmURETetq
         vmyQ==
X-Gm-Message-State: AOJu0YzE+Y3nZseP5Pc1WHv+nkzSI0HyRvTLfu+aFlF68YxXe5BqLBOD
	85nXV2qwAsplDZV7attdBvykz74Z1VVBu68M483rvo9ona29eS+u6Ij93Lph
X-Gm-Gg: ASbGnctbcTP3pz+P5cRLOZuxg51T/+6vzBtE4g3YUZ8NnJfFCaxRhmAQi6fhu5j2fyi
	kvc6VJ66SqmwhDpXaVN9pcaywnhvs8l797iXGRAyxp6i32TaO+EXgmXYBieE/gQKOOheQmBBXYl
	WFx8aUkH8OE5Q1JSsrVf1VUPm+XaK9egxWGAaH0E664+9TsAut9ec2CqEAepyWRXcqenBLrvzhZ
	hTAwdz7qGkTJPIQpBqfNnrOiwt6ZGvpUqXYMj/RKGmhdrLdlEIW2h4cBzJVPHqNnQpbfJvOw++s
	7xLXWy60SDy1aVGy+NqC15LD4g+oNpNlO/PLSJuXSMRO/cMbWt2osZEZN1EeysANgoDP
X-Google-Smtp-Source: AGHT+IGh8kjjds3ZhV+4Dw1jkBLrccxO0wIy9xmfIsh5fLYQQjphFELM9MBXVzvLxOWPvTbPBEI3Fw==
X-Received: by 2002:a05:6a21:9006:b0:1f5:7862:7f3a with SMTP id adf61e73a8af0-20bd6a42cadmr59404637.14.1746048442735;
        Wed, 30 Apr 2025 14:27:22 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2c5:11:c94d:a5fe:c768:2a7f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74039a62e23sm2240586b3a.147.2025.04.30.14.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 14:27:22 -0700 (PDT)
From: Leah Rumancik <leah.rumancik@gmail.com>
To: stable@vger.kernel.org
Cc: xfs-stable@lists.linux.dev,
	chandan.babu@oracle.com,
	catherine.hoang@oracle.com,
	djwong@kernel.org,
	Zhang Yi <yi.zhang@huawei.com>,
	Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandanbabu@kernel.org>,
	Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 6.1 11/16] xfs: convert delayed extents to unwritten when zeroing post eof blocks
Date: Wed, 30 Apr 2025 14:26:58 -0700
Message-ID: <20250430212704.2905795-12-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.49.0.906.g1f30a19c02-goog
In-Reply-To: <20250430212704.2905795-1-leah.rumancik@gmail.com>
References: <20250430212704.2905795-1-leah.rumancik@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 fs/xfs/xfs_iomap.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index f6ca27a42498..fab191a09442 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -994,10 +994,28 @@ xfs_buffered_write_iomap_begin(
 	if ((flags & IOMAP_ZERO) && imap.br_startoff > offset_fsb) {
 		xfs_hole_to_iomap(ip, iomap, offset_fsb, imap.br_startoff);
 		goto out_unlock;
 	}
 
+	/*
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
 	/*
 	 * Search the COW fork extent list even if we did not find a data fork
 	 * extent.  This serves two purposes: first this implements the
 	 * speculative preallocation using cowextsize, so that we also unshare
 	 * block adjacent to shared blocks instead of just the shared blocks
@@ -1136,10 +1154,21 @@ xfs_buffered_write_iomap_begin(
 found_imap:
 	seq = xfs_iomap_inode_sequence(ip, 0);
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
 		error = xfs_bmbt_to_iomap(ip, srcmap, &imap, flags, 0, seq);
 		if (error)
-- 
2.49.0.906.g1f30a19c02-goog



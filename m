Return-Path: <stable+bounces-91884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE99C139A
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 02:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C88501C23381
	for <lists+stable@lfdr.de>; Fri,  8 Nov 2024 01:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BED39FD6;
	Fri,  8 Nov 2024 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qYYuiUPy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270D136126;
	Fri,  8 Nov 2024 01:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731029170; cv=none; b=uXz9XKKrzFE0zfMGSuRxbT2DF1yaZMfjdaiznzi8YhYeDsUYiqQ+idgm85CRWrNVqQ4jQ3fgayyWhkj6bxF9gjdvyj0Z9FNbeXXzpEKGj9GW/UxmjUPNqE5KWDFZqcY27rDTlKGW2QEWYmBQsVqfzhD2ejInHQdUqsBBzOgAuaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731029170; c=relaxed/simple;
	bh=gPIkxehSKAI0ucltkZ1fut7ZW6Iq4yCbo00XEqZNTOA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hGiazbfdwH4mt3CZGNFvTjMjjJGP5ZyfmRgm37dhNY12JWDuzk8F4NmRVpkUxlqpWf1XancB99Xm1+Op+BHi1cqEnG89w9Gysw0WKrs7T5UXPfxGNZxHxPFEHXSbLGzCNGsuHrRyX+j+/6Cs5CGkRcPtkFSzKmZb/bwcNEpshpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qYYuiUPy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562B1C4CECC;
	Fri,  8 Nov 2024 01:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731029170;
	bh=gPIkxehSKAI0ucltkZ1fut7ZW6Iq4yCbo00XEqZNTOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qYYuiUPyH2Mz0ezkEkyom8E7Qbs7K7xqKi2IvL1VTAx2L734ePruCTPrW7ThfMImg
	 /W4qtabEK7FGQmQTK9UPjmAdP3QGvnYuY24zgSL/zSu4WZGdoUqIygrKUeFW141Zst
	 mlNI+MchNG2a9DiCri44oi1jDnuKa8fUsTPBr44d/a8ZaxnFAwdanhG0eQxu5c3Hqv
	 L7Iz/po0ubzM4m9PBbKj5jaDQ+vgTJGkyLsPqBQ06LK5qF4OngOCSeX2Jb2fVLPHE3
	 Ys4b1voheyLFTfOzkw74JdCJalsk8Wefy+47L7AEjtickLM5BCC8JMgodZSTG1fNqy
	 TG2JnHsGOWi8Q==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org,
	Zhiguo Niu <zhiguo.niu@unisoc.com>
Subject: [PATCH 4/4] f2fs: fix to requery extent which cross boundary of inquiry
Date: Fri,  8 Nov 2024 09:25:57 +0800
Message-Id: <20241108012557.572782-4-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241108012557.572782-1-chao@kernel.org>
References: <20241108012557.572782-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dd if=/dev/zero of=file bs=4k count=5
xfs_io file -c "fiemap -v 2 16384"
file:
   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
     0: [0..31]:         139272..139303      32 0x1000
     1: [32..39]:        139304..139311       8 0x1001
xfs_io file -c "fiemap -v 0 16384"
file:
   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
     0: [0..31]:         139272..139303      32 0x1000
xfs_io file -c "fiemap -v 0 16385"
file:
   EXT: FILE-OFFSET      BLOCK-RANGE      TOTAL FLAGS
     0: [0..39]:         139272..139311      40 0x1001

There are two problems:
- continuous extent is split to two
- FIEMAP_EXTENT_LAST is missing in last extent

The root cause is: if upper boundary of inquiry crosses extent,
f2fs_map_blocks() will truncate length of returned extent to
F2FS_BYTES_TO_BLK(len), and also, it will stop to query latter
extent or hole to make sure current extent is last or not.

In order to fix this issue, once we found an extent locates
in the end of inquiry range by f2fs_map_blocks(), we need to
expand inquiry range to requiry.

Cc: stable@vger.kernel.org
Fixes: 7f63eb77af7b ("f2fs: report unwritten area in f2fs_fiemap")
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 69f1cb0490ee..ee5614324df0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1896,7 +1896,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		u64 start, u64 len)
 {
 	struct f2fs_map_blocks map;
-	sector_t start_blk, last_blk;
+	sector_t start_blk, last_blk, blk_len, max_len;
 	pgoff_t next_pgofs;
 	u64 logical = 0, phys = 0, size = 0;
 	u32 flags = 0;
@@ -1940,14 +1940,13 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 	start_blk = F2FS_BYTES_TO_BLK(start);
 	last_blk = F2FS_BYTES_TO_BLK(start + len - 1);
-
-	if (len & F2FS_BLKSIZE_MASK)
-		len = round_up(len, F2FS_BLKSIZE);
+	blk_len = last_blk - start_blk + 1;
+	max_len = F2FS_BYTES_TO_BLK(maxbytes) - start_blk;
 
 next:
 	memset(&map, 0, sizeof(map));
 	map.m_lblk = start_blk;
-	map.m_len = F2FS_BYTES_TO_BLK(len);
+	map.m_len = blk_len;
 	map.m_next_pgofs = &next_pgofs;
 	map.m_seg_type = NO_CHECK_TYPE;
 
@@ -1970,6 +1969,17 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		flags |= FIEMAP_EXTENT_LAST;
 	}
 
+	/*
+	 * current extent may cross boundary of inquiry, increase len to
+	 * requery.
+	 */
+	if (!compr_cluster && (map.m_flags & F2FS_MAP_MAPPED) &&
+				map.m_lblk + map.m_len - 1 == last_blk &&
+				blk_len != max_len) {
+		blk_len = max_len;
+		goto next;
+	}
+
 	compr_appended = false;
 	/* In a case of compressed cluster, append this to the last extent */
 	if (compr_cluster && ((map.m_flags & F2FS_MAP_DELALLOC) ||
-- 
2.40.1



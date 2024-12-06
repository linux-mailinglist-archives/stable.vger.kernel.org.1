Return-Path: <stable+bounces-99028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A22919E6DC1
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CCE283B0B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A488A200125;
	Fri,  6 Dec 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lE13cvNE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437F1DE3D9
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486796; cv=none; b=ueh4Hmz87opAJTcU4o3Mbwvw+oLqgEp8OyiHy3fL/HxJZkFbcPLxOZDPl6Y2hkEgRzkaLlEcPqCyHLbYb3YRGEbV8HEzAWHb8F4tJvwOUbCcjGwQxm0qOQognhZGUEOqqLwKXv1oq9S6Nii8IrzxnsuwgVcgyBZUCeRdqrEniFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486796; c=relaxed/simple;
	bh=1y/wwVv7HBi3tpEYgmsgJ7HW8enhwUIEcjCr8CasRB0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IzRUvgzhmyxZsjVDNTFMmscRnFholFF7c5A9Rumigne1Wrik5dmn+0vhQ67MumJ0eXAd6RevcunC9UMJs7iCx/6xo/zy8o89U75Y4+CIpC7HOZrO4iUEokh7S71Syy1BKY7G0ARrdXkE5LfIKu+cBAjVhxTkxjzeFbpdpuszddE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lE13cvNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23F9C4CEDD;
	Fri,  6 Dec 2024 12:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733486796;
	bh=1y/wwVv7HBi3tpEYgmsgJ7HW8enhwUIEcjCr8CasRB0=;
	h=Subject:To:Cc:From:Date:From;
	b=lE13cvNEVjmLXW9r3mRkBXFVLOcjcoVDfvlTfdw/NeDiEFA1Bi90I5XSQswJjMnHb
	 N8wEk6Oiy/HRHQDMYNz2GQsH7QLzd5+DiXKVX4T17GmgShZ2wNVnEbvUFd//MUgipG
	 TbwrBIeGznSS+jAOnGz6rTqfRX//wtIzb3k54U7U=
Subject: FAILED: patch "[PATCH] f2fs: fix to requery extent which cross boundary of inquiry" failed to apply to 6.6-stable tree
To: chao@kernel.org,jaegeuk@kernel.org,zhiguo.niu@unisoc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:06:30 +0100
Message-ID: <2024120629-flaccid-viewer-fbf0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 6787a82245857271133b63ae7f72f1dc9f29e985
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120629-flaccid-viewer-fbf0@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6787a82245857271133b63ae7f72f1dc9f29e985 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Fri, 8 Nov 2024 09:25:57 +0800
Subject: [PATCH] f2fs: fix to requery extent which cross boundary of inquiry

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
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

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



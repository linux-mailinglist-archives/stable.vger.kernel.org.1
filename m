Return-Path: <stable+bounces-105651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42D59FB107
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4597A154F
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D76A13BC0C;
	Mon, 23 Dec 2024 16:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v4dffxlW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2BF2EAE6;
	Mon, 23 Dec 2024 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734969669; cv=none; b=eT587D8rhOYYbZYwHpeYYym0kpFa7VIncbjRokAUu1G1JpHesv9LUx2GB461H1ZHGDtsBIycPCxoThDULVw1BdW2BWmcboO7OVgZnQSpB9WS+mYpyBpSLjcyP2Fw3/btSvW0PyxthvPQZG+DTW47mFDsj6j4dhk78KSJEtADiRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734969669; c=relaxed/simple;
	bh=Lzadj4ypt5dpNOiDas35h2op3C6ikQsVRlUCDPsV21M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFq2oNDwmDZWyahYunsD3WnKn+jzUberNx561bihJc0/f4Fyqh5Fbt9174anGn8JkiPypEypTEOsXrFzUnvNSwODZDilr5uNt0AOUAMQO8EkmVctioxLUjOkGF0Z8agHflXdJaJVtT0dbldtlKAZn4ZyRYcHCv3Ei+YrPKkIZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v4dffxlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4819BC4CED4;
	Mon, 23 Dec 2024 16:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734969668;
	bh=Lzadj4ypt5dpNOiDas35h2op3C6ikQsVRlUCDPsV21M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=v4dffxlWBMII+0jSi4zOhRsO3KlUyM/53cR6bYLnwp1itbRLfR+UQyUgU5lz8mfWW
	 v4eglvw7gD0R4rD3NjiKlFSED+mLrec5t6FbsE6riA8as9w4iQ4QY9Dm1wJzcs07AD
	 1ETUqPX6sGlWhY1nWeUfJRSYgos4Mc4wXdU32PC4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 021/160] erofs: reference `struct erofs_device_info` for erofs_map_dev
Date: Mon, 23 Dec 2024 16:57:12 +0100
Message-ID: <20241223155409.472948718@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155408.598780301@linuxfoundation.org>
References: <20241223155408.598780301@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gao Xiang <hsiangkao@linux.alibaba.com>

[ Upstream commit f8d920a402aec3482931cb5f1539ed438740fc49 ]

Record `m_sb` and `m_dif` to replace `m_fscache`, `m_daxdev`, `m_fp`
and `m_dax_part_off` in order to simplify the codebase.

Note that `m_bdev` is still left since it can be assigned from
`sb->s_bdev` directly.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20241212235401.2857246-1-hsiangkao@linux.alibaba.com
Stable-dep-of: 6422cde1b0d5 ("erofs: use buffered I/O for file-backed mounts by default")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/data.c     | 26 ++++++++++----------------
 fs/erofs/fileio.c   |  2 +-
 fs/erofs/fscache.c  |  4 ++--
 fs/erofs/internal.h |  6 ++----
 4 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 365c988262b1..722151d3fee8 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -186,19 +186,13 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 }
 
 static void erofs_fill_from_devinfo(struct erofs_map_dev *map,
-				    struct erofs_device_info *dif)
+		struct super_block *sb, struct erofs_device_info *dif)
 {
+	map->m_sb = sb;
+	map->m_dif = dif;
 	map->m_bdev = NULL;
-	map->m_fp = NULL;
-	if (dif->file) {
-		if (S_ISBLK(file_inode(dif->file)->i_mode))
-			map->m_bdev = file_bdev(dif->file);
-		else
-			map->m_fp = dif->file;
-	}
-	map->m_daxdev = dif->dax_dev;
-	map->m_dax_part_off = dif->dax_part_off;
-	map->m_fscache = dif->fscache;
+	if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
+		map->m_bdev = file_bdev(dif->file);
 }
 
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
@@ -208,7 +202,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	erofs_off_t startoff, length;
 	int id;
 
-	erofs_fill_from_devinfo(map, &EROFS_SB(sb)->dif0);
+	erofs_fill_from_devinfo(map, sb, &EROFS_SB(sb)->dif0);
 	map->m_bdev = sb->s_bdev;	/* use s_bdev for the primary device */
 	if (map->m_deviceid) {
 		down_read(&devs->rwsem);
@@ -222,7 +216,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		erofs_fill_from_devinfo(map, dif);
+		erofs_fill_from_devinfo(map, sb, dif);
 		up_read(&devs->rwsem);
 	} else if (devs->extra_devices && !devs->flatdev) {
 		down_read(&devs->rwsem);
@@ -235,7 +229,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				erofs_fill_from_devinfo(map, dif);
+				erofs_fill_from_devinfo(map, sb, dif);
 				break;
 			}
 		}
@@ -305,7 +299,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	iomap->offset = map.m_la;
 	if (flags & IOMAP_DAX)
-		iomap->dax_dev = mdev.m_daxdev;
+		iomap->dax_dev = mdev.m_dif->dax_dev;
 	else
 		iomap->bdev = mdev.m_bdev;
 	iomap->length = map.m_llen;
@@ -334,7 +328,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->type = IOMAP_MAPPED;
 		iomap->addr = mdev.m_pa;
 		if (flags & IOMAP_DAX)
-			iomap->addr += mdev.m_dax_part_off;
+			iomap->addr += mdev.m_dif->dax_part_off;
 	}
 	return 0;
 }
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 3af96b1e2c2a..a61b8faec651 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -67,7 +67,7 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 					     GFP_KERNEL | __GFP_NOFAIL);
 
 	bio_init(&rq->bio, NULL, rq->bvecs, BIO_MAX_VECS, REQ_OP_READ);
-	rq->iocb.ki_filp = mdev->m_fp;
+	rq->iocb.ki_filp = mdev->m_dif->file;
 	return rq;
 }
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index ce7e38c82719..ce3d8737df85 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -198,7 +198,7 @@ struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev)
 
 	io = kmalloc(sizeof(*io), GFP_KERNEL | __GFP_NOFAIL);
 	bio_init(&io->bio, NULL, io->bvecs, BIO_MAX_VECS, REQ_OP_READ);
-	io->io.private = mdev->m_fscache->cookie;
+	io->io.private = mdev->m_dif->fscache->cookie;
 	io->io.end_io = erofs_fscache_bio_endio;
 	refcount_set(&io->io.ref, 1);
 	return &io->bio;
@@ -316,7 +316,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 	if (!io)
 		return -ENOMEM;
 	iov_iter_xarray(&io->iter, ITER_DEST, &mapping->i_pages, pos, count);
-	ret = erofs_fscache_read_io_async(mdev.m_fscache->cookie,
+	ret = erofs_fscache_read_io_async(mdev.m_dif->fscache->cookie,
 			mdev.m_pa + (pos - map.m_la), io);
 	erofs_fscache_req_io_put(io);
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d70aa2410472..3108ece1d709 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -366,11 +366,9 @@ enum {
 };
 
 struct erofs_map_dev {
-	struct erofs_fscache *m_fscache;
+	struct super_block *m_sb;
+	struct erofs_device_info *m_dif;
 	struct block_device *m_bdev;
-	struct dax_device *m_daxdev;
-	struct file *m_fp;
-	u64 m_dax_part_off;
 
 	erofs_off_t m_pa;
 	unsigned int m_deviceid;
-- 
2.39.5





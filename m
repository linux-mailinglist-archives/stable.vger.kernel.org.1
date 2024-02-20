Return-Path: <stable+bounces-20763-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC385B19E
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 04:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB067281AB4
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 03:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A958347A4C;
	Tue, 20 Feb 2024 03:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdr9C+X8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B61C2E
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 03:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400896; cv=none; b=e+oKr1TocwFB0bjgWBI5ox26DiX6Fa8OuZ9MHkH8pG6sFm/yd3Qe7PjjTEA8r+GM4QWotzvVd5OQZ1ho1ZuouNyQEBStd9bSyPo2vaS3LLtq1WtU9dxRPKfo0nw6SuyjyUIIwhGwz9jkyZYqwjb6Y2qZv47gtGILEEBDp+GihQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400896; c=relaxed/simple;
	bh=OXA16Hpjqvpl285+uhB/KZbd4aN5s4oFsZqUtu8rbTY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LkOyfEvk+5k+L7WHwvC0lgTakqNlm8cJIYyvEwpxrHinvjFuOL6sy9LOQaYCBKdsqKdiAk3QvkBY75t7uNQ7Em/dIRJM6eaJEg7QT+LJPVK0RQCMmHEv8YuzeS48Wp04EhexPbVa7LJqB34BXfDjTh6MzrcUcXS/CF8arihvzMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdr9C+X8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC949C433F1
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 03:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708400895;
	bh=OXA16Hpjqvpl285+uhB/KZbd4aN5s4oFsZqUtu8rbTY=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=pdr9C+X8YENBihSJAx20oTLYT18X7zNleK7E6z0mNpcEpAJPbLvE+2es9Bce1VFGH
	 bMUwtW/fTKVtBIbx2TXDOlP9iF5mYltE4Nb7kDXJHFyuFGQhPLhwmsM4/kDXZuvo/W
	 nfFFxi8Tb/ZzUkKE+ffP+6EwtxSS52ok+RddJ7YEDQLvtX5bvxi+kg7AJ9TAuleFi+
	 1KNEesLg6TB7PcVi6JUeoDigfAGPoF7VXDgh810WfLi7Zwu8XiqkoHs/HNiqjTjf3g
	 YQv3T1weLnIXKc5KExFs23x3NPLwQ0C+QGP4SO3O/rX5YTMlXmZcZuHH6WVbRKi/kj
	 GlHfWPcDjrA+w==
From: Damien Le Moal <dlemoal@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y] zonefs: Improve error handling
Date: Tue, 20 Feb 2024 12:48:14 +0900
Message-ID: <20240220034814.2680699-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <2024021944-kettle-upturned-4371@gregkh>
References: <2024021944-kettle-upturned-4371@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 14db5f64a971fce3d8ea35de4dfc7f443a3efb92 upstream.

Write error handling is racy and can sometime lead to the error recovery
path wrongly changing the inode size of a sequential zone file to an
incorrect value  which results in garbage data being readable at the end
of a file. There are 2 problems:

1) zonefs_file_dio_write() updates a zone file write pointer offset
   after issuing a direct IO with iomap_dio_rw(). This update is done
   only if the IO succeed for synchronous direct writes. However, for
   asynchronous direct writes, the update is done without waiting for
   the IO completion so that the next asynchronous IO can be
   immediately issued. However, if an asynchronous IO completes with a
   failure right before the i_truncate_mutex lock protecting the update,
   the update may change the value of the inode write pointer offset
   that was corrected by the error path (zonefs_io_error() function).

2) zonefs_io_error() is called when a read or write error occurs. This
   function executes a report zone operation using the callback function
   zonefs_io_error_cb(), which does all the error recovery handling
   based on the current zone condition, write pointer position and
   according to the mount options being used. However, depending on the
   zoned device being used, a report zone callback may be executed in a
   context that is different from the context of __zonefs_io_error(). As
   a result, zonefs_io_error_cb() may be executed without the inode
   truncate mutex lock held, which can lead to invalid error processing.

Fix both problems as follows:
- Problem 1: Perform the inode write pointer offset update before a
  direct write is issued with iomap_dio_rw(). This is safe to do as
  partial direct writes are not supported (IOMAP_DIO_PARTIAL is not
  set) and any failed IO will trigger the execution of zonefs_io_error()
  which will correct the inode write pointer offset to reflect the
  current state of the one on the device.
- Problem 2: Change zonefs_io_error_cb() into zonefs_handle_io_error()
  and call this function directly from __zonefs_io_error() after
  obtaining the zone information using blkdev_report_zones() with a
  simple callback function that copies to a local stack variable the
  struct blk_zone obtained from the device. This ensures that error
  handling is performed holding the inode truncate mutex.
  This change also simplifies error handling for conventional zone files
  by bypassing the execution of report zones entirely. This is safe to
  do because the condition of conventional zones cannot be read-only or
  offline and conventional zone files are always fully mapped with a
  constant file size.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 fs/zonefs/super.c | 68 +++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index b9522eee1257..f9ecade9ea65 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -319,16 +319,18 @@ static loff_t zonefs_check_zone_condition(struct inode *inode,
 	}
 }
 
-struct zonefs_ioerr_data {
-	struct inode	*inode;
-	bool		write;
-};
-
 static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 			      void *data)
 {
-	struct zonefs_ioerr_data *err = data;
-	struct inode *inode = err->inode;
+	struct blk_zone *z = data;
+
+	*z = *zone;
+	return 0;
+}
+
+static void zonefs_handle_io_error(struct inode *inode, struct blk_zone *zone,
+				   bool write)
+{
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
@@ -344,8 +346,8 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	isize = i_size_read(inode);
 	if (zone->cond != BLK_ZONE_COND_OFFLINE &&
 	    zone->cond != BLK_ZONE_COND_READONLY &&
-	    !err->write && isize == data_size)
-		return 0;
+	    !write && isize == data_size)
+		return;
 
 	/*
 	 * At this point, we detected either a bad zone or an inconsistency
@@ -366,8 +368,9 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	 * In all cases, warn about inode size inconsistency and handle the
 	 * IO error according to the zone condition and to the mount options.
 	 */
-	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ && isize != data_size)
-		zonefs_warn(sb, "inode %lu: invalid size %lld (should be %lld)\n",
+	if (isize != data_size)
+		zonefs_warn(sb,
+			    "inode %lu: invalid size %lld (should be %lld)\n",
 			    inode->i_ino, isize, data_size);
 
 	/*
@@ -427,8 +430,6 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	zonefs_update_stats(inode, data_size);
 	zonefs_i_size_write(inode, data_size);
 	zi->i_wpoffset = data_size;
-
-	return 0;
 }
 
 /*
@@ -442,23 +443,25 @@ static void __zonefs_io_error(struct inode *inode, bool write)
 {
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 	struct super_block *sb = inode->i_sb;
-	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
 	unsigned int noio_flag;
-	unsigned int nr_zones = 1;
-	struct zonefs_ioerr_data err = {
-		.inode = inode,
-		.write = write,
-	};
+	struct blk_zone zone;
 	int ret;
 
 	/*
-	 * The only files that have more than one zone are conventional zone
-	 * files with aggregated conventional zones, for which the inode zone
-	 * size is always larger than the device zone size.
+	 * Conventional zone have no write pointer and cannot become read-only
+	 * or offline. So simply fake a report for a single or aggregated zone
+	 * and let zonefs_handle_io_error() correct the zone inode information
+	 * according to the mount options.
 	 */
-	if (zi->i_zone_size > bdev_zone_sectors(sb->s_bdev))
-		nr_zones = zi->i_zone_size >>
-			(sbi->s_zone_sectors_shift + SECTOR_SHIFT);
+	if (zi->i_ztype != ZONEFS_ZTYPE_SEQ) {
+		zone.start = zi->i_zsector;
+		zone.len = zi->i_max_size >> SECTOR_SHIFT;
+		zone.wp = zone.start + zone.len;
+		zone.type = BLK_ZONE_TYPE_CONVENTIONAL;
+		zone.cond = BLK_ZONE_COND_NOT_WP;
+		zone.capacity = zone.len;
+		goto handle_io_error;
+	}
 
 	/*
 	 * Memory allocations in blkdev_report_zones() can trigger a memory
@@ -469,12 +472,19 @@ static void __zonefs_io_error(struct inode *inode, bool write)
 	 * the GFP_NOIO context avoids both problems.
 	 */
 	noio_flag = memalloc_noio_save();
-	ret = blkdev_report_zones(sb->s_bdev, zi->i_zsector, nr_zones,
-				  zonefs_io_error_cb, &err);
-	if (ret != nr_zones)
+	ret = blkdev_report_zones(sb->s_bdev, zi->i_zsector, 1,
+				  zonefs_io_error_cb, &zone);
+	memalloc_noio_restore(noio_flag);
+	if (ret != 1) {
 		zonefs_err(sb, "Get inode %lu zone information failed %d\n",
 			   inode->i_ino, ret);
-	memalloc_noio_restore(noio_flag);
+		zonefs_warn(sb, "remounting filesystem read-only\n");
+		sb->s_flags |= SB_RDONLY;
+		return;
+	}
+
+handle_io_error:
+	zonefs_handle_io_error(inode, &zone, write);
 }
 
 static void zonefs_io_error(struct inode *inode, bool write)
-- 
2.43.2



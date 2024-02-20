Return-Path: <stable+bounces-20761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE6A85B194
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 04:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 783AC1F2216D
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 03:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B147768;
	Tue, 20 Feb 2024 03:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efxjr0r2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101004643B
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708400666; cv=none; b=BFXTMK7jCqvbtKY8llM9/PR7BgPdoaumClGvEgBMBZ1oKwGaeb5u+/dNpNTKy6T0vLtcktcx4lDk6UEdSb4bg+epvH0XMe7DPSGuWnQGdAp24qMPHJenUfR4k2yaspKTlMWNov8jH1pIFaLCzcE5AUeC2YfFr0El6HoTbLDu+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708400666; c=relaxed/simple;
	bh=Y0TobukOJxIADNGFhWQxctZecj04MSsrX95/VSKaRnU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5l2QyIDJV3c/toc9wx7iruncIDU94DA0+aVtIAxPpQlOqcee7llkDFpTIDJcbAeffCqDxOn8hHWLZ6YVs57Rx6CL6kZ6E2SnX+v0PNcXyd48tmTzzAuV7jfgoxKtApeela0e819vz8UDJavhcFk4n5sBcS5jUsJ1ewFe8BKAOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efxjr0r2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5BDC433C7
	for <stable@vger.kernel.org>; Tue, 20 Feb 2024 03:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708400665;
	bh=Y0TobukOJxIADNGFhWQxctZecj04MSsrX95/VSKaRnU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=efxjr0r2kRIsR+o2+1YNxSWB5+o1Dm/ewe26NVaaUN0oVGPVL/LUmYFkvlbok+hKV
	 PlycICNEjlCLxS5GNeP1drEtWRYqRVSHXLbbx9DBmNCwVwj9qJg5GEr1tv9omwtR4n
	 zhZnLPq+W6EzgJ4kbVcBwlQh6zbwv0l61sFhhkN4+zsDuNdmhGhqQDObIysfXEnpy7
	 FvHajrCf7cPhoqr6I1szixR9YGkyob7nLwg5bds1tZARx2rpG7vce9V3IR99S6Pld7
	 EJJepdJGdnO/JwU2AcJrL+1X1oNr/pCbwa2p/+kEbjxt0y/XWwGxmWPXuPwqj/vOMo
	 WEcdSCGgDeukQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] zonefs: Improve error handling
Date: Tue, 20 Feb 2024 12:44:23 +0900
Message-ID: <20240220034423.2571184-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <2024021942-driven-backhand-7edd@gregkh>
References: <2024021942-driven-backhand-7edd@gregkh>
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
index 9619a68df163..788f10a21ce0 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -327,16 +327,18 @@ static loff_t zonefs_check_zone_condition(struct inode *inode,
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
@@ -352,8 +354,8 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	isize = i_size_read(inode);
 	if (zone->cond != BLK_ZONE_COND_OFFLINE &&
 	    zone->cond != BLK_ZONE_COND_READONLY &&
-	    !err->write && isize == data_size)
-		return 0;
+	    !write && isize == data_size)
+		return;
 
 	/*
 	 * At this point, we detected either a bad zone or an inconsistency
@@ -374,8 +376,9 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
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
@@ -435,8 +438,6 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	zonefs_update_stats(inode, data_size);
 	zonefs_i_size_write(inode, data_size);
 	zi->i_wpoffset = data_size;
-
-	return 0;
 }
 
 /*
@@ -450,23 +451,25 @@ static void __zonefs_io_error(struct inode *inode, bool write)
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
@@ -477,12 +480,19 @@ static void __zonefs_io_error(struct inode *inode, bool write)
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



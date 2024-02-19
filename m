Return-Path: <stable+bounces-20699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E68C85AB53
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459DF283C07
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDA145C04;
	Mon, 19 Feb 2024 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nbB+DYSt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10D244C8C
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708368236; cv=none; b=Rl6FnoDpO4lBBJuhKCVfOwQMbXygtkejJtEnbpxBwkWtIjnmfL2GP+QBuxr89tpJZAvLGUoXS3VWw7tejPbLoELnuKShQapKnjf8Zsp9t8MPuRtT1gNHUJ1mwLdh6JDT1lQbdQz5QMN+pIIMEJkDZwFJJ5BozsChmeS3Gd83rj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708368236; c=relaxed/simple;
	bh=vuWJ079UmUlMmwV39g16p85CFdUefHfj8f9IrkdNOoo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RDi9wf1Y8Ovwqws4hjwMeTsb5tvg0LCf71KVlxdofeJIQ3j1EL0Q7FFru65hR7WNamEH7/ceUzqqMk6s3hXJk6vFJOFYC994HqkxFqcaS7Y0E81iJQUFt/8mAcWlnb20ANMJxkvL3R8B00vcdSGaWyB87TT1CCN54kDG9oSNdOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nbB+DYSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D46C433C7;
	Mon, 19 Feb 2024 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708368235;
	bh=vuWJ079UmUlMmwV39g16p85CFdUefHfj8f9IrkdNOoo=;
	h=Subject:To:Cc:From:Date:From;
	b=nbB+DYStOwyiHOzllM7za0Ogh11p3eBBWGOIsG+64H1eIzp2OQ8dJquOaEOZup1sm
	 kixuUNdJt4EXtf16JaXtxOt7YF3bu8bdYDBvX8FGpa2t+2Y0h9elAc9bcOfKP4mvwH
	 0k7URUasO1OWQw8jxZU24H6Fbx0d9GwGnlpzDs7I=
Subject: FAILED: patch "[PATCH] zonefs: Improve error handling" failed to apply to 5.10-stable tree
To: dlemoal@kernel.org,himanshu.madhani@oracle.com,johannes.thumshirn@wdc.com,shinichiro.kawasaki@wdc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:43:44 +0100
Message-ID: <2024021944-kettle-upturned-4371@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 14db5f64a971fce3d8ea35de4dfc7f443a3efb92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021944-kettle-upturned-4371@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

14db5f64a971 ("zonefs: Improve error handling")
77af13ba3c7f ("zonefs: Do not propagate iomap_dio_rw() ENOTBLK error to user space")
aa7f243f32e1 ("zonefs: Separate zone information from inode information")
34422914dc00 ("zonefs: Reduce struct zonefs_inode_info size")
46a9c526eef7 ("zonefs: Simplify IO error handling")
4008e2a0b01a ("zonefs: Reorganize code")
a608da3bd730 ("zonefs: Detect append writes at invalid locations")
db58653ce0c7 ("zonefs: Fix active zone accounting")
7dd12d65ac64 ("zonefs: fix zone report size in __zonefs_io_error()")
8745889a7fd0 ("Merge tag 'iomap-6.0-merge-2' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14db5f64a971fce3d8ea35de4dfc7f443a3efb92 Mon Sep 17 00:00:00 2001
From: Damien Le Moal <dlemoal@kernel.org>
Date: Thu, 8 Feb 2024 17:26:59 +0900
Subject: [PATCH] zonefs: Improve error handling

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

diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 6ab2318a9c8e..dba5dcb62bef 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -348,7 +348,12 @@ static int zonefs_file_write_dio_end_io(struct kiocb *iocb, ssize_t size,
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
 
 	if (error) {
-		zonefs_io_error(inode, true);
+		/*
+		 * For Sync IOs, error recovery is called from
+		 * zonefs_file_dio_write().
+		 */
+		if (!is_sync_kiocb(iocb))
+			zonefs_io_error(inode, true);
 		return error;
 	}
 
@@ -491,6 +496,14 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 			ret = -EINVAL;
 			goto inode_unlock;
 		}
+		/*
+		 * Advance the zone write pointer offset. This assumes that the
+		 * IO will succeed, which is OK to do because we do not allow
+		 * partial writes (IOMAP_DIO_PARTIAL is not set) and if the IO
+		 * fails, the error path will correct the write pointer offset.
+		 */
+		z->z_wpoffset += count;
+		zonefs_inode_account_active(inode);
 		mutex_unlock(&zi->i_truncate_mutex);
 	}
 
@@ -504,20 +517,19 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 	if (ret == -ENOTBLK)
 		ret = -EBUSY;
 
-	if (zonefs_zone_is_seq(z) &&
-	    (ret > 0 || ret == -EIOCBQUEUED)) {
-		if (ret > 0)
-			count = ret;
-
-		/*
-		 * Update the zone write pointer offset assuming the write
-		 * operation succeeded. If it did not, the error recovery path
-		 * will correct it. Also do active seq file accounting.
-		 */
-		mutex_lock(&zi->i_truncate_mutex);
-		z->z_wpoffset += count;
-		zonefs_inode_account_active(inode);
-		mutex_unlock(&zi->i_truncate_mutex);
+	/*
+	 * For a failed IO or partial completion, trigger error recovery
+	 * to update the zone write pointer offset to a correct value.
+	 * For asynchronous IOs, zonefs_file_write_dio_end_io() may already
+	 * have executed error recovery if the IO already completed when we
+	 * reach here. However, we cannot know that and execute error recovery
+	 * again (that will not change anything).
+	 */
+	if (zonefs_zone_is_seq(z)) {
+		if (ret > 0 && ret != count)
+			ret = -EIO;
+		if (ret < 0 && ret != -EIOCBQUEUED)
+			zonefs_io_error(inode, true);
 	}
 
 inode_unlock:
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 93971742613a..b6e8e7c96251 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -246,16 +246,18 @@ static void zonefs_inode_update_mode(struct inode *inode)
 	z->z_mode = inode->i_mode;
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
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
 	struct super_block *sb = inode->i_sb;
 	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
@@ -270,8 +272,8 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	data_size = zonefs_check_zone_condition(sb, z, zone);
 	isize = i_size_read(inode);
 	if (!(z->z_flags & (ZONEFS_ZONE_READONLY | ZONEFS_ZONE_OFFLINE)) &&
-	    !err->write && isize == data_size)
-		return 0;
+	    !write && isize == data_size)
+		return;
 
 	/*
 	 * At this point, we detected either a bad zone or an inconsistency
@@ -292,7 +294,7 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	 * In all cases, warn about inode size inconsistency and handle the
 	 * IO error according to the zone condition and to the mount options.
 	 */
-	if (zonefs_zone_is_seq(z) && isize != data_size)
+	if (isize != data_size)
 		zonefs_warn(sb,
 			    "inode %lu: invalid size %lld (should be %lld)\n",
 			    inode->i_ino, isize, data_size);
@@ -352,8 +354,6 @@ static int zonefs_io_error_cb(struct blk_zone *zone, unsigned int idx,
 	zonefs_i_size_write(inode, data_size);
 	z->z_wpoffset = data_size;
 	zonefs_inode_account_active(inode);
-
-	return 0;
 }
 
 /*
@@ -367,23 +367,25 @@ void __zonefs_io_error(struct inode *inode, bool write)
 {
 	struct zonefs_zone *z = zonefs_inode_zone(inode);
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
-	if (z->z_size > bdev_zone_sectors(sb->s_bdev))
-		nr_zones = z->z_size >>
-			(sbi->s_zone_sectors_shift + SECTOR_SHIFT);
+	if (!zonefs_zone_is_seq(z)) {
+		zone.start = z->z_sector;
+		zone.len = z->z_size >> SECTOR_SHIFT;
+		zone.wp = zone.start + zone.len;
+		zone.type = BLK_ZONE_TYPE_CONVENTIONAL;
+		zone.cond = BLK_ZONE_COND_NOT_WP;
+		zone.capacity = zone.len;
+		goto handle_io_error;
+	}
 
 	/*
 	 * Memory allocations in blkdev_report_zones() can trigger a memory
@@ -394,12 +396,20 @@ void __zonefs_io_error(struct inode *inode, bool write)
 	 * the GFP_NOIO context avoids both problems.
 	 */
 	noio_flag = memalloc_noio_save();
-	ret = blkdev_report_zones(sb->s_bdev, z->z_sector, nr_zones,
-				  zonefs_io_error_cb, &err);
-	if (ret != nr_zones)
+	ret = blkdev_report_zones(sb->s_bdev, z->z_sector, 1,
+				  zonefs_io_error_cb, &zone);
+	memalloc_noio_restore(noio_flag);
+
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
 
 static struct kmem_cache *zonefs_inode_cachep;



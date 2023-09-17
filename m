Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE5C37A3D51
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbjIQUlI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbjIQUk7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:40:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E83910E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:40:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A147EC433C7;
        Sun, 17 Sep 2023 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983254;
        bh=OL/IkHJR7x8D3Dt+rBhQ7476Q909hMWOsFRf5Exrsoc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BpUNyNpfAHzEyRgapcBqCDVdJ1mO4vj2UElgRsvY5o4iWcf5Uda8lthAmMuf29Z4E
         rSigZgWZKh2jDIXiBBXJJE/Fy0xtgZK6g//rETvoU/ZfpNsFVTAOIik4GwZJYmuMSM
         OL9Vl9FsbfuxYD8wxYYvzHrswl/GHYxWJvdzpDEY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 488/511] block: move GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE to disk->event_flags
Date:   Sun, 17 Sep 2023 21:15:15 +0200
Message-ID: <20230917191125.518517721@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 1545e0b419ba1d9b9bee4061d4826340afe6b0aa ]

GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE is all about the event reporting
mechanism, so move it to the event_flags field.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20211122130625.1136848-3-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 1a721de8489f ("block: don't add or resize partition on the disk with GENHD_FL_NO_PART")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bdev.c               | 2 +-
 drivers/block/paride/pcd.c | 2 +-
 drivers/scsi/sr.c          | 5 +++--
 include/linux/genhd.h      | 6 ++----
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 18abafb135e0b..b8599a4088843 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -835,7 +835,7 @@ struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder)
 		 * used in blkdev_get/put().
 		 */
 		if ((mode & FMODE_WRITE) && !bdev->bd_write_holder &&
-		    (disk->flags & GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE)) {
+		    (disk->event_flags & DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE)) {
 			bdev->bd_write_holder = true;
 			unblock_events = false;
 		}
diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 93ed636262328..6ac716e614e30 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -929,8 +929,8 @@ static int pcd_init_unit(struct pcd_unit *cd, bool autoprobe, int port,
 	disk->minors = 1;
 	strcpy(disk->disk_name, cd->name);	/* umm... */
 	disk->fops = &pcd_bdops;
-	disk->flags = GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE;
 	disk->events = DISK_EVENT_MEDIA_CHANGE;
+	disk->event_flags = DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE;
 
 	if (!pi_init(cd->pi, autoprobe, port, mode, unit, protocol, delay,
 			pcd_buffer, PI_PCD, verbose, cd->name))
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 652cd81d77753..af210910dadf2 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -684,9 +684,10 @@ static int sr_probe(struct device *dev)
 	disk->minors = 1;
 	sprintf(disk->disk_name, "sr%d", minor);
 	disk->fops = &sr_bdops;
-	disk->flags = GENHD_FL_CD | GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE;
+	disk->flags = GENHD_FL_CD;
 	disk->events = DISK_EVENT_MEDIA_CHANGE | DISK_EVENT_EJECT_REQUEST;
-	disk->event_flags = DISK_EVENT_FLAG_POLL | DISK_EVENT_FLAG_UEVENT;
+	disk->event_flags = DISK_EVENT_FLAG_POLL | DISK_EVENT_FLAG_UEVENT |
+				DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE;
 
 	blk_queue_rq_timeout(sdev->request_queue, SR_TIMEOUT);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 3234b43fefb5c..300f796b8773d 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -60,9 +60,6 @@ struct partition_meta_info {
  * (``BLOCK_EXT_MAJOR``).
  * This affects the maximum number of partitions.
  *
- * ``GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE`` (0x0100): event polling is
- * blocked whenever a writer holds an exclusive lock.
- *
  * ``GENHD_FL_NO_PART_SCAN`` (0x0200): partition scanning is disabled.
  * Used for loop devices in their default settings and some MMC
  * devices.
@@ -80,7 +77,6 @@ struct partition_meta_info {
 #define GENHD_FL_CD				0x0008
 #define GENHD_FL_SUPPRESS_PARTITION_INFO	0x0020
 #define GENHD_FL_EXT_DEVT			0x0040
-#define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
 #define GENHD_FL_NO_PART_SCAN			0x0200
 #define GENHD_FL_HIDDEN				0x0400
 
@@ -94,6 +90,8 @@ enum {
 	DISK_EVENT_FLAG_POLL			= 1 << 0,
 	/* Forward events to udev */
 	DISK_EVENT_FLAG_UEVENT			= 1 << 1,
+	/* Block event polling when open for exclusive write */
+	DISK_EVENT_FLAG_BLOCK_ON_EXCL_WRITE	= 1 << 2,
 };
 
 struct disk_events;
-- 
2.40.1




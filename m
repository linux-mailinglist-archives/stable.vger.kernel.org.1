Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E659F7A3D4D
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjIQUlH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241299AbjIQUkw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:40:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2BA710E
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:40:47 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D730DC433C8;
        Sun, 17 Sep 2023 20:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694983247;
        bh=kRmihp+Cgs/nZ1FbwlB+WoGxupWJB+2A10LA8mfTX2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dxZwdqTcMx4oHg2PmxOQ8AvLUp3QGN0ElI12iAeP7kF64riSKV8pe76YjggZ4z1yK
         VPRzXkqHC05rUFjZteNQAW6tupxxI3and6YbNLlSkFkYbVRKAQdOKLYfYtRvJv5GqQ
         ZIXhXAA2yCnP94KEiw+u8UI01N5kH7ROJ2sBk+Sc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 487/511] block: move GENHD_FL_NATIVE_CAPACITY to disk->state
Date:   Sun, 17 Sep 2023 21:15:14 +0200
Message-ID: <20230917191125.495788417@linuxfoundation.org>
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

[ Upstream commit 86416916466514e4ae0b7296d20133b6427c4c1f ]

The flag to indicate an unlocked native capacity is dynamic state,
not a driver capability flag, so move it to disk->state.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20211122130625.1136848-2-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 1a721de8489f ("block: don't add or resize partition on the disk with GENHD_FL_NO_PART")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/partitions/core.c | 15 ++++++---------
 include/linux/genhd.h   |  8 +-------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index b9e9af84f5188..1ead8c0015616 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -526,18 +526,15 @@ int bdev_resize_partition(struct gendisk *disk, int partno, sector_t start,
 
 static bool disk_unlock_native_capacity(struct gendisk *disk)
 {
-	const struct block_device_operations *bdops = disk->fops;
-
-	if (bdops->unlock_native_capacity &&
-	    !(disk->flags & GENHD_FL_NATIVE_CAPACITY)) {
-		printk(KERN_CONT "enabling native capacity\n");
-		bdops->unlock_native_capacity(disk);
-		disk->flags |= GENHD_FL_NATIVE_CAPACITY;
-		return true;
-	} else {
+	if (!disk->fops->unlock_native_capacity ||
+	    test_and_set_bit(GD_NATIVE_CAPACITY, &disk->state)) {
 		printk(KERN_CONT "truncated\n");
 		return false;
 	}
+
+	printk(KERN_CONT "enabling native capacity\n");
+	disk->fops->unlock_native_capacity(disk);
+	return true;
 }
 
 void blk_drop_partitions(struct gendisk *disk)
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 0b48a0cf42624..3234b43fefb5c 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -60,12 +60,6 @@ struct partition_meta_info {
  * (``BLOCK_EXT_MAJOR``).
  * This affects the maximum number of partitions.
  *
- * ``GENHD_FL_NATIVE_CAPACITY`` (0x0080): based on information in the
- * partition table, the device's capacity has been extended to its
- * native capacity; i.e. the device has hidden capacity used by one
- * of the partitions (this is a flag used so that native capacity is
- * only ever unlocked once).
- *
  * ``GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE`` (0x0100): event polling is
  * blocked whenever a writer holds an exclusive lock.
  *
@@ -86,7 +80,6 @@ struct partition_meta_info {
 #define GENHD_FL_CD				0x0008
 #define GENHD_FL_SUPPRESS_PARTITION_INFO	0x0020
 #define GENHD_FL_EXT_DEVT			0x0040
-#define GENHD_FL_NATIVE_CAPACITY		0x0080
 #define GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE	0x0100
 #define GENHD_FL_NO_PART_SCAN			0x0200
 #define GENHD_FL_HIDDEN				0x0400
@@ -140,6 +133,7 @@ struct gendisk {
 #define GD_NEED_PART_SCAN		0
 #define GD_READ_ONLY			1
 #define GD_DEAD				2
+#define GD_NATIVE_CAPACITY		3
 
 	struct mutex open_mutex;	/* open/close mutex */
 	unsigned open_partitions;	/* number of open partitions */
-- 
2.40.1




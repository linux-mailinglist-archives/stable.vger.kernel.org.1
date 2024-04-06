Return-Path: <stable+bounces-36162-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6693589A8E4
	for <lists+stable@lfdr.de>; Sat,  6 Apr 2024 06:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB682835D6
	for <lists+stable@lfdr.de>; Sat,  6 Apr 2024 04:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162CC18EA5;
	Sat,  6 Apr 2024 04:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mnf0g/2R"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2EB12E55
	for <stable@vger.kernel.org>; Sat,  6 Apr 2024 04:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712378808; cv=none; b=sBHX4pEyv98QNY2KvUs34z9aeptfBS8og1wEeZ1pmNBZlIfEH+nCBGARuE1pUgufm2MUZsCbaKP2WLGFdfM61I7ovbzAKEpHM2ZA+EGigIjgIg1ORm5wm+8lSNeK0HWlFDR/LMKPT2wX2YfAppj1f6G9cAR/toKKv0Y92Ur2rYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712378808; c=relaxed/simple;
	bh=Pa+glBIAYGUeYvj4bbkUW/0xQGcg4XhjmjmYm9pBmZA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D8Ak5U7yLA5PJ3VEeWMKLshaYkBDVFxW2P2LcAngnU/rmIuO7ZortBUb7UcYmyR2gTAYb1wT9e8MoDQobBP77NSrETWjZWWviS+VX3E81Ap5EKxl8TZfoNG4kGIC7ZD1nE5RSY+Av1imSYoy+EBEq/Ov4x4NB+zZO7NR4uLuBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mnf0g/2R; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saranyamohan.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61517841a2eso48619817b3.2
        for <stable@vger.kernel.org>; Fri, 05 Apr 2024 21:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712378806; x=1712983606; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tIhiZai/XuhGKAO7L+OPGtFolltjq5ipvv/SRv/Vr7Q=;
        b=Mnf0g/2RLooUEyF/mevFn7IKuVAP23dGQzKJDC+4txu8zhFS7YOjqak1eA+Gm1kTj5
         Mh4u1Y+HRYVdKiCCrfmLcverMZ6khm19uYL5z5isa9j6ytEAdCAsu7wgEVcTPmSBXbjP
         ChAjNELIEC5vN0QiQ8ctePkPe1AxtL4LeSVQEnuT3Ps7noUYLeRZHB8F3jKQxGLTkNGB
         iX82Zdn1AH+8gThTIZZNKI9JpsgM7RAkwaBMJAUZiA0TRyUOVwBNYt4qWT6q8Q6G5I87
         tfry+R/4lC3MizL5DP+DkCBf/MSCF5dLD1S/g3vwhmdFHyaESA4opAbhoNGi1HARgNc2
         SfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712378806; x=1712983606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIhiZai/XuhGKAO7L+OPGtFolltjq5ipvv/SRv/Vr7Q=;
        b=vHGg+9iVJfISrqbpbxSzfZT6Jo5RH3LDY/m7fFm3HFeLCWRVWQh/isJgIYbNTA0p0g
         0s0GLH4lIulgielmjLtocll960c8Zm42OChQDffkoAqySTc72qesja7GOUN94Xlnxwda
         V+LrfpjBs18Dhw4HpvowvA0QSkd1/KqIuEX378H0sT8l4/MQtSm+97uRhD2rH6QFxx1+
         bB4zEDCEMXv3zSS54N9EustiZ8TpfwzKgLDqaKKeyn58y8TTFEcjgqnK9rdOnhM4QaV8
         F0W0uMgH93p/ahF6wmMrj+ArnmbbJI/o5BbglyMo2O6RZv9KSL33pT+oqAMEs/L47/b0
         QFCw==
X-Forwarded-Encrypted: i=1; AJvYcCV0n9nJ/GhzJlN0vd2SSSDVyz1PRdLDyDbQvUiTo4he3PESIwkw+bIaWnpIgEc04MLHy1pT+PDLHscrws5SkcRnN9VTOmZR
X-Gm-Message-State: AOJu0YwzwGzNKKhT5yDM7jYb2HUtJITYQk4vKxJIZiV14NRzcZtqvnqG
	hOrtB4Kb6EylOXvmCcs9VvkW72Mbtl3LrtaCqi2L1wTDTq5bEBzZPimqEOOckQd0Ad1eUW/BBd2
	yzsBWcD+Ij1PljfYixFF6rFEQbw==
X-Google-Smtp-Source: AGHT+IH8o09JKg5ZtCJKPS59RQeXuArqA/XwGlDrtkB/c4fbBs7RTuImDTcRIF6jeh9pgqyE8L2cGcClE7x9pZPYXz8=
X-Received: from srnym.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2728])
 (user=saranyamohan job=sendgmr) by 2002:a0d:e251:0:b0:615:134c:7ef3 with SMTP
 id l78-20020a0de251000000b00615134c7ef3mr805341ywe.9.1712378806373; Fri, 05
 Apr 2024 21:46:46 -0700 (PDT)
Date: Sat,  6 Apr 2024 04:46:43 +0000
In-Reply-To: <20240405065333.GB4023@lst.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405065333.GB4023@lst.de>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240406044643.2475360-1-saranyamohan@google.com>
Subject: [PATCH] block: Fix BLKRRPART regression
From: Saranya Muruganandam <saranyamohan@google.com>
To: hch@lst.de
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	saranyamohan@google.com, stable@vger.kernel.org, tj@kernel.org, 
	yukuai1@huaweicloud.com
Content-Type: text/plain; charset="UTF-8"

The BLKRRPART ioctl used to report errors such as EIO before we changed
the blkdev_reread_part() logic.

Lets add a flag and capture the errors returned by bdev_disk_changed()
when the flag is set. Setting this flag for the BLKRRPART path when we
want the errors to be reported when rereading partitions on the disk.

Link: https://lore.kernel.org/all/20240320015134.GA14267@lst.de/
Suggested-by: Christoph Hellwig <hch@lst.de>
Tested: Tested by simulating failure to the block device and will
propose a new test to blktests.
Fixes: 4601b4b130de ("block: reopen the device in blkdev_reread_part")
Reported-by: Saranya Muruganandam <saranyamohan@google.com>
Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

Change-Id: Idf3d97390ed78061556f8468d10d6cab24ae20b1
---
 block/bdev.c           | 29 +++++++++++++++++++----------
 block/ioctl.c          |  3 ++-
 include/linux/blkdev.h |  2 ++
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 7a5f611c3d2e3..42940bced33bb 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -652,6 +652,14 @@ static void blkdev_flush_mapping(struct block_device *bdev)
 	bdev_write_inode(bdev);
 }
 
+static void blkdev_put_whole(struct block_device *bdev)
+{
+	if (atomic_dec_and_test(&bdev->bd_openers))
+		blkdev_flush_mapping(bdev);
+	if (bdev->bd_disk->fops->release)
+		bdev->bd_disk->fops->release(bdev->bd_disk);
+}
+
 static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 {
 	struct gendisk *disk = bdev->bd_disk;
@@ -670,20 +678,21 @@ static int blkdev_get_whole(struct block_device *bdev, blk_mode_t mode)
 
 	if (!atomic_read(&bdev->bd_openers))
 		set_init_blocksize(bdev);
-	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
-		bdev_disk_changed(disk, false);
 	atomic_inc(&bdev->bd_openers);
+	if (test_bit(GD_NEED_PART_SCAN, &disk->state)) {
+		/*
+		 * Only return scanning errors if we are called from conexts
+		 * that explicitly want them, e.g. the BLKRRPART ioctl.
+		 */
+		ret = bdev_disk_changed(disk, false);
+		if (ret && (mode & BLK_OPEN_STRICT_SCAN)) {
+			blkdev_put_whole(bdev);
+			return ret;
+		}
+	}
 	return 0;
 }
 
-static void blkdev_put_whole(struct block_device *bdev)
-{
-	if (atomic_dec_and_test(&bdev->bd_openers))
-		blkdev_flush_mapping(bdev);
-	if (bdev->bd_disk->fops->release)
-		bdev->bd_disk->fops->release(bdev->bd_disk);
-}
-
 static int blkdev_get_part(struct block_device *part, blk_mode_t mode)
 {
 	struct gendisk *disk = part->bd_disk;
diff --git a/block/ioctl.c b/block/ioctl.c
index 0c76137adcaaa..128f503828cee 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -562,7 +562,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, blk_mode_t mode,
 			return -EACCES;
 		if (bdev_is_partition(bdev))
 			return -EINVAL;
-		return disk_scan_partitions(bdev->bd_disk, mode);
+		return disk_scan_partitions(bdev->bd_disk,
+				mode | BLK_OPEN_STRICT_SCAN);
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c3e8f7cf96be9..3ed5e03109c29 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -128,6 +128,8 @@ typedef unsigned int __bitwise blk_mode_t;
 #define BLK_OPEN_WRITE_IOCTL	((__force blk_mode_t)(1 << 4))
 /* open is exclusive wrt all other BLK_OPEN_WRITE opens to the device */
 #define BLK_OPEN_RESTRICT_WRITES	((__force blk_mode_t)(1 << 5))
+/* return partition scanning errors */
+#define BLK_OPEN_STRICT_SCAN	((__force blk_mode_t)(1 << 5))
 
 struct gendisk {
 	/*
-- 
2.44.0.478.gd926399ef9-goog



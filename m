Return-Path: <stable+bounces-18463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A36ED8482D1
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C42828BBC8
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D6D4EB44;
	Sat,  3 Feb 2024 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qwFuefPZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609DA1C2BD;
	Sat,  3 Feb 2024 04:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933817; cv=none; b=iI3VO2ZYebGLQiM1iufEveoayVgndD94y+QEU5FcUEBagnuZY0bjfMadrj1MQZmyySoxM/GSzKX6mC9gRGAW6tgAE6HCQX9aoGL5qI4Y1ish3eg2bBA3Wd6F4FA/CRlTVgxS+zUTJFABrW5fuiDTvH0NK7AtPnWaDUECjgzyL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933817; c=relaxed/simple;
	bh=EEX2GxeU0rggRXpt1DYC2XmHgvQHI1k5e4mdOrPapmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gZjpiGikp4n6tkUwFQvHVu+Bwgie5wb7w8oO9LSMNyeraYoHq1FqoYiRbZL9f4gKdhZj++djsoWnJVOqBYLeslqh+M/nwbV2L7BCKMNwUiybPkzrGeM7c3CP+aUQgwX8v2+KMj5nycxhDNKAOncCDKUMB+k/CEZBBlENkxYgAuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qwFuefPZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28F73C43390;
	Sat,  3 Feb 2024 04:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933817;
	bh=EEX2GxeU0rggRXpt1DYC2XmHgvQHI1k5e4mdOrPapmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qwFuefPZJ8DkOXvsbI7d9CsCNQXOiyA5sMmdD1hdxBXfAlbhvPgqxjlw4mfwikDCq
	 dbDhOMS1/TgY5zWXUOXCIFTfQvojFYfnEdYimoueFr4ddmbXdi+FZqoZh519dvu7Gt
	 VkoCCM/5LExXQ5ttTsUE7HSx5JJ+mCObw5ib9PMI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Lyakas <alex.lyakas@zadara.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 135/353] md: Whenassemble the array, consult the superblock of the freshest device
Date: Fri,  2 Feb 2024 20:04:13 -0800
Message-ID: <20240203035407.986327263@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035403.657508530@linuxfoundation.org>
References: <20240203035403.657508530@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Lyakas <alex.lyakas@zadara.com>

[ Upstream commit dc1cc22ed58f11d58d8553c5ec5f11cbfc3e3039 ]

Upon assembling the array, both kernel and mdadm allow the devices to have event
counter difference of 1, and still consider them as up-to-date.
However, a device whose event count is behind by 1, may in fact not be up-to-date,
and array resync with such a device may cause data corruption.
To avoid this, consult the superblock of the freshest device about the status
of a device, whose event counter is behind by 1.

Signed-off-by: Alex Lyakas <alex.lyakas@zadara.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/1702470271-16073-1-git-send-email-alex.lyakas@zadara.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 54 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 22b54788bcea..21b04607d53a 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1219,6 +1219,7 @@ struct super_type  {
 					  struct md_rdev *refdev,
 					  int minor_version);
 	int		    (*validate_super)(struct mddev *mddev,
+					      struct md_rdev *freshest,
 					      struct md_rdev *rdev);
 	void		    (*sync_super)(struct mddev *mddev,
 					  struct md_rdev *rdev);
@@ -1356,8 +1357,9 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 
 /*
  * validate_super for 0.90.0
+ * note: we are not using "freshest" for 0.9 superblock
  */
-static int super_90_validate(struct mddev *mddev, struct md_rdev *rdev)
+static int super_90_validate(struct mddev *mddev, struct md_rdev *freshest, struct md_rdev *rdev)
 {
 	mdp_disk_t *desc;
 	mdp_super_t *sb = page_address(rdev->sb_page);
@@ -1869,7 +1871,7 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 	return ret;
 }
 
-static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
+static int super_1_validate(struct mddev *mddev, struct md_rdev *freshest, struct md_rdev *rdev)
 {
 	struct mdp_superblock_1 *sb = page_address(rdev->sb_page);
 	__u64 ev1 = le64_to_cpu(sb->events);
@@ -1965,13 +1967,15 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 		}
 	} else if (mddev->pers == NULL) {
 		/* Insist of good event counter while assembling, except for
-		 * spares (which don't need an event count) */
-		++ev1;
+		 * spares (which don't need an event count).
+		 * Similar to mdadm, we allow event counter difference of 1
+		 * from the freshest device.
+		 */
 		if (rdev->desc_nr >= 0 &&
 		    rdev->desc_nr < le32_to_cpu(sb->max_dev) &&
 		    (le16_to_cpu(sb->dev_roles[rdev->desc_nr]) < MD_DISK_ROLE_MAX ||
 		     le16_to_cpu(sb->dev_roles[rdev->desc_nr]) == MD_DISK_ROLE_JOURNAL))
-			if (ev1 < mddev->events)
+			if (ev1 + 1 < mddev->events)
 				return -EINVAL;
 	} else if (mddev->bitmap) {
 		/* If adding to array with a bitmap, then we can accept an
@@ -1992,8 +1996,38 @@ static int super_1_validate(struct mddev *mddev, struct md_rdev *rdev)
 		    rdev->desc_nr >= le32_to_cpu(sb->max_dev)) {
 			role = MD_DISK_ROLE_SPARE;
 			rdev->desc_nr = -1;
-		} else
+		} else if (mddev->pers == NULL && freshest && ev1 < mddev->events) {
+			/*
+			 * If we are assembling, and our event counter is smaller than the
+			 * highest event counter, we cannot trust our superblock about the role.
+			 * It could happen that our rdev was marked as Faulty, and all other
+			 * superblocks were updated with +1 event counter.
+			 * Then, before the next superblock update, which typically happens when
+			 * remove_and_add_spares() removes the device from the array, there was
+			 * a crash or reboot.
+			 * If we allow current rdev without consulting the freshest superblock,
+			 * we could cause data corruption.
+			 * Note that in this case our event counter is smaller by 1 than the
+			 * highest, otherwise, this rdev would not be allowed into array;
+			 * both kernel and mdadm allow event counter difference of 1.
+			 */
+			struct mdp_superblock_1 *freshest_sb = page_address(freshest->sb_page);
+			u32 freshest_max_dev = le32_to_cpu(freshest_sb->max_dev);
+
+			if (rdev->desc_nr >= freshest_max_dev) {
+				/* this is unexpected, better not proceed */
+				pr_warn("md: %s: rdev[%pg]: desc_nr(%d) >= freshest(%pg)->sb->max_dev(%u)\n",
+						mdname(mddev), rdev->bdev, rdev->desc_nr,
+						freshest->bdev, freshest_max_dev);
+				return -EUCLEAN;
+			}
+
+			role = le16_to_cpu(freshest_sb->dev_roles[rdev->desc_nr]);
+			pr_debug("md: %s: rdev[%pg]: role=%d(0x%x) according to freshest %pg\n",
+				     mdname(mddev), rdev->bdev, role, role, freshest->bdev);
+		} else {
 			role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
+		}
 		switch(role) {
 		case MD_DISK_ROLE_SPARE: /* spare */
 			break;
@@ -2900,7 +2934,7 @@ static int add_bound_rdev(struct md_rdev *rdev)
 		 * and should be added immediately.
 		 */
 		super_types[mddev->major_version].
-			validate_super(mddev, rdev);
+			validate_super(mddev, NULL/*freshest*/, rdev);
 		err = mddev->pers->hot_add_disk(mddev, rdev);
 		if (err) {
 			md_kick_rdev_from_array(rdev);
@@ -3837,7 +3871,7 @@ static int analyze_sbs(struct mddev *mddev)
 	}
 
 	super_types[mddev->major_version].
-		validate_super(mddev, freshest);
+		validate_super(mddev, NULL/*freshest*/, freshest);
 
 	i = 0;
 	rdev_for_each_safe(rdev, tmp, mddev) {
@@ -3852,7 +3886,7 @@ static int analyze_sbs(struct mddev *mddev)
 		}
 		if (rdev != freshest) {
 			if (super_types[mddev->major_version].
-			    validate_super(mddev, rdev)) {
+			    validate_super(mddev, freshest, rdev)) {
 				pr_warn("md: kicking non-fresh %pg from array!\n",
 					rdev->bdev);
 				md_kick_rdev_from_array(rdev);
@@ -6843,7 +6877,7 @@ int md_add_new_disk(struct mddev *mddev, struct mdu_disk_info_s *info)
 			rdev->saved_raid_disk = rdev->raid_disk;
 		} else
 			super_types[mddev->major_version].
-				validate_super(mddev, rdev);
+				validate_super(mddev, NULL/*freshest*/, rdev);
 		if ((info->state & (1<<MD_DISK_SYNC)) &&
 		     rdev->raid_disk != info->raid_disk) {
 			/* This was a hot-add request, but events doesn't
-- 
2.43.0





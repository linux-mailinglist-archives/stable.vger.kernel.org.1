Return-Path: <stable+bounces-107598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 412C0A02CA1
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C7EB161A2D
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE81553BB;
	Mon,  6 Jan 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZaK/3dtQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985AA81728;
	Mon,  6 Jan 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736178954; cv=none; b=exm6S/BLsUkC29GqxK612V6fnqIYll9dJ+kThbKNw1xm6EjtMz8f3ICFeyyrEuupT9HB0N92m0D+x0+rFFZD0smSxI64XFqekrC5jjDIrmTX1cDJdgc5Qaf8WqBnAoXfb3ju7TuXgsUtAZrpIm8KTbQOzXeJcy7piOXZv6DEcC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736178954; c=relaxed/simple;
	bh=ufi2Skh8cgXpJ+trRKLfzq+IjUlbtBg6bxJKfQ96PaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdIsQ/ezTsdZ03kN5XSsJgsv0hf75G1OTNmlqu4XfaYfMZlztAZs0qJaukymRbnHK1SFNAJyvNmPLv841+gO0OIJ5CTWNQZXc4el7MujU3UlaegMlYHB8zaCrNULO1jmvUPZI8YBSObNQjd1fMnkr6CnbEiJFb2NjyYmSPYJ0xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZaK/3dtQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBBCC4CED2;
	Mon,  6 Jan 2025 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736178954;
	bh=ufi2Skh8cgXpJ+trRKLfzq+IjUlbtBg6bxJKfQ96PaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZaK/3dtQ7ZPcNY2ukvCBeuRNjYvTYwL+tNrCcOwl2VTc7TMtem6z/IK8aLPF9TXJW
	 AZxanENZUS61mu92VL/8OK2tdwisE/lQplh41wWdjcSTCktewkzIJSIXos35KuPWZj
	 9Q5CbBqxayRl63q2toZWEMxucve5tsY9W+Otne2k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Josef Bacik <josef@toxicpanda.com>,
	Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 147/168] btrfs: sysfs: convert scnprintf and snprintf to sysfs_emit
Date: Mon,  6 Jan 2025 16:17:35 +0100
Message-ID: <20250106151143.988939576@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151138.451846855@linuxfoundation.org>
References: <20250106151138.451846855@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit 020e5277583dc26d7a5322ff2d334c764ac1faa8 ]

Commit 2efc459d06f1 ("sysfs: Add sysfs_emit and sysfs_emit_at to format
sysfs out") merged in 5.10 introduced two new functions sysfs_emit() and
sysfs_emit_at() which are aware of the PAGE_SIZE limit of the output
buffer.

Use the above two new functions instead of scnprintf() and snprintf()
in various sysfs show().

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: fca432e73db2 ("btrfs: sysfs: fix direct super block member reads")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/sysfs.c | 93 +++++++++++++++++++++++-------------------------
 1 file changed, 44 insertions(+), 49 deletions(-)

diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
index 93a9dfbc8d13..bc8d5b4c279e 100644
--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -177,7 +177,7 @@ static ssize_t btrfs_feature_attr_show(struct kobject *kobj,
 	} else
 		val = can_modify_feature(fa);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t btrfs_feature_attr_store(struct kobject *kobj,
@@ -333,7 +333,7 @@ static const struct attribute_group btrfs_feature_attr_group = {
 static ssize_t rmdir_subvol_show(struct kobject *kobj,
 				 struct kobj_attribute *ka, char *buf)
 {
-	return scnprintf(buf, PAGE_SIZE, "0\n");
+	return sysfs_emit(buf, "0\n");
 }
 BTRFS_ATTR(static_feature, rmdir_subvol, rmdir_subvol_show);
 
@@ -348,12 +348,12 @@ static ssize_t supported_checksums_show(struct kobject *kobj,
 		 * This "trick" only works as long as 'enum btrfs_csum_type' has
 		 * no holes in it
 		 */
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
-				(i == 0 ? "" : " "), btrfs_super_csum_name(i));
+		ret += sysfs_emit_at(buf, ret, "%s%s", (i == 0 ? "" : " "),
+				     btrfs_super_csum_name(i));
 
 	}
 
-	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+	ret += sysfs_emit_at(buf, ret, "\n");
 	return ret;
 }
 BTRFS_ATTR(static_feature, supported_checksums, supported_checksums_show);
@@ -361,7 +361,7 @@ BTRFS_ATTR(static_feature, supported_checksums, supported_checksums_show);
 static ssize_t send_stream_version_show(struct kobject *kobj,
 					struct kobj_attribute *ka, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", BTRFS_SEND_STREAM_VERSION);
+	return sysfs_emit(buf, "%d\n", BTRFS_SEND_STREAM_VERSION);
 }
 BTRFS_ATTR(static_feature, send_stream_version, send_stream_version_show);
 
@@ -381,9 +381,8 @@ static ssize_t supported_rescue_options_show(struct kobject *kobj,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(rescue_opts); i++)
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%s%s",
-				 (i ? " " : ""), rescue_opts[i]);
-	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "\n");
+		ret += sysfs_emit_at(buf, ret, "%s%s", (i ? " " : ""), rescue_opts[i]);
+	ret += sysfs_emit_at(buf, ret, "\n");
 	return ret;
 }
 BTRFS_ATTR(static_feature, supported_rescue_options,
@@ -397,10 +396,10 @@ static ssize_t supported_sectorsizes_show(struct kobject *kobj,
 
 	/* 4K sector size is also supported with 64K page size */
 	if (PAGE_SIZE == SZ_64K)
-		ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%u ", SZ_4K);
+		ret += sysfs_emit_at(buf, ret, "%u ", SZ_4K);
 
 	/* Only sectorsize == PAGE_SIZE is now supported */
-	ret += scnprintf(buf + ret, PAGE_SIZE - ret, "%lu\n", PAGE_SIZE);
+	ret += sysfs_emit_at(buf, ret, "%lu\n", PAGE_SIZE);
 
 	return ret;
 }
@@ -440,7 +439,7 @@ static ssize_t btrfs_discardable_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%lld\n",
+	return sysfs_emit(buf, "%lld\n",
 			atomic64_read(&fs_info->discard_ctl.discardable_bytes));
 }
 BTRFS_ATTR(discard, discardable_bytes, btrfs_discardable_bytes_show);
@@ -451,7 +450,7 @@ static ssize_t btrfs_discardable_extents_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n",
+	return sysfs_emit(buf, "%d\n",
 			atomic_read(&fs_info->discard_ctl.discardable_extents));
 }
 BTRFS_ATTR(discard, discardable_extents, btrfs_discardable_extents_show);
@@ -462,8 +461,8 @@ static ssize_t btrfs_discard_bitmap_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n",
-			fs_info->discard_ctl.discard_bitmap_bytes);
+	return sysfs_emit(buf, "%llu\n",
+			  fs_info->discard_ctl.discard_bitmap_bytes);
 }
 BTRFS_ATTR(discard, discard_bitmap_bytes, btrfs_discard_bitmap_bytes_show);
 
@@ -473,7 +472,7 @@ static ssize_t btrfs_discard_bytes_saved_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%lld\n",
+	return sysfs_emit(buf, "%lld\n",
 		atomic64_read(&fs_info->discard_ctl.discard_bytes_saved));
 }
 BTRFS_ATTR(discard, discard_bytes_saved, btrfs_discard_bytes_saved_show);
@@ -484,8 +483,8 @@ static ssize_t btrfs_discard_extent_bytes_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n",
-			fs_info->discard_ctl.discard_extent_bytes);
+	return sysfs_emit(buf, "%llu\n",
+			  fs_info->discard_ctl.discard_extent_bytes);
 }
 BTRFS_ATTR(discard, discard_extent_bytes, btrfs_discard_extent_bytes_show);
 
@@ -495,8 +494,8 @@ static ssize_t btrfs_discard_iops_limit_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			READ_ONCE(fs_info->discard_ctl.iops_limit));
+	return sysfs_emit(buf, "%u\n",
+			  READ_ONCE(fs_info->discard_ctl.iops_limit));
 }
 
 static ssize_t btrfs_discard_iops_limit_store(struct kobject *kobj,
@@ -526,8 +525,8 @@ static ssize_t btrfs_discard_kbps_limit_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			READ_ONCE(fs_info->discard_ctl.kbps_limit));
+	return sysfs_emit(buf, "%u\n",
+			  READ_ONCE(fs_info->discard_ctl.kbps_limit));
 }
 
 static ssize_t btrfs_discard_kbps_limit_store(struct kobject *kobj,
@@ -556,8 +555,8 @@ static ssize_t btrfs_discard_max_discard_size_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = discard_to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n",
-			READ_ONCE(fs_info->discard_ctl.max_discard_size));
+	return sysfs_emit(buf, "%llu\n",
+			  READ_ONCE(fs_info->discard_ctl.max_discard_size));
 }
 
 static ssize_t btrfs_discard_max_discard_size_store(struct kobject *kobj,
@@ -630,7 +629,7 @@ static ssize_t btrfs_show_u64(u64 *value_ptr, spinlock_t *lock, char *buf)
 	val = *value_ptr;
 	if (lock)
 		spin_unlock(lock);
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
+	return sysfs_emit(buf, "%llu\n", val);
 }
 
 static ssize_t global_rsv_size_show(struct kobject *kobj,
@@ -676,7 +675,7 @@ static ssize_t raid_bytes_show(struct kobject *kobj,
 			val += block_group->used;
 	}
 	up_read(&sinfo->groups_sem);
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", val);
+	return sysfs_emit(buf, "%llu\n", val);
 }
 
 /*
@@ -774,7 +773,7 @@ static ssize_t btrfs_label_show(struct kobject *kobj,
 	ssize_t ret;
 
 	spin_lock(&fs_info->super_lock);
-	ret = scnprintf(buf, PAGE_SIZE, label[0] ? "%s\n" : "%s", label);
+	ret = sysfs_emit(buf, label[0] ? "%s\n" : "%s", label);
 	spin_unlock(&fs_info->super_lock);
 
 	return ret;
@@ -822,7 +821,7 @@ static ssize_t btrfs_nodesize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->nodesize);
+	return sysfs_emit(buf, "%u\n", fs_info->super_copy->nodesize);
 }
 
 BTRFS_ATTR(, nodesize, btrfs_nodesize_show);
@@ -832,8 +831,7 @@ static ssize_t btrfs_sectorsize_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
-			 fs_info->super_copy->sectorsize);
+	return sysfs_emit(buf, "%u\n", fs_info->super_copy->sectorsize);
 }
 
 BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
@@ -843,7 +841,7 @@ static ssize_t btrfs_clone_alignment_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->sectorsize);
+	return sysfs_emit(buf, "%u\n", fs_info->super_copy->sectorsize);
 }
 
 BTRFS_ATTR(, clone_alignment, btrfs_clone_alignment_show);
@@ -855,7 +853,7 @@ static ssize_t quota_override_show(struct kobject *kobj,
 	int quota_override;
 
 	quota_override = test_bit(BTRFS_FS_QUOTA_OVERRIDE, &fs_info->flags);
-	return scnprintf(buf, PAGE_SIZE, "%d\n", quota_override);
+	return sysfs_emit(buf, "%d\n", quota_override);
 }
 
 static ssize_t quota_override_store(struct kobject *kobj,
@@ -893,8 +891,7 @@ static ssize_t btrfs_metadata_uuid_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%pU\n",
-			fs_info->fs_devices->metadata_uuid);
+	return sysfs_emit(buf, "%pU\n", fs_info->fs_devices->metadata_uuid);
 }
 
 BTRFS_ATTR(, metadata_uuid, btrfs_metadata_uuid_show);
@@ -905,9 +902,9 @@ static ssize_t btrfs_checksum_show(struct kobject *kobj,
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 	u16 csum_type = btrfs_super_csum_type(fs_info->super_copy);
 
-	return scnprintf(buf, PAGE_SIZE, "%s (%s)\n",
-			btrfs_super_csum_name(csum_type),
-			crypto_shash_driver_name(fs_info->csum_shash));
+	return sysfs_emit(buf, "%s (%s)\n",
+			  btrfs_super_csum_name(csum_type),
+			  crypto_shash_driver_name(fs_info->csum_shash));
 }
 
 BTRFS_ATTR(, checksum, btrfs_checksum_show);
@@ -944,7 +941,7 @@ static ssize_t btrfs_exclusive_operation_show(struct kobject *kobj,
 			str = "UNKNOWN\n";
 			break;
 	}
-	return scnprintf(buf, PAGE_SIZE, "%s", str);
+	return sysfs_emit(buf, "%s", str);
 }
 BTRFS_ATTR(, exclusive_operation, btrfs_exclusive_operation_show);
 
@@ -953,7 +950,7 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n", fs_info->generation);
+	return sysfs_emit(buf, "%llu\n", fs_info->generation);
 }
 BTRFS_ATTR(, generation, btrfs_generation_show);
 
@@ -1031,8 +1028,7 @@ static ssize_t btrfs_bg_reclaim_threshold_show(struct kobject *kobj,
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 	ssize_t ret;
 
-	ret = scnprintf(buf, PAGE_SIZE, "%d\n",
-			READ_ONCE(fs_info->bg_reclaim_threshold));
+	ret = sysfs_emit(buf, "%d\n", READ_ONCE(fs_info->bg_reclaim_threshold));
 
 	return ret;
 }
@@ -1474,7 +1470,7 @@ static ssize_t btrfs_devinfo_in_fs_metadata_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 BTRFS_ATTR(devid, in_fs_metadata, btrfs_devinfo_in_fs_metadata_show);
 
@@ -1487,7 +1483,7 @@ static ssize_t btrfs_devinfo_missing_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 BTRFS_ATTR(devid, missing, btrfs_devinfo_missing_show);
 
@@ -1501,7 +1497,7 @@ static ssize_t btrfs_devinfo_replace_target_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 BTRFS_ATTR(devid, replace_target, btrfs_devinfo_replace_target_show);
 
@@ -1512,8 +1508,7 @@ static ssize_t btrfs_devinfo_scrub_speed_max_show(struct kobject *kobj,
 	struct btrfs_device *device = container_of(kobj, struct btrfs_device,
 						   devid_kobj);
 
-	return scnprintf(buf, PAGE_SIZE, "%llu\n",
-			 READ_ONCE(device->scrub_speed_max));
+	return sysfs_emit(buf, "%llu\n", READ_ONCE(device->scrub_speed_max));
 }
 
 static ssize_t btrfs_devinfo_scrub_speed_max_store(struct kobject *kobj,
@@ -1545,7 +1540,7 @@ static ssize_t btrfs_devinfo_writeable_show(struct kobject *kobj,
 
 	val = !!test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 BTRFS_ATTR(devid, writeable, btrfs_devinfo_writeable_show);
 
@@ -1556,14 +1551,14 @@ static ssize_t btrfs_devinfo_error_stats_show(struct kobject *kobj,
 						   devid_kobj);
 
 	if (!device->dev_stats_valid)
-		return scnprintf(buf, PAGE_SIZE, "invalid\n");
+		return sysfs_emit(buf, "invalid\n");
 
 	/*
 	 * Print all at once so we get a snapshot of all values from the same
 	 * time. Keep them in sync and in order of definition of
 	 * btrfs_dev_stat_values.
 	 */
-	return scnprintf(buf, PAGE_SIZE,
+	return sysfs_emit(buf,
 		"write_errs %d\n"
 		"read_errs %d\n"
 		"flush_errs %d\n"
-- 
2.39.5





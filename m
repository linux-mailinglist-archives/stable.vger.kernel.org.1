Return-Path: <stable+bounces-75601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4789735C9
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 12:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 614CAB236FA
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 10:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B71188A28;
	Tue, 10 Sep 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sm9XboR7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FEE23A6;
	Tue, 10 Sep 2024 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725965208; cv=none; b=gLePLtaQ4CyxgVJfAfZgGfQ9SeM+9H4mJ7WOlPAJQJ/HVjGYA5aGmmdTkJDFCtzU/o2loGcNXjVcy1LC58Dk0nYqKgfPUVYVf6GwWKpAwQV7uMagAS2W/nfEzFV5c5+OpyVsa6WU4ZQ6DLdThnmY3G9k5RAEHg9hfZzKIAX9WP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725965208; c=relaxed/simple;
	bh=V7f54r3LyVtNJ5oFf5sv6TMoDNoVjaSWxEi3Kfs8pWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D1zKTCcZXYjZZrctvy9jqDT0WkjSoY3AW84iMU1IRA5H0Ug6EmONG5IGA0UMjAzN6HYSDJDnmTensEEpuwQ1Cu8Jrfwjza2Q9QM2BazY0lRgIjlQ8BJ24NoJoha7s5J4j4Vlpm+dIUgDc9xbay6ZMWxsFwwr0QraY4LMegsdVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sm9XboR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1D9C4CEC3;
	Tue, 10 Sep 2024 10:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725965208;
	bh=V7f54r3LyVtNJ5oFf5sv6TMoDNoVjaSWxEi3Kfs8pWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sm9XboR7af5l6msZEBzKp5uC0ynTmCC/J7RSsOxxpvL2pHklej0IW7oRtKQ7A5zY3
	 SoklQ3oww5NDUjtLwyviSN7ju27QbuS0I7sZNWlXlYPHP9mnvfHjeieXxF1321QSj7
	 Mo6ykNQg0tGVbYB83YS35m2uSo9imJVJFbreQMvM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qing Wang <wangqing@vivo.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 173/186] nilfs2: replace snprintf in show functions with sysfs_emit
Date: Tue, 10 Sep 2024 11:34:28 +0200
Message-ID: <20240910092601.755275877@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092554.645718780@linuxfoundation.org>
References: <20240910092554.645718780@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qing Wang <wangqing@vivo.com>

[ Upstream commit 3bcd6c5bd483287f4a09d3d59a012d47677b6edc ]

Patch series "nilfs2 updates".

This patch (of 2):

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the coccicheck warning:

  WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Link: https://lkml.kernel.org/r/1635151862-11547-1-git-send-email-konishi.ryusuke@gmail.com
Link: https://lkml.kernel.org/r/1634095759-4625-1-git-send-email-wangqing@vivo.com
Link: https://lkml.kernel.org/r/1635151862-11547-2-git-send-email-konishi.ryusuke@gmail.com
Signed-off-by: Qing Wang <wangqing@vivo.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: 683408258917 ("nilfs2: protect references to superblock parameters exposed in sysfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/sysfs.c | 76 +++++++++++++++++++++++------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 57afd06db62d..63ab8f9e6db3 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -108,7 +108,7 @@ static ssize_t
 nilfs_snapshot_inodes_count_show(struct nilfs_snapshot_attr *attr,
 				 struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)atomic64_read(&root->inodes_count));
 }
 
@@ -116,7 +116,7 @@ static ssize_t
 nilfs_snapshot_blocks_count_show(struct nilfs_snapshot_attr *attr,
 				 struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)atomic64_read(&root->blocks_count));
 }
 
@@ -129,7 +129,7 @@ static ssize_t
 nilfs_snapshot_README_show(struct nilfs_snapshot_attr *attr,
 			    struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, snapshot_readme_str);
+	return sysfs_emit(buf, snapshot_readme_str);
 }
 
 NILFS_SNAPSHOT_RO_ATTR(inodes_count);
@@ -230,7 +230,7 @@ static ssize_t
 nilfs_mounted_snapshots_README_show(struct nilfs_mounted_snapshots_attr *attr,
 				    struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, mounted_snapshots_readme_str);
+	return sysfs_emit(buf, mounted_snapshots_readme_str);
 }
 
 NILFS_MOUNTED_SNAPSHOTS_RO_ATTR(README);
@@ -268,7 +268,7 @@ nilfs_checkpoints_checkpoints_number_show(struct nilfs_checkpoints_attr *attr,
 
 	ncheckpoints = cpstat.cs_ncps;
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", ncheckpoints);
+	return sysfs_emit(buf, "%llu\n", ncheckpoints);
 }
 
 static ssize_t
@@ -291,7 +291,7 @@ nilfs_checkpoints_snapshots_number_show(struct nilfs_checkpoints_attr *attr,
 
 	nsnapshots = cpstat.cs_nsss;
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nsnapshots);
+	return sysfs_emit(buf, "%llu\n", nsnapshots);
 }
 
 static ssize_t
@@ -305,7 +305,7 @@ nilfs_checkpoints_last_seg_checkpoint_show(struct nilfs_checkpoints_attr *attr,
 	last_cno = nilfs->ns_last_cno;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_cno);
+	return sysfs_emit(buf, "%llu\n", last_cno);
 }
 
 static ssize_t
@@ -319,7 +319,7 @@ nilfs_checkpoints_next_checkpoint_show(struct nilfs_checkpoints_attr *attr,
 	cno = nilfs->ns_cno;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", cno);
+	return sysfs_emit(buf, "%llu\n", cno);
 }
 
 static const char checkpoints_readme_str[] =
@@ -335,7 +335,7 @@ static ssize_t
 nilfs_checkpoints_README_show(struct nilfs_checkpoints_attr *attr,
 				struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, checkpoints_readme_str);
+	return sysfs_emit(buf, checkpoints_readme_str);
 }
 
 NILFS_CHECKPOINTS_RO_ATTR(checkpoints_number);
@@ -366,7 +366,7 @@ nilfs_segments_segments_number_show(struct nilfs_segments_attr *attr,
 				     struct the_nilfs *nilfs,
 				     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%lu\n", nilfs->ns_nsegments);
+	return sysfs_emit(buf, "%lu\n", nilfs->ns_nsegments);
 }
 
 static ssize_t
@@ -374,7 +374,7 @@ nilfs_segments_blocks_per_segment_show(struct nilfs_segments_attr *attr,
 					struct the_nilfs *nilfs,
 					char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%lu\n", nilfs->ns_blocks_per_segment);
+	return sysfs_emit(buf, "%lu\n", nilfs->ns_blocks_per_segment);
 }
 
 static ssize_t
@@ -388,7 +388,7 @@ nilfs_segments_clean_segments_show(struct nilfs_segments_attr *attr,
 	ncleansegs = nilfs_sufile_get_ncleansegs(nilfs->ns_sufile);
 	up_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", ncleansegs);
+	return sysfs_emit(buf, "%lu\n", ncleansegs);
 }
 
 static ssize_t
@@ -408,7 +408,7 @@ nilfs_segments_dirty_segments_show(struct nilfs_segments_attr *attr,
 		return err;
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", sustat.ss_ndirtysegs);
+	return sysfs_emit(buf, "%llu\n", sustat.ss_ndirtysegs);
 }
 
 static const char segments_readme_str[] =
@@ -424,7 +424,7 @@ nilfs_segments_README_show(struct nilfs_segments_attr *attr,
 			    struct the_nilfs *nilfs,
 			    char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, segments_readme_str);
+	return sysfs_emit(buf, segments_readme_str);
 }
 
 NILFS_SEGMENTS_RO_ATTR(segments_number);
@@ -461,7 +461,7 @@ nilfs_segctor_last_pseg_block_show(struct nilfs_segctor_attr *attr,
 	last_pseg = nilfs->ns_last_pseg;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)last_pseg);
 }
 
@@ -476,7 +476,7 @@ nilfs_segctor_last_seg_sequence_show(struct nilfs_segctor_attr *attr,
 	last_seq = nilfs->ns_last_seq;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_seq);
+	return sysfs_emit(buf, "%llu\n", last_seq);
 }
 
 static ssize_t
@@ -490,7 +490,7 @@ nilfs_segctor_last_seg_checkpoint_show(struct nilfs_segctor_attr *attr,
 	last_cno = nilfs->ns_last_cno;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_cno);
+	return sysfs_emit(buf, "%llu\n", last_cno);
 }
 
 static ssize_t
@@ -504,7 +504,7 @@ nilfs_segctor_current_seg_sequence_show(struct nilfs_segctor_attr *attr,
 	seg_seq = nilfs->ns_seg_seq;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", seg_seq);
+	return sysfs_emit(buf, "%llu\n", seg_seq);
 }
 
 static ssize_t
@@ -518,7 +518,7 @@ nilfs_segctor_current_last_full_seg_show(struct nilfs_segctor_attr *attr,
 	segnum = nilfs->ns_segnum;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", segnum);
+	return sysfs_emit(buf, "%llu\n", segnum);
 }
 
 static ssize_t
@@ -532,7 +532,7 @@ nilfs_segctor_next_full_seg_show(struct nilfs_segctor_attr *attr,
 	nextnum = nilfs->ns_nextnum;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nextnum);
+	return sysfs_emit(buf, "%llu\n", nextnum);
 }
 
 static ssize_t
@@ -546,7 +546,7 @@ nilfs_segctor_next_pseg_offset_show(struct nilfs_segctor_attr *attr,
 	pseg_offset = nilfs->ns_pseg_offset;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", pseg_offset);
+	return sysfs_emit(buf, "%lu\n", pseg_offset);
 }
 
 static ssize_t
@@ -560,7 +560,7 @@ nilfs_segctor_next_checkpoint_show(struct nilfs_segctor_attr *attr,
 	cno = nilfs->ns_cno;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", cno);
+	return sysfs_emit(buf, "%llu\n", cno);
 }
 
 static ssize_t
@@ -588,7 +588,7 @@ nilfs_segctor_last_seg_write_time_secs_show(struct nilfs_segctor_attr *attr,
 	ctime = nilfs->ns_ctime;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", ctime);
+	return sysfs_emit(buf, "%llu\n", ctime);
 }
 
 static ssize_t
@@ -616,7 +616,7 @@ nilfs_segctor_last_nongc_write_time_secs_show(struct nilfs_segctor_attr *attr,
 	nongc_ctime = nilfs->ns_nongc_ctime;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nongc_ctime);
+	return sysfs_emit(buf, "%llu\n", nongc_ctime);
 }
 
 static ssize_t
@@ -630,7 +630,7 @@ nilfs_segctor_dirty_data_blocks_count_show(struct nilfs_segctor_attr *attr,
 	ndirtyblks = atomic_read(&nilfs->ns_ndirtyblks);
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", ndirtyblks);
+	return sysfs_emit(buf, "%u\n", ndirtyblks);
 }
 
 static const char segctor_readme_str[] =
@@ -667,7 +667,7 @@ static ssize_t
 nilfs_segctor_README_show(struct nilfs_segctor_attr *attr,
 			  struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, segctor_readme_str);
+	return sysfs_emit(buf, segctor_readme_str);
 }
 
 NILFS_SEGCTOR_RO_ATTR(last_pseg_block);
@@ -736,7 +736,7 @@ nilfs_superblock_sb_write_time_secs_show(struct nilfs_superblock_attr *attr,
 	sbwtime = nilfs->ns_sbwtime;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", sbwtime);
+	return sysfs_emit(buf, "%llu\n", sbwtime);
 }
 
 static ssize_t
@@ -750,7 +750,7 @@ nilfs_superblock_sb_write_count_show(struct nilfs_superblock_attr *attr,
 	sbwcount = nilfs->ns_sbwcount;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", sbwcount);
+	return sysfs_emit(buf, "%u\n", sbwcount);
 }
 
 static ssize_t
@@ -764,7 +764,7 @@ nilfs_superblock_sb_update_frequency_show(struct nilfs_superblock_attr *attr,
 	sb_update_freq = nilfs->ns_sb_update_freq;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", sb_update_freq);
+	return sysfs_emit(buf, "%u\n", sb_update_freq);
 }
 
 static ssize_t
@@ -812,7 +812,7 @@ static ssize_t
 nilfs_superblock_README_show(struct nilfs_superblock_attr *attr,
 				struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, sb_readme_str);
+	return sysfs_emit(buf, sb_readme_str);
 }
 
 NILFS_SUPERBLOCK_RO_ATTR(sb_write_time);
@@ -847,7 +847,7 @@ ssize_t nilfs_dev_revision_show(struct nilfs_dev_attr *attr,
 	u32 major = le32_to_cpu(sbp[0]->s_rev_level);
 	u16 minor = le16_to_cpu(sbp[0]->s_minor_rev_level);
 
-	return snprintf(buf, PAGE_SIZE, "%d.%d\n", major, minor);
+	return sysfs_emit(buf, "%d.%d\n", major, minor);
 }
 
 static
@@ -855,7 +855,7 @@ ssize_t nilfs_dev_blocksize_show(struct nilfs_dev_attr *attr,
 				 struct the_nilfs *nilfs,
 				 char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", nilfs->ns_blocksize);
+	return sysfs_emit(buf, "%u\n", nilfs->ns_blocksize);
 }
 
 static
@@ -866,7 +866,7 @@ ssize_t nilfs_dev_device_size_show(struct nilfs_dev_attr *attr,
 	struct nilfs_super_block **sbp = nilfs->ns_sbp;
 	u64 dev_size = le64_to_cpu(sbp[0]->s_dev_size);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", dev_size);
+	return sysfs_emit(buf, "%llu\n", dev_size);
 }
 
 static
@@ -877,7 +877,7 @@ ssize_t nilfs_dev_free_blocks_show(struct nilfs_dev_attr *attr,
 	sector_t free_blocks = 0;
 
 	nilfs_count_free_blocks(nilfs, &free_blocks);
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)free_blocks);
 }
 
@@ -888,7 +888,7 @@ ssize_t nilfs_dev_uuid_show(struct nilfs_dev_attr *attr,
 {
 	struct nilfs_super_block **sbp = nilfs->ns_sbp;
 
-	return snprintf(buf, PAGE_SIZE, "%pUb\n", sbp[0]->s_uuid);
+	return sysfs_emit(buf, "%pUb\n", sbp[0]->s_uuid);
 }
 
 static
@@ -916,7 +916,7 @@ static ssize_t nilfs_dev_README_show(struct nilfs_dev_attr *attr,
 				     struct the_nilfs *nilfs,
 				     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, dev_readme_str);
+	return sysfs_emit(buf, dev_readme_str);
 }
 
 NILFS_DEV_RO_ATTR(revision);
@@ -1060,7 +1060,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
 static ssize_t nilfs_feature_revision_show(struct kobject *kobj,
 					    struct attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d.%d\n",
+	return sysfs_emit(buf, "%d.%d\n",
 			NILFS_CURRENT_REV, NILFS_MINOR_REV);
 }
 
@@ -1073,7 +1073,7 @@ static ssize_t nilfs_feature_README_show(struct kobject *kobj,
 					 struct attribute *attr,
 					 char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, features_readme_str);
+	return sysfs_emit(buf, features_readme_str);
 }
 
 NILFS_FEATURE_RO_ATTR(revision);
-- 
2.43.0





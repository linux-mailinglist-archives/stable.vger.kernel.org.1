Return-Path: <stable+bounces-6280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC8580D9D6
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 19:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECC0EB21915
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816C9524C6;
	Mon, 11 Dec 2023 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tkDS3vga"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF40E548;
	Mon, 11 Dec 2023 18:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3281C433C7;
	Mon, 11 Dec 2023 18:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702321001;
	bh=t65D/I6HruPNJ5zavfL5LxZWng+gtEeFGuDgn56ASjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tkDS3vgaCE+FqrYWRLB3k5n/MLB5a6e2vcywNVSyXF/2iW2f155KdWttdyPEiwM5B
	 cbcVglJdoR5k1C67cFdhz+sxy5np4v9FCsCjiCHGN8b7PgAI6p4fTys7l9hWKQJAMB
	 14wH+Cb9a6LNzsWtdbhgsM+qn1uwkzTb4/2UpW/I=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ye Bin <yebin10@huawei.com>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 074/141] md: introduce md_ro_state
Date: Mon, 11 Dec 2023 19:22:13 +0100
Message-ID: <20231211182029.776861932@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211182026.503492284@linuxfoundation.org>
References: <20231211182026.503492284@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit f97a5528b21eb175d90dce2df9960c8d08e1be82 ]

Introduce md_ro_state for mddev->ro, so it is easy to understand.

Signed-off-by: Ye Bin <yebin10@huawei.com>
Signed-off-by: Song Liu <song@kernel.org>
Stable-dep-of: c9f7cb5b2bc9 ("md: don't leave 'MD_RECOVERY_FROZEN' in error path of md_set_readonly()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c | 152 ++++++++++++++++++++++++++----------------------
 1 file changed, 82 insertions(+), 70 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index a2d9856365958..2d04073174782 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -92,6 +92,18 @@ static int remove_and_add_spares(struct mddev *mddev,
 				 struct md_rdev *this);
 static void mddev_detach(struct mddev *mddev);
 
+enum md_ro_state {
+	MD_RDWR,
+	MD_RDONLY,
+	MD_AUTO_READ,
+	MD_MAX_STATE
+};
+
+static bool md_is_rdwr(struct mddev *mddev)
+{
+	return (mddev->ro == MD_RDWR);
+}
+
 /*
  * Default number of read corrections we'll attempt on an rdev
  * before ejecting it from the array. We divide the read error
@@ -461,7 +473,7 @@ static blk_qc_t md_submit_bio(struct bio *bio)
 	if (!bio)
 		return BLK_QC_T_NONE;
 
-	if (mddev->ro == 1 && unlikely(rw == WRITE)) {
+	if (mddev->ro == MD_RDONLY && unlikely(rw == WRITE)) {
 		if (bio_sectors(bio) != 0)
 			bio->bi_status = BLK_STS_IOERR;
 		bio_endio(bio);
@@ -2680,7 +2692,7 @@ void md_update_sb(struct mddev *mddev, int force_change)
 	int any_badblocks_changed = 0;
 	int ret = -1;
 
-	if (mddev->ro) {
+	if (!md_is_rdwr(mddev)) {
 		if (force_change)
 			set_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags);
 		return;
@@ -3953,7 +3965,7 @@ level_store(struct mddev *mddev, const char *buf, size_t len)
 		goto out_unlock;
 	}
 	rv = -EROFS;
-	if (mddev->ro)
+	if (!md_is_rdwr(mddev))
 		goto out_unlock;
 
 	/* request to change the personality.  Need to ensure:
@@ -4159,7 +4171,7 @@ layout_store(struct mddev *mddev, const char *buf, size_t len)
 	if (mddev->pers) {
 		if (mddev->pers->check_reshape == NULL)
 			err = -EBUSY;
-		else if (mddev->ro)
+		else if (!md_is_rdwr(mddev))
 			err = -EROFS;
 		else {
 			mddev->new_layout = n;
@@ -4268,7 +4280,7 @@ chunk_size_store(struct mddev *mddev, const char *buf, size_t len)
 	if (mddev->pers) {
 		if (mddev->pers->check_reshape == NULL)
 			err = -EBUSY;
-		else if (mddev->ro)
+		else if (!md_is_rdwr(mddev))
 			err = -EROFS;
 		else {
 			mddev->new_chunk_sectors = n >> 9;
@@ -4391,13 +4403,13 @@ array_state_show(struct mddev *mddev, char *page)
 
 	if (mddev->pers && !test_bit(MD_NOT_READY, &mddev->flags)) {
 		switch(mddev->ro) {
-		case 1:
+		case MD_RDONLY:
 			st = readonly;
 			break;
-		case 2:
+		case MD_AUTO_READ:
 			st = read_auto;
 			break;
-		case 0:
+		case MD_RDWR:
 			spin_lock(&mddev->lock);
 			if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
 				st = write_pending;
@@ -4433,7 +4445,8 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 	int err = 0;
 	enum array_state st = match_word(buf, array_states);
 
-	if (mddev->pers && (st == active || st == clean) && mddev->ro != 1) {
+	if (mddev->pers && (st == active || st == clean) &&
+	    mddev->ro != MD_RDONLY) {
 		/* don't take reconfig_mutex when toggling between
 		 * clean and active
 		 */
@@ -4477,23 +4490,23 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 		if (mddev->pers)
 			err = md_set_readonly(mddev, NULL);
 		else {
-			mddev->ro = 1;
+			mddev->ro = MD_RDONLY;
 			set_disk_ro(mddev->gendisk, 1);
 			err = do_md_run(mddev);
 		}
 		break;
 	case read_auto:
 		if (mddev->pers) {
-			if (mddev->ro == 0)
+			if (md_is_rdwr(mddev))
 				err = md_set_readonly(mddev, NULL);
-			else if (mddev->ro == 1)
+			else if (mddev->ro == MD_RDONLY)
 				err = restart_array(mddev);
 			if (err == 0) {
-				mddev->ro = 2;
+				mddev->ro = MD_AUTO_READ;
 				set_disk_ro(mddev->gendisk, 0);
 			}
 		} else {
-			mddev->ro = 2;
+			mddev->ro = MD_AUTO_READ;
 			err = do_md_run(mddev);
 		}
 		break;
@@ -4518,7 +4531,7 @@ array_state_store(struct mddev *mddev, const char *buf, size_t len)
 			wake_up(&mddev->sb_wait);
 			err = 0;
 		} else {
-			mddev->ro = 0;
+			mddev->ro = MD_RDWR;
 			set_disk_ro(mddev->gendisk, 0);
 			err = do_md_run(mddev);
 		}
@@ -4819,7 +4832,7 @@ action_show(struct mddev *mddev, char *page)
 	if (test_bit(MD_RECOVERY_FROZEN, &recovery))
 		type = "frozen";
 	else if (test_bit(MD_RECOVERY_RUNNING, &recovery) ||
-	    (!mddev->ro && test_bit(MD_RECOVERY_NEEDED, &recovery))) {
+	    (md_is_rdwr(mddev) && test_bit(MD_RECOVERY_NEEDED, &recovery))) {
 		if (test_bit(MD_RECOVERY_RESHAPE, &recovery))
 			type = "reshape";
 		else if (test_bit(MD_RECOVERY_SYNC, &recovery)) {
@@ -4892,11 +4905,11 @@ action_store(struct mddev *mddev, const char *page, size_t len)
 		set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 		set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
 	}
-	if (mddev->ro == 2) {
+	if (mddev->ro == MD_AUTO_READ) {
 		/* A write to sync_action is enough to justify
 		 * canceling read-auto mode
 		 */
-		mddev->ro = 0;
+		mddev->ro = MD_RDWR;
 		md_wakeup_thread(mddev->sync_thread);
 	}
 	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
@@ -5124,8 +5137,7 @@ max_sync_store(struct mddev *mddev, const char *buf, size_t len)
 			goto out_unlock;
 
 		err = -EBUSY;
-		if (max < mddev->resync_max &&
-		    mddev->ro == 0 &&
+		if (max < mddev->resync_max && md_is_rdwr(mddev) &&
 		    test_bit(MD_RECOVERY_RUNNING, &mddev->recovery))
 			goto out_unlock;
 
@@ -5841,8 +5853,8 @@ int md_run(struct mddev *mddev)
 			continue;
 		sync_blockdev(rdev->bdev);
 		invalidate_bdev(rdev->bdev);
-		if (mddev->ro != 1 && rdev_read_only(rdev)) {
-			mddev->ro = 1;
+		if (mddev->ro != MD_RDONLY && rdev_read_only(rdev)) {
+			mddev->ro = MD_RDONLY;
 			if (mddev->gendisk)
 				set_disk_ro(mddev->gendisk, 1);
 		}
@@ -5945,8 +5957,8 @@ int md_run(struct mddev *mddev)
 
 	mddev->ok_start_degraded = start_dirty_degraded;
 
-	if (start_readonly && mddev->ro == 0)
-		mddev->ro = 2; /* read-only, but switch on first write */
+	if (start_readonly && md_is_rdwr(mddev))
+		mddev->ro = MD_AUTO_READ; /* read-only, but switch on first write */
 
 	err = pers->run(mddev);
 	if (err)
@@ -6021,8 +6033,8 @@ int md_run(struct mddev *mddev)
 		mddev->sysfs_action = sysfs_get_dirent_safe(mddev->kobj.sd, "sync_action");
 		mddev->sysfs_completed = sysfs_get_dirent_safe(mddev->kobj.sd, "sync_completed");
 		mddev->sysfs_degraded = sysfs_get_dirent_safe(mddev->kobj.sd, "degraded");
-	} else if (mddev->ro == 2) /* auto-readonly not meaningful */
-		mddev->ro = 0;
+	} else if (mddev->ro == MD_AUTO_READ)
+		mddev->ro = MD_RDWR;
 
 	atomic_set(&mddev->max_corr_read_errors,
 		   MD_DEFAULT_MAX_CORRECTED_READ_ERRORS);
@@ -6040,7 +6052,7 @@ int md_run(struct mddev *mddev)
 		if (rdev->raid_disk >= 0)
 			sysfs_link_rdev(mddev, rdev); /* failure here is OK */
 
-	if (mddev->degraded && !mddev->ro)
+	if (mddev->degraded && md_is_rdwr(mddev))
 		/* This ensures that recovering status is reported immediately
 		 * via sysfs - until a lack of spares is confirmed.
 		 */
@@ -6130,7 +6142,7 @@ static int restart_array(struct mddev *mddev)
 		return -ENXIO;
 	if (!mddev->pers)
 		return -EINVAL;
-	if (!mddev->ro)
+	if (md_is_rdwr(mddev))
 		return -EBUSY;
 
 	rcu_read_lock();
@@ -6149,7 +6161,7 @@ static int restart_array(struct mddev *mddev)
 		return -EROFS;
 
 	mddev->safemode = 0;
-	mddev->ro = 0;
+	mddev->ro = MD_RDWR;
 	set_disk_ro(disk, 0);
 	pr_debug("md: %s switched to read-write mode.\n", mdname(mddev));
 	/* Kick recovery or resync if necessary */
@@ -6176,7 +6188,7 @@ static void md_clean(struct mddev *mddev)
 	mddev->clevel[0] = 0;
 	mddev->flags = 0;
 	mddev->sb_flags = 0;
-	mddev->ro = 0;
+	mddev->ro = MD_RDWR;
 	mddev->metadata_type[0] = 0;
 	mddev->chunk_sectors = 0;
 	mddev->ctime = mddev->utime = 0;
@@ -6227,7 +6239,7 @@ static void __md_stop_writes(struct mddev *mddev)
 	}
 	md_bitmap_flush(mddev);
 
-	if (mddev->ro == 0 &&
+	if (md_is_rdwr(mddev) &&
 	    ((!mddev->in_sync && !mddev_is_clustered(mddev)) ||
 	     mddev->sb_flags)) {
 		/* mark array as shutdown cleanly */
@@ -6337,9 +6349,9 @@ static int md_set_readonly(struct mddev *mddev, struct block_device *bdev)
 		__md_stop_writes(mddev);
 
 		err  = -ENXIO;
-		if (mddev->ro==1)
+		if (mddev->ro == MD_RDONLY)
 			goto out;
-		mddev->ro = 1;
+		mddev->ro = MD_RDONLY;
 		set_disk_ro(mddev->gendisk, 1);
 		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
@@ -6396,7 +6408,7 @@ static int do_md_stop(struct mddev *mddev, int mode,
 		return -EBUSY;
 	}
 	if (mddev->pers) {
-		if (mddev->ro)
+		if (!md_is_rdwr(mddev))
 			set_disk_ro(disk, 0);
 
 		__md_stop_writes(mddev);
@@ -6413,8 +6425,8 @@ static int do_md_stop(struct mddev *mddev, int mode,
 		mutex_unlock(&mddev->open_mutex);
 		mddev->changed = 1;
 
-		if (mddev->ro)
-			mddev->ro = 0;
+		if (!md_is_rdwr(mddev))
+			mddev->ro = MD_RDWR;
 	} else
 		mutex_unlock(&mddev->open_mutex);
 	/*
@@ -7226,7 +7238,7 @@ static int update_size(struct mddev *mddev, sector_t num_sectors)
 	if (test_bit(MD_RECOVERY_RUNNING, &mddev->recovery) ||
 	    mddev->sync_thread)
 		return -EBUSY;
-	if (mddev->ro)
+	if (!md_is_rdwr(mddev))
 		return -EROFS;
 
 	rdev_for_each(rdev, mddev) {
@@ -7256,7 +7268,7 @@ static int update_raid_disks(struct mddev *mddev, int raid_disks)
 	/* change the number of raid disks */
 	if (mddev->pers->check_reshape == NULL)
 		return -EINVAL;
-	if (mddev->ro)
+	if (!md_is_rdwr(mddev))
 		return -EROFS;
 	if (raid_disks <= 0 ||
 	    (mddev->max_disks && raid_disks >= mddev->max_disks))
@@ -7680,26 +7692,25 @@ static int md_ioctl(struct block_device *bdev, fmode_t mode,
 	 * The remaining ioctls are changing the state of the
 	 * superblock, so we do not allow them on read-only arrays.
 	 */
-	if (mddev->ro && mddev->pers) {
-		if (mddev->ro == 2) {
-			mddev->ro = 0;
-			sysfs_notify_dirent_safe(mddev->sysfs_state);
-			set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-			/* mddev_unlock will wake thread */
-			/* If a device failed while we were read-only, we
-			 * need to make sure the metadata is updated now.
-			 */
-			if (test_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags)) {
-				mddev_unlock(mddev);
-				wait_event(mddev->sb_wait,
-					   !test_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags) &&
-					   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
-				mddev_lock_nointr(mddev);
-			}
-		} else {
+	if (!md_is_rdwr(mddev) && mddev->pers) {
+		if (mddev->ro != MD_AUTO_READ) {
 			err = -EROFS;
 			goto unlock;
 		}
+		mddev->ro = MD_RDWR;
+		sysfs_notify_dirent_safe(mddev->sysfs_state);
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+		/* mddev_unlock will wake thread */
+		/* If a device failed while we were read-only, we
+		 * need to make sure the metadata is updated now.
+		 */
+		if (test_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags)) {
+			mddev_unlock(mddev);
+			wait_event(mddev->sb_wait,
+				   !test_bit(MD_SB_CHANGE_DEVS, &mddev->sb_flags) &&
+				   !test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags));
+			mddev_lock_nointr(mddev);
+		}
 	}
 
 	switch (cmd) {
@@ -7785,11 +7796,11 @@ static int md_set_read_only(struct block_device *bdev, bool ro)
 	 * Transitioning to read-auto need only happen for arrays that call
 	 * md_write_start and which are not ready for writes yet.
 	 */
-	if (!ro && mddev->ro == 1 && mddev->pers) {
+	if (!ro && mddev->ro == MD_RDONLY && mddev->pers) {
 		err = restart_array(mddev);
 		if (err)
 			goto out_unlock;
-		mddev->ro = 2;
+		mddev->ro = MD_AUTO_READ;
 	}
 
 out_unlock:
@@ -8247,9 +8258,9 @@ static int md_seq_show(struct seq_file *seq, void *v)
 		seq_printf(seq, "%s : %sactive", mdname(mddev),
 						mddev->pers ? "" : "in");
 		if (mddev->pers) {
-			if (mddev->ro==1)
+			if (mddev->ro == MD_RDONLY)
 				seq_printf(seq, " (read-only)");
-			if (mddev->ro==2)
+			if (mddev->ro == MD_AUTO_READ)
 				seq_printf(seq, " (auto-read-only)");
 			seq_printf(seq, " %s", mddev->pers->name);
 		}
@@ -8509,10 +8520,10 @@ bool md_write_start(struct mddev *mddev, struct bio *bi)
 	if (bio_data_dir(bi) != WRITE)
 		return true;
 
-	BUG_ON(mddev->ro == 1);
-	if (mddev->ro == 2) {
+	BUG_ON(mddev->ro == MD_RDONLY);
+	if (mddev->ro == MD_AUTO_READ) {
 		/* need to switch to read/write */
-		mddev->ro = 0;
+		mddev->ro = MD_RDWR;
 		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
 		md_wakeup_thread(mddev->thread);
 		md_wakeup_thread(mddev->sync_thread);
@@ -8563,7 +8574,7 @@ void md_write_inc(struct mddev *mddev, struct bio *bi)
 {
 	if (bio_data_dir(bi) != WRITE)
 		return;
-	WARN_ON_ONCE(mddev->in_sync || mddev->ro);
+	WARN_ON_ONCE(mddev->in_sync || !md_is_rdwr(mddev));
 	percpu_ref_get(&mddev->writes_pending);
 }
 EXPORT_SYMBOL(md_write_inc);
@@ -8668,7 +8679,7 @@ void md_allow_write(struct mddev *mddev)
 {
 	if (!mddev->pers)
 		return;
-	if (mddev->ro)
+	if (!md_is_rdwr(mddev))
 		return;
 	if (!mddev->pers->sync_request)
 		return;
@@ -8717,7 +8728,7 @@ void md_do_sync(struct md_thread *thread)
 	if (test_bit(MD_RECOVERY_DONE, &mddev->recovery) ||
 	    test_bit(MD_RECOVERY_WAIT, &mddev->recovery))
 		return;
-	if (mddev->ro) {/* never try to sync a read-only array */
+	if (!md_is_rdwr(mddev)) {/* never try to sync a read-only array */
 		set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 		return;
 	}
@@ -9185,9 +9196,9 @@ static int remove_and_add_spares(struct mddev *mddev,
 		if (test_bit(Faulty, &rdev->flags))
 			continue;
 		if (!test_bit(Journal, &rdev->flags)) {
-			if (mddev->ro &&
-			    ! (rdev->saved_raid_disk >= 0 &&
-			       !test_bit(Bitmap_sync, &rdev->flags)))
+			if (!md_is_rdwr(mddev) &&
+			    !(rdev->saved_raid_disk >= 0 &&
+			      !test_bit(Bitmap_sync, &rdev->flags)))
 				continue;
 
 			rdev->recovery_offset = 0;
@@ -9285,7 +9296,8 @@ void md_check_recovery(struct mddev *mddev)
 		flush_signals(current);
 	}
 
-	if (mddev->ro && !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
+	if (!md_is_rdwr(mddev) &&
+	    !test_bit(MD_RECOVERY_NEEDED, &mddev->recovery))
 		return;
 	if ( ! (
 		(mddev->sb_flags & ~ (1<<MD_SB_CHANGE_PENDING)) ||
@@ -9304,7 +9316,7 @@ void md_check_recovery(struct mddev *mddev)
 		if (!mddev->external && mddev->safemode == 1)
 			mddev->safemode = 0;
 
-		if (mddev->ro) {
+		if (!md_is_rdwr(mddev)) {
 			struct md_rdev *rdev;
 			if (!mddev->external && mddev->in_sync)
 				/* 'Blocked' flag not needed as failed devices
-- 
2.42.0





Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71967A3BFA
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240857AbjIQUZG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbjIQUYk (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:24:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AD6101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:24:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BC8C433C9;
        Sun, 17 Sep 2023 20:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982273;
        bh=JHJAKsbEgXRVBoIy4f8njzIONS+ANG8xcsaI8ODbnFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Db/h9MXJezAJeWrGllbpiKavgtODTwa9YcN2q39bsS+a4kO4RViTip1Qt0BkDNkGD
         AYCUOLd+9aZKIOSq5c7NN6ULPNv1f9JP6PcyttprNoBJ6+V6J5PnIBG0zkOzgRJujE
         Q3t2dPfDnSKxpfvMsrIdgoEumxFjE2oTTAkUphnE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>,
        Xiao Ni <xni@redhat.com>
Subject: [PATCH 5.15 185/511] md: Set MD_BROKEN for RAID1 and RAID10
Date:   Sun, 17 Sep 2023 21:10:12 +0200
Message-ID: <20230917191118.295007373@linuxfoundation.org>
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

From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>

[ Upstream commit 9631abdbf406c764f2a5d8305eac063bc3396a0a ]

There is no direct mechanism to determine raid failure outside
personality. It is done by checking rdev->flags after executing
md_error(). If "faulty" flag is not set then -EBUSY is returned to
userspace. -EBUSY means that array will be failed after drive removal.

Mdadm has special routine to handle the array failure and it is executed
if -EBUSY is returned by md.

There are at least two known reasons to not consider this mechanism
as correct:
1. drive can be removed even if array will be failed[1].
2. -EBUSY seems to be wrong status. Array is not busy, but removal
   process cannot proceed safe.

-EBUSY expectation cannot be removed without breaking compatibility
with userspace. In this patch first issue is resolved by adding support
for MD_BROKEN flag for RAID1 and RAID10. Support for RAID456 is added in
next commit.

The idea is to set the MD_BROKEN if we are sure that raid is in failed
state now. This is done in each error_handler(). In md_error() MD_BROKEN
flag is checked. If is set, then -EBUSY is returned to userspace.

As in previous commit, it causes that #mdadm --set-faulty is able to
fail array. Previously proposed workaround is valid if optional
functionality[1] is disabled.

[1] commit 9a567843f7ce("md: allow last device to be forcibly removed from
    RAID1/RAID10.")

Reviewd-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Song Liu <song@kernel.org>
Stable-dep-of: 319ff40a5427 ("md/raid0: Fix performance regression for large sequential writes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.c     | 27 +++++++++++---------
 drivers/md/md.h     | 62 +++++++++++++++++++++++++--------------------
 drivers/md/raid1.c  | 43 ++++++++++++++++++-------------
 drivers/md/raid10.c | 40 +++++++++++++++++------------
 4 files changed, 100 insertions(+), 72 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 89a270d293698..a6e855cbf3946 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2992,10 +2992,11 @@ state_store(struct md_rdev *rdev, const char *buf, size_t len)
 
 	if (cmd_match(buf, "faulty") && rdev->mddev->pers) {
 		md_error(rdev->mddev, rdev);
-		if (test_bit(Faulty, &rdev->flags))
-			err = 0;
-		else
+
+		if (test_bit(MD_BROKEN, &rdev->mddev->flags))
 			err = -EBUSY;
+		else
+			err = 0;
 	} else if (cmd_match(buf, "remove")) {
 		if (rdev->mddev->pers) {
 			clear_bit(Blocked, &rdev->flags);
@@ -4364,10 +4365,9 @@ __ATTR_PREALLOC(resync_start, S_IRUGO|S_IWUSR,
  *     like active, but no writes have been seen for a while (100msec).
  *
  * broken
- *     RAID0/LINEAR-only: same as clean, but array is missing a member.
- *     It's useful because RAID0/LINEAR mounted-arrays aren't stopped
- *     when a member is gone, so this state will at least alert the
- *     user that something is wrong.
+*     Array is failed. It's useful because mounted-arrays aren't stopped
+*     when array is failed, so this state will at least alert the user that
+*     something is wrong.
  */
 enum array_state { clear, inactive, suspended, readonly, read_auto, clean, active,
 		   write_pending, active_idle, broken, bad_word};
@@ -7439,7 +7439,7 @@ static int set_disk_faulty(struct mddev *mddev, dev_t dev)
 		err =  -ENODEV;
 	else {
 		md_error(mddev, rdev);
-		if (!test_bit(Faulty, &rdev->flags))
+		if (test_bit(MD_BROKEN, &mddev->flags))
 			err = -EBUSY;
 	}
 	rcu_read_unlock();
@@ -7985,13 +7985,16 @@ void md_error(struct mddev *mddev, struct md_rdev *rdev)
 
 	if (!mddev->pers || !mddev->pers->error_handler)
 		return;
-	mddev->pers->error_handler(mddev,rdev);
-	if (mddev->degraded)
+	mddev->pers->error_handler(mddev, rdev);
+
+	if (mddev->degraded && !test_bit(MD_BROKEN, &mddev->flags))
 		set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 	sysfs_notify_dirent_safe(rdev->sysfs_state);
 	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
-	set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
-	md_wakeup_thread(mddev->thread);
+	if (!test_bit(MD_BROKEN, &mddev->flags)) {
+		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
+		md_wakeup_thread(mddev->thread);
+	}
 	if (mddev->event_work.func)
 		queue_work(md_misc_wq, &mddev->event_work);
 	md_new_event(mddev);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 62852d7011457..0e0cc5d7921bd 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -234,34 +234,42 @@ extern int rdev_clear_badblocks(struct md_rdev *rdev, sector_t s, int sectors,
 				int is_new);
 struct md_cluster_info;
 
-/* change UNSUPPORTED_MDDEV_FLAGS for each array type if new flag is added */
+/**
+ * enum mddev_flags - md device flags.
+ * @MD_ARRAY_FIRST_USE: First use of array, needs initialization.
+ * @MD_CLOSING: If set, we are closing the array, do not open it then.
+ * @MD_JOURNAL_CLEAN: A raid with journal is already clean.
+ * @MD_HAS_JOURNAL: The raid array has journal feature set.
+ * @MD_CLUSTER_RESYNC_LOCKED: cluster raid only, which means node, already took
+ *			       resync lock, need to release the lock.
+ * @MD_FAILFAST_SUPPORTED: Using MD_FAILFAST on metadata writes is supported as
+ *			    calls to md_error() will never cause the array to
+ *			    become failed.
+ * @MD_HAS_PPL:  The raid array has PPL feature set.
+ * @MD_HAS_MULTIPLE_PPLS: The raid array has multiple PPLs feature set.
+ * @MD_ALLOW_SB_UPDATE: md_check_recovery is allowed to update the metadata
+ *			 without taking reconfig_mutex.
+ * @MD_UPDATING_SB: md_check_recovery is updating the metadata without
+ *		     explicitly holding reconfig_mutex.
+ * @MD_NOT_READY: do_md_run() is active, so 'array_state', ust not report that
+ *		   array is ready yet.
+ * @MD_BROKEN: This is used to stop writes and mark array as failed.
+ *
+ * change UNSUPPORTED_MDDEV_FLAGS for each array type if new flag is added
+ */
 enum mddev_flags {
-	MD_ARRAY_FIRST_USE,	/* First use of array, needs initialization */
-	MD_CLOSING,		/* If set, we are closing the array, do not open
-				 * it then */
-	MD_JOURNAL_CLEAN,	/* A raid with journal is already clean */
-	MD_HAS_JOURNAL,		/* The raid array has journal feature set */
-	MD_CLUSTER_RESYNC_LOCKED, /* cluster raid only, which means node
-				   * already took resync lock, need to
-				   * release the lock */
-	MD_FAILFAST_SUPPORTED,	/* Using MD_FAILFAST on metadata writes is
-				 * supported as calls to md_error() will
-				 * never cause the array to become failed.
-				 */
-	MD_HAS_PPL,		/* The raid array has PPL feature set */
-	MD_HAS_MULTIPLE_PPLS,	/* The raid array has multiple PPLs feature set */
-	MD_ALLOW_SB_UPDATE,	/* md_check_recovery is allowed to update
-				 * the metadata without taking reconfig_mutex.
-				 */
-	MD_UPDATING_SB,		/* md_check_recovery is updating the metadata
-				 * without explicitly holding reconfig_mutex.
-				 */
-	MD_NOT_READY,		/* do_md_run() is active, so 'array_state'
-				 * must not report that array is ready yet
-				 */
-	MD_BROKEN,              /* This is used in RAID-0/LINEAR only, to stop
-				 * I/O in case an array member is gone/failed.
-				 */
+	MD_ARRAY_FIRST_USE,
+	MD_CLOSING,
+	MD_JOURNAL_CLEAN,
+	MD_HAS_JOURNAL,
+	MD_CLUSTER_RESYNC_LOCKED,
+	MD_FAILFAST_SUPPORTED,
+	MD_HAS_PPL,
+	MD_HAS_MULTIPLE_PPLS,
+	MD_ALLOW_SB_UPDATE,
+	MD_UPDATING_SB,
+	MD_NOT_READY,
+	MD_BROKEN,
 };
 
 enum mddev_sb_flags {
diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index e8e475b082567..6f2570f36b9b9 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1611,30 +1611,39 @@ static void raid1_status(struct seq_file *seq, struct mddev *mddev)
 	seq_printf(seq, "]");
 }
 
+/**
+ * raid1_error() - RAID1 error handler.
+ * @mddev: affected md device.
+ * @rdev: member device to fail.
+ *
+ * The routine acknowledges &rdev failure and determines new @mddev state.
+ * If it failed, then:
+ *	- &MD_BROKEN flag is set in &mddev->flags.
+ *	- recovery is disabled.
+ * Otherwise, it must be degraded:
+ *	- recovery is interrupted.
+ *	- &mddev->degraded is bumped.
+ *
+ * @rdev is marked as &Faulty excluding case when array is failed and
+ * &mddev->fail_last_dev is off.
+ */
 static void raid1_error(struct mddev *mddev, struct md_rdev *rdev)
 {
 	char b[BDEVNAME_SIZE];
 	struct r1conf *conf = mddev->private;
 	unsigned long flags;
 
-	/*
-	 * If it is not operational, then we have already marked it as dead
-	 * else if it is the last working disks with "fail_last_dev == false",
-	 * ignore the error, let the next level up know.
-	 * else mark the drive as failed
-	 */
 	spin_lock_irqsave(&conf->device_lock, flags);
-	if (test_bit(In_sync, &rdev->flags) && !mddev->fail_last_dev
-	    && (conf->raid_disks - mddev->degraded) == 1) {
-		/*
-		 * Don't fail the drive, act as though we were just a
-		 * normal single drive.
-		 * However don't try a recovery from this drive as
-		 * it is very likely to fail.
-		 */
-		conf->recovery_disabled = mddev->recovery_disabled;
-		spin_unlock_irqrestore(&conf->device_lock, flags);
-		return;
+
+	if (test_bit(In_sync, &rdev->flags) &&
+	    (conf->raid_disks - mddev->degraded) == 1) {
+		set_bit(MD_BROKEN, &mddev->flags);
+
+		if (!mddev->fail_last_dev) {
+			conf->recovery_disabled = mddev->recovery_disabled;
+			spin_unlock_irqrestore(&conf->device_lock, flags);
+			return;
+		}
 	}
 	set_bit(Blocked, &rdev->flags);
 	if (test_and_clear_bit(In_sync, &rdev->flags))
diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
index a3a3a02d48b17..910e7db7d5736 100644
--- a/drivers/md/raid10.c
+++ b/drivers/md/raid10.c
@@ -2008,32 +2008,40 @@ static int enough(struct r10conf *conf, int ignore)
 		_enough(conf, 1, ignore);
 }
 
+/**
+ * raid10_error() - RAID10 error handler.
+ * @mddev: affected md device.
+ * @rdev: member device to fail.
+ *
+ * The routine acknowledges &rdev failure and determines new @mddev state.
+ * If it failed, then:
+ *	- &MD_BROKEN flag is set in &mddev->flags.
+ * Otherwise, it must be degraded:
+ *	- recovery is interrupted.
+ *	- &mddev->degraded is bumped.
+
+ * @rdev is marked as &Faulty excluding case when array is failed and
+ * &mddev->fail_last_dev is off.
+ */
 static void raid10_error(struct mddev *mddev, struct md_rdev *rdev)
 {
 	char b[BDEVNAME_SIZE];
 	struct r10conf *conf = mddev->private;
 	unsigned long flags;
 
-	/*
-	 * If it is not operational, then we have already marked it as dead
-	 * else if it is the last working disks with "fail_last_dev == false",
-	 * ignore the error, let the next level up know.
-	 * else mark the drive as failed
-	 */
 	spin_lock_irqsave(&conf->device_lock, flags);
-	if (test_bit(In_sync, &rdev->flags) && !mddev->fail_last_dev
-	    && !enough(conf, rdev->raid_disk)) {
-		/*
-		 * Don't fail the drive, just return an IO error.
-		 */
-		spin_unlock_irqrestore(&conf->device_lock, flags);
-		return;
+
+	if (test_bit(In_sync, &rdev->flags) && !enough(conf, rdev->raid_disk)) {
+		set_bit(MD_BROKEN, &mddev->flags);
+
+		if (!mddev->fail_last_dev) {
+			spin_unlock_irqrestore(&conf->device_lock, flags);
+			return;
+		}
 	}
 	if (test_and_clear_bit(In_sync, &rdev->flags))
 		mddev->degraded++;
-	/*
-	 * If recovery is running, make sure it aborts.
-	 */
+
 	set_bit(MD_RECOVERY_INTR, &mddev->recovery);
 	set_bit(Blocked, &rdev->flags);
 	set_bit(Faulty, &rdev->flags);
-- 
2.40.1




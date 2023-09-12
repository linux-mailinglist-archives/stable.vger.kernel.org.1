Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788D479B5C6
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353924AbjIKVvf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241841AbjIKPQB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:16:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0535AFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:15:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4315CC433C9;
        Mon, 11 Sep 2023 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445356;
        bh=pAp/AQ1kEk+q6lZoyx6QwQNk1Helrq58cUjXOgQ0gnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GH+DFsB/zykD78sXgPrTwsgBDfMWCXAWfCHAKavjXNpZb6JujKBwMiH/g27UGT6Bq
         R6HlsltNW9sx98SUCgGwYhLCy3v9dcgUDlfe/Ig7LoLzNGsLW9iG/rWAXi4Qi8gC1i
         332zzyVAHbeTq5Yh97bx+jojU10xSI0iBPxumnyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiao Ni <xni@redhat.com>,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 318/600] md: add error_handlers for raid0 and linear
Date:   Mon, 11 Sep 2023 15:45:51 +0200
Message-ID: <20230911134643.071669801@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>

[ Upstream commit c31fea2f8e2a72c817f318016bbc327095175a9f ]

After the commit 9631abdbf406c("md: Set MD_BROKEN for RAID1 and RAID10")
MD_BROKEN must be set if array is failed because state_store() checks it.
If it is set then -EBUSY is returned to userspace.

For raid0 and linear MD_BROKEN is not set by error_handler(). As a result
mdadm is unable to trigger clean-up actions. It is a regression.

This patch adds appropriate error_handler for raid0 and linear. The
error handler sets MD_BROKEN for this device.

Reviewed-by: Xiao Ni <xni@redhat.com>
Signed-off-by: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20230306130317.3418-1-mariusz.tkaczyk@linux.intel.com
Stable-dep-of: 319ff40a5427 ("md/raid0: Fix performance regression for large sequential writes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md-linear.c | 14 +++++++++++++-
 drivers/md/md.c        |  3 +++
 drivers/md/md.h        | 10 ++--------
 drivers/md/raid0.c     | 14 +++++++++++++-
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 6e7797b4e7381..4eb72b9dd9336 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -223,7 +223,8 @@ static bool linear_make_request(struct mddev *mddev, struct bio *bio)
 		     bio_sector < start_sector))
 		goto out_of_bounds;
 
-	if (unlikely(is_mddev_broken(tmp_dev->rdev, "linear"))) {
+	if (unlikely(is_rdev_broken(tmp_dev->rdev))) {
+		md_error(mddev, tmp_dev->rdev);
 		bio_io_error(bio);
 		return true;
 	}
@@ -270,6 +271,16 @@ static void linear_status (struct seq_file *seq, struct mddev *mddev)
 	seq_printf(seq, " %dk rounding", mddev->chunk_sectors / 2);
 }
 
+static void linear_error(struct mddev *mddev, struct md_rdev *rdev)
+{
+	if (!test_and_set_bit(MD_BROKEN, &mddev->flags)) {
+		char *md_name = mdname(mddev);
+
+		pr_crit("md/linear%s: Disk failure on %pg detected, failing array.\n",
+			md_name, rdev->bdev);
+	}
+}
+
 static void linear_quiesce(struct mddev *mddev, int state)
 {
 }
@@ -286,6 +297,7 @@ static struct md_personality linear_personality =
 	.hot_add_disk	= linear_add,
 	.size		= linear_size,
 	.quiesce	= linear_quiesce,
+	.error_handler	= linear_error,
 };
 
 static int __init linear_init (void)
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 443837fe6291e..b65d8bf54924b 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -7992,6 +7992,9 @@ void md_error(struct mddev *mddev, struct md_rdev *rdev)
 		return;
 	mddev->pers->error_handler(mddev, rdev);
 
+	if (mddev->pers->level == 0 || mddev->pers->level == LEVEL_LINEAR)
+		return;
+
 	if (mddev->degraded && !test_bit(MD_BROKEN, &mddev->flags))
 		set_bit(MD_RECOVERY_RECOVER, &mddev->recovery);
 	sysfs_notify_dirent_safe(rdev->sysfs_state);
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 64f8182a3dfc6..4f0b480974552 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -790,15 +790,9 @@ extern void mddev_destroy_serial_pool(struct mddev *mddev, struct md_rdev *rdev,
 struct md_rdev *md_find_rdev_nr_rcu(struct mddev *mddev, int nr);
 struct md_rdev *md_find_rdev_rcu(struct mddev *mddev, dev_t dev);
 
-static inline bool is_mddev_broken(struct md_rdev *rdev, const char *md_type)
+static inline bool is_rdev_broken(struct md_rdev *rdev)
 {
-	if (!disk_live(rdev->bdev->bd_disk)) {
-		if (!test_and_set_bit(MD_BROKEN, &rdev->mddev->flags))
-			pr_warn("md: %s: %s array has a missing/failed member\n",
-				mdname(rdev->mddev), md_type);
-		return true;
-	}
-	return false;
+	return !disk_live(rdev->bdev->bd_disk);
 }
 
 static inline void rdev_dec_pending(struct md_rdev *rdev, struct mddev *mddev)
diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
index 0f7c3b3c62b25..d1ac73fcd8529 100644
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -615,8 +615,9 @@ static bool raid0_make_request(struct mddev *mddev, struct bio *bio)
 		return true;
 	}
 
-	if (unlikely(is_mddev_broken(tmp_dev, "raid0"))) {
+	if (unlikely(is_rdev_broken(tmp_dev))) {
 		bio_io_error(bio);
+		md_error(mddev, tmp_dev);
 		return true;
 	}
 
@@ -638,6 +639,16 @@ static void raid0_status(struct seq_file *seq, struct mddev *mddev)
 	return;
 }
 
+static void raid0_error(struct mddev *mddev, struct md_rdev *rdev)
+{
+	if (!test_and_set_bit(MD_BROKEN, &mddev->flags)) {
+		char *md_name = mdname(mddev);
+
+		pr_crit("md/raid0%s: Disk failure on %pg detected, failing array.\n",
+			md_name, rdev->bdev);
+	}
+}
+
 static void *raid0_takeover_raid45(struct mddev *mddev)
 {
 	struct md_rdev *rdev;
@@ -813,6 +824,7 @@ static struct md_personality raid0_personality=
 	.size		= raid0_size,
 	.takeover	= raid0_takeover,
 	.quiesce	= raid0_quiesce,
+	.error_handler	= raid0_error,
 };
 
 static int __init raid0_init (void)
-- 
2.40.1




Return-Path: <stable+bounces-34055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBFB893DAB
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 17:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1981F22EF3
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665C15336D;
	Mon,  1 Apr 2024 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DpG0KubT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194B44AEC1;
	Mon,  1 Apr 2024 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711986857; cv=none; b=S17NLdmJLqLc3dNnklJHWyhdyksn84ne2lqpRm4O3W0wBO/QmaAnzDlFBpyAd0WtR7SysDmNq0gsxWCA5tT9i36GPAk4JYPVGIyIXRqk8s/tbj7lVXEbu3+UU8J37ITi2J33jf2Z9fv631SPL5ncwxpahoyvt+MHArFW6hR8GEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711986857; c=relaxed/simple;
	bh=PpQe2d7QcAI/TB8FWAjsDbeHAWTs/8G1fqDaXsKVnEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YlRadjdF1rK6uPQRdZJxHlnpgfYZ1S0+pVpF8vSjdSIYgSP/HaCwv8UYkCWkrpQnsCrEQ7HSZq20nVJvg0S4R1KOq0CDsykkYz7DzNp5guJKnnmyb+AOqq6D6SI84P5cpcu5jW7H4+eErQSkV4dxVNcDK/oNIX2coPJiVJEgEhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DpG0KubT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CDF4C433C7;
	Mon,  1 Apr 2024 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711986857;
	bh=PpQe2d7QcAI/TB8FWAjsDbeHAWTs/8G1fqDaXsKVnEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DpG0KubTtfip8QHEMMl0bEEmwrsjhJJT+AQGU5SwjvCV+cIK3IAFk2SyZnqqeXXsF
	 KwRHBmENOwEU2Ovogec0f8jvl4UKTiGPSFjvJFe71Vu8kAgOD0a0ZT4MVKkmJfonE5
	 fcapCRFLNP3aODubXfqgzPJZB3HeW2lTodh3dROE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mikulas Patocka <mpatocka@redhat.com>,
	Yu Kuai <yukuai3@huawei.com>,
	Xiao Ni <xni@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Song Liu <song@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 108/399] dm-raid: really frozen sync_thread during suspend
Date: Mon,  1 Apr 2024 17:41:14 +0200
Message-ID: <20240401152552.412184859@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 16c4770c75b1223998adbeb7286f9a15c65fba73 ]

1) commit f52f5c71f3d4 ("md: fix stopping sync thread") remove
   MD_RECOVERY_FROZEN from __md_stop_writes() and doesn't realize that
   dm-raid relies on __md_stop_writes() to frozen sync_thread
   indirectly. Fix this problem by adding MD_RECOVERY_FROZEN in
   md_stop_writes(), and since stop_sync_thread() is only used for
   dm-raid in this case, also move stop_sync_thread() to
   md_stop_writes().
2) The flag MD_RECOVERY_FROZEN doesn't mean that sync thread is frozen,
   it only prevent new sync_thread to start, and it can't stop the
   running sync thread; In order to frozen sync_thread, after seting the
   flag, stop_sync_thread() should be used.
3) The flag MD_RECOVERY_FROZEN doesn't mean that writes are stopped, use
   it as condition for md_stop_writes() in raid_postsuspend() doesn't
   look correct. Consider that reentrant stop_sync_thread() do nothing,
   always call md_stop_writes() in raid_postsuspend().
4) raid_message can set/clear the flag MD_RECOVERY_FROZEN at anytime,
   and if MD_RECOVERY_FROZEN is cleared while the array is suspended,
   new sync_thread can start unexpected. Fix this by disallow
   raid_message() to change sync_thread status during suspend.

Note that after commit f52f5c71f3d4 ("md: fix stopping sync thread"), the
test shell/lvconvert-raid-reshape.sh start to hang in stop_sync_thread(),
and with previous fixes, the test won't hang there anymore, however, the
test will still fail and complain that ext4 is corrupted. And with this
patch, the test won't hang due to stop_sync_thread() or fail due to ext4
is corrupted anymore. However, there is still a deadlock related to
dm-raid456 that will be fixed in following patches.

Reported-by: Mikulas Patocka <mpatocka@redhat.com>
Closes: https://lore.kernel.org/all/e5e8afe2-e9a8-49a2-5ab0-958d4065c55e@redhat.com/
Fixes: 1af2048a3e87 ("dm raid: fix deadlock caused by premature md_stop_writes()")
Fixes: 9dbd1aa3a81c ("dm raid: add reshaping support to the target")
Fixes: f52f5c71f3d4 ("md: fix stopping sync thread")
Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Xiao Ni <xni@redhat.com>
Acked-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/20240305072306.2562024-6-yukuai1@huaweicloud.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-raid.c | 25 +++++++++++++++----------
 drivers/md/md.c      |  3 ++-
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 13eb47b997f94..fff9336fee767 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3240,11 +3240,12 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	rs->md.ro = 1;
 	rs->md.in_sync = 1;
 
-	/* Keep array frozen until resume. */
-	set_bit(MD_RECOVERY_FROZEN, &rs->md.recovery);
-
 	/* Has to be held on running the array */
 	mddev_suspend_and_lock_nointr(&rs->md);
+
+	/* Keep array frozen until resume. */
+	md_frozen_sync_thread(&rs->md);
+
 	r = md_run(&rs->md);
 	rs->md.in_sync = 0; /* Assume already marked dirty */
 	if (r) {
@@ -3722,6 +3723,9 @@ static int raid_message(struct dm_target *ti, unsigned int argc, char **argv,
 	if (!mddev->pers || !mddev->pers->sync_request)
 		return -EINVAL;
 
+	if (test_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags))
+		return -EBUSY;
+
 	if (!strcasecmp(argv[0], "frozen"))
 		set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	else
@@ -3796,10 +3800,11 @@ static void raid_postsuspend(struct dm_target *ti)
 	struct raid_set *rs = ti->private;
 
 	if (!test_and_set_bit(RT_FLAG_RS_SUSPENDED, &rs->runtime_flags)) {
-		/* Writes have to be stopped before suspending to avoid deadlocks. */
-		if (!test_bit(MD_RECOVERY_FROZEN, &rs->md.recovery))
-			md_stop_writes(&rs->md);
-
+		/*
+		 * sync_thread must be stopped during suspend, and writes have
+		 * to be stopped before suspending to avoid deadlocks.
+		 */
+		md_stop_writes(&rs->md);
 		mddev_suspend(&rs->md, false);
 	}
 }
@@ -4012,8 +4017,6 @@ static int raid_preresume(struct dm_target *ti)
 	}
 
 	/* Check for any resize/reshape on @rs and adjust/initiate */
-	/* Be prepared for mddev_resume() in raid_resume() */
-	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 	if (mddev->recovery_cp && mddev->recovery_cp < MaxSector) {
 		set_bit(MD_RECOVERY_REQUESTED, &mddev->recovery);
 		mddev->resync_min = mddev->recovery_cp;
@@ -4055,10 +4058,12 @@ static void raid_resume(struct dm_target *ti)
 		if (mddev->delta_disks < 0)
 			rs_set_capacity(rs);
 
+		WARN_ON_ONCE(!test_bit(MD_RECOVERY_FROZEN, &mddev->recovery));
+		WARN_ON_ONCE(test_bit(MD_RECOVERY_RUNNING, &mddev->recovery));
 		mddev_lock_nointr(mddev);
-		clear_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
 		mddev->ro = 0;
 		mddev->in_sync = 0;
+		md_unfrozen_sync_thread(mddev);
 		mddev_unlock_and_resume(mddev);
 	}
 }
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 245ef8af8640a..ea68a6f8103bb 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6344,7 +6344,6 @@ static void md_clean(struct mddev *mddev)
 
 static void __md_stop_writes(struct mddev *mddev)
 {
-	stop_sync_thread(mddev, true, false);
 	del_timer_sync(&mddev->safemode_timer);
 
 	if (mddev->pers && mddev->pers->quiesce) {
@@ -6369,6 +6368,8 @@ static void __md_stop_writes(struct mddev *mddev)
 void md_stop_writes(struct mddev *mddev)
 {
 	mddev_lock_nointr(mddev);
+	set_bit(MD_RECOVERY_FROZEN, &mddev->recovery);
+	stop_sync_thread(mddev, true, false);
 	__md_stop_writes(mddev);
 	mddev_unlock(mddev);
 }
-- 
2.43.0





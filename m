Return-Path: <stable+bounces-71032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E91961152
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 17:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001051F21E79
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FB21CB14E;
	Tue, 27 Aug 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ytjfMjAe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7671C689C;
	Tue, 27 Aug 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771871; cv=none; b=HGhmZf/3i2FeAxRxAIdG97LGFaQfPmJgNGBgvScInc76M03lmw7dImkAeX1AbbRd6lESYMi+c1kNwLjV8f5ig2368mGO4ecGgf6vbx9JFWDniMeIVfs5MmUcaZd3nadhvzFXyhiyqyy/50214PYyk/BHyakTNv0Kh7EOOyDGFOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771871; c=relaxed/simple;
	bh=byIaE/eDDsjx+AqOFCVrQQJ2Gm8z6xPbgwccrUGzkQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q36pDrIhdrW5sJ1pjq3LocyIhgJywNSrp8Kpf1iOFQvVLqwQwAOjmYOcj6IR0lh9K3AUoEcaxzR/uMHQqfi/XFCVdnf6gUrCSBHKNKQxf79bo2GzLaxtq9MVezjwzbtmtA8Fa8T3iBTnH8ksFbo/3p5AKdV7BG4S6ZHnrVvwzlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ytjfMjAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70D65C61051;
	Tue, 27 Aug 2024 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771870;
	bh=byIaE/eDDsjx+AqOFCVrQQJ2Gm8z6xPbgwccrUGzkQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ytjfMjAefqb04XUwz2qKHfpmhg3HiUwDnAZIp6o22yrw9y4uc7D0MpYQaXE0g0mkc
	 589U8a8K9uIxP3w3Vp3AzuTKWLb4J6s9fdQjQTaGV/BLI++hH7/fDaQJYLeZLOrhuC
	 BTUPlTWi3UFRniyzkRDS2+8yDlFmF4ud4kHE4l/w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 046/321] gfs2: Rework freeze / thaw logic
Date: Tue, 27 Aug 2024 16:35:54 +0200
Message-ID: <20240827143839.982776362@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143838.192435816@linuxfoundation.org>
References: <20240827143838.192435816@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit b77b4a4815a9651d1d6e07b8e6548eee9531a5eb ]

So far, at mount time, gfs2 would take the freeze glock in shared mode
and then immediately drop it again, turning it into a cached glock that
can be reclaimed at any time.  To freeze the filesystem cluster-wide,
the node initiating the freeze would take the freeze glock in exclusive
mode, which would cause the freeze glock's freeze_go_sync() callback to
run on each node.  There, gfs2 would freeze the filesystem and schedule
gfs2_freeze_func() to run.  gfs2_freeze_func() would re-acquire the
freeze glock in shared mode, thaw the filesystem, and drop the freeze
glock again.  The initiating node would keep the freeze glock held in
exclusive mode.  To thaw the filesystem, the initiating node would drop
the freeze glock again, which would allow gfs2_freeze_func() to resume
on all nodes, leaving the filesystem in the thawed state.

It turns out that in freeze_go_sync(), we cannot reliably and safely
freeze the filesystem.  This is primarily because the final unmount of a
filesystem takes a write lock on the s_umount rw semaphore before
calling into gfs2_put_super(), and freeze_go_sync() needs to call
freeze_super() which also takes a write lock on the same semaphore,
causing a deadlock.  We could work around this by trying to take an
active reference on the super block first, which would prevent unmount
from running at the same time.  But that can fail, and freeze_go_sync()
isn't actually allowed to fail.

To get around this, this patch changes the freeze glock locking scheme
as follows:

At mount time, each node takes the freeze glock in shared mode.  To
freeze a filesystem, the initiating node first freezes the filesystem
locally and then drops and re-acquires the freeze glock in exclusive
mode.  All other nodes notice that there is contention on the freeze
glock in their go_callback callbacks, and they schedule
gfs2_freeze_func() to run.  There, they freeze the filesystem locally
and drop and re-acquire the freeze glock before re-thawing the
filesystem.  This is happening outside of the glock state engine, so
there, we are allowed to fail.

>From a cluster point of view, taking and immediately dropping a glock is
indistinguishable from taking the glock and only dropping it upon
contention, so this new scheme is compatible with the old one.

Thanks to Li Dong <lidong@vivo.com> for reporting a locking bug in
gfs2_freeze_func() in a previous version of this commit.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Stable-dep-of: f66af88e3321 ("gfs2: Stop using gfs2_make_fs_ro for withdraw")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glops.c      |  52 +++++--------
 fs/gfs2/log.c        |   2 -
 fs/gfs2/ops_fstype.c |   5 +-
 fs/gfs2/recovery.c   |  24 +++---
 fs/gfs2/super.c      | 172 +++++++++++++++++++++++++++++++++----------
 fs/gfs2/super.h      |   1 +
 fs/gfs2/util.c       |  32 +++-----
 7 files changed, 178 insertions(+), 110 deletions(-)

diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 91a542b9d81e8..089b3d811e43d 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -555,47 +555,33 @@ static void inode_go_dump(struct seq_file *seq, struct gfs2_glock *gl,
 }
 
 /**
- * freeze_go_sync - promote/demote the freeze glock
+ * freeze_go_callback - A cluster node is requesting a freeze
  * @gl: the glock
+ * @remote: true if this came from a different cluster node
  */
 
-static int freeze_go_sync(struct gfs2_glock *gl)
+static void freeze_go_callback(struct gfs2_glock *gl, bool remote)
 {
-	int error = 0;
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct super_block *sb = sdp->sd_vfs;
+
+	if (!remote ||
+	    gl->gl_state != LM_ST_SHARED ||
+	    gl->gl_demote_state != LM_ST_UNLOCKED)
+		return;
 
 	/*
-	 * We need to check gl_state == LM_ST_SHARED here and not gl_req ==
-	 * LM_ST_EXCLUSIVE. That's because when any node does a freeze,
-	 * all the nodes should have the freeze glock in SH mode and they all
-	 * call do_xmote: One for EX and the others for UN. They ALL must
-	 * freeze locally, and they ALL must queue freeze work. The freeze_work
-	 * calls freeze_func, which tries to reacquire the freeze glock in SH,
-	 * effectively waiting for the thaw on the node who holds it in EX.
-	 * Once thawed, the work func acquires the freeze glock in
-	 * SH and everybody goes back to thawed.
+	 * Try to get an active super block reference to prevent racing with
+	 * unmount (see trylock_super()).  But note that unmount isn't the only
+	 * place where a write lock on s_umount is taken, and we can fail here
+	 * because of things like remount as well.
 	 */
-	if (gl->gl_state == LM_ST_SHARED && !gfs2_withdrawn(sdp) &&
-	    !test_bit(SDF_NORECOVERY, &sdp->sd_flags)) {
-		atomic_set(&sdp->sd_freeze_state, SFS_STARTING_FREEZE);
-		error = freeze_super(sdp->sd_vfs);
-		if (error) {
-			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
-				error);
-			if (gfs2_withdrawn(sdp)) {
-				atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
-				return 0;
-			}
-			gfs2_assert_withdraw(sdp, 0);
-		}
-		queue_work(gfs2_freeze_wq, &sdp->sd_freeze_work);
-		if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
-			gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_FREEZE |
-				       GFS2_LFC_FREEZE_GO_SYNC);
-		else /* read-only mounts */
-			atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
+	if (down_read_trylock(&sb->s_umount)) {
+		atomic_inc(&sb->s_active);
+		up_read(&sb->s_umount);
+		if (!queue_work(gfs2_freeze_wq, &sdp->sd_freeze_work))
+			deactivate_super(sb);
 	}
-	return 0;
 }
 
 /**
@@ -760,9 +746,9 @@ const struct gfs2_glock_operations gfs2_rgrp_glops = {
 };
 
 const struct gfs2_glock_operations gfs2_freeze_glops = {
-	.go_sync = freeze_go_sync,
 	.go_xmote_bh = freeze_go_xmote_bh,
 	.go_demote_ok = freeze_go_demote_ok,
+	.go_callback = freeze_go_callback,
 	.go_type = LM_TYPE_NONDISK,
 	.go_flags = GLOF_NONDISK,
 };
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index e021d5f50c231..8fd8bb8604869 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -1136,8 +1136,6 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 		if (flags & (GFS2_LOG_HEAD_FLUSH_SHUTDOWN |
 			     GFS2_LOG_HEAD_FLUSH_FREEZE))
 			gfs2_log_shutdown(sdp);
-		if (flags & GFS2_LOG_HEAD_FLUSH_FREEZE)
-			atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
 	}
 
 out_end:
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index e427fb7fbe998..8299113858ce4 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1143,7 +1143,6 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	int silent = fc->sb_flags & SB_SILENT;
 	struct gfs2_sbd *sdp;
 	struct gfs2_holder mount_gh;
-	struct gfs2_holder freeze_gh;
 	int error;
 
 	sdp = init_sbd(sb);
@@ -1266,15 +1265,15 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 		}
 	}
 
-	error = gfs2_freeze_lock_shared(sdp, &freeze_gh, 0);
+	error = gfs2_freeze_lock_shared(sdp, &sdp->sd_freeze_gh, 0);
 	if (error)
 		goto fail_per_node;
 
 	if (!sb_rdonly(sb))
 		error = gfs2_make_fs_rw(sdp);
 
-	gfs2_freeze_unlock(&freeze_gh);
 	if (error) {
+		gfs2_freeze_unlock(&sdp->sd_freeze_gh);
 		if (sdp->sd_quotad_process)
 			kthread_stop(sdp->sd_quotad_process);
 		sdp->sd_quotad_process = NULL;
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 61ef07da40b22..afeda936e2beb 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -404,7 +404,7 @@ void gfs2_recover_func(struct work_struct *work)
 	struct gfs2_inode *ip = GFS2_I(jd->jd_inode);
 	struct gfs2_sbd *sdp = GFS2_SB(jd->jd_inode);
 	struct gfs2_log_header_host head;
-	struct gfs2_holder j_gh, ji_gh, thaw_gh;
+	struct gfs2_holder j_gh, ji_gh;
 	ktime_t t_start, t_jlck, t_jhd, t_tlck, t_rep;
 	int ro = 0;
 	unsigned int pass;
@@ -465,14 +465,14 @@ void gfs2_recover_func(struct work_struct *work)
 		ktime_ms_delta(t_jhd, t_jlck));
 
 	if (!(head.lh_flags & GFS2_LOG_HEAD_UNMOUNT)) {
-		fs_info(sdp, "jid=%u: Acquiring the freeze glock...\n",
-			jd->jd_jid);
-
-		/* Acquire a shared hold on the freeze glock */
+		mutex_lock(&sdp->sd_freeze_mutex);
 
-		error = gfs2_freeze_lock_shared(sdp, &thaw_gh, LM_FLAG_PRIORITY);
-		if (error)
+		if (atomic_read(&sdp->sd_freeze_state) != SFS_UNFROZEN) {
+			mutex_unlock(&sdp->sd_freeze_mutex);
+			fs_warn(sdp, "jid=%u: Can't replay: filesystem "
+				"is frozen\n", jd->jd_jid);
 			goto fail_gunlock_ji;
+		}
 
 		if (test_bit(SDF_RORECOVERY, &sdp->sd_flags)) {
 			ro = 1;
@@ -496,7 +496,7 @@ void gfs2_recover_func(struct work_struct *work)
 			fs_warn(sdp, "jid=%u: Can't replay: read-only block "
 				"device\n", jd->jd_jid);
 			error = -EROFS;
-			goto fail_gunlock_thaw;
+			goto fail_gunlock_nofreeze;
 		}
 
 		t_tlck = ktime_get();
@@ -514,7 +514,7 @@ void gfs2_recover_func(struct work_struct *work)
 			lops_after_scan(jd, error, pass);
 			if (error) {
 				up_read(&sdp->sd_log_flush_lock);
-				goto fail_gunlock_thaw;
+				goto fail_gunlock_nofreeze;
 			}
 		}
 
@@ -522,7 +522,7 @@ void gfs2_recover_func(struct work_struct *work)
 		clean_journal(jd, &head);
 		up_read(&sdp->sd_log_flush_lock);
 
-		gfs2_freeze_unlock(&thaw_gh);
+		mutex_unlock(&sdp->sd_freeze_mutex);
 		t_rep = ktime_get();
 		fs_info(sdp, "jid=%u: Journal replayed in %lldms [jlck:%lldms, "
 			"jhead:%lldms, tlck:%lldms, replay:%lldms]\n",
@@ -543,8 +543,8 @@ void gfs2_recover_func(struct work_struct *work)
 	fs_info(sdp, "jid=%u: Done\n", jd->jd_jid);
 	goto done;
 
-fail_gunlock_thaw:
-	gfs2_freeze_unlock(&thaw_gh);
+fail_gunlock_nofreeze:
+	mutex_unlock(&sdp->sd_freeze_mutex);
 fail_gunlock_ji:
 	if (jlocked) {
 		gfs2_glock_dq_uninit(&ji_gh);
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index cdfbfda046945..1a888b9c3d110 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -332,7 +332,12 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 	struct lfcc *lfcc;
 	LIST_HEAD(list);
 	struct gfs2_log_header_host lh;
-	int error;
+	int error, error2;
+
+	/*
+	 * Grab all the journal glocks in SH mode.  We are *probably* doing
+	 * that to prevent recovery.
+	 */
 
 	list_for_each_entry(jd, &sdp->sd_jindex_list, jd_list) {
 		lfcc = kmalloc(sizeof(struct lfcc), GFP_KERNEL);
@@ -349,11 +354,13 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 		list_add(&lfcc->list, &list);
 	}
 
+	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+
 	error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_EXCLUSIVE,
 				   LM_FLAG_NOEXP | GL_NOPID,
 				   &sdp->sd_freeze_gh);
 	if (error)
-		goto out;
+		goto relock_shared;
 
 	list_for_each_entry(jd, &sdp->sd_jindex_list, jd_list) {
 		error = gfs2_jdesc_check(jd);
@@ -368,8 +375,14 @@ static int gfs2_lock_fs_check_clean(struct gfs2_sbd *sdp)
 		}
 	}
 
-	if (error)
-		gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+	if (!error)
+		goto out;  /* success */
+
+	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+
+relock_shared:
+	error2 = gfs2_freeze_lock_shared(sdp, &sdp->sd_freeze_gh, 0);
+	gfs2_assert_withdraw(sdp, !error2);
 
 out:
 	while (!list_empty(&list)) {
@@ -600,6 +613,8 @@ static void gfs2_put_super(struct super_block *sb)
 
 	/*  Release stuff  */
 
+	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+
 	iput(sdp->sd_jindex);
 	iput(sdp->sd_statfs_inode);
 	iput(sdp->sd_rindex);
@@ -654,31 +669,82 @@ static int gfs2_sync_fs(struct super_block *sb, int wait)
 	return sdp->sd_log_error;
 }
 
-void gfs2_freeze_func(struct work_struct *work)
+static int gfs2_freeze_locally(struct gfs2_sbd *sdp)
 {
-	int error;
-	struct gfs2_holder freeze_gh;
-	struct gfs2_sbd *sdp = container_of(work, struct gfs2_sbd, sd_freeze_work);
 	struct super_block *sb = sdp->sd_vfs;
+	int error;
 
-	atomic_inc(&sb->s_active);
-	error = gfs2_freeze_lock_shared(sdp, &freeze_gh, 0);
-	if (error) {
-		gfs2_assert_withdraw(sdp, 0);
-	} else {
-		atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
-		error = thaw_super(sb);
-		if (error) {
-			fs_info(sdp, "GFS2: couldn't thaw filesystem: %d\n",
-				error);
-			gfs2_assert_withdraw(sdp, 0);
+	atomic_set(&sdp->sd_freeze_state, SFS_STARTING_FREEZE);
+
+	error = freeze_super(sb);
+	if (error)
+		goto fail;
+
+	if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
+		gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_FREEZE |
+			       GFS2_LFC_FREEZE_GO_SYNC);
+		if (gfs2_withdrawn(sdp)) {
+			thaw_super(sb);
+			error = -EIO;
+			goto fail;
 		}
-		gfs2_freeze_unlock(&freeze_gh);
 	}
+	return 0;
+
+fail:
+	atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
+	return error;
+}
+
+static int gfs2_do_thaw(struct gfs2_sbd *sdp)
+{
+	struct super_block *sb = sdp->sd_vfs;
+	int error;
+
+	error = gfs2_freeze_lock_shared(sdp, &sdp->sd_freeze_gh, 0);
+	if (error)
+		goto fail;
+	error = thaw_super(sb);
+	if (!error)
+		return 0;
+
+fail:
+	fs_info(sdp, "GFS2: couldn't thaw filesystem: %d\n", error);
+	gfs2_assert_withdraw(sdp, 0);
+	return error;
+}
+
+void gfs2_freeze_func(struct work_struct *work)
+{
+	struct gfs2_sbd *sdp = container_of(work, struct gfs2_sbd, sd_freeze_work);
+	struct super_block *sb = sdp->sd_vfs;
+	int error;
+
+	mutex_lock(&sdp->sd_freeze_mutex);
+	error = -EBUSY;
+	if (atomic_read(&sdp->sd_freeze_state) != SFS_UNFROZEN)
+		goto freeze_failed;
+
+	error = gfs2_freeze_locally(sdp);
+	if (error)
+		goto freeze_failed;
+
+	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+	atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
+
+	error = gfs2_do_thaw(sdp);
+	if (error)
+		goto out;
+
+	atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
+	goto out;
+
+freeze_failed:
+	fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n", error);
+
+out:
+	mutex_unlock(&sdp->sd_freeze_mutex);
 	deactivate_super(sb);
-	clear_bit_unlock(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
-	wake_up_bit(&sdp->sd_flags, SDF_FREEZE_INITIATOR);
-	return;
 }
 
 /**
@@ -692,21 +758,27 @@ static int gfs2_freeze_super(struct super_block *sb)
 	struct gfs2_sbd *sdp = sb->s_fs_info;
 	int error;
 
-	mutex_lock(&sdp->sd_freeze_mutex);
-	if (atomic_read(&sdp->sd_freeze_state) != SFS_UNFROZEN) {
-		error = -EBUSY;
+	if (!mutex_trylock(&sdp->sd_freeze_mutex))
+		return -EBUSY;
+	error = -EBUSY;
+	if (atomic_read(&sdp->sd_freeze_state) != SFS_UNFROZEN)
 		goto out;
-	}
 
 	for (;;) {
-		if (gfs2_withdrawn(sdp)) {
-			error = -EINVAL;
+		error = gfs2_freeze_locally(sdp);
+		if (error) {
+			fs_info(sdp, "GFS2: couldn't freeze filesystem: %d\n",
+				error);
 			goto out;
 		}
 
 		error = gfs2_lock_fs_check_clean(sdp);
 		if (!error)
-			break;
+			break;  /* success */
+
+		error = gfs2_do_thaw(sdp);
+		if (error)
+			goto out;
 
 		if (error == -EBUSY)
 			fs_err(sdp, "waiting for recovery before freeze\n");
@@ -720,8 +792,12 @@ static int gfs2_freeze_super(struct super_block *sb)
 		fs_err(sdp, "retrying...\n");
 		msleep(1000);
 	}
-	set_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
+
 out:
+	if (!error) {
+		set_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
+		atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
+	}
 	mutex_unlock(&sdp->sd_freeze_mutex);
 	return error;
 }
@@ -735,17 +811,39 @@ static int gfs2_freeze_super(struct super_block *sb)
 static int gfs2_thaw_super(struct super_block *sb)
 {
 	struct gfs2_sbd *sdp = sb->s_fs_info;
+	int error;
 
-	mutex_lock(&sdp->sd_freeze_mutex);
-	if (atomic_read(&sdp->sd_freeze_state) != SFS_FROZEN ||
-	    !gfs2_holder_initialized(&sdp->sd_freeze_gh)) {
-		mutex_unlock(&sdp->sd_freeze_mutex);
-		return -EINVAL;
+	if (!mutex_trylock(&sdp->sd_freeze_mutex))
+		return -EBUSY;
+	error = -EINVAL;
+	if (!test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags))
+		goto out;
+
+	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+
+	error = gfs2_do_thaw(sdp);
+
+	if (!error) {
+		clear_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags);
+		atomic_set(&sdp->sd_freeze_state, SFS_UNFROZEN);
 	}
+out:
+	mutex_unlock(&sdp->sd_freeze_mutex);
+	return error;
+}
+
+void gfs2_thaw_freeze_initiator(struct super_block *sb)
+{
+	struct gfs2_sbd *sdp = sb->s_fs_info;
+
+	mutex_lock(&sdp->sd_freeze_mutex);
+	if (!test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags))
+		goto out;
 
 	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
+
+out:
 	mutex_unlock(&sdp->sd_freeze_mutex);
-	return wait_on_bit(&sdp->sd_flags, SDF_FREEZE_INITIATOR, TASK_INTERRUPTIBLE);
 }
 
 /**
diff --git a/fs/gfs2/super.h b/fs/gfs2/super.h
index 58d13fd77aed5..bba58629bc458 100644
--- a/fs/gfs2/super.h
+++ b/fs/gfs2/super.h
@@ -46,6 +46,7 @@ extern void gfs2_statfs_change_out(const struct gfs2_statfs_change_host *sc,
 extern void update_statfs(struct gfs2_sbd *sdp, struct buffer_head *m_bh);
 extern int gfs2_statfs_sync(struct super_block *sb, int type);
 extern void gfs2_freeze_func(struct work_struct *work);
+extern void gfs2_thaw_freeze_initiator(struct super_block *sb);
 
 extern void free_local_statfs_inodes(struct gfs2_sbd *sdp);
 extern struct inode *find_local_statfs_inode(struct gfs2_sbd *sdp,
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index ebf87fb7b3bf5..d4cc8667a5b72 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -124,7 +124,6 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	struct gfs2_inode *ip;
 	struct gfs2_glock *i_gl;
 	u64 no_formal_ino;
-	int log_write_allowed = test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 	int ret = 0;
 	int tries;
 
@@ -152,24 +151,18 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	 */
 	clear_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
 	if (!sb_rdonly(sdp->sd_vfs)) {
-		struct gfs2_holder freeze_gh;
-
-		gfs2_holder_mark_uninitialized(&freeze_gh);
-		if (sdp->sd_freeze_gl &&
-		    !gfs2_glock_is_locked_by_me(sdp->sd_freeze_gl)) {
-			ret = gfs2_freeze_lock_shared(sdp, &freeze_gh,
-					log_write_allowed ? 0 : LM_FLAG_TRY);
-			if (ret == GLR_TRYFAILED)
-				ret = 0;
-		}
-		if (!ret)
-			gfs2_make_fs_ro(sdp);
+		bool locked = mutex_trylock(&sdp->sd_freeze_mutex);
+
+		gfs2_make_fs_ro(sdp);
+
+		if (locked)
+			mutex_unlock(&sdp->sd_freeze_mutex);
+
 		/*
 		 * Dequeue any pending non-system glock holders that can no
 		 * longer be granted because the file system is withdrawn.
 		 */
 		gfs2_gl_dq_holders(sdp);
-		gfs2_freeze_unlock(&freeze_gh);
 	}
 
 	if (sdp->sd_lockstruct.ls_ops->lm_lock == NULL) { /* lock_nolock */
@@ -187,15 +180,8 @@ static void signal_our_withdraw(struct gfs2_sbd *sdp)
 	}
 	sdp->sd_jinode_gh.gh_flags |= GL_NOCACHE;
 	gfs2_glock_dq(&sdp->sd_jinode_gh);
-	if (test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags)) {
-		/* Make sure gfs2_thaw_super works if partially-frozen */
-		flush_work(&sdp->sd_freeze_work);
-		atomic_set(&sdp->sd_freeze_state, SFS_FROZEN);
-		thaw_super(sdp->sd_vfs);
-	} else {
-		wait_on_bit(&i_gl->gl_flags, GLF_DEMOTE,
-			    TASK_UNINTERRUPTIBLE);
-	}
+	gfs2_thaw_freeze_initiator(sdp->sd_vfs);
+	wait_on_bit(&i_gl->gl_flags, GLF_DEMOTE, TASK_UNINTERRUPTIBLE);
 
 	/*
 	 * holder_uninit to force glock_put, to force dlm to let go
-- 
2.43.0





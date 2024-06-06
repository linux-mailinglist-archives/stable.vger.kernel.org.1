Return-Path: <stable+bounces-48996-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6B18FEB6C
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E0A2B21000
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC571993BD;
	Thu,  6 Jun 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ui+0AT9G"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB096196D9B;
	Thu,  6 Jun 2024 14:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683249; cv=none; b=MoHOX1eeqKBixLyDKk19MF4eNQYk/Ecr35cJr5R9oi+Bf8ew/HbzVAd46/ijSUnpVtWChJCVdkGS//dZNk5nb48dF/tAk35HDFbx8SmFyVzsOfQr+dsrJUO+AF9RQxWeeZnaZI6YR75BIT03UBHmcPIx09C+e63TDts2KE7VxIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683249; c=relaxed/simple;
	bh=3hyOOW0u2kyJLQFNwq/xaF30nL7MFAuK6t9zXdcUejI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V6l3FMMUpcKa1L14LjuWjXisyZ1qf1Kr009yN8Tva7rKXdZ9wkQlxTineSliQiNZLG1ZRiMwAeZBycvgGjQUwUUAqGicn9Akief+cP6E716rTvoXCegh0Gd8Gs1WijIg3/0jWDLt5rkyTERokxKWrnTtllsgrwy0O8YG9X1ivoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ui+0AT9G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDAEC2BD10;
	Thu,  6 Jun 2024 14:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683249;
	bh=3hyOOW0u2kyJLQFNwq/xaF30nL7MFAuK6t9zXdcUejI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ui+0AT9G8YdmiN7S9V1tixi13OlzWtlCWFfIsne7kixlB6sFs9Vx3V/jjeA88gSPW
	 WS7od3OSQVuftfHYtTkKwHSL0wGVZgQFu9MHmPh1HVFUzmidCPvuC/uGFCmVcaIozW
	 vax5f7FRCSrUrzl4nAJVxyOAy2ZM8i4pfuyxJmqE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 193/744] gfs2: Rename gfs2_withdrawn to gfs2_withdrawing_or_withdrawn
Date: Thu,  6 Jun 2024 15:57:45 +0200
Message-ID: <20240606131738.628114637@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 4d927b03a68846e4e791ccde6b4c274df02f11e9 ]

This function checks whether the filesystem has been been marked to be
withdrawn eventually or has been withdrawn already.  Rename this
function to avoid confusing code like checking for gfs2_withdrawing()
when gfs2_withdrawn() has already returned true.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Stable-dep-of: 9947a06d29c0 ("gfs2: do_xmote fixes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/aops.c       |  2 +-
 fs/gfs2/file.c       |  2 +-
 fs/gfs2/glock.c      |  8 ++++----
 fs/gfs2/glops.c      |  2 +-
 fs/gfs2/lock_dlm.c   |  8 ++++----
 fs/gfs2/log.c        | 21 +++++++++++----------
 fs/gfs2/meta_io.c    |  9 ++++++---
 fs/gfs2/ops_fstype.c |  2 +-
 fs/gfs2/quota.c      |  8 ++++----
 fs/gfs2/recovery.c   |  2 +-
 fs/gfs2/super.c      | 10 +++++-----
 fs/gfs2/sys.c        |  2 +-
 fs/gfs2/trans.c      |  2 +-
 fs/gfs2/util.c       |  4 ++--
 fs/gfs2/util.h       |  5 +++--
 15 files changed, 46 insertions(+), 41 deletions(-)

diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index b8404ce301b3c..6097db9a7ebf3 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -464,7 +464,7 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 		error = mpage_read_folio(folio, gfs2_block_map);
 	}
 
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return -EIO;
 
 	return error;
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 1dc7fe805d2f1..9296e0e282bcd 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -1436,7 +1436,7 @@ static int gfs2_lock(struct file *file, int cmd, struct file_lock *fl)
 
 	if (!(fl->fl_flags & FL_POSIX))
 		return -ENOLCK;
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		if (fl->fl_type == F_UNLCK)
 			locks_lock_file_wait(file, fl);
 		return -EIO;
diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 42de9db983a8b..7af12c8fb577d 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -156,7 +156,7 @@ static bool glock_blocked_by_withdraw(struct gfs2_glock *gl)
 {
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
 
-	if (!gfs2_withdrawn(sdp))
+	if (!gfs2_withdrawing_or_withdrawn(sdp))
 		return false;
 	if (gl->gl_ops->go_flags & GLOF_NONDISK)
 		return false;
@@ -304,7 +304,7 @@ static void __gfs2_glock_put(struct gfs2_glock *gl)
 	GLOCK_BUG_ON(gl, !list_empty(&gl->gl_holders));
 	if (mapping) {
 		truncate_inode_pages_final(mapping);
-		if (!gfs2_withdrawn(sdp))
+		if (!gfs2_withdrawing_or_withdrawn(sdp))
 			GLOCK_BUG_ON(gl, !mapping_empty(mapping));
 	}
 	trace_gfs2_glock_put(gl);
@@ -783,7 +783,7 @@ __acquires(&gl->gl_lockref.lock)
 	 * gfs2_gl_hash_clear calls clear_glock) and recovery is complete
 	 * then it's okay to tell dlm to unlock it.
 	 */
-	if (unlikely(sdp->sd_log_error) && !gfs2_withdrawn(sdp))
+	if (unlikely(sdp->sd_log_error) && !gfs2_withdrawing_or_withdrawn(sdp))
 		gfs2_withdraw_delayed(sdp);
 	if (glock_blocked_by_withdraw(gl) &&
 	    (target != LM_ST_UNLOCKED ||
@@ -822,7 +822,7 @@ __acquires(&gl->gl_lockref.lock)
 			gfs2_glock_queue_work(gl, 0);
 		} else if (ret) {
 			fs_err(sdp, "lm_lock ret %d\n", ret);
-			GLOCK_BUG_ON(gl, !gfs2_withdrawn(sdp));
+			GLOCK_BUG_ON(gl, !gfs2_withdrawing_or_withdrawn(sdp));
 		}
 	} else { /* lock_nolock */
 		finish_xmote(gl, target);
diff --git a/fs/gfs2/glops.c b/fs/gfs2/glops.c
index 3c6f508383fe2..1c854d4e2d491 100644
--- a/fs/gfs2/glops.c
+++ b/fs/gfs2/glops.c
@@ -177,7 +177,7 @@ static int gfs2_rgrp_metasync(struct gfs2_glock *gl)
 
 	filemap_fdatawrite_range(metamapping, start, end);
 	error = filemap_fdatawait_range(metamapping, start, end);
-	WARN_ON_ONCE(error && !gfs2_withdrawn(sdp));
+	WARN_ON_ONCE(error && !gfs2_withdrawing_or_withdrawn(sdp));
 	mapping_set_error(metamapping, error);
 	if (error)
 		gfs2_io_error(sdp);
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index 0bde45fb49630..e028e55e67d95 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -1134,7 +1134,7 @@ static void gdlm_recover_prep(void *arg)
 	struct gfs2_sbd *sdp = arg;
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		fs_err(sdp, "recover_prep ignored due to withdraw.\n");
 		return;
 	}
@@ -1160,7 +1160,7 @@ static void gdlm_recover_slot(void *arg, struct dlm_slot *slot)
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	int jid = slot->slot - 1;
 
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		fs_err(sdp, "recover_slot jid %d ignored due to withdraw.\n",
 		       jid);
 		return;
@@ -1189,7 +1189,7 @@ static void gdlm_recover_done(void *arg, struct dlm_slot *slots, int num_slots,
 	struct gfs2_sbd *sdp = arg;
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		fs_err(sdp, "recover_done ignored due to withdraw.\n");
 		return;
 	}
@@ -1220,7 +1220,7 @@ static void gdlm_recovery_result(struct gfs2_sbd *sdp, unsigned int jid,
 {
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		fs_err(sdp, "recovery_result jid %d ignored due to withdraw.\n",
 		       jid);
 		return;
diff --git a/fs/gfs2/log.c b/fs/gfs2/log.c
index e5271ae87d1c4..88bc9b1b22650 100644
--- a/fs/gfs2/log.c
+++ b/fs/gfs2/log.c
@@ -126,7 +126,7 @@ __acquires(&sdp->sd_ail_lock)
 			}
 		}
 
-		if (gfs2_withdrawn(sdp)) {
+		if (gfs2_withdrawing_or_withdrawn(sdp)) {
 			gfs2_remove_from_ail(bd);
 			continue;
 		}
@@ -841,7 +841,7 @@ void gfs2_write_log_header(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
 	struct super_block *sb = sdp->sd_vfs;
 	u64 dblock;
 
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return;
 
 	page = mempool_alloc(gfs2_page_pool, GFP_NOIO);
@@ -1047,7 +1047,8 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	 * Do this check while holding the log_flush_lock to prevent new
 	 * buffers from being added to the ail via gfs2_pin()
 	 */
-	if (gfs2_withdrawn(sdp) || !test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
+	if (gfs2_withdrawing_or_withdrawn(sdp) ||
+	    !test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags))
 		goto out;
 
 	/* Log might have been flushed while we waited for the flush lock */
@@ -1096,13 +1097,13 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 			goto out_withdraw;
 
 	gfs2_ordered_write(sdp);
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		goto out_withdraw;
 	lops_before_commit(sdp, tr);
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		goto out_withdraw;
 	gfs2_log_submit_bio(&sdp->sd_jdesc->jd_log_bio, REQ_OP_WRITE);
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		goto out_withdraw;
 
 	if (sdp->sd_log_head != sdp->sd_log_flush_head) {
@@ -1110,7 +1111,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	} else if (sdp->sd_log_tail != sdp->sd_log_flush_tail && !sdp->sd_log_idle) {
 		log_write_header(sdp, flags);
 	}
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		goto out_withdraw;
 	lops_after_commit(sdp, tr);
 
@@ -1128,7 +1129,7 @@ void gfs2_log_flush(struct gfs2_sbd *sdp, struct gfs2_glock *gl, u32 flags)
 	if (!(flags & GFS2_LOG_HEAD_FLUSH_NORMAL)) {
 		if (!sdp->sd_log_idle) {
 			empty_ail1_list(sdp);
-			if (gfs2_withdrawn(sdp))
+			if (gfs2_withdrawing_or_withdrawn(sdp))
 				goto out_withdraw;
 			log_write_header(sdp, flags);
 		}
@@ -1298,7 +1299,7 @@ int gfs2_logd(void *data)
 	unsigned long t = 1;
 
 	while (!kthread_should_stop()) {
-		if (gfs2_withdrawn(sdp))
+		if (gfs2_withdrawing_or_withdrawn(sdp))
 			break;
 
 		/* Check for errors writing to the journal */
@@ -1337,7 +1338,7 @@ int gfs2_logd(void *data)
 				gfs2_ail_flush_reqd(sdp) ||
 				gfs2_jrnl_flush_reqd(sdp) ||
 				sdp->sd_log_error ||
-				gfs2_withdrawn(sdp) ||
+				gfs2_withdrawing_or_withdrawn(sdp) ||
 				kthread_should_stop(),
 				t);
 	}
diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
index 50c2ecbba7ca7..1f42eae112fb8 100644
--- a/fs/gfs2/meta_io.c
+++ b/fs/gfs2/meta_io.c
@@ -257,7 +257,8 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 	struct buffer_head *bh, *bhs[2];
 	int num = 0;
 
-	if (gfs2_withdrawn(sdp) && !gfs2_withdraw_in_prog(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp) &&
+	    !gfs2_withdraw_in_prog(sdp)) {
 		*bhp = NULL;
 		return -EIO;
 	}
@@ -315,7 +316,8 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
 
 int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 {
-	if (gfs2_withdrawn(sdp) && !gfs2_withdraw_in_prog(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp) &&
+	    !gfs2_withdraw_in_prog(sdp))
 		return -EIO;
 
 	wait_on_buffer(bh);
@@ -326,7 +328,8 @@ int gfs2_meta_wait(struct gfs2_sbd *sdp, struct buffer_head *bh)
 			gfs2_io_error_bh_wd(sdp, bh);
 		return -EIO;
 	}
-	if (gfs2_withdrawn(sdp) && !gfs2_withdraw_in_prog(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp) &&
+	    !gfs2_withdraw_in_prog(sdp))
 		return -EIO;
 
 	return 0;
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index be7df57bd5c86..5d51bc58a9a03 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1075,7 +1075,7 @@ static int gfs2_lm_mount(struct gfs2_sbd *sdp, int silent)
 void gfs2_lm_unmount(struct gfs2_sbd *sdp)
 {
 	const struct lm_lockops *lm = sdp->sd_lockstruct.ls_ops;
-	if (!gfs2_withdrawn(sdp) && lm->lm_unmount)
+	if (!gfs2_withdrawing_or_withdrawn(sdp) && lm->lm_unmount)
 		lm->lm_unmount(sdp);
 }
 
diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index f689847bab40f..892b1c44de531 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -128,7 +128,7 @@ static void gfs2_qd_dispose(struct gfs2_quota_data *qd)
 	hlist_bl_del_rcu(&qd->qd_hlist);
 	spin_unlock_bucket(qd->qd_hash);
 
-	if (!gfs2_withdrawn(sdp)) {
+	if (!gfs2_withdrawing_or_withdrawn(sdp)) {
 		gfs2_assert_warn(sdp, !qd->qd_change);
 		gfs2_assert_warn(sdp, !qd->qd_slot_ref);
 		gfs2_assert_warn(sdp, !qd->qd_bh_count);
@@ -1528,7 +1528,7 @@ static void quotad_error(struct gfs2_sbd *sdp, const char *msg, int error)
 {
 	if (error == 0 || error == -EROFS)
 		return;
-	if (!gfs2_withdrawn(sdp)) {
+	if (!gfs2_withdrawing_or_withdrawn(sdp)) {
 		if (!cmpxchg(&sdp->sd_log_error, 0, error))
 			fs_err(sdp, "gfs2_quotad: %s error %d\n", msg, error);
 		wake_up(&sdp->sd_logd_waitq);
@@ -1572,7 +1572,7 @@ int gfs2_quotad(void *data)
 	unsigned long t = 0;
 
 	while (!kthread_should_stop()) {
-		if (gfs2_withdrawn(sdp))
+		if (gfs2_withdrawing_or_withdrawn(sdp))
 			break;
 
 		/* Update the master statfs file */
@@ -1596,7 +1596,7 @@ int gfs2_quotad(void *data)
 
 		t = wait_event_interruptible_timeout(sdp->sd_quota_wait,
 				sdp->sd_statfs_force_sync ||
-				gfs2_withdrawn(sdp) ||
+				gfs2_withdrawing_or_withdrawn(sdp) ||
 				kthread_should_stop(),
 				t);
 
diff --git a/fs/gfs2/recovery.c b/fs/gfs2/recovery.c
index 5aae02669a409..f4fe7039f725b 100644
--- a/fs/gfs2/recovery.c
+++ b/fs/gfs2/recovery.c
@@ -411,7 +411,7 @@ void gfs2_recover_func(struct work_struct *work)
 	int error = 0;
 	int jlocked = 0;
 
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		fs_err(sdp, "jid=%u: Recovery not attempted due to withdraw.\n",
 		       jd->jd_jid);
 		goto fail;
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 1afcca5292d55..2e1d1eca4d14a 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -134,7 +134,7 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 	int error;
 
 	j_gl->gl_ops->go_inval(j_gl, DIO_METADATA);
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return -EIO;
 
 	error = gfs2_find_jhead(sdp->sd_jdesc, &head, false);
@@ -153,7 +153,7 @@ int gfs2_make_fs_rw(struct gfs2_sbd *sdp)
 	gfs2_log_pointers_init(sdp, head.lh_blkno);
 
 	error = gfs2_quota_init(sdp);
-	if (!error && gfs2_withdrawn(sdp))
+	if (!error && gfs2_withdrawing_or_withdrawn(sdp))
 		error = -EIO;
 	if (!error)
 		set_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);
@@ -499,7 +499,7 @@ static void gfs2_dirty_inode(struct inode *inode, int flags)
 		return;
 	}
 
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return;
 	if (!gfs2_glock_is_locked_by_me(ip->i_gl)) {
 		ret = gfs2_glock_nq_init(ip->i_gl, LM_ST_EXCLUSIVE, 0, &gh);
@@ -605,7 +605,7 @@ static void gfs2_put_super(struct super_block *sb)
 	if (!sb_rdonly(sb))
 		gfs2_make_fs_ro(sdp);
 	else {
-		if (gfs2_withdrawn(sdp))
+		if (gfs2_withdrawing_or_withdrawn(sdp))
 			gfs2_destroy_threads(sdp);
 
 		gfs2_quota_cleanup(sdp);
@@ -682,7 +682,7 @@ static int gfs2_freeze_locally(struct gfs2_sbd *sdp)
 	if (test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags)) {
 		gfs2_log_flush(sdp, NULL, GFS2_LOG_HEAD_FLUSH_FREEZE |
 			       GFS2_LFC_FREEZE_GO_SYNC);
-		if (gfs2_withdrawn(sdp)) {
+		if (gfs2_withdrawing_or_withdrawn(sdp)) {
 			error = thaw_super(sb, FREEZE_HOLDER_USERSPACE);
 			if (error)
 				return error;
diff --git a/fs/gfs2/sys.c b/fs/gfs2/sys.c
index 60a0206890c54..250f340cb44d6 100644
--- a/fs/gfs2/sys.c
+++ b/fs/gfs2/sys.c
@@ -193,7 +193,7 @@ static ssize_t freeze_store(struct gfs2_sbd *sdp, const char *buf, size_t len)
 
 static ssize_t withdraw_show(struct gfs2_sbd *sdp, char *buf)
 {
-	unsigned int b = gfs2_withdrawn(sdp);
+	unsigned int b = gfs2_withdrawing_or_withdrawn(sdp);
 	return snprintf(buf, PAGE_SIZE, "%u\n", b);
 }
 
diff --git a/fs/gfs2/trans.c b/fs/gfs2/trans.c
index 1487fbb62d842..192213c7359af 100644
--- a/fs/gfs2/trans.c
+++ b/fs/gfs2/trans.c
@@ -268,7 +268,7 @@ void gfs2_trans_add_meta(struct gfs2_glock *gl, struct buffer_head *bh)
 		       (unsigned long long)bd->bd_bh->b_blocknr);
 		BUG();
 	}
-	if (gfs2_withdrawn(sdp)) {
+	if (gfs2_withdrawing_or_withdrawn(sdp)) {
 		fs_info(sdp, "GFS2:adding buf while withdrawn! 0x%llx\n",
 			(unsigned long long)bd->bd_bh->b_blocknr);
 		goto out_unlock;
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index d424691bd3f8a..fc3ecb180ac53 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -371,7 +371,7 @@ void gfs2_assert_withdraw_i(struct gfs2_sbd *sdp, char *assertion,
 			    const char *function, char *file, unsigned int line,
 			    bool delayed)
 {
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return;
 
 	fs_err(sdp,
@@ -547,7 +547,7 @@ void gfs2_io_error_bh_i(struct gfs2_sbd *sdp, struct buffer_head *bh,
 			const char *function, char *file, unsigned int line,
 			bool withdraw)
 {
-	if (gfs2_withdrawn(sdp))
+	if (gfs2_withdrawing_or_withdrawn(sdp))
 		return;
 
 	fs_err(sdp, "fatal: I/O error\n"
diff --git a/fs/gfs2/util.h b/fs/gfs2/util.h
index 76acf0b398149..ba071998461fd 100644
--- a/fs/gfs2/util.h
+++ b/fs/gfs2/util.h
@@ -198,10 +198,11 @@ static inline void gfs2_withdraw_delayed(struct gfs2_sbd *sdp)
 }
 
 /**
- * gfs2_withdrawn - test whether the file system is withdrawing or withdrawn
+ * gfs2_withdrawing_or_withdrawn - test whether the file system is withdrawing
+ *                                 or withdrawn
  * @sdp: the superblock
  */
-static inline bool gfs2_withdrawn(struct gfs2_sbd *sdp)
+static inline bool gfs2_withdrawing_or_withdrawn(struct gfs2_sbd *sdp)
 {
 	return unlikely(test_bit(SDF_WITHDRAWN, &sdp->sd_flags) ||
 			test_bit(SDF_WITHDRAWING, &sdp->sd_flags));
-- 
2.43.0





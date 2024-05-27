Return-Path: <stable+bounces-46742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D488D0B12
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5C91C20CE5
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFDF15FD11;
	Mon, 27 May 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pnh+0Ut9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3C1754B;
	Mon, 27 May 2024 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836743; cv=none; b=aWIpx9bZqhtzN8J83X1DHo8HsAjgYEuXkE66CFNhnj2V4OQ+PbsRDu+lPPwDVp2qjuFnmgjKxxQo5CX16Aax0tPixv6NKKVFyRyDa6XTWd1I9x/Gfz1AUQIPNEhj8zGo3AJ55b6Sy0RIuJxRzRtFHSUtMg49vcVedgWasfs7h4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836743; c=relaxed/simple;
	bh=rZCxaUFb3K9Yb2O0YMeufDCPal+Igs3v7kRYdXQXlm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/A9iaPxM4vpfgceozyi9aCHhZqged4NedQiShMJ5AyAhVecGJNBp9Zjv99PaW+wis2eLZJghIsNgbdeO8qlIk/WNhZWPXvsU8h1Qq96ld4QLBk4YsvLg0irK/hbaZLPTwf408xTwHo5IYvAxkrjuf6gpAlF4YHKpBfQoKM52ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pnh+0Ut9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7821DC2BBFC;
	Mon, 27 May 2024 19:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836742;
	bh=rZCxaUFb3K9Yb2O0YMeufDCPal+Igs3v7kRYdXQXlm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pnh+0Ut9AUiq+wTZBVoj2ThNVRLSlHWrlYbQFN0uLalvhircHP1e+Jyofo0yzqdoC
	 Q3YUZ0Yoxikd1GBPUXIM9jwxm3qqAfg3rMxPGkVlEVx7v5PJr0XFWAsiLZuUhTv0a9
	 r2tFtmWbvF+fUF2yoZ0hZR3h3oe1mCCxvhG2H80Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 169/427] gfs2: Fix potential glock use-after-free on unmount
Date: Mon, 27 May 2024 20:53:36 +0200
Message-ID: <20240527185618.110932423@linuxfoundation.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240527185601.713589927@linuxfoundation.org>
References: <20240527185601.713589927@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit d98779e687726d8f8860f1c54b5687eec5f63a73 ]

When a DLM lockspace is released and there ares still locks in that
lockspace, DLM will unlock those locks automatically.  Commit
fb6791d100d1b started exploiting this behavior to speed up filesystem
unmount: gfs2 would simply free glocks it didn't want to unlock and then
release the lockspace.  This didn't take the bast callbacks for
asynchronous lock contention notifications into account, which remain
active until until a lock is unlocked or its lockspace is released.

To prevent those callbacks from accessing deallocated objects, put the
glocks that should not be unlocked on the sd_dead_glocks list, release
the lockspace, and only then free those glocks.

As an additional measure, ignore unexpected ast and bast callbacks if
the receiving glock is dead.

Fixes: fb6791d100d1b ("GFS2: skip dlm_unlock calls in unmount")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Cc: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glock.c      | 35 ++++++++++++++++++++++++++++++++---
 fs/gfs2/glock.h      |  1 +
 fs/gfs2/incore.h     |  1 +
 fs/gfs2/lock_dlm.c   | 32 ++++++++++++++++++++++----------
 fs/gfs2/ops_fstype.c |  1 +
 fs/gfs2/super.c      |  3 ---
 6 files changed, 57 insertions(+), 16 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 5d5b3235d4e59..1bf0d751ece0a 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -166,18 +166,45 @@ static bool glock_blocked_by_withdraw(struct gfs2_glock *gl)
 	return true;
 }
 
-void gfs2_glock_free(struct gfs2_glock *gl)
+static void __gfs2_glock_free(struct gfs2_glock *gl)
 {
-	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
-
 	rhashtable_remove_fast(&gl_hash_table, &gl->gl_node, ht_parms);
 	smp_mb();
 	wake_up_glock(gl);
 	call_rcu(&gl->gl_rcu, gfs2_glock_dealloc);
+}
+
+void gfs2_glock_free(struct gfs2_glock *gl) {
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+
+	__gfs2_glock_free(gl);
 	if (atomic_dec_and_test(&sdp->sd_glock_disposal))
 		wake_up(&sdp->sd_kill_wait);
 }
 
+void gfs2_glock_free_later(struct gfs2_glock *gl) {
+	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+
+	spin_lock(&lru_lock);
+	list_add(&gl->gl_lru, &sdp->sd_dead_glocks);
+	spin_unlock(&lru_lock);
+	if (atomic_dec_and_test(&sdp->sd_glock_disposal))
+		wake_up(&sdp->sd_kill_wait);
+}
+
+static void gfs2_free_dead_glocks(struct gfs2_sbd *sdp)
+{
+	struct list_head *list = &sdp->sd_dead_glocks;
+
+	while(!list_empty(list)) {
+		struct gfs2_glock *gl;
+
+		gl = list_first_entry(list, struct gfs2_glock, gl_lru);
+		list_del_init(&gl->gl_lru);
+		__gfs2_glock_free(gl);
+	}
+}
+
 /**
  * gfs2_glock_hold() - increment reference count on glock
  * @gl: The glock to hold
@@ -2226,6 +2253,8 @@ void gfs2_gl_hash_clear(struct gfs2_sbd *sdp)
 	wait_event_timeout(sdp->sd_kill_wait,
 			   atomic_read(&sdp->sd_glock_disposal) == 0,
 			   HZ * 600);
+	gfs2_lm_unmount(sdp);
+	gfs2_free_dead_glocks(sdp);
 	glock_hash_walk(dump_glock_func, sdp);
 }
 
diff --git a/fs/gfs2/glock.h b/fs/gfs2/glock.h
index 0114f3e0ebe01..86987a59a0580 100644
--- a/fs/gfs2/glock.h
+++ b/fs/gfs2/glock.h
@@ -252,6 +252,7 @@ void gfs2_gl_dq_holders(struct gfs2_sbd *sdp);
 void gfs2_glock_thaw(struct gfs2_sbd *sdp);
 void gfs2_glock_add_to_lru(struct gfs2_glock *gl);
 void gfs2_glock_free(struct gfs2_glock *gl);
+void gfs2_glock_free_later(struct gfs2_glock *gl);
 
 int __init gfs2_glock_init(void);
 void gfs2_glock_exit(void);
diff --git a/fs/gfs2/incore.h b/fs/gfs2/incore.h
index 95a334d64da2a..60abd7050c998 100644
--- a/fs/gfs2/incore.h
+++ b/fs/gfs2/incore.h
@@ -838,6 +838,7 @@ struct gfs2_sbd {
 	/* For quiescing the filesystem */
 	struct gfs2_holder sd_freeze_gh;
 	struct mutex sd_freeze_mutex;
+	struct list_head sd_dead_glocks;
 
 	char sd_fsname[GFS2_FSNAME_LEN + 3 * sizeof(int) + 2];
 	char sd_table_name[GFS2_FSNAME_LEN];
diff --git a/fs/gfs2/lock_dlm.c b/fs/gfs2/lock_dlm.c
index d1ac5d0679ea6..e028e55e67d95 100644
--- a/fs/gfs2/lock_dlm.c
+++ b/fs/gfs2/lock_dlm.c
@@ -121,6 +121,11 @@ static void gdlm_ast(void *arg)
 	struct gfs2_glock *gl = arg;
 	unsigned ret = gl->gl_state;
 
+	/* If the glock is dead, we only react to a dlm_unlock() reply. */
+	if (__lockref_is_dead(&gl->gl_lockref) &&
+	    gl->gl_lksb.sb_status != -DLM_EUNLOCK)
+		return;
+
 	gfs2_update_reply_times(gl);
 	BUG_ON(gl->gl_lksb.sb_flags & DLM_SBF_DEMOTED);
 
@@ -171,6 +176,9 @@ static void gdlm_bast(void *arg, int mode)
 {
 	struct gfs2_glock *gl = arg;
 
+	if (__lockref_is_dead(&gl->gl_lockref))
+		return;
+
 	switch (mode) {
 	case DLM_LOCK_EX:
 		gfs2_glock_cb(gl, LM_ST_UNLOCKED);
@@ -291,8 +299,12 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	int error;
 
-	if (gl->gl_lksb.sb_lkid == 0)
-		goto out_free;
+	BUG_ON(!__lockref_is_dead(&gl->gl_lockref));
+
+	if (gl->gl_lksb.sb_lkid == 0) {
+		gfs2_glock_free(gl);
+		return;
+	}
 
 	clear_bit(GLF_BLOCKING, &gl->gl_flags);
 	gfs2_glstats_inc(gl, GFS2_LKS_DCOUNT);
@@ -300,13 +312,17 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 	gfs2_update_request_times(gl);
 
 	/* don't want to call dlm if we've unmounted the lock protocol */
-	if (test_bit(DFL_UNMOUNT, &ls->ls_recover_flags))
-		goto out_free;
+	if (test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
+		gfs2_glock_free(gl);
+		return;
+	}
 	/* don't want to skip dlm_unlock writing the lvb when lock has one */
 
 	if (test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags) &&
-	    !gl->gl_lksb.sb_lvbptr)
-		goto out_free;
+	    !gl->gl_lksb.sb_lvbptr) {
+		gfs2_glock_free_later(gl);
+		return;
+	}
 
 again:
 	error = dlm_unlock(ls->ls_dlm, gl->gl_lksb.sb_lkid, DLM_LKF_VALBLK,
@@ -321,10 +337,6 @@ static void gdlm_put_lock(struct gfs2_glock *gl)
 		       gl->gl_name.ln_type,
 		       (unsigned long long)gl->gl_name.ln_number, error);
 	}
-	return;
-
-out_free:
-	gfs2_glock_free(gl);
 }
 
 static void gdlm_cancel(struct gfs2_glock *gl)
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 572d58e86296f..cde7118599abb 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -136,6 +136,7 @@ static struct gfs2_sbd *init_sbd(struct super_block *sb)
 	atomic_set(&sdp->sd_log_in_flight, 0);
 	init_waitqueue_head(&sdp->sd_log_flush_wait);
 	mutex_init(&sdp->sd_freeze_mutex);
+	INIT_LIST_HEAD(&sdp->sd_dead_glocks);
 
 	return sdp;
 
diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index e5f79466340d2..2d780b4701a23 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -646,10 +646,7 @@ static void gfs2_put_super(struct super_block *sb)
 	gfs2_gl_hash_clear(sdp);
 	truncate_inode_pages_final(&sdp->sd_aspace);
 	gfs2_delete_debugfs_file(sdp);
-	/*  Unmount the locking protocol  */
-	gfs2_lm_unmount(sdp);
 
-	/*  At this point, we're through participating in the lockspace  */
 	gfs2_sys_fs_del(sdp);
 	free_sbd(sdp);
 }
-- 
2.43.0





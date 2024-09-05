Return-Path: <stable+bounces-73454-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4B096D4F0
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 11:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2154B282FE
	for <lists+stable@lfdr.de>; Thu,  5 Sep 2024 09:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C9F194AC7;
	Thu,  5 Sep 2024 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vAp/AW2W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DF215574C;
	Thu,  5 Sep 2024 09:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725530285; cv=none; b=MU0jMo59tyM2bZ0wT7q4l4hC0ByWZzX4hSkOI5O+yMSg6yDqn9a1iyZUTQomxuJZr79495VjzWh9lI/aMCTw60uxcE7o2f6o8KZA1NRYeocTtJEF5HEm9YXsB4ovQ4dcqaqJQJwtAngpWdJSw4FvrIFb9zqUBr+zbWjgR1ogzK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725530285; c=relaxed/simple;
	bh=Ah1JzXrj/sBHK4GG152PQsdfaSq29o0e7MDybCm58o8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWrT4FVdslD3KqKd6Ra3E8UXR4K3zVPHUN/zQNoLAiZ35+Mri3iqbANHo4tXgpWuL1iyk1XRJNkEb8R4JowkfkkWWSL25iabdDxorcFZiEcgs2AhHKceHn5jntCQr6Y4gUaXrvWijMvvaP9fGmNxJ5jn/ZZniqenB1zgdoHXljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vAp/AW2W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A9BC4CEC3;
	Thu,  5 Sep 2024 09:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725530284;
	bh=Ah1JzXrj/sBHK4GG152PQsdfaSq29o0e7MDybCm58o8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vAp/AW2WBNfvuNT4I/4Bwp/RdWhNZAbS50dhF36FHRt+geonCyVgplYUPzVwGi3WA
	 lnmbHlVUk/xuhaXfWwMs3NF5KUUhKmOjvK0LQ/UsWdP4hZXIn1D+vL7ZwwavsNCkfW
	 Nnq5XKam/xeYhoShFD8SDqR54jComupCgFN+1eYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 111/132] gfs2: Revert "Add quota_change type"
Date: Thu,  5 Sep 2024 11:41:38 +0200
Message-ID: <20240905093726.544686825@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905093722.230767298@linuxfoundation.org>
References: <20240905093722.230767298@linuxfoundation.org>
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

[ Upstream commit ec4b5200c8af9ce021399d3192b3379c089396c3 ]

Commit 432928c93779 ("gfs2: Add quota_change type") makes the incorrect
assertion that function do_qc() should behave differently in the two
contexts it is used in, but that isn't actually true.  In all cases,
do_qc() grabs a "reference" when it starts using a slot in the per-node
quota changes file, and it releases that "reference" when no more
residual changes remain.  Revert that broken commit.

There are some remaining issues with function do_qc() which are
addressed in the next commit.

This reverts commit 432928c9377959684c748a9bc6553ed2d3c2ea4f.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/quota.c | 19 +++++++------------
 fs/gfs2/util.c  |  6 +++---
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 892b1c44de53..299b6d6aaa79 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -75,9 +75,6 @@
 #define GFS2_QD_HASH_SIZE       BIT(GFS2_QD_HASH_SHIFT)
 #define GFS2_QD_HASH_MASK       (GFS2_QD_HASH_SIZE - 1)
 
-#define QC_CHANGE 0
-#define QC_SYNC 1
-
 /* Lock order: qd_lock -> bucket lock -> qd->lockref.lock -> lru lock */
 /*                     -> sd_bitmap_lock                              */
 static DEFINE_SPINLOCK(qd_lock);
@@ -697,7 +694,7 @@ static int sort_qd(const void *a, const void *b)
 	return 0;
 }
 
-static void do_qc(struct gfs2_quota_data *qd, s64 change, int qc_type)
+static void do_qc(struct gfs2_quota_data *qd, s64 change)
 {
 	struct gfs2_sbd *sdp = qd->qd_sbd;
 	struct gfs2_inode *ip = GFS2_I(sdp->sd_qc_inode);
@@ -722,18 +719,16 @@ static void do_qc(struct gfs2_quota_data *qd, s64 change, int qc_type)
 	qd->qd_change = x;
 	spin_unlock(&qd_lock);
 
-	if (qc_type == QC_CHANGE) {
-		if (!test_and_set_bit(QDF_CHANGE, &qd->qd_flags)) {
-			qd_hold(qd);
-			slot_hold(qd);
-		}
-	} else {
+	if (!x) {
 		gfs2_assert_warn(sdp, test_bit(QDF_CHANGE, &qd->qd_flags));
 		clear_bit(QDF_CHANGE, &qd->qd_flags);
 		qc->qc_flags = 0;
 		qc->qc_id = 0;
 		slot_put(qd);
 		qd_put(qd);
+	} else if (!test_and_set_bit(QDF_CHANGE, &qd->qd_flags)) {
+		qd_hold(qd);
+		slot_hold(qd);
 	}
 
 	if (change < 0) /* Reset quiet flag if we freed some blocks */
@@ -978,7 +973,7 @@ static int do_sync(unsigned int num_qd, struct gfs2_quota_data **qda)
 		if (error)
 			goto out_end_trans;
 
-		do_qc(qd, -qd->qd_change_sync, QC_SYNC);
+		do_qc(qd, -qd->qd_change_sync);
 		set_bit(QDF_REFRESH, &qd->qd_flags);
 	}
 
@@ -1300,7 +1295,7 @@ void gfs2_quota_change(struct gfs2_inode *ip, s64 change,
 
 		if (qid_eq(qd->qd_id, make_kqid_uid(uid)) ||
 		    qid_eq(qd->qd_id, make_kqid_gid(gid))) {
-			do_qc(qd, change, QC_CHANGE);
+			do_qc(qd, change);
 		}
 	}
 }
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index fc3ecb180ac5..b65261e0cae3 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -99,12 +99,12 @@ int check_journal_clean(struct gfs2_sbd *sdp, struct gfs2_jdesc *jd,
  */
 int gfs2_freeze_lock_shared(struct gfs2_sbd *sdp)
 {
+	int flags = LM_FLAG_NOEXP | GL_EXACT;
 	int error;
 
-	error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_SHARED,
-				   LM_FLAG_NOEXP | GL_EXACT,
+	error = gfs2_glock_nq_init(sdp->sd_freeze_gl, LM_ST_SHARED, flags,
 				   &sdp->sd_freeze_gh);
-	if (error)
+	if (error && error != GLR_TRYFAILED)
 		fs_err(sdp, "can't lock the freeze glock: %d\n", error);
 	return error;
 }
-- 
2.43.0





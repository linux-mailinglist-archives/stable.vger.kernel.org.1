Return-Path: <stable+bounces-49000-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E20A8FEB6F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A247E287A7F
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D947D1AB50A;
	Thu,  6 Jun 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JXt9204k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BD71AB507;
	Thu,  6 Jun 2024 14:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683251; cv=none; b=A5U/3Jb3dCvhkY+5ATse0JhAfMstacIkgLdKzm4a+gQ7XsPeHiRz84rUu8x5UiMpBxCPDaNnar3IRjnlNf4jBO9BH2aHRsaxDWCsZJpKyF5aNjnuhJoRMQWHQQSfJlt1PmyqHhInQbwjo1Rc7IpfjNXUFkhnapRXZGZ7xOmf1sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683251; c=relaxed/simple;
	bh=pbvwfaRQ2QoR/zkBCkjkRIhmk6SWl2pcliKaO6Indlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=po5V/zsTbtR88db/JtDDz7hqW/xmPyutE5XodQTHDEGWWrGAlE4EAWEbCemV5+XBYjHbPEghEGitPrGANV7t4W0ViOdqiIS7Hz1cQKdMrDYlOJzUVhhBy5tHqkBSdVxsXVEetEoQJiDiSqhso29U0P2lslEn6XFChoYDG/5d/u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JXt9204k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EFBC2BD10;
	Thu,  6 Jun 2024 14:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683251;
	bh=pbvwfaRQ2QoR/zkBCkjkRIhmk6SWl2pcliKaO6Indlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXt9204kaVQrPAYIJDvBQ+gPhIubjAMk2Ulo3dKzu32f/2qvcQPTxbeN3FUWz4dN2
	 9IFREc7O8X1QGqggCicrYkm60Mko8ug7EHGY+xuqu7gBGGXyl0tdLc692DTqZCoL9l
	 6brWhCLK7GldAIzdpLW1SFwOlcvfHHV6k7MHVoe0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 195/744] gfs2: do_xmote fixes
Date: Thu,  6 Jun 2024 15:57:47 +0200
Message-ID: <20240606131738.694893961@linuxfoundation.org>
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

[ Upstream commit 9947a06d29c0a30da88cdc6376ca5fd87083e130 ]

Function do_xmote() is called with the glock spinlock held.  Commit
86934198eefa added a 'goto skip_inval' statement at the beginning of the
function to further below where the glock spinlock is expected not to be
held anymore.  Then it added code there that requires the glock spinlock
to be held.  This doesn't make sense; fix this up by dropping and
retaking the spinlock where needed.

In addition, when ->lm_lock() returned an error, do_xmote() didn't fail
the locking operation, and simply left the glock hanging; fix that as
well.  (This is a much older error.)

Fixes: 86934198eefa ("gfs2: Clear flags when withdraw prevents xmote")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glock.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 009a6a6312c2f..685e3ef9e9008 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -696,6 +696,7 @@ __acquires(&gl->gl_lockref.lock)
 {
 	const struct gfs2_glock_operations *glops = gl->gl_ops;
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	unsigned int lck_flags = (unsigned int)(gh ? gh->gh_flags : 0);
 	int ret;
 
@@ -724,6 +725,9 @@ __acquires(&gl->gl_lockref.lock)
 	    (gl->gl_state == LM_ST_EXCLUSIVE) ||
 	    (lck_flags & (LM_FLAG_TRY|LM_FLAG_TRY_1CB)))
 		clear_bit(GLF_BLOCKING, &gl->gl_flags);
+	if (!glops->go_inval && !glops->go_sync)
+		goto skip_inval;
+
 	spin_unlock(&gl->gl_lockref.lock);
 	if (glops->go_sync) {
 		ret = glops->go_sync(gl);
@@ -736,6 +740,7 @@ __acquires(&gl->gl_lockref.lock)
 				fs_err(sdp, "Error %d syncing glock \n", ret);
 				gfs2_dump_glock(NULL, gl, true);
 			}
+			spin_lock(&gl->gl_lockref.lock);
 			goto skip_inval;
 		}
 	}
@@ -756,9 +761,10 @@ __acquires(&gl->gl_lockref.lock)
 		glops->go_inval(gl, target == LM_ST_DEFERRED ? 0 : DIO_METADATA);
 		clear_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags);
 	}
+	spin_lock(&gl->gl_lockref.lock);
 
 skip_inval:
-	gfs2_glock_hold(gl);
+	gl->gl_lockref.count++;
 	/*
 	 * Check for an error encountered since we called go_sync and go_inval.
 	 * If so, we can't withdraw from the glock code because the withdraw
@@ -800,37 +806,37 @@ __acquires(&gl->gl_lockref.lock)
 			 */
 			clear_bit(GLF_LOCK, &gl->gl_flags);
 			clear_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
-			gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
-			goto out;
+			__gfs2_glock_queue_work(gl, GL_GLOCK_DFT_HOLD);
+			return;
 		} else {
 			clear_bit(GLF_INVALIDATE_IN_PROGRESS, &gl->gl_flags);
 		}
 	}
 
-	if (sdp->sd_lockstruct.ls_ops->lm_lock)	{
-		struct lm_lockstruct *ls = &sdp->sd_lockstruct;
+	if (ls->ls_ops->lm_lock) {
+		spin_unlock(&gl->gl_lockref.lock);
+		ret = ls->ls_ops->lm_lock(gl, target, lck_flags);
+		spin_lock(&gl->gl_lockref.lock);
 
-		/* lock_dlm */
-		ret = sdp->sd_lockstruct.ls_ops->lm_lock(gl, target, lck_flags);
 		if (ret == -EINVAL && gl->gl_target == LM_ST_UNLOCKED &&
 		    target == LM_ST_UNLOCKED &&
 		    test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
-			spin_lock(&gl->gl_lockref.lock);
-			finish_xmote(gl, target);
-			__gfs2_glock_queue_work(gl, 0);
-			spin_unlock(&gl->gl_lockref.lock);
+			/*
+			 * The lockspace has been released and the lock has
+			 * been unlocked implicitly.
+			 */
 		} else if (ret) {
 			fs_err(sdp, "lm_lock ret %d\n", ret);
-			GLOCK_BUG_ON(gl, !gfs2_withdrawing_or_withdrawn(sdp));
+			target = gl->gl_state | LM_OUT_ERROR;
+		} else {
+			/* The operation will be completed asynchronously. */
+			return;
 		}
-	} else { /* lock_nolock */
-		spin_lock(&gl->gl_lockref.lock);
-		finish_xmote(gl, target);
-		__gfs2_glock_queue_work(gl, 0);
-		spin_unlock(&gl->gl_lockref.lock);
 	}
-out:
-	spin_lock(&gl->gl_lockref.lock);
+
+	/* Complete the operation now. */
+	finish_xmote(gl, target);
+	__gfs2_glock_queue_work(gl, 0);
 }
 
 /**
-- 
2.43.0





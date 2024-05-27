Return-Path: <stable+bounces-46744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891BE8D0B14
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 21:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DF011F229AD
	for <lists+stable@lfdr.de>; Mon, 27 May 2024 19:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5486F160784;
	Mon, 27 May 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xKDh5wd0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139301754B;
	Mon, 27 May 2024 19:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716836748; cv=none; b=W5/KzNvbCEEX9i4+wFf1X8jRtcBpgGg5JbDDWFp7NtPnhyQ+yFAjZRtPpfxcTlx7vrkLo34MZQZlpJrfLlJEGXL8ZQg9nPnBMH/jZLnbmr+aNPZhfMmwEsxGDqxg8GxyL9bFwoSUpgkpNjRwhkszcgeM7HOwLvPsnQ2QuvpSCKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716836748; c=relaxed/simple;
	bh=32ClpFUauyhA2EtfpjyGZbvECIrenUiyINjgUBaKIzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKec9f92LFT5eINouT/R5PuXFyfAgh7p20sM5hj3j7dBin6LnQ9riIhSBdrPuzYrE3WtdrgNUGGb/OlAb+jO1X+8aHK8HFy+M34T7vHgvYwa+moTp1fuFeFH1eTyfrw9uOximCDSfuIEw71bCnMYZv89bnMymkIFJOm/3yTXJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xKDh5wd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF8FC2BBFC;
	Mon, 27 May 2024 19:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716836748;
	bh=32ClpFUauyhA2EtfpjyGZbvECIrenUiyINjgUBaKIzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xKDh5wd08qICdNTkxRtX9WNWnkc8XSHRI5F+4z6INm0FVMPKhVa9alT537uY0L6eD
	 J6jE8aTCWrL4QnBYleqxC40DMT6+b6G3Dj+QT4MPZ89OHdWRU3ZMF+9xAQjNV44j5T
	 A/+EmwEQqF2JozfmKunR6oLJQ52dgZ401vLt5rbA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.9 171/427] gfs2: do_xmote fixes
Date: Mon, 27 May 2024 20:53:38 +0200
Message-ID: <20240527185618.257164547@linuxfoundation.org>
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
index 0c719fcd4fbc5..2507fe34cbdf0 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -713,6 +713,7 @@ __acquires(&gl->gl_lockref.lock)
 {
 	const struct gfs2_glock_operations *glops = gl->gl_ops;
 	struct gfs2_sbd *sdp = gl->gl_name.ln_sbd;
+	struct lm_lockstruct *ls = &sdp->sd_lockstruct;
 	unsigned int lck_flags = (unsigned int)(gh ? gh->gh_flags : 0);
 	int ret;
 
@@ -741,6 +742,9 @@ __acquires(&gl->gl_lockref.lock)
 	    (gl->gl_state == LM_ST_EXCLUSIVE) ||
 	    (lck_flags & (LM_FLAG_TRY|LM_FLAG_TRY_1CB)))
 		clear_bit(GLF_BLOCKING, &gl->gl_flags);
+	if (!glops->go_inval && !glops->go_sync)
+		goto skip_inval;
+
 	spin_unlock(&gl->gl_lockref.lock);
 	if (glops->go_sync) {
 		ret = glops->go_sync(gl);
@@ -753,6 +757,7 @@ __acquires(&gl->gl_lockref.lock)
 				fs_err(sdp, "Error %d syncing glock \n", ret);
 				gfs2_dump_glock(NULL, gl, true);
 			}
+			spin_lock(&gl->gl_lockref.lock);
 			goto skip_inval;
 		}
 	}
@@ -773,9 +778,10 @@ __acquires(&gl->gl_lockref.lock)
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
@@ -817,37 +823,37 @@ __acquires(&gl->gl_lockref.lock)
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





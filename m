Return-Path: <stable+bounces-48941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2EC8FEB33
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805921F277A6
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BA01A2FDC;
	Thu,  6 Jun 2024 14:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bn4vz8w+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B61A2FD9;
	Thu,  6 Jun 2024 14:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683222; cv=none; b=Jf3oU+fMKI8NiFzCchEoIUIzmrVKWL0h4Uc5r0lwZ1WtBwvI92FDJiMaXmwgVCGwl7Q083LfYcvLI+1bEJ3o5ayxsBW8b/3DS/3Y/1c1naRs4hxvdcZg0DsRHriblvuWL7MRNgbxzrACtHlKQln6baqvwm7Py9VUXaDt4lZVlrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683222; c=relaxed/simple;
	bh=uZL6h0NbAygCONNuH0nA/JSkoeXBMi2H/Y4NsfykjuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAmQEqHp/zzn79/TwokeTXo3999nINXCZTXhJ4Rex02Je+OhRAIkhJsFPoufj493l922eMHP7yAQC4H1OYvtXQuaVMCZeO+p5rvgla2YrL9BH/un+U+1lSlTGObvB89y4epE30adTJf0kS4YjXNuJcHoOkSfbAl2UKYHwH5AtCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bn4vz8w+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD44C32786;
	Thu,  6 Jun 2024 14:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683222;
	bh=uZL6h0NbAygCONNuH0nA/JSkoeXBMi2H/Y4NsfykjuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bn4vz8w+dTz4LNxQ2i7d7qikiVVOdj7d3EIrUfLjweSl7BGzKAD2HThcMTIrCZVwL
	 1ZWf93ltPQ7NFQdGeAugAnpcjN2/+740VIErxnQ7i1X155q3IFbz7MkAhPdzpAwOYe
	 dcaGl79ILDQhL1wgshWOlqgs8OpWXcGTdk1mIXMs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 164/744] gfs2: Fix "ignore unlock failures after withdraw"
Date: Thu,  6 Jun 2024 15:57:16 +0200
Message-ID: <20240606131737.682590043@linuxfoundation.org>
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

[ Upstream commit 5d9231111966b6c5a65016d58dcbeab91055bc91 ]

Commit 3e11e53041502 tries to suppress dlm_lock() lock conversion errors
that occur when the lockspace has already been released.

It does that by setting and checking the SDF_SKIP_DLM_UNLOCK flag.  This
conflicts with the intended meaning of the SDF_SKIP_DLM_UNLOCK flag, so
check whether the lockspace is still allocated instead.

(Given the current DLM API, checking for this kind of error after the
fact seems easier that than to make sure that the lockspace is still
allocated before calling dlm_lock().  Changing the DLM API so that users
maintain the lockspace references themselves would be an option.)

Fixes: 3e11e53041502 ("GFS2: ignore unlock failures after withdraw")
Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glock.c | 4 +++-
 fs/gfs2/util.c  | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 4a280be229a65..207b7c23bc0f3 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -785,11 +785,13 @@ __acquires(&gl->gl_lockref.lock)
 	}
 
 	if (sdp->sd_lockstruct.ls_ops->lm_lock)	{
+		struct lm_lockstruct *ls = &sdp->sd_lockstruct;
+
 		/* lock_dlm */
 		ret = sdp->sd_lockstruct.ls_ops->lm_lock(gl, target, lck_flags);
 		if (ret == -EINVAL && gl->gl_target == LM_ST_UNLOCKED &&
 		    target == LM_ST_UNLOCKED &&
-		    test_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags)) {
+		    test_bit(DFL_UNMOUNT, &ls->ls_recover_flags)) {
 			finish_xmote(gl, target);
 			gfs2_glock_queue_work(gl, 0);
 		} else if (ret) {
diff --git a/fs/gfs2/util.c b/fs/gfs2/util.c
index da29fafb62728..d424691bd3f8a 100644
--- a/fs/gfs2/util.c
+++ b/fs/gfs2/util.c
@@ -350,7 +350,6 @@ int gfs2_withdraw(struct gfs2_sbd *sdp)
 			fs_err(sdp, "telling LM to unmount\n");
 			lm->lm_unmount(sdp);
 		}
-		set_bit(SDF_SKIP_DLM_UNLOCK, &sdp->sd_flags);
 		fs_err(sdp, "File system withdrawn\n");
 		dump_stack();
 		clear_bit(SDF_WITHDRAW_IN_PROG, &sdp->sd_flags);
-- 
2.43.0





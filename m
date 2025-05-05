Return-Path: <stable+bounces-139946-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10927AAA2D2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E665A5C5C
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 23:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC472E3379;
	Mon,  5 May 2025 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4hOF53h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F92281507;
	Mon,  5 May 2025 22:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483748; cv=none; b=oNekbv2DPh2wb80Ig/bYGBgwf/LaYavHtAtABa5uPMIa4D4Y3xgG5M+NpRqgtyCVhhTCzE9Ji+IC6dqaJ4B4PCjcgGvodZ3k3fm4TPbEydIyKGo06GniQm+5h3rzpZLN1y65ryAOU2QSChXvP7cT5THDT993XIi+FjqiniU1N1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483748; c=relaxed/simple;
	bh=vrcgQAoS8feypavuTiO0uVauypa5k1qVzGz8jT7qcG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkjCoOeRfGGRLvJuzmmRshihM/AJKkMsJxRhRz+5hqSxJaHFcVB7W++UtTvLvV6E03+2eJGqx4dKqK0SWxNwGc7UCpUWf/Gg5+g8qhwif1/LOvzUAo2iOQsNrRR4ZKd3q/1EUey9/A3edN7HUpv48vZAVFDtleMAq7zRU/46SPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4hOF53h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19E4C4CEEF;
	Mon,  5 May 2025 22:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483748;
	bh=vrcgQAoS8feypavuTiO0uVauypa5k1qVzGz8jT7qcG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a4hOF53hXg3tjo5fjb+m534vMbXH0ircy1XYrezIyY8boVkXyKOeT72ZvNA4XrwRn
	 TUWF+h1eeWfhFxqhFaZ43wxxYE3bti0ydkbstoTKZJTt2p91voZ/xuQW3QBo6uAt2T
	 JoMdyeObe95POxSX4Brutuqd7U7lQshuEq1+7lvdLYcsiDFj53mNxfUCCEWHtn/mVc
	 NyjICU2D3o8Z/rBZ1rr8c06RuGSmh+2lymF5xXq+vvqIRkqKfJZ0S7Uvt74CcYHkfH
	 /N/C9k0i8PuJJjW2jPjrYDykgT1n2xVXN2wU1lgq+0G40TdYxEbZ0Cp/EY5LZIAR9V
	 NHB6420nF89GQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 199/642] gfs2: Check for empty queue in run_queue
Date: Mon,  5 May 2025 18:06:55 -0400
Message-Id: <20250505221419.2672473-199-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit d838605fea6eabae3746a276fd448f6719eb3926 ]

In run_queue(), check if the queue of pending requests is empty instead
of blindly assuming that it won't be.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/glock.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index 65c07aa957184..7f9cc7872214e 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -843,12 +843,13 @@ static void run_queue(struct gfs2_glock *gl, const int nonblock)
 __releases(&gl->gl_lockref.lock)
 __acquires(&gl->gl_lockref.lock)
 {
-	struct gfs2_holder *gh = NULL;
+	struct gfs2_holder *gh;
 
 	if (test_bit(GLF_LOCK, &gl->gl_flags))
 		return;
 	set_bit(GLF_LOCK, &gl->gl_flags);
 
+	/* While a demote is in progress, the GLF_LOCK flag must be set. */
 	GLOCK_BUG_ON(gl, test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags));
 
 	if (test_bit(GLF_DEMOTE, &gl->gl_flags) &&
@@ -860,18 +861,22 @@ __acquires(&gl->gl_lockref.lock)
 		set_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
 		GLOCK_BUG_ON(gl, gl->gl_demote_state == LM_ST_EXCLUSIVE);
 		gl->gl_target = gl->gl_demote_state;
+		do_xmote(gl, NULL, gl->gl_target);
+		return;
 	} else {
 		if (test_bit(GLF_DEMOTE, &gl->gl_flags))
 			gfs2_demote_wake(gl);
 		if (do_promote(gl))
 			goto out_unlock;
 		gh = find_first_waiter(gl);
+		if (!gh)
+			goto out_unlock;
 		gl->gl_target = gh->gh_state;
 		if (!(gh->gh_flags & (LM_FLAG_TRY | LM_FLAG_TRY_1CB)))
 			do_error(gl, 0); /* Fail queued try locks */
+		do_xmote(gl, gh, gl->gl_target);
+		return;
 	}
-	do_xmote(gl, gh, gl->gl_target);
-	return;
 
 out_sched:
 	clear_bit(GLF_LOCK, &gl->gl_flags);
-- 
2.39.5



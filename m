Return-Path: <stable+bounces-141108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4391AAB0C9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 534797BDD66
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF9131A9EC;
	Tue,  6 May 2025 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SYiszbRU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE535B948;
	Mon,  5 May 2025 22:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485095; cv=none; b=o7xskNqJPmjahHh6AVa075niuQI5H6wU21EC+8MJbuemsfmBCfECLlgPO/sDQznJw+RkCgh0PvNsg9MoZv4JLcbykTkKYpZiI0615vTyV2BuzsMnsD1cPM1AcnF2sSEvZdbIZ3U+RSq8t2K4F4sEK1iA7Om2S6c8JLjfEw3LTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485095; c=relaxed/simple;
	bh=qTiixerpP4JVYjqht41+eGrpWIMH1nTcxBB/tX6CKfA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UrogC467hX1+eKSF3ICDXms3PfLilafyIe2gaXF71MBaLuXOTD9VFrAE4KSJjUmR8nJok/houPdZHombeYf1B22E24o4MC6PBNcAqPm7ox/2n9WUmhB9QPBTB0bc9Faz2PiQ3MaR12jwYdNSUGyf1752EuixDlQuOy1NiAFUak4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SYiszbRU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFE7C4CEE4;
	Mon,  5 May 2025 22:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485095;
	bh=qTiixerpP4JVYjqht41+eGrpWIMH1nTcxBB/tX6CKfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SYiszbRUhN4ArhXLlUK495sA80kAxgeMhBvhd9O+B06vfsVyrRKqZ5E85r/KLx+fU
	 RSkWPERFjhu8YowD+lKEVt35iGzqETauV/eCUyLPGG3ZMZCzp6EYklPzDcFVXKp5sO
	 UIHOFaF/Ur5BDX66jYrFEz0w2LpLR0JyOL0vY4p1HLcYr3TYxEj/zIzfzH/XRHf7KV
	 kHJoPEyEpGReGxABviOI1A5f1YKUeTzwNRvsHp8xygMGyCCRZjui06HTvi9z24HcNM
	 obAb7TXf1mIw/r10gySXZ0nMCktkeNSY6nv0Yfqx6HHqDFuqKOzHaqyqgJJxoCOzE4
	 aXNzWAxTIooKA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.12 160/486] gfs2: Check for empty queue in run_queue
Date: Mon,  5 May 2025 18:33:56 -0400
Message-Id: <20250505223922.2682012-160-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index a51fe42732c4c..4f1eca99786b6 100644
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



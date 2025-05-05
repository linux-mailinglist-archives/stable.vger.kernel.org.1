Return-Path: <stable+bounces-141384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8602AAB30D
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238A91C03235
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DB14539F0;
	Tue,  6 May 2025 00:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3/daiIJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B75437C748;
	Mon,  5 May 2025 22:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485981; cv=none; b=br+yMdvdDj012joInAXotR0T9bE+De69Ic//asg88wL6dIHYSmFAvO4cdwaFatzLW1nkvA6tAQ/RcUNJQZXn/LDLJt71SRaSHESX9BFi2wUCr0spnOAqDexBWuBkoC/El/KbUx1UUkTFEEsxttZEAXH+ZzMZYAE+dHHElx99VBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485981; c=relaxed/simple;
	bh=o3QD/J3tU7Q74uHqCAl5L86/kt1bBA5NIb4E8urow+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tKOpuvjyMGAnPzchUd7LO29gKPd57/7vwu1vnUcB4b90XLmDyRtrkXDV6pBITi3DNaNAgYOWBIuHRxnyCVTz3amJp/QACZSqxrx+M6EH2oLxSS8K1YadXOPTDQVYPOOEhyqJjTiCLl5lsCFoGWAsXWuJE15r4YXNvnWY554eVR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3/daiIJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C85C4CEE4;
	Mon,  5 May 2025 22:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485980;
	bh=o3QD/J3tU7Q74uHqCAl5L86/kt1bBA5NIb4E8urow+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l3/daiIJ5Fz+KBmlFivOqLRTva5RBTQnKxFqFEDpszsVLJZfCrF9T5/XkYrrD45h1
	 8tqpvZS1Rgch2Um2fYAH0E4YNI9IXdLEmF3VXpDQwE+n5Og3Y4tCfWjccB0sFnXGhO
	 jT/ANCst1r+WUZfKbAaYIkBI9wefOegNQVqVeRUt2qcT9sG3cfxytZf34yVieSUgSa
	 4eK3RrksCRUdh++8E0NSEJUr2mqOy5ouNZLvwqRSu+dnajv5YoEjNPKdENdG9hAEcD
	 JhnM2P1vmUq5JmMhi5GDpIotOJqwUjY1J4LCjbNYpOndJ3kDramC7vtaVgyOVdkoVv
	 Xw/JaOlFMvDIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 096/294] gfs2: Check for empty queue in run_queue
Date: Mon,  5 May 2025 18:53:16 -0400
Message-Id: <20250505225634.2688578-96-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 2c0908a302102..687670075d225 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -853,11 +853,12 @@ static void run_queue(struct gfs2_glock *gl, const int nonblock)
 __releases(&gl->gl_lockref.lock)
 __acquires(&gl->gl_lockref.lock)
 {
-	struct gfs2_holder *gh = NULL;
+	struct gfs2_holder *gh;
 
 	if (test_and_set_bit(GLF_LOCK, &gl->gl_flags))
 		return;
 
+	/* While a demote is in progress, the GLF_LOCK flag must be set. */
 	GLOCK_BUG_ON(gl, test_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags));
 
 	if (test_bit(GLF_DEMOTE, &gl->gl_flags) &&
@@ -869,18 +870,22 @@ __acquires(&gl->gl_lockref.lock)
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



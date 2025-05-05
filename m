Return-Path: <stable+bounces-140837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA419AAABEA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8851A8780B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E692A3B89F5;
	Mon,  5 May 2025 23:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IqFL5das"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14982ED094;
	Mon,  5 May 2025 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486522; cv=none; b=Q86PzJyLX51qaHsdlLLcOxe4rL8C8StaAzBmTOgsW07IMpZGLvrtS/ZauEzcQYjF/n47+vky25KA7YCEsYgDK2x2MLpG3urKRr9q0FeGj0myhoDA9zJ5Hp7IM0RYdWDckGp+dJ96JoIxyzAGmN41ffWzcgLxvpkNHu0FvW/GT20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486522; c=relaxed/simple;
	bh=Qc8kUZMXipZTXxf3pFyZhAv0logpsqy6IX7EpbaAqNM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oNGo3Qqq5Ft5NZckv8ValKWwAZIK26KmOZTbArsz53lzPZvVXKI5PK33lFnZgZ/nD8RludB0j7O5UwibFGGhzaLQp2AtoAAvNvBv/swVq0nAb6psMhCcYvRAwESX3gi/+ZEz8njvSz4TdGFTAtmc+YJgeItmjHIFoCw6DhWMErc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IqFL5das; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB30C4CEEF;
	Mon,  5 May 2025 23:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486521;
	bh=Qc8kUZMXipZTXxf3pFyZhAv0logpsqy6IX7EpbaAqNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IqFL5dasOb7UH8fvITR+0e58eiwP1CR+gXvMczXy6xOpj6e6Xnq5H8Zw3iWgsEzoj
	 vpwRZuJMQwVZ34sSyUj0Tx7aHbsD3nUCm5fI+8+sBgBN871K3Q9wOnW9yIF7cCkUtu
	 ck7JRmi368NzKeL/NkXHV9TzK4nx7nIsiKT4yLBg9koqVAVAk7x5iny2Dinr7tMMDO
	 RjdBQM8fWpqPSjN+wYG8IDT3acemc+kvtOtsaC4AIISyyvsT/tHkN53N6/wNqK/5wj
	 ZiCuWabGDnhTClm4N0EC714YV+VyFDO5VDDaPZz/98ArKIpLZ7jxa/+nj1Y3BjkjN7
	 PW/H5BTPqvCTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 074/212] gfs2: Check for empty queue in run_queue
Date: Mon,  5 May 2025 19:04:06 -0400
Message-Id: <20250505230624.2692522-74-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 6ba8460f53318..428c1db295fa1 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -885,11 +885,12 @@ static void run_queue(struct gfs2_glock *gl, const int nonblock)
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
@@ -901,18 +902,22 @@ __acquires(&gl->gl_lockref.lock)
 		set_bit(GLF_DEMOTE_IN_PROGRESS, &gl->gl_flags);
 		GLOCK_BUG_ON(gl, gl->gl_demote_state == LM_ST_EXCLUSIVE);
 		gl->gl_target = gl->gl_demote_state;
+		do_xmote(gl, NULL, gl->gl_target);
+		return;
 	} else {
 		if (test_bit(GLF_DEMOTE, &gl->gl_flags))
 			gfs2_demote_wake(gl);
 		if (do_promote(gl) == 0)
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



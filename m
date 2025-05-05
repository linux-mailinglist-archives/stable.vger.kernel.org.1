Return-Path: <stable+bounces-140515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8E0AAA96F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD2817B880
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D203235ABCE;
	Mon,  5 May 2025 22:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfh4KrAb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6F629A3CF;
	Mon,  5 May 2025 22:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485026; cv=none; b=rVV9QWYwq1i+Mh4f+rWRW/FF4aeIo1r36HdUp4GTYCXYu40tePXgMIhxTOSfn/1aX5EwUEsM/rcBvPPvdyHTh5mVSgX+rbYmsUZSgrRTjbYTC0uoVCqAYKMuUOEIxg1nzTo+Yq/GghfyzoLhh8BdZQjSZ6kxOABPqYNF6U48J00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485026; c=relaxed/simple;
	bh=9yY8EsVHZzA7vgJG97Cqf+iaAANblz1FFdDbdEtZyXc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pAydHr2wUuUO07TfQWxIXizLI9hEFnBcruefynPTM8HiRXE0mnZOg2SG+ilmTiStc0DfAnBgPQV3MhGSKxY7buJypeHOKL7J1F3Xy91hVTohGN/ehpHgI6zoYwJ7NxHo3kLt/0wkKwX69R5VxwkfeSA6qOXMCeQNcmVzAXeQ5bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfh4KrAb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15B7C4CEEF;
	Mon,  5 May 2025 22:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485025;
	bh=9yY8EsVHZzA7vgJG97Cqf+iaAANblz1FFdDbdEtZyXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bfh4KrAb5oR4qbwD2elhAEtZIXWE7oFQ7Jkui05DkZkLDDsFGyaf0wXhBErIJ8W/E
	 Jqe51ocfXbfEBIkPNv0SdrRzpc/cVMtl90Y4V6JPX/y1oatn/lz9hdtxYtTnEb2cHx
	 fKNnlZYeH6FKOBGURiZYe2lbj34xiExQ19sh48KffOvdNBy9eoRQ0RLQhv6Ukgr877
	 WEW9fn8odswJJCBQPQiUZME4fgUu7ZtFWYt3TJ3y3xw6CQTvgXscQyknpWa0Izk7B+
	 cEpWAa2Wbl7d0ICMtL7W/MK5VAkp4dE5Ub2ctOwuaBlWzUwoJPHFg5geMXfRPj8MHY
	 AVnudsDmvtuvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	anna-maria@linutronix.de
Subject: [PATCH AUTOSEL 6.12 130/486] posix-timers: Ensure that timer initialization is fully visible
Date: Mon,  5 May 2025 18:33:26 -0400
Message-Id: <20250505223922.2682012-130-sashal@kernel.org>
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

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 2389c6efd3ad8edb3bcce0019b4edcc7d9c7de19 ]

Frederic pointed out that the memory operations to initialize the timer are
not guaranteed to be visible, when __lock_timer() observes timer::it_signal
valid under timer::it_lock:

  T0                                      T1
  ---------                               -----------
  do_timer_create()
      // A
      new_timer->.... = ....
      spin_lock(current->sighand)
      // B
      WRITE_ONCE(new_timer->it_signal, current->signal)
      spin_unlock(current->sighand)
					sys_timer_*()
					   t =  __lock_timer()
						  spin_lock(&timr->it_lock)
						  // observes B
						  if (timr->it_signal == current->signal)
						    return timr;
			                   if (!t)
					       return;
					// Is not guaranteed to observe A

Protect the write of timer::it_signal, which makes the timer valid, with
timer::it_lock as well. This guarantees that T1 must observe the
initialization A completely, when it observes the valid signal pointer
under timer::it_lock. sighand::siglock must still be taken to protect the
signal::posix_timers list.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
Suggested-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/all/20250308155623.507944489@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/time/posix-timers.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 896ff735034ce..c5d9bfbb082b8 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -514,14 +514,21 @@ static int do_timer_create(clockid_t which_clock, struct sigevent *event,
 	if (error)
 		goto out;
 
-	spin_lock_irq(&current->sighand->siglock);
-	/* This makes the timer valid in the hash table */
-	WRITE_ONCE(new_timer->it_signal, current->signal);
-	hlist_add_head(&new_timer->list, &current->signal->posix_timers);
-	spin_unlock_irq(&current->sighand->siglock);
 	/*
-	 * After unlocking sighand::siglock @new_timer is subject to
-	 * concurrent removal and cannot be touched anymore
+	 * timer::it_lock ensures that __lock_timer() observes a fully
+	 * initialized timer when it observes a valid timer::it_signal.
+	 *
+	 * sighand::siglock is required to protect signal::posix_timers.
+	 */
+	scoped_guard (spinlock_irq, &new_timer->it_lock) {
+		guard(spinlock)(&current->sighand->siglock);
+		/* This makes the timer valid in the hash table */
+		WRITE_ONCE(new_timer->it_signal, current->signal);
+		hlist_add_head(&new_timer->list, &current->signal->posix_timers);
+	}
+	/*
+	 * After unlocking @new_timer is subject to concurrent removal and
+	 * cannot be touched anymore
 	 */
 	return 0;
 out:
-- 
2.39.5



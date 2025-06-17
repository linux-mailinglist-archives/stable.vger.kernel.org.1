Return-Path: <stable+bounces-152886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E275EADD09B
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 16:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7E519420E4
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 14:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF0B20AF62;
	Tue, 17 Jun 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XLPSz5uf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D8202C44
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750171667; cv=none; b=OvEcZIR0xkf0Dv2uDuevtbGvZJSadoB6EcnblUOnrM6xcJC+QFQ06Cw0Zm9M461Dkhdi0i9qGrdl2NHk1qDHrAleDbqb745s+1jW7zAn8vMlcFTtdvN7N1FzdVcVW5dEX/p1ksdCupHyz3ZlVkA2C56x2o8mBuiCRrYZJdvA32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750171667; c=relaxed/simple;
	bh=OqlrAe7kpRdGM7wGJ+6dcTFlrN47sWpcIdSGsoGV0Ig=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kf0bwi2bgnkN9PNOdQ+yen71gtRaeQwmqHTJJllyd8rc/esz8gVGkmxkRd+x64/3IyaikF39lgoJ1onDUPv1GU+OAAH/LkBFdZ4cF3e69OgANv0eJSdKfQ0//A7J+UA9gPrQ4NpN6OAO7ialMahDAN362CrKn/scrl/cawY6qGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XLPSz5uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9954EC4CEE3;
	Tue, 17 Jun 2025 14:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750171667;
	bh=OqlrAe7kpRdGM7wGJ+6dcTFlrN47sWpcIdSGsoGV0Ig=;
	h=Subject:To:Cc:From:Date:From;
	b=XLPSz5ufIKdx9C6uZPTwU2UIoUDXI4EnLlDOWrU3Is2R/HkVTwlxKvbB7e8EYagD4
	 6obT1G55Zmdh2lK/GFVAVWFDTFgoBMT48hWhSW1U1Rnk9+4O8ZUH3YFb53NrSP/qzA
	 GPcUmnpyxYTkclWhpZo33DYhKIGC7U+zoSWfFTOY=
Subject: FAILED: patch "[PATCH] posix-cpu-timers: fix race between handle_posix_cpu_timers()" failed to apply to 5.4-stable tree
To: oleg@redhat.com,bsevens@google.com,torvalds@linux-foundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Jun 2025 16:47:44 +0200
Message-ID: <2025061744-precinct-rubble-45c9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f90fff1e152dedf52b932240ebbd670d83330eca
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025061744-precinct-rubble-45c9@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f90fff1e152dedf52b932240ebbd670d83330eca Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Fri, 13 Jun 2025 19:26:50 +0200
Subject: [PATCH] posix-cpu-timers: fix race between handle_posix_cpu_timers()
 and posix_cpu_timer_del()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If an exiting non-autoreaping task has already passed exit_notify() and
calls handle_posix_cpu_timers() from IRQ, it can be reaped by its parent
or debugger right after unlock_task_sighand().

If a concurrent posix_cpu_timer_del() runs at that moment, it won't be
able to detect timer->it.cpu.firing != 0: cpu_timer_task_rcu() and/or
lock_task_sighand() will fail.

Add the tsk->exit_state check into run_posix_cpu_timers() to fix this.

This fix is not needed if CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y, because
exit_task_work() is called before exit_notify(). But the check still
makes sense, task_work_add(&tsk->posix_cputimers_work.work) will fail
anyway in this case.

Cc: stable@vger.kernel.org
Reported-by: Benoît Sevens <bsevens@google.com>
Fixes: 0bdd2ed4138e ("sched: run_posix_cpu_timers: Don't check ->exit_state, use lock_task_sighand()")
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 50e8d04ab661..2e5b89d7d866 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1405,6 +1405,15 @@ void run_posix_cpu_timers(void)
 
 	lockdep_assert_irqs_disabled();
 
+	/*
+	 * Ensure that release_task(tsk) can't happen while
+	 * handle_posix_cpu_timers() is running. Otherwise, a concurrent
+	 * posix_cpu_timer_del() may fail to lock_task_sighand(tsk) and
+	 * miss timer->it.cpu.firing != 0.
+	 */
+	if (tsk->exit_state)
+		return;
+
 	/*
 	 * If the actual expiry is deferred to task work context and the
 	 * work is already scheduled there is no point to do anything here.



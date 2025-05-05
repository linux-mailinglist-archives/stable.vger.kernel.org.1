Return-Path: <stable+bounces-141433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2777AAB369
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7761C051C7
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FEF239591;
	Tue,  6 May 2025 00:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq73F4sc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AF8288534;
	Mon,  5 May 2025 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486309; cv=none; b=XwoomoaKMmMMv+H+prZev50X0tJoAX3zS1yH991yq1xNuuDyUifRtR/9ILfcDINpaNE8MvDAldijdPCa2FZob47etpcxD0twWEVIiPfIH8wQSCrRZStCIJUNqWrqP23kP2iTAqnFcGIWV3Nmo2lk1jnMTFo0g10lNpxhRN9rwi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486309; c=relaxed/simple;
	bh=6BmnCNBbfLfoySlSwNtn0q29baarrlkHdad1Zgjlyyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZcKVMmfJqwimsfJCe3aJqD3qobLcnlnarW4Q1ecruiWcplLZiQxmtqO07ccGdasPxIiawy0qNYy3tS5ZSs4/nQKJmrb2dDXKHU1vPXL64CZsD2UjaoozDtmPZsssVd5oVHVVcptM8mUMhI1W2YFfQ9q9xyMTQdgVrqLQ/kjoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq73F4sc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA27C4CEE4;
	Mon,  5 May 2025 23:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486308;
	bh=6BmnCNBbfLfoySlSwNtn0q29baarrlkHdad1Zgjlyyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fq73F4scMLjJceCWTdvqOaDhjvkoWvln7M2rrSXb5mzfawZXqrnZUjd2LVaJcgSfV
	 SPh6HTMO96mfKqdGI8pP4IIeQqpHIWCmcNU9H0XUsu1AmDJYN4kSkeVtnMJIUVnwll
	 JW5L/X69lE36joYCJId5KmLGf8fWTJLHD3Uc59et28QCo3qv09LbzhdSzJBI+eYCkj
	 WNsl+rHwCgbYizTq1wlpEx/Xf71TyMxuLjLmK9MB8QjAH3G1hZRtf9KalKfG5c1cT9
	 E1UGPhx/e6GVFWNJ0AZVCoiJRwsRxa1uHQc3nZg32m9Fzcvc4rnDNaXUOnZ+2RCHjD
	 co5KP1QX+9zmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	Liam.Howlett@Oracle.com,
	mjguzik@gmail.com,
	alexjlzheng@tencent.com,
	pasha.tatashin@soleen.com
Subject: [PATCH AUTOSEL 6.6 251/294] exit: change the release_task() paths to call flush_sigqueue() lockless
Date: Mon,  5 May 2025 18:55:51 -0400
Message-Id: <20250505225634.2688578-251-sashal@kernel.org>
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

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit fb3bbcfe344e64a46574a638b051ffd78762c12d ]

A task can block a signal, accumulate up to RLIMIT_SIGPENDING sigqueues,
and exit. In this case __exit_signal()->flush_sigqueue() called with irqs
disabled can trigger a hard lockup, see
https://lore.kernel.org/all/20190322114917.GC28876@redhat.com/

Fortunately, after the recent posixtimer changes sys_timer_delete() paths
no longer try to clear SIGQUEUE_PREALLOC and/or free tmr->sigq, and after
the exiting task passes __exit_signal() lock_task_sighand() can't succeed
and pid_task(tmr->it_pid) will return NULL.

This means that after __exit_signal(tsk) nobody can play with tsk->pending
or (if group_dead) with tsk->signal->shared_pending, so release_task() can
safely call flush_sigqueue() after write_unlock_irq(&tasklist_lock).

TODO:
	- we can probably shift posix_cpu_timers_exit() as well
	- do_sigaction() can hit the similar problem

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250206152314.GA14620@redhat.com
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/exit.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index 1b7257c12cb10..6c75c823de25c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -199,20 +199,13 @@ static void __exit_signal(struct task_struct *tsk)
 	__unhash_process(tsk, group_dead);
 	write_sequnlock(&sig->stats_lock);
 
-	/*
-	 * Do this under ->siglock, we can race with another thread
-	 * doing sigqueue_free() if we have SIGQUEUE_PREALLOC signals.
-	 */
-	flush_sigqueue(&tsk->pending);
 	tsk->sighand = NULL;
 	spin_unlock(&sighand->siglock);
 
 	__cleanup_sighand(sighand);
 	clear_tsk_thread_flag(tsk, TIF_SIGPENDING);
-	if (group_dead) {
-		flush_sigqueue(&sig->shared_pending);
+	if (group_dead)
 		tty_kref_put(tty);
-	}
 }
 
 static void delayed_put_task_struct(struct rcu_head *rhp)
@@ -282,6 +275,16 @@ void release_task(struct task_struct *p)
 	proc_flush_pid(thread_pid);
 	put_pid(thread_pid);
 	release_thread(p);
+	/*
+	 * This task was already removed from the process/thread/pid lists
+	 * and lock_task_sighand(p) can't succeed. Nobody else can touch
+	 * ->pending or, if group dead, signal->shared_pending. We can call
+	 * flush_sigqueue() lockless.
+	 */
+	flush_sigqueue(&p->pending);
+	if (thread_group_leader(p))
+		flush_sigqueue(&p->signal->shared_pending);
+
 	put_task_struct_rcu_user(p);
 
 	p = leader;
-- 
2.39.5



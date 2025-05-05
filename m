Return-Path: <stable+bounces-141036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A01AAAD75
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D7D34A083C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303033B6B97;
	Mon,  5 May 2025 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3KD1E9w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540403B63F4;
	Mon,  5 May 2025 23:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487285; cv=none; b=K0xTIsHQap9jQ+lCkPCERTWj76UyPuVpPmHt5DJd2ZLdE8cBnF9EZjhbGs9rrPzcqvqPuONWug4jTDmiiz6DZQvsay50SykDfPgeQVGZEhXoi64GSyzfPkY+QzfgkeIaAPptvYvUR8ri1uvRwAaqWTXZmXTxSFtDor63yFUvdhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487285; c=relaxed/simple;
	bh=B2r14mnB16WfIei0uxyEGEkNfzuObM3K9X5c2LPbKvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G2lEo3AHQ8wb/N2eIobI88Q3ZCIW6L2JK8OWcnvdIgInncMbjUM/P4gTFQA+DmMblQUDmC6FpVu4ZRkt7pqg+f/L514U5lkoBYpqV4BLV0fFnER5eoRwZlTVdivFWgkH0fJa1ZG5rSmgap6LS3L+aPkdIFElPN2EboW3tch7ZuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3KD1E9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB76EC4CEF3;
	Mon,  5 May 2025 23:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487284;
	bh=B2r14mnB16WfIei0uxyEGEkNfzuObM3K9X5c2LPbKvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I3KD1E9w1a+73RcclXhX8WldabMAQ0OYfyKnCWvj05biuFP8kTrXObPdKaOZydMXn
	 oE5yavn8PZZLb1aIiR4pKn4f0f007Hxwy5gM0czAMjbHYXUJJn3JJLDhjgxyPp4Oa/
	 vEGbwM01HIohSC9xbjCptKkbXXAt3Xq1AYMW7q82CoHJJATL9KD2P/6QDPM8d/K/IU
	 l92tKr6LkcdZYkuJ+dUDtsOuu03R9bpEwxh/bZ69P7CVlxgwmI/E7zBctqf4MQfSmV
	 6gLAL3oL+wQ8SDQpz/vjEXrba3NUqZzcDlnRc2kxTp6vYMFE3U/lQ5eKzc2/1n0e48
	 VIRwCyNxVz1jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	mhocko@suse.com,
	mjguzik@gmail.com,
	pasha.tatashin@soleen.com,
	alexjlzheng@tencent.com
Subject: [PATCH AUTOSEL 5.10 098/114] exit: change the release_task() paths to call flush_sigqueue() lockless
Date: Mon,  5 May 2025 19:18:01 -0400
Message-Id: <20250505231817.2697367-98-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index 05f682cfdd6a7..7eb1e9a1d601f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -195,20 +195,13 @@ static void __exit_signal(struct task_struct *tsk)
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
@@ -272,6 +265,16 @@ void release_task(struct task_struct *p)
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



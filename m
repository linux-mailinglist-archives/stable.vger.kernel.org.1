Return-Path: <stable+bounces-141088-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF3AAB09F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE3A3B1C49
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AEC30FCF3;
	Mon,  5 May 2025 23:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7xk4BDT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FB03C01BE;
	Mon,  5 May 2025 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487430; cv=none; b=PqnKlOHfHhLkrA6PtPxqUUUI9x0eKzFqZPT7lLRjHOn2icgHCQ5k9wGNmjvr1YAE1p3R0FObpJR04nN8GbFb3XNxqhJYfSL6aZ/u1oTKjpWzTrUCJXVzMsCAtoA5m526HEo32RoUYuMcecZ58uUlRSXkMczBMTZL6jwErORkKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487430; c=relaxed/simple;
	bh=UYGpjOHgcNF79y7W9l1Itqi9E6pd4CUoXHkU2SU5pQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A4NfOeu31WwzRx6jhgQDVanymjsLOw0WPYfP8NtcNDHMfT/e64ExAJhiel1OkESgHc4R7une4xLmybd7O3Q3imHHgbYWKWqkPCQM/FpByrlub2GFiR+YxGXRTP32exc9bdT3ldJpgprInb53I/o4WLI9krhtQtpot5bC818Ye9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7xk4BDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B99C4CEED;
	Mon,  5 May 2025 23:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487428;
	bh=UYGpjOHgcNF79y7W9l1Itqi9E6pd4CUoXHkU2SU5pQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N7xk4BDTnk5Lk5IIIOeY6bfVn/2JBswxTlgKbKWJuQ611kMbXTAQaA/gApeczhonF
	 ammakxCg9LZZqBeO/KSAY3SXIvgFYMoqYJvY/AzgNjpjtz+TP0Ti2U/tC4l8xjpJH1
	 N7sHEuQWmZ+M9uZDDrY3/N94++qpplskF6Nr1XY+ht/7QO54zHi8J3TE2qqkzZYgUX
	 HRra5chTpVyslSZebSlNexQP/3ii3qmzJ+NL30bTfx4DKs3yXkY05ppj42KcA5d1i6
	 aTLxK58qyjQ8U/AZd236HovkRkRwbQ/DNSewuQ+Jdm74e2ejWuTff8WcCbYCDAP+BE
	 /qvcP6czszB4A==
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
	pasha.tatashin@soleen.com,
	alexjlzheng@tencent.com
Subject: [PATCH AUTOSEL 5.4 66/79] exit: change the release_task() paths to call flush_sigqueue() lockless
Date: Mon,  5 May 2025 19:21:38 -0400
Message-Id: <20250505232151.2698893-66-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
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
index 5015ecdda6d95..69deb2901ec55 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -204,20 +204,13 @@ static void __exit_signal(struct task_struct *tsk)
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
@@ -277,6 +270,16 @@ void release_task(struct task_struct *p)
 
 	write_unlock_irq(&tasklist_lock);
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



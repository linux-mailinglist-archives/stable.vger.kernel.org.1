Return-Path: <stable+bounces-62377-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8720093EEF8
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 09:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4F8A1C20927
	for <lists+stable@lfdr.de>; Mon, 29 Jul 2024 07:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C4212C522;
	Mon, 29 Jul 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ij4uBPVx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897DF12A177
	for <stable@vger.kernel.org>; Mon, 29 Jul 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722239384; cv=none; b=l6QWDSlPumuj2+UU82Pp9hHD4RJVYQfWOCUS4jQjyuaKBLS+RNaQvcutGH6NDUwXqx5tyf6RbKhwvSftKtIznKVm42d2f23qtwRaTjrJIoaU8ZwF1cIVyNT+lKBcClguNpLOGMTD4FCUw1biZ4CjtFjJK0QZPJhaqeIK5Byz1Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722239384; c=relaxed/simple;
	bh=ume9GRpGSssU6gwuY77P1WIyK/tx85j2XCgNhoQb/Ug=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mg0sTHz7pY6k66xi1bMnHjHKxC2tyw2oUGgWgFjZyPIkPBMogS9RflA0vJVbL1EddlFx+5VUP/eLh5x0MD0/8YG2jTMyT04GrEsyHwlQ5MHkqDTSbRXSpXYtEmv3A4KEUv3D0qFLkg+JKTRQHcZTug5lcAwR+aclgC363Y+jDm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ij4uBPVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E27C32786;
	Mon, 29 Jul 2024 07:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722239384;
	bh=ume9GRpGSssU6gwuY77P1WIyK/tx85j2XCgNhoQb/Ug=;
	h=Subject:To:Cc:From:Date:From;
	b=ij4uBPVxuHPvtNvJAjWY7eartWjg28vDnKcKD/jFuH0ETfQ+096jIWQbyjkrRpki3
	 te6A8F7hoDhqKl3hnqitg0gJhFg8hiGTvt35ESZ70soQpP+7/ZYURmM3nkBZ3nKB1u
	 eisyWx7wxOzxy0IsBTznPzCV2TA7WtNgzgpfc8qg=
Subject: FAILED: patch "[PATCH] kernel: rerun task_work while freezing in get_signal()" failed to apply to 5.15-stable tree
To: asml.silence@gmail.com,axboe@kernel.dk,ju.orth@gmail.com,oleg@redhat.com,tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 29 Jul 2024 09:49:40 +0200
Message-ID: <2024072940-parish-shirt-3e49@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 943ad0b62e3c21f324c4884caa6cb4a871bca05c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072940-parish-shirt-3e49@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

943ad0b62e3c ("kernel: rerun task_work while freezing in get_signal()")
f5d39b020809 ("freezer,sched: Rewrite core freezer logic")
9963e444f71e ("sched: Widen TAKS_state literals")
f9fc8cad9728 ("sched: Add TASK_ANY for wait_task_inactive()")
9204a97f7ae8 ("sched: Change wait_task_inactive()s match_state")
1fbcaa923ce2 ("freezer,umh: Clean up freezer/initrd interaction")
5950e5d574c6 ("freezer: Have {,un}lock_system_sleep() save/restore flags")
0b9d46fc5ef7 ("sched: Rename task_running() to task_on_cpu()")
8386c414e27c ("PM: hibernate: defer device probing when resuming from hibernation")
57b6de08b5f6 ("ptrace: Admit ptrace_stop can generate spuriuos SIGTRAPs")
7b0fe1367ef2 ("ptrace: Document that wait_task_inactive can't fail")
1930a6e739c4 ("Merge tag 'ptrace-cleanups-for-v5.18' of git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 943ad0b62e3c21f324c4884caa6cb4a871bca05c Mon Sep 17 00:00:00 2001
From: Pavel Begunkov <asml.silence@gmail.com>
Date: Wed, 10 Jul 2024 18:58:18 +0100
Subject: [PATCH] kernel: rerun task_work while freezing in get_signal()

io_uring can asynchronously add a task_work while the task is getting
freezed. TIF_NOTIFY_SIGNAL will prevent the task from sleeping in
do_freezer_trap(), and since the get_signal()'s relock loop doesn't
retry task_work, the task will spin there not being able to sleep
until the freezing is cancelled / the task is killed / etc.

Run task_works in the freezer path. Keep the patch small and simple
so it can be easily back ported, but we might need to do some cleaning
after and look if there are other places with similar problems.

Cc: stable@vger.kernel.org
Link: https://github.com/systemd/systemd/issues/33626
Fixes: 12db8b690010c ("entry: Add support for TIF_NOTIFY_SIGNAL")
Reported-by: Julian Orth <ju.orth@gmail.com>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://lore.kernel.org/r/89ed3a52933370deaaf61a0a620a6ac91f1e754d.1720634146.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/kernel/signal.c b/kernel/signal.c
index 1f9dd41c04be..60c737e423a1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2600,6 +2600,14 @@ static void do_freezer_trap(void)
 	spin_unlock_irq(&current->sighand->siglock);
 	cgroup_enter_frozen();
 	schedule();
+
+	/*
+	 * We could've been woken by task_work, run it to clear
+	 * TIF_NOTIFY_SIGNAL. The caller will retry if necessary.
+	 */
+	clear_notify_signal();
+	if (unlikely(task_work_pending(current)))
+		task_work_run();
 }
 
 static int ptrace_signal(int signr, kernel_siginfo_t *info, enum pid_type type)



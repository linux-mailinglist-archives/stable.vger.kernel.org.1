Return-Path: <stable+bounces-99007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D464C9E6DAA
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 13:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8726D283826
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BD9E1FF61F;
	Fri,  6 Dec 2024 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xv6QInuD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF41FF604
	for <stable@vger.kernel.org>; Fri,  6 Dec 2024 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733486580; cv=none; b=T1fNiMVtFXTFhvHau1l5KLgMpNfoK8+4AQoukSxSzvtdfPSpc3xYzcAMXVwyFy11YEem3fxrKXyay/JxVWiXNFxHHn9B1T/O9g5COwe3sGUiIYF2oSc+eE57uvZhmb/He2mq0Pr/9azRih4cfEfmGtEuyBuUf71C3oN78AD68Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733486580; c=relaxed/simple;
	bh=pVtpHpwALZU07KWDhbYW0H0drxhREf9hgaakkO06La4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=guyUwB+XzQM/TBvYuAJd6MS4BfoMXr08a2aScMLA48n1C0xENP8Z4JgTXUw/ilnkZpb7XIUFXIawi45nXSETlWj30J3ZQdNDViODE/+92s5GZ6zmgc+Z4T0vjMy+BCpsVNu6f4GgzpZG0kF9klHvBOmPzMtGl/vl3IaKL+y9M2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xv6QInuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEB79C4CED1;
	Fri,  6 Dec 2024 12:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733486579;
	bh=pVtpHpwALZU07KWDhbYW0H0drxhREf9hgaakkO06La4=;
	h=Subject:To:Cc:From:Date:From;
	b=Xv6QInuDQUQWd1lu7l9Pkdq5IA5SomYgzfPsJ/tJzrtgUSWUc2KgfHAIEVvw1r8Sj
	 KruJPtckSDcvVEyQ6/YO8dAbt9X7yiIWdRKrwT11LURcWC5ZxuCwpOxxkdl9jeJ+wq
	 V0Z1ExJPdEZFlM5jUJGyHdD3csjjSdxuw3Ue9HBo=
Subject: FAILED: patch "[PATCH] posix-timers: Target group sigqueue to current task only if" failed to apply to 6.12-stable tree
To: frederic@kernel.org,anthony.mallet@laas.fr,oleg@redhat.com,tglx@linutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 06 Dec 2024 13:02:56 +0100
Message-ID: <2024120656-jelly-gore-aa4c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 63dffecfba3eddcf67a8f76d80e0c141f93d44a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024120656-jelly-gore-aa4c@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63dffecfba3eddcf67a8f76d80e0c141f93d44a5 Mon Sep 17 00:00:00 2001
From: Frederic Weisbecker <frederic@kernel.org>
Date: Sat, 23 Nov 2024 00:48:11 +0100
Subject: [PATCH] posix-timers: Target group sigqueue to current task only if
 not exiting

A sigqueue belonging to a posix timer, which target is not a specific
thread but a whole thread group, is preferrably targeted to the current
task if it is part of that thread group.

However nothing prevents a posix timer event from queueing such a
sigqueue from a reaped yet running task. The interruptible code space
between exit_notify() and the final call to schedule() is enough for
posix_timer_fn() hrtimer to fire.

If that happens while the current task is part of the thread group
target, it is proposed to handle it but since its sighand pointer may
have been cleared already, the sigqueue is dropped even if there are
other tasks running within the group that could handle it.

As a result posix timers with thread group wide target may miss signals
when some of their threads are exiting.

Fix this with verifying that the current task hasn't been through
exit_notify() before proposing it as a preferred target so as to ensure
that its sighand is still here and stable.

complete_signal() might still reconsider the choice and find a better
target within the group if current has passed retarget_shared_pending()
already.

Fixes: bcb7ee79029d ("posix-timers: Prefer delivery of signals to the current thread")
Reported-by: Anthony Mallet <anthony.mallet@laas.fr>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Oleg Nesterov <oleg@redhat.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20241122234811.60455-1-frederic@kernel.org
Closes: https://lore.kernel.org/all/26411.57288.238690.681680@gargle.gargle.HOWL

diff --git a/kernel/signal.c b/kernel/signal.c
index 98b65cb35830..989b1cc9116a 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1959,14 +1959,15 @@ static void posixtimer_queue_sigqueue(struct sigqueue *q, struct task_struct *t,
  *
  * Where type is not PIDTYPE_PID, signals must be delivered to the
  * process. In this case, prefer to deliver to current if it is in
- * the same thread group as the target process, which avoids
- * unnecessarily waking up a potentially idle task.
+ * the same thread group as the target process and its sighand is
+ * stable, which avoids unnecessarily waking up a potentially idle task.
  */
 static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
 {
 	struct task_struct *t = pid_task(tmr->it_pid, tmr->it_pid_type);
 
-	if (t && tmr->it_pid_type != PIDTYPE_PID && same_thread_group(t, current))
+	if (t && tmr->it_pid_type != PIDTYPE_PID &&
+	    same_thread_group(t, current) && !current->exit_state)
 		t = current;
 	return t;
 }



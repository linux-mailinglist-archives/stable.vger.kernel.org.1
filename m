Return-Path: <stable+bounces-69570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79016956843
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 12:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E041C2123B
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0187E15F3E7;
	Mon, 19 Aug 2024 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sThu2/76"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7725158DBF
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062943; cv=none; b=KspD8sDVww7ldS2UgCo9RHpz+c2DPj6NaCzS3JxyQz5HseYytJHFwbL+3LaWqZtHHYtzhFj9nyU5X2xwoScnn4Fi1nA3AHBK2CK1ke1sScAuinxyfAEyS0Uf+iTxOvVCrSWuBAC+QxNUDDob5dhJGynFYGPoXmELwuwPYGZtI/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062943; c=relaxed/simple;
	bh=UR64QFryQ2sf1YO/B1TLh0Fs28ItAW30rSfB/cS4jSs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=O+hDkXCG7aioWbqBxtqDgrBTwDolUxQQQzobh+DKyeJPTK2Oj9/vKV0jYLn5DYQAuqEcdFnOpfLW2wt+eOlPYahsX/Hjyxcq63Pus5gCRtyjTPi+I4DWbvi8vVRnWP1fssNSjw6Qh232VaHaacTIJXSDbDZ7vJ2Z1L/2b9GL44g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sThu2/76; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40169C32782;
	Mon, 19 Aug 2024 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724062943;
	bh=UR64QFryQ2sf1YO/B1TLh0Fs28ItAW30rSfB/cS4jSs=;
	h=Subject:To:Cc:From:Date:From;
	b=sThu2/76W0QVbaehz9k2Ir2+OxfCMLijraLGhPiYICkbm5bzIeBCd1y7MexO6QTB8
	 JALK0sls2dtCt0wrY4vVk3XRMMYX9IbyO6huksdKMY+6YSUjZXsyH5xhmiLzrhTRpj
	 SNYc7bUVlOBMBNEWeEkTCO246tUjRHubK6R66V+U=
Subject: FAILED: patch "[PATCH] pidfd: prevent creation of pidfds for kthreads" failed to apply to 5.15-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 12:22:10 +0200
Message-ID: <2024081910-grid-bobsled-6cb3@gregkh>
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
git cherry-pick -x 3b5bbe798b2451820e74243b738268f51901e7d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081910-grid-bobsled-6cb3@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

3b5bbe798b24 ("pidfd: prevent creation of pidfds for kthreads")
83b290c9e3b5 ("pidfd: clone: allow CLONE_THREAD | CLONE_PIDFD together")
64bef697d33b ("pidfd: implement PIDFD_THREAD flag for pidfd_open()")
21e25205d7f9 ("pidfd: don't do_notify_pidfd() if !thread_group_empty()")
cdefbf2324ce ("pidfd: cleanup the usage of __pidfd_prepare's flags")
932562a6045e ("rseq: Split out rseq.h from sched.h")
cba6167f0adb ("restart_block: Trim includes")
f038cc1379c0 ("locking/seqlock: Split out seqlock_types.h")
53d31ba842d9 ("posix-cpu-timers: Split out posix-timers_types.h")
f995443f01b4 ("locking/seqlock: Simplify SEQCOUNT_LOCKNAME()")
58390c8ce1bd ("Merge tag 'iommu-updates-v6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3b5bbe798b2451820e74243b738268f51901e7d0 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 31 Jul 2024 12:01:12 +0200
Subject: [PATCH] pidfd: prevent creation of pidfds for kthreads

It's currently possible to create pidfds for kthreads but it is unclear
what that is supposed to mean. Until we have use-cases for it and we
figured out what behavior we want block the creation of pidfds for
kthreads.

Link: https://lore.kernel.org/r/20240731-gleis-mehreinnahmen-6bbadd128383@brauner
Fixes: 32fcb426ec00 ("pid: add pidfd_open()")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>

diff --git a/kernel/fork.c b/kernel/fork.c
index cc760491f201..18bdc87209d0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2053,11 +2053,24 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
  */
 int pidfd_prepare(struct pid *pid, unsigned int flags, struct file **ret)
 {
-	bool thread = flags & PIDFD_THREAD;
-
-	if (!pid || !pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID))
+	if (!pid)
 		return -EINVAL;
 
+	scoped_guard(rcu) {
+		struct task_struct *tsk;
+
+		if (flags & PIDFD_THREAD)
+			tsk = pid_task(pid, PIDTYPE_PID);
+		else
+			tsk = pid_task(pid, PIDTYPE_TGID);
+		if (!tsk)
+			return -EINVAL;
+
+		/* Don't create pidfds for kernel threads for now. */
+		if (tsk->flags & PF_KTHREAD)
+			return -EINVAL;
+	}
+
 	return __pidfd_prepare(pid, flags, ret);
 }
 
@@ -2403,6 +2416,12 @@ __latent_entropy struct task_struct *copy_process(
 	if (clone_flags & CLONE_PIDFD) {
 		int flags = (clone_flags & CLONE_THREAD) ? PIDFD_THREAD : 0;
 
+		/* Don't create pidfds for kernel threads for now. */
+		if (args->kthread) {
+			retval = -EINVAL;
+			goto bad_fork_free_pid;
+		}
+
 		/* Note that no task has been attached to @pid yet. */
 		retval = __pidfd_prepare(pid, flags, &pidfile);
 		if (retval < 0)



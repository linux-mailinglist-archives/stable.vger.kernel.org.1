Return-Path: <stable+bounces-20629-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C35C85AA9D
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:11:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16F581F23634
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A838F481B1;
	Mon, 19 Feb 2024 18:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2n/o12ZF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548D481AE
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366291; cv=none; b=DL6UZnlTidgtSLshhCBCIuUYMPnasZozJ+1l9fBrwOd56V59WWnU0A6j19uGe3uke3/G3bCI+38DKR5a1PcNm6b5+KeKxdbin3PJ2sRI3EkQYP/7Gpq3aHrRUBO5W1V+CV8aY7ffFtwdhn23Hkea9++NPNmt2y/BXtyNmJAxvlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366291; c=relaxed/simple;
	bh=JXf1XRHVqmK6Wwv4Qit3WS8L0hg3IlrKQGldIMaDB90=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cb87eGYpWYOWbnIQbkwe3Xr16ZG04ET+BwDnN7pl0BOLSjfhj7fL2icxErF8bgiOgspoUSdQ63YRgN1U9wwhb8A7+GD1eof0bZJCNjJAIZbq83mbL8AI4iOlC2BaTm1NLXHts3uz9bjzSaiVIl1xbRePLyb1PWKhJ+PEo8vRi7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2n/o12ZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59EEC433F1;
	Mon, 19 Feb 2024 18:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366290;
	bh=JXf1XRHVqmK6Wwv4Qit3WS8L0hg3IlrKQGldIMaDB90=;
	h=Subject:To:Cc:From:Date:From;
	b=2n/o12ZFPirHQycSaRLVHTgh2sROuJ6bmbvROhKETxFx11SpUj3HblUQykJQUhQ1Z
	 GUNYsqk8y+N8bfkqVY5pMlIr8g/qIq2vtxbYBY073ijsLxwEg9/Oc26NHfSKF7pIyT
	 9wPepUhYZEv9Ym9wUcCazl06riCiKeivvHgAB1l8=
Subject: FAILED: patch "[PATCH] getrusage: move thread_group_cputime_adjusted() outside of" failed to apply to 5.15-stable tree
To: oleg@redhat.com,akpm@linux-foundation.org,dylanbhatch@google.com,ebiederm@xmission.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:11:23 +0100
Message-ID: <2024021923-promptly-dedicate-e327@gregkh>
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
git cherry-pick -x daa694e4137571b4ebec330f9a9b4d54aa8b8089
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021923-promptly-dedicate-e327@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

daa694e41375 ("getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()")
c7ac8231ace9 ("getrusage: add the "signal_struct *sig" local variable")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From daa694e4137571b4ebec330f9a9b4d54aa8b8089 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Mon, 22 Jan 2024 16:50:50 +0100
Subject: [PATCH] getrusage: move thread_group_cputime_adjusted() outside of
 lock_task_sighand()

Patch series "getrusage: use sig->stats_lock", v2.


This patch (of 2):

thread_group_cputime() does its own locking, we can safely shift
thread_group_cputime_adjusted() which does another for_each_thread loop
outside of ->siglock protected section.

This is also preparation for the next patch which changes getrusage() to
use stats_lock instead of siglock, thread_group_cputime() takes the same
lock.  With the current implementation recursive read_seqbegin_or_lock()
is fine, thread_group_cputime() can't enter the slow mode if the caller
holds stats_lock, yet this looks more safe and better performance-wise.

Link: https://lkml.kernel.org/r/20240122155023.GA26169@redhat.com
Link: https://lkml.kernel.org/r/20240122155050.GA26205@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reported-by: Dylan Hatch <dylanbhatch@google.com>
Tested-by: Dylan Hatch <dylanbhatch@google.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/kernel/sys.c b/kernel/sys.c
index e219fcfa112d..70ad06ad852e 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1785,17 +1785,19 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	struct task_struct *t;
 	unsigned long flags;
 	u64 tgutime, tgstime, utime, stime;
-	unsigned long maxrss = 0;
+	unsigned long maxrss;
+	struct mm_struct *mm;
 	struct signal_struct *sig = p->signal;
 
-	memset((char *)r, 0, sizeof (*r));
+	memset(r, 0, sizeof(*r));
 	utime = stime = 0;
+	maxrss = 0;
 
 	if (who == RUSAGE_THREAD) {
 		task_cputime_adjusted(current, &utime, &stime);
 		accumulate_thread_rusage(p, r);
 		maxrss = sig->maxrss;
-		goto out;
+		goto out_thread;
 	}
 
 	if (!lock_task_sighand(p, &flags))
@@ -1819,9 +1821,6 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		fallthrough;
 
 	case RUSAGE_SELF:
-		thread_group_cputime_adjusted(p, &tgutime, &tgstime);
-		utime += tgutime;
-		stime += tgstime;
 		r->ru_nvcsw += sig->nvcsw;
 		r->ru_nivcsw += sig->nivcsw;
 		r->ru_minflt += sig->min_flt;
@@ -1839,19 +1838,24 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	}
 	unlock_task_sighand(p, &flags);
 
-out:
+	if (who == RUSAGE_CHILDREN)
+		goto out_children;
+
+	thread_group_cputime_adjusted(p, &tgutime, &tgstime);
+	utime += tgutime;
+	stime += tgstime;
+
+out_thread:
+	mm = get_task_mm(p);
+	if (mm) {
+		setmax_mm_hiwater_rss(&maxrss, mm);
+		mmput(mm);
+	}
+
+out_children:
+	r->ru_maxrss = maxrss * (PAGE_SIZE / 1024); /* convert pages to KBs */
 	r->ru_utime = ns_to_kernel_old_timeval(utime);
 	r->ru_stime = ns_to_kernel_old_timeval(stime);
-
-	if (who != RUSAGE_CHILDREN) {
-		struct mm_struct *mm = get_task_mm(p);
-
-		if (mm) {
-			setmax_mm_hiwater_rss(&maxrss, mm);
-			mmput(mm);
-		}
-	}
-	r->ru_maxrss = maxrss * (PAGE_SIZE / 1024); /* convert pages to KBs */
 }
 
 SYSCALL_DEFINE2(getrusage, int, who, struct rusage __user *, ru)



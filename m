Return-Path: <stable+bounces-20630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B4285AA9E
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E030283BDD
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F97481BF;
	Mon, 19 Feb 2024 18:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EL1G4D+l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8016481AB
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366299; cv=none; b=SZQ+92vUKOKTmxRoKsgG0aGog0JTPQmsSgueB49ri6YnIehT7wlXtse3rGRle3UxKKGga0ANEx3g03V8TI+b0oPcdd3gke24xEKEQrt+9ub/yoe/dIk7RU0Tipkig96uetVRruSF+2caoey94l/QUssmeZQ/7RFWKMvHelkEUUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366299; c=relaxed/simple;
	bh=PpMCINiU+LvkQCuHfj+fiU5kp9ieGziXoqoaPjQd4gw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=n3gEu6HEhgqvt8O3SKlSJ8lGc/qzbOI+AE0XwSbDAOQ8KvB+y8Vu6y76hC3+8KoSend1NELRJ+4yx9z96nsp32E0/hjExpqf3IKDKq6gHm093RMnFbXgNk1FLv0Dv+d3Xh/qo3ZawiEVOl8c1o8UtBLQw5zAx5jG8DbEcPAztp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EL1G4D+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB169C433F1;
	Mon, 19 Feb 2024 18:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366298;
	bh=PpMCINiU+LvkQCuHfj+fiU5kp9ieGziXoqoaPjQd4gw=;
	h=Subject:To:Cc:From:Date:From;
	b=EL1G4D+lez6OetgogCSIgTfRF19KNGso4zBYCaLMakhP2zMB+8JVhAfZHL+4l+r7x
	 RA/LVI/TO8p1GxTVaOV1VSmgjk7RWgCKWic6UWKfbvaF3xy0jemij53k5TS5lrOuIe
	 7J1Z3rUdPEayrL/72A6gC43HNAd6xfi0hkwQrAzs=
Subject: FAILED: patch "[PATCH] getrusage: move thread_group_cputime_adjusted() outside of" failed to apply to 5.10-stable tree
To: oleg@redhat.com,akpm@linux-foundation.org,dylanbhatch@google.com,ebiederm@xmission.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:11:24 +0100
Message-ID: <2024021924-steersman-sixtieth-0e6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x daa694e4137571b4ebec330f9a9b4d54aa8b8089
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021924-steersman-sixtieth-0e6e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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



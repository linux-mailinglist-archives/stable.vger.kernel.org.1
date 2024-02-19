Return-Path: <stable+bounces-20637-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A2485AAA6
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1F71F21AFF
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6BC47F63;
	Mon, 19 Feb 2024 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yhPOL52J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7343B19D
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366321; cv=none; b=jh1aR1O2LOP45EVK7PW8cFzvDbL9YufP9ViCvScnA4JrUHvpioBEUpwS9EH0p4RFhfNRFat6d1vJic70K4VIoo2j4H4H8//V2szcK4+KIrWnbTypqcity56/Pg75WXSE1EfwvE8uJLR5hdivsbiwW9WcSNTb0g/tyQarRYGljn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366321; c=relaxed/simple;
	bh=Js5tmWxFT4CQhJ2NvQi1tlQLpoW156uAvbDWXveiFZs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Vpl/NmcA/pWsIm7uWq43LiDR7kRooQGCTTspfAkCiMuEUbMlknEB7dYpYcRfGZmZX4sApsBfOH7C9+YQTS/RxOaRRO1FKALj9mR+iHgh3Z4/uf76Pad4vydlA8JAIScV1QmUwiICOQ8diPPHA3sIzkVwYlTcyVNGsybg/EmJNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yhPOL52J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB012C433C7;
	Mon, 19 Feb 2024 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366321;
	bh=Js5tmWxFT4CQhJ2NvQi1tlQLpoW156uAvbDWXveiFZs=;
	h=Subject:To:Cc:From:Date:From;
	b=yhPOL52JrsDdn8OaYgWKC5vLXYAtczHz7mOJVadZSkC8ydLby5XXPF2bfZVtY0Fz+
	 5xDTquaFMKcirxoZO/APS/bc5hD5r97I6OmoNsac1jAW1DTEAO2/ujpoxXzJQQh4+F
	 nSnFJgugqDucqlmW29h084kXBHN7Jj2qA60NYzL0=
Subject: FAILED: patch "[PATCH] getrusage: use sig->stats_lock rather than" failed to apply to 5.4-stable tree
To: oleg@redhat.com,akpm@linux-foundation.org,dylanbhatch@google.com,ebiederm@xmission.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:11:40 +0100
Message-ID: <2024021940-bonfire-exert-b64f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x f7ec1cd5cc7ef3ad964b677ba82b8b77f1c93009
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021940-bonfire-exert-b64f@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

f7ec1cd5cc7e ("getrusage: use sig->stats_lock rather than lock_task_sighand()")
daa694e41375 ("getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()")
13b7bc60b535 ("getrusage: use __for_each_thread()")
c7ac8231ace9 ("getrusage: add the "signal_struct *sig" local variable")
bdd565f817a7 ("y2038: rusage: use __kernel_old_timeval")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f7ec1cd5cc7ef3ad964b677ba82b8b77f1c93009 Mon Sep 17 00:00:00 2001
From: Oleg Nesterov <oleg@redhat.com>
Date: Mon, 22 Jan 2024 16:50:53 +0100
Subject: [PATCH] getrusage: use sig->stats_lock rather than
 lock_task_sighand()

lock_task_sighand() can trigger a hard lockup. If NR_CPUS threads call
getrusage() at the same time and the process has NR_THREADS, spin_lock_irq
will spin with irqs disabled O(NR_CPUS * NR_THREADS) time.

Change getrusage() to use sig->stats_lock, it was specifically designed
for this type of use. This way it runs lockless in the likely case.

TODO:
	- Change do_task_stat() to use sig->stats_lock too, then we can
	  remove spin_lock_irq(siglock) in wait_task_zombie().

	- Turn sig->stats_lock into seqcount_rwlock_t, this way the
	  readers in the slow mode won't exclude each other. See
	  https://lore.kernel.org/all/20230913154907.GA26210@redhat.com/

	- stats_lock has to disable irqs because ->siglock can be taken
	  in irq context, it would be very nice to change __exit_signal()
	  to avoid the siglock->stats_lock dependency.

Link: https://lkml.kernel.org/r/20240122155053.GA26214@redhat.com
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Reported-by: Dylan Hatch <dylanbhatch@google.com>
Tested-by: Dylan Hatch <dylanbhatch@google.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/kernel/sys.c b/kernel/sys.c
index 70ad06ad852e..f8e543f1e38a 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1788,7 +1788,9 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 	unsigned long maxrss;
 	struct mm_struct *mm;
 	struct signal_struct *sig = p->signal;
+	unsigned int seq = 0;
 
+retry:
 	memset(r, 0, sizeof(*r));
 	utime = stime = 0;
 	maxrss = 0;
@@ -1800,8 +1802,7 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		goto out_thread;
 	}
 
-	if (!lock_task_sighand(p, &flags))
-		return;
+	flags = read_seqbegin_or_lock_irqsave(&sig->stats_lock, &seq);
 
 	switch (who) {
 	case RUSAGE_BOTH:
@@ -1829,14 +1830,23 @@ void getrusage(struct task_struct *p, int who, struct rusage *r)
 		r->ru_oublock += sig->oublock;
 		if (maxrss < sig->maxrss)
 			maxrss = sig->maxrss;
+
+		rcu_read_lock();
 		__for_each_thread(sig, t)
 			accumulate_thread_rusage(t, r);
+		rcu_read_unlock();
+
 		break;
 
 	default:
 		BUG();
 	}
-	unlock_task_sighand(p, &flags);
+
+	if (need_seqretry(&sig->stats_lock, seq)) {
+		seq = 1;
+		goto retry;
+	}
+	done_seqretry_irqrestore(&sig->stats_lock, seq, flags);
 
 	if (who == RUSAGE_CHILDREN)
 		goto out_children;



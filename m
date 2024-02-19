Return-Path: <stable+bounces-20633-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B8E85AAA2
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 19:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7F51C217C1
	for <lists+stable@lfdr.de>; Mon, 19 Feb 2024 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1496481AF;
	Mon, 19 Feb 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="113i2+v9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E0481A7
	for <stable@vger.kernel.org>; Mon, 19 Feb 2024 18:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366308; cv=none; b=UXt5anzSW42Md4v4bpAa707z5y1lNfeONq68eD5pEcCqOAT7hrfVM5B+sLZSrMC1q3UlvqjuZvUcoxNHylNTZeF+LUmJX0UYTF+wNFtMqw4YRFNV0vX2/fx8K0MWyGdcUf0QU1T7fPiVhMbSDDeEiaRVsZbjVWT4bmtGuPptLeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366308; c=relaxed/simple;
	bh=IXmKvGV6vTOi32DzQNf2ca09SeFFbSseMoaR4V26AgI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QcLJesiqGN78S9f3fK5bLr/ab2pw4HoMdjY0clCLIJBLEelpWDyIwQIus7i4uD10oQOBHM2Qf5A2xyNaBOuKtQtb1WsxzCft4uc29qLlgKWl32l3gBu3YjaClIhiJUECgu9psKnpnFpSbeDKWYXp4YfvL3p8fHp/BX2c7g8eaM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=113i2+v9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7DDC433F1;
	Mon, 19 Feb 2024 18:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708366308;
	bh=IXmKvGV6vTOi32DzQNf2ca09SeFFbSseMoaR4V26AgI=;
	h=Subject:To:Cc:From:Date:From;
	b=113i2+v9BRsgL63+rLp2LOgFIds9WP8fSel3PLSGoBUBsydzal/fDGXGoARbwjSKW
	 Fvv3H5GBhsm+1OA4otr/RcdOSlWSUdpvSFfhAFci5UtEy7U1Z8VP7ZL5kOdTbMfSh6
	 JiPXbPxnRdQpdoU9H1pQ1N5r7w9tpNtSxLWHncp8=
Subject: FAILED: patch "[PATCH] getrusage: use sig->stats_lock rather than" failed to apply to 6.6-stable tree
To: oleg@redhat.com,akpm@linux-foundation.org,dylanbhatch@google.com,ebiederm@xmission.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Feb 2024 19:11:33 +0100
Message-ID: <2024021933-passion-crucial-7362@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f7ec1cd5cc7ef3ad964b677ba82b8b77f1c93009
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024021933-passion-crucial-7362@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

f7ec1cd5cc7e ("getrusage: use sig->stats_lock rather than lock_task_sighand()")
daa694e41375 ("getrusage: move thread_group_cputime_adjusted() outside of lock_task_sighand()")
13b7bc60b535 ("getrusage: use __for_each_thread()")
c7ac8231ace9 ("getrusage: add the "signal_struct *sig" local variable")

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



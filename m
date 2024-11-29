Return-Path: <stable+bounces-95805-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E17F9DE65A
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 13:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21FF21649DC
	for <lists+stable@lfdr.de>; Fri, 29 Nov 2024 12:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FA219D065;
	Fri, 29 Nov 2024 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H9mLtwEo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+kegZlHi"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7C919A298;
	Fri, 29 Nov 2024 12:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732883214; cv=none; b=nNSuWCTEh5PpLnHFsqutYbBQ8AauCt50nMOw3odswRGO8V8RlQ8EFhyj6Q0GB9/QL6BM0XMDWORc+sHbn3gU8Olz6biobdcyWLOE/wtKTtyCRZCsDF0M0vKBo3PcMLhp6dlu97u/8yEacvpPltaQDj2qLed7lbGAVCIexQEjg+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732883214; c=relaxed/simple;
	bh=FHiC2Wea6t2YR3kDPzsqL1s5fgWUsTDDIXkAK5wspI0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ui02Z50hnvz2uZWp+VttDtNsd/c1K5PX/vu3DVp8kNjMl2hQ0dYOWD/9gNTsgas1XLFF47mosnlFX7OVs4MbZl3ert8A0UwkHGozmuDPukJ2lNsqYM+eRRmHOFazA28hu48uGTLxfDI6yuU+5noOxc3e2iET3XKTFEXdF55rj24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H9mLtwEo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+kegZlHi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 29 Nov 2024 12:26:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732883211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJVSSdJOdSZGebsbDcIYlSf24/N5rpFGvgPRw9vnbI0=;
	b=H9mLtwEoDSF2z6E9X8+VII5TvJdOodoCwDjxr9fy4D0deEa5LwhZPpvm97baANCYThoHKf
	PaNeLefSvg7LjmIldGcAaEDaBsTELerI/ecnjiHWMBPZLWRitu9/qgJL1b1Qq0VecbN5tk
	aNf1UXjKXJshRCLwDLjvFlBmps1OyVFrEl1sA4jo80ZQ4vzxTlNQ7l61PmA6q2iWO6ptg4
	gSU7G/2/4JlNk4+jcBkIxgQOHkiitfkl3mL7aJJ3AE3p2LJZFqbAyMABQa+5+RZteTH+Ie
	1DEH0/1dXH61wbzYn1oVGvwaW1JTrGI3Y02n/0iq5lUNZu3deuhOkoE00oWQbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732883211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJVSSdJOdSZGebsbDcIYlSf24/N5rpFGvgPRw9vnbI0=;
	b=+kegZlHi5G2dAnZ+f3NYBk+B4bu+sdMfrMGyhPRvdmNDKhaTpdGsvA08AQqckmOXAuZcwH
	/+7Qkw2blfyLh/AQ==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] posix-timers: Target group sigqueue to current
 task only if not exiting
Cc: Anthony Mallet <anthony.mallet@laas.fr>, Oleg Nesterov <oleg@redhat.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241122234811.60455-1-frederic@kernel.org>
References: <20241122234811.60455-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173288321021.412.11000070169478198327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     63dffecfba3eddcf67a8f76d80e0c141f93d44a5
Gitweb:        https://git.kernel.org/tip/63dffecfba3eddcf67a8f76d80e0c141f93d44a5
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Sat, 23 Nov 2024 00:48:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 29 Nov 2024 13:19:09 +01:00

posix-timers: Target group sigqueue to current task only if not exiting

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
---
 kernel/signal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 98b65cb..989b1cc 100644
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


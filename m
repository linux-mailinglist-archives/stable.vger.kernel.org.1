Return-Path: <stable+bounces-89969-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489799BDC15
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 03:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5133F1C22C95
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 02:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2350C1D5ADE;
	Wed,  6 Nov 2024 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RA2GuPjG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D240C1D5CF2;
	Wed,  6 Nov 2024 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730859020; cv=none; b=u93TjaJ71+Ueuf+C8L/h391mfeSSDRrZQbDBpV6kY8kA1IDRjI198hLE2XWkmjUV92e3sIDLNWNVYt/nZ1Fb4ykOAg/QTZKkgg/2GsgtsRVXwJNTwj5WERNZfAv0TIn09PrRVkPfFOBWE0zUdr/KhS91ooZAaQatU9SW6gk6bEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730859020; c=relaxed/simple;
	bh=U8SfGi9S7CnLF+4L2YGr8saonvufQuCOZTo6a5ch3ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgCiz6PLCuHNqaCWlBNTh46w+ENFPgg1mLhc0iHOHp1rHMUm1AJShC6csH8jPG4IlypJEqAO1mbR6aqQSWA/OVlF1fLo2QF3kqu5UTgkOq3JOhX/7/6IgPlTRuUTG9Gi3s24hJZ02KBxdXw0TvoFQ0Opz7EBmo2N2AWXY0Yljuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RA2GuPjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81AAC4CED1;
	Wed,  6 Nov 2024 02:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730859020;
	bh=U8SfGi9S7CnLF+4L2YGr8saonvufQuCOZTo6a5ch3ls=;
	h=From:To:Cc:Subject:Date:From;
	b=RA2GuPjGnT22Rq6DFbnCAoEHRuVloPelScBi1j9M7bDkrZXle4V2smcqE2jk495ke
	 MvV9J4SjMn3lYN4j5x5ZJTLjOKmHMHYWzBVQCW2TLcw7OojpLz7tknd26rMbvJfkUt
	 DS3gwLM4V+STjuVU30fdNSmBfZISXw236eHdxVZZCySUol2bHu/3Mc2t78Yp68vCV8
	 HDf8O9MP9kVvPYQAiyzvXxcJztr6Lck9MVibz7u+0Ji7OJjmYDQbECXoQfhbTTiOaV
	 3CgY7fGeyxoprW3mq72YfVlb3nUObi3bTV/o4OyotqeDVAGggSyVIegmAsJ5SC13K+
	 MSp3YlfZPpRuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bsegall@google.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER on clone" failed to apply to v6.1-stable tree
Date: Tue,  5 Nov 2024 21:10:17 -0500
Message-ID: <20241106021018.179970-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the v6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b5413156bad91dc2995a5c4eab1b05e56914638a Mon Sep 17 00:00:00 2001
From: Benjamin Segall <bsegall@google.com>
Date: Fri, 25 Oct 2024 18:35:35 -0700
Subject: [PATCH] posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER on clone

When cloning a new thread, its posix_cputimers are not inherited, and
are cleared by posix_cputimers_init(). However, this does not clear the
tick dependency it creates in tsk->tick_dep_mask, and the handler does
not reach the code to clear the dependency if there were no timers to
begin with.

Thus if a thread has a cputimer running before clone/fork, all
descendants will prevent nohz_full unless they create a cputimer of
their own.

Fix this by entirely clearing the tick_dep_mask in copy_process().
(There is currently no inherited state that needs a tick dependency)

Process-wide timers do not have this problem because fork does not copy
signal_struct as a baseline, it creates one from scratch.

Fixes: b78783000d5c ("posix-cpu-timers: Migrate to use new tick dependency mask model")
Signed-off-by: Ben Segall <bsegall@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/xm26o737bq8o.fsf@google.com
---
 include/linux/tick.h | 8 ++++++++
 kernel/fork.c        | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 72744638c5b0f..99c9c5a7252aa 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -251,12 +251,19 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_set_task(tsk, bit);
 }
+
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit)
 {
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_clear_task(tsk, bit);
 }
+
+static inline void tick_dep_init_task(struct task_struct *tsk)
+{
+	atomic_set(&tsk->tick_dep_mask, 0);
+}
+
 static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit)
 {
@@ -290,6 +297,7 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
+static inline void tick_dep_init_task(struct task_struct *tsk) { }
 static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
diff --git a/kernel/fork.c b/kernel/fork.c
index 89ceb4a68af25..6fa9fe62e01e3 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <linux/rseq.h>
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
+#include <linux/tick.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2292,6 +2293,7 @@ __latent_entropy struct task_struct *copy_process(
 	acct_clear_integrals(p);
 
 	posix_cputimers_init(&p->posix_cputimers);
+	tick_dep_init_task(p);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
-- 
2.43.0






Return-Path: <stable+bounces-91776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277009C0208
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59A351C20DB3
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 10:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FB51EABB4;
	Thu,  7 Nov 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdhp+9da"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A541E8856;
	Thu,  7 Nov 2024 10:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730974496; cv=none; b=okwR2INAHm5ywsU5k5m5tVTJe3G5MU2GO3GKs9nrsd/SwYYt7yZHgVGrrjLfT2/2OqRQRzjC+igsBSxiyQ++Ue14Yf/3z2kgIqIXDsc8o11cRBGVyos0sifjZ8dk8+aaG2zOJ04o8j43l+sKws1nqewJ+ejiT81YAi0l7tBsB4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730974496; c=relaxed/simple;
	bh=w5g82WZeZTzWD79OqJf1UTmTavO98j4tPfUoxbpEwQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ckfVaL0tkWSxjZ0I1xjIWBrZl/fSWM8NoEKEM6mxEvij/DA9Sino3wCRo/bq8WjVXvw3komhqSMm6sKAdQZzfyQNa+9gTtXdX78ZBV7jEsnFICh8QczQ0FO7svhSPamkT/+d3pKeyQ8Z4YN2fIQHMrky1ymtGgVn/NosoKGW0bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdhp+9da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F4EC4CED2;
	Thu,  7 Nov 2024 10:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730974495;
	bh=w5g82WZeZTzWD79OqJf1UTmTavO98j4tPfUoxbpEwQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rdhp+9daubb7PiW1j9ix67RZN+smC9IvZ+YXxVYxT76Xv22mO9/e47Vicp5aHctle
	 GGL0ZMwC2u4zM2vIg9j8P3jlNrD9/nFtyzftPktwI3GVCQ2gICfpsCe2QTLyV4yb2m
	 ggNGKqt02AqlqyVeD/Xr/z1rZwfWryZuE6lTxL5Ql6tPUX+udDxqcjtrcEN4ATPTjy
	 tSZ3w/sYHEN4R46ejmuapnMYIz9gahX4Vwm2wUUvqTFidPORSnLxy7IDidnwiao2TB
	 G5iBxwBXUOA8NM/g/ud6dPcWIpjBL4D4r5QbmBdQEP6hKL+XW6TDc+cnuBUH3w42Pi
	 CS0RYZKH99rcA==
Date: Thu, 7 Nov 2024 11:14:52 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, bsegall@google.com,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER
 on clone" failed to apply to v6.1-stable tree
Message-ID: <ZyyTHGkchGzeHBx3@pavilion.home>
References: <20241106021018.179970-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106021018.179970-1-sashal@kernel.org>

Hi,

Le Tue, Nov 05, 2024 at 09:10:17PM -0500, Sasha Levin a écrit :
> The patch below does not apply to the v6.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.


Can you try with this updated version on the failing trees?

Thanks.

---
From b5b62a0c48448c4bf7cc0ff8c3f3736ced489939 Mon Sep 17 00:00:00 2001
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
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/tick.h | 8 ++++++++
 kernel/fork.c        | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 9459fef5b857..9701c571a5cf 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -252,12 +252,19 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
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
@@ -291,6 +298,7 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
+static inline void tick_dep_init_task(struct task_struct *tsk) { }
 static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
diff --git a/kernel/fork.c b/kernel/fork.c
index 8dd46baee4c3..09a935724bd9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/tick.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2183,6 +2184,7 @@ static __latent_entropy struct task_struct *copy_process(
 	acct_clear_integrals(p);
 
 	posix_cputimers_init(&p->posix_cputimers);
+	tick_dep_init_task(p);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
-- 
2.46.0



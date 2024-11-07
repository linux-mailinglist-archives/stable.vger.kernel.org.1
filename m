Return-Path: <stable+bounces-91780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ACA9C0268
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C94D91C21323
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 10:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997CE1E909B;
	Thu,  7 Nov 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI23klle"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF61DF72F;
	Thu,  7 Nov 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975549; cv=none; b=F4/dNY0LZ/MCubLFA52jZMQUO1PJ6FUA8scJk0qYd4A+qArGr/wGE6mofHE/d1DMucgnvNNqRdbLLVXU3wnad7W/MZQdwT0UAm2Shew1P+Y4shotFHQv+0JGGTOXkNVC3AKsbRBuuU+/GAJO04/gcTWeqiJ/jREjM1KA2/AqGHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975549; c=relaxed/simple;
	bh=zftwGZWn+NcFfV7ZloooFrWn7zlJGxlcpjkWe9gYlLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+apbQwBjOVFd3GYhB6fiBrs0sMt4skqsZYg5iszYYlTI7ABeg2aM3HyN+MLaJquITwA3xvbRVYbRyh46km1aDiOt62zJTmNULnEyGIvQcnOTKfmcRaSamlNa68EPHZuCDWXlj7ZjJbUsnZAg5u+88qUgECvLMogKkhnwVPtRA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI23klle; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79463C4CECC;
	Thu,  7 Nov 2024 10:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730975548;
	bh=zftwGZWn+NcFfV7ZloooFrWn7zlJGxlcpjkWe9gYlLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OI23klleBHMR0yzZMj7BsFVm4O+KNdGs/7UUvwVXWHjpXv/n5jQLG1C67sir353t7
	 QAaUwp4EBT0Bp5lCxEBaMkHyW5ey7t2ygkVp4p2gf+89jF5cfr4Tml8Ye3oWIop1xC
	 42aXwmNCGZUrr+69BqAdHxKPlTQNBmS8g/urcJiuY2NUjuQeZ4PHtqAZKwiB9Ls+U/
	 geFO7qhxeR9FYwJXt+oZ//RsmCQ0n3N3yhuFhV0ogLa+Uws1sab3Uwc3GxPt2KI3HY
	 AORK05G2cJipRQkw1pvuqEJIosZvTR8d7EJRPwGTMqG6iGQJdik87oVGqASmg0pY/E
	 EnKrRvAvyRiQQ==
Date: Thu, 7 Nov 2024 11:32:26 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, bsegall@google.com,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER
 on clone" failed to apply to v5.10-stable tree
Message-ID: <ZyyXOhXF2xNA3luS@pavilion.home>
References: <20241106021231.182968-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106021231.182968-1-sashal@kernel.org>

Le Tue, Nov 05, 2024 at 09:12:31PM -0500, Sasha Levin a écrit :
> The patch below does not apply to the v5.10-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

Please try this one:

From 9f41884fa9493382e59a0d42b2084d37b36bec06 Mon Sep 17 00:00:00 2001
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
index a90a8f7759a2..fe38aaacebf0 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -247,12 +247,19 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
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
 static inline void tick_dep_set_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit)
 {
@@ -286,6 +293,7 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
+static inline void tick_dep_init_task(struct task_struct *tsk) { }
 static inline void tick_dep_set_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
diff --git a/kernel/fork.c b/kernel/fork.c
index 8b8a5a172b15..f54d32bcdb21 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -96,6 +96,7 @@
 #include <linux/kasan.h>
 #include <linux/scs.h>
 #include <linux/io_uring.h>
+#include <linux/tick.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2053,6 +2054,7 @@ static __latent_entropy struct task_struct *copy_process(
 	acct_clear_integrals(p);
 
 	posix_cputimers_init(&p->posix_cputimers);
+	tick_dep_init_task(p);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
-- 
2.46.0





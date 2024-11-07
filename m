Return-Path: <stable+bounces-91777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 153899C0239
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9D7283D6F
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 10:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5611EE015;
	Thu,  7 Nov 2024 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWLJMkF4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD91EE00E;
	Thu,  7 Nov 2024 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975008; cv=none; b=JNpZBO9tS6cAGFOUgYj8N2HwFhdtoGVTeP8qH7kGx7k8N/AGUcddax9jNfKyfpy3leedZBnGzr7FIbtSY7mAj8i9ztqzE2rFthrQbufThAWSwQtSVzsEgPW0T6cV4Zt0guEg4ylTpwcJfGAJd2hgmLcDv3Qg85UZsgb7/NKrAPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975008; c=relaxed/simple;
	bh=TFDLa8HlOYFM/PmgkFHcp+YBi3i4we1XyQl6R3cgqjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKxPZ2IqRqkQLy345AhyCZkfVDNcW5kiH9wGGpsDAmCkVE6zEM8zMOMUAoD6EG+j/mfB+txZgS/aQvU5H2U9YTncd7/hKULQze5DupNi8AVR0Xfr+AotUjxRl6gh6gewQxjQpQRZO1Qqhai0dVe2FnaJQiqopYieUrlvVnJscC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWLJMkF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F833C4CED6;
	Thu,  7 Nov 2024 10:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730975006;
	bh=TFDLa8HlOYFM/PmgkFHcp+YBi3i4we1XyQl6R3cgqjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PWLJMkF4VkREaKXG9X3OTXLiN1Im82ZokTh/4JheuKTSRX8WPJa5eVP33lBWui0US
	 4GZsGE5uTsnY9tion4Qky9G2UouKhsCaFcNPdzy0jsxxaLCtGymQfAPz3VEHX43oKh
	 cdNeVWhh0h8+44tQvU6XVqcQ85Rc7m0+x6FCVj+aWIWI09cqoPs3U3YKLzC8sytF15
	 mRIZqINIJjSpw7Gz6VmpH2z7faIUPfyiDUqHojjx4zoSDDjYFMY4MqyaDJ24EZQYcx
	 klMJUBhWoi/LVKhuFU8vCYV+OJzdRjr+F+/sSvpPJPvMNq3CGY4DZYDVbUWEZGwOfk
	 RcSqNeGPS4ulg==
Date: Thu, 7 Nov 2024 11:23:24 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, bsegall@google.com,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER
 on clone" failed to apply to v4.19-stable tree
Message-ID: <ZyyVHAwmFIyTc3rR@pavilion.home>
References: <20241106021416.184155-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106021416.184155-1-sashal@kernel.org>

Le Tue, Nov 05, 2024 at 09:14:15PM -0500, Sasha Levin a écrit :
> The patch below does not apply to the v4.19-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> Thanks,
> Sasha

Please try this:

---
From ee0d95090203b7ee4cb1f29c586cd7d0dbf79fff Mon Sep 17 00:00:00 2001
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
index 443726085f6c..832381b812c2 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -233,12 +233,19 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
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
@@ -272,6 +279,7 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
+static inline void tick_dep_init_task(struct task_struct *tsk) { }
 static inline void tick_dep_set_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
diff --git a/kernel/fork.c b/kernel/fork.c
index b65871600507..1fb06d8952bc 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -91,6 +91,7 @@
 #include <linux/kcov.h>
 #include <linux/livepatch.h>
 #include <linux/thread_info.h>
+#include <linux/tick.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1829,6 +1830,7 @@ static __latent_entropy struct task_struct *copy_process(
 	acct_clear_integrals(p);
 
 	posix_cpu_timers_init(p);
+	tick_dep_init_task(p);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
-- 
2.46.0



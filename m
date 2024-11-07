Return-Path: <stable+bounces-91779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A370D9C024E
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FEADB215CB
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 10:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C810B1EBA1B;
	Thu,  7 Nov 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP/941cF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857E41DE4EA;
	Thu,  7 Nov 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975233; cv=none; b=L+tubU9hgzSYZ4NcqgH2L26VUUPuFSUuiDpVISh5JLHDcxa8fyt5O9KIoud5eI6rBQjB+dNRudtnmxvELu81aFTkdxcfCB4e/5rST9sbnbt4wJm4mdCTH5S6RT5BP1goF60RcgXNTPgKjzHpzWd6gwbxeyzGcsz7+j6Dzau8Xm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975233; c=relaxed/simple;
	bh=w7LlA+d3P8tWpqL1R1qmf9z0LDa4pqyuLrV0Uk8F5P8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opUz9OTBtg3zrSYx7viVMR6EI+E2FCaFA7/7Kj61lg0G+ftk2zFvf+SF/qm8mFscG9axpoI26cK5dh9p4PvlJWhLY+kSrUpskW11tXgQZXyUwqliJ0Ts7ULpaxYGk4UaOpKMQ/YCNdrlMQDftxHzVX+RSapAZIClwpNfly7rJOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP/941cF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8EBC4CED2;
	Thu,  7 Nov 2024 10:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730975233;
	bh=w7LlA+d3P8tWpqL1R1qmf9z0LDa4pqyuLrV0Uk8F5P8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eP/941cF+syt8TdVfS5qQgfgNj+beEkbClcA9CLeVPm0+Qv+9fFrpv7ADx4ne9kya
	 fSxgRGC+pBQcgKdDiKfCoelY3kcc0v0krcY0d0v1k/fIc86iN5JyRG/ZDt+nfyutVu
	 PVkvfEw0EacbzcsignpQdB93vNGMF8MbcAwtDQuibrX0B662P0sDTIwZoSNH3crUb1
	 Gs331qaoflK88MxqVayxOEegQq+I233Je6dDyHToVdCu82bHCcwkUIn8JzuK59bVyY
	 oeZ8wj0jaf/9XeXCJurRHTSzc2Et5RqV/IuRzkHenjFGgk2tHmYfzJgmwavwYBBIh8
	 1OFFzDYpagQpw==
Date: Thu, 7 Nov 2024 11:27:10 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, bsegall@google.com,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER
 on clone" failed to apply to v5.4-stable tree
Message-ID: <ZyyV_oFz2cqfB7x0@pavilion.home>
References: <20241106021327.183601-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106021327.183601-1-sashal@kernel.org>

Le Tue, Nov 05, 2024 at 09:13:26PM -0500, Sasha Levin a écrit :
> The patch below does not apply to the v5.4-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> Thanks,
> Sasha

Please try this:

From 6b742b3fa045260c3b13e7747332e9d34ca7bbe9 Mon Sep 17 00:00:00 2001
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
index cf6c92060929..4634af47f8c2 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -244,12 +244,19 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
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
@@ -283,6 +290,7 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
+static inline void tick_dep_init_task(struct task_struct *tsk) { }
 static inline void tick_dep_set_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
diff --git a/kernel/fork.c b/kernel/fork.c
index 1728aa77861c..ce795a61874a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -94,6 +94,7 @@
 #include <linux/livepatch.h>
 #include <linux/thread_info.h>
 #include <linux/stackleak.h>
+#include <linux/tick.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -1956,6 +1957,7 @@ static __latent_entropy struct task_struct *copy_process(
 	acct_clear_integrals(p);
 
 	posix_cputimers_init(&p->posix_cputimers);
+	tick_dep_init_task(p);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
-- 
2.46.0


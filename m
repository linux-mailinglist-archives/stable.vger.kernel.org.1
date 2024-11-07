Return-Path: <stable+bounces-91781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45069C0281
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8E41F231D4
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 10:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8AB1EE039;
	Thu,  7 Nov 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffWFnKme"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4C1EE024;
	Thu,  7 Nov 2024 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730975860; cv=none; b=aVLLjtAm8gdXFenfw+oD+UxRP0ImqyCGnLVf/uxG82bLtea8LUcbIstN4iqrYI43THsti+RP1XUXHO5VUsciVHZqxuAYvDtsOrggV6s9tvnmkpd2nOzCujuvxRxP/Qdq75PmeDaikeD5nQOGh9AUy+1jxKhM0QHJs40IFLnGmpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730975860; c=relaxed/simple;
	bh=IV6NnD8adAnUKMEzmLFpfBCgOY7VG6juo/usQ46euSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHzdDXdcfbqx+YyqlMbAYbxsLsoFwUtxbg7TWnE43DSQyHywD3QvbrZzTavZGGTBmVNfOnFAeEzkm9mhaoZhM+jqbQCioaRxF5vbrb7+IK2be5qanXwsX/1gy07ljAVcaNuXS5eGdAJ5CFKKkct/GRre9NWyjw+eRKRC39zYezs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffWFnKme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42FBC4CED2;
	Thu,  7 Nov 2024 10:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730975860;
	bh=IV6NnD8adAnUKMEzmLFpfBCgOY7VG6juo/usQ46euSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ffWFnKmeJ/Dt99iAM/xE4yEOct4Kt3OpoOAR3j+3P794y/be+bFud4aXqKmvIhCIq
	 vELCBDZX2uPDOyLmgz/nNnufDcKlyGpo6Fu2/DRYq6hPAM203sFn48yARgWWYVvFVA
	 +wV2DTZWRINFLZBvpbGY/Br78c6rfvFYbLUk4cQ6DBoV/TXLjLtcXZ+RkgmN0ha1/t
	 ER8JtCEkWCaIQ27nS8g8D74ihI4Ya2+f6c7kXCbYSOm5KHIn+IqFA5Mq2X9F75D29F
	 Nd28PZKELcLKTbT2XcITnJr+YOw+eHDrz7pgRg+B7WG8dANLCQSA3BABM8KlAfy6D6
	 b19ce+HlLdEkA==
Date: Thu, 7 Nov 2024 11:37:37 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, bsegall@google.com,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER
 on clone" failed to apply to v5.15-stable tree
Message-ID: <ZyyYcdCYZfJfwDty@pavilion.home>
References: <20241106021136.182329-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106021136.182329-1-sashal@kernel.org>

Le Tue, Nov 05, 2024 at 09:11:36PM -0500, Sasha Levin a écrit :
> The patch below does not apply to the v5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> Thanks,
> Sasha

Please try this one instead:

From 806ef66e95663c8fce77a7b9ffb8788b11105307 Mon Sep 17 00:00:00 2001
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
index fec103ae640f..23ffcf8a859c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -97,6 +97,7 @@
 #include <linux/scs.h>
 #include <linux/io_uring.h>
 #include <linux/bpf.h>
+#include <linux/tick.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2126,6 +2127,7 @@ static __latent_entropy struct task_struct *copy_process(
 	acct_clear_integrals(p);
 
 	posix_cputimers_init(&p->posix_cputimers);
+	tick_dep_init_task(p);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
-- 
2.46.0



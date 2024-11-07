Return-Path: <stable+bounces-91783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE96F9C02A8
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 11:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94482281E7C
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 10:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17E1EF94F;
	Thu,  7 Nov 2024 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8OZ3wlc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23631EBFF4;
	Thu,  7 Nov 2024 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730976166; cv=none; b=FOrS2z8DESv+D3bN5TjjLyhisWskdt7x11mk5GSZxYQDVzt43CHNGkEPZReHYHAstQ9VXxmBI+zLOTOtGBVseTNua7AAEpq8T2681YfngzUOf7fvZnV/76zx6lhinxUiiNSKTNuJlOEMhmtPhhahsqfJIkJu4F6hz7l/Y0RPzvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730976166; c=relaxed/simple;
	bh=zRpLMPauPAGsguakIW/QvonIxsET1BLwl9GokVEGwV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UscnuOP0SY8di2oBSuxUov4J13BwQwhVtqu+oBiyspO2l1tQpSk0fChaOvMccTsMcJeR9T01RH3iE7VvjQ4PY2hmNGw3GryNvFe2F2dXn0+9EogX0U4dz38ojuD9qUyH/QZzjo43l7wbdsofC2frF4NhOfzU/p48RhxJStVHtdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8OZ3wlc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00357C4CED5;
	Thu,  7 Nov 2024 10:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730976166;
	bh=zRpLMPauPAGsguakIW/QvonIxsET1BLwl9GokVEGwV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8OZ3wlcajF1rIxpljzudGvrLEbmx5u37+maFP1H89DCtImzheudXJ9KP8hwt0en4
	 BTuWP8KiNnbSWlylUFeQjMN1vkwX1JCQAkCmSjy3SS4OS4N3VpRYZpDvOOPEsH9+DV
	 N0nW4yjp0oGu1o4YEBuZwGmHLSwC+62y2zBLsMt0H5WTTf86WUK+SJFJQEjN5Z2ySz
	 4XqQM5yWzkN+68L6sxJVJLChcYTplT3PW6KKO0OjyGLLPNfBoyqxR3+pPfgHEKqJRA
	 WOolivOhB2caeqtonBa0wZhEieWhRemKVnA44Yihy2mQFS7CmE3LB7/uWfj0pwxZtI
	 XkFzE6GwCqCFA==
Date: Thu, 7 Nov 2024 11:42:43 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, bsegall@google.com,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: FAILED: Patch "posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER
 on clone" failed to apply to v6.6-stable tree
Message-ID: <ZyyZo7cFy0xvfcJr@pavilion.home>
References: <20241106020901.164614-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241106020901.164614-1-sashal@kernel.org>

Le Tue, Nov 05, 2024 at 09:09:00PM -0500, Sasha Levin a écrit :
> The patch below does not apply to the v6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> Thanks,
> Sasha

Please try this one instead:

From eb2b3ebf29a859e788fe1cee9ca67d8e7ee580e9 Mon Sep 17 00:00:00 2001
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
index 32ffbc1c96ba..525937981971 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -99,6 +99,7 @@
 #include <linux/stackprotector.h>
 #include <linux/user_events.h>
 #include <linux/iommu.h>
+#include <linux/tick.h>
 
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2417,6 +2418,7 @@ __latent_entropy struct task_struct *copy_process(
 	acct_clear_integrals(p);
 
 	posix_cputimers_init(&p->posix_cputimers);
+	tick_dep_init_task(p);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
-- 
2.46.0


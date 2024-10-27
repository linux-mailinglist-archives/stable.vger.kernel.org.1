Return-Path: <stable+bounces-88225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9513E9B1CE5
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 10:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E091C20B34
	for <lists+stable@lfdr.de>; Sun, 27 Oct 2024 09:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7B4AD51;
	Sun, 27 Oct 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kBudHpLd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YNIDm0rr"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A88D824BD;
	Sun, 27 Oct 2024 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730022305; cv=none; b=UL1urlqEFQ3ZdgfPmhNRRNYuAIAhptMDDs0EuOFmdvatnDUqMaq6I98XYOVU8Lii7TfLsDLFbrr7EQyRM7GcisVuWHFFfHOY7bHeRs5FmO/voLZTyvO7IltaPk15P3zSYzPMZdKFeBtfE9HkKx8lqB+OfZbbIg2ScIR/AR25fyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730022305; c=relaxed/simple;
	bh=kpGyt5DfEqELmZNEMeSLrL8K07eYoJyYk2e8lQ3vNI0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pyNrgjEx5Og4Rm6z/sz+xgUGSM3M3llznMhfAHZ9LOOmnRBerb03dDjNqJ562q+GZi/0w7NdqEfizy11L0B7QrIYn7Yu2mFiNVA3XuyB5hm4RQnHkVNuXOt8l+A8xlm8ManqT60p7S+uHbyfGgdJjkoT4PJEDVPc61RNTfR0kvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kBudHpLd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YNIDm0rr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 27 Oct 2024 09:45:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730022301;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DD0dSUyqSFCp+Ruij6xJVnsHx+ZvtO/ME1Hf79cnz/s=;
	b=kBudHpLddzyWxVyxXG3fjtTNophb2zp+E41jeFh7dPUurl6GPOr3DRbnUx14CdZBh8mDwV
	FqyglJ2MUtZmHy59RrPq3uIIX6hgfvU2KLz/HyovW0vdt4fciROjk8iwlR9mFEvUubeCSq
	Twr8BpX6nd/TfsEnBbsECfxiZFgEI50b+sh/Zi7GfyYOmhGi3xjoYNAmI8jwuXTtmGH3Rr
	PyAfa5YVZrV6ZijF431pUeeoMZAOEMk0BgtM5IFCGVGtNPJkNHeVIHfS9JcvbAQbO5E1l9
	vVtyGcmVyuiwV1czPZo0L0Ji7O7WOn1o+6tI/grQRZaj9plIWNmHFRKVIe78Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730022301;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DD0dSUyqSFCp+Ruij6xJVnsHx+ZvtO/ME1Hf79cnz/s=;
	b=YNIDm0rrPLPmUGe0zv9zR18FZCMnCyYx1H+G8KhPByqvv7v25UtS3OjZQlOjyrI6EHlY6C
	wGt085D8rmxv9LDw==
From: "tip-bot2 for Benjamin Segall" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER
 on clone
Cc: Ben Segall <bsegall@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, stable@vger.kernel.org,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <xm26o737bq8o.fsf@google.com>
References: <xm26o737bq8o.fsf@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173002230033.1442.372126072824359559.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     b5413156bad91dc2995a5c4eab1b05e56914638a
Gitweb:        https://git.kernel.org/tip/b5413156bad91dc2995a5c4eab1b05e56914638a
Author:        Benjamin Segall <bsegall@google.com>
AuthorDate:    Fri, 25 Oct 2024 18:35:35 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 27 Oct 2024 10:36:04 +01:00

posix-cpu-timers: Clear TICK_DEP_BIT_POSIX_TIMER on clone

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
index 7274463..99c9c5a 100644
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
index 89ceb4a..6fa9fe6 100644
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


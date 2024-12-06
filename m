Return-Path: <stable+bounces-98936-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 762389E677D
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 07:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE3916A8F8
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 06:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795FE1BC9F6;
	Fri,  6 Dec 2024 06:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KvfbEIQ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B711BE23F;
	Fri,  6 Dec 2024 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733468027; cv=none; b=hTfs9EQMdXkI23AfQpfGwd7+CCtMQechMkip5PbwkgKpKaBLFav5BjK3rlx80RMlKVXoIeyx2OWcqgLLrw8IyGVbQfLNK5TmRMW/P7apfUkVIGzWENZHMv3bD8Hg9nYb+lTD2110ZQbyk+RrpStGjEdCk3PaAbXibBWk00sQdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733468027; c=relaxed/simple;
	bh=CDaeCoUeHpxo3y18LCqxxSEsl87PJ3S/StBtK4GaxTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rnWagEQ2qCCmz/u75gVbA2HJ/dbNZvNvGmMIZn9uiNYLx2xTlnzi8CfPk+cjh/QFjtRnzHqncOTELQB9B0QqM+Wj3sSeQQPmAJ76+leaQ3VFt5EPu+gCIbabbDdUuVImlFUJua05NlimFRBx3ruIHmbKGmnIusER5f8aAxjyCLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KvfbEIQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A338C4CEDE;
	Fri,  6 Dec 2024 06:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733468026;
	bh=CDaeCoUeHpxo3y18LCqxxSEsl87PJ3S/StBtK4GaxTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvfbEIQ/fcV9b9xQeekc3yb/G80LZFHTrtnXogP2ubn0h6bpB065xFbxAfJZ0qM/t
	 CumBKaMgMcPZU5NBseRGReUh3PGPzwdsb8ecEZmDeHvo1AC/Mg6QznypvRpg6r88tZ
	 Xat8Y8zGQeBiwaBJid//pPdwSO3OEClcUrwMpCR4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.3
Date: Fri,  6 Dec 2024 07:53:34 +0100
Message-ID: <2024120634-ozone-sincerity-b372@gregkh>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <2024120634-likely-groovy-d26a@gregkh>
References: <2024120634-likely-groovy-d26a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index da6e99309a4d..e81030ec6831 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 2
+SUBLEVEL = 3
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a1c353a62c56..76b27b2a9c56 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4424,7 +4424,8 @@ int wake_up_state(struct task_struct *p, unsigned int state)
  * Perform scheduler related setup for a newly forked process p.
  * p is forked by current.
  *
- * __sched_fork() is basic setup used by init_idle() too:
+ * __sched_fork() is basic setup which is also used by sched_init() to
+ * initialize the boot CPU's idle task.
  */
 static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 {
@@ -7683,8 +7684,6 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	unsigned long flags;
 
-	__sched_fork(0, idle);
-
 	raw_spin_lock_irqsave(&idle->pi_lock, flags);
 	raw_spin_rq_lock(rq);
 
@@ -7699,10 +7698,8 @@ void __init init_idle(struct task_struct *idle, int cpu)
 
 #ifdef CONFIG_SMP
 	/*
-	 * It's possible that init_idle() gets called multiple times on a task,
-	 * in that case do_set_cpus_allowed() will not do the right thing.
-	 *
-	 * And since this is boot we can forgo the serialization.
+	 * No validation and serialization required at boot time and for
+	 * setting up the idle tasks of not yet online CPUs.
 	 */
 	set_cpus_allowed_common(idle, &ac);
 #endif
@@ -8546,6 +8543,7 @@ void __init sched_init(void)
 	 * but because we are the idle thread, we just pick up running again
 	 * when this runqueue becomes "idle".
 	 */
+	__sched_fork(0, current);
 	init_idle(current, smp_processor_id());
 
 	calc_load_update = jiffies + LOAD_FREQ;


Return-Path: <stable+bounces-139796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED83AA9FBC
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F3A53A6AEB
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 22:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF821289375;
	Mon,  5 May 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp6TcLrp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86E828936C;
	Mon,  5 May 2025 22:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483353; cv=none; b=IArxg89xhEhtLAMEPqXECvE2rA9OwwMDgbZhW+51wBAq0+HQ2yQpz5rq68un4q7zNauVA90ZZbd3IhRWguMbUyqCFy8IFV0nTm+JnOvIj6N7RzJ2k1K3sdzTWXa6SQK7ok2zf6gm7oxfP5Ke/ExaV3+UXnnlfhC9I5tnfgX67dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483353; c=relaxed/simple;
	bh=aMJpZbhrk1lyvoxeycNtnIzcxhgtNw6ZUzzuEiCE7OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WythtABK+Vbsli2dEz31KReEY/WUIkqRjrquj4CxVKqt7dqgnpkJ/DiwwYynueEuRgmSNelEHxfvM1h6qPbLfmGku2MiA31hNCS/KcUQtTLw6/y/EbcL52avk9Pe50QdtPVc+PIC7tCBIIqvJc9AON3OQOPXBJLbcsFVniF6dR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp6TcLrp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096DFC4CEE4;
	Mon,  5 May 2025 22:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483353;
	bh=aMJpZbhrk1lyvoxeycNtnIzcxhgtNw6ZUzzuEiCE7OE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fp6TcLrpAt0Yo/GnDtZlH7IIHuwiLuY3f/Px8lWs5XIrVhy6MJET6QRFbOBxrdhh7
	 /5QC+3rzGKnNe4UqMnIabeJAr8zuXh3g5IAnq6dmC9jzllqLzKpjdLh+aiJKnnDwxE
	 qL9j1EAUx/PAIbbOOlRD1ZqNxkYHMVhyKrLuHKSTffNBWEoJaXau/G4bN/sgoQBAmI
	 SUQhgItFFz2wvaXPE77FkPwh8vwql4tPi8rQ1IycvAj4VwUePFhvcN7AYxKHjqrr2q
	 N8Cj+9aA9K8/JVz7pv5jL0J9L4IsYnC/Bh1cCs+ti4yMniAYyKzXvfa/FcgjVmDydl
	 rulRBKTPjQfjw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ryo Takakura <ryotkkr98@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bigeasy@linutronix.de,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	neilb@suse.de,
	kprateek.nayak@amd.com,
	csander@purestorage.com,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.14 049/642] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Mon,  5 May 2025 18:04:25 -0400
Message-Id: <20250505221419.2672473-49-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Ryo Takakura <ryotkkr98@gmail.com>

[ Upstream commit 61c39d8c83e2077f33e0a2c8980a76a7f323f0ce ]

Since:

  0c1d7a2c2d32 ("lockdep: Remove softirq accounting on PREEMPT_RT.")

the wait context test for mutex usage within "in softirq context" fails
as it references @softirq_context:

    | wait context tests |
    --------------------------------------------------------------------------
                                   | rcu  | raw  | spin |mutex |
    --------------------------------------------------------------------------
                 in hardirq context:  ok  |  ok  |  ok  |  ok  |
  in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
                 in softirq context:  ok  |  ok  |  ok  |FAILED|

As a fix, add lockdep map for BH disabled section. This fixes the
issue by letting us catch cases when local_bh_disable() gets called
with preemption disabled where local_lock doesn't get acquired.
In the case of "in softirq context" selftest, local_bh_disable() was
being called with preemption disable as it's early in the boot.

[ boqun: Move the lockdep annotations into __local_bh_*() to avoid false
         positives because of unpaired local_bh_disable() reported by
	 Borislav Petkov and Peter Zijlstra, and make bh_lock_map
	 only exist for PREEMPT_RT. ]

[ mingo: Restored authorship and improved the bh_lock_map definition. ]

Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250321143322.79651-1-boqun.feng@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/softirq.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 4dae6ac2e83fb..513b1945987cc 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -126,6 +126,18 @@ static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static struct lock_class_key bh_lock_key;
+struct lockdep_map bh_lock_map = {
+	.name			= "local_bh",
+	.key			= &bh_lock_key,
+	.wait_type_outer	= LD_WAIT_FREE,
+	.wait_type_inner	= LD_WAIT_CONFIG, /* PREEMPT_RT makes BH preemptible. */
+	.lock_type		= LD_LOCK_PERCPU,
+};
+EXPORT_SYMBOL_GPL(bh_lock_map);
+#endif
+
 /**
  * local_bh_blocked() - Check for idle whether BH processing is blocked
  *
@@ -148,6 +160,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 
 	WARN_ON_ONCE(in_hardirq());
 
+	lock_map_acquire_read(&bh_lock_map);
+
 	/* First entry of a task into a BH disabled section? */
 	if (!current->softirq_disable_cnt) {
 		if (preemptible()) {
@@ -211,6 +225,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 
+	lock_map_release(&bh_lock_map);
+
 	local_irq_save(flags);
 	curcnt = __this_cpu_read(softirq_ctrl.cnt);
 
@@ -261,6 +277,8 @@ static inline void ksoftirqd_run_begin(void)
 /* Counterpart to ksoftirqd_run_begin() */
 static inline void ksoftirqd_run_end(void)
 {
+	/* pairs with the lock_map_acquire_read() in ksoftirqd_run_begin() */
+	lock_map_release(&bh_lock_map);
 	__local_bh_enable(SOFTIRQ_OFFSET, true);
 	WARN_ON_ONCE(in_interrupt());
 	local_irq_enable();
-- 
2.39.5



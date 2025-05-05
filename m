Return-Path: <stable+bounces-141480-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075DEAAB39E
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88AFC7A9876
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B89633F72C;
	Tue,  6 May 2025 00:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5MvtnoD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F972EC016;
	Mon,  5 May 2025 23:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486431; cv=none; b=hSIlg+SOA+Lb+1Nl2keH7NGezyp9ZfJ1DrW/N1yn+/jQ8B/9QWhiY9vcw9rZMLypl1fx7J83N8dIEFC7vIYTl/hY0ljSbvjTinLpU2MsX9nnLSCNlEUG2uimPSQSAyZJpwJYkHKDRewd3XufysP1GM6ymaM2CfJMIHbrpynJTSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486431; c=relaxed/simple;
	bh=+iCTQXefiv7beKZtI1OTYnA/ZeUG5ws+vcTC6+XJFpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XPdDj+Vr4a4sTL65dRk85VLFC0YSQnXQif2Mo+OPD26ECvNpbYBAYrc+FH/cnnl2w5rs60rgJGf7Mgvh38sdPRzWvXQusrbHj6Wi2tu8PiFGdas0SY0MzYFmDXTNH8EVRbqLh6qPKBJYD73J/L8qtUFtwmzupEKwuh8RJozFmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5MvtnoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD81CC4CEE4;
	Mon,  5 May 2025 23:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486431;
	bh=+iCTQXefiv7beKZtI1OTYnA/ZeUG5ws+vcTC6+XJFpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k5MvtnoDrGzkou72QmwLAbxvzT3SlDlzb0BcYZHbf7WZy9PdTDOOvxkFIA0qx44ut
	 TQnqsFnlj3pPc5TPjTDW7Y7ObjQ8zYh1tYo7maS75fE91eaii4V/nEueO0/jTYpkHK
	 RiUU0L249Ixi22VB/MfhCRtJes0gGuSsTdL8vZSvjxondh5lTjLhQ0O0Lk1/XtGpjL
	 V8M4HVKgzDK1ZlTGQSZVH+8nf6NthLvFJPQv7h3ZGLoH66hfv7Lh9K0968acKi8c2E
	 9xilqERCvGCn+wrp0+dTqYpMJhbKwfFOeXeyUqsGDza3iiRTpJB4/1zKScEcH2kVdQ
	 IQQhoqUa8dblA==
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
	peterz@infradead.org,
	tglx@linutronix.de,
	frederic@kernel.org,
	csander@purestorage.com,
	neilb@suse.de,
	kprateek.nayak@amd.com,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 023/212] lockdep: Fix wait context check on softirq for PREEMPT_RT
Date: Mon,  5 May 2025 19:03:15 -0400
Message-Id: <20250505230624.2692522-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
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
index 6665f5cd60cb0..9ab5ca399a990 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -140,6 +140,18 @@ static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
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
@@ -162,6 +174,8 @@ void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 
 	WARN_ON_ONCE(in_hardirq());
 
+	lock_map_acquire_read(&bh_lock_map);
+
 	/* First entry of a task into a BH disabled section? */
 	if (!current->softirq_disable_cnt) {
 		if (preemptible()) {
@@ -225,6 +239,8 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 	WARN_ON_ONCE(in_hardirq());
 	lockdep_assert_irqs_enabled();
 
+	lock_map_release(&bh_lock_map);
+
 	local_irq_save(flags);
 	curcnt = __this_cpu_read(softirq_ctrl.cnt);
 
@@ -275,6 +291,8 @@ static inline void ksoftirqd_run_begin(void)
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



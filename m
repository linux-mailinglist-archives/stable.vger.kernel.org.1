Return-Path: <stable+bounces-141092-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FD9AAB08B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 05:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537424C777B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E571405E9E;
	Mon,  5 May 2025 23:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYG/Heji"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2163C10AC;
	Mon,  5 May 2025 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487437; cv=none; b=uzyYN50e0lwfopqY8OIwAXJ9fzNdCPByk9lHO1nuyaQ6QeAxWsbd+sLNlRfayKNEB+Qsqsv0tcx2/yhQIbDiusLxSOB2cdtw/Tq3ss0Z+e+4F86NJwGsyLg78L39WAV3ZSYH1+SKYimvukIeWnVNq1ytEuAjFKs2Js8xkuzQ+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487437; c=relaxed/simple;
	bh=gigUoykiJHFtsD94irfvEODoT3hgotgeNnEsbNFMLUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WfoMHvrNmiYJ/Tp7mDalWDLRalenA6IEsOVhrnS5xnpIayzQjYfv6wNfFomV9zNeBkOsXIoVp++3gy5Y22U3MeF/vKGK9AHQCL8Bsq94pOwP6k4dlym69gRDGj0tuh0EG1S0CyQJz6eaHWrQiXBq4bA6KDHrknpHcdltYXQlL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYG/Heji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73203C4CEEE;
	Mon,  5 May 2025 23:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487435;
	bh=gigUoykiJHFtsD94irfvEODoT3hgotgeNnEsbNFMLUc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYG/Hejif72+wAhv+a3TR/uFr3hLoRXvq+0Ecxsz9KELDeGpCWpzYuGIssP9VJkSv
	 rb4aGnnTkLRXLJpKOQ7YcgOfmPKyjSRbUP6zBEhy9tcZ/UGIhr1+sU9LbhFMnlBwSY
	 ogXU2NKWLxLN63MSdAj3CJJF4OdycUD+biAs91ub/c8hD/kumjoQnCQYXbhk0ozQzq
	 mWfVw1VSAJU6uKOVjXc6wXZ6epGZTSyONDJKaIT9f2j7Afoz3OS3T1WTcSP/XeYOto
	 tpuNbvLQlBbOfYSMQpUjrZUP5lSaX73Bm6m+7C09CYhhSVHihufDi+nRXKNRa295av
	 jFZA00cKo1eDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	neeraj.upadhyay@kernel.org,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	rcu@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 70/79] rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Mon,  5 May 2025 19:21:42 -0400
Message-Id: <20250505232151.2698893-70-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505232151.2698893-1-sashal@kernel.org>
References: <20250505232151.2698893-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.293
Content-Transfer-Encoding: 8bit

From: Ankur Arora <ankur.a.arora@oracle.com>

[ Upstream commit 83b28cfe796464ebbde1cf7916c126da6d572685 ]

With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
states for read-side critical sections via rcu_all_qs().
One reason why this was needed: lacking preempt-count, the tick
handler has no way of knowing whether it is executing in a
read-side critical section or not.

With (PREEMPT_LAZY=y, PREEMPT_DYNAMIC=n), we get (PREEMPT_COUNT=y,
PREEMPT_RCU=n). In this configuration cond_resched() is a stub and
does not provide quiescent states via rcu_all_qs().
(PREEMPT_RCU=y provides this information via rcu_read_unlock() and
its nesting counter.)

So, use the availability of preempt_count() to report quiescent states
in rcu_flavor_sched_clock_irq().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/rcu/tree_plugin.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2c127d438fe0a..1d9f2831b54ea 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -902,13 +902,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
  */
 static void rcu_flavor_sched_clock_irq(int user)
 {
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
+	if (user || rcu_is_cpu_rrupt_from_idle() ||
+	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
+	      (preempt_count() == HARDIRQ_OFFSET))) {
 
 		/*
 		 * Get here if this CPU took its interrupt from user
-		 * mode or from the idle loop, and if this is not a
-		 * nested interrupt.  In this case, the CPU is in
-		 * a quiescent state, so note it.
+		 * mode, from the idle loop without this being a nested
+		 * interrupt, or while not holding the task preempt count
+		 * (with PREEMPT_COUNT=y). In this case, the CPU is in a
+		 * quiescent state, so note it.
 		 *
 		 * No memory barrier is required here because rcu_qs()
 		 * references only CPU-local variables that other CPUs
-- 
2.39.5



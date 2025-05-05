Return-Path: <stable+bounces-140967-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F77AAAD4A
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1198B9A195F
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0F63CEB8C;
	Mon,  5 May 2025 23:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irXGZByO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A800E2F6B29;
	Mon,  5 May 2025 23:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487074; cv=none; b=YCZi+3FAjY16s8hW42BnQ6B4+0xtVs0k3G8nswda4QJwpi0okwj54n2O4aourPYy7dJ79S9Jb5pnAq7gdt+EGGr5orIztP8oTXQKbmgihU0Hzk+R9en3Mj3ctaciR2hnaqUqJa2BGMUzocUh4ocopMvZ+sL/4mJhPVsv/sfVT/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487074; c=relaxed/simple;
	bh=xSLLz/4eix5InbKfFV8XKKJhByYuDsQyk3B6wkXDwHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oyCicqZr2H+IOUc3IdsNH53iIOWma5EuzqHFBEg0cBRCTNz7+Kq2IhtQ2bdYFvcof/Q+t1qVxTE1x0hx7shxW8AfepJWEXnbIHaEVXbLSaL1M+IQxD3ZtlGwvql8QKBVKbtWTsqLISYUnx+2gynonGlTBStvBPwcK+cZrsDiXeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irXGZByO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C03B6C4CEED;
	Mon,  5 May 2025 23:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487073;
	bh=xSLLz/4eix5InbKfFV8XKKJhByYuDsQyk3B6wkXDwHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irXGZByOeE0NR8B690YMlm6nRyb8bYnDF1GqztQnfVSNyAM822lYSHCS+PS/wKqni
	 UeGifxkE8wko8hKU9w9WjcaUomfO7HOdRnKEkoyERnr0E+epToTdYYos76rqC6lpZy
	 BOYEHy2BbNd8jckcz7EkflQ8YNEz9nbA6EzZibEbDhZtqlew5yL/EaBRh0+kFLXvoD
	 4vBISjRYicvM1Gorh3fsqR7nLocL69BRlfj5IWWwfNeDTfAkqdSzAT4zKXGEs6Yfbf
	 wRpvGXoWswecIuGSLg9De/h6pPdkOR8TO2JqbO+CXm+/4MUoW91f4gIEuo+JQDjbgU
	 U6grwGpxRbXYA==
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
Subject: [PATCH AUTOSEL 5.15 139/153] rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Mon,  5 May 2025 19:13:06 -0400
Message-Id: <20250505231320.2695319-139-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
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
index b48b42d76474e..9e84d603e882e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -945,13 +945,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
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



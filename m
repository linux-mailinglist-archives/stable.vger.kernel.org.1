Return-Path: <stable+bounces-151266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A01ACD4A0
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36CC3A2FCE
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 01:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F166927B4F7;
	Wed,  4 Jun 2025 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uECAgI0z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94A527B4F5;
	Wed,  4 Jun 2025 01:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999240; cv=none; b=EY35g/udcRtE8MePS9+Ec6vM7/CpcMgU1inUBcu/vYiO/yXymWjn7hgRYpwdbjCcHfSJNoQjw6eWAVHARfC8HBWoHI9+/S8423fGHbtDv11XsH4cNmDeKtR1ZVynv+YeQ5ELyk/kQmvqWmwDW4naCJr6kDceFZrsH+aXbGbwRKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999240; c=relaxed/simple;
	bh=zaTAzhTpgjtk7bwXtkeBmwOt+xf/rvku3KtpmQwDBZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hd29kOi3ctudLAKTZcKA/hrlDZ3Yrkcfe9xfKlKOAW2UBqIGfediaffYxeB0zEQ+reuCfSou15ltUYuGzJQddidLpUW57mCutdA9E5uLeqwHh/6sBZIU285vfl2OHT3mlNc+XrE1ONqqAu5N85w7CL/FkMeo0+5LQ3mJSJVFrPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uECAgI0z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523DEC4CEEF;
	Wed,  4 Jun 2025 01:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999240;
	bh=zaTAzhTpgjtk7bwXtkeBmwOt+xf/rvku3KtpmQwDBZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uECAgI0zM0ydKbwsvHV1GI562/JVhVbhvbkMf5yEPH9bqkOWOitYv5GXB8YcriYUe
	 fdBGHSECpwtkgwnYAlYM8nni7L5m72cRTSpAPC1L8hZ6SWf0IDi2KRKR94tlSqwJ+C
	 e2QDGi+R37Qq0pWBQjyPz+T27dm5OOilX6YfuGDpXUGPHPfRHFZvxCPpNkaguzpu62
	 2J8VD/Nqr8+vzYEHdV2uDYkdd1MKB6AvQO6GhbZLqBCqregc/G6oS4PFley8PrCVUy
	 idhQpwJDMVLkIq6EVSOKVJ8aySJgdezQKbwVZWBnoxLIR1ucbC7lD7IlKJlf/1PNkN
	 qd7QnBtWl9Euw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	David Ahern <dsahern@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	clrkwllms@kernel.org,
	rostedt@goodmis.org,
	netdev@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH AUTOSEL 5.4 08/20] ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT
Date: Tue,  3 Jun 2025 21:06:54 -0400
Message-Id: <20250604010706.7395-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010706.7395-1-sashal@kernel.org>
References: <20250604010706.7395-1-sashal@kernel.org>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 1c0829788a6e6e165846b9bedd0b908ef16260b6 ]

The statistics are incremented with raw_cpu_inc() assuming it always
happens with bottom half disabled. Without per-CPU locking in
local_bh_disable() on PREEMPT_RT this is no longer true.

Use this_cpu_inc() on PREEMPT_RT for the increment to not worry about
preemption.

Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://patch.msgid.link/20250512092736.229935-4-bigeasy@linutronix.de
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**Answer: YES** This commit should be backported to stable kernel trees
based on the following analysis: ## Technical Analysis **The Issue:**
The commit fixes a correctness bug in IPv4 routing statistics collection
on PREEMPT_RT kernels. The `RT_CACHE_STAT_INC` macro uses
`raw_cpu_inc()` which assumes preemption is disabled, but this
assumption is violated on PREEMPT_RT systems where many previously non-
preemptible contexts become preemptible. **Code Changes:** The fix is
minimal and surgical: ```c #ifndef CONFIG_PREEMPT_RT #define
RT_CACHE_STAT_INC(field) raw_cpu_inc(rt_cache_stat.field) #else #define
RT_CACHE_STAT_INC(field) this_cpu_inc(rt_cache_stat.field) #endif ```
This conditional compilation ensures that: - Non-PREEMPT_RT systems
maintain existing performance with `raw_cpu_inc()` - PREEMPT_RT systems
get correctness with `this_cpu_inc()` which includes implicit preemption
protection ## Backport Justification **1. Follows Stable Tree
Criteria:** - **Bug Fix:** Corrects statistics corruption on PREEMPT_RT
systems - **Small and Contained:** Only 4 lines changed in a single
macro definition - **Low Risk:** No behavioral change for non-PREEMPT_RT
systems - **No Architectural Changes:** Simple conditional compilation
approach **2. Consistent with Similar Commits:** The change follows the
exact same pattern as Similar Commit #1 and #3 (both marked "Backport
Status: YES"), which fix preemption-related issues in per-CPU
statistics. Like those commits, this addresses scenarios where
`__this_cpu_*` or `raw_cpu_*` operations are called from preemptible
context on PREEMPT_RT. **3. Real User Impact:** - **Affected Systems:**
PREEMPT_RT kernels with IPv4 routing (real-time systems, industrial
applications) - **Symptoms:** Inaccurate routing statistics due to race
conditions during CPU migration - **Debugging Impact:** Could mislead
network troubleshooting efforts **4. Technical Correctness:** Race
conditions can occur when a process is preempted and migrated to another
CPU between reading the per-CPU pointer and incrementing the counter,
leading to lost statistics updates. The `this_cpu_inc()` variant
prevents this by ensuring atomic access to per-CPU data. **5. Minimal
Risk Profile:** - No functional changes to packet forwarding - Zero
impact on non-PREEMPT_RT systems - Follows established kernel patterns
for PREEMPT_RT safety - No performance regression expected This is
exactly the type of targeted correctness fix that stable trees are
designed to include - it addresses a real bug affecting a specific
subset of users with minimal risk to the broader user base.

 net/ipv4/route.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index da280a2df4e66..d173234503f94 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -197,7 +197,11 @@ const __u8 ip_tos2prio[16] = {
 EXPORT_SYMBOL(ip_tos2prio);
 
 static DEFINE_PER_CPU(struct rt_cache_stat, rt_cache_stat);
+#ifndef CONFIG_PREEMPT_RT
 #define RT_CACHE_STAT_INC(field) raw_cpu_inc(rt_cache_stat.field)
+#else
+#define RT_CACHE_STAT_INC(field) this_cpu_inc(rt_cache_stat.field)
+#endif
 
 #ifdef CONFIG_PROC_FS
 static void *rt_cache_seq_start(struct seq_file *seq, loff_t *pos)
-- 
2.39.5



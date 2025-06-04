Return-Path: <stable+bounces-151210-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F16ACD4B9
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EE8C189E2D7
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 01:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD8A846C;
	Wed,  4 Jun 2025 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb3H26nS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C552EAE5;
	Wed,  4 Jun 2025 01:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999147; cv=none; b=ZGJFShJbrOUWNicBwpjwI/Kcp+hwXth9xycgpEU0bAiRiAfMnfhxLPNeCpnNKoQembgcaPf8ecW311SpTRHH8eabklhsLqqQvgzEb563BgjxwVoDtnvGQuH+3bCaFhs+gUTx2yiHBPfgfB5FG3WhQJqaE0MbZbzXwWbgpM5Gljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999147; c=relaxed/simple;
	bh=+Eq8+EIrRD1Mi/Rf//1lF1Ficl+qxh2LHxgD57bVrY8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S29GDCsv0JVVJbUCRI5N5XHqS3WSN6F/ffrQNfBRZOfuOxZ//Usa+yNQkNEgLc61CXNQ4zfFFp4Ei/WaLeCfkkewdSPIWt3wFyBCJWzyiik4TwMg8TOouD21jYTg7WLKTp0rx44WNQLUgU6QlDdHv9A7StCg+w1ivsRVNDICuvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb3H26nS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1900C4CEEF;
	Wed,  4 Jun 2025 01:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999147;
	bh=+Eq8+EIrRD1Mi/Rf//1lF1Ficl+qxh2LHxgD57bVrY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jb3H26nS4MD1/HoNTb4l5uH175D0xAjBKCCWBdGRfXeNpy2rq/9lnKAQUMeM5cnp1
	 0Gh2y3Tnx47MSneIcLgAhYYXw0s6ZxRsRJQTgnXuiuVAxZnWXsYi4FIEy00ZJNrUaI
	 gZGeW2wkdif+cWkq79O0v42xCRPyp6nFqQORS1ktJj6yY7h5BzGPXDiP1VK4E7I0Yc
	 LRPB+dDq/iS7aHkgBvQFOGJda1i99osqYzM7tMQSL25Dz9WiIoKOEMoOTDOQQp6mSo
	 WrVYM4LlJV/ryEzOm9xSlccu13PoIq67iUJhhQh1BqUEe22KiBVAryZARbPBXVa87l
	 KAPQDxObvSPnA==
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
Subject: [PATCH AUTOSEL 5.15 12/33] ipv4/route: Use this_cpu_inc() for stats on PREEMPT_RT
Date: Tue,  3 Jun 2025 21:05:03 -0400
Message-Id: <20250604010524.6091-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010524.6091-1-sashal@kernel.org>
References: <20250604010524.6091-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.184
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
index a4884d434038e..cbc584c386e9e 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -200,7 +200,11 @@ const __u8 ip_tos2prio[16] = {
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



Return-Path: <stable+bounces-231230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sK/EF1yJymn09gUAu9opvQ
	(envelope-from <stable+bounces-231230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:31:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA1435CE52
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 16:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 158A4305FF7D
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF673D7D92;
	Mon, 30 Mar 2026 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/EemMjS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7373A6B6C
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 14:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774880289; cv=none; b=cpwJQyDNx43W42AxDbmDly0/ba8RnaQB7Wk27SbdTMmJLbsBSKXUYsppVfxFaW685g9BsGL2aAHoyokFlKSLC7d+59alR6piTyz4ZgeYjR1xUqx2xrJ+miffoJqrmVnspDsuwcICBuNJZOkWy4HpoGDs0YcHMXmUHSSU709Duc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774880289; c=relaxed/simple;
	bh=vSGD07/8t2rBz+mRcELw9Rz9zD2SB/EfU5sdzuJHmJo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YV3zNA5eh8U7hYB1vExN9DC3PeJwpeZ3wH82B2xmAgPdFuywOinn1pafS/ZA8jm15IX24yt6I3J4566H3R/CAyuMeNBjxcxE0/XPlrzqnQIx5N0jB1FtKlzRhVCnoBsO1fFzApfqjpgcy7CjH70gD/rOMd+8FK0X8X3upxOjjP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r/EemMjS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29262C4CEF7;
	Mon, 30 Mar 2026 14:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880289;
	bh=vSGD07/8t2rBz+mRcELw9Rz9zD2SB/EfU5sdzuJHmJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r/EemMjSDI0+o1sCh6b6XLZ2lUCLnxmKpX++uIEFg/i7tEAkuPydNKboeCQUoPm5c
	 X/7KDkY0C0QTk5MX2E7WimIHTNfIrVxMEZXtHYTXBclZbddEQWSqeCYxJj4ITwQVf1
	 pb+8z4qUGGQWGveN4/i3OjcSF2FzCCz8vB0PzdON0A0xhnEpybG7EEC+mE6jTrtzEf
	 ImJLNNWTrOJobnEONLi2IfaVY2Bddko1D3Q/iLTZlhHtbr32v4OhP1TqXOm2jhGwmo
	 MBfKUCLvbgJ4nDfuXpYn/mjnBwRx7p53AqECHG95gcFQyU5GpMCqXhbX93qw1cIxS4
	 qEMU7sR52HWcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] tracing: Switch trace_osnoise.c code over to use guard() and __free()
Date: Mon, 30 Mar 2026 10:18:05 -0400
Message-ID: <20260330141806.817242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026032952-shredding-snorkel-3530@gregkh>
References: <2026032952-shredding-snorkel-3530@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231230-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,efficios.com:email,infradead.org:email,goodmis.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 5CA1435CE52
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 930d2b32c0af6895ba4c6ca6404e7f7b6dc214ed ]

The osnoise_hotplug_workfn() grabs two mutexes and cpu_read_lock(). It has
various gotos to handle unlocking them. Switch them over to guard() and
let the compiler worry about it.

The osnoise_cpus_read() has a temporary mask_str allocated and there's
some gotos to make sure it gets freed on error paths. Switch that over to
__free() to let the compiler worry about it.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/20241225222931.517329690@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 1f9885732248 ("tracing: Fix potential deadlock in cpu hotplug with osnoise")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_osnoise.c | 40 ++++++++++++------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 216247913980e..412ca1efa956e 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2099,26 +2099,21 @@ static void osnoise_hotplug_workfn(struct work_struct *dummy)
 {
 	unsigned int cpu = smp_processor_id();
 
-	mutex_lock(&trace_types_lock);
+	guard(mutex)(&trace_types_lock);
 
 	if (!osnoise_has_registered_instances())
-		goto out_unlock_trace;
+		return;
 
-	mutex_lock(&interface_lock);
-	cpus_read_lock();
+	guard(mutex)(&interface_lock);
+	guard(cpus_read_lock)();
 
 	if (!cpu_online(cpu))
-		goto out_unlock;
+		return;
+
 	if (!cpumask_test_cpu(cpu, &osnoise_cpumask))
-		goto out_unlock;
+		return;
 
 	start_kthread(cpu);
-
-out_unlock:
-	cpus_read_unlock();
-	mutex_unlock(&interface_lock);
-out_unlock_trace:
-	mutex_unlock(&trace_types_lock);
 }
 
 static DECLARE_WORK(osnoise_hotplug_work, osnoise_hotplug_workfn);
@@ -2316,31 +2311,22 @@ static ssize_t
 osnoise_cpus_read(struct file *filp, char __user *ubuf, size_t count,
 		  loff_t *ppos)
 {
-	char *mask_str;
+	char *mask_str __free(kfree) = NULL;
 	int len;
 
-	mutex_lock(&interface_lock);
+	guard(mutex)(&interface_lock);
 
 	len = snprintf(NULL, 0, "%*pbl\n", cpumask_pr_args(&osnoise_cpumask)) + 1;
 	mask_str = kmalloc(len, GFP_KERNEL);
-	if (!mask_str) {
-		count = -ENOMEM;
-		goto out_unlock;
-	}
+	if (!mask_str)
+		return -ENOMEM;
 
 	len = snprintf(mask_str, len, "%*pbl\n", cpumask_pr_args(&osnoise_cpumask));
-	if (len >= count) {
-		count = -EINVAL;
-		goto out_free;
-	}
+	if (len >= count)
+		return -EINVAL;
 
 	count = simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
 
-out_free:
-	kfree(mask_str);
-out_unlock:
-	mutex_unlock(&interface_lock);
-
 	return count;
 }
 
-- 
2.53.0



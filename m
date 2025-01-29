Return-Path: <stable+bounces-111182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE6CA2207B
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 16:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2173A7D8D
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 15:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C6A1DDA17;
	Wed, 29 Jan 2025 15:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b="ZRtv0hsi"
X-Original-To: stable@vger.kernel.org
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0101DAC9C
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 15:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738164835; cv=none; b=BWnjeGh+CaeA+7LrzeqaFzbQXkWoEFxC17On7H26E/KRjZ+eQ3XjGylWdO/JMn60Nk1ufHCJyBbECx6PEXwwk4KGSa+xyrlEvSaQ2kc1XfVil7qXkp299Ph5paEFb5xJVYdCyhgXwdiyfX2r+eKcUp/z9P7TzHB0djfKnD5AaBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738164835; c=relaxed/simple;
	bh=CbuHinQHOlhIHuit6tKHJw+70mtv7ZDDYwOdOt5vrTM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Je0OGX+PC6c9SiEDnctihSws0jnH7MV8iQTeXEZFhTDviNnlKmiGRfFQOIfJwNSVC16M1RPw7eDXsvmRowx2oT1t9Nsv9UQrr2UDZkh2pamtVVHCL6corTqBmVmEBA8V/EuDD/ycR3ZhhXrpA7qxBXV7alK5vL5icNawlaQdroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=florian.bezdeka@siemens.com header.b=ZRtv0hsi; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202501291533418574514b09b57b4e62
        for <stable@vger.kernel.org>;
        Wed, 29 Jan 2025 16:33:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=FGViqN3IYekN9fhckmenjv0tHD9Ju/IGnV0yXeYlqaE=;
 b=ZRtv0hsiaZTEaVRJVf4flW4+9JmnICfZXIPD0PemuvkBjCsiIS7U+20Dt3L+0f1WbCJS8n
 l3dXTz4LUPdDfywXBTnTx2XvZmC62wBrGwFpz3MXaJ3VtD9Z7LQgYrIWMRvYb9pRUn5znxkN
 dd2hEcZKhEt/lLVaQzLE806RciaA8uFf54JoSLWS3Su5N4FgC7EdzdKnrZWlbhm1HgCsclR/
 bhRecJSTVi8LlsTDgBQlur/H7mC7cpSNyTVPG4ZBaQGqeGMn38gwaLvKsGuJs0E1y5WAcK7O
 GCY4bqhbcD9/iUWrJbFX5fBRSO8mIxP4XTjZwVIn8gIVyWH2YD8XbwvA==;
From: Florian Bezdeka <florian.bezdeka@siemens.com>
To: stable@vger.kernel.org
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Felix Moessbauer <felix.moessbauer@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>
Subject: [PATCH 6.1] softirq: Allow raising SCHED_SOFTIRQ from SMP-call-function on RT kernel
Date: Wed, 29 Jan 2025 16:32:26 +0100
Message-Id: <20250129153226.818485-1-florian.bezdeka@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer

From: K Prateek Nayak <kprateek.nayak@amd.com>

commit 6675ce20046d149e1e1ffe7e9577947dee17aad5 upstream.

do_softirq_post_smp_call_flush() on PREEMPT_RT kernels carries a
WARN_ON_ONCE() for any SOFTIRQ being raised from an SMP-call-function.
Since do_softirq_post_smp_call_flush() is called with preempt disabled,
raising a SOFTIRQ during flush_smp_call_function_queue() can lead to
longer preempt disabled sections.

Since commit b2a02fc43a1f ("smp: Optimize
send_call_function_single_ipi()") IPIs to an idle CPU in
TIF_POLLING_NRFLAG mode can be optimized out by instead setting
TIF_NEED_RESCHED bit in idle task's thread_info and relying on the
flush_smp_call_function_queue() in the idle-exit path to run the
SMP-call-function.

To trigger an idle load balancing, the scheduler queues
nohz_csd_function() responsible for triggering an idle load balancing on
a target nohz idle CPU and sends an IPI. Only now, this IPI is optimized
out and the SMP-call-function is executed from
flush_smp_call_function_queue() in do_idle() which can raise a
SCHED_SOFTIRQ to trigger the balancing.

So far, this went undetected since, the need_resched() check in
nohz_csd_function() would make it bail out of idle load balancing early
as the idle thread does not clear TIF_POLLING_NRFLAG before calling
flush_smp_call_function_queue(). The need_resched() check was added with
the intent to catch a new task wakeup, however, it has recently
discovered to be unnecessary and will be removed in the subsequent
commit after which nohz_csd_function() can raise a SCHED_SOFTIRQ from
flush_smp_call_function_queue() to trigger an idle load balance on an
idle target in TIF_POLLING_NRFLAG mode.

nohz_csd_function() bails out early if "idle_cpu()" check for the
target CPU, and does not lock the target CPU's rq until the very end,
once it has found tasks to run on the CPU and will not inhibit the
wakeup of, or running of a newly woken up higher priority task. Account
for this and prevent a WARN_ON_ONCE() when SCHED_SOFTIRQ is raised from
flush_smp_call_function_queue().

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241119054432.6405-2-kprateek.nayak@amd.com
Tested-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
---

Newer stable branches (6.12, 6.6) got this already, 5.10 and lower are
not affected.

The warning triggered for SCHED_SOFTIRQ under high network load while
testing.

 kernel/softirq.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index a47396161843..6665f5cd60cb 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -294,17 +294,24 @@ static inline void invoke_softirq(void)
 		wakeup_softirqd();
 }
 
+#define SCHED_SOFTIRQ_MASK	BIT(SCHED_SOFTIRQ)
+
 /*
  * flush_smp_call_function_queue() can raise a soft interrupt in a function
- * call. On RT kernels this is undesired and the only known functionality
- * in the block layer which does this is disabled on RT. If soft interrupts
- * get raised which haven't been raised before the flush, warn so it can be
+ * call. On RT kernels this is undesired and the only known functionalities
+ * are in the block layer which is disabled on RT, and in the scheduler for
+ * idle load balancing. If soft interrupts get raised which haven't been
+ * raised before the flush, warn if it is not a SCHED_SOFTIRQ so it can be
  * investigated.
  */
 void do_softirq_post_smp_call_flush(unsigned int was_pending)
 {
-	if (WARN_ON_ONCE(was_pending != local_softirq_pending()))
+	unsigned int is_pending = local_softirq_pending();
+
+	if (unlikely(was_pending != is_pending)) {
+		WARN_ON_ONCE(was_pending != (is_pending & ~SCHED_SOFTIRQ_MASK));
 		invoke_softirq();
+	}
 }
 
 #else /* CONFIG_PREEMPT_RT */
-- 
2.39.5



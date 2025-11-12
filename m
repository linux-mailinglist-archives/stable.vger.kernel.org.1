Return-Path: <stable+bounces-194563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FDDC506BE
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 04:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5BF5F4E3BAF
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 03:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886E02C0F6C;
	Wed, 12 Nov 2025 03:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="LlHxg1bW"
X-Original-To: stable@vger.kernel.org
Received: from sonic306-21.consmr.mail.sg3.yahoo.com (sonic306-21.consmr.mail.sg3.yahoo.com [106.10.241.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D6A186294
	for <stable@vger.kernel.org>; Wed, 12 Nov 2025 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.241.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762918613; cv=none; b=Ln/T7WyrxDyIp8XupLk0V5C4usrEkqBwZQe/HpRJo/E6tUGzEb2HlyhnbbEVG6xQrPaC2TEtqcrYW6RNvhrxFNvVfGR8bIqBFdTc7v6BGKpV8knb+xuKJ12EkwdfGUveCNK8NYx9bErMXxFlhVjDliX0E7ZFSh4wV7T17696kA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762918613; c=relaxed/simple;
	bh=Bqc5MWVXAYPapWswck3KTvUFUUcE64qQzbuAoQzW7Rc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dim8vdXCMZ5ebpwywDrrXG9UlJm5m2Lm97pLRgntkpamYhNJH9u+2nJt3m4NrQiBu7Zld+/V3eq/BFSYYoVECswusEINne3gFu48Ihwcj5S5QM4KnR+QeDHporWz3eGsVM1e/nOF77Nd17NziYwKjGCB3vEXjoyqGeSDED6o4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=LlHxg1bW; arc=none smtp.client-ip=106.10.241.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762918607; bh=DfqdO3iXrWbO4uBssqKRQ276sSUPpFPYITqgJr3Z2C8=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=LlHxg1bWcSbI+VAxGejqxPLeGHcagWnWnErC/V8jxBB35u3GTMxToEDlOuo7W7+d7SLORuCjnIpXR4lwzWnbXEX7fypl2O2wGY+EEYXzBrJNJ3hZgdHUXQggsF9CwcKuF10bAdaiF87jZT4cljnqlQZCXOyLo3DX0eRcBwhFLyV+5UOKPOyO1EHx9RRfPje9pkNeacHkiAufqelIX1LV7E8dllIrCUndJEc4ZOSeO6y2PaZM3T6gEXV2lz0DimVwoD+ecdytmQ1E8bhoNb63sqxQLhcfLZkuz4BATRbcrgJEKuWYbgp0uMsZ90+eNz69pENlIPkgmdhsOf4V7glb2Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1762918607; bh=uNsFwpeW+PBW8uGA5uy7eP84rRsB8Mkhy9hkkCQ0xir=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=im3qSR/JPz8NZ3dEoWnxnJ4HDxhQos/L2Cq0TlyawTkxlOMGwXIbmJE7xxvb2GD1OmdmjUXgStQu77rHQoW4gu+yOIi9ce1VJg+dSPwU0xkxr1G3dgGrEm4svdTqcBfxdrXIz8C0YiZX/I78bxhywk53V8jQSGb7G3l7V9pfqFwO5Kf1o3KXh5ZbOJXLtTlc3uWmHFWPHommh0r7f5VJe0lY5K3XQN9p9KLu4VERn4ocFKRf5jqy80GYueIKs4HR/wT92gfOZ+CBmexwBCUqbvZR10AfPig7lpLX5Z1HjaiRh71wpUvhwYmi2XAC0WQE65eo67jX9zKF82mxm7Bbnw==
X-YMail-OSG: lzMZSl4VM1niLCJYY3BgUt_8IEKYN5oBRWuDUf7w1ZnLO43pw5Q138hlPsnIj.r
 RB5NEfOiVsDVFEUMIyF51dRkYRBzY6sulmfu5ZyefMNOKBTlt6S3iiFR5VsECRTVTDugiRzzv6UW
 m6mNjf3QYPMTxgy.UrIXm7INscsAJvGxMGuhV1mDtkCIsyrhnnbfZwUV.LbLW2Yj4tAPycIX_IjP
 pzg9hCy9Q08lBVk6018P0vSxDWlCRecreEMum9alhvDv_cHqcpcmzELBKEluxgSHIZw0o3Sg0ZDG
 Mpo2o1uHZSPnVhVZGeQFDPv2xcw8.9HozE9OcaPfpV6rypOJuvtvjWyfKXI3ZWIzRd2W5mhNJ7o0
 0TGqkvSwiaHXftlXKUumV.eWErhqhYSzdA7ceT0iQJbBhOicxBteAdKtwrNjA3_iJLr29ssva5aF
 WnFAcb5KSjoxvNLI.h_rtW1IzcG4_yBTmXUWfIr0YuSkovtMM7wErvijQJAfvg3Y4lL4tWeh.G2C
 SUrEueNjqPZjZpGith6OI_eM4JcMe.I9xjwTKIcX57lVv73.H8SLBQ3FdyreQQ7TJGUmoEoo6Bxi
 w8k3ZnRCOYmr5hptHnMK94wYE0mPTxbpSG1WHgkocpsF..1bFP12Dy1rCf.fmpZUZww78KUxQw.m
 5tKYB7HTglI7ARCzCLsWE0GerRK5vRFJz.mWlvJ1vVkJ.TGJBTD2ZWmvONvuTIitQYNOFuTorzPB
 otsTEf02mrnwq93Yil9Jad0Ac55gwmo2gFyg0eS9RDcyPXZhTt_mDRbg0ojx0.22y1YeBPdY468N
 9At9Dw7s8DEX21z149SEtu.vnKLkPrB0yXgSdoPZ2DQE6cqA2ELy.6F4WglLLWYqFJ_RScXDhg..
 LbMMD9jvXxQCv0sc9B5JJSm3V9UkiRZL6z_sYP5wfTclvXncpB5NfQm0oFUiuw4R2hqtFOXh_IEJ
 Q7pkoiOgA.b2Ze3QoF7P2qDxKHGF3wmW_bvL59bOMvkkeVA9l66YS5lV6hJvS3tiKX4DEwkJN6NC
 qrOsIo.ev6V2hrHBwFtP1F5jf_5k9XJNFDz.Sx1urEuhlaxaR9nll6.Jf0GuoCZenvjf2kciot2C
 HQMmjLWd0WrKU_xrk2aLrr2EDjPIYabaRco.9T.dcSYn9EII1MnWkqQ6A1kUBpl_.hCJHqroKrhq
 UmX9GVrOzHYUbBo9NzuQi20BmznYqRz8zyeMFLJ1il0U3o5CsLycI4k2pi55QxmQ2dXDDDJUitwG
 g12fbtxM6R5f2TEV9Bu0soTlw.nlmjqE0TaxUgHLQC70HQa.gdaLmAUbg211jOMQS.FC0_K25tu1
 EvUAaNuLQTrbhJLD5VvGc9NGqsJjFAgroVyItsxRJEFXlePZa_bKS3ItlP4i8sc6wZvgU7HNTS0X
 .vceOdfpkNDIeVkjQd9KOl7p1c2isEHSQ2Rr72M5NqDm4610roOsqNau.uZ6q8WRQmn88QONhvxb
 f5Eb_cEn3nLq1VBm4oBclRuN3OcCsIqZrk4Pgjo_O83Tv7EqTfjbuFTkaDe.jJmeqNV9UvUZKkVq
 sxih8dcCx_KZDDfQqZMQ4z89lEBTgfc5fHgztlCD_7spoC2SIr_u6ID_kgr2Lknm5pkxsamTThmq
 ZQHxEnrVfoDYGErv_Dx3ppSaTirqeCpUi3TJXTEo.i4K8sgNBpQ2U76XQf9M0t2xGvQ0Vfpcm6vD
 g5S97u0Sb9UkCAsDOsGIO..6hSalVolsadmHI3XmeCVKamwf_Dh5xJ5mfZEmrcA_Ec.993GUwq4P
 CqqdSw5_IlIQEHErPe7qvUJDT437tdxkAEPqvc_V5bW1or8iHq2MMGouwDgc0bX9SAzO7RCank_u
 3GuCDbyq1fmfPD3CDNjAUa.wSLx4rv0GYHMi1zCw.x2NEPzdAh6IQOMqDiuYQDl.uC1tgRCJ0SaU
 S9HQIVHbfoUXjew3Dp4m63cQaLgKljZLpqFXzzi4UraCDOjgc0BIDb2jrMBgTlnTpV4.BolboaY.
 cN8z5D9D0zNVDwxuhfn.hks9gM0OWF1syu3YuK0xMfWbT4SSxWW2uD6MZ6QhnnE2K4L2740JQwx2
 yWy_UJZR1_FZTu7B9QSrtcEdPp26v4aXitAgDE0qoc.8yG09HPKZub46.1tpnmx1AchO9iz5FkKe
 faO_4iNrrKXBHFnRH_HeRkmaJ0Aa9_PIvf01cjhVz5bcnNKkhOBiwhNI8ubDgxrPt4oM_L3o6war
 UovwWm5FxvDWY2m.xbwwCqNswM9880olIO2TgxSzf03AxfpcxvXP.rUiEwyx2OS5Y48tkeXf4MQp
 dlqEKhyW4sSLrJ0ZsdzRiNJrPfn1Hn6iRT0Us
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: 597644d1-cd42-43a9-bfc7-eb4b5b6dfa75
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.sg3.yahoo.com with HTTP; Wed, 12 Nov 2025 03:36:47 +0000
Received: by hermes--production-ne1-55f4cd58bd-xpw5m (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID e4690b395d94bf0002e45a0b77724bf8;
          Wed, 12 Nov 2025 03:16:28 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: jstultz@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	sumanth.gavini@yahoo.com,
	tglx@linutronix.de,
	clingutla@codeaurora.org,
	mingo@kernel.org,
	sashal@kernel.org,
	boqun.feng@gmail.com,
	gregkh@linuxfoundation.org,
	ryotkkr98@gmail.com,
	kprateek.nayak@amd.com
Cc: elavila@google.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH V2 6.1] softirq: Add trace points for tasklet entry/exit
Date: Tue, 11 Nov 2025 21:16:20 -0600
Message-ID: <20251112031620.121107-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANDhNCq_11zO4SNWsYzxOeDuwN5Ogrq9s4B9PVJ=mkx_v8RT9Q@mail.gmail.com>
References: <CANDhNCq_11zO4SNWsYzxOeDuwN5Ogrq9s4B9PVJ=mkx_v8RT9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f4bf3ca2e5cba655824b6e0893a98dfb33ed24e5 upstream.

Tasklets are supposed to finish their work quickly and should not block the
current running process, but it is not guaranteed that they do so.

Currently softirq_entry/exit can be used to analyse the total tasklets
execution time, but that's not helpful to track individual tasklets
execution time. That makes it hard to identify tasklet functions, which
take more time than expected.

Add tasklet_entry/exit trace point support to track individual tasklet
execution.

Trivial usage example:
   # echo 1 > /sys/kernel/debug/tracing/events/irq/tasklet_entry/enable
   # echo 1 > /sys/kernel/debug/tracing/events/irq/tasklet_exit/enable
   # cat /sys/kernel/debug/tracing/trace
 # tracer: nop
 #
 # entries-in-buffer/entries-written: 4/4   #P:4
 #
 #                                _-----=> irqs-off/BH-disabled
 #                               / _----=> need-resched
 #                              | / _---=> hardirq/softirq
 #                              || / _--=> preempt-depth
 #                              ||| / _-=> migrate-disable
 #                              |||| /     delay
 #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
 #              | |         |   |||||     |         |
           <idle>-0       [003] ..s1.   314.011428: tasklet_entry: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
           <idle>-0       [003] ..s1.   314.011432: tasklet_exit: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
           <idle>-0       [003] ..s1.   314.017369: tasklet_entry: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func
           <idle>-0       [003] ..s1.   314.017371: tasklet_exit: tasklet=0xffffa01ef8db2740 function=tcp_tasklet_func

Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>
Signed-off-by: J. Avila <elavila@google.com>
Signed-off-by: John Stultz <jstultz@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://lore.kernel.org/r/20230407230526.1685443-1-jstultz@google.com

[elavila: Port to android-mainline]
[jstultz: Rebased to upstream, cut unused trace points, added
 comments for the tracepoints, reworded commit]

The intention is to keep the stable branch in sync with upstream fixes
and improve observability without introducing new functionality.

Signed-off-by: Sumanth Gavini <sumanth.gavini@yahoo.com>

Changes in V2:
- No code changes
- Link to V1: https://lore.kernel.org/all/20250812161755.609600-1-sumanth.gavini@yahoo.com/
- Updated the comment msg before the signed-off-by
---
 include/trace/events/irq.h | 47 ++++++++++++++++++++++++++++++++++++++
 kernel/softirq.c           |  9 ++++++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/irq.h b/include/trace/events/irq.h
index eeceafaaea4c..a07b4607b663 100644
--- a/include/trace/events/irq.h
+++ b/include/trace/events/irq.h
@@ -160,6 +160,53 @@ DEFINE_EVENT(softirq, softirq_raise,
 	TP_ARGS(vec_nr)
 );
 
+DECLARE_EVENT_CLASS(tasklet,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func),
+
+	TP_STRUCT__entry(
+		__field(	void *,	tasklet)
+		__field(	void *,	func)
+	),
+
+	TP_fast_assign(
+		__entry->tasklet = t;
+		__entry->func = func;
+	),
+
+	TP_printk("tasklet=%ps function=%ps", __entry->tasklet, __entry->func)
+);
+
+/**
+ * tasklet_entry - called immediately before the tasklet is run
+ * @t: tasklet pointer
+ * @func: tasklet callback or function being run
+ *
+ * Used to find individual tasklet execution time
+ */
+DEFINE_EVENT(tasklet, tasklet_entry,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func)
+);
+
+/**
+ * tasklet_exit - called immediately after the tasklet is run
+ * @t: tasklet pointer
+ * @func: tasklet callback or function being run
+ *
+ * Used to find individual tasklet execution time
+ */
+DEFINE_EVENT(tasklet, tasklet_exit,
+
+	TP_PROTO(struct tasklet_struct *t, void *func),
+
+	TP_ARGS(t, func)
+);
+
 #endif /*  _TRACE_IRQ_H */
 
 /* This part must be outside protection */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 9ab5ca399a99..fadc6bbda27b 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -822,10 +822,15 @@ static void tasklet_action_common(struct softirq_action *a,
 		if (tasklet_trylock(t)) {
 			if (!atomic_read(&t->count)) {
 				if (tasklet_clear_sched(t)) {
-					if (t->use_callback)
+					if (t->use_callback) {
+						trace_tasklet_entry(t, t->callback);
 						t->callback(t);
-					else
+						trace_tasklet_exit(t, t->callback);
+					} else {
+						trace_tasklet_entry(t, t->func);
 						t->func(t->data);
+						trace_tasklet_exit(t, t->func);
+					}
 				}
 				tasklet_unlock(t);
 				continue;
-- 
2.43.0



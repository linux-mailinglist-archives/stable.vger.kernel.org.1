Return-Path: <stable+bounces-211443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFtcJvNvdGme5gAAu9opvQ
	(envelope-from <stable+bounces-211443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 08:08:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 170707CC54
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 08:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E1CF130041FD
	for <lists+stable@lfdr.de>; Sat, 24 Jan 2026 07:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A3E25B1C7;
	Sat, 24 Jan 2026 07:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xl7/qPlD"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D66C1E1DEC
	for <stable@vger.kernel.org>; Sat, 24 Jan 2026 07:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769238510; cv=none; b=H7AFWpSzOi+yRCKMX6ps0YkbV7rAAkmnWfXNZU0geqmACjsJLRFH1JSERBT0olwTAVP4kuvcdrPeOf/er2Xz/y6TC6knZYXiCffxAPufspSfyGS1dv1+WR5rcqvtcIM0lzrqOlMKlMImPB2kilojpnbofJ1GiO46+6otknylqRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769238510; c=relaxed/simple;
	bh=f0WroCkTqRKE2T125f7PZut/lKVaRERWCDmHSoTNRxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPcnl/p4pOlp369QzFZol3Zmy/ZpO3Az6optHKKS3jvZyWtyvRUDYnXryI6aSeRMDD/FMU1uJ53DzjhA5+VpqUepI+PVtBbMSJr0xvBtb1sSEvev7yaG5O+F5Z6/X6yWM/UaOMYfotcfjpN8YrpHpiVbMb6he+FEw7xKWBtm52g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xl7/qPlD; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4694479eec.0
        for <stable@vger.kernel.org>; Fri, 23 Jan 2026 23:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769238508; x=1769843308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAlcDf31qBBwSv93L3Z4uMSzJzYFnwNA3ebbhkgX8oI=;
        b=Xl7/qPlD1uUQQYMO1kMG0uZs/0fn0BwIUVHH03domQk+oe2StTfDKMDPfor37Gk1O3
         0pA6H7k/2xNdYTeRnyLG1V1WM50SZtyBvHuCedGtp5Uu7bnVge0a2BsfL7Zbv+aIaJ/n
         xyGgMcyGmbr/o+0O/q6iUStJ0fxI4okjDmttv28vCrtzmhN13LS4b0sFlna0vVppvaQc
         MTwI+KRvPFrkSRM5ycPydQ470eCpWjHX5VgHJ23ajXc4xHr3U1kSavcOYgZTu4H1yujq
         QmK8a/+ncbi2xMrfQkzqVedOzyX8xGHtSs1hfZmrFejIgTfnRLSQsE8xZ//Dh8gMo5UP
         sDbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769238508; x=1769843308;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iAlcDf31qBBwSv93L3Z4uMSzJzYFnwNA3ebbhkgX8oI=;
        b=N7Q79HLS4iPYPNcnte8+doBVOLOsFi16VQ82tRQ/5Q/ixpJzqDNAXUDK4Y4YrWiAfo
         3iZVmZo5zM7d5TnrIu6kJCijst+w7KOXlKAYaQFRmcJQJqyCrfDmF8Maiq2RirCFI1b+
         XUfD/46jDcTTmu1fMDPIavqhnsKwhz2wUx0jYaTcqUjaGKho3uQilWodWSbq67TPtxo6
         H63hOD/+9NK3kX6xaKcka4mmh00HgFpiDJdPKeyQBW65z7u/RHAo0LeFrC6HIzpHT/nX
         aqNV8CKHuUvA/lD+e7lTa2Gj8wopqRdReIns7TkxmFUos96lB0IGEkKB858ozVocD1A5
         yd7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzorweKKf1f7V/ZDiSSam/fo+IO0fTe70Np6LKdgiCUID9FZYoJh60sTqSjr80Ouz9pNiP//A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm4IM8d9NtT3VV8tv9KWFfNPL2rPh2Y5XUkP7AnF+9BO3cFNwx
	5JBrsks9jV0rc7GGgdEvRnD24Gz2w+PzEgI5b5MxFrPdAeiC3NOYp3GfD2CzQQ==
X-Gm-Gg: AZuq6aIHEMNAexZPVu5Ji9CkObARR6CReMEGMjg1TM4iHS5fc1+cbPBnGPmGqxzZaYE
	AFCHO2tJxW24edWEpR6bkW2nzDxF7WwJlZ49ja0AuSpzrqswtxB4GmbXEy3pDvJGhmb75ZWzL94
	T0Aw5dGgjB16Qm5+FADwvGYVU1x4PobhFb7/VUuq2U8QTOernVkEXRTjnSNE1ZBrJNT/ob9lc5c
	Ckrf/uCkEr8sblm9Cs/00nDhmNwGDt0vqFi8TpDktE3H0BwXCLg4QPMaXV4MjdMIdmNfyE9Rsf/
	8ClTGOuzTGfR0x6VKOCRzyMsC7Qzu51lHYYapydA6mRC63LlSUWmUHCGwudXfRHO/ifrh7wLuGy
	7ea31drYxhNOvA8xxsj2ULNarnmoKVG4a8QwuQtUnY8pUmsKHKQe67ECQJgWD18YQGeYAP+Mc3Z
	O3cPE=
X-Received: by 2002:a05:7300:bc0e:b0:2b7:3780:810f with SMTP id 5a478bee46e88-2b739b73be3mr3051286eec.23.1769238508267;
        Fri, 23 Jan 2026 23:08:28 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b749e301f0sm3798342eec.35.2026.01.23.23.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 23:08:27 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: dianders@chromium.org
Cc: akpm@linux-foundation.org,
	lihuafei1@huawei.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	mm-commits@vger.kernel.org,
	realwujing@gmail.com,
	song@kernel.org,
	stable@vger.kernel.org,
	sunshx@chinatelecom.cn,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	yangyicong@hisilicon.com,
	yuanql9@chinatelecom.cn,
	zhangjn11@chinatelecom.cn,
	linux-watchdog@vger.kernel.org
Subject: [PATCH v4] watchdog/hardlockup: Fix UAF in perf event cleanup due to migration race
Date: Sat, 24 Jan 2026 02:08:14 -0500
Message-ID: <20260124070814.806828-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAD=FV=WHWrKS_LVjod6nhnPdEk9_ZqeubGpft3PJOUJNMbBxfg@mail.gmail.com>
References: <CAD=FV=WHWrKS_LVjod6nhnPdEk9_ZqeubGpft3PJOUJNMbBxfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.94 / 15.00];
	SUSPICIOUS_URL_IN_SUSPICIOUS_MESSAGE(1.00)[];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	URIBL_RED(0.50)[chinatelecom.cn:email];
	MAILLIST(-0.15)[generic];
	HAS_ANON_DOMAIN(0.10)[];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,huawei.com,vger.kernel.org,kernel.org,gmail.com,chinatelecom.cn,linux.dev,hisilicon.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-211443-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_DKIM_ALLOW(0.00)[gmail.com:s=20230601];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	NEURAL_HAM(-0.00)[-0.739];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c09:e001:a7::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 170707CC54
X-Rspamd-Action: no action

Original analysis on Linux 4.19 showed a race condition in the hardlockup
detector's initialization phase. Specifically, during the early probe
phase, hardlockup_detector_perf_init() (renamed to
watchdog_hardlockup_probe() in newer kernels via commit d9b3629ade8e)
interacted with the per-cpu 'watchdog_ev' variable.

If the initializing task migrates to another CPU during this probe phase,
two issues arise:
1. The 'watchdog_ev' pointer on the original CPU is set but not cleared,
   leaving a stale pointer to a freed perf event.
2. The 'watchdog_ev' pointer on the new CPU might be incorrectly cleared.

Note: Although the logs below reference hardlockup_detector_perf_init(),
the same logic persists in the current watchdog_hardlockup_probe()
implementation.

This race condition was observed in console logs:
[23.038376] hardlockup_detector_perf_init 313 cur_cpu=2
...
[23.076385] hardlockup_detector_event_create 203 cpu(cur)=2 set watchdog_ev
...
[23.095788] perf_event_release_kernel 4623 cur_cpu=2
...
[23.116963] lockup_detector_reconfigure 577 cur_cpu=3

The log shows the task started on CPU 2, set watchdog_ev on CPU 2,
released the event on CPU 2, but then migrated to CPU 3 before the
cleanup logic could run. This left watchdog_ev on CPU 2 pointing to a
freed event, resulting in a UAF when later accessed:

[26.540732] BUG: KASAN: use-after-free in perf_event_ctx_lock_nested.isra.72+0x6b/0x140
[26.542442] Read of size 8 at addr ff110006b360d718 by task kworker/2:1/94

Fix this by refactoring hardlockup_detector_event_create() to return the
created perf event instead of directly assigning it to the per-cpu variable.
In the probe function, use an arbitrary CPU but ensure it remains
online via cpu_hotplug_disable() during the check.

Fixes: 930d8f8dbab9 ("watchdog/perf: adapt the watchdog_perf interface for async model")
Signed-off-by: Shouxin Sun <sunshx@chinatelecom.cn>
Signed-off-by: Junnan Zhang <zhangjn11@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Cc: Song Liu <song@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Wang Jinchao <wangjinchao600@gmail.com>
Cc: <stable@vger.kernel.org>
---
v4:
- Add cpu_hotplug_disable() in watchdog_hardlockup_probe() to ensure the
  sampled CPU remains online during probing. 
- Update commit message to explain the relevance of 4.19 logs even
  though functions were renamed in modern kernels. 
v3:
- Refactor hardlockup_detector_event_create() to return the event pointer
  instead of directly assigning to per-cpu variables to fix the UAF.
- Restore PMU cycle fallback and unify the enable/probe paths.
v2:
- Add Cc: <stable@vger.kernel.org>.
v1:
- Avoid 'watchdog_ev' in probe path by manually creating and releasing a
  local perf event.
 kernel/watchdog_perf.c | 56 +++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index d3ca70e3c256..887b61c65c1b 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -17,6 +17,7 @@
 #include <linux/atomic.h>
 #include <linux/module.h>
 #include <linux/sched/debug.h>
+#include <linux/cpu.h>
 
 #include <asm/irq_regs.h>
 #include <linux/perf_event.h>
@@ -118,18 +119,11 @@ static void watchdog_overflow_callback(struct perf_event *event,
 	watchdog_hardlockup_check(smp_processor_id(), regs);
 }
 
-static int hardlockup_detector_event_create(void)
+static struct perf_event *hardlockup_detector_event_create(unsigned int cpu)
 {
-	unsigned int cpu;
 	struct perf_event_attr *wd_attr;
 	struct perf_event *evt;
 
-	/*
-	 * Preemption is not disabled because memory will be allocated.
-	 * Ensure CPU-locality by calling this in per-CPU kthread.
-	 */
-	WARN_ON(!is_percpu_thread());
-	cpu = raw_smp_processor_id();
 	wd_attr = &wd_hw_attr;
 	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
 
@@ -143,14 +137,7 @@ static int hardlockup_detector_event_create(void)
 						       watchdog_overflow_callback, NULL);
 	}
 
-	if (IS_ERR(evt)) {
-		pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
-			 PTR_ERR(evt));
-		return PTR_ERR(evt);
-	}
-	WARN_ONCE(this_cpu_read(watchdog_ev), "unexpected watchdog_ev leak");
-	this_cpu_write(watchdog_ev, evt);
-	return 0;
+	return evt;
 }
 
 /**
@@ -159,17 +146,26 @@ static int hardlockup_detector_event_create(void)
  */
 void watchdog_hardlockup_enable(unsigned int cpu)
 {
+	struct perf_event *evt;
+
 	WARN_ON_ONCE(cpu != smp_processor_id());
 
-	if (hardlockup_detector_event_create())
+	evt = hardlockup_detector_event_create(cpu);
+	if (IS_ERR(evt)) {
+		pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
+			 PTR_ERR(evt));
 		return;
+	}
 
 	/* use original value for check */
 	if (!atomic_fetch_inc(&watchdog_cpus))
 		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
 
+	WARN_ONCE(this_cpu_read(watchdog_ev), "unexpected watchdog_ev leak");
+	this_cpu_write(watchdog_ev, evt);
+
 	watchdog_init_timestamp();
-	perf_event_enable(this_cpu_read(watchdog_ev));
+	perf_event_enable(evt);
 }
 
 /**
@@ -263,19 +259,35 @@ bool __weak __init arch_perf_nmi_is_available(void)
  */
 int __init watchdog_hardlockup_probe(void)
 {
+	struct perf_event *evt;
+	unsigned int cpu;
 	int ret;
 
 	if (!arch_perf_nmi_is_available())
 		return -ENODEV;
 
-	ret = hardlockup_detector_event_create();
+	if (!hw_nmi_get_sample_period(watchdog_thresh))
+		return -EINVAL;
 
-	if (ret) {
+	/*
+	 * Test hardware PMU availability by creating a temporary perf event.
+	 * The requested CPU is arbitrary; preemption is not disabled, so
+	 * raw_smp_processor_id() is used. Surround with cpu_hotplug_disable()
+	 * to ensure the arbitrarily chosen CPU remains online during the check.
+	 * The event is released immediately.
+	 */
+	cpu_hotplug_disable();
+	cpu = raw_smp_processor_id();
+	evt = hardlockup_detector_event_create(cpu);
+	if (IS_ERR(evt)) {
 		pr_info("Perf NMI watchdog permanently disabled\n");
+		ret = PTR_ERR(evt);
 	} else {
-		perf_event_release_kernel(this_cpu_read(watchdog_ev));
-		this_cpu_write(watchdog_ev, NULL);
+		perf_event_release_kernel(evt);
+		ret = 0;
 	}
+	cpu_hotplug_enable();
+
 	return ret;
 }
 
-- 
2.51.0



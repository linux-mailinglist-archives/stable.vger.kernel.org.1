Return-Path: <stable+bounces-211704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG56C68heGk/oQEAu9opvQ
	(envelope-from <stable+bounces-211704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:23:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 708638EFF2
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 03:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD4953006002
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 02:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D433398A;
	Tue, 27 Jan 2026 02:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlcal7hw"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A629B8FE
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 02:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769480590; cv=none; b=GvxN1Q/BqMwODTn4oA+wlr6Ag9cUtS/FL7SAv84aHq+7j/NyNfM77fOacK03q7kZAv0tS99GFKbKW5MTssxzkJYtbC70in2e7vHeGD31sGg4eMhRHBtHSbGyS71z4MLxHUbOi5+0cHTWXpEk/nkUBOQTibCN6L7aE2kEmjeCwCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769480590; c=relaxed/simple;
	bh=N64M/JIJLJwol49yhjrUkcj2FnRP1GWKH932vmf5iHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R6k/3oTLJGht7T3+9a+kJn41Tk3JnYHuDmAycCCUeCaT3H5m2eluxisJ9d8kuXutm3Z3sYTMd3ctSwRxuct+ie89dP4gOwY86UrIvWN15h4tK05kfMMO3uu3EzJskD314IMVNTy7xk5KNlrgxt+4UvZcWCjmj8po804yU784N2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dlcal7hw; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-124899ee9d3so1489891c88.0
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 18:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769480588; x=1770085388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C/BKwe8/Yc0esAHXSWFatM1ucuc0hnp+X30KfdTTAPY=;
        b=Dlcal7hwWTDZxQTCOfnwtmBy8iOvHqQIJvt/bhR9jpoyNep7Rzy7GxNkhmxJEQKiQy
         yYbwJRA7THKCc62/Oe3LpKzIQLxIhYdawEv3GACkuWacW2saOFh5qwxg+ghI3gDDlq/+
         zYPK3zG9q6qrP4+UrIUPinfQI9nTB7T/7MelW+2SJgfIDF2JoXjokE0L+fHpYYhpjoI9
         XrxZFXbu60IM2lNwJKeH+dzEWgwjUyUWS9VvRS1ISFYdIP0dBsd2ehNY7maJApDM+pgj
         GxoSfdAarSs5FxsD3pr4dZldhTssR+MFqx+6aQawuiMl+T2nneWZASvc6zDA1jV1Y0b4
         Y10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769480588; x=1770085388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/BKwe8/Yc0esAHXSWFatM1ucuc0hnp+X30KfdTTAPY=;
        b=xEXD1FjxeDha2rdf/F0sC6HpZXvpl+ujJ1jMicOF9to3jXKb73WkzgysjvWKPIBvvy
         VwUZoZoH4e+kmMNbFdxskT5rE6ivtbB9xDWJTCs0YOPfxeCwZG1Ib7U2pyc0Ggc1LQca
         n6k7a18IXCF/rYal4fysgwQRWymbXlOvBYymCTw7UNp/tSI6r3UomUc8EFdLYCNS4IGQ
         vvhVJBErcG9yf7laHYaAy4IDKfaWUaAwmd2r1r1MhGhVuRW2RaKLmZdh00dVpvDdfJ1Q
         HJzsV44tAwJtG3z5SL2TGyJSldNCO2ZQhZP6vq6L55aIOp/fdOx9RwuXc22Opikl7Lv+
         No0A==
X-Forwarded-Encrypted: i=1; AJvYcCVTPnQvvGCs4K1UAq7ByZmc/5yHQPpujbjOM84YvZ7gj2zfnyhhTzqRcu3402EpZOe//KecJyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysBgZFeNbEGnffJi8wUYeHAJ1bspWwAs4ik1XW5WIUKWGr7q9O
	G0fN7JVPs9W1Do6dal6TA2TZ0oSg6uj5EnK2e9znjI8jMcYRq9v832Mm
X-Gm-Gg: AZuq6aLT48Lkew9z6Md1iE+I4slXpKiJpidSD6Cn8o/8GAs5+nB9/2RtaIftyEotWv1
	NBcoKCY8NfnGjTz+7IVK54i5YF5yn8bxPNbMeXQ+MlJyRSGIX9XRYGeR6pptKZ+jf7i54PEXrlA
	myGHJXIFK/Uq2i874naUyex3kjhEIxDTZGipzrE3KBuuJujO733WAxP8cABPMqWfEsGQ20CmHSv
	cyjVhc/MglxVJ9eRMQIkiwvh+ld1NZB9tX8g4QSHrUhroq2Il2UFTFgJW5YsMIoBltEE4Sw0fzH
	5AzkZxRhq0NmdtujjHQcV94vbqgx2yojG/gRgb/N31L/H0PnNqhYyjANb1JFpRlVHYIm67PBdxH
	FFeugxHJSU2AD3PlwiypV/FGjqN4vibsVXOadD6aqk3oYM1qmJNpYpfsrxjPzad/QsaqsJt3rwF
	AV63Q=
X-Received: by 2002:a05:7022:6725:b0:11b:9386:a383 with SMTP id a92af1059eb24-124a0e8a130mr52799c88.22.1769480588356;
        Mon, 26 Jan 2026 18:23:08 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d90cda6sm20111224c88.1.2026.01.26.18.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:23:08 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Qiliang Yuan <realwujing@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Li Huafei <lihuafei1@huawei.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Jinchao Wang <wangjinchao600@gmail.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Petr Mladek <pmladek@suse.com>,
	Pingfan Liu <kernelfans@gmail.com>,
	Lecopzer Chen <lecopzer.chen@mediatek.com>,
	Douglas Anderson <dianders@chromium.org>
Cc: linux-watchdog@vger.kernel.org,
	mm-commits@vger.kernel.org,
	Shouxin Sun <sunshx@chinatelecom.cn>,
	Junnan Zhang <zhangjn11@chinatelecom.cn>,
	Qiliang Yuan <yuanql9@chinatelecom.cn>,
	Song Liu <song@kernel.org>,
	stable@vger.kernel.org,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] watchdog/hardlockup: Fix UAF in perf event cleanup due to migration race
Date: Mon, 26 Jan 2026 21:22:24 -0500
Message-ID: <20260127022238.1182079-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chinatelecom.cn,kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-211704-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux-foundation.org,huawei.com,linux.dev,hisilicon.com,suse.com,mediatek.com,chromium.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chinatelecom.cn:email,chromium.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 708638EFF2
X-Rspamd-Action: no action

The hardlockup detector's probe path (watchdog_hardlockup_probe()) can
be executed in a non-pinned context, such as during the asynchronous
retry mechanism (lockup_detector_delay_init) which runs in a standard
unbound workqueue.

In this context, the existing implementation of
hardlockup_detector_event_create() suffers from a race condition due to
potential task migration. It relies on is_percpu_thread() to ensure
CPU-locality, but worker threads in a global workqueue do not carry the
PF_PERCPU_THREAD flag, causing the WARN_ON() to trigger and violating
the assumption of stable per-cpu access.

If the task migrates during the probe:
1. It might set 'watchdog_ev' on one CPU but fail to clear it if the
   subsequent migration causes the cleanup logic to run on a different CPU.
2. This leaves a stale pointer to a freed perf_event in the original
   CPU's 'watchdog_ev' variable, leading to a use-after-free (UAF) when
   the watchdog is later enabled or reconfigured.

While this issue was prominently observed in downstream kernels (like
openEuler 4.19) where initialization timings are shifted to a post-SMP
phase, it represents a latent bug in the mainline asynchronous
initialization path.

Refactor hardlockup_detector_event_create() to be stateless by returning
the created perf_event pointer instead of directly modifying the per-cpu
'watchdog_ev' variable. This allows the probe logic to safely manage
the temporary event. Use cpu_hotplug_disable() during the probe to ensure
the target CPU remains valid throughout the check.

Fixes: 930d8f8dbab9 ("watchdog/perf: adapt the watchdog_perf interface for async model")
Signed-off-by: Shouxin Sun <sunshx@chinatelecom.cn>
Signed-off-by: Junnan Zhang <zhangjn11@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
Cc: Song Liu <song@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Cc: <stable@vger.kernel.org>
---
v5:
- Refine description: clarify it identifies a latent bug in the mainline
  asynchronous retry path where worker threads lack PF_PERCPU_THREAD.
v4:
- Add cpu_hotplug_disable() in watchdog_hardlockup_probe() to stabilize
  the probe CPU.
- Update description to explain the relevance of 4.19 logs.
v3:
- Refactor hardlockup_detector_event_create() to be stateless.
v2:
- Add Cc stable.

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



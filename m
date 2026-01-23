Return-Path: <stable+bounces-211338-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBw5NPUWc2mwsAAAu9opvQ
	(envelope-from <stable+bounces-211338-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 07:36:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BB9710E1
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 07:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96A863019074
	for <lists+stable@lfdr.de>; Fri, 23 Jan 2026 06:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5612FC891;
	Fri, 23 Jan 2026 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhMTsOby"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506B72BFC7B
	for <stable@vger.kernel.org>; Fri, 23 Jan 2026 06:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769150064; cv=none; b=V822wF85kcD9sZfuDz/u8XiWESAMWW0nOekre0s0XqF68VkNUT0MwSJ2cOwNSQJF5akEjYYeZxu0+rh8QRIDYPlEW98rFWHxSuuMSvSLjhaXImt598Snfh0Rx9Da7eWiiUPq72cA+MhBLwYkznqFU+1ag/58frVPC6HIcOl9jik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769150064; c=relaxed/simple;
	bh=3tE8bua8ns/oISEYiYIo23uBl9ulZW+1x9VpbUmsXjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K3LvKql4FKMGem9r8oO+xV6oH3nYa045e15AAxUo7Cvuux7SlhDjSoNUNeaU28VXD8orTPtsnRdIwa1Q6C77AcFXWCuYfADks6YtLzYcYVie9+WBsrJKWUM3ghs+JEWBNNOKQYYgTjfHY2JiIjXad0F9ON+nJ9pReN5FdyZZu4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhMTsOby; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-121a0bcd364so3253236c88.0
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 22:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769150059; x=1769754859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sXcBBoWh7S5ryxIZK6TNZiSRw8O4j7XF0vdkdGQlyQ=;
        b=HhMTsOby5FV2mEjeANhw/wG13yZ1j0cilrYs7iLQodzhEcmfdyCLkX2tIJjf4Bpcx9
         Anipt3e+Ini1ftLQSWLYLxQSDuU8gA0oerZcViL7NPJxXTAHf7cu4d3D6NhBH1kDlXqG
         gL7fUicpa9bbXVOFjpeldFyx7rRI3EMp1TSbC5FJ2wDfe622Ukaqz+QZsYbua3eBOm11
         Yr/VFXCYWIxd/bZDTbXyxfvg72b7438WtRvAmmIo19FLO7cnib5//OrYOToWrp0W+DkD
         Hoc6Sdqo9fZNk+aBdVmvJvWoCvW3YWezHWxnIehgAawTg/mA6VWPNbNmOrGiVWC1A7Pp
         LknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769150059; x=1769754859;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5sXcBBoWh7S5ryxIZK6TNZiSRw8O4j7XF0vdkdGQlyQ=;
        b=rEI2I2zG9oRJ1yBqteOKlY8OHSoTJIS3KmEKd1dWExPgOzkrENE3D4Z/E9fkhPHl9N
         wg5dLvHUlnle5HbexmnOLiVuPfSRpc59j5ppigG6kkxi0F50t/llWjXhaF783+8fLVeJ
         oO4OFEQmrgUAUrxZdmHMImu5O9AyBxWU7j4kYqydTndC8LcYbN5lgxbStcUGRWcOEsyK
         LzeliPyIFxOyb2KxLuUMcOvDleMDuUomZHWWzeT5wVFygTPeNXCiJxC4DRGnjxKN91pz
         LbgsidBEOcLqaIlWwth4s4pYRudWRNeUwWmxWo5lvAYNYFvCjO/t+Eyl8ALnIqVASD+g
         hv9w==
X-Forwarded-Encrypted: i=1; AJvYcCW6v77jmk/ruB+7OM8um0f4+A0zfWtSnYy8gF7d7NuwryCKzwXRZLyRQlDDPYpMQlhcVdhl4Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywGiX4Ny5aKDYHscAK43lur0tVhcpawTDfCE8EdQPYOhkDwnoV
	U54HJzKSRWzeqWWWfKoNqwJCgIzLm9d2BeJCWiiYhS4qA+Mgh4NqshkJdlG2tTgG
X-Gm-Gg: AZuq6aJHhaoqkWckAdM5ZM63pfX53dJcS0XXB/5qHQ+qxVjbttnRAaYRV53ieCMb0gw
	RuJ7p0ng899LGjqRsTRBhnZSvF6boOWilxT5mHS02w06DDe8iJgnM4WI6NgAkqw4NKsJU5baSjq
	RSoawCZsXnQ2GsjG1/KkcRY5SaPYt39W2U5qRAhncW+Q9BxuCDfNWfzbAjOsDtZrg44MrOb++rT
	3+WuLa9bVBtbkXaYXo4FwQbDdEsfSDE1bblBvYsRxg2l+nZJtgYUqywQ4p5Xfgk677uMVu2W9Hn
	cK88zOJg7zqKpwIGxIjJvSThI6NkeQO6+lltb9sWD8wNQJdUjBBj2IGgTAMDZMNP+14uMiVRvmb
	hqoeSXh9JIxAvFQmZzzs934NnAWO3oyE+HngiQQhR5iz52kZ3CRljqgnwJnWLEr8lcArBsT/dGo
	o5XMM=
X-Received: by 2002:a05:7022:6720:b0:11b:9386:a381 with SMTP id a92af1059eb24-1247dc13195mr946069c88.48.1769150058449;
        Thu, 22 Jan 2026 22:34:18 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d7abb74sm3396847c88.0.2026.01.22.22.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 22:34:18 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org
Cc: lihuafei1@huawei.com,
	linux-kernel@vger.kernel.org,
	mingo@kernel.org,
	realwujing@gmail.com,
	song@kernel.org,
	stable@vger.kernel.org,
	sunshx@chinatelecom.cn,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	yangyicong@hisilicon.com,
	yuanql9@chinatelecom.cn,
	zhangjn11@chinatelecom.cn,
	mm-commits@vger.kernel.org
Subject: [PATCH v3] watchdog/hardlockup: Fix UAF in perf event cleanup due to migration race
Date: Fri, 23 Jan 2026 01:34:07 -0500
Message-ID: <20260123063407.248775-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAD=FV=UGpqN3XsHWM9coRdez2mL8mz0_hsUMQttTqaD7oEvSEQ@mail.gmail.com>
References: <CAD=FV=UGpqN3XsHWM9coRdez2mL8mz0_hsUMQttTqaD7oEvSEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211338-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[huawei.com,vger.kernel.org,kernel.org,gmail.com,chinatelecom.cn,linux.dev,hisilicon.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: 35BB9710E1
X-Rspamd-Action: no action

During the early initialization of the hardlockup detector, the
hardlockup_detector_perf_init() function probes for PMU hardware availability.
It originally used hardlockup_detector_event_create(), which interacts with
the per-cpu 'watchdog_ev' variable.

If the initializing task migrates to another CPU during this probe phase,
two issues arise:
1. The 'watchdog_ev' pointer on the original CPU is set but not cleared,
   leaving a stale pointer to a freed perf event.
2. The 'watchdog_ev' pointer on the new CPU might be incorrectly cleared.

This race condition was observed in console logs (captured by adding debug printks):

[23.038376] hardlockup_detector_perf_init 313 cur_cpu=2
...
[23.076385] hardlockup_detector_event_create 203 cpu(cur)=2 set watchdog_ev
...
[23.095788] perf_event_release_kernel 4623 cur_cpu=2
...
[23.116963] lockup_detector_reconfigure 577 cur_cpu=3

The log shows the task started on CPU 2, set watchdog_ev on CPU 2,
released the event on CPU 2, but then migrated to CPU 3 before the
cleanup logic (which would clear watchdog_ev) could run. This left
watchdog_ev on CPU 2 pointing to a freed event.

Later, when the watchdog is enabled/disabled on CPU 2, this stale pointer
leads to a Use-After-Free (UAF) in perf_event_disable(), as detected by KASAN:
[26.539140] ==================================================================
[26.540732] BUG: KASAN: use-after-free in perf_event_ctx_lock_nested.isra.72+0x6b/0x140
[26.542442] Read of size 8 at addr ff110006b360d718 by task kworker/2:1/94
[26.543954]
[26.544744] CPU: 2 PID: 94 Comm: kworker/2:1 Not tainted 4.19.90-debugkasan #11
[26.546505] Hardware name: GoStack Foundation OpenStack Nova, BIOS 1.16.3-3.ctl3 04/01/2014
[26.548256] Workqueue: events smp_call_on_cpu_callback
[26.549267] Call Trace:
[26.549936]  dump_stack+0x8b/0xbb
[26.550731]  print_address_description+0x6a/0x270
[26.551688]  kasan_report+0x179/0x2c0
[26.552519]  ? perf_event_ctx_lock_nested.isra.72+0x6b/0x140
[26.553654]  ? watchdog_disable+0x80/0x80
[26.553657]  perf_event_ctx_lock_nested.isra.72+0x6b/0x140
[26.556951]  ? dump_stack+0xa0/0xbb
[26.564006]  ? watchdog_disable+0x80/0x80
[26.564886]  perf_event_disable+0xa/0x30
[26.565746]  hardlockup_detector_perf_disable+0x1b/0x60
[26.566776]  watchdog_disable+0x51/0x80
[26.567624]  softlockup_stop_fn+0x11/0x20
[26.568499]  smp_call_on_cpu_callback+0x5b/0xb0
[26.569443]  process_one_work+0x389/0x770
[26.570311]  worker_thread+0x57/0x5a0
[26.571124]  ? process_one_work+0x770/0x770
[26.572031]  kthread+0x1ae/0x1d0
[26.572810]  ? kthread_create_worker_on_cpu+0xc0/0xc0
[26.573821]  ret_from_fork+0x1f/0x40
[26.574638]
[26.575178] Allocated by task 1:
[26.575990]  kasan_kmalloc+0xa0/0xd0
[26.576814]  kmem_cache_alloc_trace+0xf3/0x1e0
[26.577732]  perf_event_alloc.part.89+0xb5/0x12b0
[26.578700]  perf_event_create_kernel_counter+0x1e/0x1d0
[26.579728]  hardlockup_detector_event_create+0x4e/0xc0
[26.580744]  hardlockup_detector_perf_init+0x2f/0x60
[26.581746]  lockup_detector_init+0x85/0xdc
[26.582645]  kernel_init_freeable+0x34d/0x40e
[26.583568]  kernel_init+0xf/0x130
[26.584428]  ret_from_fork+0x1f/0x40
[26.584429]
[26.584430] Freed by task 0:
[26.584433]  __kasan_slab_free+0x130/0x180
[26.584436]  kfree+0x90/0x1a0
[26.589641]  rcu_process_callbacks+0x2cb/0x6e0
[26.590935]  __do_softirq+0x119/0x3a2
[26.591965]
[26.592630] The buggy address belongs to the object at ff110006b360d500
[26.592630]  which belongs to the cache kmalloc-2048 of size 2048
[26.592633] The buggy address is located 536 bytes inside of
[26.592633]  2048-byte region [ff110006b360d500, ff110006b360dd00)
[26.592634] The buggy address belongs to the page:
[26.592637] page:ffd400001acd8200 count:1 mapcount:0 mapping:ff11000107c0e800 index:0x0 compound_mapcount: 0
[26.600959] flags: 0x17ffffc0010200(slab|head)
[26.601891] raw: 0017ffffc0010200 dead000000000100 dead000000000200 ff11000107c0e800
[26.603541] raw: 0000000000000000 00000000800f000f 00000001ffffffff 0000000000000000
[26.605546] page dumped because: kasan: bad access detected
[26.606788]
[26.607351] Memory state around the buggy address:
[26.608556]  ff110006b360d600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[26.610565]  ff110006b360d680: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[26.610567] >ff110006b360d700: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[26.610568]                             ^
[26.610570]  ff110006b360d780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[26.610573]  ff110006b360d800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[26.618955] ==================================================================

Fix this by refactoring hardlockup_detector_event_create() to return the
created perf event instead of directly assigning it to the per-cpu variable.
This allows the probe logic to reuse the creation code (including fallback
logic) without affecting the global state, ensuring that task migration
during probe no longer leaves stale pointers in 'watchdog_ev'.

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
v3: Refactor creation logic to return event pointer; restores PMU cycle fallback and unifies paths.
v2: Add Cc: <stable@vger.kernel.org>.
v1: Avoid 'watchdog_ev' in probe path by manually creating and releasing a local perf event.

 kernel/watchdog_perf.c | 51 ++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index d3ca70e3c256..d045b92bc514 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -118,18 +118,11 @@ static void watchdog_overflow_callback(struct perf_event *event,
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
 
@@ -143,14 +136,7 @@ static int hardlockup_detector_event_create(void)
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
@@ -159,17 +145,26 @@ static int hardlockup_detector_event_create(void)
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
@@ -263,19 +258,31 @@ bool __weak __init arch_perf_nmi_is_available(void)
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
+	 * Allow migration during the check as any successfully created per-cpu
+	 * event validates PMU support. The event is released immediately.
+	 */
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
+
 	return ret;
 }
 
-- 
2.51.0



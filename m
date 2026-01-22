Return-Path: <stable+bounces-211196-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id N/QkFK60cWkzLgAAu9opvQ
	(envelope-from <stable+bounces-211196-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 06:25:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0887661F76
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 06:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B1B44E0D4E
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 05:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74A2478841;
	Thu, 22 Jan 2026 05:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdx7BRtr"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880036AB51
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769059494; cv=none; b=Ejiq3dJgv6qRtwe7v2UKVgDBzyYckNXGv8yvU+lVWzWdR4efejzdEl9X8HB2n62PAj66SJRxJoZqpT6iNf9l845H+niDweIbPUuuKnLkLNZ8p+v4wPyIlyIrTQ3HYAf6OQl/wW3gb6g0jzzxC9F9ju+xdi4ATRWG14jQVGTV/0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769059494; c=relaxed/simple;
	bh=/O/LXsBDl7s+Krr2SC1dRCCWCDvR9M9YaJFuQenykYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ug4mOHzvhUvodjE/uLpb29x2Q5h3XqjA0PIy6WChEwZKD5YI9ISnMxoaAP5iLh0WB15djVeDDo4+km4SHl8k7zDavqXfpJEdpJ5wsZ06HZ2KnA55Gy0L0KMCiZ8HxzJMMNN2PBiLUq4DL+hn23wZcBRohJwRE5d2qYBGQOA3HT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdx7BRtr; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2ae287a8444so319936eec.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 21:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769059491; x=1769664291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aR4Uz4L/WnOPutN7yUdcbAcf30b/FJQNKcYLIOLmU40=;
        b=kdx7BRtr1Q01jsFURe4Dz6UWX4v3Fmhsf3CcZT/rXWEMO6lwauwN0/hQ+ifqDFz2wn
         4Mu2byvOcUJC7zQQeEuFsIZzXsQcQxS+5fm1Qd3Uiz4F6wZkkGijeJt27yVBZTtmlXj9
         i4n0VoCb4pHrUsRi8xRikYmxr5/7P7lJ0mf0q0DuJN+JLPKl0CNiKYSPXTq/WmNpQCTe
         +p5Us89zEecWGQosWuTU/FW/Ds/7/pYbWeKxNIR1qr0Sp1o1mG7zols3c55E5f8I0hld
         E0CcIHYiXN8d1lBsOCP5szOfCGJ/he/jgeoeD36mJ8Ov9+3lUAN4EinruGfPz37a2Erk
         rsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769059491; x=1769664291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aR4Uz4L/WnOPutN7yUdcbAcf30b/FJQNKcYLIOLmU40=;
        b=C627oTSyWZc7wAKNra4lBIlNG73jBC4k+ulrxGvLE61anBnpBLsQwqQHVTpDoPR0kg
         Pf9pB8gYkEzmPFyFEp2FY9Eq0AE4xlz5gYrkpac9nxG+9kYlP0qvJbRYG5ygRVXNaiiU
         Gg4FU7v7ZYzuzdmaTw8tRqD9GY22E2QB6qpq4u4hqZg6tmNbTI1OZy+SKVjUY+01X5Ad
         fplOveCNmNI2lprWJ9am3nqeGrZ7RtDnRCwk+NM5RVQmj7OU16ir/XIlmtf4PWYJ96Bb
         21QJoZk+SheKZVVSB62+yXNk1qQQzCox0EZZOkaaoqiewhSLtm0iTX9n6fZ7EBXS4ZxW
         YTHg==
X-Forwarded-Encrypted: i=1; AJvYcCVnJfOVQOFAZHOfbiLIJgdE7YNW56irLpeNxm1JefJax1MDL/vVLo+cdKxIry3fRrseK8YSwFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSszb2oJdfxho5pCwQvl2HN9MkK8a8F+Yrw18sQp6ELdNBX7t2
	thaksHWQhGv2eizk7xKZGKtoY9/DK2np0WZHo5LnXDAnbWS317BurN/m
X-Gm-Gg: AZuq6aLejAWpax/YqmiE30cr1QtiFb2ZtkiwV4mIWJjfojQVzVwVWhUE8lK2bm2KGrz
	UqRc65q4ntkisWFfFhQYuLDxz/vWohlxVz60PHnN856TaANIrVS3qSL8vtkW1bFgLUvyXpz6XQi
	SsWplukszDdS58S9wqbnud8mJKtKIutiEXca3mEXvH5c3jMYOe3nfaKDfUDecT3MHsjLvV2A8OR
	WEEzudovOXPnkEfiCL2dyFVw6hT8AwGUycM6JqaBptfVURT4d0eYxp7bamtflS+hSArSCR25jLG
	EYNlUlr4ec5M814DE57P1Wc2zh9O6+Hz0lxeBWH12pFPLsydc2OcLxDXmTOF9POhA9m89du2qsS
	qQ7rH8ZbgbVBrzeQ7MllN5/Ie5i3cB5f5+jNAfDzP4iL8zSFULIktbl0I5DeQWI/MUrxF4tNd7t
	CMvBs=
X-Received: by 2002:a05:7300:148e:b0:2b6:fa6a:6ef4 with SMTP id 5a478bee46e88-2b7247eb3b2mr1072622eec.12.1769059491289;
        Wed, 21 Jan 2026 21:24:51 -0800 (PST)
Received: from debian ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7070eeec2sm7556295eec.21.2026.01.21.21.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 21:24:50 -0800 (PST)
From: Qiliang Yuan <realwujing@gmail.com>
To: realwujing@gmail.com,
	akpm@linux-foundation.org,
	lihuafei1@huawei.com,
	mingo@kernel.org
Cc: linux-kernel@vger.kernel.org,
	sunshx@chinatelecom.cn,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	yangyicong@hisilicon.com,
	yuanql9@chinatelecom.cn,
	zhangjn11@chinatelecom.cn,
	stable@vger.kernel.org
Subject: [PATCH v2] watchdog/hardlockup: Fix UAF in perf event cleanup due to migration race
Date: Thu, 22 Jan 2026 00:24:42 -0500
Message-ID: <20260122052442.667394-1-realwujing@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122042717.657231-1-realwujing@gmail.com>
References: <20260122042717.657231-1-realwujing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211196-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,chinatelecom.cn,linux.dev,gmail.com,hisilicon.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org,huawei.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[realwujing@gmail.com,stable@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,chinatelecom.cn:email]
X-Rspamd-Queue-Id: 0887661F76
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

Fix this by making the probe logic stateless. Use a local variable for the
perf event and avoid accessing the per-cpu 'watchdog_ev' during initialization.
This ensures that the probe event is always properly released regardless of
task migration, and no stale global state is left behind.

Cc: stable@vger.kernel.org
Signed-off-by: Shouxin Sun <sunshx@chinatelecom.cn>
Signed-off-by: Junnan Zhang <zhangjn11@chinatelecom.cn>
Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
---
v2:
- Add Cc: stable@vger.kernel.org tag.
---
 kernel/watchdog_perf.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index d3ca70e3c256..5066be7bba03 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -264,18 +264,38 @@ bool __weak __init arch_perf_nmi_is_available(void)
 int __init watchdog_hardlockup_probe(void)
 {
 	int ret;
+	struct perf_event_attr *wd_attr = &wd_hw_attr;
+	struct perf_event *evt;
+	unsigned int cpu;
 
 	if (!arch_perf_nmi_is_available())
 		return -ENODEV;
 
-	ret = hardlockup_detector_event_create();
+	/*
+	 * Test hardware PMU availability. Avoid using
+	 * hardlockup_detector_event_create() to prevent migration-related
+	 * stale pointers in the per-cpu watchdog_ev during early probe.
+	 */
+	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
+	if (!wd_attr->sample_period)
+		return -EINVAL;
 
-	if (ret) {
+	/*
+	 * Use raw_smp_processor_id() for probing in preemptible init code.
+	 * Migration after reading ID is acceptable as counter creation on
+	 * the old CPU is sufficient for the probe.
+	 */
+	cpu = raw_smp_processor_id();
+	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
+					       watchdog_overflow_callback, NULL);
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



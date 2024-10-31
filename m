Return-Path: <stable+bounces-89448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7E29B84A4
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 21:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1F941F23705
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 20:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6541CC16B;
	Thu, 31 Oct 2024 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b="gMYsVa9x"
X-Original-To: stable@vger.kernel.org
Received: from ksmg02.maxima.ru (ksmg02.maxima.ru [81.200.124.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F6514A4F3;
	Thu, 31 Oct 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407856; cv=none; b=JRZXw/0LklqENwPbSQLI1lFituLASmCEenXwiPv9utEf6c9oXhSz6bgEbjmhZfbcCWoR+XUri9zmSzKn7AvrRnDxeeLaTeRk81ailim51bUw0T/AITZZGwuWsXcrPJGz3f4XAgnWDLczRpJVgfSWg1oq71GZaCIWFrHUuYlF19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407856; c=relaxed/simple;
	bh=4zbPd6N0MMmrRlIDYPnV9xe1iljTOJKsOO1hDW7GNzk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jm48s+gaoYx4CqDUjA+yhL+OWrmeVHtBkb+SpKjW+kanpmNG+AmUz0P8HdSP/yVrKEjH6BZOIN26jG5oZLIpw+r37o5TNYYkl5i3qSFl3S8dsCGR2eacYYu2Tj40IYWkUuKUeCESOySPuIdEKHk+e9js8jM18eF5WYDpM5Zr94Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru; spf=pass smtp.mailfrom=maxima.ru; dkim=pass (2048-bit key) header.d=maxima.ru header.i=@maxima.ru header.b=gMYsVa9x; arc=none smtp.client-ip=81.200.124.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maxima.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxima.ru
Received: from ksmg02.maxima.ru (localhost [127.0.0.1])
	by ksmg02.maxima.ru (Postfix) with ESMTP id 9DA141E000D;
	Thu, 31 Oct 2024 23:42:33 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg02.maxima.ru 9DA141E000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxima.ru; s=sl;
	t=1730407353; bh=f8wdmRjxhv+HtGLkF0t4xEscwB6K86okf8MRSzlwnWA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=gMYsVa9xfBrmvQ9j2KIhMpsMSXtFwIZIVD7RHrivgr+gqtGKJi2dnne6rgM5sqjp3
	 HIYk1QzqJU5rU9FNAycs6dMD6R9Vjo/H2DvxvlrWx6eaAwgoK/bsv/DPoCIRjxNVcw
	 UUhNtQgdq2hsepN60NV/YvkkhaEI9icGZHCu+QOZgEn+zTVtRhr66A8yAc/QD2WG3J
	 XQ8y2qWwiqVCQWwfQUsrfv5pfNOi0Vwa3yqGVGjclRN8CcEKTp5fQEZwjVteSbVuhl
	 MPn6ZKR9vsje8Ra9xYPeW1+NBOa+wF/YebnB8TUUxmkKw3e96h2p1b+N4WiW68kZiQ
	 51pknVtAxvHSA==
Received: from ksmg02.maxima.ru (mail.maxima.ru [81.200.124.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg02.maxima.ru (Postfix) with ESMTPS;
	Thu, 31 Oct 2024 23:42:33 +0300 (MSK)
Received: from GS-NOTE-190.mt.ru (10.0.247.52) by mmail-p-exch02.mt.ru
 (81.200.124.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.4; Thu, 31 Oct
 2024 23:42:30 +0300
From: Murad Masimov <m.masimov@maxima.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Murad Masimov <m.masimov@maxima.ru>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 5.10] perf/x86/intel: Fix PEBS-via-PT reload base value for Extended PEBS
Date: Thu, 31 Oct 2024 23:42:00 +0300
Message-ID: <20241031204202.134-1-m.masimov@maxima.ru>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch02.mt.ru
 (81.200.124.62)
X-KSMG-Rule-ID: 7
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 188865 [Oct 31 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: m.masimov@maxima.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dmarc=none header.from=maxima.ru;spf=none smtp.mailfrom=maxima.ru;dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {rep_avail}, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;maxima.ru:7.1.1;81.200.124.62:7.1.2;ksmg02.maxima.ru:7.1.1;lkml.kernel.org:7.1.1, FromAlignment: s, ApMailHostAddress: 81.200.124.62
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/10/31 16:34:00
X-KSMG-LinksScanning: Clean, bases: 2024/10/31 16:34:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/10/31 05:12:00 #26797869
X-KSMG-AntiVirus-Status: Clean, skipped

From: Like Xu <like.xu.linux@gmail.com>

commit 4c58d922c0877e23cc7d3d7c6bff49b85faaca89 upstream.

If we use the "PEBS-via-PT" feature on a platform that supports
extended PBES, like this:

    perf record -c 10000 \
    -e '{intel_pt/branch=0/,branch-instructions/aux-output/p}' uname

we will encounter the following call trace:

[  250.906542] unchecked MSR access error: WRMSR to 0x14e1 (tried to write
0x0000000000000000) at rIP: 0xffffffff88073624 (native_write_msr+0x4/0x20)
[  250.920779] Call Trace:
[  250.923508]  intel_pmu_pebs_enable+0x12c/0x190
[  250.928359]  intel_pmu_enable_event+0x346/0x390
[  250.933300]  x86_pmu_start+0x64/0x80
[  250.937231]  x86_pmu_enable+0x16a/0x2f0
[  250.941434]  perf_event_exec+0x144/0x4c0
[  250.945731]  begin_new_exec+0x650/0xbf0
[  250.949933]  load_elf_binary+0x13e/0x1700
[  250.954321]  ? lock_acquire+0xc2/0x390
[  250.958430]  ? bprm_execve+0x34f/0x8a0
[  250.962544]  ? lock_is_held_type+0xa7/0x120
[  250.967118]  ? find_held_lock+0x32/0x90
[  250.971321]  ? sched_clock_cpu+0xc/0xb0
[  250.975527]  bprm_execve+0x33d/0x8a0
[  250.979452]  do_execveat_common.isra.0+0x161/0x1d0
[  250.984673]  __x64_sys_execve+0x33/0x40
[  250.988877]  do_syscall_64+0x3d/0x80
[  250.992806]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  250.998302] RIP: 0033:0x7fbc971d82fb
[  251.002235] Code: Unable to access opcode bytes at RIP 0x7fbc971d82d1.
[  251.009303] RSP: 002b:00007fffb8aed808 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
[  251.017478] RAX: ffffffffffffffda RBX: 00007fffb8af2f00 RCX: 00007fbc971d82fb
[  251.025187] RDX: 00005574792aac50 RSI: 00007fffb8af2f00 RDI: 00007fffb8aed810
[  251.032901] RBP: 00007fffb8aed970 R08: 0000000000000020 R09: 00007fbc9725c8b0
[  251.040613] R10: 6d6c61632f6d6f63 R11: 0000000000000202 R12: 00005574792aac50
[  251.048327] R13: 00007fffb8af35f0 R14: 00005574792aafdf R15: 00005574792aafe7

This is because the target reload msr address is calculated
based on the wrong base msr and the target reload msr value
is accessed from ds->pebs_event_reset[] with the wrong offset.

According to Intel SDM Table 2-14, for extended PBES feature,
the reload msr for MSR_IA32_FIXED_CTRx should be based on
MSR_RELOAD_FIXED_CTRx.

For fixed counters, let's fix it by overriding the reload msr
address and its value, thus avoiding out-of-bounds access.

Fixes: 42880f726c66("perf/x86/intel: Support PEBS output to PT")
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210621034710.31107-1-likexu@tencent.com
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
---
 arch/x86/events/intel/ds.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 48f30ffef1f4..182908aebed0 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1093,6 +1093,9 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 	struct debug_store *ds = cpuc->ds;
+	u64 value = ds->pebs_event_reset[hwc->idx];
+	u32 base = MSR_RELOAD_PMC0;
+	unsigned int idx = hwc->idx;
 
 	if (!is_pebs_pt(event))
 		return;
@@ -1102,7 +1105,12 @@ static void intel_pmu_pebs_via_pt_enable(struct perf_event *event)
 
 	cpuc->pebs_enabled |= PEBS_OUTPUT_PT;
 
-	wrmsrl(MSR_RELOAD_PMC0 + hwc->idx, ds->pebs_event_reset[hwc->idx]);
+	if (hwc->idx >= INTEL_PMC_IDX_FIXED) {
+		base = MSR_RELOAD_FIXED_CTR0;
+		idx = hwc->idx - INTEL_PMC_IDX_FIXED;
+		value = ds->pebs_event_reset[MAX_PEBS_EVENTS + idx];
+	}
+	wrmsrl(base + idx, value);
 }
 
 void intel_pmu_pebs_enable(struct perf_event *event)
@@ -1110,6 +1118,7 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct hw_perf_event *hwc = &event->hw;
 	struct debug_store *ds = cpuc->ds;
+	unsigned int idx = hwc->idx;
 
 	hwc->config &= ~ARCH_PERFMON_EVENTSEL_INT;
 
@@ -1128,19 +1137,18 @@ void intel_pmu_pebs_enable(struct perf_event *event)
 		}
 	}
 
+	if (idx >= INTEL_PMC_IDX_FIXED)
+		idx = MAX_PEBS_EVENTS + (idx - INTEL_PMC_IDX_FIXED);
+
 	/*
 	 * Use auto-reload if possible to save a MSR write in the PMI.
 	 * This must be done in pmu::start(), because PERF_EVENT_IOC_PERIOD.
 	 */
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
-		unsigned int idx = hwc->idx;
-
-		if (idx >= INTEL_PMC_IDX_FIXED)
-			idx = MAX_PEBS_EVENTS + (idx - INTEL_PMC_IDX_FIXED);
 		ds->pebs_event_reset[idx] =
 			(u64)(-hwc->sample_period) & x86_pmu.cntval_mask;
 	} else {
-		ds->pebs_event_reset[hwc->idx] = 0;
+		ds->pebs_event_reset[idx] = 0;
 	}
 
 	intel_pmu_pebs_via_pt_enable(event);
-- 
2.39.2



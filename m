Return-Path: <stable+bounces-106677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A86FA003BD
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 06:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDB663A37F1
	for <lists+stable@lfdr.de>; Fri,  3 Jan 2025 05:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A491B3929;
	Fri,  3 Jan 2025 05:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cYM0dz6L"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86CC1B21A7
	for <stable@vger.kernel.org>; Fri,  3 Jan 2025 05:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735883114; cv=none; b=e9f2nsEIcOA/RTMC9b97A/xBrAAH6XGVSO8sAzAiS4Npy2Ll8TgW0NwQf8gPaf6SX3n2oUJ/Vb5SUlNJfNX2c5hSYTNqLcoDR6c898AuOuz4Ob3Vt4zj7F4Ko00n566KnFkcRDKo/E8qPrhR1oRL0p2znl60HySIMK3A0LFlJZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735883114; c=relaxed/simple;
	bh=hz1RqTw1E/+PJaISYkmLCfE7Vsdg5C7rG+upHlBEbg0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gonvPheOyEWHTuIJ5WjIA1MCuPHcdXO14rdF3diiRarPgqZYrZa1UY8n/fT0aUkQPqrRpju0hHhYi4d7lQ0sn8PWKxLTethurDt/TTJXUvrSQgbM/hpbVMgS9jIjPPPJzAjqUcRcHLn+gllxtwMP08m1iIC5DxS1tii9O4xvKFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cYM0dz6L; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from namjain-hibernation.4uyjgaamrtuunfhsycmekme4ua.xx.internal.cloudapp.net (unknown [20.94.232.156])
	by linux.microsoft.com (Postfix) with ESMTPSA id 538E02041A90;
	Thu,  2 Jan 2025 21:45:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 538E02041A90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735883111;
	bh=4fAtC6ThXpmeUAWUdJmyTFEK9WJ+iGL8jbP9AHW3ENE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cYM0dz6LEHttBLdDaah+0alFXQEiE1WfFFMl4daxgvwuvy5CRPdMT9ICpB4IBr0V3
	 xDaYmyvGGIIYpgA4Tu6OFCI6lIFE8dBdKeRK+XghHS6WT9hQf+EtDHA1po2YwPHomW
	 HgJ+ez+nVcig7Usqc1jYHozdLUJgp1BCoLpFc90s=
From: Naman Jain <namjain@linux.microsoft.com>
To: stable@vger.kernel.org,
	namjain@linux.microsoft.com
Subject: [PATCH 5.10.y] x86/hyperv: Fix hv tsc page based sched_clock for hibernation
Date: Fri,  3 Jan 2025 05:45:06 +0000
Message-ID: <20250103054506.1748-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024122327-imaginary-gizzard-8e8b@gregkh>
References: <2024122327-imaginary-gizzard-8e8b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

read_hv_sched_clock_tsc() assumes that the Hyper-V clock counter is
bigger than the variable hv_sched_clock_offset, which is cached during
early boot, but depending on the timing this assumption may be false
when a hibernated VM starts again (the clock counter starts from 0
again) and is resuming back (Note: hv_init_tsc_clocksource() is not
called during hibernation/resume); consequently,
read_hv_sched_clock_tsc() may return a negative integer (which is
interpreted as a huge positive integer since the return type is u64)
and new kernel messages are prefixed with huge timestamps before
read_hv_sched_clock_tsc() grows big enough (which typically takes
several seconds).

Fix the issue by saving the Hyper-V clock counter just before the
suspend, and using it to correct the hv_sched_clock_offset in
resume. This makes hv tsc page based sched_clock continuous and ensures
that post resume, it starts from where it left off during suspend.
Override x86_platform.save_sched_clock_state and
x86_platform.restore_sched_clock_state routines to correct this as soon
as possible.

Note: if Invariant TSC is available, the issue doesn't happen because
1) we don't register read_hv_sched_clock_tsc() for sched clock:
See commit e5313f1c5404 ("clocksource/drivers/hyper-v: Rework
clocksource and sched clock setup");
2) the common x86 code adjusts TSC similarly: see
__restore_processor_state() ->  tsc_verify_tsc_adjust(true) and
x86_platform.restore_sched_clock_state().

Cc: stable@vger.kernel.org
Fixes: 1349401ff1aa ("clocksource/drivers/hyper-v: Suspend/resume Hyper-V clocksource for hibernation")
Co-developed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/20240917053917.76787-1-namjain@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20240917053917.76787-1-namjain@linux.microsoft.com>
(cherry picked from commit bcc80dec91ee745b3d66f3e48f0ec2efdea97149)
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c     | 58 ++++++++++++++++++++++++++++++
 drivers/clocksource/hyperv_timer.c | 14 +++++++-
 include/clocksource/hyperv_timer.h |  2 ++
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index a91aad434d03..14e5e1d7d0e8 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -163,6 +163,63 @@ static void hv_machine_crash_shutdown(struct pt_regs *regs)
 	hyperv_cleanup();
 }
 #endif /* CONFIG_KEXEC_CORE */
+
+static u64 hv_ref_counter_at_suspend;
+static void (*old_save_sched_clock_state)(void);
+static void (*old_restore_sched_clock_state)(void);
+
+/*
+ * Hyper-V clock counter resets during hibernation. Save and restore clock
+ * offset during suspend/resume, while also considering the time passed
+ * before suspend. This is to make sure that sched_clock using hv tsc page
+ * based clocksource, proceeds from where it left off during suspend and
+ * it shows correct time for the timestamps of kernel messages after resume.
+ */
+static void save_hv_clock_tsc_state(void)
+{
+	hv_ref_counter_at_suspend = hv_read_reference_counter();
+}
+
+static void restore_hv_clock_tsc_state(void)
+{
+	/*
+	 * Adjust the offsets used by hv tsc clocksource to
+	 * account for the time spent before hibernation.
+	 * adjusted value = reference counter (time) at suspend
+	 *                - reference counter (time) now.
+	 */
+	hv_adj_sched_clock_offset(hv_ref_counter_at_suspend - hv_read_reference_counter());
+}
+
+/*
+ * Functions to override save_sched_clock_state and restore_sched_clock_state
+ * functions of x86_platform. The Hyper-V clock counter is reset during
+ * suspend-resume and the offset used to measure time needs to be
+ * corrected, post resume.
+ */
+static void hv_save_sched_clock_state(void)
+{
+	old_save_sched_clock_state();
+	save_hv_clock_tsc_state();
+}
+
+static void hv_restore_sched_clock_state(void)
+{
+	restore_hv_clock_tsc_state();
+	old_restore_sched_clock_state();
+}
+
+static void __init x86_setup_ops_for_tsc_pg_clock(void)
+{
+	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
+		return;
+
+	old_save_sched_clock_state = x86_platform.save_sched_clock_state;
+	x86_platform.save_sched_clock_state = hv_save_sched_clock_state;
+
+	old_restore_sched_clock_state = x86_platform.restore_sched_clock_state;
+	x86_platform.restore_sched_clock_state = hv_restore_sched_clock_state;
+}
 #endif /* CONFIG_HYPERV */
 
 static uint32_t  __init ms_hyperv_platform(void)
@@ -380,6 +437,7 @@ static void __init ms_hyperv_init_platform(void)
 
 	/* Register Hyper-V specific clocksource */
 	hv_init_clocksource();
+	x86_setup_ops_for_tsc_pg_clock();
 #endif
 	/*
 	 * TSC should be marked as unstable only after Hyper-V
diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 7c617d8dff3f..a8875384fb02 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -23,7 +23,8 @@
 #include <asm/mshyperv.h>
 
 static struct clock_event_device __percpu *hv_clock_event;
-static u64 hv_sched_clock_offset __ro_after_init;
+/* Note: offset can hold negative values after hibernation. */
+static u64 hv_sched_clock_offset __read_mostly;
 
 /*
  * If false, we're using the old mechanism for stimer0 interrupts
@@ -370,6 +371,17 @@ static void resume_hv_clock_tsc(struct clocksource *arg)
 	hv_set_reference_tsc(tsc_msr);
 }
 
+/*
+ * Called during resume from hibernation, from overridden
+ * x86_platform.restore_sched_clock_state routine. This is to adjust offsets
+ * used to calculate time for hv tsc page based sched_clock, to account for
+ * time spent before hibernation.
+ */
+void hv_adj_sched_clock_offset(u64 offset)
+{
+	hv_sched_clock_offset -= offset;
+}
+
 static int hv_cs_enable(struct clocksource *cs)
 {
 	hv_enable_vdso_clocksource();
diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyperv_timer.h
index 34eef083c988..7659942f7283 100644
--- a/include/clocksource/hyperv_timer.h
+++ b/include/clocksource/hyperv_timer.h
@@ -35,6 +35,8 @@ extern void hv_init_clocksource(void);
 
 extern struct ms_hyperv_tsc_page *hv_get_tsc_page(void);
 
+extern void hv_adj_sched_clock_offset(u64 offset);
+
 static inline notrace u64
 hv_read_tsc_page_tsc(const struct ms_hyperv_tsc_page *tsc_pg, u64 *cur_tsc)
 {
-- 
2.43.0



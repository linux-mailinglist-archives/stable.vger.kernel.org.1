Return-Path: <stable+bounces-116618-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF45AA38D46
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 21:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A537A26EC
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 20:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B99623872E;
	Mon, 17 Feb 2025 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RKd7GC1K"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C07225798
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 20:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823879; cv=none; b=JXGADV/GPDiGlHrJSjU7IJ73D+QDQGhH7McW3rM6twBLfNPfy/yOrKAy8unuXi3/vYS3B0v9ncKKuDJyS6fX6INxh6oAKsxH5XtRoS4eu8NSnIjbrEids4FChTMSIj8H57mv1B+QBCXm0o+w0fVaB072kOy02Vq/laJ5IyiY1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823879; c=relaxed/simple;
	bh=eT0uHoJVUyeYy/0a2hHObE8YxpngQ35kMWqHF5vQT3M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FYDmM7v+oX68JSc/gB+APS4Zf+99X8O6Ek0FvvVeeW7MwCRYwrhT1FmVDHImkwdXUz6jYaOGOq+Bj4xvlwS1jWLFHkCc1fREXVJB0zsi29XaVEvMbr++qvgYH5PvfIk46B+QhpzWN2XpNc1fo5B3ITHh6oie4vAoVw6zKjm1fMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RKd7GC1K; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739823877; x=1771359877;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RjWCe/xAD5p4Eoc0myXeNx+KiCaOmaq/9SVu5NEXTHg=;
  b=RKd7GC1KXXuWFmEK080da/Zrq9tdUhJQSTOuvZvVfRfrKAq3i50cLF9C
   04GYXyLqpgcEVcpnzsKaHTvWGRo9HH1K31ibhsqJLn2XzgesTHiBA3Yt8
   hao74/ITL/K6PU+uC6HeaMlSyrwjYyE9OQ49CU3ynem2W2LI/7N+/Xf3X
   I=;
X-IronPort-AV: E=Sophos;i="6.13,293,1732579200"; 
   d="scan'208";a="697893077"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 20:24:36 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:36443]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.115:2525] with esmtp (Farcaster)
 id df27e7da-5d58-4bac-b3d8-bb3c37f30eb8; Mon, 17 Feb 2025 20:24:35 +0000 (UTC)
X-Farcaster-Flow-ID: df27e7da-5d58-4bac-b3d8-bb3c37f30eb8
Received: from EX19EXOUWB001.ant.amazon.com (10.250.64.229) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 20:24:35 +0000
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19EXOUWB001.ant.amazon.com (10.250.64.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 20:24:35 +0000
Received: from email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Mon, 17 Feb 2025 20:24:35 +0000
Received: from dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com (dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com [10.189.199.127])
	by email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com (Postfix) with ESMTP id E2BCD405B1
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 20:24:34 +0000 (UTC)
Received: by dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com (Postfix, from userid 30684173)
	id A54FD4F01; Mon, 17 Feb 2025 20:24:34 +0000 (UTC)
From: jaywang-amazon <wanjay@amazon.com>
To: <stable@vger.kernel.org>
Subject: [PATCH] x86/i8253: Disable PIT timer 0 when not in use
Date: Mon, 17 Feb 2025 20:24:34 +0000
Message-ID: <20250217202434.11659-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: David Woodhouse <dwmw@amazon.co.uk>

[upstream commit 70e6b7d9ae3c63df90a7bba7700e8d5c300c360]

Leaving the PIT interrupt running can cause noticeable steal time for
virtual guests. The VMM generally has a timer which toggles the IRQ input
to the PIC and I/O APIC, which takes CPU time away from the guest. Even
on real hardware, running the counter may use power needlessly (albeit
not much).

Make sure it's turned off if it isn't going to be used.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhkelley@outlook.com>
Link: https://lore.kernel.org/all/20240802135555.564941-1-dwmw2@infradead.org

(cherry picked from commit 70e6b7d9ae3c63df90a7bba7700e8d5c300c3c60)

Cc: stable@vger.kernel.org # v5.15

Signed-off-by: jaywang-amazon <wanjay@amazon.com>
---
 arch/x86/kernel/i8253.c     | 11 +++++++++--
 drivers/clocksource/i8253.c | 13 +++++++++----
 include/linux/i8253.h       |  1 +
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/i8253.c b/arch/x86/kernel/i8253.c
index 2b7999a1a50a..80e262bb627f 100644
--- a/arch/x86/kernel/i8253.c
+++ b/arch/x86/kernel/i8253.c
@@ -8,6 +8,7 @@
 #include <linux/timex.h>
 #include <linux/i8253.h>
 
+#include <asm/hypervisor.h>
 #include <asm/apic.h>
 #include <asm/hpet.h>
 #include <asm/time.h>
@@ -39,9 +40,15 @@ static bool __init use_pit(void)
 
 bool __init pit_timer_init(void)
 {
-	if (!use_pit())
+	if (!use_pit()) {
+		/*
+		 * Don't just ignore the PIT. Ensure it's stopped, because
+		 * VMMs otherwise steal CPU time just to pointlessly waggle
+		 * the (masked) IRQ.
+		 */
+		clockevent_i8253_disable();
 		return false;
-
+	}
 	clockevent_i8253_init(true);
 	global_clock_event = &i8253_clockevent;
 	return true;
diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
index d4350bb10b83..cb215e6f2e83 100644
--- a/drivers/clocksource/i8253.c
+++ b/drivers/clocksource/i8253.c
@@ -108,11 +108,8 @@ int __init clocksource_i8253_init(void)
 #endif
 
 #ifdef CONFIG_CLKEVT_I8253
-static int pit_shutdown(struct clock_event_device *evt)
+void clockevent_i8253_disable(void)
 {
-	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
-		return 0;
-
 	raw_spin_lock(&i8253_lock);
 
 	outb_p(0x30, PIT_MODE);
@@ -123,6 +120,14 @@ static int pit_shutdown(struct clock_event_device *evt)
 	}
 
 	raw_spin_unlock(&i8253_lock);
+}
+
+static int pit_shutdown(struct clock_event_device *evt)
+{
+	if (!clockevent_state_oneshot(evt) && !clockevent_state_periodic(evt))
+		return 0;
+
+	clockevent_i8253_disable();
 	return 0;
 }
 
diff --git a/include/linux/i8253.h b/include/linux/i8253.h
index 8336b2f6f834..bf169cfef7f1 100644
--- a/include/linux/i8253.h
+++ b/include/linux/i8253.h
@@ -24,6 +24,7 @@ extern raw_spinlock_t i8253_lock;
 extern bool i8253_clear_counter_on_shutdown;
 extern struct clock_event_device i8253_clockevent;
 extern void clockevent_i8253_init(bool oneshot);
+extern void clockevent_i8253_disable(void);
 
 extern void setup_pit_timer(void);
 
-- 
2.47.1



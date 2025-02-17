Return-Path: <stable+bounces-116630-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C28CA38F53
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 23:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 856813B0A23
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 22:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AD71A83E2;
	Mon, 17 Feb 2025 22:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XkcEc7dZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE4C1A5B9D
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 22:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739832922; cv=none; b=E7YBXZNQaoe4haVC2MglvyTUw32TMF5QrTh53i5WhfBwcmUquBibmQ+fRsqHH8kNMxSFPtomZiKn94ec+OF3j5hVMM1iEgl2yFbbeIapdsoAZG8lD/YDQvmvSELbxpy7K7oKP8udb+NuPRLZo0mLzqjGiaJDFYHgHtQMlE1tbkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739832922; c=relaxed/simple;
	bh=KgZs4XQobgfq5yfUsTPhFtGN5CwF1ZT03Vrk7zPkfz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NNUPi30Lv0hUdxW55Yg95MgEIakxD/4xcjyCSyZDA6dDml4Gj1o/FaeTEnBlNijskAUyGHNXagEpfmqfVkKUD3iSfAahWUPkjbnITx2IlSYVHCcXb5Ym7KezXqjgXZiexQ1agu24Lr//DzwRekifiiTUBheyWTlVoAgVVNa8jIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XkcEc7dZ; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739832920; x=1771368920;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ypvW157RxEoXcNDTwRd2xGj5wGATgALIhBwNjUtHmY=;
  b=XkcEc7dZJ/cFVyWmYktdc7BjUFYEf8exDlme5nBVnUKPFmPUKtfuBrg1
   9wH4vx7PFgL6yjJyOALOU7jkUV84APmqBPOQqhVgbsG3l/bbPxeNI0wHO
   1iIRN9kKoq93WoYJ9zQsAWqb5esw0Lsl4AwG9CFGvdu613CRE1BkqrYoG
   0=;
X-IronPort-AV: E=Sophos;i="6.13,294,1732579200"; 
   d="scan'208";a="173336726"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 22:55:20 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:60752]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.176:2525] with esmtp (Farcaster)
 id 942b5359-faf6-497d-ab6f-06e52296650a; Mon, 17 Feb 2025 22:55:20 +0000 (UTC)
X-Farcaster-Flow-ID: 942b5359-faf6-497d-ab6f-06e52296650a
Received: from EX19D004UWB002.ant.amazon.com (10.13.138.45) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 22:55:19 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D004UWB002.ant.amazon.com (10.13.138.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 22:55:19 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Mon, 17 Feb 2025 22:55:19 +0000
Received: from dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com (dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com [10.189.199.127])
	by email-imr-corp-prod-pdx-1box-2b-ecca39fb.us-west-2.amazon.com (Postfix) with ESMTP id 8651C80130;
	Mon, 17 Feb 2025 22:55:19 +0000 (UTC)
Received: by dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com (Postfix, from userid 30684173)
	id 83E494F37; Mon, 17 Feb 2025 22:55:19 +0000 (UTC)
From: jaywang-amazon <wanjay@amazon.com>
To: <stable@vger.kernel.org>
CC: <wanjay@amazon.com>
Subject: [PATCH 6.1 1/1] x86/i8253: Disable PIT timer 0 when not in use
Date: Mon, 17 Feb 2025 22:53:55 +0000
Message-ID: <20250217225353.21795-4-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250217225353.21795-2-wanjay@amazon.com>
References: <20250217225353.21795-2-wanjay@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: David Woodhouse <dwmw@amazon.co.uk>

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
Cc: stable@vger.kernel.org #v6.1
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



Return-Path: <stable+bounces-116928-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45018A3AA08
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 21:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E69B1885775
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B587A1D90D7;
	Tue, 18 Feb 2025 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nczMR5Gn"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD51B041F
	for <stable@vger.kernel.org>; Tue, 18 Feb 2025 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739910931; cv=none; b=gBMj59ljhfXFgBrN7h+QLOfj/n4rC/6JIjJ2YdLO93TrVozFPPOYnOvJqUhZqDeR6mtj/zt8yOgHQn1s8I/1a88hCd1ncmV3R5utUcx6nYBYxTqhwRT20j7IqI+2Gm7Nys4vynpFiKoky+/BchrKSNzqGKvfcGUZNq2ywLpmBZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739910931; c=relaxed/simple;
	bh=sgBpp2z4rcr/OaW7ZJM2YHs+fhG/lSdMGMZs8d/uhDg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=m8BQI8zKtZqH4pNqZoRm6G8ZVM2/2+xSTy/XhcKDzfPvyPKeazQHJyyWTOFUminq8bx6m6d07jkMiSgWkVrsTzJ9cZm+LD9alcHMBdCSXWVEabJkIsTZPUW4BdIIWO0mjsEXzu2XuZMCdzEYE/ijXosicTsPcupz/vRtMCVqNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nczMR5Gn; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739910930; x=1771446930;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6xEuCQGhQlAngHoW3mdQa2421ClO1jvKoWpuUAKtSvw=;
  b=nczMR5GnX1DsxXdx5V1X95oV8zavhxYAVNLiaKC81dDN8rT3woyD9P5W
   OnB250NRgrpnFgxkH/4InPvSbNR/9wB0fud1d6EP0+BgS7J+5qPbsyFzS
   UlXQwOCiXst/j3BA+er/NNCJSe4vc2gnuKtW9vCjxTynKQacI5GYuPzeF
   o=;
X-IronPort-AV: E=Sophos;i="6.13,296,1732579200"; 
   d="scan'208";a="463708957"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2025 20:35:29 +0000
Received: from EX19MTAUEA001.ant.amazon.com [10.0.44.209:27239]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.30.208:2525] with esmtp (Farcaster)
 id 9b4fb3bb-24e5-477a-a48c-0c025dae018a; Tue, 18 Feb 2025 20:35:28 +0000 (UTC)
X-Farcaster-Flow-ID: 9b4fb3bb-24e5-477a-a48c-0c025dae018a
Received: from EX19D008UEC003.ant.amazon.com (10.252.135.194) by
 EX19MTAUEA001.ant.amazon.com (10.252.134.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 18 Feb 2025 20:35:28 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D008UEC003.ant.amazon.com (10.252.135.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Feb 2025 20:35:27 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 18 Feb 2025 20:35:27 +0000
Received: from dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com (dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com [10.189.199.127])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTP id CD6A8404A9;
	Tue, 18 Feb 2025 20:35:27 +0000 (UTC)
Received: by dev-dsk-wanjay-2c-b9f4719a.us-west-2.amazon.com (Postfix, from userid 30684173)
	id 906BF4FA4; Tue, 18 Feb 2025 20:35:27 +0000 (UTC)
From: Jay Wang <wanjay@amazon.com>
To: <stable@vger.kernel.org>
CC: Jay Wang <wanjay@amazon.com>, David Woodhouse <dwmw@amazon.co.uk>, "Thomas
 Gleixner" <tglx@linutronix.de>, Michael Kelley <mhkelley@outlook.com>
Subject: [PATCH v5.10/v5.15/v6.1] x86/i8253: Disable PIT timer 0 when not in use
Date: Tue, 18 Feb 2025 20:35:23 +0000
Message-ID: <20250218203526.17408-1-wanjay@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

commit 70e6b7d9ae3c63df90a7bba7700e8d5c300c3c60 upstream

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
Signed-off-by: Jay Wang <wanjay@amazon.com>
Cc: stable@vger.kernel.org #v5.10/v5.15/v6.1
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



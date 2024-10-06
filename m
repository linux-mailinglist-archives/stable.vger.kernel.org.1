Return-Path: <stable+bounces-81202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A71E99219C
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 23:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82C51F20FEE
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 21:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B1018A6BD;
	Sun,  6 Oct 2024 21:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nBY/9RlZ"
X-Original-To: stable@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9616F265
	for <stable@vger.kernel.org>; Sun,  6 Oct 2024 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728249503; cv=none; b=RMSABHl649DWu9KFxwZJQ51wBAn7St692tmLRzfRIRJnURAV0sMMuV3fDrol8khpjFJuFu1MS1uFgM8p2wQeT5PTmK1Wvv2XThDN4FcSaoMnEghMCAb2muIrfLepyb42Pu0CNuj7c36OyIdw5PXMQbmNt5PdT5lVDjGhUAhOoKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728249503; c=relaxed/simple;
	bh=Dzgy8bFVFDENsREqyKGcDc7kuihgR+Tz9cJKiL1EMHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jO9cXIoJnb36PDmNXnf/6++8hG/tGvmdtm7mlvIuOebpmDyxR9wRhTFpfjl8Zr/F/RN5vENW+fF8yc1bwBm3wVDms0HYalXdzh80OHlRiF3xnba/OGaBO3xcJnUHA8X7+R99zBr6fmLk0uKX4hxG5pC+jc6L8xRNaysMZUwqT9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nBY/9RlZ; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description; bh=POXOaZpzTNuBMaCcG7kfW4vaZSxHavHBOPPiRK5huy0=; b=nBY/
	9RlZSPPyySLNwUghahOrqvzOcmNO2QPkby13pb9HO67U38ES8iF3wfWXDandAE7U5g+YZISqp9kyb
	aSrZoykOKifHaszGkZmLs+Sgn87cuGyck2Zsp45xWrOqC8SovRju3gDDQaT5c07VeH2JupWueHC+S
	TjeAQ2NwX1IhduwMVbZ8OcjfAavGe2O5xtijUAan0LXFzFv8+5iZ7s8dHPyOPr67HNunFT2ziAllL
	knQG9Yityopcbf8Ulubjco8sLNZs6EEavvqIpzJD82P6Z4Yiucjwe39HQKjteFwLRLhIoKKQ9RLmo
	5NWnQ0QeEDi5rOvPIWXUfqy0hG2EsA==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1sxYDu-003U6X-Mq; Sun, 06 Oct 2024 20:51:26 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: stable@vger.kernel.org
Cc: xiao sheng wen <atzlinux@sina.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6.10.x] cpufreq: intel_pstate: Make hwp_notify_lock a raw spinlock
Date: Sun,  6 Oct 2024 22:51:06 +0200
Message-ID: <20241006205106.385009-5-ukleinek@debian.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241006205106.385009-4-ukleinek@debian.org>
References: <20241006205106.385009-4-ukleinek@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3541; i=ukleinek@debian.org; h=from:subject; bh=Dzgy8bFVFDENsREqyKGcDc7kuihgR+Tz9cJKiL1EMHU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnAvg9wwymWiz9i0kmqn/t/QhyuDzIhBPrY5kbi HGeBkFUiUeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZwL4PQAKCRCPgPtYfRL+ Tq04B/9xa0ox6CGukbPcl1kRozqvNyXq2254AH4NmsREd6s9oT65sR6O0nbuo2jH18nCTuDC9ig 4/ZShsYtxpAHbKuDHnoEv2b4SzZnvm5iFSlNLM1ct9O4zi7FLisNK2VnuewMwqUss6dGzYjdbXc +grlraYpJ7oJ53GV/KL4LTx/Qfv+G4EXpLW8vC74nsaSuOoUyMAvBzGVgfqZPtjlj7hlQ2IIhMr ncGIObPWWJErHlzcutEvJpQ5RwwmYykbkazHv5m0oteWCUcnnBT5S6Dv7MsQgZ+gagYe4G2G1kN VXQse41Qsp9j55w+v/Bj0iSlxAX6GNai2un9BOcwRoFx9CWy
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

commit 8b4865cd904650cbed7f2407e653934c621b8127 upstream.

notify_hwp_interrupt() is called via sysvec_thermal() ->
smp_thermal_vector() -> intel_thermal_interrupt() in hard irq context.
For this reason it must not use a simple spin_lock that sleeps with
PREEMPT_RT enabled. So convert it to a raw spinlock.

Reported-by: xiao sheng wen <atzlinux@sina.com>
Link: https://bugs.debian.org/1076483
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: xiao sheng wen <atzlinux@sina.com>
Link: https://patch.msgid.link/20240919081121.10784-2-ukleinek@debian.org
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ukleinek: Backport to v6.10.y]
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 drivers/cpufreq/intel_pstate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index c31914a9876f..b694e474acec 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1622,7 +1622,7 @@ static void intel_pstate_notify_work(struct work_struct *work)
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
 }
 
-static DEFINE_SPINLOCK(hwp_notify_lock);
+static DEFINE_RAW_SPINLOCK(hwp_notify_lock);
 static cpumask_t hwp_intr_enable_mask;
 
 void notify_hwp_interrupt(void)
@@ -1638,7 +1638,7 @@ void notify_hwp_interrupt(void)
 	if (!(value & 0x01))
 		return;
 
-	spin_lock_irqsave(&hwp_notify_lock, flags);
+	raw_spin_lock_irqsave(&hwp_notify_lock, flags);
 
 	if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
 		goto ack_intr;
@@ -1646,13 +1646,13 @@ void notify_hwp_interrupt(void)
 	schedule_delayed_work(&all_cpu_data[this_cpu]->hwp_notify_work,
 			      msecs_to_jiffies(10));
 
-	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+	raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
 
 	return;
 
 ack_intr:
 	wrmsrl_safe(MSR_HWP_STATUS, 0);
-	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+	raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
 }
 
 static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
@@ -1665,9 +1665,9 @@ static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
 	/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
-	spin_lock_irq(&hwp_notify_lock);
+	raw_spin_lock_irq(&hwp_notify_lock);
 	cancel_work = cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask);
-	spin_unlock_irq(&hwp_notify_lock);
+	raw_spin_unlock_irq(&hwp_notify_lock);
 
 	if (cancel_work)
 		cancel_delayed_work_sync(&cpudata->hwp_notify_work);
@@ -1677,10 +1677,10 @@ static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
 {
 	/* Enable HWP notification interrupt for guaranteed performance change */
 	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
-		spin_lock_irq(&hwp_notify_lock);
+		raw_spin_lock_irq(&hwp_notify_lock);
 		INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
 		cpumask_set_cpu(cpudata->cpu, &hwp_intr_enable_mask);
-		spin_unlock_irq(&hwp_notify_lock);
+		raw_spin_unlock_irq(&hwp_notify_lock);
 
 		/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
-- 
2.45.2



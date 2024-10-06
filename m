Return-Path: <stable+bounces-81203-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B93839921AA
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 23:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71CFB280CB6
	for <lists+stable@lfdr.de>; Sun,  6 Oct 2024 21:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB021714C9;
	Sun,  6 Oct 2024 21:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="e2CVKnCj"
X-Original-To: stable@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197BD170A3E
	for <stable@vger.kernel.org>; Sun,  6 Oct 2024 21:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250247; cv=none; b=idHcr6tpC7fcuERpKQXj3xso6BOlRAdOlk2tt9mFBcOvB4KtlwNQip/qa68m3f5Aw2YV+t/L+P7x2GludgX1QyoODzMBI1n7CNymB2muBRb8Tr3qMtrL4XS8zxtLJdNmt38Cd9aXZ8zpgRUR3fYWxjEdkvevtDshLNJkI5wur3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250247; c=relaxed/simple;
	bh=plvdcIrF+/9PMWZAX4XUy05CstB2iv+ZEdy+RNH/OsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gd18Bg2MlV5ErfvYWYXoK+6TSTINgSN2QXNIGVsf/iuKwb64krluK0FBgda7oiXqIHPvrwQHaicOwazOBjk9MmNigXKU1Yul+54LNGzMs0NPnsmtwGs2kpQ/Gm4MWBd69EwHgLACriKONQS/BRbo21npdGAt0w7oR2t+RP0Xd44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=e2CVKnCj; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description; bh=zdBDZgetkh5UgI2D2SQbdbYvtZ+RJqSi4tcrK665tTc=; b=e2CV
	KnCjy5jfrgR/TeZvmI3o5/LKiZ3K8Er1CWbTQOfsgeweszpFRP9N13sLm/sm7Hu6+Y6bF85m+nmgT
	ACKFfihHSj6QZDKNKZwlSUkZOFsJ7XXw2mX5m0BTyA5xN9w9/q9gRjIVw9e1yS/JlsEPfZo4jCxRT
	DHl8DrZdUxxeRQg44w/8PQfP+cdKVznx9WTQ77X9N7KZpLJXiui906mGQb/9QAW3ko+SW8l6QYFwi
	dbqHgyKVbY4qUo21w/qGsfDiaNCaFH4i1cQD6+/eEOzmd4qZYQargMtXmNJzzsmbott6aE3X+BRuL
	7UHN3eH3VXyEWpYMr6lJ193I1ofnYQ==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1sxYDv-003U6l-Ra; Sun, 06 Oct 2024 20:51:27 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: stable@vger.kernel.org
Cc: xiao sheng wen <atzlinux@sina.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v6.6.x] cpufreq: intel_pstate: Make hwp_notify_lock a raw spinlock
Date: Sun,  6 Oct 2024 22:51:07 +0200
Message-ID: <20241006205106.385009-6-ukleinek@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4038; i=ukleinek@debian.org; h=from:subject; bh=plvdcIrF+/9PMWZAX4XUy05CstB2iv+ZEdy+RNH/OsE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnAvg/2ByivPLbvtRDQFQ+6+yVX33eUqqBIZvNU Mh72COdR7eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZwL4PwAKCRCPgPtYfRL+ TtWmB/0Y6nyrcTZqmPoZyRUD2odvxBeiizHKneQPk4BG6p6yf55/di7HwQCTzKucdXVqGhc0795 TwcbOcnMhs5CtK0onBb1ci+TJ64hZgVFppVUHJJmqsV+6GgH+PzaabDajf/WH0JAxCnd09s0wIZ ShFg4D6UYHqbxcU3pR7J1SbQuDPId1vs990ZgYBqIjUXIH+foHEO3wRGn4n0oo1dcqHXwy19xE5 +cmoEp391RVJaMMC7bL2KucPH6Xjozu1Azy/aTpxQ7M93eS/vCAAxm2eLvQsgmbwucBtjzByLh5 TqGE3CvlHoqwb8tPbMtNR3nrZUthAWowLpivcTvnwVPLfhek
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
[ukleinek: Backport to v6.6.y]
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 drivers/cpufreq/intel_pstate.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0ee3a04bb102..8a4fdf212ce0 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1632,7 +1632,7 @@ static void intel_pstate_notify_work(struct work_struct *work)
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
 }
 
-static DEFINE_SPINLOCK(hwp_notify_lock);
+static DEFINE_RAW_SPINLOCK(hwp_notify_lock);
 static cpumask_t hwp_intr_enable_mask;
 
 void notify_hwp_interrupt(void)
@@ -1649,7 +1649,7 @@ void notify_hwp_interrupt(void)
 	if (!(value & 0x01))
 		return;
 
-	spin_lock_irqsave(&hwp_notify_lock, flags);
+	raw_spin_lock_irqsave(&hwp_notify_lock, flags);
 
 	if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
 		goto ack_intr;
@@ -1673,13 +1673,13 @@ void notify_hwp_interrupt(void)
 
 	schedule_delayed_work(&cpudata->hwp_notify_work, msecs_to_jiffies(10));
 
-	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+	raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
 
 	return;
 
 ack_intr:
 	wrmsrl_safe(MSR_HWP_STATUS, 0);
-	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+	raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
 }
 
 static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
@@ -1692,10 +1692,10 @@ static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
 	/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
-	spin_lock_irqsave(&hwp_notify_lock, flags);
+	raw_spin_lock_irqsave(&hwp_notify_lock, flags);
 	if (cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask))
 		cancel_delayed_work(&cpudata->hwp_notify_work);
-	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+	raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
 }
 
 static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
@@ -1704,10 +1704,10 @@ static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
 	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&hwp_notify_lock, flags);
+		raw_spin_lock_irqsave(&hwp_notify_lock, flags);
 		INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
 		cpumask_set_cpu(cpudata->cpu, &hwp_intr_enable_mask);
-		spin_unlock_irqrestore(&hwp_notify_lock, flags);
+		raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
 
 		/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
@@ -3136,10 +3136,10 @@ static void intel_pstate_driver_cleanup(void)
 			if (intel_pstate_driver == &intel_pstate)
 				intel_pstate_clear_update_util_hook(cpu);
 
-			spin_lock(&hwp_notify_lock);
+			raw_spin_lock(&hwp_notify_lock);
 			kfree(all_cpu_data[cpu]);
 			WRITE_ONCE(all_cpu_data[cpu], NULL);
-			spin_unlock(&hwp_notify_lock);
+			raw_spin_unlock(&hwp_notify_lock);
 		}
 	}
 	cpus_read_unlock();
-- 
2.45.2



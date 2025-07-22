Return-Path: <stable+bounces-163717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 710EDB0DB2D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E2921AA2043
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A672E9EA6;
	Tue, 22 Jul 2025 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIl4rq97"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CFD185E4A
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 13:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753191872; cv=none; b=iN0Riq4H0HB3ue8oF4nqs3HigsGF/DT+h4JCzjTAc9gacfeH3l+A1ZEvTef9OjMFwKymx/RIN6gEe6mffu4bu3kBIS1opRFPq3XP4FyLWJd5zo29V1Rx2+Wr/B0xOk4SYe9+wj9RDAiHAg0xIvJ4SND4VuUv/jbqeNUbaLsdi50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753191872; c=relaxed/simple;
	bh=ZtJgf4DGQyVwnnTV8EAnyoUyBcHmifjHAXaCcmNycFc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FByXKcjOkjugqvl/mOZ+gieN0IftyTAaL8kfGVxJU4WbnZO4qlW3tkXgUOlBTzmtch716c0VswD+xALq7DwPOAJZgjj0jjLmHmCvteNo6Zu3PEHCPk4/Xac45eyGxefPQzVSh/kAUDDSPkYu5jWYdHoCe62mrywwpA+8zRBFDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIl4rq97; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4792AC4CEEB;
	Tue, 22 Jul 2025 13:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753191872;
	bh=ZtJgf4DGQyVwnnTV8EAnyoUyBcHmifjHAXaCcmNycFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CIl4rq97pkeT8XxVnzpkeZPoVLWKO1OlrCyW4OTNEj32c8zs+BJO6wmDR18ZpAGFl
	 SgNO4WCoqg9oZKN3m9RH3nJGz+svJWM3l1ZC0P+4r5u0Bl1GH7W+Gbk4sDQcHx8IJN
	 2In/cuVSLarV9WfslHW5NGIVGHzO9SgVhUNIRJdjj6a4EKHy5Zwy2MeajOrH40GZ5p
	 e/oX9Z99NLa4GX/7nHE/WD6+/2VPfphGYqQ7jpzfC9mMB/aMv3tZexjUKVrZlQqrQJ
	 LWSKRXk1YDq3IsOLyITFrkjZ4zt+6t0Irn5kjN72o6pgWF1GzvIoSQ0MHwVzgzLeaY
	 4hm37Jcmu+RGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] pmdomain: governor: Consider CPU latency tolerance from pm_domain_cpu_gov
Date: Tue, 22 Jul 2025 09:44:28 -0400
Message-Id: <20250722134428.946158-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072113-grill-thimble-5d5c@gregkh>
References: <2025072113-grill-thimble-5d5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maulik Shah <maulik.shah@oss.qualcomm.com>

[ Upstream commit 500ba33284416255b9a5b50ace24470b6fe77ea5 ]

pm_domain_cpu_gov is selecting a cluster idle state but does not consider
latency tolerance of child CPUs. This results in deeper cluster idle state
whose latency does not meet latency tolerance requirement.

Select deeper idle state only if global and device latency tolerance of all
child CPUs meet.

Test results on SM8750 with 300 usec PM-QoS on CPU0 which is less than
domain idle state entry (2150) + exit (1983) usec latency mentioned in
devicetree, demonstrate the issue.

	# echo 300 > /sys/devices/system/cpu/cpu0/power/pm_qos_resume_latency_us

Before: (Usage is incrementing)
======
	# cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
	State          Time Spent(ms) Usage      Rejected   Above      Below
	S0             29817          537        8          270        0

	# cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
	State          Time Spent(ms) Usage      Rejected   Above      Below
	S0             30348          542        8          271        0

After: (Usage is not incrementing due to latency tolerance)
======
	# cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
	State          Time Spent(ms) Usage      Rejected   Above      Below
	S0             39319          626        14         307        0

	# cat /sys/kernel/debug/pm_genpd/power-domain-cluster0/idle_states
	State          Time Spent(ms) Usage      Rejected   Above      Below
	S0             39319          626        14         307        0

Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
Fixes: e94999688e3a ("PM / Domains: Add genpd governor for CPUs")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250709-pmdomain_qos-v2-1-976b12257899@oss.qualcomm.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[ adapted file path from drivers/pmdomain/governor.c to drivers/base/power/domain_governor.c ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/domain_governor.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 490ed7deb99a7..99427e18e6237 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -8,6 +8,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/hrtimer.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/ktime.h>
@@ -254,6 +255,8 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct cpuidle_device *dev;
 	ktime_t domain_wakeup, next_hrtimer;
+	struct device *cpu_dev;
+	s64 cpu_constraint, global_constraint;
 	s64 idle_duration_ns;
 	int cpu, i;
 
@@ -264,6 +267,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
 		return true;
 
+	global_constraint = cpu_latency_qos_limit();
 	/*
 	 * Find the next wakeup for any of the online CPUs within the PM domain
 	 * and its subdomains. Note, we only need the genpd->cpus, as it already
@@ -277,8 +281,16 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 			if (ktime_before(next_hrtimer, domain_wakeup))
 				domain_wakeup = next_hrtimer;
 		}
+
+		cpu_dev = get_cpu_device(cpu);
+		if (cpu_dev) {
+			cpu_constraint = dev_pm_qos_raw_resume_latency(cpu_dev);
+			if (cpu_constraint < global_constraint)
+				global_constraint = cpu_constraint;
+		}
 	}
 
+	global_constraint *= NSEC_PER_USEC;
 	/* The minimum idle duration is from now - until the next wakeup. */
 	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, ktime_get()));
 	if (idle_duration_ns <= 0)
@@ -291,8 +303,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	 */
 	i = genpd->state_idx;
 	do {
-		if (idle_duration_ns >= (genpd->states[i].residency_ns +
-		    genpd->states[i].power_off_latency_ns)) {
+		if ((idle_duration_ns >= (genpd->states[i].residency_ns +
+		    genpd->states[i].power_off_latency_ns)) &&
+		    (global_constraint >= (genpd->states[i].power_on_latency_ns +
+		    genpd->states[i].power_off_latency_ns))) {
 			genpd->state_idx = i;
 			return true;
 		}
-- 
2.39.5



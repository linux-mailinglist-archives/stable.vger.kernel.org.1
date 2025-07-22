Return-Path: <stable+bounces-163758-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C77B0DB56
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 15:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D751C812BB
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 13:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2788728B7EE;
	Tue, 22 Jul 2025 13:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ine+XqNb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC23289340
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192111; cv=none; b=UHkenODGxLwmY7gJAAYavJQbHdxHWx/yO9PZU0g851ita1MugVcxCn87qvDXhIZm6q+KvtUqY5jt//qbEFZc1Eclig3eVxbLLDOHpvWbTSlxn42+Sk7ELJDvUfz+2F3DQbh2058xPrsMoWa9eVnTvm91R2W55M7ud/6so0KGfVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192111; c=relaxed/simple;
	bh=EB9k1RSeCMPZoU+SqI+O7cBPupLBiZM7RCwKjXpc5Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rHvGd39uYas/pBDCYPqHFd5EZabZwncPi6Qyo9gj5kUtKVp2RPOI73d/MjuiTa5DtikBTq9Al51uL0EgcHGoAGdY3d5sS9lfXZuS1igaccBRnK6Bpx0apv6RqjTHfCfFVOetRt6e0hgmM4lZWXYfTbIyZ2+IEXnWOP6WAEjr8GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ine+XqNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2213C4CEF1;
	Tue, 22 Jul 2025 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753192111;
	bh=EB9k1RSeCMPZoU+SqI+O7cBPupLBiZM7RCwKjXpc5Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ine+XqNbeEMeeBoc95eeoXDzxMigLsjfKOaswyWwUv7PP9rrWkwaJ9PJpKJHtvfZq
	 riG0E6TB/espsyXuBbz1a95GnPbtUoRsk3RFVy1FoyvY+pAanCul18KMdKsS5FbwGN
	 H9z9MMje8gHIOivNLe7oikh81ngHwALp//sSA5fbbZXdoR/oO9feTnMoKNtbV28h2Y
	 Mkj+iCuK1lLAINJBfWyeYCtsN5AYVSuQm0RUCBAqnSakCBT0eRaJVcTnqbS8Eu2LFd
	 rv5WqLrx9vLZw8wwD1E96IIDZLku324Uro4lTr6Dc3A+YcvtPDSwDHlChki51wq8zK
	 hQms+NrkDjCmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] pmdomain: governor: Consider CPU latency tolerance from pm_domain_cpu_gov
Date: Tue, 22 Jul 2025 09:48:27 -0400
Message-Id: <20250722134827.947709-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072114-matriarch-decline-2598@gregkh>
References: <2025072114-matriarch-decline-2598@gregkh>
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
[ replaced cpu_latency_qos_limit() with pm_qos_request(PM_QOS_CPU_DMA_LATENCY) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/power/domain_governor.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 490ed7deb99a7..35f2e961756b2 100644
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
 
+	global_constraint = pm_qos_request(PM_QOS_CPU_DMA_LATENCY);
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



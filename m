Return-Path: <stable+bounces-163560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B44C2B0C264
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 13:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB77189504F
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 11:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50592989B4;
	Mon, 21 Jul 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GgWMkUt2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BA3298996
	for <stable@vger.kernel.org>; Mon, 21 Jul 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753096453; cv=none; b=LfT7LbVYpaS7ZXa1VoBIenpFOy4lNS2HvI8xOK4gPj1htVYe0I9z3kazmqHe4+27lgyMPwVgU0a0R7eYs812DDWdl6vP1rm7f6rtGS3vIIK6Kni65L+A5Zte/pseFHbLZEbWBXVYBBB+gGRp4Dp3gF8ozCMaFxDCG4oVZjhhm1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753096453; c=relaxed/simple;
	bh=E4yOPJ8E9+iaPVatNDWnqqAtSkuKotEZziIYqrXVBJA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dxtEMC6cn3UpcsvAZfqA1xAV7h+IeNQkouDOmsDUlWs/AwQ7/uO0Qv2Tkv3BCrBtjamJsclmET8lLgEoH2tbLds6VGyJWqgaDBhToq0nZXJq/URlrUp7WU3P0hvOWQXV7c6lnzhqriqRo115kxj8GxGZHjjTgDk0oRInGKdz4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GgWMkUt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 142B8C4CEED;
	Mon, 21 Jul 2025 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753096453;
	bh=E4yOPJ8E9+iaPVatNDWnqqAtSkuKotEZziIYqrXVBJA=;
	h=Subject:To:Cc:From:Date:From;
	b=GgWMkUt2qyLiJVm4uKXrx2JD2VFBrjD3xN3jdN8hn7CN7BGOx0se6iZ5o2tSJLka/
	 Oek9ZxVjhGeHC2VQpkFzULronuFgnEDQNgXSJDjH1Cgx6cSWaZ9O4aBwtLB5pREZAh
	 r8GSZYyXcd/49lPNIh7LUP9xQf47S6fa/kjhOS/c=
Subject: FAILED: patch "[PATCH] pmdomain: governor: Consider CPU latency tolerance from" failed to apply to 5.10-stable tree
To: maulik.shah@oss.qualcomm.com,ulf.hansson@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 21 Jul 2025 13:13:14 +0200
Message-ID: <2025072113-grill-thimble-5d5c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 500ba33284416255b9a5b50ace24470b6fe77ea5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025072113-grill-thimble-5d5c@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 500ba33284416255b9a5b50ace24470b6fe77ea5 Mon Sep 17 00:00:00 2001
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Wed, 9 Jul 2025 14:00:11 +0530
Subject: [PATCH] pmdomain: governor: Consider CPU latency tolerance from
 pm_domain_cpu_gov

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

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index c1e148657c87..39359811a930 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -8,6 +8,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_qos.h>
 #include <linux/hrtimer.h>
+#include <linux/cpu.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/ktime.h>
@@ -349,6 +350,8 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	struct cpuidle_device *dev;
 	ktime_t domain_wakeup, next_hrtimer;
 	ktime_t now = ktime_get();
+	struct device *cpu_dev;
+	s64 cpu_constraint, global_constraint;
 	s64 idle_duration_ns;
 	int cpu, i;
 
@@ -359,6 +362,7 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
 		return true;
 
+	global_constraint = cpu_latency_qos_limit();
 	/*
 	 * Find the next wakeup for any of the online CPUs within the PM domain
 	 * and its subdomains. Note, we only need the genpd->cpus, as it already
@@ -372,8 +376,16 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
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
 	idle_duration_ns = ktime_to_ns(ktime_sub(domain_wakeup, now));
 	if (idle_duration_ns <= 0)
@@ -389,8 +401,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
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
 			genpd->gd->last_enter = now;
 			genpd->gd->reflect_residency = true;



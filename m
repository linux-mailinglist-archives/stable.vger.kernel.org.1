Return-Path: <stable+bounces-164126-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EA1B0DDC2
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 16:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E47CA1C88186
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988EA2EBB8F;
	Tue, 22 Jul 2025 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QFCdtrp2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E642EA168;
	Tue, 22 Jul 2025 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193333; cv=none; b=VW2EL/CvOnMjfDfX6613H235/ykN91pPAnSNsPzqNzILEcShVMJ7/SqypZO+zuv9Dnt7j3TkB7ge5zdu7Nh6rKrBJJGaDdFktCkUq/ZETueAkkDPxu4GVoZBlVtrALVNpJiGxjNct/RG+gw6jr31bV1gGHkcxYPxxJ08b+miIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193333; c=relaxed/simple;
	bh=l4MZZ+KIFsRMYNcMNoLQC8GzKLu6RWqi9PZ/y57rZv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5oUo4RbcNymW5DlzuPdhUgs2p10gSAxmJysxMIN7JFaObAbWjccbe8V4w963YGVLepBXq40eJtYVGiFPbSPjf0kGpm0wyZM3Njde5Yue9Wm3y6G0kw1TzoT2B8oHisM0ZEUi5VxfE15e5uvW0S+WR2eUr2z/kbB9gKJuvtO400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QFCdtrp2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7087C4CEEB;
	Tue, 22 Jul 2025 14:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753193333;
	bh=l4MZZ+KIFsRMYNcMNoLQC8GzKLu6RWqi9PZ/y57rZv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QFCdtrp26ypybhF8caB5Up52nZN8vYbUmQRkk6MGsG8bRKmauP7k9mzxxgvvkAKTv
	 D/kWYs5sSZDEwkTYrme/BDJupwJHK5d6fHA2+yla+0Psn37Py44TYH4A7WySq44U6T
	 hGhgcgbFtpARh52gmslmdYET6Ms/7Mv2wGepKZg4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Raghavendra Kakarla <quic_rkakarla@quicinc.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.15 060/187] cpuidle: psci: Fix cpuhotplug routine with PREEMPT_RT=y
Date: Tue, 22 Jul 2025 15:43:50 +0200
Message-ID: <20250722134347.992291537@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
References: <20250722134345.761035548@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Lezcano <daniel.lezcano@linaro.org>

commit 621a88dbfe9006c318a0cafbd12e677ccfe006e7 upstream.

Currently cpu hotplug with the PREEMPT_RT option set in the kernel is
not supported because the underlying generic power domain functions
used in the cpu hotplug callbacks are incompatible from a lock point
of view. This situation prevents the suspend to idle to reach the
deepest idle state for the "cluster" as identified in the
undermentioned commit.

Use the compatible ones when PREEMPT_RT is enabled and remove the
boolean disabling the hotplug callbacks with this option.

With this change the platform can reach the deepest idle state
allowing at suspend time to consume less power.

Tested-on Lenovo T14s with the following script:

echo 0 > /sys/devices/system/cpu/cpu3/online
BEFORE=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }') ;
rtcwake -s 1 -m mem;
AFTER=$(cat /sys/kernel/debug/pm_genpd/power-domain-cpu-cluster0/idle_states | grep S0 | awk '{ print $3 }');
if [ $BEFORE -lt $AFTER ]; then
    echo "Test successful"
else
    echo "Test failed"
fi
echo 1 > /sys/devices/system/cpu/cpu3/online

Fixes: 1c4b2932bd62 ("cpuidle: psci: Enable the hierarchical topology for s2idle on PREEMPT_RT")
Cc: Raghavendra Kakarla <quic_rkakarla@quicinc.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250709154728.733920-1-daniel.lezcano@linaro.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpuidle/cpuidle-psci.c |   23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -39,7 +39,6 @@ struct psci_cpuidle_data {
 static DEFINE_PER_CPU_READ_MOSTLY(struct psci_cpuidle_data, psci_cpuidle_data);
 static DEFINE_PER_CPU(u32, domain_state);
 static bool psci_cpuidle_use_syscore;
-static bool psci_cpuidle_use_cpuhp;
 
 void psci_set_domain_state(u32 state)
 {
@@ -108,8 +107,12 @@ static int psci_idle_cpuhp_up(unsigned i
 {
 	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
 
-	if (pd_dev)
-		pm_runtime_get_sync(pd_dev);
+	if (pd_dev) {
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			pm_runtime_get_sync(pd_dev);
+		else
+			dev_pm_genpd_resume(pd_dev);
+	}
 
 	return 0;
 }
@@ -119,7 +122,11 @@ static int psci_idle_cpuhp_down(unsigned
 	struct device *pd_dev = __this_cpu_read(psci_cpuidle_data.dev);
 
 	if (pd_dev) {
-		pm_runtime_put_sync(pd_dev);
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+			pm_runtime_put_sync(pd_dev);
+		else
+			dev_pm_genpd_suspend(pd_dev);
+
 		/* Clear domain state to start fresh at next online. */
 		psci_set_domain_state(0);
 	}
@@ -180,9 +187,6 @@ static void psci_idle_init_cpuhp(void)
 {
 	int err;
 
-	if (!psci_cpuidle_use_cpuhp)
-		return;
-
 	err = cpuhp_setup_state_nocalls(CPUHP_AP_CPU_PM_STARTING,
 					"cpuidle/psci:online",
 					psci_idle_cpuhp_up,
@@ -243,10 +247,8 @@ static int psci_dt_cpu_init_topology(str
 	 * s2ram and s2idle.
 	 */
 	drv->states[state_count - 1].enter_s2idle = psci_enter_s2idle_domain_idle_state;
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		drv->states[state_count - 1].enter = psci_enter_domain_idle_state;
-		psci_cpuidle_use_cpuhp = true;
-	}
 
 	return 0;
 }
@@ -323,7 +325,6 @@ static void psci_cpu_deinit_idle(int cpu
 
 	dt_idle_detach_cpu(data->dev);
 	psci_cpuidle_use_syscore = false;
-	psci_cpuidle_use_cpuhp = false;
 }
 
 static int psci_idle_init_cpu(struct device *dev, int cpu)




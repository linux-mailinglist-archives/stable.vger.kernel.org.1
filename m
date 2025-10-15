Return-Path: <stable+bounces-185797-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39294BDE2D8
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 13:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27B1B503B66
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 11:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E8B308F31;
	Wed, 15 Oct 2025 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HxJ3vD91"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5942217F56
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760526032; cv=none; b=oU/HwvKYmU9iNbuIhYNNyn2Y3oayfbJM2vjeTAx4EVbM7PLGg5iXYKw7MQfoZmNthh3myL1o/+ojITQbohjEnQL/1RPjRh7GQC8r8pEWX9kDgWk52BTCp0ot+obdNhLc7hcpLiLw0/F0B3aha5IGfekmxtJau/xoo6OAeRzHUb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760526032; c=relaxed/simple;
	bh=J5GF899BMrFKbXwcBpNE9FarAZyVyPSh7tGbzm9MJS4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BQwG5sJ9+otHU67UT2ekgWvDq1XgHETCRrI7TU762L+xScH+mYzNJ83f5yFwO7Lo//2Hs0YhcngJt5UslnsAPXumToxDpxGpit/zLf5GmyQetB4u4UgnfpSdUu8mvgbeTsiesx5bqPueV0larvDZ8dpFVg+hcPMtOJzAlm02dMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HxJ3vD91; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC14C116D0;
	Wed, 15 Oct 2025 11:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760526031;
	bh=J5GF899BMrFKbXwcBpNE9FarAZyVyPSh7tGbzm9MJS4=;
	h=Subject:To:Cc:From:Date:From;
	b=HxJ3vD910GC/iJg8fYYaHNspoAwPfktqglH6kvbK7w9PDTZjoveb/ywWCTactONjD
	 qmSBs7HieRMTgVjeWC6yCSpAC4PJBuIKr2DLKPk0XeF/imuToJUPnpUdJmy1firQYf
	 8OLJa2tSZLfNOPFiRfy2Cw9+yc/D+tm+PY+ahTLM=
Subject: FAILED: patch "[PATCH] cpufreq: Make drivers using CPUFREQ_ETERNAL specify" failed to apply to 6.12-stable tree
To: rafael.j.wysocki@intel.com,qyousef@layalina.io,shawnguo@kernel.org,stable@vger.kernel.org,superm1@kernel.org,viresh.kumar@linaro.org,zhanjie9@hisilicon.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Oct 2025 13:00:28 +0200
Message-ID: <2025101528-barcode-doorstop-420a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f97aef092e199c10a3da96ae79b571edd5362faa
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025101528-barcode-doorstop-420a@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f97aef092e199c10a3da96ae79b571edd5362faa Mon Sep 17 00:00:00 2001
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Date: Fri, 26 Sep 2025 12:12:37 +0200
Subject: [PATCH] cpufreq: Make drivers using CPUFREQ_ETERNAL specify
 transition latency

Commit a755d0e2d41b ("cpufreq: Honour transition_latency over
transition_delay_us") caused platforms where cpuinfo.transition_latency
is CPUFREQ_ETERNAL to get a very large transition latency whereas
previously it had been capped at 10 ms (and later at 2 ms).

This led to a user-observable regression between 6.6 and 6.12 as
described by Shawn:

"The dbs sampling_rate was 10000 us on 6.6 and suddently becomes
 6442450 us (4294967295 / 1000 * 1.5) on 6.12 for these platforms
 because the default transition delay was dropped [...].

 It slows down dbs governor's reacting to CPU loading change
 dramatically.  Also, as transition_delay_us is used by schedutil
 governor as rate_limit_us, it shows a negative impact on device
 idle power consumption, because the device gets slightly less time
 in the lowest OPP."

Evidently, the expectation of the drivers using CPUFREQ_ETERNAL as
cpuinfo.transition_latency was that it would be capped by the core,
but they may as well return a default transition latency value instead
of CPUFREQ_ETERNAL and the core need not do anything with it.

Accordingly, introduce CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS and make
all of the drivers in question use it instead of CPUFREQ_ETERNAL.  Also
update the related Rust binding.

Fixes: a755d0e2d41b ("cpufreq: Honour transition_latency over transition_delay_us")
Closes: https://lore.kernel.org/linux-pm/20250922125929.453444-1-shawnguo2@yeah.net/
Reported-by: Shawn Guo <shawnguo@kernel.org>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: 6.6+ <stable@vger.kernel.org> # 6.6+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://patch.msgid.link/2264949.irdbgypaU6@rafael.j.wysocki
[ rjw: Fix typo in new symbol name, drop redundant type cast from Rust binding ]
Tested-by: Shawn Guo <shawnguo@kernel.org> # with cpufreq-dt driver
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 506437489b4d..7d5079fd1688 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -104,7 +104,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
 	if (!transition_latency)
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	cpumask_copy(policy->cpus, priv->cpus);
 	policy->driver_data = priv;
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index db1c88e9d3f9..e93697d3edfd 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -442,7 +442,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_u32(np, "clock-latency", &transition_latency))
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	/*
 	 * Calculate the ramp time for max voltage change in the
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index fce5aa5ceea0..ae4500ab4891 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -309,7 +309,7 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	latency = readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 1000;
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 	policy->fast_switch_possible = true;
diff --git a/drivers/cpufreq/rcpufreq_dt.rs b/drivers/cpufreq/rcpufreq_dt.rs
index 7e1fbf9a091f..3909022e1c74 100644
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -123,7 +123,7 @@ fn init(policy: &mut cpufreq::Policy) -> Result<Self::PData> {
 
         let mut transition_latency = opp_table.max_transition_latency_ns() as u32;
         if transition_latency == 0 {
-            transition_latency = cpufreq::ETERNAL_LATENCY_NS;
+            transition_latency = cpufreq::DEFAULT_TRANSITION_LATENCY_NS;
         }
 
         policy
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 38c165d526d1..d2a110079f5f 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -294,7 +294,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 
 	latency = perf_ops->transition_latency_get(ph, domain);
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index dcbb0ae7dd47..e530345baddf 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -157,7 +157,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 
 	latency = scpi_ops->get_transition_latency(cpu_dev);
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 
diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index 707c71090cc3..2a1550e1aa21 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -182,7 +182,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
 
 	if (of_property_read_u32(np, "clock-latency",
 				&spear_cpufreq.transition_latency))
-		spear_cpufreq.transition_latency = CPUFREQ_ETERNAL;
+		spear_cpufreq.transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	cnt = of_property_count_u32_elems(np, "cpufreq_tbl");
 	if (cnt <= 0) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 40966512ea18..bc8c083bc16a 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -32,6 +32,9 @@
  */
 
 #define CPUFREQ_ETERNAL			(-1)
+
+#define CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS	NSEC_PER_MSEC
+
 #define CPUFREQ_NAME_LEN		16
 /* Print length for names. Extra 1 space for accommodating '\n' in prints */
 #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
index eea57ba95f24..2ea735700ae7 100644
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -39,7 +39,8 @@
 const CPUFREQ_NAME_LEN: usize = bindings::CPUFREQ_NAME_LEN as usize;
 
 /// Default transition latency value in nanoseconds.
-pub const ETERNAL_LATENCY_NS: u32 = bindings::CPUFREQ_ETERNAL as u32;
+pub const DEFAULT_TRANSITION_LATENCY_NS: u32 =
+        bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 /// CPU frequency driver flags.
 pub mod flags {
@@ -400,13 +401,13 @@ pub fn to_table(mut self) -> Result<TableBox> {
 /// The following example demonstrates how to create a CPU frequency table.
 ///
 /// ```
-/// use kernel::cpufreq::{ETERNAL_LATENCY_NS, Policy};
+/// use kernel::cpufreq::{DEFAULT_TRANSITION_LATENCY_NS, Policy};
 ///
 /// fn update_policy(policy: &mut Policy) {
 ///     policy
 ///         .set_dvfs_possible_from_any_cpu(true)
 ///         .set_fast_switch_possible(true)
-///         .set_transition_latency_ns(ETERNAL_LATENCY_NS);
+///         .set_transition_latency_ns(DEFAULT_TRANSITION_LATENCY_NS);
 ///
 ///     pr_info!("The policy details are: {:?}\n", (policy.cpu(), policy.cur()));
 /// }



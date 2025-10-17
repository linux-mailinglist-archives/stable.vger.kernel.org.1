Return-Path: <stable+bounces-187007-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907C5BE9F39
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C927C4BC1
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABE0242935;
	Fri, 17 Oct 2025 15:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Oj1UMwzu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC52F3370FB;
	Fri, 17 Oct 2025 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714857; cv=none; b=JEysA6Ugy/iyKshTGYR5ceaJ6jWO5Xcgx3omTtAq/blQ5AlmVaSypbnuG5AFpa1PvhX4c8E5x63v5KahRLI1uHC88G8BGMBccyyIWawjMkOs6iO931lv5L8BZl2PO6SJ3Ato4j6G1BmMrxflM0+FMLXGESxjO5z2stluG4aB+LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714857; c=relaxed/simple;
	bh=DtOQElQFSPY1dBSQbhDiyJ9BmqWCvYj8Q2A/ooYxdv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3pGtAxOImdKOZmg9tPB8AJf9000b6x0up0X3S8ANTTbbIjrswOoZ5J+LuozaCsCXcXYJuY8dj2cOPeAaU0512Ukh8U8IpvdwQzmP2c7vceU7Z7RYBt1V9SW1ZQUvq8T2HRlgWPWekDLW04DryB1iXR/aXsLOIPGjRdOFIZS4II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Oj1UMwzu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF6CC4CEE7;
	Fri, 17 Oct 2025 15:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714856;
	bh=DtOQElQFSPY1dBSQbhDiyJ9BmqWCvYj8Q2A/ooYxdv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oj1UMwzug6F0rth/btfDzRKf3RzeibW3//izqHGidIfjEdgDDiRae85uJNznculib
	 9JIqihYxjcSOS53KDVS4dl0xi/PVr+s43ZjhCAr99waqzRZD3R0Tm8rSoy5aLsy3gg
	 iQTb/G4aGi9bBLKj2rvlPdkFprIavRuJGF63xHP0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shawn Guo <shawnguo@kernel.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH 6.17 013/371] cpufreq: Make drivers using CPUFREQ_ETERNAL specify transition latency
Date: Fri, 17 Oct 2025 16:49:48 +0200
Message-ID: <20251017145202.276530039@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

commit f97aef092e199c10a3da96ae79b571edd5362faa upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq-dt.c          |    2 +-
 drivers/cpufreq/imx6q-cpufreq.c       |    2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c |    2 +-
 drivers/cpufreq/rcpufreq_dt.rs        |    2 +-
 drivers/cpufreq/scmi-cpufreq.c        |    2 +-
 drivers/cpufreq/scpi-cpufreq.c        |    2 +-
 drivers/cpufreq/spear-cpufreq.c       |    2 +-
 include/linux/cpufreq.h               |    3 +++
 rust/kernel/cpufreq.rs                |    7 ++++---
 9 files changed, 14 insertions(+), 10 deletions(-)

--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -104,7 +104,7 @@ static int cpufreq_init(struct cpufreq_p
 
 	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
 	if (!transition_latency)
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	cpumask_copy(policy->cpus, priv->cpus);
 	policy->driver_data = priv;
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -442,7 +442,7 @@ soc_opp_out:
 	}
 
 	if (of_property_read_u32(np, "clock-latency", &transition_latency))
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	/*
 	 * Calculate the ramp time for max voltage change in the
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -238,7 +238,7 @@ static int mtk_cpufreq_hw_cpu_init(struc
 
 	latency = readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 1000;
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 	policy->fast_switch_possible = true;
--- a/drivers/cpufreq/rcpufreq_dt.rs
+++ b/drivers/cpufreq/rcpufreq_dt.rs
@@ -123,7 +123,7 @@ impl cpufreq::Driver for CPUFreqDTDriver
 
         let mut transition_latency = opp_table.max_transition_latency_ns() as u32;
         if transition_latency == 0 {
-            transition_latency = cpufreq::ETERNAL_LATENCY_NS;
+            transition_latency = cpufreq::DEFAULT_TRANSITION_LATENCY_NS;
         }
 
         policy
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -294,7 +294,7 @@ static int scmi_cpufreq_init(struct cpuf
 
 	latency = perf_ops->transition_latency_get(ph, domain);
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -157,7 +157,7 @@ static int scpi_cpufreq_init(struct cpuf
 
 	latency = scpi_ops->get_transition_latency(cpu_dev);
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -182,7 +182,7 @@ static int spear_cpufreq_probe(struct pl
 
 	if (of_property_read_u32(np, "clock-latency",
 				&spear_cpufreq.transition_latency))
-		spear_cpufreq.transition_latency = CPUFREQ_ETERNAL;
+		spear_cpufreq.transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	cnt = of_property_count_u32_elems(np, "cpufreq_tbl");
 	if (cnt <= 0) {
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
--- a/rust/kernel/cpufreq.rs
+++ b/rust/kernel/cpufreq.rs
@@ -39,7 +39,8 @@ use macros::vtable;
 const CPUFREQ_NAME_LEN: usize = bindings::CPUFREQ_NAME_LEN as usize;
 
 /// Default transition latency value in nanoseconds.
-pub const ETERNAL_LATENCY_NS: u32 = bindings::CPUFREQ_ETERNAL as u32;
+pub const DEFAULT_TRANSITION_LATENCY_NS: u32 =
+        bindings::CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 /// CPU frequency driver flags.
 pub mod flags {
@@ -400,13 +401,13 @@ impl TableBuilder {
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




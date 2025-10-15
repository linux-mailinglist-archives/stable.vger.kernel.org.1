Return-Path: <stable+bounces-185852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB995BE03BA
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 20:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165BF1A230AA
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43321DDC07;
	Wed, 15 Oct 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg+XN/vR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9C618D636
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 18:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553919; cv=none; b=t52SeeqsbsO6APBAaCj79MhjNEa77SvgDVzaFAcs2A3moNri5p91q+tJv0ZZXOUogB++peQGYbo6yNDpq8ZuviSf7kvSvGeluAtixUkp98FLp2W/WufP4W/KUz0Eq2jMM447ExMJBQ1QIRo7B+szveLd6BsLYP/a0QCgvJ5zdzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553919; c=relaxed/simple;
	bh=TWDxQ/8j9M8b2zOz7bwGoKteRtC1LZvJ/Pa3+xmBLPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=onHauv3ShivJK6m59sUHHDYmWyCzpd5ElvXiJSJzYvS6tSh/cG36oQhcAD2T/iVbjzG0cXIqHZPiLfBjllfMPCkJ7YmxZPYU3wUFStPV8gAdd28u8XH0Z0ds3f19ZIUExhlGRSdXcP0fsA7DPZMpV+WT9PeugLpe4tLLBBD1BM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg+XN/vR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AC2C4CEF8;
	Wed, 15 Oct 2025 18:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760553919;
	bh=TWDxQ/8j9M8b2zOz7bwGoKteRtC1LZvJ/Pa3+xmBLPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gg+XN/vRpzNOmR0XHK03kW8OwK9mcvvmdIvWEETLbXURn9vX8l+le90rTfiMD49Gj
	 ICr0GLHjAykwnSz6AwBabm2b9k8cJrf+hS9nm7bzP7zgn2ukdgURef2dabKraBN1Bn
	 eyzCvK3mJQnUPktMrxIpcbZ8gyjDh+WbDQdWlwN4BZdGBfofIAg3KpKNhnsl5BiVF1
	 f/cktCQ/BklV7OrQ7befaYCAKVrEHXpN6/I2WmJILiBDHhjROocqpeLM2iRr8OoewW
	 my/4+gHVu5wGwk7PQzgygqRqQoEExDyGyy6eIub+udNgXZ6fB3IQRRibTr9GUvify/
	 RfF6gvbF9QxDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Jie Zhan <zhanjie9@hisilicon.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Qais Yousef <qyousef@layalina.io>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] cpufreq: Make drivers using CPUFREQ_ETERNAL specify transition latency
Date: Wed, 15 Oct 2025 14:45:16 -0400
Message-ID: <20251015184516.1496577-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101528-barcode-doorstop-420a@gregkh>
References: <2025101528-barcode-doorstop-420a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

[ Upstream commit f97aef092e199c10a3da96ae79b571edd5362faa ]

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
[ omitted Rust changes ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq-dt.c          | 2 +-
 drivers/cpufreq/imx6q-cpufreq.c       | 2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c | 2 +-
 drivers/cpufreq/scmi-cpufreq.c        | 2 +-
 drivers/cpufreq/scpi-cpufreq.c        | 2 +-
 drivers/cpufreq/spear-cpufreq.c       | 2 +-
 include/linux/cpufreq.h               | 3 +++
 7 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 983443396f8f2..30e1b64d0558f 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -110,7 +110,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 
 	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
 	if (!transition_latency)
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	cpumask_copy(policy->cpus, priv->cpus);
 	policy->driver_data = priv;
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index c20d3ecc5a81e..33c1df7f683e4 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -443,7 +443,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_u32(np, "clock-latency", &transition_latency))
-		transition_latency = CPUFREQ_ETERNAL;
+		transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	/*
 	 * Calculate the ramp time for max voltage change in the
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index aeb5e63045421..1f1ec43aad7ca 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -238,7 +238,7 @@ static int mtk_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	latency = readl_relaxed(data->reg_bases[REG_FREQ_LATENCY]) * 1000;
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 	policy->fast_switch_possible = true;
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index a2ec1addafc93..bb265541671a5 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -280,7 +280,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 
 	latency = perf_ops->transition_latency_get(ph, domain);
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index a191d9bdf667a..bdbc3923629e7 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -157,7 +157,7 @@ static int scpi_cpufreq_init(struct cpufreq_policy *policy)
 
 	latency = scpi_ops->get_transition_latency(cpu_dev);
 	if (!latency)
-		latency = CPUFREQ_ETERNAL;
+		latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	policy->cpuinfo.transition_latency = latency;
 
diff --git a/drivers/cpufreq/spear-cpufreq.c b/drivers/cpufreq/spear-cpufreq.c
index d8ab5b01d46d0..c032dd5d12d3c 100644
--- a/drivers/cpufreq/spear-cpufreq.c
+++ b/drivers/cpufreq/spear-cpufreq.c
@@ -183,7 +183,7 @@ static int spear_cpufreq_probe(struct platform_device *pdev)
 
 	if (of_property_read_u32(np, "clock-latency",
 				&spear_cpufreq.transition_latency))
-		spear_cpufreq.transition_latency = CPUFREQ_ETERNAL;
+		spear_cpufreq.transition_latency = CPUFREQ_DEFAULT_TRANSITION_LATENCY_NS;
 
 	cnt = of_property_count_u32_elems(np, "cpufreq_tbl");
 	if (cnt <= 0) {
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index a604c54ae44da..794e38320f568 100644
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
-- 
2.51.0



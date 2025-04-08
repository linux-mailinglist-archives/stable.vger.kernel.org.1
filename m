Return-Path: <stable+bounces-130640-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC64AA805A1
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90F701B82135
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964C226F44E;
	Tue,  8 Apr 2025 12:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ILQ7rz2q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548962686BC;
	Tue,  8 Apr 2025 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114253; cv=none; b=FV3a0qoZ+EisZFlRZAuF62MZKzZRoI7h4q41c7As6XRbklRsOj2MVRlH1YIZKEDG7MfLv6YS+LPuJ8mF9DaHvfEIj10h65onjFeqx4oWsDvo7nvtBnXQhBR3bNRySJuYonCt1WPubsrDe0L6QXebQlsxXopnQo58tsEBLwyWmFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114253; c=relaxed/simple;
	bh=fe+aH+tLJmve57Duq09apitXzr5eEGSDnlJAcc8Si/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r98qXSC3O052EGZa7caGNGbsBI1Gv0I6qc5bzQtrD4iRhmQQoZZPy2SJTuATVBk23iHKD/Dzwlagu1eUqfUPzvm9l1V5J6sERn+/zqSdzBlwcwtSU6UqQ9/L6t+BWiV94/DpiEfq7D7oW85g+pSSKrtRZk+2TJhdp8vvqmT+FtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ILQ7rz2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D88C4CEE5;
	Tue,  8 Apr 2025 12:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114252;
	bh=fe+aH+tLJmve57Duq09apitXzr5eEGSDnlJAcc8Si/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ILQ7rz2qxo4fPIjNJsH78SueHsOIdmD6Z0v6ePRVop00kT3OEZTL1KAoEKpIG9qWL
	 F1UrjTMoQKxTkdSJIhCQisIO6Mfzlr5pNgU7j5/1+fO70IzvsyELkm0gyeiA/NHk2k
	 v8C77O+l3STxJ9OBI9SEvD8Y02yRD+TH1biD7j8E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sudeep Holla <sudeep.holla@arm.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 037/499] cpufreq: Init cpufreq only for present CPUs
Date: Tue,  8 Apr 2025 12:44:09 +0200
Message-ID: <20250408104852.171611642@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jacky Bai <ping.bai@nxp.com>

[ Upstream commit 45f589b7167f36290d29c79e3a442dc0b13c086a ]

for_each_possible_cpu() is currently used to initialize cpufreq.
However, in cpu_dev_register_generic(), for_each_present_cpu()
is used to register CPU devices which means the CPU devices are
only registered for present CPUs and not all possible CPUs.

With nosmp or maxcpus=0, only the boot CPU is present, lead
to the cpufreq probe failure or defer probe due to no cpu device
available for not present CPUs.

Change for_each_possible_cpu() to for_each_present_cpu() in the
above cpufreq drivers to ensure it only registers cpufreq for
CPUs that are actually present.

Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/armada-8k-cpufreq.c    | 2 +-
 drivers/cpufreq/cpufreq-dt.c           | 2 +-
 drivers/cpufreq/mediatek-cpufreq-hw.c  | 2 +-
 drivers/cpufreq/mediatek-cpufreq.c     | 2 +-
 drivers/cpufreq/mvebu-cpufreq.c        | 2 +-
 drivers/cpufreq/qcom-cpufreq-hw.c      | 2 +-
 drivers/cpufreq/qcom-cpufreq-nvmem.c   | 8 ++++----
 drivers/cpufreq/scmi-cpufreq.c         | 2 +-
 drivers/cpufreq/scpi-cpufreq.c         | 2 +-
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 6 +++---
 drivers/cpufreq/virtual-cpufreq.c      | 2 +-
 11 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index 7a979db81f098..5a3545bd0d8d2 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -47,7 +47,7 @@ static void __init armada_8k_get_sharing_cpus(struct clk *cur_clk,
 {
 	int cpu;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct device *cpu_dev;
 		struct clk *clk;
 
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 3a7c3372bda75..f3913eea5e553 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -303,7 +303,7 @@ static int dt_cpufreq_probe(struct platform_device *pdev)
 	int ret, cpu;
 
 	/* Request resources early so we can return in case of -EPROBE_DEFER */
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		ret = dt_cpufreq_early_init(&pdev->dev, cpu);
 		if (ret)
 			goto err;
diff --git a/drivers/cpufreq/mediatek-cpufreq-hw.c b/drivers/cpufreq/mediatek-cpufreq-hw.c
index 9252ebd60373f..478257523cc3c 100644
--- a/drivers/cpufreq/mediatek-cpufreq-hw.c
+++ b/drivers/cpufreq/mediatek-cpufreq-hw.c
@@ -304,7 +304,7 @@ static int mtk_cpufreq_hw_driver_probe(struct platform_device *pdev)
 	struct regulator *cpu_reg;
 
 	/* Make sure that all CPU supplies are available before proceeding. */
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (!cpu_dev)
 			return dev_err_probe(&pdev->dev, -EPROBE_DEFER,
diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 663f61565cf72..2e4f9ca0af350 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -632,7 +632,7 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, -ENODEV,
 				     "failed to get mtk cpufreq platform data\n");
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		info = mtk_cpu_dvfs_info_lookup(cpu);
 		if (info)
 			continue;
diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
index 7f3cfe668f307..2aad4c04673cc 100644
--- a/drivers/cpufreq/mvebu-cpufreq.c
+++ b/drivers/cpufreq/mvebu-cpufreq.c
@@ -56,7 +56,7 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 	 * it), and registers the clock notifier that will take care
 	 * of doing the PMSU part of a frequency transition.
 	 */
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct device *cpu_dev;
 		struct clk *clk;
 		int ret;
diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index b2e7e89feaac4..dce7cad1813fb 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -306,7 +306,7 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
 	struct of_phandle_args args;
 	int cpu, ret;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpu_np = of_cpu_device_node_get(cpu);
 		if (!cpu_np)
 			continue;
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 3a8ed723a23e5..54f8117103c85 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -489,7 +489,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		nvmem_cell_put(speedbin_nvmem);
 	}
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct dev_pm_opp_config config = {
 			.supported_hw = NULL,
 		};
@@ -543,7 +543,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	dev_err(cpu_dev, "Failed to register platform device\n");
 
 free_opp:
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
@@ -557,7 +557,7 @@ static void qcom_cpufreq_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		dev_pm_domain_detach_list(drv->cpus[cpu].pd_list);
 		dev_pm_opp_clear_config(drv->cpus[cpu].opp_token);
 	}
@@ -568,7 +568,7 @@ static int qcom_cpufreq_suspend(struct device *dev)
 	struct qcom_cpufreq_drv *drv = dev_get_drvdata(dev);
 	unsigned int cpu;
 
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		qcom_cpufreq_suspend_pd_devs(drv, cpu);
 
 	return 0;
diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 07d6f9a9b7c82..66e2d24e5fa17 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -101,7 +101,7 @@ scmi_get_sharing_cpus(struct device *cpu_dev, int domain,
 	int cpu, tdomain;
 	struct device *tcpu_dev;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		if (cpu == cpu_dev->id)
 			continue;
 
diff --git a/drivers/cpufreq/scpi-cpufreq.c b/drivers/cpufreq/scpi-cpufreq.c
index 9e09565e41c09..1f97b949763fa 100644
--- a/drivers/cpufreq/scpi-cpufreq.c
+++ b/drivers/cpufreq/scpi-cpufreq.c
@@ -65,7 +65,7 @@ scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
 	if (domain < 0)
 		return domain;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		if (cpu == cpu_dev->id)
 			continue;
 
diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 17d6a149f580d..47d6840b34899 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -262,7 +262,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	snprintf(name, sizeof(name), "speed%d", speed);
 	config.prop_name = name;
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct device *cpu_dev = get_cpu_device(cpu);
 
 		if (!cpu_dev) {
@@ -288,7 +288,7 @@ static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 	pr_err("Failed to register platform device\n");
 
 free_opp:
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		dev_pm_opp_clear_config(opp_tokens[cpu]);
 	kfree(opp_tokens);
 
@@ -302,7 +302,7 @@ static void sun50i_cpufreq_nvmem_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu)
+	for_each_present_cpu(cpu)
 		dev_pm_opp_clear_config(opp_tokens[cpu]);
 
 	kfree(opp_tokens);
diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
index a050b3a6737f0..272dc3c85106c 100644
--- a/drivers/cpufreq/virtual-cpufreq.c
+++ b/drivers/cpufreq/virtual-cpufreq.c
@@ -138,7 +138,7 @@ static int virt_cpufreq_get_sharing_cpus(struct cpufreq_policy *policy)
 	cur_perf_domain = readl_relaxed(base + policy->cpu *
 					PER_CPU_OFFSET + REG_PERF_DOMAIN_OFFSET);
 
-	for_each_possible_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (!cpu_dev)
 			continue;
-- 
2.39.5





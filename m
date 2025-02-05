Return-Path: <stable+bounces-112446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA20EA28CBC
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 14:53:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5343B16193D
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 13:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5A9149C64;
	Wed,  5 Feb 2025 13:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SSwTyE+W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD151FC0B;
	Wed,  5 Feb 2025 13:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763597; cv=none; b=npAwixisEUPLk5xReBpJkmISk29gLoAwfmt0tFxUxVhhZSFQQksznRghRBXctq+0QRzWRHliOVZ1eOsTYQZZ8DO3A6briFn9vtW2VRaLIHK1q0dLZZUHlTKn4uAjUIBeWDV2N8ucc9vvrZiJdBCIgats46AqKWaMlBFQtUeYaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763597; c=relaxed/simple;
	bh=PFTmEmxHUNE+x0dBDzm4re0C1Ht8gcKkT+cXPjv/Gf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPoAruxy8wIDknKK+mT5m2m48z/Cnl8LzCXa8IydRiNXQRu0l1gaKgm1q+/7iCc9O12Epjz1EFpsc9gkLwWC1md2szpaljNv40X6jRblXlgiaiqx5vgBHDMhBXWIbSUY3ypJ+V0rHXr983nuWhkXaxO0FUtoALKS3lEF4hc7XPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SSwTyE+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D65C4CED1;
	Wed,  5 Feb 2025 13:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738763595;
	bh=PFTmEmxHUNE+x0dBDzm4re0C1Ht8gcKkT+cXPjv/Gf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSwTyE+Wu/Wfv8EUOte6/X4Djy7zzz4AoPHvF4thl/qh2IrBprb4kUkpx4Or97y/w
	 QKF3wg687phuVen2mhRXeEqkEvp09In6j/vUf3MmJ0Yo2GBU11J+OKACzTUXe8qTF1
	 ZQG3AvZdzK+JjBcw9RRdQby4am8Nmh8qA1pRrN6Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 086/393] cpufreq: qcom: Fix qcom_cpufreq_hw_recalc_rate() to query LUT if LMh IRQ is not available
Date: Wed,  5 Feb 2025 14:40:05 +0100
Message-ID: <20250205134423.583277335@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205134420.279368572@linuxfoundation.org>
References: <20250205134420.279368572@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

[ Upstream commit 85d8b11351a8f15d6ec7a5e97909861cb3b6bcec ]

Currently, qcom_cpufreq_hw_recalc_rate() returns the LMh throttled
frequency for the domain even if LMh IRQ is not available. But as per
qcom_cpufreq_hw_get(), the driver has to query LUT entries to get the
actual frequency of the domain. So do the same in
qcom_cpufreq_hw_recalc_rate().

While doing so, refactor the existing qcom_cpufreq_hw_get() function so
that qcom_cpufreq_hw_recalc_rate() can make use of the existing code and
avoid code duplication. This also requires setting the
qcom_cpufreq_data::policy even if LMh IRQ is not available.

Fixes: 4370232c727b ("cpufreq: qcom-hw: Add CPU clock provider support")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 70b0f21968a01..3a4305df5c119 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -142,14 +142,12 @@ static unsigned long qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
 }
 
 /* Get the frequency requested by the cpufreq core for the CPU */
-static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
+static unsigned int qcom_cpufreq_get_freq(struct cpufreq_policy *policy)
 {
 	struct qcom_cpufreq_data *data;
 	const struct qcom_cpufreq_soc_data *soc_data;
-	struct cpufreq_policy *policy;
 	unsigned int index;
 
-	policy = cpufreq_cpu_get_raw(cpu);
 	if (!policy)
 		return 0;
 
@@ -162,12 +160,10 @@ static unsigned int qcom_cpufreq_get_freq(unsigned int cpu)
 	return policy->freq_table[index].frequency;
 }
 
-static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
+static unsigned int __qcom_cpufreq_hw_get(struct cpufreq_policy *policy)
 {
 	struct qcom_cpufreq_data *data;
-	struct cpufreq_policy *policy;
 
-	policy = cpufreq_cpu_get_raw(cpu);
 	if (!policy)
 		return 0;
 
@@ -176,7 +172,12 @@ static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
 	if (data->throttle_irq >= 0)
 		return qcom_lmh_get_throttle_freq(data) / HZ_PER_KHZ;
 
-	return qcom_cpufreq_get_freq(cpu);
+	return qcom_cpufreq_get_freq(policy);
+}
+
+static unsigned int qcom_cpufreq_hw_get(unsigned int cpu)
+{
+	return __qcom_cpufreq_hw_get(cpufreq_cpu_get_raw(cpu));
 }
 
 static unsigned int qcom_cpufreq_hw_fast_switch(struct cpufreq_policy *policy,
@@ -362,7 +363,7 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 	 * If h/w throttled frequency is higher than what cpufreq has requested
 	 * for, then stop polling and switch back to interrupt mechanism.
 	 */
-	if (throttled_freq >= qcom_cpufreq_get_freq(cpu))
+	if (throttled_freq >= qcom_cpufreq_get_freq(cpufreq_cpu_get_raw(cpu)))
 		enable_irq(data->throttle_irq);
 	else
 		mod_delayed_work(system_highpri_wq, &data->throttle_work,
@@ -440,7 +441,6 @@ static int qcom_cpufreq_hw_lmh_init(struct cpufreq_policy *policy, int index)
 		return data->throttle_irq;
 
 	data->cancel_throttle = false;
-	data->policy = policy;
 
 	mutex_init(&data->throttle_lock);
 	INIT_DEFERRABLE_WORK(&data->throttle_work, qcom_lmh_dcvs_poll);
@@ -551,6 +551,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
 
 	policy->driver_data = data;
 	policy->dvfs_possible_from_any_cpu = true;
+	data->policy = policy;
 
 	ret = qcom_cpufreq_hw_read_lut(cpu_dev, policy);
 	if (ret) {
@@ -623,7 +624,7 @@ static unsigned long qcom_cpufreq_hw_recalc_rate(struct clk_hw *hw, unsigned lon
 {
 	struct qcom_cpufreq_data *data = container_of(hw, struct qcom_cpufreq_data, cpu_clk);
 
-	return qcom_lmh_get_throttle_freq(data);
+	return __qcom_cpufreq_hw_get(data->policy) * HZ_PER_KHZ;
 }
 
 static const struct clk_ops qcom_cpufreq_hw_clk_ops = {
-- 
2.39.5





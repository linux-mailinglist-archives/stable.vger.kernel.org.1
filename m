Return-Path: <stable+bounces-158021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD7AE56AB
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 00:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDAC54E0E01
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3196225792;
	Mon, 23 Jun 2025 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ae6TPy7A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13CE223DE8;
	Mon, 23 Jun 2025 22:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717289; cv=none; b=tb3e7fUnugR2hgQRAWy286fXclYbCYvM6ThpnBsiEuFdoUny6cy+ZvyVGeix7GjVdrCdUzW3T8wAHBaqrOZ/GF1fwWo8jPBOTtZM/BXJFRG3RMPTt0JcuO1Of/jFe7EUi4XFTOk6V1SJ6zptiDpTSWgnhQNV6OK7HWtXtlUCOXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717289; c=relaxed/simple;
	bh=GxZ2Ai0PW7tmVWFpqWns4mcVM26JnKyTsz380sh3Q4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqzODFvHzYwDBR4tFgu114bxLHAcvRtmwN+LOR3Xw3vTzu5zXJ4ENn8/8GCuv/TZBuPKtdGFD9vYsAHhll8ac4xfGP0k+Jgbo86pjVgxz69c/HnsC9XyURCTsg8CfP2xFwZ4V72zGXqG+6RgStkJ/SKFZE/FBnUUQQSWax4FqTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ae6TPy7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0D9C4CEEA;
	Mon, 23 Jun 2025 22:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750717289;
	bh=GxZ2Ai0PW7tmVWFpqWns4mcVM26JnKyTsz380sh3Q4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ae6TPy7AhCFM5C7zSXvbXbeXv/WpKRdpaASHfEAhzRMXLuy1iS28iM3Jf39mB1QqB
	 2813Qle9vFKejLnDm3YhMisUoSkHnXh48UUTnVAYdugevpB+D6MQND9H7hotScymDB
	 zadxQC2zsYK2mZVR709REFnL3hXgLO6OxUNYjmSE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Tipton <quic_mdtipton@quicinc.com>,
	Peng Fan <peng.fan@nxp.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 396/508] cpufreq: scmi: Skip SCMI devices that arent used by the CPUs
Date: Mon, 23 Jun 2025 15:07:21 +0200
Message-ID: <20250623130655.005975353@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130645.255320792@linuxfoundation.org>
References: <20250623130645.255320792@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Tipton <quic_mdtipton@quicinc.com>

[ Upstream commit 6c9bb86922728c7a4cceb99f131e00dd87514f20 ]

Currently, all SCMI devices with performance domains attempt to register
a cpufreq driver, even if their performance domains aren't used to
control the CPUs. The cpufreq framework only supports registering a
single driver, so only the first device will succeed. And if that device
isn't used for the CPUs, then cpufreq will scale the wrong domains.

To avoid this, return early from scmi_cpufreq_probe() if the probing
SCMI device isn't referenced by the CPU device phandles.

This keeps the existing assumption that all CPUs are controlled by a
single SCMI device.

Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Tested-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/scmi-cpufreq.c | 36 +++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index e4989764efe2a..6ff77003a96ea 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -299,6 +299,40 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 	.register_em	= scmi_cpufreq_register_em,
 };
 
+static bool scmi_dev_used_by_cpus(struct device *scmi_dev)
+{
+	struct device_node *scmi_np = dev_of_node(scmi_dev);
+	struct device_node *cpu_np, *np;
+	struct device *cpu_dev;
+	int cpu, idx;
+
+	if (!scmi_np)
+		return false;
+
+	for_each_possible_cpu(cpu) {
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev)
+			continue;
+
+		cpu_np = dev_of_node(cpu_dev);
+
+		np = of_parse_phandle(cpu_np, "clocks", 0);
+		of_node_put(np);
+
+		if (np == scmi_np)
+			return true;
+
+		idx = of_property_match_string(cpu_np, "power-domain-names", "perf");
+		np = of_parse_phandle(cpu_np, "power-domains", idx);
+		of_node_put(np);
+
+		if (np == scmi_np)
+			return true;
+	}
+
+	return false;
+}
+
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
 {
 	int ret;
@@ -307,7 +341,7 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 
 	handle = sdev->handle;
 
-	if (!handle)
+	if (!handle || !scmi_dev_used_by_cpus(dev))
 		return -ENODEV;
 
 	perf_ops = handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
-- 
2.39.5





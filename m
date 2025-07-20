Return-Path: <stable+bounces-163483-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F89B0B965
	for <lists+stable@lfdr.de>; Mon, 21 Jul 2025 01:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C910B3AD115
	for <lists+stable@lfdr.de>; Sun, 20 Jul 2025 23:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D735F22FE10;
	Sun, 20 Jul 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSZ2x5a5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989B1E55B
	for <stable@vger.kernel.org>; Sun, 20 Jul 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055243; cv=none; b=uT1wNSzUWFEu2ivmg94So/hK320EnSNfG7LpYuwzz1DjP+GgcUQuRe72vI6laEyb+OFYxTKmfwdWiLd9A0fwFExaEOutL+5Y694Ghw3R4LDy4i3kgo7KELQtRWQC5vt76z924BsWrLZJRAx3MqLjcfLo2u9WW4D0gTuGM+/AyYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055243; c=relaxed/simple;
	bh=j3LxlwqDD1wL+A5o/2YPHhKpoYsKvxfYUSvlitY+OxU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VIUVg3v6u2OViwgOZOacbXMigQVlnPj51Xj/RMPubD/c61BXdzUBGbrf7HczZyYj/07wkFJzlAIwsmQTEytf8L0kPuZjUHl8ZPZj7y8NewGXJa2nZs1AkWN5GRVoXEMmods6xd6fwlN3RnrC3Cc2Idiyes53kwfUo7oSqQbPyO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSZ2x5a5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B753C4CEF6;
	Sun, 20 Jul 2025 23:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753055243;
	bh=j3LxlwqDD1wL+A5o/2YPHhKpoYsKvxfYUSvlitY+OxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSZ2x5a55wReKhli5b8FirRFYPDaRp0+70Ut2yguf5SeuAmBZ11oq/NIXwapFptZT
	 LWGAb13kYXc+9HlAvlI88fMqF0v0pHf00OEhYo/kU9sOLXDZFg/h/NdYpxUmvx77tt
	 bNjPmitNF0mZDPZRuEFdEDLr/C+fk53IQVCVnZvjnvV1WbQlqYPuOV3XnDryDTvwnL
	 reBmMkbRVjLNtq91PYAnd7w+BGITSGO1R7OQcpUQFV6EehKKBbRmaJJlDnFF0mE82W
	 ScIDUq5s3wBydQBvxnFiAh8rboE+HQZ1kJMeM/PTntL1Gv0tiZd4VE48ed3hjfdUlz
	 pypshjJ6t26Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>,
	Wang Wendy <wendy.wang@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/7] powercap: intel_rapl: Use bitmap for Power Limits
Date: Sun, 20 Jul 2025 19:47:03 -0400
Message-Id: <20250720234705.764310-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250720234705.764310-1-sashal@kernel.org>
References: <2025070817-quaintly-lend-80a3@gregkh>
 <20250720234705.764310-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit a38f300bb23c896d2d132a4502086d4bfec2a25e ]

Currently, a RAPL package is registered with the number of Power Limits
supported in each RAPL domain. But this doesn't tell which Power Limits
are available. Using the number of Power Limits supported to guess the
availability of each Power Limit is fragile.

Use bitmap to represent the availability of each Power Limit.

Note that PL1 is mandatory thus it does not need to be set explicitly by
the RAPL Interface drivers.

No functional change intended.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 964209202ebe ("powercap: intel_rapl: Do not change CLAMPING bit if ENABLE bit cannot be changed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/powercap/intel_rapl_common.c               | 14 ++++++--------
 drivers/powercap/intel_rapl_msr.c                  |  6 +++---
 .../intel/int340x_thermal/processor_thermal_rapl.c |  4 ++--
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 87023d6aebf9c..db0016c188f5f 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -575,20 +575,18 @@ static void rapl_init_domains(struct rapl_package *rp)
 				rapl_domain_names[i]);
 
 		rd->id = i;
+
+		/* PL1 is supported by default */
+		rp->priv->limits[i] |= BIT(POWER_LIMIT1);
 		rd->rpl[0].prim_id = PL1_ENABLE;
 		rd->rpl[0].name = pl1_name;
 
-		/*
-		 * The PL2 power domain is applicable for limits two
-		 * and limits three
-		 */
-		if (rp->priv->limits[i] >= 2) {
+		if (rp->priv->limits[i] & BIT(POWER_LIMIT2)) {
 			rd->rpl[1].prim_id = PL2_ENABLE;
 			rd->rpl[1].name = pl2_name;
 		}
 
-		/* Enable PL4 domain if the total power limits are three */
-		if (rp->priv->limits[i] == 3) {
+		if (rp->priv->limits[i] & BIT(POWER_LIMIT4)) {
 			rd->rpl[2].prim_id = PL4_ENABLE;
 			rd->rpl[2].name = pl4_name;
 		}
@@ -786,7 +784,7 @@ static int rapl_read_data_raw(struct rapl_domain *rd,
 	cpu = rd->rp->lead_cpu;
 
 	/* domain with 2 limits has different bit */
-	if (prim == FW_LOCK && rd->rp->priv->limits[rd->id] == 2) {
+	if (prim == FW_LOCK && (rd->rp->priv->limits[rd->id] & BIT(POWER_LIMIT2))) {
 		rpi->mask = POWER_HIGH_LOCK;
 		rpi->shift = 63;
 	}
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index e46a7641e42f6..1094b8fed2365 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -44,8 +44,8 @@ static struct rapl_if_priv rapl_msr_priv_intel = {
 		MSR_DRAM_POWER_LIMIT, MSR_DRAM_ENERGY_STATUS, MSR_DRAM_PERF_STATUS, 0, MSR_DRAM_POWER_INFO },
 	.regs[RAPL_DOMAIN_PLATFORM] = {
 		MSR_PLATFORM_POWER_LIMIT, MSR_PLATFORM_ENERGY_STATUS, 0, 0, 0},
-	.limits[RAPL_DOMAIN_PACKAGE] = 2,
-	.limits[RAPL_DOMAIN_PLATFORM] = 2,
+	.limits[RAPL_DOMAIN_PACKAGE] = BIT(POWER_LIMIT2),
+	.limits[RAPL_DOMAIN_PLATFORM] = BIT(POWER_LIMIT2),
 };
 
 static struct rapl_if_priv rapl_msr_priv_amd = {
@@ -166,7 +166,7 @@ static int rapl_msr_probe(struct platform_device *pdev)
 	rapl_msr_priv->write_raw = rapl_msr_write_raw;
 
 	if (id) {
-		rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] = 3;
+		rapl_msr_priv->limits[RAPL_DOMAIN_PACKAGE] |= BIT(POWER_LIMIT4);
 		rapl_msr_priv->regs[RAPL_DOMAIN_PACKAGE][RAPL_DOMAIN_REG_PL4] =
 			MSR_VR_CURRENT_CONFIG;
 		pr_info("PL4 support detected.\n");
diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
index a205221ec8df9..e070239106f58 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_rapl.c
@@ -15,8 +15,8 @@ static const struct rapl_mmio_regs rapl_mmio_default = {
 	.reg_unit = 0x5938,
 	.regs[RAPL_DOMAIN_PACKAGE] = { 0x59a0, 0x593c, 0x58f0, 0, 0x5930},
 	.regs[RAPL_DOMAIN_DRAM] = { 0x58e0, 0x58e8, 0x58ec, 0, 0},
-	.limits[RAPL_DOMAIN_PACKAGE] = 2,
-	.limits[RAPL_DOMAIN_DRAM] = 2,
+	.limits[RAPL_DOMAIN_PACKAGE] = BIT(POWER_LIMIT2),
+	.limits[RAPL_DOMAIN_DRAM] = BIT(POWER_LIMIT2),
 };
 
 static int rapl_mmio_cpu_online(unsigned int cpu)
-- 
2.39.5



Return-Path: <stable+bounces-206019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A705CFA5EB
	for <lists+stable@lfdr.de>; Tue, 06 Jan 2026 19:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C00A3349FB96
	for <lists+stable@lfdr.de>; Tue,  6 Jan 2026 18:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B05362120;
	Tue,  6 Jan 2026 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXgdHYCM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CA1361DB7
	for <stable@vger.kernel.org>; Tue,  6 Jan 2026 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767723025; cv=none; b=o3rFrLxCDjetb8OE08zH+6qwSfFo+VntJXdhBw0hazo2Zo/2trisNWVL6n7HfcGbnxuK5yB4m1dLOaxu4ZooiEFNAU+ko/9JJRpRWLeurh/y2LXE0J5dSVImZoip7Ep93N/zpsb2sy+XeFUwQTUrsIY1DNiDrcmGjHIy8tWnS5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767723025; c=relaxed/simple;
	bh=H8JY0sxXTdkK1XAL3E6igWsRDe7QVUUUxI/YceReXKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OsWcnGAfgNAPNX67geMZKyAmi27KgFqccBXMW/S6tjgmWIaImP2mCXikIR8R83FPRRt8WshFPhZFrnYn4tldJxMxOD2IiacvJM3619+OkWHxvbPgTbR2nXSTYKR0MJ1X59uRwNgO9FJcbDAN/uD7c8dmnCARnKD1SWqxhJGhqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXgdHYCM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819EFC116C6;
	Tue,  6 Jan 2026 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767723025;
	bh=H8JY0sxXTdkK1XAL3E6igWsRDe7QVUUUxI/YceReXKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gXgdHYCMKnTtHfzkObzouJZRlUV353clnVNc80gNkOfx2lZLmB2ElffqNpVIhuoZf
	 zmT1F3CmvwIrThugyG8m6QfQ1fBzwsq5fy3GqxfvfDxsUndJKPdUTVy9jzhBzIBVs6
	 zvCxZx26q7TdqPZJOMxUAoWlJKTRRWLvLLoVm9pSS/xxBOJCqmwExSED6WkBnAAPbG
	 2hfmXbMpBlJNZRJtJrBswoJ0W9RN53kX31ToSL9MT88BJ8VCkkwfR9QBdJ17RyUWiF
	 kH24wrwN0ymI0yB2F4X47elf38gW96Iew+7xyu8IxqiK2oGdQVLy7LqjZqbf9hsArh
	 nEZQTQbFJaDqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Brian Norris <briannorris@chromium.org>,
	Peter Geis <pgwipeout@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] soc: rockchip: power-domain: Manage resource conflicts with firmware
Date: Tue,  6 Jan 2026 13:10:14 -0500
Message-ID: <20260106181021.3109327-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010515-dragonish-pelican-5b3c@gregkh>
References: <2026010515-dragonish-pelican-5b3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@chromium.org>

[ Upstream commit defec178df76e0caadd4e8ef68f3d655a2088198 ]

On RK3399 platforms, power domains are managed mostly by the kernel
(drivers/soc/rockchip/pm_domains.c), but there are a few exceptions
where ARM Trusted Firmware has to be involved:

(1) system suspend/resume
(2) DRAM DVFS (a.k.a., "ddrfreq")

Exception (1) does not cause much conflict, since the kernel has
quiesced itself by the time we make the relevant PSCI call.

Exception (2) can cause conflict, because of two actions:

(a) ARM Trusted Firmware needs to read/modify/write the PMU_BUS_IDLE_REQ
    register to idle the memory controller domain; the kernel driver
    also has to touch this register for other domains.
(b) ARM Trusted Firmware needs to manage the clocks associated with
    these domains.

To elaborate on (b): idling a power domain has always required ungating
an array of clocks; see this old explanation from Rockchip:
https://lore.kernel.org/linux-arm-kernel/54503C19.9060607@rock-chips.com/

Historically, ARM Trusted Firmware has avoided this issue by using a
special PMU_CRU_GATEDIS_CON0 register -- this register ungates all the
necessary clocks -- when idling the memory controller. Unfortunately,
we've found that this register is not 100% sufficient; it does not turn
the relevant PLLs on [0].

So it's possible to trigger issues with something like the following:

1. enable a power domain (e.g., RK3399_PD_VDU) -- kernel will
   temporarily enable relevant clocks/PLLs, then turn them back off
   2. a PLL (e.g., PLL_NPLL) is part of the clock tree for
      RK3399_PD_VDU's clocks but otherwise unused; NPLL is disabled
3. perform a ddrfreq transition (rk3399_dmcfreq_target() -> ...
   drivers/clk/rockchip/clk-ddr.c / ROCKCHIP_SIP_DRAM_FREQ)
   4. ARM Trusted Firmware unagates VDU clocks (via PMU_CRU_GATEDIS_CON0)
   5. ARM Trusted firmware idles the memory controller domain
   6. Step 5 waits on the VDU domain/clocks, but NPLL is still off

i.e., we hang the system.

So for (b), we need to at a minimum manage the relevant PLLs on behalf
of firmware. It's easier to simply manage the whole clock tree, in a
similar way we do in rockchip_pd_power().

For (a), we need to provide mutual exclusion betwen rockchip_pd_power()
and firmware. To resolve that, we simply grab the PMU mutex and release
it when ddrfreq is done.

The Chromium OS kernel has been carrying versions of part of this hack
for a while, based on some new custom notifiers [1]. I've rewritten as a
simple function call between the drivers, which is OK because:

 * the PMU driver isn't enabled, and we don't have this problem at all
   (the firmware should have left us in an OK state, and there are no
   runtime conflicts); or
 * the PMU driver is present, and is a single instance.

And the power-domain driver cannot be removed, so there's no lifetime
management to worry about.

For completeness, there's a 'dmc_pmu_mutex' to guard (likely
theoretical?) probe()-time races. It's OK for the memory controller
driver to start running before the PMU, because the PMU will avoid any
critical actions during the block() sequence.

[0] The RK3399 TRM for PMU_CRU_GATEDIS_CON0 only talks about ungating
    clocks. Based on experimentation, we've found that it does not power
    up the necessary PLLs.

[1] CHROMIUM: soc: rockchip: power-domain: Add notifier to dmc driver
    https://chromium-review.googlesource.com/q/I242dbd706d352f74ff706f5cbf42ebb92f9bcc60
    Notably, the Chromium solution only handled conflict (a), not (b).
    In practice, item (b) wasn't a problem in many cases because we
    never managed to fully power off PLLs. Now that the (upstream) video
    decoder driver performs runtime clock management, we often power off
    NPLL.

Signed-off-by: Brian Norris <briannorris@chromium.org>
Tested-by: Peter Geis <pgwipeout@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Stable-dep-of: 73cb5f6eafb0 ("pmdomain: imx: Fix reference count leak in imx_gpc_probe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/rockchip/pm_domains.c | 118 ++++++++++++++++++++++++++++++
 include/soc/rockchip/pm_domains.h |  25 +++++++
 2 files changed, 143 insertions(+)
 create mode 100644 include/soc/rockchip/pm_domains.h

diff --git a/drivers/soc/rockchip/pm_domains.c b/drivers/soc/rockchip/pm_domains.c
index 0868b7d406fb..b1cf7d29dafd 100644
--- a/drivers/soc/rockchip/pm_domains.c
+++ b/drivers/soc/rockchip/pm_domains.c
@@ -8,6 +8,7 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/err.h>
+#include <linux/mutex.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
 #include <linux/of_address.h>
@@ -16,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
+#include <soc/rockchip/pm_domains.h>
 #include <dt-bindings/power/px30-power.h>
 #include <dt-bindings/power/rk3036-power.h>
 #include <dt-bindings/power/rk3066-power.h>
@@ -139,6 +141,109 @@ struct rockchip_pmu {
 #define DOMAIN_RK3568(name, pwr, req, wakeup)		\
 	DOMAIN_M(name, pwr, pwr, req, req, req, wakeup)
 
+/*
+ * Dynamic Memory Controller may need to coordinate with us -- see
+ * rockchip_pmu_block().
+ *
+ * dmc_pmu_mutex protects registration-time races, so DMC driver doesn't try to
+ * block() while we're initializing the PMU.
+ */
+static DEFINE_MUTEX(dmc_pmu_mutex);
+static struct rockchip_pmu *dmc_pmu;
+
+/*
+ * Block PMU transitions and make sure they don't interfere with ARM Trusted
+ * Firmware operations. There are two conflicts, noted in the comments below.
+ *
+ * Caller must unblock PMU transitions via rockchip_pmu_unblock().
+ */
+int rockchip_pmu_block(void)
+{
+	struct rockchip_pmu *pmu;
+	struct generic_pm_domain *genpd;
+	struct rockchip_pm_domain *pd;
+	int i, ret;
+
+	mutex_lock(&dmc_pmu_mutex);
+
+	/* No PMU (yet)? Then we just block rockchip_pmu_probe(). */
+	if (!dmc_pmu)
+		return 0;
+	pmu = dmc_pmu;
+
+	/*
+	 * mutex blocks all idle transitions: we can't touch the
+	 * PMU_BUS_IDLE_REQ (our ".idle_offset") register while ARM Trusted
+	 * Firmware might be using it.
+	 */
+	mutex_lock(&pmu->mutex);
+
+	/*
+	 * Power domain clocks: Per Rockchip, we *must* keep certain clocks
+	 * enabled for the duration of power-domain transitions. Most
+	 * transitions are handled by this driver, but some cases (in
+	 * particular, DRAM DVFS / memory-controller idle) must be handled by
+	 * firmware. Firmware can handle most clock management via a special
+	 * "ungate" register (PMU_CRU_GATEDIS_CON0), but unfortunately, this
+	 * doesn't handle PLLs. We can assist this transition by doing the
+	 * clock management on behalf of firmware.
+	 */
+	for (i = 0; i < pmu->genpd_data.num_domains; i++) {
+		genpd = pmu->genpd_data.domains[i];
+		if (genpd) {
+			pd = to_rockchip_pd(genpd);
+			ret = clk_bulk_enable(pd->num_clks, pd->clks);
+			if (ret < 0) {
+				dev_err(pmu->dev,
+					"failed to enable clks for domain '%s': %d\n",
+					genpd->name, ret);
+				goto err;
+			}
+		}
+	}
+
+	return 0;
+
+err:
+	for (i = i - 1; i >= 0; i--) {
+		genpd = pmu->genpd_data.domains[i];
+		if (genpd) {
+			pd = to_rockchip_pd(genpd);
+			clk_bulk_disable(pd->num_clks, pd->clks);
+		}
+	}
+	mutex_unlock(&pmu->mutex);
+	mutex_unlock(&dmc_pmu_mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rockchip_pmu_block);
+
+/* Unblock PMU transitions. */
+void rockchip_pmu_unblock(void)
+{
+	struct rockchip_pmu *pmu;
+	struct generic_pm_domain *genpd;
+	struct rockchip_pm_domain *pd;
+	int i;
+
+	if (dmc_pmu) {
+		pmu = dmc_pmu;
+		for (i = 0; i < pmu->genpd_data.num_domains; i++) {
+			genpd = pmu->genpd_data.domains[i];
+			if (genpd) {
+				pd = to_rockchip_pd(genpd);
+				clk_bulk_disable(pd->num_clks, pd->clks);
+			}
+		}
+
+		mutex_unlock(&pmu->mutex);
+	}
+
+	mutex_unlock(&dmc_pmu_mutex);
+}
+EXPORT_SYMBOL_GPL(rockchip_pmu_unblock);
+
 static bool rockchip_pmu_domain_is_idle(struct rockchip_pm_domain *pd)
 {
 	struct rockchip_pmu *pmu = pd->pmu;
@@ -690,6 +795,12 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 
 	error = -ENODEV;
 
+	/*
+	 * Prevent any rockchip_pmu_block() from racing with the remainder of
+	 * setup (clocks, register initialization).
+	 */
+	mutex_lock(&dmc_pmu_mutex);
+
 	for_each_available_child_of_node(np, node) {
 		error = rockchip_pm_add_one_domain(pmu, node);
 		if (error) {
@@ -719,10 +830,17 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
+	/* We only expect one PMU. */
+	if (!WARN_ON_ONCE(dmc_pmu))
+		dmc_pmu = pmu;
+
+	mutex_unlock(&dmc_pmu_mutex);
+
 	return 0;
 
 err_out:
 	rockchip_pm_domain_cleanup(pmu);
+	mutex_unlock(&dmc_pmu_mutex);
 	return error;
 }
 
diff --git a/include/soc/rockchip/pm_domains.h b/include/soc/rockchip/pm_domains.h
new file mode 100644
index 000000000000..7dbd941fc937
--- /dev/null
+++ b/include/soc/rockchip/pm_domains.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2022, The Chromium OS Authors. All rights reserved.
+ */
+
+#ifndef __SOC_ROCKCHIP_PM_DOMAINS_H__
+#define __SOC_ROCKCHIP_PM_DOMAINS_H__
+
+#ifdef CONFIG_ROCKCHIP_PM_DOMAINS
+
+int rockchip_pmu_block(void);
+void rockchip_pmu_unblock(void);
+
+#else /* CONFIG_ROCKCHIP_PM_DOMAINS */
+
+static inline int rockchip_pmu_block(void)
+{
+	return 0;
+}
+
+static inline void rockchip_pmu_unblock(void) { }
+
+#endif /* CONFIG_ROCKCHIP_PM_DOMAINS */
+
+#endif /* __SOC_ROCKCHIP_PM_DOMAINS_H__ */
-- 
2.51.0



Return-Path: <stable+bounces-153350-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80899ADD412
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 18:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFD211885025
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898E62ECEA5;
	Tue, 17 Jun 2025 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W1PZfqvc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465AE2DFF00;
	Tue, 17 Jun 2025 15:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750175665; cv=none; b=qy0DNQ9rOXxBKlxVuW+kBYoGbVldD+hZ9tGQ1JxkAdOQp8GNOYUmrXyTdJIu0FVRztdgNXZQZaqzbI/S4VhZeGWvdO/k61zoS6mgaTT2LRIM29hEH/FZkfTJpvt9QZjZuQN3SutKfNNNZ/ZscqHwwYEjbPdDy5PWAiph1ocvxEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750175665; c=relaxed/simple;
	bh=I7smV/Yy8ydMSc/ztEDgxYLWqav1finAAZQCzwkOMdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHAumF+CjnDATg01YYFsuYN+aViWo2gbQ0+b9oQj1uzbhgUAliTapoysf1M8FTarJ0w5IbmpKIAnam4ZLf4jeZvRMN6gFK7fE5xfpnMsIBjOw38iXC20Lti2L6/gS8LkgUhw+5SSmkZkEzZBgbs+pm5c8rwqIJmpqYMCNcoRVv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W1PZfqvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7653C4CEE3;
	Tue, 17 Jun 2025 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750175665;
	bh=I7smV/Yy8ydMSc/ztEDgxYLWqav1finAAZQCzwkOMdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W1PZfqvcbNWnRNkiir7R/4c9tBkDVMdtO3qeyyIf+FoNZitaRcI68q8lp2TaZQBGM
	 OaRKlRmmy7JC2xdTQBN3IZQh8SRBj61mAyo3nML+DkgBkhFbu1z0jiskkxENLx3pnh
	 yaYHxAWuVv4zue5KM28wg68K/o0rp64ZQ827bxjw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hongbo Yao <andy.xu@hj-micro.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 111/780] perf: arm-ni: Unregister PMUs on probe failure
Date: Tue, 17 Jun 2025 17:16:59 +0200
Message-ID: <20250617152456.027057934@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617152451.485330293@linuxfoundation.org>
References: <20250617152451.485330293@linuxfoundation.org>
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

From: Hongbo Yao <andy.xu@hj-micro.com>

[ Upstream commit 7f57afde6a44d9e044885e1125034edd4fda02e8 ]

When a resource allocation fails in one clock domain of an NI device,
we need to properly roll back all previously registered perf PMUs in
other clock domains of the same device.

Otherwise, it can lead to kernel panics.

Calling arm_ni_init+0x0/0xff8 [arm_ni] @ 2374
arm-ni ARMHCB70:00: Failed to request PMU region 0x1f3c13000
arm-ni ARMHCB70:00: probe with driver arm-ni failed with error -16
list_add corruption: next->prev should be prev (fffffd01e9698a18),
but was 0000000000000000. (next=ffff10001a0decc8).
pstate: 6340009 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : list_add_valid_or_report+0x7c/0xb8
lr : list_add_valid_or_report+0x7c/0xb8
Call trace:
 __list_add_valid_or_report+0x7c/0xb8
 perf_pmu_register+0x22c/0x3a0
 arm_ni_probe+0x554/0x70c [arm_ni]
 platform_probe+0x70/0xe8
 really_probe+0xc6/0x4d8
 driver_probe_device+0x48/0x170
 __driver_attach+0x8e/0x1c0
 bus_for_each_dev+0x64/0xf0
 driver_add+0x138/0x260
 bus_add_driver+0x68/0x138
 __platform_driver_register+0x2c/0x40
 arm_ni_init+0x14/0x2a [arm_ni]
 do_init_module+0x36/0x298
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Oops - BUG: Fatal exception
SMP: stopping secondary CPUs

Fixes: 4d5a7680f2b4 ("perf: Add driver for Arm NI-700 interconnect PMU")
Signed-off-by: Hongbo Yao <andy.xu@hj-micro.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20250403070918.4153839-1-andy.xu@hj-micro.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/arm-ni.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/perf/arm-ni.c b/drivers/perf/arm-ni.c
index fd7a5e60e9630..0c418a7ee10f3 100644
--- a/drivers/perf/arm-ni.c
+++ b/drivers/perf/arm-ni.c
@@ -575,6 +575,23 @@ static int arm_ni_init_cd(struct arm_ni *ni, struct arm_ni_node *node, u64 res_s
 	return err;
 }
 
+static void arm_ni_remove(struct platform_device *pdev)
+{
+	struct arm_ni *ni = platform_get_drvdata(pdev);
+
+	for (int i = 0; i < ni->num_cds; i++) {
+		struct arm_ni_cd *cd = ni->cds + i;
+
+		if (!cd->pmu_base)
+			continue;
+
+		writel_relaxed(0, cd->pmu_base + NI_PMCR);
+		writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENCLR);
+		perf_pmu_unregister(&cd->pmu);
+		cpuhp_state_remove_instance_nocalls(arm_ni_hp_state, &cd->cpuhp_node);
+	}
+}
+
 static void arm_ni_probe_domain(void __iomem *base, struct arm_ni_node *node)
 {
 	u32 reg = readl_relaxed(base + NI_NODE_TYPE);
@@ -656,8 +673,11 @@ static int arm_ni_probe(struct platform_device *pdev)
 				reg = readl_relaxed(pd.base + NI_CHILD_PTR(c));
 				arm_ni_probe_domain(base + reg, &cd);
 				ret = arm_ni_init_cd(ni, &cd, res->start);
-				if (ret)
+				if (ret) {
+					ni->cds[cd.id].pmu_base = NULL;
+					arm_ni_remove(pdev);
 					return ret;
+				}
 			}
 		}
 	}
@@ -665,23 +685,6 @@ static int arm_ni_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void arm_ni_remove(struct platform_device *pdev)
-{
-	struct arm_ni *ni = platform_get_drvdata(pdev);
-
-	for (int i = 0; i < ni->num_cds; i++) {
-		struct arm_ni_cd *cd = ni->cds + i;
-
-		if (!cd->pmu_base)
-			continue;
-
-		writel_relaxed(0, cd->pmu_base + NI_PMCR);
-		writel_relaxed(U32_MAX, cd->pmu_base + NI_PMINTENCLR);
-		perf_pmu_unregister(&cd->pmu);
-		cpuhp_state_remove_instance_nocalls(arm_ni_hp_state, &cd->cpuhp_node);
-	}
-}
-
 #ifdef CONFIG_OF
 static const struct of_device_id arm_ni_of_match[] = {
 	{ .compatible = "arm,ni-700" },
-- 
2.39.5





Return-Path: <stable+bounces-127072-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1484A7682E
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C796188CC78
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB0D21CC60;
	Mon, 31 Mar 2025 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0+5UDXH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E621B9FD;
	Mon, 31 Mar 2025 14:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431676; cv=none; b=BxjOW8IpRKbhhtGcrhqVMnLar111crxdCkQOxpsKw18cTRD2N/oBl1waTQnXFTVaEqmJXYmYOwvBV47OuoNQMbygET4Ve+wQrzIu+JHo3UT7ZGg3BNGrSPA8tY6AahUi2leIdB3vY4H6z4+JvE8TJQpZeLLUvuXFzzQh4EssoiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431676; c=relaxed/simple;
	bh=RbGuvqY2Py6/CSNYRkaEEr45J/MeGhBOFxWvpr/kSLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DBjiwpyl9lw/UlK/RzklNMHQEK8SEwyGKSjbRdJUA9qkm0xJqWTTHMWelOUKdRoA4BgxsqRDqB3iM8ibqH/RWvD4rwaobvl+t2ckR1jiUF76zxvQ5yliubrX69mZxgExwD0kLvmbdKJ+YbiFMucMtHW6kaxKeNf92rM9CYIRkyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0+5UDXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84580C4CEE9;
	Mon, 31 Mar 2025 14:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431674;
	bh=RbGuvqY2Py6/CSNYRkaEEr45J/MeGhBOFxWvpr/kSLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J0+5UDXHwMCgTgrY5WglDTyvRcFJA9xJe8BV6Jr53vHp3dfrrz8mx7zSjA9LKDZL6
	 enuzTGydy3mzZlGK5vOZAOvEsCs0zWI7FL0/pL2AnXuHESJHNmCrHWRK2bqQsKEU6M
	 t1jEixFknVoAAc7OiGo9Xb69vEMSPpARvYiwB8li5O0vSt+8eh5rBe0efrA8GOYd7p
	 pCvPXYFbRNU5cizwtprolbFmMVhCZxERPn0uRdpfDGukl8IES6C8fKEa6wcnRxaakt
	 VarJg8dx3Sne/gxiw9HwtIsdHPMLw83Oogs+E4/hpQN0yhvqFGN+ePFeEkypDnqPEX
	 LUnuIwes+/+DQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Will Deacon <will@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	renyu.zj@linux.alibaba.com,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 10/18] perf/dwc_pcie: fix duplicate pci_dev devices
Date: Mon, 31 Mar 2025 10:34:00 -0400
Message-Id: <20250331143409.1682789-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143409.1682789-1-sashal@kernel.org>
References: <20250331143409.1682789-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14
Content-Transfer-Encoding: 8bit

From: Yunhui Cui <cuiyunhui@bytedance.com>

[ Upstream commit 7f35b429802a8065aa61e2a3f567089649f4d98e ]

During platform_device_register, wrongly using struct device
pci_dev as platform_data caused a kmemdup copy of pci_dev. Worse
still, accessing the duplicated device leads to list corruption as its
mutex content (e.g., list, magic) remains the same as the original.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Link: https://lore.kernel.org/r/20250220121716.50324-3-cuiyunhui@bytedance.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/dwc_pcie_pmu.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
index 19fa2ba8dd670..f851e070760c5 100644
--- a/drivers/perf/dwc_pcie_pmu.c
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -565,9 +565,7 @@ static int dwc_pcie_register_dev(struct pci_dev *pdev)
 	u32 sbdf;
 
 	sbdf = (pci_domain_nr(pdev->bus) << 16) | PCI_DEVID(pdev->bus->number, pdev->devfn);
-	plat_dev = platform_device_register_data(NULL, "dwc_pcie_pmu", sbdf,
-						 pdev, sizeof(*pdev));
-
+	plat_dev = platform_device_register_simple("dwc_pcie_pmu", sbdf, NULL, 0);
 	if (IS_ERR(plat_dev))
 		return PTR_ERR(plat_dev);
 
@@ -616,18 +614,26 @@ static struct notifier_block dwc_pcie_pmu_nb = {
 
 static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 {
-	struct pci_dev *pdev = plat_dev->dev.platform_data;
+	struct pci_dev *pdev;
 	struct dwc_pcie_pmu *pcie_pmu;
 	char *name;
 	u32 sbdf;
 	u16 vsec;
 	int ret;
 
+	sbdf = plat_dev->id;
+	pdev = pci_get_domain_bus_and_slot(sbdf >> 16, PCI_BUS_NUM(sbdf & 0xffff),
+					   sbdf & 0xff);
+	if (!pdev) {
+		pr_err("No pdev found for the sbdf 0x%x\n", sbdf);
+		return -ENODEV;
+	}
+
 	vsec = dwc_pcie_des_cap(pdev);
 	if (!vsec)
 		return -ENODEV;
 
-	sbdf = plat_dev->id;
+	pci_dev_put(pdev);
 	name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x", sbdf);
 	if (!name)
 		return -ENOMEM;
@@ -642,7 +648,7 @@ static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
 	pcie_pmu->on_cpu = -1;
 	pcie_pmu->pmu = (struct pmu){
 		.name		= name,
-		.parent		= &pdev->dev,
+		.parent		= &plat_dev->dev,
 		.module		= THIS_MODULE,
 		.attr_groups	= dwc_pcie_attr_groups,
 		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
-- 
2.39.5



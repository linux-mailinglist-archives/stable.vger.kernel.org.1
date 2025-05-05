Return-Path: <stable+bounces-141257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89808AAB1D9
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 06:08:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3E617487C
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 04:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78C833676E;
	Tue,  6 May 2025 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YibxDo62"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833B29E069;
	Mon,  5 May 2025 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485627; cv=none; b=mqn6IeBKzVZIc5YxIp4KSPHzhQxTD6OsuWSbeKGovYgp4cNwwPm+ohLqHDjLq3AkaXXHTAKLcIUblXDV8ThgjY/yDdtPSDkLskmzo5en1M1vvSVXnFWPW9BimJEi5jYJXZcrzSW0FLo1y1MQ8BwX8PmXDoklmj8dk3AhEif5pio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485627; c=relaxed/simple;
	bh=OShk5Pk7+EWw5WJPlyaLJpSjwrVtxveqeWxZaYaBs5k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CnIm98rNWG+p+4uArRGy1fz30dMqjVNfYIN5Zicb6qaZ7vt0ET9PvQ5VGMaqBJKR8XW2S+QFURo9JN0+X0YG5u/enlS+kkDiPX0sKQ/icwXZEXAdvOq0uGVkNXLY4dPtIs4jFGwb4xZupQCVAtokOKjmWcr4BtDxw8c+esJn+zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YibxDo62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ED01C4CEEE;
	Mon,  5 May 2025 22:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485627;
	bh=OShk5Pk7+EWw5WJPlyaLJpSjwrVtxveqeWxZaYaBs5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YibxDo62cvGyAwFLLNf/C/cqdfuqM7mQXxFcBNbc5EMaduWYWGoR3DmFXsFddM+uG
	 r7c7S+LdoBZhFP0BbeyFturGU7b6qaLxL5xmzes7cURpfVF4NNDT3zCcU4U9lqVzRI
	 Yh5SGzO1ugVVxZVpqWWoKQ181kijCSE6s5g6JRST/iNBZe10E+p51al3hSX2LVu6Yj
	 iC3wrfisVKUR4yQa1kM0xmHSlx7t9WqVLYgQQvgsUnRGuWJW6cd0AFA1ciyQ90ohxP
	 YNwHRgFt8oTGKPfI4yrrEFM/PbJCfTYyH21YQ6uJZlbTElCcCm6mHW3RvtjEyxIG2X
	 Cd390xqCbjyEQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gaurav Batra <gbatra@linux.ibm.com>,
	Donet Tom <donettom@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	mpe@ellerman.id.au,
	dan.j.williams@intel.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	Jonathan.Cameron@huawei.com,
	david@redhat.com,
	nilay@linux.ibm.com,
	sbhat@linux.ibm.com,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 6.12 394/486] powerpc/pseries/iommu: memory notifier incorrectly adds TCEs for pmemory
Date: Mon,  5 May 2025 18:37:50 -0400
Message-Id: <20250505223922.2682012-394-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Gaurav Batra <gbatra@linux.ibm.com>

[ Upstream commit 6aa989ab2bd0d37540c812b4270006ff794662e7 ]

iommu_mem_notifier() is invoked when RAM is dynamically added/removed. This
notifier call is responsible to add/remove TCEs from the Dynamic DMA Window
(DDW) when TCEs are pre-mapped. TCEs are pre-mapped only for RAM and not
for persistent memory (pmemory). For DMA buffers in pmemory, TCEs are
dynamically mapped when the device driver instructs to do so.

The issue is 'daxctl' command is capable of adding pmemory as "System RAM"
after LPAR boot. The command to do so is -

daxctl reconfigure-device --mode=system-ram dax0.0 --force

This will dynamically add pmemory range to LPAR RAM eventually invoking
iommu_mem_notifier(). The address range of pmemory is way beyond the Max
RAM that the LPAR can have. Which means, this range is beyond the DDW
created for the device, at device initialization time.

As a result when TCEs are pre-mapped for the pmemory range, by
iommu_mem_notifier(), PHYP HCALL returns H_PARAMETER. This failed the
command, daxctl, to add pmemory as RAM.

The solution is to not pre-map TCEs for pmemory.

Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
Tested-by: Donet Tom <donettom@linux.ibm.com>
Reviewed-by: Donet Tom <donettom@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20250130183854.92258-1-gbatra@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/include/asm/mmzone.h      |  1 +
 arch/powerpc/mm/numa.c                 |  2 +-
 arch/powerpc/platforms/pseries/iommu.c | 29 ++++++++++++++------------
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
index d99863cd6cde4..049152f8d597a 100644
--- a/arch/powerpc/include/asm/mmzone.h
+++ b/arch/powerpc/include/asm/mmzone.h
@@ -29,6 +29,7 @@ extern cpumask_var_t node_to_cpumask_map[];
 #ifdef CONFIG_MEMORY_HOTPLUG
 extern unsigned long max_pfn;
 u64 memory_hotplug_max(void);
+u64 hot_add_drconf_memory_max(void);
 #else
 #define memory_hotplug_max() memblock_end_of_DRAM()
 #endif
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 3c1da08304d03..603a0f652ba61 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1336,7 +1336,7 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 	return nid;
 }
 
-static u64 hot_add_drconf_memory_max(void)
+u64 hot_add_drconf_memory_max(void)
 {
 	struct device_node *memory = NULL;
 	struct device_node *dn = NULL;
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index ae6f7a235d8b2..8f32340960e21 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1284,17 +1284,13 @@ static LIST_HEAD(failed_ddw_pdn_list);
 
 static phys_addr_t ddw_memory_hotplug_max(void)
 {
-	resource_size_t max_addr = memory_hotplug_max();
-	struct device_node *memory;
+	resource_size_t max_addr;
 
-	for_each_node_by_type(memory, "memory") {
-		struct resource res;
-
-		if (of_address_to_resource(memory, 0, &res))
-			continue;
-
-		max_addr = max_t(resource_size_t, max_addr, res.end + 1);
-	}
+#if defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)
+	max_addr = hot_add_drconf_memory_max();
+#else
+	max_addr = memblock_end_of_DRAM();
+#endif
 
 	return max_addr;
 }
@@ -1600,7 +1596,7 @@ static bool enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 
 	if (direct_mapping) {
 		/* DDW maps the whole partition, so enable direct DMA mapping */
-		ret = walk_system_ram_range(0, memblock_end_of_DRAM() >> PAGE_SHIFT,
+		ret = walk_system_ram_range(0, ddw_memory_hotplug_max() >> PAGE_SHIFT,
 					    win64->value, tce_setrange_multi_pSeriesLP_walk);
 		if (ret) {
 			dev_info(&dev->dev, "failed to map DMA window for %pOF: %d\n",
@@ -2349,11 +2345,17 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 	struct memory_notify *arg = data;
 	int ret = 0;
 
+	/* This notifier can get called when onlining persistent memory as well.
+	 * TCEs are not pre-mapped for persistent memory. Persistent memory will
+	 * always be above ddw_memory_hotplug_max()
+	 */
+
 	switch (action) {
 	case MEM_GOING_ONLINE:
 		spin_lock(&dma_win_list_lock);
 		list_for_each_entry(window, &dma_win_list, list) {
-			if (window->direct) {
+			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
+				ddw_memory_hotplug_max()) {
 				ret |= tce_setrange_multi_pSeriesLP(arg->start_pfn,
 						arg->nr_pages, window->prop);
 			}
@@ -2365,7 +2367,8 @@ static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
 	case MEM_OFFLINE:
 		spin_lock(&dma_win_list_lock);
 		list_for_each_entry(window, &dma_win_list, list) {
-			if (window->direct) {
+			if (window->direct && (arg->start_pfn << PAGE_SHIFT) <
+				ddw_memory_hotplug_max()) {
 				ret |= tce_clearrange_multi_pSeriesLP(arg->start_pfn,
 						arg->nr_pages, window->prop);
 			}
-- 
2.39.5



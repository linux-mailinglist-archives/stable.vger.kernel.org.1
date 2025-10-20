Return-Path: <stable+bounces-188219-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 752DABF2C0B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 19:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 022734664C1
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867FA332EBC;
	Mon, 20 Oct 2025 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WcsOFqiT"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557913321D7
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981859; cv=none; b=uAuejSM1wtFIlYp2WRLsB4Q5N/ncGj4bQ3Wj9pewQft0N8omtfpqBt34ynKc2e1E97Nj94n8nwdXuPgocYVLTmWoC8j2S/lI4xw0xL7BBa8QbKqM6pKPPJAh6rxXjAkmzQEcz+1+Ql7G2HUfwHySGG33lNYU8oVNP7Ahb12ZN18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981859; c=relaxed/simple;
	bh=R9ct9H1hNt2GOAeJv5d7SgnwKuc3fc/lx932nNxp6+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EV/Z+8peWNUuLhIJIEI1oyVuqiXKpeOZJG1yLAprOmwkg6S/iJmwR9R3MiABGpeoh6gCOsEcgMwpm+tatlPpzK78NeHcnjTdF/xG6/jVbkkKyWpdy+g7LhyAyeHfbxAq2Mn0DVjLvAg/IQZEs8qybmpkZT3xwuARh7AhmpfIajc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WcsOFqiT; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760981854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y4JOwk34LepEFVJGETGypOIklR/AvWXb3lw788E7e/4=;
	b=WcsOFqiTIx6jTXFu3WvQN36utU/EHT39o7erlRy9zOUpHCbeA8brU4twYQaWushPx0ju+U
	ae4Br8KN4RhNdYKf9TMwrO0Dkg36wTUJzoAsmE9gr7GtVCOdc8ExCg/+TjOvAPLneundrj
	IR2Uzp4BIOU8daZcqlvfAAfDlgyQryY=
From: Wen Yang <wen.yang@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pierre Gondois <pierre.gondois@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH 6.1 06/10] arch_topology: Build cacheinfo from primary CPU
Date: Tue, 21 Oct 2025 01:36:20 +0800
Message-Id: <20251020173624.20228-7-wen.yang@linux.dev>
In-Reply-To: <20251020173624.20228-1-wen.yang@linux.dev>
References: <20251020173624.20228-1-wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Pierre Gondois <pierre.gondois@arm.com>

[ Upstream commit 5944ce092b97caed5d86d961e963b883b5c44ee2 ]

commit 3fcbf1c77d08 ("arch_topology: Fix cache attributes detection
in the CPU hotplug path")
adds a call to detect_cache_attributes() to populate the cacheinfo
before updating the siblings mask. detect_cache_attributes() allocates
memory and can take the PPTT mutex (on ACPI platforms). On PREEMPT_RT
kernels, on secondary CPUs, this triggers a:
  'BUG: sleeping function called from invalid context' [1]
as the code is executed with preemption and interrupts disabled.

The primary CPU was previously storing the cache information using
the now removed (struct cpu_topology).llc_id:
commit 5b8dc787ce4a ("arch_topology: Drop LLC identifier stash from
the CPU topology")

allocate_cache_info() tries to build the cacheinfo from the primary
CPU prior secondary CPUs boot, if the DT/ACPI description
contains cache information.
If allocate_cache_info() fails, then fallback to the current state
for the cacheinfo allocation. [1] will be triggered in such case.

When unplugging a CPU, the cacheinfo memory cannot be freed. If it
was, then the memory would be allocated early by the re-plugged
CPU and would trigger [1].

Note that populate_cache_leaves() might be called multiple times
due to populate_leaves being moved up. This is required since
detect_cache_attributes() might be called with per_cpu_cacheinfo(cpu)
being allocated but not populated.

[1]:
 | BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
 | in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/111
 | preempt_count: 1, expected: 0
 | RCU nest depth: 1, expected: 1
 | 3 locks held by swapper/111/0:
 |  #0:  (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x218/0x12c8
 |  #1:  (rcu_read_lock){....}-{1:3}, at: rt_spin_trylock+0x48/0xf0
 |  #2:  (&zone->lock){+.+.}-{3:3}, at: rmqueue_bulk+0x64/0xa80
 | irq event stamp: 0
 | hardirqs last  enabled at (0):  0x0
 | hardirqs last disabled at (0):  copy_process+0x5dc/0x1ab8
 | softirqs last  enabled at (0):  copy_process+0x5dc/0x1ab8
 | softirqs last disabled at (0):  0x0
 | Preemption disabled at:
 |  migrate_enable+0x30/0x130
 | CPU: 111 PID: 0 Comm: swapper/111 Tainted: G        W          6.0.0-rc4-rt6-[...]
 | Call trace:
 |  __kmalloc+0xbc/0x1e8
 |  detect_cache_attributes+0x2d4/0x5f0
 |  update_siblings_masks+0x30/0x368
 |  store_cpu_topology+0x78/0xb8
 |  secondary_start_kernel+0xd0/0x198
 |  __secondary_switched+0xb0/0xb4

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
Link: https://lore.kernel.org/r/20230104183033.755668-7-pierre.gondois@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 arch/riscv/kernel/cacheinfo.c |  5 ---
 drivers/base/arch_topology.c  | 12 +++++-
 drivers/base/cacheinfo.c      | 71 ++++++++++++++++++++++++++---------
 include/linux/cacheinfo.h     |  1 +
 4 files changed, 65 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 440a3df5944c..3a13113f1b29 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -113,11 +113,6 @@ static void fill_cacheinfo(struct cacheinfo **this_leaf,
 	}
 }
 
-int init_cache_level(unsigned int cpu)
-{
-	return init_of_cache_level(cpu);
-}
-
 int populate_cache_leaves(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7d6e6657ffa..b1c1dd38ab01 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -736,7 +736,7 @@ void update_siblings_masks(unsigned int cpuid)
 
 	ret = detect_cache_attributes(cpuid);
 	if (ret && ret != -ENOENT)
-		pr_info("Early cacheinfo failed, ret = %d\n", ret);
+		pr_info("Early cacheinfo allocation failed, ret = %d\n", ret);
 
 	/* update core and thread sibling masks */
 	for_each_online_cpu(cpu) {
@@ -825,7 +825,7 @@ __weak int __init parse_acpi_topology(void)
 #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 void __init init_cpu_topology(void)
 {
-	int ret;
+	int cpu, ret;
 
 	reset_cpu_topology();
 	ret = parse_acpi_topology();
@@ -840,6 +840,14 @@ void __init init_cpu_topology(void)
 		reset_cpu_topology();
 		return;
 	}
+
+	for_each_possible_cpu(cpu) {
+		ret = fetch_cache_info(cpu);
+		if (ret) {
+			pr_err("Early cacheinfo failed, ret = %d\n", ret);
+			break;
+		}
+	}
 }
 
 void store_cpu_topology(unsigned int cpuid)
diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index ab99b0f0d010..cd943d06d074 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -412,10 +412,6 @@ static void free_cache_attributes(unsigned int cpu)
 		return;
 
 	cache_shared_cpu_map_remove(cpu);
-
-	kfree(per_cpu_cacheinfo(cpu));
-	per_cpu_cacheinfo(cpu) = NULL;
-	cache_leaves(cpu) = 0;
 }
 
 int __weak init_cache_level(unsigned int cpu)
@@ -428,29 +424,71 @@ int __weak populate_cache_leaves(unsigned int cpu)
 	return -ENOENT;
 }
 
+static inline
+int allocate_cache_info(int cpu)
+{
+	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu),
+					 sizeof(struct cacheinfo), GFP_ATOMIC);
+	if (!per_cpu_cacheinfo(cpu)) {
+		cache_leaves(cpu) = 0;
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int fetch_cache_info(unsigned int cpu)
+{
+	struct cpu_cacheinfo *this_cpu_ci;
+	unsigned int levels, split_levels;
+	int ret;
+
+	if (acpi_disabled) {
+		ret = init_of_cache_level(cpu);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = acpi_get_cache_info(cpu, &levels, &split_levels);
+		if (ret < 0)
+			return ret;
+
+		this_cpu_ci = get_cpu_cacheinfo(cpu);
+		this_cpu_ci->num_levels = levels;
+		/*
+		 * This assumes that:
+		 * - there cannot be any split caches (data/instruction)
+		 *   above a unified cache
+		 * - data/instruction caches come by pair
+		 */
+		this_cpu_ci->num_leaves = levels + split_levels;
+	}
+	if (!cache_leaves(cpu))
+		return -ENOENT;
+
+	return allocate_cache_info(cpu);
+}
+
 int detect_cache_attributes(unsigned int cpu)
 {
 	int ret;
 
-	/* Since early detection of the cacheinfo is allowed via this
-	 * function and this also gets called as CPU hotplug callbacks via
-	 * cacheinfo_cpu_online, the initialisation can be skipped and only
-	 * CPU maps can be updated as the CPU online status would be update
-	 * if called via cacheinfo_cpu_online path.
+	/* Since early initialization/allocation of the cacheinfo is allowed
+	 * via fetch_cache_info() and this also gets called as CPU hotplug
+	 * callbacks via cacheinfo_cpu_online, the init/alloc can be skipped
+	 * as it will happen only once (the cacheinfo memory is never freed).
+	 * Just populate the cacheinfo.
 	 */
 	if (per_cpu_cacheinfo(cpu))
-		goto update_cpu_map;
+		goto populate_leaves;
 
 	if (init_cache_level(cpu) || !cache_leaves(cpu))
 		return -ENOENT;
 
-	per_cpu_cacheinfo(cpu) = kcalloc(cache_leaves(cpu),
-					 sizeof(struct cacheinfo), GFP_ATOMIC);
-	if (per_cpu_cacheinfo(cpu) == NULL) {
-		cache_leaves(cpu) = 0;
-		return -ENOMEM;
-	}
+	ret = allocate_cache_info(cpu);
+	if (ret)
+		return ret;
 
+populate_leaves:
 	/*
 	 * populate_cache_leaves() may completely setup the cache leaves and
 	 * shared_cpu_map or it may leave it partially setup.
@@ -459,7 +497,6 @@ int detect_cache_attributes(unsigned int cpu)
 	if (ret)
 		goto free_ci;
 
-update_cpu_map:
 	/*
 	 * For systems using DT for cache hierarchy, fw_token
 	 * and shared_cpu_map will be set up here only if they are
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 00d8e7f9d1c6..dfef57077cd0 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -85,6 +85,7 @@ int populate_cache_leaves(unsigned int cpu);
 int cache_setup_acpi(unsigned int cpu);
 bool last_level_cache_is_valid(unsigned int cpu);
 bool last_level_cache_is_shared(unsigned int cpu_x, unsigned int cpu_y);
+int fetch_cache_info(unsigned int cpu);
 int detect_cache_attributes(unsigned int cpu);
 #ifndef CONFIG_ACPI_PPTT
 /*
-- 
2.25.1



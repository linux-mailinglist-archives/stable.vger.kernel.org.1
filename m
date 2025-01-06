Return-Path: <stable+bounces-106949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE68EA02971
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 16:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67E33A12E5
	for <lists+stable@lfdr.de>; Mon,  6 Jan 2025 15:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21DA48634A;
	Mon,  6 Jan 2025 15:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2kSSsb8b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5FC1547F2;
	Mon,  6 Jan 2025 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176999; cv=none; b=J3qIxCU/Ey/qR9g+cuWTMlGDhfAGdV7KjSuFJzFDmsivYrEPv442hkn/YCpPYUchsWxTujYAQiuEvBVAPIQ2A5151TyVd/b+a5ypUo6XENu+oUNKCevfMfgUhmuBmBjlKkzFxkYZmdppInEuWH5NSP/Q8pihcp9rtwF3fyRscus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176999; c=relaxed/simple;
	bh=hRXUpTSefMDCVBSFNdxsLY3Agi6E+P74ARjDbA8tJc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aLNCwVUm9VX5QiEE1vgI4lWn/8zMvVvJviCWdtwz61yCv6Ztk2pAnR8uPUL6/8ocPzUGKiSwUvWHmPbNw00jKP6RRY7mnpnfMPgZKeQy2LnFhX4eiQR/KHu56P5BS7wF3sx709pteI1fv74IxsVlXiWX9JezjblCenwgnQP9OXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2kSSsb8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2181DC4CED2;
	Mon,  6 Jan 2025 15:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1736176999;
	bh=hRXUpTSefMDCVBSFNdxsLY3Agi6E+P74ARjDbA8tJc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2kSSsb8bTHYSYxqklxBtseSooE8sDNzHJJwvByNuBgFMhS2/hNuEcZ5wboC3kPp1K
	 pKGZBHthmb4WjjQ8UzcVfLFj/ipN+WowJF0iW1C4RCs3OTOdQTg2AGGARtuJxVKvBD
	 XCnj2ZemC8Vhojt2kb1ro1TQ2xWeDL8OwFxNuCOk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Liam Ni <zhiguangni01@gmail.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	WANG Xuerui <kernel@xen0n.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 018/222] NUMA: optimize detection of memory with no node id assigned by firmware
Date: Mon,  6 Jan 2025 16:13:42 +0100
Message-ID: <20250106151151.290568282@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106151150.585603565@linuxfoundation.org>
References: <20250106151150.585603565@linuxfoundation.org>
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

From: Liam Ni <zhiguangni01@gmail.com>

[ Upstream commit ff6c3d81f2e86b63a3a530683f89ef393882782a ]

Sanity check that makes sure the nodes cover all memory loops over
numa_meminfo to count the pages that have node id assigned by the
firmware, then loops again over memblock.memory to find the total amount
of memory and in the end checks that the difference between the total
memory and memory that covered by nodes is less than some threshold.
Worse, the loop over numa_meminfo calls __absent_pages_in_range() that
also partially traverses memblock.memory.

It's much simpler and more efficient to have a single traversal of
memblock.memory that verifies that amount of memory not covered by nodes
is less than a threshold.

Introduce memblock_validate_numa_coverage() that does exactly that and use
it instead of numa_meminfo_cover_memory().

Link: https://lkml.kernel.org/r/20231026020329.327329-1-zhiguangni01@gmail.com
Signed-off-by: Liam Ni <zhiguangni01@gmail.com>
Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Bibo Mao <maobibo@loongson.cn>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Feiyang Chen <chenfeiyang@loongson.cn>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: WANG Xuerui <kernel@xen0n.name>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 9cdc6423acb4 ("memblock: allow zero threshold in validate_numa_converage()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/numa.c | 28 +---------------------------
 arch/x86/mm/numa.c           | 34 ++--------------------------------
 include/linux/memblock.h     |  1 +
 mm/memblock.c                | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 59 deletions(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 6e65ff12d5c7..8fe21f868f72 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -226,32 +226,6 @@ static void __init node_mem_init(unsigned int node)
 
 #ifdef CONFIG_ACPI_NUMA
 
-/*
- * Sanity check to catch more bad NUMA configurations (they are amazingly
- * common).  Make sure the nodes cover all memory.
- */
-static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
-{
-	int i;
-	u64 numaram, biosram;
-
-	numaram = 0;
-	for (i = 0; i < mi->nr_blks; i++) {
-		u64 s = mi->blk[i].start >> PAGE_SHIFT;
-		u64 e = mi->blk[i].end >> PAGE_SHIFT;
-
-		numaram += e - s;
-		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
-		if ((s64)numaram < 0)
-			numaram = 0;
-	}
-	max_pfn = max_low_pfn;
-	biosram = max_pfn - absent_pages_in_range(0, max_pfn);
-
-	BUG_ON((s64)(biosram - numaram) >= (1 << (20 - PAGE_SHIFT)));
-	return true;
-}
-
 static void __init add_node_intersection(u32 node, u64 start, u64 size, u32 type)
 {
 	static unsigned long num_physpages;
@@ -396,7 +370,7 @@ int __init init_numa_memory(void)
 		return -EINVAL;
 
 	init_node_memblock();
-	if (numa_meminfo_cover_memory(&numa_meminfo) == false)
+	if (!memblock_validate_numa_coverage(SZ_1M))
 		return -EINVAL;
 
 	for_each_node_mask(node, node_possible_map) {
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index c7fa5396c0f0..2c67bfc3cf32 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -448,37 +448,6 @@ int __node_distance(int from, int to)
 }
 EXPORT_SYMBOL(__node_distance);
 
-/*
- * Sanity check to catch more bad NUMA configurations (they are amazingly
- * common).  Make sure the nodes cover all memory.
- */
-static bool __init numa_meminfo_cover_memory(const struct numa_meminfo *mi)
-{
-	u64 numaram, e820ram;
-	int i;
-
-	numaram = 0;
-	for (i = 0; i < mi->nr_blks; i++) {
-		u64 s = mi->blk[i].start >> PAGE_SHIFT;
-		u64 e = mi->blk[i].end >> PAGE_SHIFT;
-		numaram += e - s;
-		numaram -= __absent_pages_in_range(mi->blk[i].nid, s, e);
-		if ((s64)numaram < 0)
-			numaram = 0;
-	}
-
-	e820ram = max_pfn - absent_pages_in_range(0, max_pfn);
-
-	/* We seem to lose 3 pages somewhere. Allow 1M of slack. */
-	if ((s64)(e820ram - numaram) >= (1 << (20 - PAGE_SHIFT))) {
-		printk(KERN_ERR "NUMA: nodes only cover %LuMB of your %LuMB e820 RAM. Not used.\n",
-		       (numaram << PAGE_SHIFT) >> 20,
-		       (e820ram << PAGE_SHIFT) >> 20);
-		return false;
-	}
-	return true;
-}
-
 /*
  * Mark all currently memblock-reserved physical memory (which covers the
  * kernel's own memory ranges) as hot-unswappable.
@@ -584,7 +553,8 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			return -EINVAL;
 		}
 	}
-	if (!numa_meminfo_cover_memory(mi))
+
+	if (!memblock_validate_numa_coverage(SZ_1M))
 		return -EINVAL;
 
 	/* Finally register nodes. */
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index ed57c23f80ac..ed64240041e8 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -122,6 +122,7 @@ unsigned long memblock_addrs_overlap(phys_addr_t base1, phys_addr_t size1,
 				     phys_addr_t base2, phys_addr_t size2);
 bool memblock_overlaps_region(struct memblock_type *type,
 			      phys_addr_t base, phys_addr_t size);
+bool memblock_validate_numa_coverage(unsigned long threshold_bytes);
 int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
diff --git a/mm/memblock.c b/mm/memblock.c
index d630f5c2bdb9..3a3ab73546f5 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -735,6 +735,40 @@ int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
 	return memblock_add_range(&memblock.memory, base, size, MAX_NUMNODES, 0);
 }
 
+/**
+ * memblock_validate_numa_coverage - check if amount of memory with
+ * no node ID assigned is less than a threshold
+ * @threshold_bytes: maximal number of pages that can have unassigned node
+ * ID (in bytes).
+ *
+ * A buggy firmware may report memory that does not belong to any node.
+ * Check if amount of such memory is below @threshold_bytes.
+ *
+ * Return: true on success, false on failure.
+ */
+bool __init_memblock memblock_validate_numa_coverage(unsigned long threshold_bytes)
+{
+	unsigned long nr_pages = 0;
+	unsigned long start_pfn, end_pfn, mem_size_mb;
+	int nid, i;
+
+	/* calculate lose page */
+	for_each_mem_pfn_range(i, MAX_NUMNODES, &start_pfn, &end_pfn, &nid) {
+		if (nid == NUMA_NO_NODE)
+			nr_pages += end_pfn - start_pfn;
+	}
+
+	if ((nr_pages << PAGE_SHIFT) >= threshold_bytes) {
+		mem_size_mb = memblock_phys_mem_size() >> 20;
+		pr_err("NUMA: no nodes coverage for %luMB of %luMB RAM\n",
+		       (nr_pages << PAGE_SHIFT) >> 20, mem_size_mb);
+		return false;
+	}
+
+	return true;
+}
+
+
 /**
  * memblock_isolate_range - isolate given range into disjoint memblocks
  * @type: memblock type to isolate range for
-- 
2.39.5





Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1845D7ED009
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235482AbjKOTw1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235460AbjKOTw0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:52:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6D6B8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:52:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA599C433C7;
        Wed, 15 Nov 2023 19:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077942;
        bh=RRtzE9C8tSh/4M/7ZaHUGQy4mNJ08pCcRZSOQemT51I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1DvQ4666/47hM1qtyoZ2CVPLNg9+JEzUi+EzkpL+kX7ttuOUUAALasC+fec/OY8Jw
         Ggf1w5Nbk8H6xVI5UGPu8i6Q/UFoLa+0fKiigL1yPiVEx0qxN3jUAZ5SWUnsplqslk
         qFyqMEiF1fyLzcHWPKPYzEkQTrgpCFrmJ962FgtE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Derick Marks <derick.w.marks@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 012/379] x86/numa: Introduce numa_fill_memblks()
Date:   Wed, 15 Nov 2023 14:21:27 -0500
Message-ID: <20231115192645.880721039@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alison Schofield <alison.schofield@intel.com>

[ Upstream commit 8f012db27c9516be1a7aca93ea4a6ca9c75056c9 ]

numa_fill_memblks() fills in the gaps in numa_meminfo memblks
over an physical address range.

The ACPI driver will use numa_fill_memblks() to implement a new Linux
policy that prescribes extending proximity domains in a portion of a
CFMWS window to the entire window.

Dan Williams offered this explanation of the policy:
A CFWMS is an ACPI data structure that indicates *potential* locations
where CXL memory can be placed. It is the playground where the CXL
driver has free reign to establish regions. That space can be populated
by BIOS created regions, or driver created regions, after hotplug or
other reconfiguration.

When BIOS creates a region in a CXL Window it additionally describes
that subset of the Window range in the other typical ACPI tables SRAT,
SLIT, and HMAT. The rationale for BIOS not pre-describing the entire
CXL Window in SRAT, SLIT, and HMAT is that it can not predict the
future. I.e. there is nothing stopping higher or lower performance
devices being placed in the same Window. Compare that to ACPI memory
hotplug that just onlines additional capacity in the proximity domain
with little freedom for dynamic performance differentiation.

That leaves the OS with a choice, should unpopulated window capacity
match the proximity domain of an existing region, or should it allocate
a new one? This patch takes the simple position of minimizing proximity
domain proliferation by reusing any proximity domain intersection for
the entire Window. If the Window has no intersections then allocate a
new proximity domain. Note that SRAT, SLIT and HMAT information can be
enumerated dynamically in a standard way from device provided data.
Think of CXL as the end of ACPI needing to describe memory attributes,
CXL offers a standard discovery model for performance attributes, but
Linux still needs to interoperate with the old regime.

Reported-by: Derick Marks <derick.w.marks@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Derick Marks <derick.w.marks@intel.com>
Link: https://lore.kernel.org/all/ef078a6f056ca974e5af85997013c0fda9e3326d.1689018477.git.alison.schofield%40intel.com
Stable-dep-of: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/sparsemem.h |  2 +
 arch/x86/mm/numa.c               | 80 ++++++++++++++++++++++++++++++++
 include/linux/numa.h             |  7 +++
 3 files changed, 89 insertions(+)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 64df897c0ee30..1be13b2dfe8bf 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -37,6 +37,8 @@ extern int phys_to_target_node(phys_addr_t start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+extern int numa_fill_memblks(u64 start, u64 end);
+#define numa_fill_memblks numa_fill_memblks
 #endif
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 2aadb2019b4f2..c01c5506fd4ae 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -11,6 +11,7 @@
 #include <linux/nodemask.h>
 #include <linux/sched.h>
 #include <linux/topology.h>
+#include <linux/sort.h>
 
 #include <asm/e820/api.h>
 #include <asm/proto.h>
@@ -961,4 +962,83 @@ int memory_add_physaddr_to_nid(u64 start)
 	return nid;
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
+
+static int __init cmp_memblk(const void *a, const void *b)
+{
+	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
+	const struct numa_memblk *mb = *(const struct numa_memblk **)b;
+
+	return ma->start - mb->start;
+}
+
+static struct numa_memblk *numa_memblk_list[NR_NODE_MEMBLKS] __initdata;
+
+/**
+ * numa_fill_memblks - Fill gaps in numa_meminfo memblks
+ * @start: address to begin fill
+ * @end: address to end fill
+ *
+ * Find and extend numa_meminfo memblks to cover the @start-@end
+ * physical address range, such that the first memblk includes
+ * @start, the last memblk includes @end, and any gaps in between
+ * are filled.
+ *
+ * RETURNS:
+ * 0		  : Success
+ * NUMA_NO_MEMBLK : No memblk exists in @start-@end range
+ */
+
+int __init numa_fill_memblks(u64 start, u64 end)
+{
+	struct numa_memblk **blk = &numa_memblk_list[0];
+	struct numa_meminfo *mi = &numa_meminfo;
+	int count = 0;
+	u64 prev_end;
+
+	/*
+	 * Create a list of pointers to numa_meminfo memblks that
+	 * overlap start, end. Exclude (start == bi->end) since
+	 * end addresses in both a CFMWS range and a memblk range
+	 * are exclusive.
+	 *
+	 * This list of pointers is used to make in-place changes
+	 * that fill out the numa_meminfo memblks.
+	 */
+	for (int i = 0; i < mi->nr_blks; i++) {
+		struct numa_memblk *bi = &mi->blk[i];
+
+		if (start < bi->end && end >= bi->start) {
+			blk[count] = &mi->blk[i];
+			count++;
+		}
+	}
+	if (!count)
+		return NUMA_NO_MEMBLK;
+
+	/* Sort the list of pointers in memblk->start order */
+	sort(&blk[0], count, sizeof(blk[0]), cmp_memblk, NULL);
+
+	/* Make sure the first/last memblks include start/end */
+	blk[0]->start = min(blk[0]->start, start);
+	blk[count - 1]->end = max(blk[count - 1]->end, end);
+
+	/*
+	 * Fill any gaps by tracking the previous memblks
+	 * end address and backfilling to it if needed.
+	 */
+	prev_end = blk[0]->end;
+	for (int i = 1; i < count; i++) {
+		struct numa_memblk *curr = blk[i];
+
+		if (prev_end >= curr->start) {
+			if (prev_end < curr->end)
+				prev_end = curr->end;
+		} else {
+			curr->start = prev_end;
+			prev_end = curr->end;
+		}
+	}
+	return 0;
+}
+
 #endif
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 59df211d051fa..0f512c0aba54b 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -12,6 +12,7 @@
 #define MAX_NUMNODES    (1 << NODES_SHIFT)
 
 #define	NUMA_NO_NODE	(-1)
+#define	NUMA_NO_MEMBLK	(-1)
 
 /* optionally keep NUMA memory info available post init */
 #ifdef CONFIG_NUMA_KEEP_MEMINFO
@@ -43,6 +44,12 @@ static inline int phys_to_target_node(u64 start)
 	return 0;
 }
 #endif
+#ifndef numa_fill_memblks
+static inline int __init numa_fill_memblks(u64 start, u64 end)
+{
+	return NUMA_NO_MEMBLK;
+}
+#endif
 #else /* !CONFIG_NUMA */
 static inline int numa_map_to_online_node(int node)
 {
-- 
2.42.0




Return-Path: <stable+bounces-7554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B7281730F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F6771F22B4F
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41D61D15F;
	Mon, 18 Dec 2023 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ndReNyCN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5971D123;
	Mon, 18 Dec 2023 14:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF16C433C8;
	Mon, 18 Dec 2023 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702908782;
	bh=4BpZ61PHvBwcPVvOpv3IxiRkvEP+REp1+KQvbum4z1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndReNyCNjSH3KCaADrTFXoX7aqt8Hn+KDkNxtUNh76wWlJTTImkqRkgUVL3WhT/Tr
	 joEw6Px6G3EbE2bH7131MJ0mDzV4jOOAeloGBIzM6U4sHwuTj99snfW8kYQWbLll0Y
	 7mf8LKJbJVTT0z9Y5FFlSVKBCnZyyM50ZrH5+W9g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Jianyong Wu <Jianyong.Wu@arm.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Michal Hocko <mhocko@suse.com>,
	Oscar Salvador <osalvador@suse.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Shahab Vahedi <shahab@synopsys.com>
Subject: [PATCH 5.15 07/83] memblock: allow to specify flags with memblock_add_node()
Date: Mon, 18 Dec 2023 14:51:28 +0100
Message-ID: <20231218135050.081096172@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135049.738602288@linuxfoundation.org>
References: <20231218135049.738602288@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Hildenbrand <david@redhat.com>

[ Upstream commit 952eea9b01e4bbb7011329f1b7240844e61e5128 ]

We want to specify flags when hotplugging memory.  Let's prepare to pass
flags to memblock_add_node() by adjusting all existing users.

Note that when hotplugging memory the system is already up and running
and we might have concurrent memblock users: for example, while we're
hotplugging memory, kexec_file code might search for suitable memory
regions to place kexec images.  It's important to add the memory
directly to memblock via a single call with the right flags, instead of
adding the memory first and apply flags later: otherwise, concurrent
memblock users might temporarily stumble over memblocks with wrong
flags, which will be important in a follow-up patch that introduces a
new flag to properly handle add_memory_driver_managed().

Link: https://lkml.kernel.org/r/20211004093605.5830-4-david@redhat.com
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Acked-by: Shahab Vahedi <shahab@synopsys.com>	[arch/arc]
Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: Jianyong Wu <Jianyong.Wu@arm.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Vineet Gupta <vgupta@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: c7206e7bd214 ("MIPS: Loongson64: Handle more memory types passed from firmware")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arc/mm/init.c               | 4 ++--
 arch/ia64/mm/contig.c            | 2 +-
 arch/ia64/mm/init.c              | 2 +-
 arch/m68k/mm/mcfmmu.c            | 3 ++-
 arch/m68k/mm/motorola.c          | 6 ++++--
 arch/mips/loongson64/init.c      | 4 +++-
 arch/mips/sgi-ip27/ip27-memory.c | 3 ++-
 arch/s390/kernel/setup.c         | 3 ++-
 include/linux/memblock.h         | 3 ++-
 include/linux/mm.h               | 2 +-
 mm/memblock.c                    | 9 +++++----
 mm/memory_hotplug.c              | 2 +-
 12 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
index 699ecf1196414..110eb69e9bee8 100644
--- a/arch/arc/mm/init.c
+++ b/arch/arc/mm/init.c
@@ -59,13 +59,13 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 
 		low_mem_sz = size;
 		in_use = 1;
-		memblock_add_node(base, size, 0);
+		memblock_add_node(base, size, 0, MEMBLOCK_NONE);
 	} else {
 #ifdef CONFIG_HIGHMEM
 		high_mem_start = base;
 		high_mem_sz = size;
 		in_use = 1;
-		memblock_add_node(base, size, 1);
+		memblock_add_node(base, size, 1, MEMBLOCK_NONE);
 		memblock_reserve(base, size);
 #endif
 	}
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index 9817caba07026..1e9eaa107eb73 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -153,7 +153,7 @@ find_memory (void)
 	efi_memmap_walk(find_max_min_low_pfn, NULL);
 	max_pfn = max_low_pfn;
 
-	memblock_add_node(0, PFN_PHYS(max_low_pfn), 0);
+	memblock_add_node(0, PFN_PHYS(max_low_pfn), 0, MEMBLOCK_NONE);
 
 	find_initrd();
 
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 5c6da8d83c1ad..5d165607bf354 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -378,7 +378,7 @@ int __init register_active_ranges(u64 start, u64 len, int nid)
 #endif
 
 	if (start < end)
-		memblock_add_node(__pa(start), end - start, nid);
+		memblock_add_node(__pa(start), end - start, nid, MEMBLOCK_NONE);
 	return 0;
 }
 
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index eac9dde651934..6f1f251252944 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -174,7 +174,8 @@ void __init cf_bootmem_alloc(void)
 	m68k_memory[0].addr = _rambase;
 	m68k_memory[0].size = _ramend - _rambase;
 
-	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0);
+	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0,
+			  MEMBLOCK_NONE);
 
 	/* compute total pages in system */
 	num_pages = PFN_DOWN(_ramend - _rambase);
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 9f3f77785aa78..2b05bb2bac00d 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -410,7 +410,8 @@ void __init paging_init(void)
 
 	min_addr = m68k_memory[0].addr;
 	max_addr = min_addr + m68k_memory[0].size;
-	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0);
+	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0,
+			  MEMBLOCK_NONE);
 	for (i = 1; i < m68k_num_memory;) {
 		if (m68k_memory[i].addr < min_addr) {
 			printk("Ignoring memory chunk at 0x%lx:0x%lx before the first chunk\n",
@@ -421,7 +422,8 @@ void __init paging_init(void)
 				(m68k_num_memory - i) * sizeof(struct m68k_mem_info));
 			continue;
 		}
-		memblock_add_node(m68k_memory[i].addr, m68k_memory[i].size, i);
+		memblock_add_node(m68k_memory[i].addr, m68k_memory[i].size, i,
+				  MEMBLOCK_NONE);
 		addr = m68k_memory[i].addr + m68k_memory[i].size;
 		if (addr > max_addr)
 			max_addr = addr;
diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
index c1498fdd5c79c..fc7a5c61d91d6 100644
--- a/arch/mips/loongson64/init.c
+++ b/arch/mips/loongson64/init.c
@@ -77,7 +77,9 @@ void __init szmem(unsigned int node)
 				(u32)node_id, mem_type, mem_start, mem_size);
 			pr_info("       start_pfn:0x%llx, end_pfn:0x%llx, num_physpages:0x%lx\n",
 				start_pfn, end_pfn, num_physpages);
-			memblock_add_node(PFN_PHYS(start_pfn), PFN_PHYS(node_psize), node);
+			memblock_add_node(PFN_PHYS(start_pfn),
+					  PFN_PHYS(node_psize), node,
+					  MEMBLOCK_NONE);
 			break;
 		case SYSTEM_RAM_RESERVED:
 			pr_info("Node%d: mem_type:%d, mem_start:0x%llx, mem_size:0x%llx MB\n",
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 6173684b5aaa0..adc2faeecf7c0 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -341,7 +341,8 @@ static void __init szmem(void)
 				continue;
 			}
 			memblock_add_node(PFN_PHYS(slot_getbasepfn(node, slot)),
-					  PFN_PHYS(slot_psize), node);
+					  PFN_PHYS(slot_psize), node,
+					  MEMBLOCK_NONE);
 		}
 	}
 }
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 4dfe37b068898..b7ce6c7c84c6f 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -596,7 +596,8 @@ static void __init setup_resources(void)
 	 * part of the System RAM resource.
 	 */
 	if (crashk_res.end) {
-		memblock_add_node(crashk_res.start, resource_size(&crashk_res), 0);
+		memblock_add_node(crashk_res.start, resource_size(&crashk_res),
+				  0, MEMBLOCK_NONE);
 		memblock_reserve(crashk_res.start, resource_size(&crashk_res));
 		insert_resource(&iomem_resource, &crashk_res);
 	}
diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 5df38332e4139..307cab05d67ec 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -100,7 +100,8 @@ static inline void memblock_discard(void) {}
 #endif
 
 void memblock_allow_resize(void);
-int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid);
+int memblock_add_node(phys_addr_t base, phys_addr_t size, int nid,
+		      enum memblock_flags flags);
 int memblock_add(phys_addr_t base, phys_addr_t size);
 int memblock_remove(phys_addr_t base, phys_addr_t size);
 int memblock_free(phys_addr_t base, phys_addr_t size);
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a27a6b58d3740..5692055f202cb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2454,7 +2454,7 @@ static inline unsigned long get_num_physpages(void)
  * unsigned long max_zone_pfns[MAX_NR_ZONES] = {max_dma, max_normal_pfn,
  * 							 max_highmem_pfn};
  * for_each_valid_physical_page_range()
- * 	memblock_add_node(base, size, nid)
+ *	memblock_add_node(base, size, nid, MEMBLOCK_NONE)
  * free_area_init(max_zone_pfns);
  */
 void free_area_init(unsigned long *max_zone_pfn);
diff --git a/mm/memblock.c b/mm/memblock.c
index 2b7397781c99a..2f2094b16416e 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -661,6 +661,7 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
  * @base: base address of the new region
  * @size: size of the new region
  * @nid: nid of the new region
+ * @flags: flags of the new region
  *
  * Add new memblock region [@base, @base + @size) to the "memory"
  * type. See memblock_add_range() description for mode details
@@ -669,14 +670,14 @@ static int __init_memblock memblock_add_range(struct memblock_type *type,
  * 0 on success, -errno on failure.
  */
 int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_t size,
-				       int nid)
+				      int nid, enum memblock_flags flags)
 {
 	phys_addr_t end = base + size - 1;
 
-	memblock_dbg("%s: [%pa-%pa] nid=%d %pS\n", __func__,
-		     &base, &end, nid, (void *)_RET_IP_);
+	memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
+		     &base, &end, nid, flags, (void *)_RET_IP_);
 
-	return memblock_add_range(&memblock.memory, base, size, nid, 0);
+	return memblock_add_range(&memblock.memory, base, size, nid, flags);
 }
 
 /**
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index bc52a9d201ea6..2d8e9fb4ce0b2 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1385,7 +1385,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	mem_hotplug_begin();
 
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
-		ret = memblock_add_node(start, size, nid);
+		ret = memblock_add_node(start, size, nid, MEMBLOCK_NONE);
 		if (ret)
 			goto error_mem_hotplug_end;
 	}
-- 
2.43.0





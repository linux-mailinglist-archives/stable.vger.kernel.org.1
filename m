Return-Path: <stable+bounces-23155-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D32F85DF84
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C74221F24708
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D487C097;
	Wed, 21 Feb 2024 14:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PMmM1pJE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28297BB1F;
	Wed, 21 Feb 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525744; cv=none; b=FECt/wfO8bTnrcxObrpeCbhNvmEjd0kKjOyxVVYuVZ9hYzUAAQDK3rS0c2qN8F2quLiqC49ZapQrrbGiKZYWhwHs7eDn/1NucUwGrLIJJxPK1e9z0SVAtm86gaBUMbhkxRP2P/Bys2BqdTr3tKY05Dz35kJ36vem1ShQz12n4PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525744; c=relaxed/simple;
	bh=CP66e+A65JG/gUMMgAq68tyZ9ez7ohzXGhnatm1DUdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pJ2SgLgZ0wGIinvGE06SfKSCyi/bgaO0X//Rrno+63NyLgSwVg19WsNvKqbcMszz9s4RNQHH4DRcBYVpEXdPGNasn15+dLBbSuUOzzQcfqoQjKXS1dG1/hzBZ1RapBxZS0wMZk26ZyGlJvfaL/gPqwpcNOcwcYAAHJjPoJT7RPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PMmM1pJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420C5C433C7;
	Wed, 21 Feb 2024 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708525743;
	bh=CP66e+A65JG/gUMMgAq68tyZ9ez7ohzXGhnatm1DUdg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PMmM1pJEjdCnfHdn01cA1Qo1cgHT9rWlpyR9WPokuWGlOJoVQ5qxV96XHX1ob2wGw
	 X5jeoCTUmFIFbULpn/Kqnh4ygTHNHaVvOIeKJ9bX+euznU6LKSk9e8CYvNH4RjXIfF
	 BoCeq6UBPC/yyTu+ChTYpMhaG8a8pFKCG3hpnxWQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mike Rapoport <rppt@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	David Hildenbrand <david@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Jonathan Corbet <corbet@lwn.net>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <rth@twiddle.net>,
	Vineet Gupta <vgupta@synopsys.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 250/267] arch, mm: remove stale mentions of DISCONIGMEM
Date: Wed, 21 Feb 2024 14:09:51 +0100
Message-ID: <20240221125948.096689842@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
References: <20240221125940.058369148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mike Rapoport <rppt@linux.ibm.com>

[ Upstream commit d3c251ab95b69f3dc189c4657baeac1b4c050789 ]

There are several places that mention DISCONIGMEM in comments or have
stale code guarded by CONFIG_DISCONTIGMEM.

Remove the dead code and update the comments.

Link: https://lkml.kernel.org/r/20210608091316.3622-7-rppt@kernel.org
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Vineet Gupta <vgupta@synopsys.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Stable-dep-of: e1a9ae457369 ("mips: Fix max_mapnr being uninitialized on early stages")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/ia64/kernel/topology.c     | 5 ++---
 arch/ia64/mm/numa.c             | 5 ++---
 arch/mips/include/asm/mmzone.h  | 6 ------
 arch/mips/mm/init.c             | 3 ---
 arch/nds32/include/asm/memory.h | 6 ------
 arch/xtensa/include/asm/page.h  | 4 ----
 include/linux/gfp.h             | 4 ++--
 7 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/arch/ia64/kernel/topology.c b/arch/ia64/kernel/topology.c
index 09fc385c2acd..3639e0a7cb3b 100644
--- a/arch/ia64/kernel/topology.c
+++ b/arch/ia64/kernel/topology.c
@@ -3,9 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * This file contains NUMA specific variables and functions which can
- * be split away from DISCONTIGMEM and are used on NUMA machines with
- * contiguous memory.
+ * This file contains NUMA specific variables and functions which are used on
+ * NUMA machines with contiguous memory.
  * 		2002/08/07 Erich Focht <efocht@ess.nec.de>
  * Populate cpu entries in sysfs for non-numa systems as well
  *  	Intel Corporation - Ashok Raj
diff --git a/arch/ia64/mm/numa.c b/arch/ia64/mm/numa.c
index 5e1015eb6d0d..ad6837d00e7d 100644
--- a/arch/ia64/mm/numa.c
+++ b/arch/ia64/mm/numa.c
@@ -3,9 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * This file contains NUMA specific variables and functions which can
- * be split away from DISCONTIGMEM and are used on NUMA machines with
- * contiguous memory.
+ * This file contains NUMA specific variables and functions which are used on
+ * NUMA machines with contiguous memory.
  * 
  *                         2002/08/07 Erich Focht <efocht@ess.nec.de>
  */
diff --git a/arch/mips/include/asm/mmzone.h b/arch/mips/include/asm/mmzone.h
index b826b8473e95..7649ab45e80c 100644
--- a/arch/mips/include/asm/mmzone.h
+++ b/arch/mips/include/asm/mmzone.h
@@ -20,10 +20,4 @@
 #define nid_to_addrbase(nid) 0
 #endif
 
-#ifdef CONFIG_DISCONTIGMEM
-
-#define pfn_to_nid(pfn)		pa_to_nid((pfn) << PAGE_SHIFT)
-
-#endif /* CONFIG_DISCONTIGMEM */
-
 #endif /* _ASM_MMZONE_H_ */
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index a73899933505..dee6a790d42d 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -453,9 +453,6 @@ void __init mem_init(void)
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_32BIT) && (_PFN_SHIFT > PAGE_SHIFT));
 
 #ifdef CONFIG_HIGHMEM
-#ifdef CONFIG_DISCONTIGMEM
-#error "CONFIG_HIGHMEM and CONFIG_DISCONTIGMEM dont work together yet"
-#endif
 	max_mapnr = highend_pfn ? highend_pfn : max_low_pfn;
 #else
 	max_mapnr = max_low_pfn;
diff --git a/arch/nds32/include/asm/memory.h b/arch/nds32/include/asm/memory.h
index 940d32842793..62faafbc28e4 100644
--- a/arch/nds32/include/asm/memory.h
+++ b/arch/nds32/include/asm/memory.h
@@ -76,18 +76,12 @@
  *  virt_to_page(k)	convert a _valid_ virtual address to struct page *
  *  virt_addr_valid(k)	indicates whether a virtual address is valid
  */
-#ifndef CONFIG_DISCONTIGMEM
-
 #define ARCH_PFN_OFFSET		PHYS_PFN_OFFSET
 #define pfn_valid(pfn)		((pfn) >= PHYS_PFN_OFFSET && (pfn) < (PHYS_PFN_OFFSET + max_mapnr))
 
 #define virt_to_page(kaddr)	(pfn_to_page(__pa(kaddr) >> PAGE_SHIFT))
 #define virt_addr_valid(kaddr)	((unsigned long)(kaddr) >= PAGE_OFFSET && (unsigned long)(kaddr) < (unsigned long)high_memory)
 
-#else /* CONFIG_DISCONTIGMEM */
-#error CONFIG_DISCONTIGMEM is not supported yet.
-#endif /* !CONFIG_DISCONTIGMEM */
-
 #define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
 
 #endif
diff --git a/arch/xtensa/include/asm/page.h b/arch/xtensa/include/asm/page.h
index 09c56cba442e..5a42d663612b 100644
--- a/arch/xtensa/include/asm/page.h
+++ b/arch/xtensa/include/asm/page.h
@@ -181,10 +181,6 @@ static inline unsigned long ___pa(unsigned long va)
 #define pfn_valid(pfn) \
 	((pfn) >= ARCH_PFN_OFFSET && ((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
 
-#ifdef CONFIG_DISCONTIGMEM
-# error CONFIG_DISCONTIGMEM not supported
-#endif
-
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
 #define page_to_virt(page)	__va(page_to_pfn(page) << PAGE_SHIFT)
 #define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 61f2f6ff9467..c89f8456f18d 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -471,8 +471,8 @@ static inline int gfp_zonelist(gfp_t flags)
  * There are two zonelists per node, one for all zones with memory and
  * one containing just zones from the node the zonelist belongs to.
  *
- * For the normal case of non-DISCONTIGMEM systems the NODE_DATA() gets
- * optimized to &contig_page_data at compile-time.
+ * For the case of non-NUMA systems the NODE_DATA() gets optimized to
+ * &contig_page_data at compile-time.
  */
 static inline struct zonelist *node_zonelist(int nid, gfp_t flags)
 {
-- 
2.43.0





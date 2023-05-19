Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74107095FD
	for <lists+stable@lfdr.de>; Fri, 19 May 2023 13:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjESLLo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 19 May 2023 07:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjESLLo (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 19 May 2023 07:11:44 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FFCD7
        for <stable@vger.kernel.org>; Fri, 19 May 2023 04:11:42 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34JAqhjw022538;
        Fri, 19 May 2023 11:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=zExA2PDaRSPZCZ9L2R8f5sJMRNqveLPwAXVF1X8FLsY=;
 b=biaKRTXmb1wgyprRereu2cPFX4uU3Kk/FDEjPL/rjlZ3zp+j6rxz6uwJqkfWjdiudnhU
 95eCC9MmAOYOjEpXoBWqnGkVaeRDv19Dy5PY59ZUP+KzxPNEWrZE9qoI6S2mwtoE96Kq
 ojik4OlAjIcJJDqxpqAi4F0iEceByUb+A9xCSQ2F1Yu0fQP1m9j+mmZwR9rmKK6K+lQ8
 Vh5r3osQ0jwe64+Jf1htjmTWFoif8BhPpIUxKDp8W5nDo/xQfa7Qx70OoGT5G6SYLicE
 8AkGkjQEXcFa1P99zkn3qtkonXaHXuDP5tguazSFIg6B6S1Wr9ZHb5BKj3cq67ua4gkg ng== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qp7re8kmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:10:53 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34INcXXM029091;
        Fri, 19 May 2023 11:10:51 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qj1tdu4gk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 May 2023 11:10:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34JBAlBa49349010
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 May 2023 11:10:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C68EC2004D;
        Fri, 19 May 2023 11:10:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A528E20040;
        Fri, 19 May 2023 11:10:43 +0000 (GMT)
Received: from li-7e025c4c-278d-11b2-a85c-da661cef46c1.ibm.com.com (unknown [9.43.52.54])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 19 May 2023 11:10:43 +0000 (GMT)
From:   Piyush Sachdeva <piyushs@linux.ibm.com>
To:     stable@vger.kernel.org
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Tarun Sahu <tsahu@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Piyush Sachdeva <piyushs@linux.ibm.com>
Subject: [PATCH 6.3.2] mm/vmemmap/devdax: fix kernel crash when probing devdax devices
Date:   Fri, 19 May 2023 16:39:35 +0530
Message-Id: <43baafa1897127eb0e362bba3e785740017afc50.1684485577.git.piyushs@linux.ibm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2023050736-railway-greyhound-b246@gregkh>
References: <2023050736-railway-greyhound-b246@gregkh>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: unPg4oGMQFH-aRkCTYMrrkBE3hoG14qp
X-Proofpoint-ORIG-GUID: unPg4oGMQFH-aRkCTYMrrkBE3hoG14qp
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_07,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1011
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305190094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>

[ Upstream commit 87a7ae75d7383afa998f57656d1d14e2a730cc47 ]

commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory savings for
compound devmaps") added support for using optimized vmmemap for devdax
devices.  But how vmemmap mappings are created are architecture specific.
For example, powerpc with hash translation doesn't have vmemmap mappings
in init_mm page table instead they are bolted table entries in the
hardware page table

vmemmap_populate_compound_pages() used by vmemmap optimization code is not
aware of these architecture-specific mapping.  Hence allow architecture to
opt for this feature.  I selected architectures supporting
HUGETLB_PAGE_OPTIMIZE_VMEMMAP option as also supporting this feature.

This patch fixes the below crash on ppc64.

BUG: Unable to handle kernel data access on write at 0xc00c000100400038
Faulting instruction address: 0xc000000001269d90
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
Modules linked in:
CPU: 7 PID: 1 Comm: swapper/0 Not tainted 6.3.0-rc5-150500.34-default+ #2 5c90a668b6bbd142599890245c2fb5de19d7d28a
Hardware name: IBM,9009-42G POWER9 (raw) 0x4e0202 0xf000005 of:IBM,FW950.40 (VL950_099) hv:phyp pSeries
NIP:  c000000001269d90 LR: c0000000004c57d4 CTR: 0000000000000000
REGS: c000000003632c30 TRAP: 0300   Not tainted  (6.3.0-rc5-150500.34-default+)
MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 24842228  XER: 00000000
CFAR: c0000000004c57d0 DAR: c00c000100400038 DSISR: 42000000 IRQMASK: 0
....
NIP [c000000001269d90] __init_single_page.isra.74+0x14/0x4c
LR [c0000000004c57d4] __init_zone_device_page+0x44/0xd0
Call Trace:
[c000000003632ed0] [c000000003632f60] 0xc000000003632f60 (unreliable)
[c000000003632f10] [c0000000004c5ca0] memmap_init_zone_device+0x170/0x250
[c000000003632fe0] [c0000000005575f8] memremap_pages+0x2c8/0x7f0
[c0000000036330c0] [c000000000557b5c] devm_memremap_pages+0x3c/0xa0
[c000000003633100] [c000000000d458a8] dev_dax_probe+0x108/0x3e0
[c0000000036331a0] [c000000000d41430] dax_bus_probe+0xb0/0x140
[c0000000036331d0] [c000000000cef27c] really_probe+0x19c/0x520
[c000000003633260] [c000000000cef6b4] __driver_probe_device+0xb4/0x230
[c0000000036332e0] [c000000000cef888] driver_probe_device+0x58/0x120
[c000000003633320] [c000000000cefa6c] __device_attach_driver+0x11c/0x1e0
[c0000000036333a0] [c000000000cebc58] bus_for_each_drv+0xa8/0x130
[c000000003633400] [c000000000ceefcc] __device_attach+0x15c/0x250
[c0000000036334a0] [c000000000ced458] bus_probe_device+0x108/0x110
[c0000000036334f0] [c000000000ce92dc] device_add+0x7fc/0xa10
[c0000000036335b0] [c000000000d447c8] devm_create_dev_dax+0x1d8/0x530
[c000000003633640] [c000000000d46b60] __dax_pmem_probe+0x200/0x270
[c0000000036337b0] [c000000000d46bf0] dax_pmem_probe+0x20/0x70
[c0000000036337d0] [c000000000d2279c] nvdimm_bus_probe+0xac/0x2b0
[c000000003633860] [c000000000cef27c] really_probe+0x19c/0x520
[c0000000036338f0] [c000000000cef6b4] __driver_probe_device+0xb4/0x230
[c000000003633970] [c000000000cef888] driver_probe_device+0x58/0x120
[c0000000036339b0] [c000000000cefd08] __driver_attach+0x1d8/0x240
[c000000003633a30] [c000000000cebb04] bus_for_each_dev+0xb4/0x130
[c000000003633a90] [c000000000cee564] driver_attach+0x34/0x50
[c000000003633ab0] [c000000000ced878] bus_add_driver+0x218/0x300
[c000000003633b40] [c000000000cf1144] driver_register+0xa4/0x1b0
[c000000003633bb0] [c000000000d21a0c] __nd_driver_register+0x5c/0x100
[c000000003633c10] [c00000000206a2e8] dax_pmem_init+0x34/0x48
[c000000003633c30] [c0000000000132d0] do_one_initcall+0x60/0x320
[c000000003633d00] [c0000000020051b0] kernel_init_freeable+0x360/0x400
[c000000003633de0] [c000000000013764] kernel_init+0x34/0x1d0
[c000000003633e50] [c00000000000de14] ret_from_kernel_thread+0x5c/0x64

The patch: 87a7ae75d738 ("mm/vmemmap/devdax: fix kernel crash when probing
devdax devices") would apply cleanly on Linux 6.3.2 stable if all its
dependencies were applied too:
9420f89db2dd ("mm: move most of core MM initialization to mm/mm_init.c")
23baf831a32c ("mm, treewide: redefine MAX_ORDER sanely")
61883d3c3241 ("iommu: fix MAX_ORDER usage in __iommu_dma_alloc_pages()")
7a16d7c7619b ("mm/slub: fix MAX_ORDER usage in calculate_order()")
75558ad31548 ("sparc/mm: fix MAX_ORDER usage in tsb_grow()")

commit 87a7ae75d738 makes changes to 'mm/mm_init.c', of which the changed parts
used to reside in 'mm/page_alloc.c', but were moved to 'mm/mm_init.c' by commit
9420f89db2dd. Hence, applying commit 9420f89db2dd atop the patch described below
(if required in future) would create a conflict.
commit 9420f89db2dd also included the changes made by commit 23baf831a32c to
'mm/page_alloc.c'. Hence, applying commit 23baf831a32c atop commit 9420f89db2dd
or 87a7ae75d738 would also create a conflict.

Nevertheless, the patch below is an iteration of commit 87a7ae75d738 (changes
made here in 'mm/init.c' were put in 'mm/page_alloc.c', where the code
originally resided before commit 9420f89db2dd) and applies on Linux 6.3.2
stable."

Link: https://lkml.kernel.org/r/20230411142214.64464-1-aneesh.kumar@linux.ibm.com
Fixes: 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory savings for compound devmaps")
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Reported-by: Tarun Sahu <tsahu@linux.ibm.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Cc: Muchun Song <songmuchun@bytedance.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Piyush Sachdeva <piyushs@linux.ibm.com>
(cherry picked from commit 87a7ae75d7383afa998f57656d1d14e2a730cc47)
---
 include/linux/mm.h  | 16 ++++++++++++++++
 mm/page_alloc.c     | 10 ++++++----
 mm/sparse-vmemmap.c |  3 +--
 3 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1f79667824eb..ced82b9c18e5 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3425,6 +3425,22 @@ void vmemmap_populate_print_last(void);
 void vmemmap_free(unsigned long start, unsigned long end,
 		struct vmem_altmap *altmap);
 #endif
+
+#ifdef CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+static inline bool vmemmap_can_optimize(struct vmem_altmap *altmap,
+					   struct dev_pagemap *pgmap)
+{
+	return is_power_of_2(sizeof(struct page)) &&
+		pgmap && (pgmap_vmemmap_nr(pgmap) > 1) && !altmap;
+}
+#else
+static inline bool vmemmap_can_optimize(struct vmem_altmap *altmap,
+					   struct dev_pagemap *pgmap)
+{
+	return false;
+}
+#endif
+
 void register_page_bootmem_memmap(unsigned long section_nr, struct page *map,
 				  unsigned long nr_pages);
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8e39705c7bdc..afcfb2a94e6e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6905,10 +6905,12 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
  * of an altmap. See vmemmap_populate_compound_pages().
  */
 static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
-					      unsigned long nr_pages)
+					      struct dev_pagemap *pgmap)
 {
-	return is_power_of_2(sizeof(struct page)) &&
-		!altmap ? 2 * (PAGE_SIZE / sizeof(struct page)) : nr_pages;
+	if (!vmemmap_can_optimize(altmap, pgmap))
+		return pgmap_vmemmap_nr(pgmap);
+
+	return 2 * (PAGE_SIZE / sizeof(struct page));
 }
 
 static void __ref memmap_init_compound(struct page *head,
@@ -6973,7 +6975,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pfns_per_compound));
+				     compound_nr_pages(altmap, pgmap));
 	}
 
 	pr_info("%s initialised %lu pages in %ums\n", __func__,
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index c5398a5960d0..10d73a0dfcec 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -458,8 +458,7 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
 		!IS_ALIGNED(nr_pages, PAGES_PER_SUBSECTION)))
 		return NULL;
 
-	if (is_power_of_2(sizeof(struct page)) &&
-	    pgmap && pgmap_vmemmap_nr(pgmap) > 1 && !altmap)
+	if (vmemmap_can_optimize(altmap, pgmap))
 		r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
 	else
 		r = vmemmap_populate(start, end, nid, altmap);
-- 
2.40.1


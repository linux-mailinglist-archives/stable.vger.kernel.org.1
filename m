Return-Path: <stable+bounces-179191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FCDDB514B7
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 13:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7791C23550
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9183019CB;
	Wed, 10 Sep 2025 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CK/5TWwz"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363C2DCF55
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 11:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757502184; cv=none; b=GNEIW8JVTuuilF9Ri7XvLg5SASWIVCs9sJBg0gknejIli+YOug11Dr+ktpQ2F7XVy7K7CoyGtBWOHSK+RavFjAY66WUvPmrHpMAXkh4+KLU1ar0DrIr08jGPVzAuY4pCppG3DuuWwJfYn3UdWeyCchdGAAniXDqELb40B6B97sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757502184; c=relaxed/simple;
	bh=F5Ff0F97zNBa1WRwplnUihdUQW6RVE/gKGxNPbmp0Sw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rW/Zihx3TUOCI5Fp6maxE2xIdOqn2xb65DYH4ivv+s0ItTrRdnp9yL54VknxMlKi/99Kz190a3CWhkUC9rm2uWHnvgVztLgNcWw8gY5ejr6ihsUhXcRWmYG7CnvX0HnRxKpM+/N/qFZJTjHTQQpSWLVc9MNdRQ4dwNd1n+1MZVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CK/5TWwz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A8G2Z6007665;
	Wed, 10 Sep 2025 11:02:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=+r/mwRsxjtP36e35ZO9Rhg5Tw2Q/9SwD/kals131p
	3M=; b=CK/5TWwz9L2m26eVuixDSDXZjauAPUDcAWE2cyCFgryjTAg/PLVTcZ6hp
	w2iSwfkRUGIiY4JIVxRoR+dEJB8IErihfmOXBynl/GFzpf8ZSGT+AIIxCUP7iwAN
	sPrFrPw35henhFh0kWXkXlUN1zzXUMCs+Rw/UTP2XkXxl1URWRQgjnVgI+6IwC3R
	HSMeY2hujJ9fKnEqTzu4yEMa7lzC6pEuAGmUKlz4GIVNYCmE27QJIj7r/C4d4Hon
	UDH8ipP7fZlbGKoUW6G+i4UgwGzY7gkZYg50ZdfpiOwuirdzVALVzdc7LZFc0cK2
	VtrD5ZZk6WuqSwh1NR+NkX6J9bIbg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyd2ffw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 11:02:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58AB2tmM028581;
	Wed, 10 Sep 2025 11:02:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xyd2fft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 11:02:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58A9jXUi007895;
	Wed, 10 Sep 2025 11:02:54 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pr379-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 11:02:53 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AB2nF116056608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 11:02:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 014492004E;
	Wed, 10 Sep 2025 11:02:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59CD02004D;
	Wed, 10 Sep 2025 11:02:47 +0000 (GMT)
Received: from aboo.ibm.com.com (unknown [9.150.16.221])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 11:02:47 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: stable@vger.kernel.org
Cc: hbathini@linux.ibm.com, mpe@ellerman.id.au, ritesh.list@gmail.com,
        aboorvad@linux.ibm.com
Subject: [PATCH] powerpc/64s/radix/kfence: map __kfence_pool at page granularity
Date: Wed, 10 Sep 2025 16:32:45 +0530
Message-ID: <20250910110245.123817-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QDdQddnfZtJfBxaouOdRJmNFUaeZ8-tM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX/qgznd7n10hK
 uW33Os/TfV/zoabt7NXzLddLnWdBbPGLCusF6TGYFDdSypHV6ZM14sQPGzHt7ABYLilFlVjU+WV
 Bo5gbCf09bwmnhoCoWosT9wEPlZWCudChQpUmmYWOBrmPJLybz6zT8GpnVN0foRa0yZea0APCml
 Fd/3e2A1CCi4yUpfVnqoXxJVwKh03+WnymLmhRJ6mejDLVoCQEfiH5tttozMUmCIRPdBzpV6WDD
 ERZRKyNEXbfowQ7vOqsFMIt9RiNcoSRast5m1AMLWIgie09LfSf27Azil7MGTVItSHmttA5izxQ
 PS1GPdj3jsIgp4r0NsjNwHWmugqHJ3VsHfEAT9xkVrmIAoYsOLXxc8zUHVIipfsxhwq8pDKmvcO
 G+Qj/HvI
X-Proofpoint-GUID: V6SNYzVGVm0ddeZML6h0eTiXNtb658eh
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68c15adf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=bC-a23v3AAAA:8
 a=VnNF1IyMAAAA:8 a=ZcE-8KfG9wawt0JmNZ8A:9 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

From: Hari Bathini <hbathini@linux.ibm.com>

When KFENCE is enabled, total system memory is mapped at page level
granularity. But in radix MMU mode, ~3GB additional memory is needed
to map 100GB of system memory at page level granularity when compared
to using 2MB direct mapping.This is not desired considering KFENCE is
designed to be enabled in production kernels [1].

Mapping only the memory allocated for KFENCE pool at page granularity is
sufficient to enable KFENCE support. So, allocate __kfence_pool during
bootup and map it at page granularity instead of mapping all system
memory at page granularity.

Without patch:
  # cat /proc/meminfo
  MemTotal:       101201920 kB

With patch:
  # cat /proc/meminfo
  MemTotal:       104483904 kB

Note that enabling KFENCE at runtime is disabled for radix MMU for now,
as it depends on the ability to split page table mappings and such APIs
are not currently implemented for radix MMU.

All kfence_test.c testcases passed with this patch.

[1] https://lore.kernel.org/all/20201103175841.3495947-2-elver@google.com/

Fixes: a5edf9815dd7 ("powerpc/64s: Enable KFENCE on book3s64")
Cc: stable@vger.kernel.org
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
Link: https://msgid.link/20240701130021.578240-1-hbathini@linux.ibm.com

---

Upstream commit 353d7a84c214 ("powerpc/64s/radix/kfence: map __kfence_pool at page granularity")

This has already been merged upstream and is required in stable kernels as well.

---
 arch/powerpc/include/asm/kfence.h        | 11 +++-
 arch/powerpc/mm/book3s64/radix_pgtable.c | 84 ++++++++++++++++++++++--
 arch/powerpc/mm/init-common.c            |  3 +
 3 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/kfence.h b/arch/powerpc/include/asm/kfence.h
index 424ceef82ae615..fab124ada1c7f2 100644
--- a/arch/powerpc/include/asm/kfence.h
+++ b/arch/powerpc/include/asm/kfence.h
@@ -15,10 +15,19 @@
 #define ARCH_FUNC_PREFIX "."
 #endif
 
+#ifdef CONFIG_KFENCE
+extern bool kfence_disabled;
+
+static inline void disable_kfence(void)
+{
+	kfence_disabled = true;
+}
+
 static inline bool arch_kfence_init_pool(void)
 {
-	return true;
+	return !kfence_disabled;
 }
+#endif
 
 #ifdef CONFIG_PPC64
 static inline bool kfence_protect_page(unsigned long addr, bool protect)
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 15e88f1439ec20..b0d927009af83c 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -17,6 +17,7 @@
 #include <linux/hugetlb.h>
 #include <linux/string_helpers.h>
 #include <linux/memory.h>
+#include <linux/kfence.h>
 
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
@@ -31,6 +32,7 @@
 #include <asm/uaccess.h>
 #include <asm/ultravisor.h>
 #include <asm/set_memory.h>
+#include <asm/kfence.h>
 
 #include <trace/events/thp.h>
 
@@ -293,7 +295,8 @@ static unsigned long next_boundary(unsigned long addr, unsigned long end)
 
 static int __meminit create_physical_mapping(unsigned long start,
 					     unsigned long end,
-					     int nid, pgprot_t _prot)
+					     int nid, pgprot_t _prot,
+					     unsigned long mapping_sz_limit)
 {
 	unsigned long vaddr, addr, mapping_size = 0;
 	bool prev_exec, exec = false;
@@ -301,7 +304,10 @@ static int __meminit create_physical_mapping(unsigned long start,
 	int psize;
 	unsigned long max_mapping_size = memory_block_size;
 
-	if (debug_pagealloc_enabled_or_kfence())
+	if (mapping_sz_limit < max_mapping_size)
+		max_mapping_size = mapping_sz_limit;
+
+	if (debug_pagealloc_enabled())
 		max_mapping_size = PAGE_SIZE;
 
 	start = ALIGN(start, PAGE_SIZE);
@@ -356,8 +362,74 @@ static int __meminit create_physical_mapping(unsigned long start,
 	return 0;
 }
 
+#ifdef CONFIG_KFENCE
+static bool __ro_after_init kfence_early_init = !!CONFIG_KFENCE_SAMPLE_INTERVAL;
+
+static int __init parse_kfence_early_init(char *arg)
+{
+	int val;
+
+	if (get_option(&arg, &val))
+		kfence_early_init = !!val;
+	return 0;
+}
+early_param("kfence.sample_interval", parse_kfence_early_init);
+
+static inline phys_addr_t alloc_kfence_pool(void)
+{
+	phys_addr_t kfence_pool;
+
+	/*
+	 * TODO: Support to enable KFENCE after bootup depends on the ability to
+	 *       split page table mappings. As such support is not currently
+	 *       implemented for radix pagetables, support enabling KFENCE
+	 *       only at system startup for now.
+	 *
+	 *       After support for splitting mappings is available on radix,
+	 *       alloc_kfence_pool() & map_kfence_pool() can be dropped and
+	 *       mapping for __kfence_pool memory can be
+	 *       split during arch_kfence_init_pool().
+	 */
+	if (!kfence_early_init)
+		goto no_kfence;
+
+	kfence_pool = memblock_phys_alloc(KFENCE_POOL_SIZE, PAGE_SIZE);
+	if (!kfence_pool)
+		goto no_kfence;
+
+	memblock_mark_nomap(kfence_pool, KFENCE_POOL_SIZE);
+	return kfence_pool;
+
+no_kfence:
+	disable_kfence();
+	return 0;
+}
+
+static inline void map_kfence_pool(phys_addr_t kfence_pool)
+{
+	if (!kfence_pool)
+		return;
+
+	if (create_physical_mapping(kfence_pool, kfence_pool + KFENCE_POOL_SIZE,
+				    -1, PAGE_KERNEL, PAGE_SIZE))
+		goto err;
+
+	memblock_clear_nomap(kfence_pool, KFENCE_POOL_SIZE);
+	__kfence_pool = __va(kfence_pool);
+	return;
+
+err:
+	memblock_phys_free(kfence_pool, KFENCE_POOL_SIZE);
+	disable_kfence();
+}
+#else
+static inline phys_addr_t alloc_kfence_pool(void) { return 0; }
+static inline void map_kfence_pool(phys_addr_t kfence_pool) { }
+#endif
+
 static void __init radix_init_pgtable(void)
 {
+	phys_addr_t kfence_pool;
 	unsigned long rts_field;
 	phys_addr_t start, end;
 	u64 i;
@@ -365,6 +437,8 @@ static void __init radix_init_pgtable(void)
 	/* We don't support slb for radix */
 	slb_set_size(0);
 
+	kfence_pool = alloc_kfence_pool();
+
 	/*
 	 * Create the linear mapping
 	 */
@@ -381,9 +455,11 @@ static void __init radix_init_pgtable(void)
 		}
 
 		WARN_ON(create_physical_mapping(start, end,
-						-1, PAGE_KERNEL));
+						-1, PAGE_KERNEL, ~0UL));
 	}
 
+	map_kfence_pool(kfence_pool);
+
 	if (!cpu_has_feature(CPU_FTR_HVMODE) &&
 			cpu_has_feature(CPU_FTR_P9_RADIX_PREFETCH_BUG)) {
 		/*
@@ -875,7 +951,7 @@ int __meminit radix__create_section_mapping(unsigned long start,
 	}
 
 	return create_physical_mapping(__pa(start), __pa(end),
-				       nid, prot);
+				       nid, prot, ~0UL);
 }
 
 int __meminit radix__remove_section_mapping(unsigned long start, unsigned long end)
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index d3a7726ecf512c..21131b96d20901 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -31,6 +31,9 @@ EXPORT_SYMBOL_GPL(kernstart_virt_addr);
 
 bool disable_kuep = !IS_ENABLED(CONFIG_PPC_KUEP);
 bool disable_kuap = !IS_ENABLED(CONFIG_PPC_KUAP);
+#ifdef CONFIG_KFENCE
+bool __ro_after_init kfence_disabled;
+#endif
 
 static int __init parse_nosmep(char *p)
 {



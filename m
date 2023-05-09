Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C4A6FC909
	for <lists+stable@lfdr.de>; Tue,  9 May 2023 16:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbjEIObf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 9 May 2023 10:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235495AbjEIObe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 9 May 2023 10:31:34 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 719881BF
        for <stable@vger.kernel.org>; Tue,  9 May 2023 07:31:31 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 349EAhSN029975;
        Tue, 9 May 2023 14:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=+ySBP7gEA9kSHu5ng4LzCXzJNpWuVl2ZWSZGQbyX3nI=;
 b=kwUayhopYlgSYnRtlxmgFVb4QMzuQRzL35ZB5jdGrK+un/ud0wLH+lX2qV9N0SN0mV+U
 v+ck5i8wn1tGpsNHtsbs0y+alHVzimqzXLfrLUcC0PyTBA1q4EwICVuT2GLraOxC8rVO
 bj81yhuTVZITme3+ED6hL96fPAi+U650WIgyFKV99/qZQdCM7A+0Rruak/WOu70WGWRo
 Fm32UsK1yAwB5Hbr/G6gsUN/D+7bNfA+aivxBH+HtQ1TOx6NuM8TbyyPiaP2S85BJ6S2
 sESV/26SXazjXnMuylH8Skhw/GZlp6Z/09v9fYH4+UYTBtkk0c03qqbL3YnMG7czbDBY pQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qfjvs9sx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 14:31:25 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3494iYc4006987;
        Tue, 9 May 2023 14:31:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3qf7mhgdma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 May 2023 14:31:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 349EVJoM40894762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 9 May 2023 14:31:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B62FE2004B;
        Tue,  9 May 2023 14:31:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D48820040;
        Tue,  9 May 2023 14:31:19 +0000 (GMT)
Received: from localhost (unknown [9.179.7.201])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  9 May 2023 14:31:19 +0000 (GMT)
Date:   Tue, 9 May 2023 16:31:17 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     stable@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH stable 6.3 2/2] s390/mm: fix direct map accounting
Message-ID: <patch-2.thread-961a23.git-961a2364d134.your-ad-here.call-01683642007-ext-1116@work.hours>
References: <cover.thread-961a23.your-ad-here.call-01683642007-ext-1116@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-961a23.your-ad-here.call-01683642007-ext-1116@work.hours>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ncERIswJ3O7myYMgP2kJlAIxZkfBjY9X
X-Proofpoint-ORIG-GUID: ncERIswJ3O7myYMgP2kJlAIxZkfBjY9X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 spamscore=0 priorityscore=1501 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 81e8479649853ffafc714aca4a9c0262efd3160a ]

Commit bb1520d581a3 ("s390/mm: start kernel with DAT enabled") did not
implement direct map accounting in the early page table setup code. In
result the reported values are bogus now:

$cat /proc/meminfo
...
DirectMap4k:        5120 kB
DirectMap1M:    18446744073709546496 kB
DirectMap2G:           0 kB

Fix this by adding the missing accounting. The result looks sane again:

$cat /proc/meminfo
...
DirectMap4k:        6156 kB
DirectMap1M:     2091008 kB
DirectMap2G:     6291456 kB

Fixes: bb1520d581a3 ("s390/mm: start kernel with DAT enabled")
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/boot/vmem.c           | 19 ++++++++++++++++---
 arch/s390/include/asm/pgtable.h |  2 +-
 arch/s390/mm/pageattr.c         |  2 +-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index db8d7cfbc8a4..a354d8bc1f0f 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -10,6 +10,10 @@
 #include "decompressor.h"
 #include "boot.h"
 
+#ifdef CONFIG_PROC_FS
+atomic_long_t __bootdata_preserved(direct_pages_count[PG_DIRECT_MAP_MAX]);
+#endif
+
 #define init_mm			(*(struct mm_struct *)vmlinux.init_mm_off)
 #define swapper_pg_dir		vmlinux.swapper_pg_dir_off
 #define invalid_pg_dir		vmlinux.invalid_pg_dir_off
@@ -126,7 +130,7 @@ static bool can_large_pmd(pmd_t *pm_dir, unsigned long addr, unsigned long end)
 static void pgtable_pte_populate(pmd_t *pmd, unsigned long addr, unsigned long end,
 				 enum populate_mode mode)
 {
-	unsigned long next;
+	unsigned long pages = 0;
 	pte_t *pte, entry;
 
 	pte = pte_offset_kernel(pmd, addr);
@@ -135,14 +139,17 @@ static void pgtable_pte_populate(pmd_t *pmd, unsigned long addr, unsigned long e
 			entry = __pte(_pa(addr, mode));
 			entry = set_pte_bit(entry, PAGE_KERNEL_EXEC);
 			set_pte(pte, entry);
+			pages++;
 		}
 	}
+	if (mode == POPULATE_DIRECT)
+		update_page_count(PG_DIRECT_MAP_4K, pages);
 }
 
 static void pgtable_pmd_populate(pud_t *pud, unsigned long addr, unsigned long end,
 				 enum populate_mode mode)
 {
-	unsigned long next;
+	unsigned long next, pages = 0;
 	pmd_t *pmd, entry;
 	pte_t *pte;
 
@@ -154,6 +161,7 @@ static void pgtable_pmd_populate(pud_t *pud, unsigned long addr, unsigned long e
 				entry = __pmd(_pa(addr, mode));
 				entry = set_pmd_bit(entry, SEGMENT_KERNEL_EXEC);
 				set_pmd(pmd, entry);
+				pages++;
 				continue;
 			}
 			pte = boot_pte_alloc();
@@ -163,12 +171,14 @@ static void pgtable_pmd_populate(pud_t *pud, unsigned long addr, unsigned long e
 		}
 		pgtable_pte_populate(pmd, addr, next, mode);
 	}
+	if (mode == POPULATE_DIRECT)
+		update_page_count(PG_DIRECT_MAP_1M, pages);
 }
 
 static void pgtable_pud_populate(p4d_t *p4d, unsigned long addr, unsigned long end,
 				 enum populate_mode mode)
 {
-	unsigned long next;
+	unsigned long next, pages = 0;
 	pud_t *pud, entry;
 	pmd_t *pmd;
 
@@ -180,6 +190,7 @@ static void pgtable_pud_populate(p4d_t *p4d, unsigned long addr, unsigned long e
 				entry = __pud(_pa(addr, mode));
 				entry = set_pud_bit(entry, REGION3_KERNEL_EXEC);
 				set_pud(pud, entry);
+				pages++;
 				continue;
 			}
 			pmd = boot_crst_alloc(_SEGMENT_ENTRY_EMPTY);
@@ -189,6 +200,8 @@ static void pgtable_pud_populate(p4d_t *p4d, unsigned long addr, unsigned long e
 		}
 		pgtable_pmd_populate(pud, addr, next, mode);
 	}
+	if (mode == POPULATE_DIRECT)
+		update_page_count(PG_DIRECT_MAP_2G, pages);
 }
 
 static void pgtable_p4d_populate(pgd_t *pgd, unsigned long addr, unsigned long end,
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 2c70b4d1263d..acbe1ac2d571 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -34,7 +34,7 @@ enum {
 	PG_DIRECT_MAP_MAX
 };
 
-extern atomic_long_t direct_pages_count[PG_DIRECT_MAP_MAX];
+extern atomic_long_t __bootdata_preserved(direct_pages_count[PG_DIRECT_MAP_MAX]);
 
 static inline void update_page_count(int level, long count)
 {
diff --git a/arch/s390/mm/pageattr.c b/arch/s390/mm/pageattr.c
index 85195c18b2e8..7be699b4974a 100644
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -41,7 +41,7 @@ void __storage_key_init_range(unsigned long start, unsigned long end)
 }
 
 #ifdef CONFIG_PROC_FS
-atomic_long_t direct_pages_count[PG_DIRECT_MAP_MAX];
+atomic_long_t __bootdata_preserved(direct_pages_count[PG_DIRECT_MAP_MAX]);
 
 void arch_report_meminfo(struct seq_file *m)
 {
-- 
2.38.1

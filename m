Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24727035D2
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243567AbjEORDF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243471AbjEORCp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:02:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6672C93FE
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 381AB62A8C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512E5C433EF;
        Mon, 15 May 2023 17:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170042;
        bh=A7FgWNYxsxpW5HK7ZS2NjPW6neCkqv8cP4h2DlUMRu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WsYWICmtFR031isXIXAeIvFBvyANLcMoNNuxUW/RyBksCd1L6tbragW0ug/dkkA6D
         MRwBnQREQxcq/r3Ze1B4Ul1dFtIfivU+yy29Dd4tjyC1qEg+SzAtGnVLfGSCtZyfTu
         5QSgQkVY2OsXiArlaiGauz1XB5TTsM83PkLaIdoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.3 245/246] s390/mm: fix direct map accounting
Date:   Mon, 15 May 2023 18:27:37 +0200
Message-Id: <20230515161730.020103570@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/boot/vmem.c           |   19 ++++++++++++++++---
 arch/s390/include/asm/pgtable.h |    2 +-
 arch/s390/mm/pageattr.c         |    2 +-
 3 files changed, 18 insertions(+), 5 deletions(-)

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
@@ -126,7 +130,7 @@ static bool can_large_pmd(pmd_t *pm_dir,
 static void pgtable_pte_populate(pmd_t *pmd, unsigned long addr, unsigned long end,
 				 enum populate_mode mode)
 {
-	unsigned long next;
+	unsigned long pages = 0;
 	pte_t *pte, entry;
 
 	pte = pte_offset_kernel(pmd, addr);
@@ -135,14 +139,17 @@ static void pgtable_pte_populate(pmd_t *
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
 
@@ -154,6 +161,7 @@ static void pgtable_pmd_populate(pud_t *
 				entry = __pmd(_pa(addr, mode));
 				entry = set_pmd_bit(entry, SEGMENT_KERNEL_EXEC);
 				set_pmd(pmd, entry);
+				pages++;
 				continue;
 			}
 			pte = boot_pte_alloc();
@@ -163,12 +171,14 @@ static void pgtable_pmd_populate(pud_t *
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
 
@@ -180,6 +190,7 @@ static void pgtable_pud_populate(p4d_t *
 				entry = __pud(_pa(addr, mode));
 				entry = set_pud_bit(entry, REGION3_KERNEL_EXEC);
 				set_pud(pud, entry);
+				pages++;
 				continue;
 			}
 			pmd = boot_crst_alloc(_SEGMENT_ENTRY_EMPTY);
@@ -189,6 +200,8 @@ static void pgtable_pud_populate(p4d_t *
 		}
 		pgtable_pmd_populate(pud, addr, next, mode);
 	}
+	if (mode == POPULATE_DIRECT)
+		update_page_count(PG_DIRECT_MAP_2G, pages);
 }
 
 static void pgtable_p4d_populate(pgd_t *pgd, unsigned long addr, unsigned long end,
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -34,7 +34,7 @@ enum {
 	PG_DIRECT_MAP_MAX
 };
 
-extern atomic_long_t direct_pages_count[PG_DIRECT_MAP_MAX];
+extern atomic_long_t __bootdata_preserved(direct_pages_count[PG_DIRECT_MAP_MAX]);
 
 static inline void update_page_count(int level, long count)
 {
--- a/arch/s390/mm/pageattr.c
+++ b/arch/s390/mm/pageattr.c
@@ -41,7 +41,7 @@ void __storage_key_init_range(unsigned l
 }
 
 #ifdef CONFIG_PROC_FS
-atomic_long_t direct_pages_count[PG_DIRECT_MAP_MAX];
+atomic_long_t __bootdata_preserved(direct_pages_count[PG_DIRECT_MAP_MAX]);
 
 void arch_report_meminfo(struct seq_file *m)
 {



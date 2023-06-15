Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48646730CEC
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 03:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbjFOBxd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 21:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239806AbjFOBx0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 21:53:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C418F1BF3
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 18:53:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EJgDNc011728;
        Thu, 15 Jun 2023 01:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=4ip0Pq0V+TMOanGBwHQSXrRvfhsNJi/oRJwlOc5kS1g=;
 b=ANGQFHyg0btCQd3emedNjoyxNI6TymqrLY1r1nkoikVOkqDuM8vJPf+r6dq6xQstukbw
 PBVlrslypOOoAjub2yPtBKB7iHNCJuqkIyd9k1R/7PnHDmhjNMGPh+eGqMWDyVxyKHA9
 zhq9xBqONlBEaIlGPpTX6suoD2BWF+0jraXU+VQX8YSZmijetHg4oDzK/DA6p85rQtu8
 bHeI3LfrElgKfA9syhnGwCH8YV7/I04AWVygiIh9vcsig1E4ltptdgbmZqd3U8r2itbq
 /1WFavlC+MCUZFjmcI00AoLPT4pzfNgit2TnLS19r5T4Hnza4XTQ2a69VXjfBqQRL6mS xw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gsu0syj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:53:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENXhCW021715;
        Thu, 15 Jun 2023 01:53:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6ar05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:53:11 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F1r5rC001175;
        Thu, 15 Jun 2023 01:53:10 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3r4fm6aqvx-3;
        Thu, 15 Jun 2023 01:53:10 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     stable@vger.kernel.org
Cc:     tony.luck@intel.com, dan.j.williams@intel.com,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com, glider@google.com,
        jane.chu@oracle.com
Subject: [5.15-stable PATCH 2/2] mm, hwpoison: when copy-on-write hits poison, take page offline
Date:   Wed, 14 Jun 2023 19:52:55 -0600
Message-Id: <20230615015255.1260473-3-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20230615015255.1260473-1-jane.chu@oracle.com>
References: <20230615015255.1260473-1-jane.chu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306150014
X-Proofpoint-GUID: Vwwn5RweKCYXIYfkHz2HDuOJv66LXUUT
X-Proofpoint-ORIG-GUID: Vwwn5RweKCYXIYfkHz2HDuOJv66LXUUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

commit d302c2398ba269e788a4f37ae57c07a7fcabaa42 upstream.

Cannot call memory_failure() directly from the fault handler because
mmap_lock (and others) are held.

It is important, but not urgent, to mark the source page as h/w poisoned
and unmap it from other tasks.

Use memory_failure_queue() to request a call to memory_failure() for the
page with the error.

Also provide a stub version for CONFIG_MEMORY_FAILURE=n

Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/20221021200120.175753-3-tony.luck@intel.com
Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Conflicts:
	include/linux/mm.h
Due to missing commits
  e591ef7d96d6e ("mm,hwpoison,hugetlb,memory_hotplug: hotremove memory section with hwpoisoned hugepage")
  5033091de814a ("mm/hwpoison: introduce per-memory_block hwpoison counter")
The impact of e591ef7d96d6e is its introduction of an additional flag in
__get_huge_page_for_hwpoison() that serves as an indication a hwpoisoned
hugetlb page should have its migratable bit cleared.
The impact of 5033091de814a is contexual.
Resolve by ignoring both missing commits.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 include/linux/mm.h | 5 ++++-
 mm/memory.c        | 4 +++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e4e1817bb3b8..a27a6b58d374 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3124,7 +3124,6 @@ enum mf_flags {
 	MF_SOFT_OFFLINE = 1 << 3,
 };
 extern int memory_failure(unsigned long pfn, int flags);
-extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
 extern int sysctl_memory_failure_early_kill;
@@ -3133,8 +3132,12 @@ extern void shake_page(struct page *p);
 extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(unsigned long pfn, int flags);
 #ifdef CONFIG_MEMORY_FAILURE
+extern void memory_failure_queue(unsigned long pfn, int flags);
 extern int __get_huge_page_for_hwpoison(unsigned long pfn, int flags);
 #else
+static inline void memory_failure_queue(unsigned long pfn, int flags)
+{
+}
 static inline int __get_huge_page_for_hwpoison(unsigned long pfn, int flags)
 {
 	return 0;
diff --git a/mm/memory.c b/mm/memory.c
index 8dd43a6b6bd7..1bb01b12db53 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2771,8 +2771,10 @@ static inline int cow_user_page(struct page *dst, struct page *src,
 	unsigned long addr = vmf->address;
 
 	if (likely(src)) {
-		if (copy_mc_user_highpage(dst, src, addr, vma))
+		if (copy_mc_user_highpage(dst, src, addr, vma)) {
+			memory_failure_queue(page_to_pfn(src), 0);
 			return -EHWPOISON;
+		}
 		return 0;
 	}
 
-- 
2.18.4


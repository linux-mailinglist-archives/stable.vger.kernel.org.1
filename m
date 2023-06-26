Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0C773EF07
	for <lists+stable@lfdr.de>; Tue, 27 Jun 2023 01:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjFZXEB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 19:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFZXDK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 19:03:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A886C268C
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 16:02:48 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35QMi2wl013366;
        Mon, 26 Jun 2023 23:02:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=s89VEnNVPoGAahv2DHMEJyBzoxqFYNwHsLW0Qa1hQas=;
 b=Caah6ZdocLarx5IEfnJDZ/KgpSLrK6W54j8w2ykcBZ+Cbl/xaTogz10PPV24R1HDxvFh
 A9jeb8tNl50P6Lm4bfDGd/fFRKwARaY4+Lh5nz8pcv6WP5F39LAknAytU5ylR6PqM2HO
 JxbeODcn1qezh2PRjBZt+Ama4fKEbQCkW95J67sYafCqvvBpq4AvWpeLpUd2agVpLaNS
 dvfeqcKvdNLglrznTlnxY1Wxlih276IDwxRrVgPuaEC3BhPReb/D6U3eIKA3W4MzIW26
 +6yJ1pN2PmN9255UiohKY8N5OicUi+yiEKJFdG549O7AcEQ5HdP4CgCgKDPTBIGlDvwk tg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e20cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 23:02:39 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35QMLggK018936;
        Mon, 26 Jun 2023 23:02:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx3ye2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jun 2023 23:02:38 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35QN2Uv5001944;
        Mon, 26 Jun 2023 23:02:38 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3rdpx3ydxg-5;
        Mon, 26 Jun 2023 23:02:38 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     stable@vger.kernel.org
Cc:     tony.luck@intel.com, dan.j.williams@intel.com,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com, glider@google.com,
        jane.chu@oracle.com
Subject: [6.1-stable PATCH 2/2] mm, hwpoison: when copy-on-write hits poison, take page offline
Date:   Mon, 26 Jun 2023 17:02:21 -0600
Message-Id: <20230626230221.3064291-5-jane.chu@oracle.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20230626230221.3064291-1-jane.chu@oracle.com>
References: <20230626230221.3064291-1-jane.chu@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-26_18,2023-06-26_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306260214
X-Proofpoint-GUID: a4PR2-nmLpasi1hfgk0nUt8mGD6HS4i4
X-Proofpoint-ORIG-GUID: a4PR2-nmLpasi1hfgk0nUt8mGD6HS4i4
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
Signed-off-by: Jane Chu <jane.chu@oracle.com>

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
index e5e8acf8eb89..49e14d3afd44 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3295,7 +3295,6 @@ enum mf_flags {
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
 extern int memory_failure(unsigned long pfn, int flags);
-extern void memory_failure_queue(unsigned long pfn, int flags);
 extern void memory_failure_queue_kick(int cpu);
 extern int unpoison_memory(unsigned long pfn);
 extern int sysctl_memory_failure_early_kill;
@@ -3304,8 +3303,12 @@ extern void shake_page(struct page *p);
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
index bd8b04dcc851..bc8b2bd295cb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2861,8 +2861,10 @@ static inline int __wp_page_copy_user(struct page *dst, struct page *src,
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


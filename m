Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8CC730CEB
	for <lists+stable@lfdr.de>; Thu, 15 Jun 2023 03:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjFOBxT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 14 Jun 2023 21:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjFOBxR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Jun 2023 21:53:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA07D137
        for <stable@vger.kernel.org>; Wed, 14 Jun 2023 18:53:16 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EJiNHU015397;
        Thu, 15 Jun 2023 01:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2023-03-30;
 bh=vJsDK7inoEk7bJx3L7/uRkM7MnZK0kpjgjZBHgwXAms=;
 b=fBEfu3VbLZzgSWbgiwipS+FasCqexyz3YJks5LJl+mS4fsYJ1sx2u0uGjcAmLJ2SYShO
 ZgEgxvhpyrfCk05g4RnhVRNMImUh3vdoScjBvernN10fjhOhOVAH6sVls/wqbOjLqDNH
 NpeBuSHAf8SKwoTjQS5Q6AXCTu8UgKTZDvQ+1TZmXTJ94u1LCTCDaXE4RMKM9GU6GtN8
 8k8PlJ9m2Tno36nH8XKaqosf+H3QCDg2LJef7y/wJoPdfVPKvxwzNUP02swM0Wzz3+uC
 KOjPRfPefHeVym1NRKhKrOw1+h1EvXFEnWTF1UK/vF6b8I14h2AhUAst28a2QYFuePlR eA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2arun8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:53:10 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35ENNoYh021624;
        Thu, 15 Jun 2023 01:53:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6aqyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 01:53:09 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35F1r5rA001175;
        Thu, 15 Jun 2023 01:53:09 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3r4fm6aqvx-2;
        Thu, 15 Jun 2023 01:53:09 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     stable@vger.kernel.org
Cc:     tony.luck@intel.com, dan.j.williams@intel.com,
        naoya.horiguchi@nec.com, linmiaohe@huawei.com, glider@google.com,
        jane.chu@oracle.com
Subject: [5.15-stable PATCH 1/2] mm, hwpoison: try to recover from copy-on write faults
Date:   Wed, 14 Jun 2023 19:52:54 -0600
Message-Id: <20230615015255.1260473-2-jane.chu@oracle.com>
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
X-Proofpoint-ORIG-GUID: QHqZJ684qIgpakNZdFK-vRLcaCqA9v2D
X-Proofpoint-GUID: QHqZJ684qIgpakNZdFK-vRLcaCqA9v2D
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

commit a873dfe1032a132bf89f9e19a6ac44f5a0b78754 upstream.

Patch series "Copy-on-write poison recovery", v3.

Part 1 deals with the process that triggered the copy on write fault with
a store to a shared read-only page.  That process is send a SIGBUS with
the usual machine check decoration to specify the virtual address of the
lost page, together with the scope.

Part 2 sets up to asynchronously take the page with the uncorrected error
offline to prevent additional machine check faults.  H/t to Miaohe Lin
<linmiaohe@huawei.com> and Shuai Xue <xueshuai@linux.alibaba.com> for
pointing me to the existing function to queue a call to memory_failure().

On x86 there is some duplicate reporting (because the error is also
signalled by the memory controller as well as by the core that triggered
the machine check).  Console logs look like this:

This patch (of 2):

If the kernel is copying a page as the result of a copy-on-write
fault and runs into an uncorrectable error, Linux will crash because
it does not have recovery code for this case where poison is consumed
by the kernel.

It is easy to set up a test case. Just inject an error into a private
page, fork(2), and have the child process write to the page.

I wrapped that neatly into a test at:

  git://git.kernel.org/pub/scm/linux/kernel/git/aegl/ras-tools.git

just enable ACPI error injection and run:

  # ./einj_mem-uc -f copy-on-write

Add a new copy_user_highpage_mc() function that uses copy_mc_to_kernel()
on architectures where that is available (currently x86 and powerpc).
When an error is detected during the page copy, return VM_FAULT_HWPOISON
to caller of wp_page_copy(). This propagates up the call stack. Both x86
and powerpc have code in their fault handler to deal with this code by
sending a SIGBUS to the application.

Note that this patch avoids a system crash and signals the process that
triggered the copy-on-write action. It does not take any action for the
memory error that is still in the shared page. To handle that a call to
memory_failure() is needed. But this cannot be done from wp_page_copy()
because it holds mmap_lock(). Perhaps the architecture fault handlers
can deal with this loose end in a subsequent patch?

On Intel/x86 this loose end will often be handled automatically because
the memory controller provides an additional notification of the h/w
poison in memory, the handler for this will call memory_failure(). This
isn't a 100% solution. If there are multiple errors, not all may be
logged in this way.

Cc: <stable@vger.kernel.org>
[tony.luck@intel.com: add call to kmsan_unpoison_memory(), per Miaohe Lin]
  Link: https://lkml.kernel.org/r/20221031201029.102123-2-tony.luck@intel.com
Link: https://lkml.kernel.org/r/20221021200120.175753-1-tony.luck@intel.com
Link: https://lkml.kernel.org/r/20221021200120.175753-2-tony.luck@intel.com
Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Conflicts:
	mm/memory.c
Due to missing commits
  c89357e27f20d ("mm: support GUP-triggered unsharing of anonymous pages")
  662ce1dc9caf4 ("delayacct: track delays from write-protect copy")
  b073d7f8aee4e ("mm: kmsan: maintain KMSAN metadata for page operations")
The impact of c89357e27f20d is a name change from cow_user_page() to
__wp_page_copy_user().
The impact of 662ce1dc9caf4 is the introduction of a new feature of
tracking write-protect copy in delayacct.
The impact of b073d7f8aee4e is an introduction of KASAN feature.
None of these commits establishes meaningful dependency, hence resolve by
ignoring them.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 include/linux/highmem.h | 24 ++++++++++++++++++++++++
 mm/memory.c             | 31 +++++++++++++++++++++----------
 2 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index b4c49f9cc379..87763f48c6c3 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -247,6 +247,30 @@ static inline void copy_user_highpage(struct page *to, struct page *from,
 
 #endif
 
+#ifdef copy_mc_to_kernel
+static inline int copy_mc_user_highpage(struct page *to, struct page *from,
+					unsigned long vaddr, struct vm_area_struct *vma)
+{
+	unsigned long ret;
+	char *vfrom, *vto;
+
+	vfrom = kmap_local_page(from);
+	vto = kmap_local_page(to);
+	ret = copy_mc_to_kernel(vto, vfrom, PAGE_SIZE);
+	kunmap_local(vto);
+	kunmap_local(vfrom);
+
+	return ret;
+}
+#else
+static inline int copy_mc_user_highpage(struct page *to, struct page *from,
+					unsigned long vaddr, struct vm_area_struct *vma)
+{
+	copy_user_highpage(to, from, vaddr, vma);
+	return 0;
+}
+#endif
+
 #ifndef __HAVE_ARCH_COPY_HIGHPAGE
 
 static inline void copy_highpage(struct page *to, struct page *from)
diff --git a/mm/memory.c b/mm/memory.c
index 8d71a82462dd..8dd43a6b6bd7 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2753,10 +2753,16 @@ static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
 	return same;
 }
 
-static inline bool cow_user_page(struct page *dst, struct page *src,
-				 struct vm_fault *vmf)
+/*
+ * Return:
+ *	0:		copied succeeded
+ *	-EHWPOISON:	copy failed due to hwpoison in source page
+ *	-EAGAIN:	copied failed (some other reason)
+ */
+static inline int cow_user_page(struct page *dst, struct page *src,
+				      struct vm_fault *vmf)
 {
-	bool ret;
+	int ret;
 	void *kaddr;
 	void __user *uaddr;
 	bool locked = false;
@@ -2765,8 +2771,9 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 	unsigned long addr = vmf->address;
 
 	if (likely(src)) {
-		copy_user_highpage(dst, src, addr, vma);
-		return true;
+		if (copy_mc_user_highpage(dst, src, addr, vma))
+			return -EHWPOISON;
+		return 0;
 	}
 
 	/*
@@ -2793,7 +2800,7 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 			 * and update local tlb only
 			 */
 			update_mmu_tlb(vma, addr, vmf->pte);
-			ret = false;
+			ret = -EAGAIN;
 			goto pte_unlock;
 		}
 
@@ -2818,7 +2825,7 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 		if (!likely(pte_same(*vmf->pte, vmf->orig_pte))) {
 			/* The PTE changed under us, update local tlb */
 			update_mmu_tlb(vma, addr, vmf->pte);
-			ret = false;
+			ret = -EAGAIN;
 			goto pte_unlock;
 		}
 
@@ -2837,7 +2844,7 @@ static inline bool cow_user_page(struct page *dst, struct page *src,
 		}
 	}
 
-	ret = true;
+	ret = 0;
 
 pte_unlock:
 	if (locked)
@@ -3003,6 +3010,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 	pte_t entry;
 	int page_copied = 0;
 	struct mmu_notifier_range range;
+	int ret;
 
 	if (unlikely(anon_vma_prepare(vma)))
 		goto oom;
@@ -3018,17 +3026,20 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		if (!new_page)
 			goto oom;
 
-		if (!cow_user_page(new_page, old_page, vmf)) {
+		ret = cow_user_page(new_page, old_page, vmf);
+		if (ret) {
 			/*
 			 * COW failed, if the fault was solved by other,
 			 * it's fine. If not, userspace would re-fault on
 			 * the same address and we will handle the fault
 			 * from the second attempt.
+			 * The -EHWPOISON case will not be retried.
 			 */
 			put_page(new_page);
 			if (old_page)
 				put_page(old_page);
-			return 0;
+
+			return ret == -EHWPOISON ? VM_FAULT_HWPOISON : 0;
 		}
 	}
 
-- 
2.18.4


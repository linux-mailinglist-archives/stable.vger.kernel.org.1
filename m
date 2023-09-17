Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048127A3C03
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbjIQUZh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240882AbjIQUZK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:25:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399B8101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:25:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51635C433C7;
        Sun, 17 Sep 2023 20:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982304;
        bh=pv+TjT0f91QxPwiUXdsxjCN2P1cZEoCh1ZGXK/Dm2MQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I1KDHVycmJT0SIUpjEQAkLvdypY4IPUTdJ3vg0dNOg9YCvnK2oZKkymchNXFanBHs
         eKLdBf8y2w/74glnglCCb5fQuNCZUad3TF7UmGqtTegu+XN+h1Rq3Jt4JBHlGj/DrF
         o0gMHWo+QqJf9eEIcb8RvSlL7VC+RuxEh1R2aAy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 211/511] powerpc/radix: Move some functions into #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
Date:   Sun, 17 Sep 2023 21:10:38 +0200
Message-ID: <20230917191118.915041718@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe Leroy <christophe.leroy@csgroup.eu>

[ Upstream commit 4a9dd8f292efd614f0a18452e6474fe19ae17b47 ]

With skiboot_defconfig, Clang reports:

  CC      arch/powerpc/mm/book3s64/radix_tlb.o
arch/powerpc/mm/book3s64/radix_tlb.c:419:20: error: unused function '_tlbie_pid_lpid' [-Werror,-Wunused-function]
static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
                   ^
arch/powerpc/mm/book3s64/radix_tlb.c:663:20: error: unused function '_tlbie_va_range_lpid' [-Werror,-Wunused-function]
static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
                   ^

This is because those functions are only called from functions
enclosed in a #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE

Move below functions inside that #ifdef
* __tlbie_pid_lpid(unsigned long pid,
* __tlbie_va_lpid(unsigned long va, unsigned long pid,
* fixup_tlbie_pid_lpid(unsigned long pid, unsigned long lpid)
* _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
* fixup_tlbie_va_range_lpid(unsigned long va,
* __tlbie_va_range_lpid(unsigned long start, unsigned long end,
* _tlbie_va_range_lpid(unsigned long start, unsigned long end,

Fixes: f0c6fbbb9050 ("KVM: PPC: Book3S HV: Add support for H_RPT_INVALIDATE")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307260802.Mjr99P5O-lkp@intel.com/
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://msgid.link/3d72efd39f986ee939d068af69fdce28bd600766.1691568093.git.christophe.leroy@csgroup.eu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/mm/book3s64/radix_tlb.c | 240 ++++++++++++++-------------
 1 file changed, 121 insertions(+), 119 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/radix_tlb.c b/arch/powerpc/mm/book3s64/radix_tlb.c
index 5172d5cec2c06..6972fd5d423c0 100644
--- a/arch/powerpc/mm/book3s64/radix_tlb.c
+++ b/arch/powerpc/mm/book3s64/radix_tlb.c
@@ -127,21 +127,6 @@ static __always_inline void __tlbie_pid(unsigned long pid, unsigned long ric)
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
-static __always_inline void __tlbie_pid_lpid(unsigned long pid,
-					     unsigned long lpid,
-					     unsigned long ric)
-{
-	unsigned long rb, rs, prs, r;
-
-	rb = PPC_BIT(53); /* IS = 1 */
-	rs = (pid << PPC_BITLSHIFT(31)) | (lpid & ~(PPC_BITMASK(0, 31)));
-	prs = 1; /* process scoped */
-	r = 1;   /* radix format */
-
-	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
-		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	trace_tlbie(0, 0, rb, rs, ric, prs, r);
-}
 static __always_inline void __tlbie_lpid(unsigned long lpid, unsigned long ric)
 {
 	unsigned long rb,rs,prs,r;
@@ -202,23 +187,6 @@ static __always_inline void __tlbie_va(unsigned long va, unsigned long pid,
 	trace_tlbie(0, 0, rb, rs, ric, prs, r);
 }
 
-static __always_inline void __tlbie_va_lpid(unsigned long va, unsigned long pid,
-					    unsigned long lpid,
-					    unsigned long ap, unsigned long ric)
-{
-	unsigned long rb, rs, prs, r;
-
-	rb = va & ~(PPC_BITMASK(52, 63));
-	rb |= ap << PPC_BITLSHIFT(58);
-	rs = (pid << PPC_BITLSHIFT(31)) | (lpid & ~(PPC_BITMASK(0, 31)));
-	prs = 1; /* process scoped */
-	r = 1;   /* radix format */
-
-	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
-		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
-	trace_tlbie(0, 0, rb, rs, ric, prs, r);
-}
-
 static __always_inline void __tlbie_lpid_va(unsigned long va, unsigned long lpid,
 					    unsigned long ap, unsigned long ric)
 {
@@ -264,22 +232,6 @@ static inline void fixup_tlbie_va_range(unsigned long va, unsigned long pid,
 	}
 }
 
-static inline void fixup_tlbie_va_range_lpid(unsigned long va,
-					     unsigned long pid,
-					     unsigned long lpid,
-					     unsigned long ap)
-{
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_ERAT_BUG)) {
-		asm volatile("ptesync" : : : "memory");
-		__tlbie_pid_lpid(0, lpid, RIC_FLUSH_TLB);
-	}
-
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
-		asm volatile("ptesync" : : : "memory");
-		__tlbie_va_lpid(va, pid, lpid, ap, RIC_FLUSH_TLB);
-	}
-}
-
 static inline void fixup_tlbie_pid(unsigned long pid)
 {
 	/*
@@ -299,26 +251,6 @@ static inline void fixup_tlbie_pid(unsigned long pid)
 	}
 }
 
-static inline void fixup_tlbie_pid_lpid(unsigned long pid, unsigned long lpid)
-{
-	/*
-	 * We can use any address for the invalidation, pick one which is
-	 * probably unused as an optimisation.
-	 */
-	unsigned long va = ((1UL << 52) - 1);
-
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_ERAT_BUG)) {
-		asm volatile("ptesync" : : : "memory");
-		__tlbie_pid_lpid(0, lpid, RIC_FLUSH_TLB);
-	}
-
-	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
-		asm volatile("ptesync" : : : "memory");
-		__tlbie_va_lpid(va, pid, lpid, mmu_get_ap(MMU_PAGE_64K),
-				RIC_FLUSH_TLB);
-	}
-}
-
 static inline void fixup_tlbie_lpid_va(unsigned long va, unsigned long lpid,
 				       unsigned long ap)
 {
@@ -416,31 +348,6 @@ static inline void _tlbie_pid(unsigned long pid, unsigned long ric)
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
-static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
-				   unsigned long ric)
-{
-	asm volatile("ptesync" : : : "memory");
-
-	/*
-	 * Workaround the fact that the "ric" argument to __tlbie_pid
-	 * must be a compile-time contraint to match the "i" constraint
-	 * in the asm statement.
-	 */
-	switch (ric) {
-	case RIC_FLUSH_TLB:
-		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_TLB);
-		fixup_tlbie_pid_lpid(pid, lpid);
-		break;
-	case RIC_FLUSH_PWC:
-		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
-		break;
-	case RIC_FLUSH_ALL:
-	default:
-		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_ALL);
-		fixup_tlbie_pid_lpid(pid, lpid);
-	}
-	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
-}
 struct tlbiel_pid {
 	unsigned long pid;
 	unsigned long ric;
@@ -566,20 +473,6 @@ static inline void __tlbie_va_range(unsigned long start, unsigned long end,
 	fixup_tlbie_va_range(addr - page_size, pid, ap);
 }
 
-static inline void __tlbie_va_range_lpid(unsigned long start, unsigned long end,
-					 unsigned long pid, unsigned long lpid,
-					 unsigned long page_size,
-					 unsigned long psize)
-{
-	unsigned long addr;
-	unsigned long ap = mmu_get_ap(psize);
-
-	for (addr = start; addr < end; addr += page_size)
-		__tlbie_va_lpid(addr, pid, lpid, ap, RIC_FLUSH_TLB);
-
-	fixup_tlbie_va_range_lpid(addr - page_size, pid, lpid, ap);
-}
-
 static __always_inline void _tlbie_va(unsigned long va, unsigned long pid,
 				      unsigned long psize, unsigned long ric)
 {
@@ -660,18 +553,6 @@ static inline void _tlbie_va_range(unsigned long start, unsigned long end,
 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
 }
 
-static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
-					unsigned long pid, unsigned long lpid,
-					unsigned long page_size,
-					unsigned long psize, bool also_pwc)
-{
-	asm volatile("ptesync" : : : "memory");
-	if (also_pwc)
-		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
-	__tlbie_va_range_lpid(start, end, pid, lpid, page_size, psize);
-	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
-}
-
 static inline void _tlbiel_va_range_multicast(struct mm_struct *mm,
 				unsigned long start, unsigned long end,
 				unsigned long pid, unsigned long page_size,
@@ -1468,6 +1349,127 @@ void radix__flush_tlb_all(void)
 }
 
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+static __always_inline void __tlbie_pid_lpid(unsigned long pid,
+					     unsigned long lpid,
+					     unsigned long ric)
+{
+	unsigned long rb, rs, prs, r;
+
+	rb = PPC_BIT(53); /* IS = 1 */
+	rs = (pid << PPC_BITLSHIFT(31)) | (lpid & ~(PPC_BITMASK(0, 31)));
+	prs = 1; /* process scoped */
+	r = 1;   /* radix format */
+
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(0, 0, rb, rs, ric, prs, r);
+}
+
+static __always_inline void __tlbie_va_lpid(unsigned long va, unsigned long pid,
+					    unsigned long lpid,
+					    unsigned long ap, unsigned long ric)
+{
+	unsigned long rb, rs, prs, r;
+
+	rb = va & ~(PPC_BITMASK(52, 63));
+	rb |= ap << PPC_BITLSHIFT(58);
+	rs = (pid << PPC_BITLSHIFT(31)) | (lpid & ~(PPC_BITMASK(0, 31)));
+	prs = 1; /* process scoped */
+	r = 1;   /* radix format */
+
+	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
+		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
+	trace_tlbie(0, 0, rb, rs, ric, prs, r);
+}
+
+static inline void fixup_tlbie_pid_lpid(unsigned long pid, unsigned long lpid)
+{
+	/*
+	 * We can use any address for the invalidation, pick one which is
+	 * probably unused as an optimisation.
+	 */
+	unsigned long va = ((1UL << 52) - 1);
+
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_ERAT_BUG)) {
+		asm volatile("ptesync" : : : "memory");
+		__tlbie_pid_lpid(0, lpid, RIC_FLUSH_TLB);
+	}
+
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
+		asm volatile("ptesync" : : : "memory");
+		__tlbie_va_lpid(va, pid, lpid, mmu_get_ap(MMU_PAGE_64K),
+				RIC_FLUSH_TLB);
+	}
+}
+
+static inline void _tlbie_pid_lpid(unsigned long pid, unsigned long lpid,
+				   unsigned long ric)
+{
+	asm volatile("ptesync" : : : "memory");
+
+	/*
+	 * Workaround the fact that the "ric" argument to __tlbie_pid
+	 * must be a compile-time contraint to match the "i" constraint
+	 * in the asm statement.
+	 */
+	switch (ric) {
+	case RIC_FLUSH_TLB:
+		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_TLB);
+		fixup_tlbie_pid_lpid(pid, lpid);
+		break;
+	case RIC_FLUSH_PWC:
+		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
+		break;
+	case RIC_FLUSH_ALL:
+	default:
+		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_ALL);
+		fixup_tlbie_pid_lpid(pid, lpid);
+	}
+	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
+}
+
+static inline void fixup_tlbie_va_range_lpid(unsigned long va,
+					     unsigned long pid,
+					     unsigned long lpid,
+					     unsigned long ap)
+{
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_ERAT_BUG)) {
+		asm volatile("ptesync" : : : "memory");
+		__tlbie_pid_lpid(0, lpid, RIC_FLUSH_TLB);
+	}
+
+	if (cpu_has_feature(CPU_FTR_P9_TLBIE_STQ_BUG)) {
+		asm volatile("ptesync" : : : "memory");
+		__tlbie_va_lpid(va, pid, lpid, ap, RIC_FLUSH_TLB);
+	}
+}
+
+static inline void __tlbie_va_range_lpid(unsigned long start, unsigned long end,
+					 unsigned long pid, unsigned long lpid,
+					 unsigned long page_size,
+					 unsigned long psize)
+{
+	unsigned long addr;
+	unsigned long ap = mmu_get_ap(psize);
+
+	for (addr = start; addr < end; addr += page_size)
+		__tlbie_va_lpid(addr, pid, lpid, ap, RIC_FLUSH_TLB);
+
+	fixup_tlbie_va_range_lpid(addr - page_size, pid, lpid, ap);
+}
+
+static inline void _tlbie_va_range_lpid(unsigned long start, unsigned long end,
+					unsigned long pid, unsigned long lpid,
+					unsigned long page_size,
+					unsigned long psize, bool also_pwc)
+{
+	asm volatile("ptesync" : : : "memory");
+	if (also_pwc)
+		__tlbie_pid_lpid(pid, lpid, RIC_FLUSH_PWC);
+	__tlbie_va_range_lpid(start, end, pid, lpid, page_size, psize);
+	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
+}
+
 /*
  * Performs process-scoped invalidations for a given LPID
  * as part of H_RPT_INVALIDATE hcall.
-- 
2.40.1




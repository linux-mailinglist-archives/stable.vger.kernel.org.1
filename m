Return-Path: <stable+bounces-196885-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA2EC848D9
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:48:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF3C94E9A32
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 10:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6680526E702;
	Tue, 25 Nov 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hKcNkwB0"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716DB2EBDD6
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067623; cv=none; b=CfehMehattlhmNPOmO5SUwUrouNjZ4VRiSBTRLE8zdtrhx/fX01874VP6ktJsLX+8i8TVddJnYFpEZ5QYReVFODQSxhRHYQgjt6nRrBTB1li3WRPmxCBwGGyxuzODeWSI8FOetCsm/fZyZH98j/UjJ5gHQGox4ydhAsEt40ZQbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067623; c=relaxed/simple;
	bh=59W5tjEY0+W9/eDniPEP1TNcUgBtAZpUAY4dyKX4Reo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScFcYK2on0JQC/e78DVEnzQ/kJU596AUcnOLDw+g52ye8Kg3mV0jZJASUUw8MCeHGXEAPzgzX6fAlPmLM+XRBGdvzlOcBedlSrUYCd8wl69Wyd99evOy0G9RFBL5Sk9ZO0SXi4bvFCCQkRoCcaQKEuCI02uxogydruSF6G3Zyxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hKcNkwB0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP3JXiU012704
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=G4U5dc122kcseG67T
	YBjWgkIjxcdr/B4QQArUWcE7ic=; b=hKcNkwB0gBhX58ND6Swt6U2mV4vIKHKk5
	k+aftmdxazEVO2DJyR6OlKTnw5oDytiXnpc/vYyx1W0+SxZB+03ksnSoZ+YHwcoi
	+OzxVru1YvC4R/DD1wwPNDEjjT3//2WS2BkU+37fL2DIQmQqAsccLkM2MAovCF3e
	62GbvjSeHFoZlAjZb2XQ1kYKWJJL6Gv5Rx34JUPAy2W7/Z3hcxTgcYBIHPCtJglU
	nuIW5f6WQ7j2XMA53PxW9NYMsvxERayrPfZIHWxGBsCsSyAl4lmbiB97plQiS1UG
	ws1HE4tEKcD0dz48sNAeW3f6Kw8BgypVK3fQR38iI/qGgr1S/7B3Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u1v9dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:46:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP93KYV000831
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:46:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4akqvxu9rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:46:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5APAksmu36503818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:46:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2F9D20043;
	Tue, 25 Nov 2025 10:46:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E19F20040;
	Tue, 25 Nov 2025 10:46:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Nov 2025 10:46:54 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 6.12.y] s390/mm: Fix __ptep_rdp() inline assembly
Date: Tue, 25 Nov 2025 11:46:36 +0100
Message-ID: <20251125104636.996014-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025112418-impish-remix-d936@gregkh>
References: <2025112418-impish-remix-d936@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX+B391J/XxSnQ
 /zT2iwQaB4HwUWaGzeYisX3oDcG7e87HXfwHnkOvsBJ0VycB1PDoc8hjN4mtzNAwnYwP3ckCqCI
 Wv5YqFqdlTyRyXdGINhqPQQceb2aUjFxnHrWQa94lkneFZE/DSONEUg/lqdR54iEORBtyK/gUCG
 9xEZYtOuNN+YKAnrrGTGypyx9Dswl+ihddP3t4LNaRi11gq15KDyesvVe5Rm1PZtvXp6Uc1Wnkm
 3dczSuooEU+n82VoQtQoKfGq5q79FgIS8A6vcprol2P2cJ0N45GXwNG1INvvUgoDdw7PEP8C7V+
 wtil18x9Y1oka67jJQ6EHfPWJ2rnInLba4uqJUzRCiU8k7FVdb4Ou7byZT631LT4TdCi3mTOUtn
 Huv7iIRHGfj+dClZUEvQJH45Bydu2A==
X-Authority-Analysis: v=2.4 cv=SuidKfO0 c=1 sm=1 tr=0 ts=69258923 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=gC6Gqo1JwSS8mSENPQoA:9
X-Proofpoint-ORIG-GUID: snRxxlK9MWwdbbSxVIlj_WFgQaFXq-jl
X-Proofpoint-GUID: snRxxlK9MWwdbbSxVIlj_WFgQaFXq-jl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220021

[ Upstream commit 31475b88110c4725b4f9a79c3a0d9bbf97e69e1c ]

When a zero ASCE is passed to the __ptep_rdp() inline assembly, the
generated instruction should have the R3 field of the instruction set to
zero. However the inline assembly is written incorrectly: for such cases a
zero is loaded into a register allocated by the compiler and this register
is then used by the instruction.

This means that selected TLB entries may not be flushed since the specified
ASCE does not match the one which was used when the selected TLB entries
were created.

Fix this by removing the asce and opt parameters of __ptep_rdp(), since
all callers always pass zero, and use a hard-coded register zero for
the R3 field.

Fixes: 0807b856521f ("s390/mm: add support for RDP (Reset DAT-Protection)")
Cc: stable@vger.kernel.org
Reviewed-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
(cherry picked from commit 31475b88110c4725b4f9a79c3a0d9bbf97e69e1c)
---
 arch/s390/include/asm/pgtable.h | 12 +++++-------
 arch/s390/mm/pgtable.c          |  4 ++--
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 5ee73f245a0c..cf5a6af9cf41 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1109,17 +1109,15 @@ static inline pte_t pte_mkhuge(pte_t pte)
 #define IPTE_NODAT	0x400
 #define IPTE_GUEST_ASCE	0x800
 
-static __always_inline void __ptep_rdp(unsigned long addr, pte_t *ptep,
-				       unsigned long opt, unsigned long asce,
-				       int local)
+static __always_inline void __ptep_rdp(unsigned long addr, pte_t *ptep, int local)
 {
 	unsigned long pto;
 
 	pto = __pa(ptep) & ~(PTRS_PER_PTE * sizeof(pte_t) - 1);
-	asm volatile(".insn rrf,0xb98b0000,%[r1],%[r2],%[asce],%[m4]"
+	asm volatile(".insn	rrf,0xb98b0000,%[r1],%[r2],%%r0,%[m4]"
 		     : "+m" (*ptep)
-		     : [r1] "a" (pto), [r2] "a" ((addr & PAGE_MASK) | opt),
-		       [asce] "a" (asce), [m4] "i" (local));
+		     : [r1] "a" (pto), [r2] "a" (addr & PAGE_MASK),
+		       [m4] "i" (local));
 }
 
 static __always_inline void __ptep_ipte(unsigned long address, pte_t *ptep,
@@ -1303,7 +1301,7 @@ static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
 	 * A local RDP can be used to do the flush.
 	 */
 	if (MACHINE_HAS_RDP && !(pte_val(*ptep) & _PAGE_PROTECT))
-		__ptep_rdp(address, ptep, 0, 0, 1);
+		__ptep_rdp(address, ptep, 1);
 }
 #define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index b03c665d7242..8eba28b9975f 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -293,9 +293,9 @@ void ptep_reset_dat_prot(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
 	preempt_disable();
 	atomic_inc(&mm->context.flush_count);
 	if (cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id())))
-		__ptep_rdp(addr, ptep, 0, 0, 1);
+		__ptep_rdp(addr, ptep, 1);
 	else
-		__ptep_rdp(addr, ptep, 0, 0, 0);
+		__ptep_rdp(addr, ptep, 0);
 	/*
 	 * PTE is not invalidated by RDP, only _PAGE_PROTECT is cleared. That
 	 * means it is still valid and active, and must not be changed according
-- 
2.48.1



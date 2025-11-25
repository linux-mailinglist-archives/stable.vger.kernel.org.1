Return-Path: <stable+bounces-196887-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0F2C84915
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 11:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7303D3A73DF
	for <lists+stable@lfdr.de>; Tue, 25 Nov 2025 10:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8731327A;
	Tue, 25 Nov 2025 10:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P1KhV1Ju"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A631282E
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764067882; cv=none; b=G0WDXSSyDLGtBOusALNW24uDOAWYLSqXefI6+KSXiFisZhzb03uSHjgmtxkTfMw7gwOiZR3nZ9MgvOoh1hkCGiPAuGIZOMTrxXqorDx1n/S4jjL1oNLccL1c4kC5AbuLrr7Ls8iPh0rylAz6O986Axf9QC8g1S55N8wA5nTpjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764067882; c=relaxed/simple;
	bh=Mu7s8fGRauMBi3UOMrIHvyLy/XKB1oyY+d+LM7BIhCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G3uB/+f/0jwhbXklDITDblB18kis6t+ONjU8bVo9NVph61uIZBPfnz89931JBXu75HWBXjd+E+xsMN21FMXZXkPJ5t8ItYokEunzQXy7E4oNSGqyVjaT5nPofizHJAv5ckulrjJX2vst1j0dRUDRG+XjKRuDLy7qcup2/2Zk+rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P1KhV1Ju; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5APAEkUH023367
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nRUZm6KQwfaL7yyZX
	bVTnJHtK3B72ctDuuDQseQ6uZI=; b=P1KhV1JuJ1pgzhKn7by93pLZq7jaSn4Wu
	uzsNs3hy6DRn0TRAEHvAGiUfzHkYchgHXROZYnJ017nfeKMxaouMH/kuCU605uTu
	acOGHshLl7TdbGgMwDUajz8Aj9djOWsqZtCULfh30Q9fehV//5s9qpkrM3N3ckCy
	eGbHu8p2/85bIuybjv7FSHHTqCOvPJmRAAXiCWClhZxFyofFK2wmuJpr2OPPIznf
	0Bqv/d/FvMt1yhAe2/0sDb5QuutI7VuIGAlLnpBc0CTaqp/XeSqvG+ojAbkxuiQp
	Q+PoyGlc5YYWlcWnA25tLkjlk+VKsvqX/1CVka8rLGDEY47BgRaQA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak3kjvcnn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:51:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AP9L6ZR030827
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:51:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akqgsbc0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 25 Nov 2025 10:51:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5APApEEx31588622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Nov 2025 10:51:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E47520043;
	Tue, 25 Nov 2025 10:51:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5484520040;
	Tue, 25 Nov 2025 10:51:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Nov 2025 10:51:14 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [PATCH 6.6.y] s390/mm: Fix __ptep_rdp() inline assembly
Date: Tue, 25 Nov 2025 11:51:07 +0100
Message-ID: <20251125105107.1067952-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025112421-strudel-attractor-63fc@gregkh>
References: <2025112421-strudel-attractor-63fc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 638xv1ADunZH_CveXmfN-zUPz4AK5qn1
X-Authority-Analysis: v=2.4 cv=frbRpV4f c=1 sm=1 tr=0 ts=69258a27 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=gC6Gqo1JwSS8mSENPQoA:9
X-Proofpoint-ORIG-GUID: 638xv1ADunZH_CveXmfN-zUPz4AK5qn1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwOCBTYWx0ZWRfX4mmrcuPeI4SX
 hSbvrEBmW9quCpQhUCa1lYcAX/+XWOBm41JW9zGqVwuFKuKqJhRtexsPESRoRWHzMzQLYQhC4Ap
 DBQXXW+CAfNoC6pstAuVFbDDdXFIni0bw22Dh0OPBfzEzccUKSgdRXSqlwH4H2HRS1NT30zQItM
 Schq7pHtJHG0vp/yl2PUScBWRQ7x0KdD+jtPS10FF4OJTSQlw+yB/eckvKCUjj5q4ZmbWjHqMTA
 H4jKrymsGjbSPxhyDVAuUHMr2m+6bseQ/aMnSA58cdVex6DbATlwftOJcoK0y2fYi/DYg3q73Zi
 5qEUIFkZ+Q0KRZ9faMHS0sdhcgdUpRMa7OHc/foCTlmu23Nq2a6Riaji0LflmUNcqE4PN4o7HtZ
 O2e3Irzmbl0WOoxq7FsEHE5EgOi6eA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511220008

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
index da2e91b5b192..2cc9d7bb1b2a 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1065,17 +1065,15 @@ static inline pte_t pte_mkhuge(pte_t pte)
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
@@ -1259,7 +1257,7 @@ static inline void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
 	 * A local RDP can be used to do the flush.
 	 */
 	if (MACHINE_HAS_RDP && !(pte_val(*ptep) & _PAGE_PROTECT))
-		__ptep_rdp(address, ptep, 0, 0, 1);
+		__ptep_rdp(address, ptep, 1);
 }
 #define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 5e349869590a..1fb435b3913c 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -312,9 +312,9 @@ void ptep_reset_dat_prot(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
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



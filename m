Return-Path: <stable+bounces-179142-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B30B509E5
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 02:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3D107A1895
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 00:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25509135A53;
	Wed, 10 Sep 2025 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BaQmpIt+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F845029
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757464121; cv=none; b=U1Db5isqI88zXg8t3rYB9zJ3xRWc8g0s+e4arRg3qzfip24Uxq2+ecBD1RatfFJu/R0WmtfGvuqHTC08wvMIj1cW5UlIiMNgaXjXi3NNoUfBYbXLoIw8lj6pbNm+NE7EBT8Mj7t2tUYJ1sDCgy7Zsq7++KQQFKQloCAe2kkmvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757464121; c=relaxed/simple;
	bh=otOMnzPnS2m/20RoWbmPzmYJ/4qDTNbSGLRvDTCMr18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ug2hpf/4ggzGzXCeg/jlgV4gUcFjLJVMH7bdGsDQAshmMZ1V+s6aXEA4AKVPVE36OnvirN3MBl5NtnFCPS8ky43C03QuWcZ7/II7JxOyRfFRe+ZJLBuxo4un2eZipli1x7cRpc4KHEK+EJGIgieMnvrFsi3McKLHln0adfFEm7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BaQmpIt+; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589L0o6x016921;
	Wed, 10 Sep 2025 00:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=3rykj
	A2uHXoRmYeMK6gw5UNR3thiINlPOgQ4RrFfipM=; b=BaQmpIt+4FbJvChZNJMNK
	7WkVxomwbtxU4rCfMLg+D/QRr1f1ESs5WHNf3xnm+KWlDL0ZTCJ9jA9GFME2O0Lh
	AZp3Q/Aw3xbdqA6BOj9c/IN2GqOZUlMF5ya2X99bdWH1QaDDRnAo9JFOaPArFgUi
	v+XUC2v4Hqoo8xGNBJtx+LG3wVcOdoP+FkrpdWIwebbdSuHmh7jcIo1QdUB23bOp
	vnHMcUkZLDd1ATLtDAz5gqfiPXmVvZxCfg8MbXlbCL/cWhX+OjCh2eQgPAWssEiP
	qAn5Dz8E5UENukgf8QFjjMbPi0Mgqxk0P4PmAjvAuPjQnRgfE0e8AmZCI/9lIM/B
	A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x930h5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 00:28:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589NcOPZ030745;
	Wed, 10 Sep 2025 00:28:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdaa3sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 00:28:30 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58A0STEx002550;
	Wed, 10 Sep 2025 00:28:30 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdaa3s6-2;
	Wed, 10 Sep 2025 00:28:30 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH v3 5.15.y 1/3] KVM: x86: Move open-coded CPUID leaf 0x80000021 EAX bit propagation code
Date: Tue,  9 Sep 2025 20:28:24 -0400
Message-ID: <20250910002826.3010884-2-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250910002826.3010884-1-boris.ostrovsky@oracle.com>
References: <20250910002826.3010884-1-boris.ostrovsky@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_03,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509100003
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfX5f8f3pjtFWv+
 j/PfMb/tPSRfMK8biKx1pydf82lYjSMhURiagRQBnNJ0OeZ7eyrRACHHpzcHOkV47QBLU6E601l
 +Fl54MvKbm8d76/knuNVGrmk0PulScuzA170VRTLmnLGosTIISZWLBn1LACBImfVMupbDefkgEJ
 DPjQMCtn2kHSPCsDe4VmqfJkKw0d467fzDBFKyL4NdyWmkbweDv2Lks9S7iZ33iqWDdBujZC0Gq
 QcCCPdDy1zrVyG+eorg/4Z3KnQRQLhe4IH2VWMka/Nc8aQJyI1kxXOA+XCnjGYL9GNL9FO/0e+5
 e1QL05R+JS9bd/eVUFw7TH3ZNwZH4XCu0U2DqpVJisunoACLS8SuS3m//CAnxQaJgxm1j8EghNN
 YeL/s25x
X-Proofpoint-GUID: Vnvu9PpCqUlDEqmmt0scRb7PZ2TkTNWQ
X-Proofpoint-ORIG-GUID: Vnvu9PpCqUlDEqmmt0scRb7PZ2TkTNWQ
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c0c62f cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=1XWaLZrsAAAA:8
 a=yPCof4ZbAAAA:8 a=5DHEWCDZTGFOdemOZZgA:9

From: Kim Phillips <kim.phillips@amd.com>

Commit c35ac8c4bf600ee23bacb20f863aa7830efb23fb upstream

Move code from __do_cpuid_func() to kvm_set_cpu_caps() in preparation for adding
the features in their native leaf.

Also drop the bit description comments as it will be more self-describing once
the individual features are added.

Whilst there, switch to using the more efficient cpu_feature_enabled() instead
of static_cpu_has().

Note, LFENCE_RDTSC and "NULL selector clears base" are currently synthetic,
Linux-defined feature flags as Linux tracking of the features predates AMD's
definition.  Keep the manual propagation of the flags from their synthetic
counterparts until the kernel fully converts to AMD's definition, otherwise KVM
would stop synthesizing the flags as intended.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Sean Christopherson <seanjc@google.com>
Link: https://lore.kernel.org/r/20230124163319.2277355-3-kim.phillips@amd.com

Move setting of VERW_CLEAR bit to the new
kvm_cpu_cap_mask(CPUID_8000_0021_EAX, ...) site.

Cc: <stable@vger.kernel.org> # 5.15.y
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kvm/cpuid.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3bdb522d48bc..f85a1f7b7582 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -544,6 +544,17 @@ void kvm_set_cpu_caps(void)
 		0 /* SME */ | F(SEV) | 0 /* VM_PAGE_FLUSH */ | F(SEV_ES) |
 		F(SME_COHERENT));
 
+	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
+		BIT(0) /* NO_NESTED_DATA_BP */ |
+		BIT(2) /* LFENCE Always serializing */ | 0 /* SmmPgCfgLock */ |
+		BIT(5) /* The memory form of VERW mitigates TSA */ |
+		BIT(6) /* NULL_SEL_CLR_BASE */ | 0 /* PrefetchCtlMsr */
+	);
+	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
+		kvm_cpu_caps[CPUID_8000_0021_EAX] |= BIT(2) /* LFENCE Always serializing */;
+	if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
+		kvm_cpu_caps[CPUID_8000_0021_EAX] |= BIT(6) /* NULL_SEL_CLR_BASE */;
+
 	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
 		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
 		F(ACE2) | F(ACE2_EN) | F(PHE) | F(PHE_EN) |
@@ -553,8 +564,6 @@ void kvm_set_cpu_caps(void)
 	if (cpu_feature_enabled(X86_FEATURE_SRSO_NO))
 		kvm_cpu_cap_set(X86_FEATURE_SRSO_NO);
 
-	kvm_cpu_cap_mask(CPUID_8000_0021_EAX, F(VERW_CLEAR));
-
 	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0021_ECX,
 		F(TSA_SQ_NO) | F(TSA_L1_NO)
 	);
@@ -1006,17 +1015,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		break;
 	case 0x80000021:
 		entry->ebx = entry->ecx = entry->edx = 0;
-		/*
-		 * Pass down these bits:
-		 *    EAX      0      NNDBP, Processor ignores nested data breakpoints
-		 *    EAX      2      LAS, LFENCE always serializing
-		 *    EAX      6      NSCB, Null selector clear base
-		 *
-		 * Other defined bits are for MSRs that KVM does not expose:
-		 *   EAX      3      SPCL, SMM page configuration lock
-		 *   EAX      13     PCMSR, Prefetch control MSR
-		 */
-		entry->eax &= BIT(0) | BIT(2) | BIT(6);
+		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
 		break;
 	/*Add support for Centaur's CPUID instruction*/
 	case 0xC0000000:
-- 
2.43.5



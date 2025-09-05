Return-Path: <stable+bounces-177890-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFE7B46449
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 22:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0D631CC5B81
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669BC2BE638;
	Fri,  5 Sep 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="noI/kM5o"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDC2D0616
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102641; cv=none; b=SawnUtuSCM8AnhlC+RCf8+83gNb4bsREinB2LaAkxbmAC1DKOEFTF2d7gPpWFKkN5l5ZSPX4XicBoSOBxdr33uFEjjL5ocf7kX8NwGnbGpjRnO2zOuZPoc1BS6ccOSuIXQe/ACRBO5NvtnfEUL6DidZQ4qfaS9/O0+rMYrCvdZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102641; c=relaxed/simple;
	bh=otOMnzPnS2m/20RoWbmPzmYJ/4qDTNbSGLRvDTCMr18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EgDIJgJpnVuhGZ/Nf42jWsQLVaZGpDhyggQdWW+vQfkyE+D3qpETyJ9XWS4DsoOFnojsAXdppU5wHFs7oD6bGlmG9qZCf8Q/VzvHKC5YxYb6lwv35irR5Boz0cv08LT/UQWPAeFtXCbcL0vsqLwdAxmOQrSoyHE8/D4ZcjhLFss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=noI/kM5o; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585IsoQr007512;
	Fri, 5 Sep 2025 20:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=3rykj
	A2uHXoRmYeMK6gw5UNR3thiINlPOgQ4RrFfipM=; b=noI/kM5oLNtiCL7dyXk2y
	fVdCGyHnkE7s1NKSpdaWANtwcNo40+68lvvmXPPKtvvOJYEeNlJ9vKUWVZeDBlL0
	g5vad0sQesr+QGC6PQZ0oACNTkuEAkyIiwTuLOfhPu7oaOTQo6+ZfUgdYJcuZ9QO
	y8bOO17kOdj2md0CJr9Puy2qx8T2SPKZP8ti2iYvpRmeiifJUe/GV03sU4oZ3ffn
	uoLQFZtktD19YffZWaHlN6oldZcM3V9VMiE1+rxxMKYEklgbjQnyzIfLbQFYBYzY
	Aa22cdR3oNvtluI5P/Nm2rVvZG2ElFoz9WTfvZq/hLTYzBgsp/vbzxxNLcFK32v4
	Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4905j604tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 20:03:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585JVNnl019657;
	Fri, 5 Sep 2025 20:03:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrdag17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 20:03:45 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585K3hQ9014431;
	Fri, 5 Sep 2025 20:03:44 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrdafyp-2;
	Fri, 05 Sep 2025 20:03:44 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH v2 5.15.y 1/3] KVM: x86: Move open-coded CPUID leaf 0x80000021 EAX bit propagation code
Date: Fri,  5 Sep 2025 16:03:39 -0400
Message-ID: <20250905200341.2504047-2-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250905200341.2504047-1-boris.ostrovsky@oracle.com>
References: <20250905200341.2504047-1-boris.ostrovsky@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050197
X-Authority-Analysis: v=2.4 cv=GOUIEvNK c=1 sm=1 tr=0 ts=68bb4222 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=1XWaLZrsAAAA:8
 a=yPCof4ZbAAAA:8 a=5DHEWCDZTGFOdemOZZgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDE4NiBTYWx0ZWRfXz2fGASwVroWB
 juGnHzLO6k15ts+uwZiSKjhm0s4+UimwYeoI5drEUxn8cIGp3AWgWAF2vXw4moNqOhQHgynOce3
 +1UR6s01fsJsGWhxOkDG8KfbORwbNyvJ0U8yGTOfz3LnPAEKRNEV9mbpC+SaV5FzS0OOux1ZrEA
 lahRMh/0bCRQhrxaoZ9rsdqOyVFLW2oHolnuwuCCIXtw760TsJVPaogcl7qUUYAnw0Xt39JlaGV
 uahKm+aLt0z//JeTTJ+FtVulQgub0E/RVgPLT7k+fCM/QTS4Ol1949sGyHVwAeZOpaAjDVnsSgK
 /XruB52iQRrAF0nTxrdnV3ZaTPOkzjSe5VXMLDdyNt2tI4Do+2HQntF3zAVPshABPnW5MEYDf6d
 ErHCHZ05
X-Proofpoint-GUID: C-UGzq0zT1Tr1MxmnyvWOT3OvfM-7x6v
X-Proofpoint-ORIG-GUID: C-UGzq0zT1Tr1MxmnyvWOT3OvfM-7x6v

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



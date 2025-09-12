Return-Path: <stable+bounces-179405-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C27B55935
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 00:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 847774E11FB
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 22:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF46D27A92F;
	Fri, 12 Sep 2025 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CiaXcDDw"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C903D283146
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757716171; cv=none; b=OJsyTqSpr0+hEq9YDHDVstDBra+21Bx4a4mRY672AwupBSuXI0TW8k263nsLVPwjTePVBR8coga2adstnQ+MWyGPvkxzh0YUscLN6xYqJF+s2rQkWdJ0HHLIa35B43XytxcRS1FZF6u2G8rA8eZvqJ8kuioB/AnsL2AxmVOnXtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757716171; c=relaxed/simple;
	bh=NDbAxaj6eNksANuJpoPJfvmRgA1O75m64EVNkMEJfgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRbHXimeYlzAeyPWL56qOTxJajYmFNMLr09nK6kq3Voji6uEeCmnuDSb6hkGs2jL/8pm7h0u0X7/P2OmZbh/U4Ie4leDkAMrxv9JbHf9V3fR1NX6dyZJ+BKRjA3STnPx3M2vAIJFYAemR6D1aCeqDyU5SQdQSHrjA84xR6BmhAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CiaXcDDw; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLfp9J031662;
	Fri, 12 Sep 2025 22:29:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=KaPMy
	XIP+3wBWtuDtvlZgtLCV+axgLlBJ3GudbmvCfE=; b=CiaXcDDwzNSZiEjc+Be2s
	iM/utLdhLQL5cvNvu9DvQ8RYxnwmgOM7v6SPcAW1gIPozrOOSFbmKcYoOao0xPE1
	wY9ONtBj0wZfYykx+9REFeNpNieg/HoAVJJIWcR9vkZgOgvPy/gcPLgBBUsAk8aI
	t7tmY2O6zZ/++fUbTUYeo8xFdlMY0IyU38yniqUQoGKAMoA/tvwoL6q702K0ma7W
	gLKBiYR2U8uq8rcXezs5LD31hTE2Zho4yoDSNBVHVNuaKttza3c96wyZrIw8oAUc
	IF4xQilpQ64ONx9TZ1BiB5UZ3NKHKEu085TpG67dZekSgKMBznFUmnuzZ3YPYLbN
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 492296941d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 22:29:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLjPsM013639;
	Fri, 12 Sep 2025 22:29:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdemaj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 22:29:19 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58CMTHqk020533;
	Fri, 12 Sep 2025 22:29:18 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdemaha-2;
	Fri, 12 Sep 2025 22:29:18 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH 6.1.y 1/3] KVM: x86: Move open-coded CPUID leaf 0x80000021 EAX bit propagation code
Date: Fri, 12 Sep 2025 18:29:13 -0400
Message-ID: <20250912222915.3143868-2-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250912222915.3143868-1-boris.ostrovsky@oracle.com>
References: <20250912222915.3143868-1-boris.ostrovsky@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_08,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120207
X-Proofpoint-GUID: qFSIJ4o8AEnV3xcO4O9fl1LS3EIVJZVC
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c49ec0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=1XWaLZrsAAAA:8
 a=yPCof4ZbAAAA:8 a=5DHEWCDZTGFOdemOZZgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX2PVWwSI/ryG6
 PcL6w15bGXGYgioMYNb+SLllpBaBRA01gw+0KWD/AJ5BnNfNTZHp4vx3XMvCOPr+eah3O4+XgS+
 Wu6PIvA10ztZWMsCqXUn7Ek1T9W/3+ZXwOclGI1c3jlFn4OVnXN/N7VZ02jcWctKFV8Yrnznl7h
 GFGX1hHkg/jkEdaGX2qBVLzbDpfcaU9Zcc97Tcl1bvTf675J9NeF7KvhQLvf7pZsb+yyZUerGH+
 WcXUDunDNO+t9iG8VTSahNdSr2PMrwyzTzQjjfA4zb96pPGM+WHfG1e5uCZKxqCvU6SiJCvwd0G
 g5RnIekPmxhLqKaVg7bj1rbICMWZSkPwnYJshoUk5sDX5GjNMap78QqkCiMqAzzufy1gpa4WbJ4
 FT8RywnE
X-Proofpoint-ORIG-GUID: qFSIJ4o8AEnV3xcO4O9fl1LS3EIVJZVC

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

Cc: <stable@vger.kernel.org> # 6.1.y
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kvm/cpuid.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 1bb5e8f6c63e..4f60341b1e94 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -749,6 +749,18 @@ void kvm_set_cpu_caps(void)
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
+	kvm_cpu_caps[CPUID_8000_0021_EAX] |= BIT(9) /* NO_SMM_CTL_MSR */;
+
 	kvm_cpu_cap_mask(CPUID_C000_0001_EDX,
 		F(XSTORE) | F(XSTORE_EN) | F(XCRYPT) | F(XCRYPT_EN) |
 		F(ACE2) | F(ACE2_EN) | F(PHE) | F(PHE_EN) |
@@ -758,8 +770,6 @@ void kvm_set_cpu_caps(void)
 	if (cpu_feature_enabled(X86_FEATURE_SRSO_NO))
 		kvm_cpu_cap_set(X86_FEATURE_SRSO_NO);
 
-	kvm_cpu_cap_mask(CPUID_8000_0021_EAX, F(VERW_CLEAR));
-
 	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0021_ECX,
 		F(TSA_SQ_NO) | F(TSA_L1_NO)
 	);
@@ -1249,23 +1259,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 		break;
 	case 0x80000021:
-		entry->ebx = entry->edx = 0;
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
-		if (static_cpu_has(X86_FEATURE_LFENCE_RDTSC))
-			entry->eax |= BIT(2);
-		if (!static_cpu_has_bug(X86_BUG_NULL_SEG))
-			entry->eax |= BIT(6);
-		cpuid_entry_override(entry, CPUID_8000_0021_ECX);
+		entry->ebx = entry->ecx = entry->edx = 0;
+		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
 		break;
 	/*Add support for Centaur's CPUID instruction*/
 	case 0xC0000000:
-- 
2.43.5



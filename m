Return-Path: <stable+bounces-176529-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0584AB38958
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 20:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CE818967CE
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968282D7DE8;
	Wed, 27 Aug 2025 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sSl86aVS"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC12D7817
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318547; cv=none; b=hOlHMj4KxNFdrIAdBFWl8DldSoAh19ytRjXozXwxGY9yTIAtz3DH0JCfoCZ6SeXUEbVtN8qXYg559Qbr3ypXTSrGXzxokddF3x4rx3ua2jT/pXI4jl2BzPrtTE2oRJQtOC3ZY3lZVdsnr69tgfmlyC92cwzPPxEqnbODyuw73h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318547; c=relaxed/simple;
	bh=jlgfhL5T4qHowXXO0OtbvL4LT0EtkT4oTraGegOtvpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKYQA4Z+sY18T7ERBYDMEvgU7Q79wP35o/kwOBgG6JLiRI3cCBo6W8XwuwGJ1LWg5bWa6VK81tHuFFxrsSmRYmXNnomqNtHVT+JYE/3Q8wJ1EQbDcHOVDjEYUPmSDTnc1DR8vbbqYIqaZRKYc8KArYq3PeaBqQmALYfTGlDBNKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sSl86aVS; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RHUcZr010246;
	Wed, 27 Aug 2025 18:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=ydZlg
	dwLkfO5kJpcwropWybXXSKn2TUPyGX2UZCvR04=; b=sSl86aVS0BdxzlRmMl/sf
	jIgdbnMoLpI/9UeuhVggq45pfGmMRj+yAUt2VGUsE65QH5NIgm1uu/b+1hcU/bc7
	vJD4QkKuiPiLObwU1yt6nTlsZCwJ8uToecKl5mXAho7NtzRS1eBIQMzPTr1QpFJN
	PQ6y60B7//pYM31hN5Y6Gm71Wo1kCuOTeYy4piCBWz68UadNzPR7zNNQqNvIk85P
	D365/21KpQM+Pr3/OIr+JJIXzu73e8g9tyZzHKU0ad+jtZfQ3HnUvSsiaixSIm+C
	HTvZ4LpeeP35v0xGc5xauMM00sfp5+UsXBWozUxbNtazsG8GVtTcTgmAO0iBtC17
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48r8twdt18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 18:15:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RHl0ma014547;
	Wed, 27 Aug 2025 18:15:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43ay066-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 18:15:32 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57RIFWUQ021299;
	Wed, 27 Aug 2025 18:15:32 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48q43ay03r-2;
	Wed, 27 Aug 2025 18:15:32 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH 5.15.y 1/2] KVM: x86: Move open-coded CPUID leaf 0x80000021 EAX bit propagation code
Date: Wed, 27 Aug 2025 14:15:23 -0400
Message-ID: <20250827181524.2089159-2-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250827181524.2089159-1-boris.ostrovsky@oracle.com>
References: <20250827181524.2089159-1-boris.ostrovsky@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270156
X-Proofpoint-ORIG-GUID: WQ_nq8DmCSWPAMIctyMxYlhZKlHZ2W7k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI0MDE4NCBTYWx0ZWRfX0WlV3Movj8BR
 KN6NGAkQp2JvjcgeDofxS7MSla+6ULWCOZ2gVUnn8Fwhemn/sUOCWIeUJsLvgZsxO/i12q9cX3C
 A3HFkc63Yb9gYJDWupVBcW7yQIZqQFgfeqLFSUFtxvpo18h/FV/iNslLrOdYF+vMAMqQAJnKmIa
 nmvWNgZSUSEDsBg644a8OvWUsnb9hr3asYVdeQoEdqWYmjjtRTKuo6XZ4zjwBi7GKv6mXKJ+t+e
 fl1QjzZmDl+g20HBfa6UtrFJ4P6memr5yW54yPpf7h5S1IrBNFOo2mGaqG9xRqGHNiPRMbSjV/Z
 LMqq5F1HV9Nr70JhNvfhfxxgu7MzNciELRgCuQ0Rm4QU5xxg5yEQpat5kQ4dDzJqybZkuzXbCMW
 /dr5eXwyGMrhClkvTW6p4Jl9SQNuIg==
X-Proofpoint-GUID: WQ_nq8DmCSWPAMIctyMxYlhZKlHZ2W7k
X-Authority-Analysis: v=2.4 cv=IciHWXqa c=1 sm=1 tr=0 ts=68af4b46 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=zd2uoN0lAAAA:8 a=1XWaLZrsAAAA:8
 a=yPCof4ZbAAAA:8 a=-DNhfvx533-h8Sos8ekA:9 cc=ntf awl=host:13602

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
Cc: <stable@vger.kernel.org> # 5.15.y
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kvm/cpuid.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 3bdb522d48bc..333f9941147e 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -544,6 +544,16 @@ void kvm_set_cpu_caps(void)
 		0 /* SME */ | F(SEV) | 0 /* VM_PAGE_FLUSH */ | F(SEV_ES) |
 		F(SME_COHERENT));
 
+	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
+		BIT(0) /* NO_NESTED_DATA_BP */ |
+		BIT(2) /* LFENCE Always serializing */ | 0 /* SmmPgCfgLock */ |
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
@@ -1006,17 +1016,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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



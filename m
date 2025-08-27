Return-Path: <stable+bounces-176528-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF50B38957
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 20:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AF51895DFE
	for <lists+stable@lfdr.de>; Wed, 27 Aug 2025 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9FE279DAC;
	Wed, 27 Aug 2025 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Sgo5woen"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C51F55F8
	for <stable@vger.kernel.org>; Wed, 27 Aug 2025 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318545; cv=none; b=frAtgCzpwZIABVeH+/BPMfSeLeDZFv0LjY2cKuuQB7ZsizW3vMjMKIw5cMgr1dDNdsCvDNpahX6xiNPK732dhFi9KP5S8+ORmwFhDO/DMDdfmQNYt7ecNDEJVSV2X0Ruj9GgBqYUvbmfupq3yQM/e0zwKT9UGJBYg+YfNmJpG5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318545; c=relaxed/simple;
	bh=eJpbOfvJg9YrWsuz794Y60eKNxb0VZpgoW3Le6Szi5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nv5kHgfMMJR2VfHXFQDwaY/t0Ow1VoTunOzuT3+k7UHh91B3Gvm3P2jzBX5PMDFK4ZNu+/C7xLh8/eBfynIw1Hy33MZfmUc6RfFVAPehFDs+tn5sHCWq5IVUY6t8rpsgJG0fPGm3IubGabxhRNlqZ6dd/J8ctKMMtkbC9W5F5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Sgo5woen; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RHHTQx004363;
	Wed, 27 Aug 2025 18:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=r2t7b
	xzkJT/AAjE6nu76ngLjk80IK7L+zljB/1EvQc4=; b=Sgo5woenN4UPINXroGRn4
	18XHbKVl0sm4+nB8xWm+ZJ1mi4tNctn041hk0+PoVYb24vIsYpihkRggHSSbIEPS
	YdsKt4UR9SbVSnFypAPUtf1SRJY2WzRXKDNokh2YwLC8JuWMdQgpIoUOeQCRwH5r
	sTFqn5NCsiY7AwsuKPO+SBx7R5Ni8Ssesfgbehw+R4jAzvk5JlLp1Y3H6jhgiHaa
	8E2V/tkj5qHkdmm7dWp3dyUJOimTG5cjKGtKADuUWx2zr/7PSQfr7Ux1gnUv8kvg
	zsxDLWyfeIzjhjLDMak7Doi5Ny/yok37p9mWHVelIXPUDH+ZD83O1Ry9vKq9yRUd
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48eq4vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 18:15:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RGiT1v014572;
	Wed, 27 Aug 2025 18:15:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43ay06c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 18:15:33 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57RIFWUS021299;
	Wed, 27 Aug 2025 18:15:32 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48q43ay03r-3;
	Wed, 27 Aug 2025 18:15:32 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH 5.15.y 2/2] KVM: SVM:  Properly advertise TSA CPUID bits to guests
Date: Wed, 27 Aug 2025 14:15:24 -0400
Message-ID: <20250827181524.2089159-3-boris.ostrovsky@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=907
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270156
X-Proofpoint-GUID: LGGEpP9px1uaGIT_FJ1GPq66jWYaJSZ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfXxWV10HoRmdWZ
 BpMGDdmJBPFT2k9+uwbzGYrO5klJA09Fnrat8F7wlaxrOVipj7lnbCUVKuHzWUsLCTM4PK3lRwS
 d265gZM7KShfCwGdHMWsRWmpcAa9BskpuL1bn+iwgdvlEYRyV8n+Zdf+LKpRqKojBHlkUhr4nd4
 7VxqFI/IfYhQfHwG+2olhG9JRvxi1ROoTT0pFeoucZtcacmZN07f93APsAevyPk8dzAcTcJrUWJ
 gOwNHORiML8CSmYmqb3POPGq67iJxoIviVePgGgw2r6W7Yddt9lixUnhA2BXbsbZw3xWIUy0xDd
 t0S/x188DASb6X9PFZiuAD/Ddj6m1ofb5STsxIGMqxkDNzse5O3Hf1cheh8xieIcVY7U4MeEFzf
 ppi/SV3ChMT1MllTsm4DtPkODmHoFw==
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68af4b46 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=DDwbneJrGOq_KpgygZEA:9
 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: LGGEpP9px1uaGIT_FJ1GPq66jWYaJSZ4

Commit 31272abd5974b38ba312e9cf2ec2f09f9dd7dcba upstream.
Commit f3f9deccfc68a6b7c8c1cc51e902edba23d309d4 LTS

Original LTS backport (commit c334ae4a545a "KVM: SVM: Advertise TSA CPUID bits to guests")
set cpuid caps mask for 0x80000021.EAX leaf but not the actual VERW_CLEAR bit.
TSA_SQ_NO/TSA_L1_NO bits were similarly not set when they are synthesized.

Fix that.

Cc: <stable@vger.kernel.org> # 5.15.y
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kvm/cpuid.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 333f9941147e..8a72b4bf5901 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -547,6 +547,7 @@ void kvm_set_cpu_caps(void)
 	kvm_cpu_cap_mask(CPUID_8000_0021_EAX,
 		BIT(0) /* NO_NESTED_DATA_BP */ |
 		BIT(2) /* LFENCE Always serializing */ | 0 /* SmmPgCfgLock */ |
+		BIT(5) /* The memory form of VERW mitigates TSA */ |
 		BIT(6) /* NULL_SEL_CLR_BASE */ | 0 /* PrefetchCtlMsr */
 	);
 	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC))
@@ -563,12 +564,15 @@ void kvm_set_cpu_caps(void)
 	if (cpu_feature_enabled(X86_FEATURE_SRSO_NO))
 		kvm_cpu_cap_set(X86_FEATURE_SRSO_NO);
 
-	kvm_cpu_cap_mask(CPUID_8000_0021_EAX, F(VERW_CLEAR));
+	kvm_cpu_cap_check_and_set(X86_FEATURE_VERW_CLEAR);
 
 	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0021_ECX,
 		F(TSA_SQ_NO) | F(TSA_L1_NO)
 	);
 
+	kvm_cpu_cap_check_and_set(X86_FEATURE_TSA_SQ_NO);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_TSA_L1_NO);
+
 	/*
 	 * Hide RDTSCP and RDPID if either feature is reported as supported but
 	 * probing MSR_TSC_AUX failed.  This is purely a sanity check and
@@ -1015,8 +1019,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 		entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
 		break;
 	case 0x80000021:
-		entry->ebx = entry->ecx = entry->edx = 0;
+		entry->ebx = entry->edx = 0;
 		cpuid_entry_override(entry, CPUID_8000_0021_EAX);
+		cpuid_entry_override(entry, CPUID_8000_0021_ECX);
 		break;
 	/*Add support for Centaur's CPUID instruction*/
 	case 0xC0000000:
-- 
2.43.5



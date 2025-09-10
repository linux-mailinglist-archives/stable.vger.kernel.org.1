Return-Path: <stable+bounces-179141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A98ACB509E4
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 02:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E04F17E006
	for <lists+stable@lfdr.de>; Wed, 10 Sep 2025 00:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A22212CDBE;
	Wed, 10 Sep 2025 00:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JZP/z9Nk"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3B031D384
	for <stable@vger.kernel.org>; Wed, 10 Sep 2025 00:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757464121; cv=none; b=cCOwa2Ygxj9yR2vuVTxugzHzDDdRXSR2tzRK5zCn70jnR1OktcSsFzJH8748Ifs72mkmOKKIqEIqRQkly/cB3BR1ZIYE7YXlvkZueeX53DqndTfivS9hm2fwb3Wgkyp8myaLteZc+8wMQtkEPn4BrLNMB/0w1oN9uFmzafJ3amc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757464121; c=relaxed/simple;
	bh=IGOV2ISLfYurE50Sbvs2b8+808i8gSqc5ETqYG6lN0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+L1TEMu/yLXb2bBmqh2GZAgAiFFUkO/86qIg60x2t1Q23P3GI681IAhaf4d3PSon/fglMzm4FVpCq331yzFb0yLFQIVTk0bQ/tmXd+R3Awkb2DkTQ97FOIgU32n2lMJ6rN53C1gVv+xKvsV1EDl1m8KcEakv9oaxv3Kn2MMDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JZP/z9Nk; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589L0nr6031127;
	Wed, 10 Sep 2025 00:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=W7oUd
	pn3IkljjBxtsP0V+Z+aOlUNds35xP6nc/G0sxg=; b=JZP/z9Nklf1CelrVbmLG+
	50BATM6Bb3A8yw0+PzsZmULTULXeh9S/zPtHP+tJDHwLqFhnx3qV4YZUZUWDwM3m
	4Sp3p5YxNavfWSNgFP+k768Uk6cTrbn8z7x/JfLfonwOckrEjlfsvFTginAZB/Qs
	2XbEC5LXtnE8epW2xog/ClOCcp8F+QWZXBtSlrKvDQYM8rAIBmksOhtLmVmYwySr
	jZGKdIXnC71CgEhwLMJSVVFzx1duWyRIck2hBz4RDrlN2j46tf7V4KXhJLJkcaEJ
	64qifmpeQXO9iZYHUilEgvFiMQ4bHjB+i7Nht4AA49zV5hFi9JNUas4D4pdiO2/V
	Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921peb53w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 00:28:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 589M49VA030831;
	Wed, 10 Sep 2025 00:28:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdaa3t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 00:28:32 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58A0STF3002550;
	Wed, 10 Sep 2025 00:28:31 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdaa3s6-4;
	Wed, 10 Sep 2025 00:28:31 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH v3 5.15.y 3/3] KVM: SVM: Set synthesized TSA CPUID flags
Date: Tue,  9 Sep 2025 20:28:26 -0400
Message-ID: <20250910002826.3010884-4-boris.ostrovsky@oracle.com>
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
X-Proofpoint-GUID: gWn7wHI_5BYOPPUurxWDwL1-VdgQV-K0
X-Proofpoint-ORIG-GUID: gWn7wHI_5BYOPPUurxWDwL1-VdgQV-K0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfX511gD7ZVzR/k
 u+6HNoemLoWt5eFkKJfgBHjN/4nUC1ZPBonquBR1YKy0zvxHMwH9EdEazH/ifSoYuadBvI6T2Ni
 iJ52w0i8Iu9NQcz4la5EEumxaoHo9aZX6Htn+5ATMmiQlsYGXG1O4Mh371h8H9reCuPkzQtIk/V
 20NzLgWX9Qhwks+TaYfe0wqwKCJHvxEqS6jd4PP3/V2zggPPplK4k2QoumY2jKFgHMeY0fo3uht
 spOQHAHYXz17xJzbNL6SmxC/uOaqE59wN5GcPb6s5L0CJYM9Ivqu7zsg9moaIcqmIP/3jRrFgWv
 Zvrkyn5VVQrv8/0+qG4OA6rZHHCVKh+J3kvaexKqil4bPl2tn3cHVBzN+vcFjLDMEiPwbjrVVCH
 R7Yggfz+
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c0c631 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=yJojWOMRYYMA:10 a=UgJECxHJAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=C2dIJva7guKq7NWXi48A:9 a=-El7cUbtino8hM1DCn8D:22
 a=Yupwre4RP9_Eg_Bd0iYG:22

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Commit f3f9deccfc68a6b7c8c1cc51e902edba23d309d4 LTS

VERW_CLEAR is supposed to be set only by the hypervisor to denote TSA
mitigation support to a guest. SQ_NO and L1_NO are both synthesizable,
and are going to be set by hw CPUID on future machines.

So keep the kvm_cpu_cap_init_kvm_defined() invocation *and* set them
when synthesized.

This fix is stable-only.

Co-developed-by: Jinpu Wang <jinpu.wang@ionos.com>
Signed-off-by: Jinpu Wang <jinpu.wang@ionos.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org> # 5.15.y
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kvm/cpuid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 4a644fcb0334..8a72b4bf5901 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -564,10 +564,15 @@ void kvm_set_cpu_caps(void)
 	if (cpu_feature_enabled(X86_FEATURE_SRSO_NO))
 		kvm_cpu_cap_set(X86_FEATURE_SRSO_NO);
 
+	kvm_cpu_cap_check_and_set(X86_FEATURE_VERW_CLEAR);
+
 	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0021_ECX,
 		F(TSA_SQ_NO) | F(TSA_L1_NO)
 	);
 
+	kvm_cpu_cap_check_and_set(X86_FEATURE_TSA_SQ_NO);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_TSA_L1_NO);
+
 	/*
 	 * Hide RDTSCP and RDPID if either feature is reported as supported but
 	 * probing MSR_TSC_AUX failed.  This is purely a sanity check and
-- 
2.43.5



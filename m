Return-Path: <stable+bounces-177891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F50FB46445
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 22:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B45FBA083F
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CE729C323;
	Fri,  5 Sep 2025 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="E6Hrveht"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5236D2C2ACE
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102641; cv=none; b=jBnBiWETPOagNnOvI3yBZG8NmAbecUjmqdH9llhv6lYE2wKhcT5pW/BQEEd8oO6IKqRuR3Ak1molxhRFRGJTpimk3a4bxAyZr2SSHcRGhrcnc81mVRx9ZaH+9G/lYiJzZnBDTiTcWb1d7gAKf9JyRhsIWxjswTWRo410hV5ytcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102641; c=relaxed/simple;
	bh=IGOV2ISLfYurE50Sbvs2b8+808i8gSqc5ETqYG6lN0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuySuDb4nbWmgShgvLazYuwv8ggx9aNSLIviE43Tq9MJH2ym6Urgfu6nZsTgZ3Y1zynjIDGWj2vg8ayQHaUKtE3UdznjuwlCzx5NC8M8hJL82r8HIe6vxbc6nMZ0kkibDcg7nhEXRiSd5dicAZZ9mIBKP9XweFxtscaFD6DrPOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=E6Hrveht; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585It147007599;
	Fri, 5 Sep 2025 20:03:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=W7oUd
	pn3IkljjBxtsP0V+Z+aOlUNds35xP6nc/G0sxg=; b=E6Hrveht53PrjF6ro/Fqv
	yfGFjTu8nBtD7YfxBIecc8vU80ExJ7ZeW/jLRrY3pN3pD3t0jHWrSn5bXrSlYAEX
	AzianFO6jKYWOassFgElTZxDNWWAM2d1Lnzs9EmYKc0d1wf/LgnE1WORqu4SwUJn
	IDYyV1ety0O0zCyf2SX08E5uIoBUAgAQTrY/xP4xMm4mazS+SkHHydZ2M3Vn8U0f
	0Y3+RTquXnLXgSrTv84hjREtxbTXLFJfGXugm+pPbogAckqrq1ZBwejM5SsqltTO
	XjRXIyOMsEs/CEILhwejzz9lqbl3HgI0Vlmv8lcVEVa8gZ5TosousX2ePYl7oTq3
	A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4905j604u4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 20:03:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585Jg4Y1019624;
	Fri, 5 Sep 2025 20:03:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrdag2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 20:03:47 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585K3hQD014431;
	Fri, 5 Sep 2025 20:03:46 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrdafyp-4;
	Fri, 05 Sep 2025 20:03:46 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH v2 5.15.y 3/3] KVM: SVM: Set synthesized TSA CPUID flags
Date: Fri,  5 Sep 2025 16:03:41 -0400
Message-ID: <20250905200341.2504047-4-boris.ostrovsky@oracle.com>
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
X-Authority-Analysis: v=2.4 cv=GOUIEvNK c=1 sm=1 tr=0 ts=68bb4224 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=UgJECxHJAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=C2dIJva7guKq7NWXi48A:9 a=-El7cUbtino8hM1DCn8D:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDE4NiBTYWx0ZWRfX39nGteWJugnn
 w8yvi1T83i4ehAl9nIsnMzhd2Cfp+dXYaYoEnKNdudRSQWUKP6Hh0+HuY9iYNDsFChR91bRwZhk
 tgpC/ZpXSadvJzkXD/9dP8X03nH0IRiNzCVU17QxNrD0xdcGLPhQqnRZhj7AgqV3o5vCoKv1Lpa
 8jw5DCXbdY4z9CXnm1qsVeb5sqHz8kamhmJIacd7pAy/jwWC0grf1CPLTW3uV3Tv5gboJ3FW8rA
 B3W/ONbCu/u0ulYeG2Az8IUY28uyILuOz7kbniHCUWQTr5USHpZiQ9Y5wjNLgM6tYVk61KaA5qz
 dLguFj8WmL5OFqy0up1NKAvNKaR35XkSMjG7LncFXBWtckTOZwCtVGUjqjqvOFr7ITaBQT4Uaq6
 iLbz4HwN
X-Proofpoint-GUID: tf6BNjYus_drz_5QQHEpAeFiDLpgNE95
X-Proofpoint-ORIG-GUID: tf6BNjYus_drz_5QQHEpAeFiDLpgNE95

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



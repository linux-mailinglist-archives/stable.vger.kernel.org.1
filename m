Return-Path: <stable+bounces-179404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6753FB55934
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 00:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B0E0B63951
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1B028640F;
	Fri, 12 Sep 2025 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A+1GQ3up"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FCF281376
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757716170; cv=none; b=MBv+qR8miCvU/io2LWdOE0VbdVyiX3uV6oahAftSmvdUeCBmydH3HY3nh07tU8vDRTKTHb5MQ/6YeMcza/7IjRZ6Ho1hatNpL/otsCdTZBxbeETnjMCUOTz8NMrTlpsrmfrAY50l9lFrfnLzhFgk3WEu9X0YGr13/rA21F+UVaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757716170; c=relaxed/simple;
	bh=ZZNA5JYeRi05yiFxNrAyqLHEtR/Fuc/ggYJ8yVdNJjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h1JdntldeGMNwsIwvGbX3+MdiXAa63FaI5LF6e4u7mHftOVu+24eB2CEhL3S9idBVcfqm6BT23lAm7IuweD0YQFmwEg/m+9sIhvXOJI8Wqzv3AIoOhRhvTcrl1U45q6Dc6u+CDFtALcqWuwFBgceiKc3DCP/P53reVjlr0el7xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A+1GQ3up; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLgogi000312;
	Fri, 12 Sep 2025 22:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=G1wun
	dBunq96bEi5U/FO1KK/hNAQaY8xilFqxtcWTjA=; b=A+1GQ3uptJSQP/7OORKqs
	kZ1pVNIv5yjABfM3wSuNEYUC3VLAPQ1EB6rOWErEqSTF2+efEtrH8H2lyufdnxqw
	G9B+al8161K0wmsQ5p45pmKbZcQXXcnpYdZ84fkvyGtG8N7IdXZqh+x1AfDE/pFc
	QIY1TGVMp2yJY5zCOnU/UYbeX+qe1UBU47UYxb1wOJUgDWdMrxfCdxhaI6nBpo1O
	mHFixut4FJ7oImpBELH9gUI5NQmHVJ739ZheN41/Z/eO7V1LUJfRzNXSSBYzMuA7
	BQnnZsVfgnBur1GoecNr8J7DJoOVsAGZhbHs10rWz7W6dqGJuiTRA6YmyVl3ZzJr
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 492296941e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 22:29:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLs7O0013398;
	Fri, 12 Sep 2025 22:29:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdemajy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 22:29:21 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58CMTHqo020533;
	Fri, 12 Sep 2025 22:29:20 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdemaha-4;
	Fri, 12 Sep 2025 22:29:20 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH 6.1.y 3/3] KVM: SVM: Set synthesized TSA CPUID flags
Date: Fri, 12 Sep 2025 18:29:15 -0400
Message-ID: <20250912222915.3143868-4-boris.ostrovsky@oracle.com>
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
X-Proofpoint-GUID: y-9Ccz7LNOb_Ti30yiOoswr86ZQJhVL-
X-Authority-Analysis: v=2.4 cv=CPEqXQrD c=1 sm=1 tr=0 ts=68c49ec2 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=UgJECxHJAAAA:8 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=C2dIJva7guKq7NWXi48A:9 a=-El7cUbtino8hM1DCn8D:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OSBTYWx0ZWRfX2BylKvecfsln
 pQrpbZiPdxh4Lgc0VnEqCe34TDf3HKdmrTchKvg5AqojW6ycuiLKKq0uzVvsw/BSRpxFAiVWvzI
 wZ9JSUicofGfU9IIjN1U+Q200epHZWkidLAyYq6CDH7zGtHGqJP0E5n0gOUIf65+g4/kj7bWT0W
 gnsnodnz+HBVa/KBbk0E1B7SQ0tOnyFEyYxlr7AtRvpEhqXcjIdQkUd4vj9KDb/aU7IRuCmNklE
 fJee/uFgi3A31UYGEsXZfFMlOA5+oQrJZ9EQbtFM1vchCS6kgDK/fhI8v1Yk1Ib8Wc4HYGvm2V/
 X+HhzvLcMBT10m7ZdP4RnfywLSNDJc7JOh//nhWMRrKXcQ4KZu1JKiyt101dSzZ2RcSlXfEdRr0
 lwUMk+AU
X-Proofpoint-ORIG-GUID: y-9Ccz7LNOb_Ti30yiOoswr86ZQJhVL-

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
Cc: <stable@vger.kernel.org> # 6.1.y
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kvm/cpuid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e53ccf8a090d..db508118891d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -770,10 +770,15 @@ void kvm_set_cpu_caps(void)
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



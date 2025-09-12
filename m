Return-Path: <stable+bounces-179406-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CE0B55936
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 00:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4977416F747
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 22:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A031DBB13;
	Fri, 12 Sep 2025 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="piHMsTTr"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF94E18FDBE
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757716212; cv=none; b=ghi9cGeUV+jhAfXBXr2r7bQhjd3iUiQIzGkljj8CbANfnCiGccY5AsGLowCYY8EBg0dOlBdp7YQN2NkXgvaDIig/rYZ15h4wSwW+I9L8Q/kgt+AmUKB3MP+HXEum1W8xibagCO4RPtHSQB/zXDvvVdK4uX7GsAzjtThtUGeG66U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757716212; c=relaxed/simple;
	bh=pKk7YMY2MiyZRpxwW033JZKD0tHk0xZDG6hQ1EtUF8s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqhwxGCOUQHAUWRQ++d/TXlF+CCXYKRRnXeriPs3S52V1catmmEgmwuSbFXpm1cSFQm/PBKen3EFyWxxmpoLuaOTkBIroqxDFJiEhDCaHJogZ+nLmK0r96q6yzxBMpsDqtv9Ii/7nSaCQgw2P6jtOZJPgZz7RLAyPMVbsz8gRvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=piHMsTTr; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLfxdw029687;
	Fri, 12 Sep 2025 22:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=6vezBy1fqBjayjxenYb07cP1Hw3EK
	OSCY8+FeYAYEL8=; b=piHMsTTrCNv4u/iN9/i8X4W+20dp2yBZ1byndeE2+0u4j
	cRLJhPv1XEwOOznVcXWRHeuvICWWPulIdaxW/jCHC68ZBKBxhL8eQdAEGLiDQGd4
	wLAzt2dmZWJVqMGm/A9kYIv8tWJ4qQ6g28pWFWnm2TXBsNBMvUuGoWIhmfU3PZZz
	Wnz3vEEB2+4IHSUimIWETRtBgSQcXhRsebIB6t4xFeuzHhhFsjNWllnhyXtAQNtC
	c6aU8Tonalqj+lv1jdg1OC0bEu04PzYCjKql9B0Stx5cDpaw04cwRZi3UAmShFNP
	6TVLfftUSutlGk/nfnaCqGr8DNj/0Y1/p9opRXGCw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921peh2sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 22:30:04 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CL1NTJ030632;
	Fri, 12 Sep 2025 22:30:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdecu4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 22:30:03 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58CMU3jS028373;
	Fri, 12 Sep 2025 22:30:03 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdecu38-1;
	Fri, 12 Sep 2025 22:30:02 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATH 6.6.y] KVM: SVM: Set synthesized TSA CPUID flags
Date: Fri, 12 Sep 2025 18:30:00 -0400
Message-ID: <20250912223000.3143913-1-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 2.47.1
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509120207
X-Proofpoint-GUID: lmwX5FqpkxXZtV71pjGALsz-FYi8Ojbh
X-Proofpoint-ORIG-GUID: lmwX5FqpkxXZtV71pjGALsz-FYi8Ojbh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MiBTYWx0ZWRfXwzSDQlZ8w512
 cwFXZgPL/tRr+uokpOrKQ/VaeCD1kmnoQbsj4MhXig7Yu3yTayD6nAyJDCdbSgiB1+uG80Jc0H5
 Cb6c1UwEtX1egvifXy5tGbJHu8dgcfjffSwBYdJFgLe2OBjzYl8YQ4ARb7/ClpbWoQ4Qk9n1SLo
 Yox8tiga+VLiwIeyXFoKzzvv2RJRTpMG2vLYf92JqE8szCq7H2IqkXRk0CDK7F1luO5fLQBD4iY
 IHezeqbAABl86KCmeZOSk6i9kOIv/Cl8AHhbYHyuC/iYek4qPZswRl+WHvxosq08tMeXmOpcDHA
 0AJvVWD7bzmenf6Yfqi1DyKkHEX5I581Yd/R/wiXrbFQM8PpB6+w2GBk0VUiGF6Fcqzbdd6z6qK
 XJjXu7wl
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68c49eec cx=c_pps
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
Cc: <stable@vger.kernel.org> # 6.6.y
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kvm/cpuid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 288db3516772..2c0bc6a93ec3 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -791,10 +791,15 @@ void kvm_set_cpu_caps(void)
 		F(PERFMON_V2)
 	);
 
+	kvm_cpu_cap_check_and_set(X86_FEATURE_VERW_CLEAR);
+
 	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0021_ECX,
 		F(TSA_SQ_NO) | F(TSA_L1_NO)
 	);
 
+	kvm_cpu_cap_check_and_set(X86_FEATURE_TSA_SQ_NO);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_TSA_L1_NO);
+
 	/*
 	 * Synthesize "LFENCE is serializing" into the AMD-defined entry in
 	 * KVM's supported CPUID if the feature is reported as supported by the
-- 
2.43.5



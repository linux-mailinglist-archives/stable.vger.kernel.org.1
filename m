Return-Path: <stable+bounces-179403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCEFB55933
	for <lists+stable@lfdr.de>; Sat, 13 Sep 2025 00:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 733B23BE1E8
	for <lists+stable@lfdr.de>; Fri, 12 Sep 2025 22:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2102853F3;
	Fri, 12 Sep 2025 22:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Av2Jz2ey"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A33128136B
	for <stable@vger.kernel.org>; Fri, 12 Sep 2025 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757716170; cv=none; b=gRFIoa+g6hj/zT12X1VDmiUxXzd82b/l0pmN8ltvtZUxokDXYKZTGFG9UrxikHtFJTH8d6hQ+0xZll8YaenyqEXkwb4CdIQHh5agDaZbxc74TGwpzZNZkGziL+d4EYTat/Xca/a0KzpRc9bCHTgQ6TvE4Qy3f4RggmCNzW6lGMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757716170; c=relaxed/simple;
	bh=aIShW6oLwefomW7ppRG2L8gke7ZBp/5C2WeqOLeiWno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lisie1k9mmCwRZ5AW7uEtMFo8620zEePcmTGYkWFmQ128lHLiwW88cKVWPj8pNWq+T/gPenAOscgwuXwhqfZSVw0TAux86NoNqdKsufqXD4UNON2dWKFUJhenKp5zm/Fo87HeWUxRGDFK9Nvl9t7zg2Bg95oJ/vvhmjLJC/Ssd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Av2Jz2ey; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLg1SI011657;
	Fri, 12 Sep 2025 22:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=oUkYY
	GCJaEF7qhI8rMyPWMMq1A/nhtnD2CBNm5sfEaw=; b=Av2Jz2eyieBsTeta3H7po
	RpyTgH0ANf993yuOo5maI0Lq9pTkb45fqFTL6opq3XTj34EVKJOh8jddU3FsrcRr
	rJ8Qy/0FkW0oqKldUpFjWSXZAtkFqHpnNkuZce56PyDFSHM4F7bJt2cCL3awSmQt
	JH49jGNOaYORjIhD4nPJM+LYYaInqx2HBoAkUTrRJFOMadt+wOz90Vm2XmjChqxB
	dX60OVneeVXyrfaF7MK8Q2ptvJS3SPwBx1Y1sn+jeNwQzXOt0ls1pQ8OAiwLps+8
	L4nAlEcC+Xf7hCNeBVaYbnc/2RJ1Cj0JDM1L/LnBUnyKmhTI6T2Vn1jp9I1KEwbq
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1s6bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 22:29:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CLkgHh013411;
	Fri, 12 Sep 2025 22:29:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdemajf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 22:29:20 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58CMTHqm020533;
	Fri, 12 Sep 2025 22:29:19 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 490bdemaha-3;
	Fri, 12 Sep 2025 22:29:19 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH 6.1.y 2/3] KVM: SVM: Return TSA_SQ_NO and TSA_L1_NO bits in __do_cpuid_func()
Date: Fri, 12 Sep 2025 18:29:14 -0400
Message-ID: <20250912222915.3143868-3-boris.ostrovsky@oracle.com>
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
X-Proofpoint-ORIG-GUID: -990XG5zCCflt0JFtAaEH6q1PbWjm2XH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX22Y14gcMGzjx
 hyQ5qJDRaoNVHpf90M3HeGpPBLX+ff9FoDExSR21pivWYdObK/efal64Bw+GaQ/kefDRmiTm6f7
 juLlBhStXav71wA5CtDEOUx1qtz7gelE2XSTRLRzxWXAa/xgSDAPFfiuHsqo7jdivYWqISZfn9r
 ZOUrqH5n44rrRDPBLZ/h1Lo0TDGknEx2Eiq4j5QE3ZsweSmq0V6XaINA26SE1rOacrVnSUHg3N9
 DtxhpI7zOC86pVRFYTD3txgnPo5v7bGnIt3rdpQAkOEVIVsexvmQUyqxJrjstTeYkc7VCQPUfkf
 6aJPB6Oyzagb+LH7dXL8e+2CwnUH2jCYMv2pkuDYteZyPDUvn70LTMYyf1M0Rf14fEsr6QAeopY
 x7DFNPYN
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c49ec0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=92bzJRmnXUVhA8tt45oA:9
X-Proofpoint-GUID: -990XG5zCCflt0JFtAaEH6q1PbWjm2XH

Commit c334ae4a545a ("KVM: SVM: Advertise TSA CPUID bits to guests")
set VERW_CLEAR, TSA_SQ_NO and TSA_L1_NO kvm_caps bits that are
supposed to be provided to guest when it requests CPUID 0x80000021.
However, the latter two (in the %ecx register) are instead returned as
zeroes in __do_cpuid_func().

Return values of TSA_SQ_NO and TSA_L1_NO as set in the kvm_cpu_caps.

This fix is stable-only.

Cc: <stable@vger.kernel.org> # 6.1.y
Fixes: c334ae4a545a ("KVM: SVM: Advertise TSA CPUID bits to guests")
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kvm/cpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 4f60341b1e94..e53ccf8a090d 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1259,8 +1259,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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



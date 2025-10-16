Return-Path: <stable+bounces-185886-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B1FBE204E
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C3B543526F9
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 07:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D43F2FFDE1;
	Thu, 16 Oct 2025 07:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kKlizNBA"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA58301473
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 07:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600802; cv=none; b=YOttTI3fP2jsJExWc+3EtiaQrdpq9kMJVjbp+UAh29XV0x3vLPKoA7nIs6R9z2/IcJ8NVzosvHmzsWNk9GkDYU8o7xmiJxlJuj9nXz9To6Qo7CcGVlEy8gZe1qbEK5Lt1E/5qU9XZ0/JDd/xAZRu021Zqvc4CBwpvugeuNxunBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600802; c=relaxed/simple;
	bh=dHPrJ50eCTYiaS/s2iwI8SvmORsSaKhX0z9JK0vu5kE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ts4kQyYHiRZ2lpyHZxuNCZrNg0r93jIN2BaGcC/0Do/WA84YfH/73m3a4haL0tkIHShiIxb9k2Ae+vQ+yQpleKU4NM1imClT2mToa2/kSIdl2tG9zbFeKZ1ky6pUEtbm3IUNRs0bSsArjhX5wi1oVsbLU4sjiYX6pbPD+GHJV2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kKlizNBA; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59G6gOEM002989;
	Thu, 16 Oct 2025 07:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=VwjxQTSrJV0JclUQurVZguLg0S//F
	fWgIPL6cagkKXo=; b=kKlizNBA4C+mFXPv02UKlMP/hAWtAfPDdjhkAuOy2gqg2
	Fl781wy3oNYlKpvGvZztcuThCokIpS2H5qyoEt7FWpV/3WLE5Xm6hgWXsa/aXsTg
	P+q0/dp81B8ijY/+fbtwsYLQwEKysUC9MZE1bV4ftwifJwls3L/8/a4Dw1SQlQns
	AthLeEouVIFbReSXoLAqeMTxYb/LGFbUFALaL/K1FDMJfI2TfpLtfd6YwE1Md9ck
	Svuf8smH+5dIPScVBTdr7gaNsmVqSh/MDcOQRtyxiJj7s+J1pcjvex34aqQwAuIk
	NqXkILpJXNlViETnc7VOg8ECdbTBEJT6pUgTvkA4A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1qfdw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 07:46:31 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59G69N8A026299;
	Thu, 16 Oct 2025 07:46:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpb4fax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 07:46:31 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59G7Yx8Z033426;
	Thu, 16 Oct 2025 07:46:30 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49qdpb4fac-1;
	Thu, 16 Oct 2025 07:46:30 +0000
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: bp@alien8.de, stable@vger.kernel.org
Cc: boris.ostrovsky@oracle.com, Nikolay Borisov <nik.borisov@suse.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 6.12.y] KVM: x86: Advertise SRSO_USER_KERNEL_NO to userspace
Date: Thu, 16 Oct 2025 00:46:27 -0700
Message-ID: <20251016074627.3417836-1-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510160059
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfX7Fwdj8Ilyxiy
 pgXLRhG9Z1md9yebmtiIu92YK6oXc4gyNDAt95liiTrP2xbvYyRT6bqBeDsyjjp7GTl/Ia+vgdK
 L1hk+wG8bk1nbsKlP4eKTSea+7Osb6dkNhNA93AX6/qeyhRrBttXfnW1YVbifBtBHQJ5oVGKix2
 dAOboB63aGzhHM5krQdDP29tZ57LwT0HJM1hMyjZkSDWmLf6djKwKF79EEBO8W+j9VVLzTw8Nt+
 0YgSya126cs6pXx4D8iDMBAJ1YV5lQRaV0x5WzoTJyEppbIwcdS8vDQoW6+vB9N04u+F8BtSULn
 wEyU0QkyQoFp3+43zAF12f3a5aRIGb+/1jqNu+96e4vg3yblnjHlzXnsUayUh1NIGIy+5OYu16C
 oDCYX8e3euRnzThmX2iMfyeAgmJDoG/lCiEivYprIjbuktYiTmk=
X-Proofpoint-GUID: CaszsR_4vO9uu-uzTuqSxbUyMlkEK0ON
X-Proofpoint-ORIG-GUID: CaszsR_4vO9uu-uzTuqSxbUyMlkEK0ON
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68f0a2d7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8
 a=yPCof4ZbAAAA:8 a=149Fr4XGxFghmVM1sOkA:9 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf
 awl=host:13624

From: "Borislav Petkov (AMD)" <bp@alien8.de>

[ Upstream commit 716f86b523d8ec3c17015ee0b03135c7aa6f2f08 ]

SRSO_USER_KERNEL_NO denotes whether the CPU is affected by SRSO across
user/kernel boundaries. Advertise it to guest userspace.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/r/20241202120416.6054-3-bp@kernel.org
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
Boris Ostrovsky suggested that we backport this commit to 6.12.y as we
have commit: 6f0f23ef76be ("KVM: x86: Add IBPB_BRTYPE support") in 6.12.y

Hi borislav: Can you please ACK before stable maintainers pick this ?
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 8f587c5bb6bc..a7a1486ce270 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -816,7 +816,7 @@ void kvm_set_cpu_caps(void)
 		F(NO_NESTED_DATA_BP) | F(LFENCE_RDTSC) | 0 /* SmmPgCfgLock */ |
 		F(VERW_CLEAR) |
 		F(NULL_SEL_CLR_BASE) | F(AUTOIBRS) | 0 /* PrefetchCtlMsr */ |
-		F(WRMSR_XX_BASE_NS)
+		F(WRMSR_XX_BASE_NS) | F(SRSO_USER_KERNEL_NO)
 	);
 
 	kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);
-- 
2.50.1



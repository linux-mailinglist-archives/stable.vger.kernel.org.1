Return-Path: <stable+bounces-177892-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B80E7B46446
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 22:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8146E7B25DC
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 20:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759852C3252;
	Fri,  5 Sep 2025 20:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PiinGJ84"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F24288C3D
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 20:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757102642; cv=none; b=kUorFBzQb1uwG1/WhOdmjU5dFFVwmRf6NWsjRiaCK+GJu3a6w2xE8hHHJZ8F+QAIveztrTD83VjrQxKraYeWZX/0gDcWjRacbO0Rh8kL7+iuFxxy+BlkBxs9jg8sD0FnUi3GAWke20Y7RFSVw5niDLyfthDvqhzHQII3JVMaTic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757102642; c=relaxed/simple;
	bh=JpnOssRmI1HeyCKVdebs81daLCs5K2g6xQWxFbRRG38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3Ym6lWAQe7Qveg0M9nrTHrpaifxfuniJ0Bs3bytQlAlGAfbp7usvWytqcCGaZbABCKBPo8nbXLREW3sSU1OV/p6Jfit6uHrYU+kxyCK4ZHVNv38RmEH8kj5/nzqxdEeHcnvbP5lHgWZjFhZdKKQS42l0XN1IapAMENFDZ+0/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PiinGJ84; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585IsXC0007194;
	Fri, 5 Sep 2025 20:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=lGtPQ
	wHKvjsMDMtZ4ak4YHJpomWFWu2G78xQhbO4VjQ=; b=PiinGJ845d2u8coMK+J/v
	+biiUJdeJsVo/JYj0kitZvVjUPnzOhF3Ku2PkerdRULiTphsHbdCPnUDXOChuU5A
	7WilEQ4BSrT8s7XV/O/5ke5+3JzlHHAnEuUUWcmz01VIsA5ESxLWmhoN5fZwCp07
	7+TZ73E2KhEeVdif/k5UqvfxIq/uO7u0fo02abl0CJ1Q1efKxLB+981OoxdRGwoY
	uKyuspGoQ5MI9VO9uHlbLf3Oc1oYQJUpef283jrhR+heTN+/GUeeKp8sOJgjKD1s
	tXTbk2GvY61uwS0kiTKkinpsSybDuM7eSeMbkAadC9nrTQcEMUoT9/2VaD5UzxDi
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4905j604u1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 20:03:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585JfQcP019800;
	Fri, 5 Sep 2025 20:03:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrdag1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 20:03:46 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585K3hQB014431;
	Fri, 5 Sep 2025 20:03:45 GMT
Received: from bostrovs-home.us.oracle.com (bostrovs-home.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.198])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 48uqrdafyp-3;
	Fri, 05 Sep 2025 20:03:45 +0000
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, bp@alien8.de
Subject: [PATCH v2 5.15.y 2/3] KVM: SVM: Return TSA_SQ_NO and TSA_L1_NO bits in __do_cpuid_func()
Date: Fri,  5 Sep 2025 16:03:40 -0400
Message-ID: <20250905200341.2504047-3-boris.ostrovsky@oracle.com>
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
 suspectscore=0 mlxlogscore=952 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050197
X-Authority-Analysis: v=2.4 cv=GOUIEvNK c=1 sm=1 tr=0 ts=68bb4223 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=kmJrlFbVo_joEtJqDcEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDE4NiBTYWx0ZWRfX5Qt/8x508Lg2
 h6/o39Pi5b3A25705erHeUcJg8voTYzmLrq2uqIZG/GnDHknTnG7tgDB/61fCJdi78ke3WZwRIF
 a9ZxMcxD5XHf4g5DanAWloweJYr9Voj5PStXuGhQDGlZmpSQqzw2uOtXk1XHGyW5gS2Z5r+9a9R
 WBFKErIS2MUwQwqxOkoUtMk/gf+zqIWO9nLE2B98HMfUI8qsiiolIYddZywRWrs2f5Ua7gwPR4U
 mTCI5SEMxcgqez3IyV0m2p3Ki5DohNZmkZ58sK3p5Wk/HorP7vwlUj+sAN0wRuj7j50l/9Tq2GB
 UCr5v+jqLqCePCUboibmhrfMfPn7I7+aApiZGrPXsFfB6mx3lP8NnR6ftoclTlXuf4VBwzZt9BX
 6NwZBFHy
X-Proofpoint-GUID: lYeJIf7QX1htHFBEM4rALqj33ew0Qtxp
X-Proofpoint-ORIG-GUID: lYeJIf7QX1htHFBEM4rALqj33ew0Qtxp

Return values of TSA_SQ_NO and TSA_L1_NO bits as set in the kvm_cpu_caps.

This fix is stable-only.

Cc: <stable@vger.kernel.org> # 5.15.y
Fixes: c334ae4a545a ("KVM: SVM: Advertise TSA CPUID bits to guests")
Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 arch/x86/kvm/cpuid.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f85a1f7b7582..4a644fcb0334 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1014,8 +1014,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
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



Return-Path: <stable+bounces-169444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA2CB25226
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 19:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 120BF176BD1
	for <lists+stable@lfdr.de>; Wed, 13 Aug 2025 17:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F83528750F;
	Wed, 13 Aug 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XJR9cySe"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74574303C8A
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755106192; cv=none; b=SFIGeE/OQczCyOv19Hp9VLUCrjwtgaCDx8T8pFFION7i/DYfH1gGWDH4i0F00nwnntu/bXt0p000rY5+clFWLbaQZ9S+7s8m8b2sQP4m6cJdVr/Ja/hrxorYJymoz66D95eBgs1wDuMF//yK8GUGKfmpA4clV6sphf3GG/mWHSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755106192; c=relaxed/simple;
	bh=Nmwwx+Tn0d/hOMqtfLzRPqNUVjZIagbUKfg24WbkCCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kk4D3i8ig9qXWICsK6g6Ww9pKS0odzxP8BXOEair06MKs6tXJ2onwbAEFs5gmxxECEymsjls+oFMMfY16eWgtgdjM64YhRwrzneDglLI9422cF9FySTEjdeBl+ZqdybwerwKF6fsSwbXAxlROkSYB15zaZkJgcB/LVh+7PYgdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XJR9cySe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DCvJXn015950
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 17:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6UR9ITIZ5E6PZZy0S
	GYbAjVFgvM9lKaqB6Vxu/IcvoU=; b=XJR9cySeeLLbe3AJijIir1O3P+A17pZki
	hzdEIRYRMSCFVi6/MDRi3DU7Q0pZWVppGBcSOFUQEnKx3wiG/JirL1LJOZtK0BKg
	q++8YOHZ2DiIgyEdJBOX7xnfCJ7Yu6MQ3lnk94vUp6YtDK+KNNMf75vgaIf2PXXq
	d5ofS3ZhRQISIaRRK8sszYhxK4Z+H4nugEGwB6t8w8NZj1x9GCCymiSFe1X765PQ
	VbYwvC0n3I2BLI/Ihr3GPakizukD5JC9g1pQ/gGv2T4ufVUyex34RKdB8UQkleo1
	YKsId2zl9PUJF7UfOpSAe+UVSPhgRr+SVfFKdLCVZ85F0bZNUuPnA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx14nu7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 17:29:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DFUbUv026282
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 17:29:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh218h9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 13 Aug 2025 17:29:49 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57DHTjj347907244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 17:29:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1913C2004B;
	Wed, 13 Aug 2025 17:29:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0008820043;
	Wed, 13 Aug 2025 17:29:44 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 17:29:44 +0000 (GMT)
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH 6.6.y] s390/mm: Remove possible false-positive warning in pte_free_defer()
Date: Wed, 13 Aug 2025 19:29:17 +0200
Message-ID: <20250813172917.1693059-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <2025081255-shabby-impound-4a47@gregkh>
References: <2025081255-shabby-impound-4a47@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Ae7Ow31aKZo9fmwFJEGK20dMz865Csfl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX3QzHA+Of3l3b
 9MoZpB/8QxoPg2bQzzrlHWixLlmRY3aADZglgLBuvpHhoSLLJkMjGH3Z456MdG7PUGSaiids8Fx
 f97//ricebLCsm0lZTVRGXoym/BmqglxUtLPvp89QHOHk6rFdmtdc7A9UiS69Gt9nuMZRfeUj8I
 usKcU1gYzwedB6i6KQWCUbOXKwhB2tqU/LJyQRpY+JXQ/BGBJhO1oB3wD12vHogPN2dL1R4BV9x
 nPX844aQpcAW7ruyRaI+OoZMW+ZJAXzQDohbYighqX4r0aNSvku0Ym04yP2Vb73XyHMVtnZ4PK4
 LBMBbgCnK16255b+CqK3zwCXY3ZlV/Li7wpEAZH1Y3UbhG+UmOvSOQ5SEQWMn2jU8UzE9nUT0Zd
 UxzlOrbr
X-Proofpoint-GUID: Ae7Ow31aKZo9fmwFJEGK20dMz865Csfl
X-Authority-Analysis: v=2.4 cv=fLg53Yae c=1 sm=1 tr=0 ts=689ccb8e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=sPEAky355RQtuwAHJkYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 spamscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508120224

Commit 8211dad627981 ("s390: add pte_free_defer() for pgtables sharing
page") added a warning to pte_free_defer(), on our request. It was meant
to warn if this would ever be reached for KVM guest mappings, because
the page table would be freed w/o a gmap_unlink(). THP mappings are not
allowed for KVM guests on s390, so this should never happen.

However, it is possible that the warning is triggered in a valid case as
false-positive.

s390_enable_sie() takes the mmap_lock, marks all VMAs as VM_NOHUGEPAGE and
splits possibly existing THP guest mappings. mm->context.has_pgste is set
to 1 before that, to prevent races with the mm_has_pgste() check in
MADV_HUGEPAGE.

khugepaged drops the mmap_lock for file mappings and might run in parallel,
before a vma is marked VM_NOHUGEPAGE, but after mm->context.has_pgste was
set to 1. If it finds file mappings to collapse, it will eventually call
pte_free_defer(). This will trigger the warning, but it is a valid case
because gmap is not yet set up, and the THP mappings will be split again.

Therefore, remove the warning and the comment.

Fixes: 8211dad627981 ("s390: add pte_free_defer() for pgtables sharing page")
Cc: <stable@vger.kernel.org> # 6.6+
Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
(cherry picked from commit 5647f61ad9171e8f025558ed6dc5702c56a33ba3)
---
 arch/s390/mm/pgalloc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 9355fbe5f51e..2f534b26fda6 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -456,11 +456,6 @@ void pte_free_defer(struct mm_struct *mm, pgtable_t pgtable)
 	page = virt_to_page(pgtable);
 	SetPageActive(page);
 	page_table_free(mm, (unsigned long *)pgtable);
-	/*
-	 * page_table_free() does not do the pgste gmap_unlink() which
-	 * page_table_free_rcu() does: warn us if pgste ever reaches here.
-	 */
-	WARN_ON_ONCE(mm_has_pgste(mm));
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-- 
2.48.1



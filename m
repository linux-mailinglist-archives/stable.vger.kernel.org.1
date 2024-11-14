Return-Path: <stable+bounces-93019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E799C8E73
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 16:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 683541F28303
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63B41885A0;
	Thu, 14 Nov 2024 15:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oiZVkx+A"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0E149C53
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598493; cv=none; b=SNC0lLBFbDwUUMmbNc5NPk47RARu12qOsvSDbR5uCGQUFXC6xZYpcPrBh4nxWbT/fAqxG8YdVLN/HSRttyaVtiLS4tnOJiVkxbxfJOzZGMdY46Uk9uXH9ejF7kwESxazXiBakJ/gxkfUyggiDPpSvldkC6OuKUGl8BZBTuSnTbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598493; c=relaxed/simple;
	bh=SNmhmAlKlVXJQAhDTmvclOtUqEsbzt/iXYsm7UovlsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QePbZLtd7oheHm585/5c44b/MGl/sot4iQOZSEdXNySyByPGjGECtMua9JQ/EX6rpHjIgIhRywAhXzRxhOr591BCQefspdh6/0zbYnXflBUhxFCzqXPgBnqGAO1kpLft/W4+3cfFsOhrGklZeCRh8xMNZXTIx2Ezekxv2RE4qt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oiZVkx+A; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED5wBi002334;
	Thu, 14 Nov 2024 15:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=a4TSD
	9p/Lv2y0y9US8f/wZ0ZmSdcoyCHbSQIaHkj/Z8=; b=oiZVkx+ABWSNdowD/1TRN
	cTBUnPSIXklHr2/txH0vI6WNIFKSOCYQJInqzVtZ9UzxJ+OtyScKamvvWk/YAXUG
	QW6OTRaxSmfoBecoLmim8HfFJIREcHKxNqICQtp2LtSGnFjMw/E6D1q/OhyPVue6
	euHUyqEjYFjEcbbbot5aDLfH58fPio0ecodWz6wWeY22m1uviSNFsTi5rkb50eWH
	WjAB/LFbJxihok7cDb40m8vPP6sM2ZBPi+axWcyA8fqEuzFEQufAhp2hhmQbW3pr
	TVzAeZMsDFWN2xL3nYLXdJnNciIFh5Dq8qTe5hm1Sa5eVx+M9A88I9R1EJm3Iqbi
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5hcw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:34:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEEXxPs001157;
	Thu, 14 Nov 2024 15:34:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bb006-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:34:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AEFXvhx031217;
	Thu, 14 Nov 2024 15:34:46 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42sx6baywk-3;
	Thu, 14 Nov 2024 15:34:45 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: akpm@linux-foundation.org
Cc: harshvardhan.j.jha@oracle.com, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 5.4.y 2/4] mm: fix ambiguous comments for better code readability
Date: Thu, 14 Nov 2024 07:34:41 -0800
Message-ID: <20241114153443.505015-3-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241114153443.505015-1-harshvardhan.j.jha@oracle.com>
References: <20241114153443.505015-1-harshvardhan.j.jha@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140121
X-Proofpoint-ORIG-GUID: A0m90aDvdgZNeH48KCkGkYZmqzRYi-7h
X-Proofpoint-GUID: A0m90aDvdgZNeH48KCkGkYZmqzRYi-7h

From: chenqiwu <chenqiwu@xiaomi.com>

commit 552657b7b3343851916fde7e4fd6bfb6516d2bcb upstream

The parameter of remap_pfn_range() @pfn passed from the caller is actually
a page-frame number converted by corresponding physical address of kernel
memory, the original comment is ambiguous that may mislead the users.

Meanwhile, there is an ambiguous typo "VMM" in the comment of
vm_area_struct.  So fixing them will make the code more readable.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/1583026921-15279-1-git-send-email-qiwuchen55@gmail.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 552657b7b3343851916fde7e4fd6bfb6516d2bcb)
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 include/linux/mm_types.h | 4 ++--
 mm/memory.c              | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 2b3b2fc1cb33f..afbe3056a8d7c 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -284,8 +284,8 @@ struct vm_userfaultfd_ctx {};
 #endif /* CONFIG_USERFAULTFD */
 
 /*
- * This struct defines a memory VMM memory area. There is one of these
- * per VM-area/task.  A VM area is any part of the process virtual memory
+ * This struct describes a virtual memory area. There is one of these
+ * per VM-area/task. A VM area is any part of the process virtual memory
  * space that has a special rule for the page-fault handlers (ie a shared
  * library, the executable area etc).
  */
diff --git a/mm/memory.c b/mm/memory.c
index 238064ef73ae8..50503743724cc 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1922,7 +1922,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
  * @vma: user vma to map to
  * @addr: target user address to start at
  * @pfn: page frame number of kernel physical memory address
- * @size: size of map area
+ * @size: size of mapping area
  * @prot: page protection flags for this mapping
  *
  * Note: this is only safe if the mm semaphore is held when called.
-- 
2.46.0



Return-Path: <stable+bounces-93022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE00C9C8E75
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 16:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3377288FD7
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 15:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C1E18DF7E;
	Thu, 14 Nov 2024 15:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gYRIMHFX"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A02218DF89
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598499; cv=none; b=lpZi0NzoJOmpj46bV5yeoTIRZOGp83I0ieRfdLjbEVoJT4M4VUJp7To+fw/PptCSxTJAddQtEsWhIB2ndYwkJ1Mvut8pY2OA7UVW149rxc+t2OW2+agOHywqN8bVD3Mov4Uesng67bOa3tio1TWwrElBNQiJKKNFADFT6H9UcFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598499; c=relaxed/simple;
	bh=Ns4hzGDcbEojzBmJpAbV88NWj7gF8yFNAP3bfRTiU98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQaTIMLXIGkpWft7p3r/eo3hKcUHlZt3dHS5Lnd2ZvRS8zSjLz7egIVHRSQoiXk7Ha54ij01eTtIOJEi5V7LBxkxUHV6/tZlw4nMzub+ah5EdLBNSl8YeEcRozy3gCZvl1xINnCsRi66i7pgMYrDdWlpPWhQv/HUCbIeYhA8p6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gYRIMHFX; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED0DwB001331;
	Thu, 14 Nov 2024 15:34:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Py5Du
	1aXatp3XRVKVEvGvm+Mt7BokMwnFHIyVFGYuXY=; b=gYRIMHFXfNL3vt+wZD0yq
	/kxkYRO6vtJkQmjEZ5zugaJNBNKHNBR/3GVQkV65u/qPx93GRSjstQ8AYpEcqMmC
	yuii4TCwheXxXCAxS7Uu5Q5fn55kJUjOFyt4kzxJ9VcG/lBusdpEqve+uk8LCiyK
	hkyCqPQXTUsoj+nuw5EaBXI2Ma1dTcJF4D3tC0A7E2cY2G4Sj8WLXHc1pFQ/0i4e
	MtTfejD5NYI042soMQoUqAyYeN66F7Eu5ZE6hwQ6g4JjHxhUMQYPnKIkvI6R0pLh
	8TIbfzkxAeObNC1EBxPq79f3A3FPWklEoPAFUtHH0QFbMJjqGer2GsB92IXnZVrX
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4k6j2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:34:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEF89c8001233;
	Thu, 14 Nov 2024 15:34:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bayyj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:34:45 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AEFXvhv031217;
	Thu, 14 Nov 2024 15:34:45 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42sx6baywk-2;
	Thu, 14 Nov 2024 15:34:45 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: akpm@linux-foundation.org
Cc: harshvardhan.j.jha@oracle.com, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 5.4.y 1/4] mm: clarify a confusing comment for remap_pfn_range()
Date: Thu, 14 Nov 2024 07:34:40 -0800
Message-ID: <20241114153443.505015-2-harshvardhan.j.jha@oracle.com>
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
X-Proofpoint-ORIG-GUID: 3xyXFew6ROvjmSaAEire7-rfnv5U6nba
X-Proofpoint-GUID: 3xyXFew6ROvjmSaAEire7-rfnv5U6nba

From: WANG Wenhu <wenhu.wang@vivo.com>

commit 86a76331d94c4cfa72fe1831dbe4b492f66fdb81 upstream

It really made me scratch my head.  Replace the comment with an accurate
and consistent description.

The parameter pfn actually refers to the page frame number which is
right-shifted by PAGE_SHIFT from the physical address.

Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20200310073955.43415-1-wenhu.wang@vivo.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 86a76331d94c4cfa72fe1831dbe4b492f66fdb81)
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index f8d76c66311df..238064ef73ae8 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1921,7 +1921,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
  * remap_pfn_range - remap kernel memory to userspace
  * @vma: user vma to map to
  * @addr: target user address to start at
- * @pfn: physical address of kernel memory
+ * @pfn: page frame number of kernel physical memory address
  * @size: size of map area
  * @prot: page protection flags for this mapping
  *
-- 
2.46.0



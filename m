Return-Path: <stable+bounces-93023-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 814B19C8E76
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 16:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473E0288E92
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 15:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB7B18DF91;
	Thu, 14 Nov 2024 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nHum0Kac"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9282B13AD29
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598502; cv=none; b=oHjtw7kNvTavhXzGl2/oGDeL8brb8oUyxNVocLadviiC/c++qhfSeDQDtzGHT63pXR1fI57XTTHpRsq4XkUS+uXuviC3foQAv8LQ/iZc+aTHGNLYiO5WRjZzeQFKvedDUQJHxdYWTc0qk32PDRin61JWzDU19fuYeNd0NJgQx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598502; c=relaxed/simple;
	bh=92k2b1WGu1k9tlo5ULzJmM66WnTMbMgkze3B7EuH7DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQ6zadOPlRStyeExdXkqoPX4NQ8WGtIdC4rUB45BMGbFQQjzjywqn/Df0jrRVt11plSCIE/V5Poze6RfHTYcqz5VBlMaQY5vF2Bq97zy6QeLYMN5fYDJJG+jifWSdHCF33gWFF+gaHDjd+pk/AJUOED8Dxtlb4fTdjVI3azlzA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nHum0Kac; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AECcora002606;
	Thu, 14 Nov 2024 15:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=8v1x2
	+4ddDfh1GMkn1TAGJMq/5kFEFBLNeiRdPRDjZg=; b=nHum0KacnCCZiEeTvvqkH
	ovnZz68Y4HuyXJ5ixU6Ct7aSg9Z3uhhPQWuT6aZktxTbhduekB/O8QD+q1qs5E8N
	GdgYgv2V4vhzIJplJNiTtioJIEQ9b7eEhnL6z46LCCQKzi3oAIJ6/oI/RvqBEwbM
	t9xfXDUPdPs7s5+D3iQGwO99RIdsSuZ2LHjxGnrp1lpdoH8hoVrMfwU/U/d0cEqh
	DPtXkPgZbMSPZuHHJ/6rjA11EX8lKb5SbIRr6c5eZAjHT4eXtW08Gw/6ZdICuVSQ
	9axBObr/+8lbtGNGL0hU2+PX0az9pQ657etT0GOrcUMHdKzb11PvRVWe/BEs5dOe
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42vsp4k6j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:34:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEF5cDt001160;
	Thu, 14 Nov 2024 15:34:49 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bb02j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:34:49 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AEFXvi1031217;
	Thu, 14 Nov 2024 15:34:48 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42sx6baywk-4;
	Thu, 14 Nov 2024 15:34:48 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: akpm@linux-foundation.org
Cc: harshvardhan.j.jha@oracle.com, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 5.4.y 3/4] mm/memory.c: make remap_pfn_range() reject unaligned addr
Date: Thu, 14 Nov 2024 07:34:42 -0800
Message-ID: <20241114153443.505015-4-harshvardhan.j.jha@oracle.com>
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
X-Proofpoint-ORIG-GUID: eS710v4UxfqsDdeqcRLPG8z8qBpv282W
X-Proofpoint-GUID: eS710v4UxfqsDdeqcRLPG8z8qBpv282W

From: Alex Zhang <zhangalex@google.com>

commit 0c4123e3fb82d6014d0a70b52eb38153f658541c upstream

This function implicitly assumes that the addr passed in is page aligned.
A non page aligned addr could ultimately cause a kernel bug in
remap_pte_range as the exit condition in the logic loop may never be
satisfied.  This patch documents the need for the requirement, as well as
explicitly adds a check for it.

Signed-off-by: Alex Zhang <zhangalex@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Link: http://lkml.kernel.org/r/20200617233512.177519-1-zhangalex@google.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 0c4123e3fb82d6014d0a70b52eb38153f658541c)
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 mm/memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 50503743724cc..1d009d3d87b34 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1920,7 +1920,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 /**
  * remap_pfn_range - remap kernel memory to userspace
  * @vma: user vma to map to
- * @addr: target user address to start at
+ * @addr: target page aligned user address to start at
  * @pfn: page frame number of kernel physical memory address
  * @size: size of mapping area
  * @prot: page protection flags for this mapping
@@ -1939,6 +1939,9 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 	unsigned long remap_pfn = pfn;
 	int err;
 
+	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
+		return -EINVAL;
+
 	/*
 	 * Physically remapped pages are special. Tell the
 	 * rest of the world about it:
-- 
2.46.0



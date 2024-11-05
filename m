Return-Path: <stable+bounces-89850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D18399BD108
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 16:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 615131F23B3B
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 15:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD1713B58D;
	Tue,  5 Nov 2024 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MXmEB/Hb"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4968913AD0F
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821853; cv=none; b=Nn7vajLmDg3VywXgPoa6JqTwtRKKRf0oaZziKYVZEKGItTqZDnw/xEzVhDuae2XqWzrN3t7j5NYJ3fIrg5pSbH5sMNzIA1h6Fg81sjl8eX5/WC+a+P3rEZRYECt6NPcft4WIB7kvvcf6kBO3Gb9o1B0lfAza/PlKqJatme8pqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821853; c=relaxed/simple;
	bh=ElEk5zH/YcAznMTKwsEmNV3nLjVj4KEJi51ZOz/Bxp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qeo+7VtOrVfa3lB5nwuk5gIcQp3oXUL32lg6TZITLhyXvYV88pIfVhMmb5gt7uRlSovUluNtHUPCLRW+zl2s0N83j//EvUEqt1Cxp8By5yHhceC2XeI7FoyreJRAPoN4WUp+uJE7Su4Ei5+oS0oF2IU78se9ucDNWnCQwi3ca0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MXmEB/Hb; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5DiYQV029653;
	Tue, 5 Nov 2024 15:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=+P0Mv
	UmtvX+pdbAUezamlBg8piG53Ca6UVptHTajYJ8=; b=MXmEB/HbVWDlr4wdK74Kj
	2QQX78MaLYq9xOWmsvGB/vC7LZavYWWx6P6wvAKAx7vkCf3Tnlc53CXsI4zq058l
	CYwL9CrHRUTm+1dPeLxWv6XxsKfw89Lx5F7xjbhl3NtuOpekpkcibxMLo4uOuQpc
	vJfw8ESYBDOGtN+VW0xMNpMz6hrstaNjniE7JVRnL69fq1LtkCBfh4S6konq3JZ1
	vtpcNLKVgfJs5rE7yI96TQMwUHenq4ACAmIJZCfl2mmv1KxX6ChUieo/FK4gJ8y/
	Eiv7jIHSof7qqd7a6lll1plPMLnVMPTZUaxHiOksg13BnSJ40sdJqB09KsySU0OC
	Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nc4bwqs5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 15:50:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5EUi9w035597;
	Tue, 5 Nov 2024 15:50:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahdkgkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 05 Nov 2024 15:50:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A5Foi0M028682;
	Tue, 5 Nov 2024 15:50:45 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42nahdkghq-3;
	Tue, 05 Nov 2024 15:50:45 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: akpm@linux-foundation.org
Cc: harshvardhan.j.jha@oracle.com, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 5.10.y 2/2] mm: avoid leaving partial pfn mappings around in error case
Date: Tue,  5 Nov 2024 07:50:42 -0800
Message-ID: <20241105155042.288813-3-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241105155042.288813-1-harshvardhan.j.jha@oracle.com>
References: <20241105155042.288813-1-harshvardhan.j.jha@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-05_06,2024-11-05_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=971 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411050122
X-Proofpoint-ORIG-GUID: y1O3ccfMcuZIrW3QjvrQnmENMAZREd1X
X-Proofpoint-GUID: y1O3ccfMcuZIrW3QjvrQnmENMAZREd1X

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 79a61cc3fc0466ad2b7b89618a6157785f0293b3 upstream.

As Jann points out, PFN mappings are special, because unlike normal
memory mappings, there is no lifetime information associated with the
mapping - it is just a raw mapping of PFNs with no reference counting of
a 'struct page'.

That's all very much intentional, but it does mean that it's easy to
mess up the cleanup in case of errors.  Yes, a failed mmap() will always
eventually clean up any partial mappings, but without any explicit
lifetime in the page table mapping itself, it's very easy to do the
error handling in the wrong order.

In particular, it's easy to mistakenly free the physical backing store
before the page tables are actually cleaned up and (temporarily) have
stale dangling PTE entries.

To make this situation less error-prone, just make sure that any partial
pfn mapping is torn down early, before any other error handling.

Reported-and-tested-by: Jann Horn <jannh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Simona Vetter <simona.vetter@ffwll.ch>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 5b2c8b34f6d76bfbd1dd4936eb8a0fbfb9af3959)
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 mm/memory.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 40a6cc6df9003..29cce8aadb618 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2290,11 +2290,7 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	return 0;
 }
 
-/*
- * Variant of remap_pfn_range that does not call track_pfn_remap.  The caller
- * must have pre-validated the caching bits of the pgprot_t.
- */
-int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+static int remap_pfn_range_internal(struct vm_area_struct *vma, unsigned long addr,
 		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	pgd_t *pgd;
@@ -2347,6 +2343,27 @@ int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
 	return 0;
 }
 
+/*
+ * Variant of remap_pfn_range that does not call track_pfn_remap.  The caller
+ * must have pre-validated the caching bits of the pgprot_t.
+ */
+int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	int error = remap_pfn_range_internal(vma, addr, pfn, size, prot);
+
+	if (!error)
+		return 0;
+
+	/*
+	 * A partial pfn range mapping is dangerous: it does not
+	 * maintain page reference counts, and callers may free
+	 * pages due to the error. So zap it early.
+	 */
+	zap_page_range_single(vma, addr, size, NULL);
+	return error;
+}
+
 /**
  * remap_pfn_range - remap kernel memory to userspace
  * @vma: user vma to map to
-- 
2.46.0



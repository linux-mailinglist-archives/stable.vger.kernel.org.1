Return-Path: <stable+bounces-93020-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 748289C8E74
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 16:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 062B21F28355
	for <lists+stable@lfdr.de>; Thu, 14 Nov 2024 15:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0752B18D626;
	Thu, 14 Nov 2024 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mlsMyrpn"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB09313AD29
	for <stable@vger.kernel.org>; Thu, 14 Nov 2024 15:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598496; cv=none; b=jyyEYELnhv7qwt/oIJy27Ggwpv8u2dMhsIewN4Hv6NPKaGJf1WpYrz9GAtzrGY+NTBlALrHyeR56yix/+8uh1XvOt8XVfgsyz1HwMicbvg22xZ2NAcC7JPZM1cxyJfUmBRYJunXtw3sUnz/1X3UqnCeWUYr9Vkrv0mxOIKUYrbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598496; c=relaxed/simple;
	bh=L4pgpeL6yRdCJJamWKBKDLwu+sghyGIreQw7qVTuspY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KWvvBE4l0lK6iV+laNOr+81G08a9A6PL9g5Q0wV32i+SSivm0aX8Bt+z10A/yMUuA76+wR2VWEbJuYhmJ4ELubYZgB5WZrV5vaJ2BZNLy25bbEc8w90tVMRUxBs/yytXRXcO6K9tI2foIk+hMv3xEgjgHJ8V7YjHkM+RNpiYF3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mlsMyrpn; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AED1W0h002323;
	Thu, 14 Nov 2024 15:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=1xUgb
	P7FM7tuWfjpTA/OYuQXMmkdV4tkkuGEzythhJQ=; b=mlsMyrpndH3YRkiEJsZGt
	I0tzP3GJAsBAygUKTQfuD1REUVGsFjwmPO6LDDrkaHlV2n2n6yVvCQGOVZKuG8JG
	ihh4H1zynQT5CKVi1ElQIzrWINFhdc2rioTTJQMYGLjaeAGCcD5C8aZ6+6cGAqd9
	XxSy+SMtiCKGbrpGMWNsySCivglFmiWHOAvuQ9CTVII/gmTo66ig8ZrQi52AsUkw
	cKSyjdl9HvNEcADARCH5x8sb7+ISHKw0l2rZjlsNIV+ADSEEZEeVD7Na0aOlJL1T
	NqbZG6RtKpgSKZqhGfzz0Ykrzb0bRzjDKz8CIUiH3XNVDZuWLQGIaXW2gMMiikXC
	A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5hcwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:34:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEEsJmo001205;
	Thu, 14 Nov 2024 15:34:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6bb03p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 15:34:49 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AEFXvi3031217;
	Thu, 14 Nov 2024 15:34:49 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42sx6baywk-5;
	Thu, 14 Nov 2024 15:34:49 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: akpm@linux-foundation.org
Cc: harshvardhan.j.jha@oracle.com, linux-mm@kvack.org, stable@vger.kernel.org
Subject: [PATCH 5.4.y 4/4] mm: add remap_pfn_range_notrack
Date: Thu, 14 Nov 2024 07:34:43 -0800
Message-ID: <20241114153443.505015-5-harshvardhan.j.jha@oracle.com>
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
X-Proofpoint-ORIG-GUID: fXCvyGJpMdYDnIU8yR-qpq6yfkyneqWY
X-Proofpoint-GUID: fXCvyGJpMdYDnIU8yR-qpq6yfkyneqWY

From: Christoph Hellwig <hch@lst.de>

commit 74ffa5a3e68504dd289135b1cf0422c19ffb3f2e upstream.

Patch series "add remap_pfn_range_notrack instead of reinventing it in i915", v2.

i915 has some reason to want to avoid the track_pfn_remap overhead in
remap_pfn_range.  Add a function to the core VM to do just that rather
than reinventing the functionality poorly in the driver.

Note that the remap_io_sg path does get exercises when using Xorg on my
Thinkpad X1, so this should be considered lightly tested, I've not managed
to hit the remap_io_mapping path at all.

This patch (of 4):

Add a version of remap_pfn_range that does not call track_pfn_range.  This
will be used to fix horrible abuses of VM internals in the i915 driver.

Link: https://lkml.kernel.org/r/20210326055505.1424432-1-hch@lst.de
Link: https://lkml.kernel.org/r/20210326055505.1424432-2-hch@lst.de
Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 69d4e1ce9087c8767f2fe9b9426fa2755c8e9072)
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 51 ++++++++++++++++++++++++++++------------------
 2 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d14aba548ff4e..4d3657b630dba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2566,6 +2566,8 @@ unsigned long change_prot_numa(struct vm_area_struct *vma,
 struct vm_area_struct *find_extend_vma(struct mm_struct *, unsigned long addr);
 int remap_pfn_range(struct vm_area_struct *, unsigned long addr,
 			unsigned long pfn, unsigned long size, pgprot_t);
+int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot);
 int vm_insert_page(struct vm_area_struct *, unsigned long addr, struct page *);
 int vm_map_pages(struct vm_area_struct *vma, struct page **pages,
 				unsigned long num);
diff --git a/mm/memory.c b/mm/memory.c
index 1d009d3d87b34..fc7454cc138b6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1917,26 +1917,17 @@ static inline int remap_p4d_range(struct mm_struct *mm, pgd_t *pgd,
 	return 0;
 }
 
-/**
- * remap_pfn_range - remap kernel memory to userspace
- * @vma: user vma to map to
- * @addr: target page aligned user address to start at
- * @pfn: page frame number of kernel physical memory address
- * @size: size of mapping area
- * @prot: page protection flags for this mapping
- *
- * Note: this is only safe if the mm semaphore is held when called.
- *
- * Return: %0 on success, negative error code otherwise.
+/*
+ * Variant of remap_pfn_range that does not call track_pfn_remap.  The caller
+ * must have pre-validated the caching bits of the pgprot_t.
  */
-int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
-		    unsigned long pfn, unsigned long size, pgprot_t prot)
+int remap_pfn_range_notrack(struct vm_area_struct *vma, unsigned long addr,
+		unsigned long pfn, unsigned long size, pgprot_t prot)
 {
 	pgd_t *pgd;
 	unsigned long next;
 	unsigned long end = addr + PAGE_ALIGN(size);
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long remap_pfn = pfn;
 	int err;
 
 	if (WARN_ON_ONCE(!PAGE_ALIGNED(addr)))
@@ -1966,10 +1957,6 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		vma->vm_pgoff = pfn;
 	}
 
-	err = track_pfn_remap(vma, &prot, remap_pfn, addr, PAGE_ALIGN(size));
-	if (err)
-		return -EINVAL;
-
 	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP;
 
 	BUG_ON(addr >= end);
@@ -1981,12 +1968,36 @@ int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
 		err = remap_p4d_range(mm, pgd, addr, next,
 				pfn + (addr >> PAGE_SHIFT), prot);
 		if (err)
-			break;
+			return err;
 	} while (pgd++, addr = next, addr != end);
 
+	return 0;
+}
+
+/**
+ * remap_pfn_range - remap kernel memory to userspace
+ * @vma: user vma to map to
+ * @addr: target page aligned user address to start at
+ * @pfn: page frame number of kernel physical memory address
+ * @size: size of mapping area
+ * @prot: page protection flags for this mapping
+ *
+ * Note: this is only safe if the mm semaphore is held when called.
+ *
+ * Return: %0 on success, negative error code otherwise.
+ */
+int remap_pfn_range(struct vm_area_struct *vma, unsigned long addr,
+		    unsigned long pfn, unsigned long size, pgprot_t prot)
+{
+	int err;
+
+	err = track_pfn_remap(vma, &prot, pfn, addr, PAGE_ALIGN(size));
 	if (err)
-		untrack_pfn(vma, remap_pfn, PAGE_ALIGN(size));
+		return -EINVAL;
 
+	err = remap_pfn_range_notrack(vma, addr, pfn, size, prot);
+	if (err)
+		untrack_pfn(vma, pfn, PAGE_ALIGN(size));
 	return err;
 }
 EXPORT_SYMBOL(remap_pfn_range);
-- 
2.46.0



Return-Path: <stable+bounces-148941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC8FACAD40
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA1C417BEE1
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412071F461D;
	Mon,  2 Jun 2025 11:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cwrSisxu"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE71F098A
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 11:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748864005; cv=none; b=LPlF25DvKXRGm8WmGh3IZtNJnobDacaDPljNSPlFIYifhWcN6YRiny0OENsrPeP8T0VT3KFQzy9TGyNCKFsEfkPtU9zw1rEk0AJihw4umSqcvQ5eoYz5dN8DiFf1K8hrU7oAlL72K0LF9ANfCxbJyGWWPivQ7Bn5jlNwS1DFZ24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748864005; c=relaxed/simple;
	bh=nQnj3UIwBixBa+9lrqP6AM/8yrw2TiAFD4ytyVUC9mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGogGR2FlISY2fNl4AMuU7lFpfMkfuBp8U9CoOD5VZyFUFPqJgVs8g9LjW51WRB897q82+QmOj8Xk4zhEU+8qHsiHsutjD1oQ7dCwOAxPP4ERsx89gmynOaby0xiWtZXSXOUd9TmTdgMgi62X7Z/FOHG51f8T29boszWvk2hjBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cwrSisxu; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5525uQTG002330;
	Mon, 2 Jun 2025 11:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=gayvE
	A2rVtsXvkFiJ3V1oEC2mGeCkmsqwcTLVgBGcnU=; b=cwrSisxuL3SydVLeYypgp
	R+CWudHLz95hzRmFVNhqRZORVzAGzdcoFAUSYD2gbotJ7Nz8ybo3Yy64bEM5im/T
	fVBh/lFcU0H+FGeaL7Z44dTSCNg1Y7anLI3RYSZtQnoQFsR8mtUtlIgNF33AEKcV
	6r3W1ajAV4ea8LUReU2x9rLIGs5U//5lBiHH0+jo44RL8RrQN7LQtY6q1ke76uyt
	b2iucf/aana75SBAXL7p2uimHUssAhwxvpCQZHyJ4lDwKkwTKOSMl7YYEXMDvvnG
	S5kMhu73hsQtvkU2CCCKX3J67GVbWPxoNsLNTGqfHZWYFztedE2b2CwnBYJCkYk/
	w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ytawjcbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 11:33:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5529VABB030620;
	Mon, 2 Jun 2025 11:33:12 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77uujv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 11:33:11 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 552BXAUl020033;
	Mon, 2 Jun 2025 11:33:11 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46yr77uuhu-2;
	Mon, 02 Jun 2025 11:33:11 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: jgross@suse.com, sstabellini@kernel.org, boris.ostrovsky@oracle.com
Cc: harshvardhan.j.jha@oracle.com, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH 5.4.y 1/1] xen/swiotlb: relax alignment requirements
Date: Mon,  2 Jun 2025 04:33:08 -0700
Message-ID: <20250602113308.3475836-2-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250602113308.3475836-1-harshvardhan.j.jha@oracle.com>
References: <20250602113308.3475836-1-harshvardhan.j.jha@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_05,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506020099
X-Proofpoint-GUID: TduUfKGbuxsukIBDwRYM4gyTx9y4tmCM
X-Proofpoint-ORIG-GUID: TduUfKGbuxsukIBDwRYM4gyTx9y4tmCM
X-Authority-Analysis: v=2.4 cv=ctObk04i c=1 sm=1 tr=0 ts=683d8bfb b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6IFa9wvqVegA:10 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=E5hRKjw2lWykmI9IJP0A:9 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf
 awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMCBTYWx0ZWRfXwLSOvWaaOpvw /9NGPMepObrOY+QYEypxiCckoPETYx0oNPJkwRzfn/4TqftXcO1+irEyoGFAjnQMAXIB/QpCwHr KLg8cA0yOnt9yYoNXYZjxIjJSKDdIwA0ykcTmivx0sCJsPE6ZxZMAGMMJ26RBhcs4HMDtyx4vHC
 MsFpj8FWiavKM92wjcSsC0b2+DhhXNJPEjzV/QvwUfVkdWthzgRojsXuTJHhO9r80qZSnsoRZx0 gRNmNaitmu9OMppw1W7ZF0IZ5d/VXYM1SmZ+Wgd5EnLHQ6l7Y3hHdxNnXyunHSvyetGWtkhbxnJ 4fDqsStL2toaf6uzjvS66TrUwj7pk5R/V4KeHrT4hJ+66J6FL1qyknT83gfMi23E79/2yACnYGV
 gIMVSyyY3Gn7sWPl2LdZ4Wk9ogB6n1zL8GjgtQirONaV1qifV4btqSIJTjERMtGLTrqnE+CC

[ Upstream commit 85fcb57c983f423180ba6ec5d0034242da05cc54 ]

When mapping a buffer for DMA via .map_page or .map_sg DMA operations,
there is no need to check the machine frames to be aligned according
to the mapped areas size. All what is needed in these cases is that the
buffer is contiguous at machine level.

So carve out the alignment check from range_straddles_page_boundary()
and move it to a helper called by xen_swiotlb_alloc_coherent() and
xen_swiotlb_free_coherent() directly.

Fixes: 9f40ec84a797 ("xen/swiotlb: add alignment check for dma buffers")
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
---
 drivers/xen/swiotlb-xen.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 5bd29d0bffa2e..382ee7dc3d5d9 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -85,19 +85,21 @@ static inline dma_addr_t xen_virt_to_bus(void *address)
 	return xen_phys_to_bus(virt_to_phys(address));
 }
 
+static inline bool range_requires_alignment(phys_addr_t p, size_t size)
+{
+	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
+	phys_addr_t bus_addr = pfn_to_bfn(XEN_PFN_DOWN(p)) << XEN_PAGE_SHIFT;
+
+	return IS_ALIGNED(p, algn) && !IS_ALIGNED(bus_addr, algn);
+}
+
 static inline int range_straddles_page_boundary(phys_addr_t p, size_t size)
 {
 	unsigned long next_bfn, xen_pfn = XEN_PFN_DOWN(p);
 	unsigned int i, nr_pages = XEN_PFN_UP(xen_offset_in_page(p) + size);
-	phys_addr_t algn = 1ULL << (get_order(size) + PAGE_SHIFT);
 
 	next_bfn = pfn_to_bfn(xen_pfn);
 
-	/* If buffer is physically aligned, ensure DMA alignment. */
-	if (IS_ALIGNED(p, algn) &&
-	    !IS_ALIGNED((phys_addr_t)next_bfn << XEN_PAGE_SHIFT, algn))
-		return 1;
-
 	for (i = 1; i < nr_pages; i++)
 		if (pfn_to_bfn(++xen_pfn) != ++next_bfn)
 			return 1;
@@ -320,7 +322,8 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	phys = *dma_handle;
 	dev_addr = xen_phys_to_bus(phys);
 	if (((dev_addr + size - 1 <= dma_mask)) &&
-	    !range_straddles_page_boundary(phys, size))
+	    !range_straddles_page_boundary(phys, size) &&
+	    !range_requires_alignment(phys, size))
 		*dma_handle = dev_addr;
 	else {
 		if (xen_create_contiguous_region(phys, order,
@@ -360,6 +363,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 
 	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
 		     range_straddles_page_boundary(phys, size)) &&
+	    !range_requires_alignment(phys, size) &&
 	    TestClearPageXenRemapped(page))
 		xen_destroy_contiguous_region(phys, order);
 
-- 
2.47.1



Return-Path: <stable+bounces-148938-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 638DCACAD3A
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 13:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD3E189DEDE
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 11:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECC01DDC2C;
	Mon,  2 Jun 2025 11:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rm2JDwds"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541671F461D
	for <stable@vger.kernel.org>; Mon,  2 Jun 2025 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748863996; cv=none; b=N5fse1j5t2WzMQCqtFs+rJLToaQOO/aLN7zMDDuDkuAWNvYez+3A+yViQbHyA2Yb9a7HW5F/pzlWwCIxycHVlyj+NatZnGdm+uB8wYqqzumuiC3q+A5CIKd5Oydk9mDsyp9b2wIZsp92Ulq9eY4B2mzsl5fcojpkH7FPzSA0u0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748863996; c=relaxed/simple;
	bh=pGBK6Y/0eBCiI5oPBzUlnB0azZMz6/diCaMDtQXINcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUVJDyfqlglnxBGuH33XkI8m4B+zjHdN+qng1202uv2OVCaPECtMH4D8A3YX2zmqi0IcYIYS1yW6mux44a+bYJGudLkHxYsnapbr5bm8fBzyFRqS0lty40h2VJvR4p+F49lbnokXTAQV7DXoZnOndWqWOiukST0yTsuiJspBG38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rm2JDwds; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5525tsf4011357;
	Mon, 2 Jun 2025 11:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=kvVbO
	UjyRbYz/XjRS4cixhkQABnoYIWp9dyNm7rGnTk=; b=Rm2JDwdsSnFQJX6ZezlVG
	4ZQW06oLvFhJvT6tf0lDspLnMZbVPCUtTNGJCFAOqwMkA8Lu80FmMxfPWWxhSXuF
	TEsSu0tFcydziuE4ILO+7YWMOcRtFJ3tTGG/57lIVo25hIAShoQuU6DfNhDHPrEM
	/qsXpD3EX09PAbYR1AQLNOte+3KSMjGjwbwZEOJ+INPKah5i04OKrMmgXM5fUgdz
	aeSZZpP0f4IsSCResrPRJQOgKDpy9dmA2EsxgdKDDNSHyVCeGHFqb4YD+avvBkcJ
	irFsFuRyxao/dXJrMdvQY+eqq/fpCWI5nAXlmmEKjC2MHqHPvkA5UnP47G0Qg5MC
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yrj52eem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 11:33:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 552BPgAr038592;
	Mon, 2 Jun 2025 11:33:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77vhva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 11:33:02 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 552BWucc001684;
	Mon, 2 Jun 2025 11:33:02 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 46yr77vhuf-2;
	Mon, 02 Jun 2025 11:33:02 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: jgross@suse.com, sstabellini@kernel.org, boris.ostrovsky@oracle.com
Cc: harshvardhan.j.jha@oracle.com, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH 5.10.y 1/1] xen/swiotlb: relax alignment requirements
Date: Mon,  2 Jun 2025 04:33:01 -0700
Message-ID: <20250602113301.3475805-2-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250602113301.3475805-1-harshvardhan.j.jha@oracle.com>
References: <20250602113301.3475805-1-harshvardhan.j.jha@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020099
X-Authority-Analysis: v=2.4 cv=fs7cZE4f c=1 sm=1 tr=0 ts=683d8bf0 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=E5hRKjw2lWykmI9IJP0A:9 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-GUID: eIe7wPBNFEkgpFOKJc8CTUn2I2JL3tdR
X-Proofpoint-ORIG-GUID: eIe7wPBNFEkgpFOKJc8CTUn2I2JL3tdR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDEwMCBTYWx0ZWRfX3JG8hQvTJkFH YhYo0zEP2AnAkx95ZpNuvEzj0d/tTPJQjcoA0El66Z4LXT4MrvGlDtVTWVv5E3ORmp4oCju9NRz v66GdNPW6kvbGisENUDvQKU3Ges47rFFldTB8X6UZZKinRYSgwQc2kQy2QBhWnMSTISXF5qj0XK
 ayulbdthVGdTqZltq/RSm6MXq79v2flvRjx+t+2m/Hdj0CQd5v/k0flKteFDwkMBHuBThKn7rL3 9y3EkPjJ5WmE//4i0ry/OvAoDG3ywIIOLQcCXDjWkIhqeSj/nwK4INmGFFguqni12bKk2xbYxzW w+aoyWb7sOygXgjIiLSBM31ol80LsEqBVu2gVmAjIZMLXj4CxQB7DsaQUpM15T/vBLPbfLOfVl6
 EEUWLXqpHhYz1iiArnpTDz41LUoCn/wOvv9i0uAVHsNgOvGKkbOeB+LZ6B4m+30ttsA55zpp

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
index 000d02ea4f7d8..d8efb8ea23a0d 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -87,19 +87,21 @@ static inline dma_addr_t xen_virt_to_bus(struct device *dev, void *address)
 	return xen_phys_to_dma(dev, virt_to_phys(address));
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
@@ -321,7 +323,8 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	phys = dma_to_phys(hwdev, *dma_handle);
 	dev_addr = xen_phys_to_dma(hwdev, phys);
 	if (((dev_addr + size - 1 <= dma_mask)) &&
-	    !range_straddles_page_boundary(phys, size))
+	    !range_straddles_page_boundary(phys, size) &&
+	    !range_requires_alignment(phys, size))
 		*dma_handle = dev_addr;
 	else {
 		if (xen_create_contiguous_region(phys, order,
@@ -362,6 +365,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 
 	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
 		     range_straddles_page_boundary(phys, size)) &&
+	    !range_requires_alignment(phys, size) &&
 	    TestClearPageXenRemapped(page))
 		xen_destroy_contiguous_region(phys, order);
 
-- 
2.47.1



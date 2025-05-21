Return-Path: <stable+bounces-145785-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B317ABEE92
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 10:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A0B67B49BE
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 08:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075DE236A70;
	Wed, 21 May 2025 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UcT01hPm"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F538231852
	for <stable@vger.kernel.org>; Wed, 21 May 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747817529; cv=none; b=We9faPgwR0+yjbexzetqj1zAUR52n5haJ4Y8/sI98csT5yQLtQsDJuS+f0z1U5BNJQ3QHYc515XH8lG+L32uskrKdqDYDWgoj2BYcxkD1zr4NbhW59nTo2nhL6YPXBKuVWZywT1cIG0HNj5T+toeby+XFfZhZqnkz7m1cwLL7x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747817529; c=relaxed/simple;
	bh=8NWS5cjUXHNwzDZ0YCbu3gGVCFHDNtaUubMktVzh6B0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEptkMabtrnQPSxzQkVzL6J4/JW74HyB6fhSzdXJNzRcYtvCDRPbxATv1qTwl0xN60RwLIR5pXtYnWfAiZDmn4z+tzSC4BT60d+MJ9kx8PzG4lGQhDiKCFrO5f4oHYdoIXVQil1vsiBQm1gMKOMZ04oH9k5+EQ+eXpc3wemees0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UcT01hPm; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L8Spjg026402;
	Wed, 21 May 2025 08:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=YCUn1
	PIbwBCxw1cn97O5FsKta9uLJW/+01K2MDVFP7A=; b=UcT01hPmJJP9Az+0HamHp
	GRVQE4qd9IrqBk027upBdONbhbR3Hp9I1JtA8nyimgJGOBy8vz1kCZrwp80Lc1ML
	bfoC5Yjnfw1rOPKCTDZX34QQDJxIVdEg81Jnldkf8JrXk+MIUram4f6/IzMO01EZ
	GgMYpQTKFXVpqocVmxqC3mWTEQqVALe+SOlefwYzw7Lm4PLJ/pDSPZvweyg7IfXS
	5a7jc2xYvhzhtOpgYZYsen5k800AISAUbBZxzka94hYIKp6Sy5sn6S0WJy0Yhi96
	LgsdrNOf9O+xP8mqk+NfImd72Oet7IAlymasE47wHIlEG82oUBdFbTjdQ9Rrf71C
	A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sahbg66d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 08:51:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54L7i855034623;
	Wed, 21 May 2025 08:51:47 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwepjar3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 08:51:47 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54L8pjuj027328;
	Wed, 21 May 2025 08:51:47 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 46rwepjaq9-2;
	Wed, 21 May 2025 08:51:46 +0000
From: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
To: jgross@suse.com, sstabellini@kernel.org, boris.ostrovsky@oracle.com
Cc: harshvardhan.j.jha@oracle.com, xen-devel@lists.xenproject.org,
        iommu@lists.linux.dev, stable@vger.kernel.org
Subject: [PATCH 5.15.y v3 1/1] xen/swiotlb: relax alignment requirements
Date: Wed, 21 May 2025 01:51:44 -0700
Message-ID: <20250521085144.1578880-2-harshvardhan.j.jha@oracle.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250521085144.1578880-1-harshvardhan.j.jha@oracle.com>
References: <20250521085144.1578880-1-harshvardhan.j.jha@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_02,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505210086
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDA4NyBTYWx0ZWRfX8f+U4oe/EQtS R/xiEPxMlpCBYcGuSQb5iApcpwt2bmOsBhLJna3sBQCLd5HDWYDNekKfY1QecnMQlfdNx1guQ6w b/HUBOQfH7SoRiXARMavCgfslIukAR6mpQBKRmmdISRxAjwX6iI7UWFK5QC5E1xDh6hQe9N4xCP
 Eg2fBmmEj79OkO1rnHahTu7bL7m+1rupo5HbijlmQzaxeGePPTFe4Ef/N9bQaXxHBGvKgwrCLRN FpUS51MqTZzh+1sp4UqjSFsHwL9cRzsaXXLNS3pfgY05jzK3q+bPLbHPhyEtoB0Y3gQ8l0iZI5J Ddu3ekRaYU3wNbFgYy77CAe0B5hT33E2I4FHNhGOrJbqyF5TK/qecCK9T9oP9ry31JAw9qQKenb
 vh5j+AJUHZwQMQUP/VcVcHMNcVFjAQR4AQc0ly/5ZTGEy7hitICqG1D1CGIjmDF75kfUMGHi
X-Authority-Analysis: v=2.4 cv=VY/3PEp9 c=1 sm=1 tr=0 ts=682d942b b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=dt9VzEwgFbYA:10 a=iox4zFpeAAAA:8 a=yPCof4ZbAAAA:8 a=E5hRKjw2lWykmI9IJP0A:9 a=WzC6qhA0u3u7Ye7llzcV:22 cc=ntf
 awl=host:13206
X-Proofpoint-GUID: 5_s0WM-cZWPJR4YTdgd_l_rYSXFz68xK
X-Proofpoint-ORIG-GUID: 5_s0WM-cZWPJR4YTdgd_l_rYSXFz68xK

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
index 0392841a822fa..65da97be06285 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -75,19 +75,21 @@ static inline phys_addr_t xen_dma_to_phys(struct device *dev,
 	return xen_bus_to_phys(dev, dma_to_phys(dev, dma_addr));
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
@@ -306,7 +308,8 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	phys = dma_to_phys(hwdev, *dma_handle);
 	dev_addr = xen_phys_to_dma(hwdev, phys);
 	if (((dev_addr + size - 1 <= dma_mask)) &&
-	    !range_straddles_page_boundary(phys, size))
+	    !range_straddles_page_boundary(phys, size) &&
+	    !range_requires_alignment(phys, size))
 		*dma_handle = dev_addr;
 	else {
 		if (xen_create_contiguous_region(phys, order,
@@ -347,6 +350,7 @@ xen_swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 
 	if (!WARN_ON((dev_addr + size - 1 > dma_mask) ||
 		     range_straddles_page_boundary(phys, size)) &&
+	    !range_requires_alignment(phys, size) &&
 	    TestClearPageXenRemapped(page))
 		xen_destroy_contiguous_region(phys, order);
 
-- 
2.47.1



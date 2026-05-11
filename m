Return-Path: <stable+bounces-245161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLhEIumUAWoefAEAu9opvQ
	(envelope-from <stable+bounces-245161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:35:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD58550A2B7
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 10:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E75CA3006817
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 08:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B603B8BDB;
	Mon, 11 May 2026 08:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="tBbG7rSJ"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6733BAD99;
	Mon, 11 May 2026 08:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778488326; cv=none; b=PMPAOH6OwSm1K0y0DAd4vsDdwmiqLOcnCTTA/48YZ8tFKvWHz5+4YiXVF5MAcdTAokDsN0q7SYj45x4DYQ6+5y/NT7ObnGQL76sB6jjCfbr2T+09E2m5eJdvjKQim+v2yfgas+Y5ledaefbngt53WSMd0ZRzbw9Kspqnm7/EcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778488326; c=relaxed/simple;
	bh=sz2mlZDT53bsPop7hHBS/2HwxEsHhbeQjeRvZmi60h0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E/gl8tXUfIyGpa5POxQ5rqmWOfvfdM7X+jVxE7rU9g7KyuFy6XBfYADju8HAOxkJFw7QWuos8y2C0cePt98LMYzI2ZOoour4NGLXA//gponcVPubzBGLPFuAbktxoBOxnO4tg3QuKz6mNPGaKVdxfsEm0Psz2Qk8X6tVDanl0Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=tBbG7rSJ; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B5eJob1174006;
	Mon, 11 May 2026 01:31:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=xM0c8X8Oj
	xQteNR6SOoz3ERQaeTZo47aoNSkqShTm2w=; b=tBbG7rSJfn6tpD4Uxc9IS5ME9
	YVB51D9390tVXoAJcv4r17xHy4E0bS99r3H06tCIXWMUFvQyNMxs50YrjLXv206f
	VoZBdVTpRDvoOcCVhTeoMTRIJ5DigYSjjk8Yjz2Z/Rm4pT89BKlstyLZO7t1Knx3
	wY4jMJLlO0wOrcHp0S4WWOEYtXB1fERUK97AYLic7NDpgcAbb6G1r/pZrhW9dVBD
	HNZ0fnPxWUKoZ0/N56Uho/lqvXhHm9uPkgwFZwcd/+n64Llhy21Rnzd3QhqO0wre
	NTUJbGAt/tz2EBva5eWTHo/MRi9F/9iu4oQnovnF2XUor7YnjCUW/3Hm8d5AA==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e24ee9d09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 11 May 2026 01:31:36 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Mon, 11 May 2026 01:31:35 -0700
Received: from pek-lpggp9.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Mon, 11 May 2026 01:31:33 -0700
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
To: <m.szyprowski@samsung.com>
CC: <robin.murphy@arm.com>, <leon@kernel.org>, <kbusch@kernel.org>,
        <jgg@ziepe.ca>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Subject: [PATCH v2] dma-mapping: move dma_map_resource() sanity check into debug code
Date: Mon, 11 May 2026 16:31:33 +0800
Message-ID: <20260511083133.1096171-1-jianpeng.chang.cn@windriver.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA5MiBTYWx0ZWRfX8RV6Sbl6WhaQ
 I5/sEIU0UZ41oEp5eMzzm2nNmn6gR4enu78bAhCopmo0UPBbgyc11MPPT8rvzWcdrJb6nhXb0P+
 IOJabp4ePlx68u/Y4YJcjFm7WXa3T+yi4m+9sWilD53JC3uGQiIQhmHZVfRUiws7vcW6Wswl6u7
 TK8FO5sWBH6rPj2rs/93rm9/TPHswnBHx6lm5P/V0lTZFGsmYuvlvUmPnNWpgR+7NgEXXJZ0D6T
 sd5iziMQRxFT+hDRUERQGlFvBeTcPGWq7J2EZmjvzP6pPqlbVtdUY4WpDsQSbODmxQDQc96XOY6
 trBojCiP2fpvFNAsPHLjQ8Qri3P3LgXk+UwsSfNpOE6p+IdiJkpvV2WNOi0+POU9BxbbKMAt7pO
 E5IPvVZ2pi2XnqJJ7OadW4sJn3Yw/aLeZvyh45ImPHq75ntrOy2s8d/VpcJBddATtxVLBebGVID
 JxMtB23n2i9vn1hTuJQ==
X-Authority-Analysis: v=2.4 cv=H/TrBeYi c=1 sm=1 tr=0 ts=6a0193e8 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8
 a=h0AvKgH_ywIdHqhAvZkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: 2394AkpGSmTLRrlOucGsnY3xOHz69ErM
X-Proofpoint-ORIG-GUID: 2394AkpGSmTLRrlOucGsnY3xOHz69ErM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110092
X-Rspamd-Queue-Id: AD58550A2B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245161-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianpeng.chang.cn@windriver.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[windriver.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

dma_map_resource() uses pfn_valid() to ensure the range is not RAM.
However, pfn_valid() only checks for availability of the memory map for
a PFN but it does not ensure that the PFN is actually backed by RAM. On
ARM64 with SPARSEMEM (128MB section granularity), MMIO addresses that
share a section with RAM will falsely trigger the WARN_ON_ONCE and cause
dma_map_resource() to return DMA_MAPPING_ERROR.

This causes a WARNING on Raspberry Pi 4 during spi_bcm2835 probe because
the SPI FIFO register (0xfe204004) falls in the same sparsemem section
as the end of RAM (0xf8000000-0xfbffffff), both in section 31
(0xf8000000-0xffffffff).

Move the sanity check from dma_map_resource() into debug_dma_map_phys()
and replace the unreliable pfn_valid() with pfn_valid() &&
!PageReserved(), which correctly identifies actual usable RAM without
false positives for MMIO regions that happen to have struct pages.

Since dma_map_resource() is dma_map_phys(DMA_ATTR_MMIO), the check
applies equally to both APIs. Any non-reserved page represents kernel
memory to a sufficient degree that using DMA_ATTR_MMIO on it is almost
certainly wrong and risks breaking coherency on non-coherent platforms.
ZONE_DEVICE pages used for PCI P2P DMA (MEMORY_DEVICE_PCI_P2PDMA) have
PageReserved set, so they will not trigger a false positive.

The check is now a WARN_ONCE that no longer blocks the mapping, since
being unobtrusive is more important than being exhaustive for what is
merely a debug sanity check.

Fixes: f7326196a781 ("dma-mapping: export new dma_*map_phys() interface")
Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
---
v2:
  - move check to debug_dma_map_phys and replace pfn_valid() with
    pfn_valid() && !PageReserved() as Robin suggested.
  - update commit message to explain why PageReserved is safe for
    ZONE_DEVICE PCI_P2PDMA pages
v1: https://lore.kernel.org/all/20260507032120.4072283-1-jianpeng.chang.cn@windriver.com/
 kernel/dma/debug.c   | 9 +++++++++
 kernel/dma/mapping.c | 4 ----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 1a725edbbbf6..180aa2c930b5 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1239,6 +1239,15 @@ void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 	if (dma_mapping_error(dev, dma_addr))
 		return;
 
+	if (attrs & DMA_ATTR_MMIO) {
+		unsigned long pfn = PHYS_PFN(phys);
+
+		WARN_ONCE(pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn)),
+			  "dma_map_resource called for RAM address %pa\n",
+			  &phys);
+		return;
+	}
+
 	entry = dma_entry_alloc();
 	if (!entry)
 		return;
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 23ed8eb9233e..e6b07f160d20 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -365,10 +365,6 @@ EXPORT_SYMBOL(dma_unmap_sg_attrs);
 dma_addr_t dma_map_resource(struct device *dev, phys_addr_t phys_addr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	if (IS_ENABLED(CONFIG_DMA_API_DEBUG) &&
-	    WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
-		return DMA_MAPPING_ERROR;
-
 	return dma_map_phys(dev, phys_addr, size, dir, attrs | DMA_ATTR_MMIO);
 }
 EXPORT_SYMBOL(dma_map_resource);
-- 
2.54.0



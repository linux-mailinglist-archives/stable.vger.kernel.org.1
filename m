Return-Path: <stable+bounces-246774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GHQAuMmBGqDEwIAu9opvQ
	(envelope-from <stable+bounces-246774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:23:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8690652E92C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 09:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BCC5301842C
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF3B3D5C1E;
	Wed, 13 May 2026 07:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Qx4EBLAR"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F4138F24F;
	Wed, 13 May 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778656972; cv=none; b=NZIVNzmwFHq1ryNBjztqmPzqC+JjgE7alVanNm1bRo1qc+wrEXh69V/QSLv1LF+nh766nqC4B8gD4mbIVMDfUDFfvO99UpKhZZyK8kCQpVuw4H0KOXH5LdwpbryTKjosQLcZoFmIsS9q5E/LkyB8DAfrJVL8utAleMMsw/bme3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778656972; c=relaxed/simple;
	bh=CxrN6QFA28zqpXwY27jGC4rk/w9QzK43mFqH4fnbJuk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g7ffXGf2LakEF390LSWekl3CZrRuBxvTCagWaxvzbp+qCjUMFLlbOjxIZp3wjJZmMpVHQ6TkAQg/ndTUNreuRiToh9be8e5yy70uPrUwhPDJotuJxIYb74pxntwwiYvVTTxibYmN+X0Li/iTTs72c6WDhm/BbGbGiB4DR9GcTAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Qx4EBLAR; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1c41C010818;
	Wed, 13 May 2026 07:22:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=BBocNGq4n
	7K6+me3DtnDcqFK2h9Y5P3ZMiaMVCqqS1k=; b=Qx4EBLARz/9WNRNqUaxPvwTdn
	h3YpU9r5yaqr6F8NjT94uzyqsrizfz87CYtwqxt9+8xOxxRe8KPsoid11IpP/JJ5
	rZ+83lGKK1C0/fRhMUYeYgsdPYUUX4q5ppm2bQEyWMwTbHwOMgaVmwkBaZ1knF88
	a7vlDXL4DxR0GAmD3kOyfh+MiUm9E3u1Arns69grjyTIoK+HcjngL/OcUuGvt3sv
	5wmSviv+Y0BKCTWmUXYaz+KbvFGq2ui/u39gVL3qISgTtnmebEKtIxBpIbEWLJAg
	36B4ct1G/4wttxpqk5NX2iTkI/FsQ7YQbovjC7MUeK9DjDZGbmLGkABQ24Xdw==
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e4ft78bf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 13 May 2026 07:22:15 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Wed, 13 May 2026 00:22:13 -0700
Received: from pek-lpggp9.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Wed, 13 May 2026 00:22:10 -0700
From: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
To: <m.szyprowski@samsung.com>
CC: <robin.murphy@arm.com>, <leon@kernel.org>, <kbusch@kernel.org>,
        <jgg@ziepe.ca>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Jianpeng Chang <jianpeng.chang.cn@windriver.com>
Subject: [PATCH v3] dma-mapping: move dma_map_resource() sanity check into debug code
Date: Wed, 13 May 2026 15:22:09 +0800
Message-ID: <20260513072209.1486986-1-jianpeng.chang.cn@windriver.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DSsEcApjTbxzovSebvYw6tDkThseE4Fk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA3NCBTYWx0ZWRfXz79ZOkByUlIp
 BRhixK9+sT/lFLuXM4q1E90t/7BgTh4Cjv9G+n333DqwFcdAsb6i9lQZjJfdrJ+KkvfKoHL8kie
 BI6rXgPDiuhbYZJeksGZplEGbmqd5zTtOx+I8SqYtJMK2T6PFAOSjiK5KW8TNf708URsdeZ0pJ5
 P1+EowIS45pMspcuF85Hdk33wKJoysLendtLFI+HkacMmy/zYqrsdl+qe2/vQ+J34Tz3fSHj5Az
 jvGZC9BMSxc++iiS9BplQflx6crB0RhXwv+TOqCU1m5SAi3pQYLIsk/tDhIWUzB5dzKutuWb7Xh
 9W/Qawz6cfGpvNRrDvVVgZH8/VAyOEBWgUVcSJ1zcBXX7CVh4LUv+2D8qgEzjuiQsnzv4zvQ5QE
 EN6Ho2h+jYg+Q+zF47/bHFIBuWouvz+rfGd1HSgSKmSdLwxYXDwD6RwTQZzVWc7G6p4ybJ+HZId
 J0hsMgZ18k85JO5YluA==
X-Proofpoint-GUID: DSsEcApjTbxzovSebvYw6tDkThseE4Fk
X-Authority-Analysis: v=2.4 cv=G6As1dk5 c=1 sm=1 tr=0 ts=6a0426a7 cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22
 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=7CQSdrXTAAAA:8
 a=h0AvKgH_ywIdHqhAvZkA:9 a=FdTzh2GWekK77mhwV6Dw:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130074
X-Rspamd-Queue-Id: 8690652E92C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246774-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,arm.com:email,windriver.com:email,windriver.com:mid,windriver.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jianpeng.chang.cn@windriver.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[windriver.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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

The check no longer blocks the mapping and uses err_printk() to
integrate with dma-debug filtering.

Fixes: f7326196a781 ("dma-mapping: export new dma_*map_phys() interface")
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Jianpeng Chang <jianpeng.chang.cn@windriver.com>
---
v3:
  - WARN_ONCE -> err_printk()
  - move the MMIO check down, and delete the return
v2: https://lore.kernel.org/all/20260511083133.1096171-1-jianpeng.chang.cn@windriver.com/
   - move check to debug_dma_map_phys and replace pfn_valid() with
     pfn_valid() && !PageReserved() as Robin suggested.
   - update commit message to explain why PageReserved is safe for
     ZONE_DEVICE PCI_P2PDMA pages
v1: https://lore.kernel.org/all/20260507032120.4072283-1-jianpeng.chang.cn@windriver.com/

 kernel/dma/debug.c   | 9 ++++++++-
 kernel/dma/mapping.c | 4 ----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 1a725edbbbf6..3248f8b4d096 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -1251,7 +1251,14 @@ void debug_dma_map_phys(struct device *dev, phys_addr_t phys, size_t size,
 	entry->direction = direction;
 	entry->map_err_type = MAP_ERR_NOT_CHECKED;
 
-	if (!(attrs & DMA_ATTR_MMIO)) {
+	if (attrs & DMA_ATTR_MMIO) {
+		unsigned long pfn = PHYS_PFN(phys);
+
+		if (pfn_valid(pfn) && !PageReserved(pfn_to_page(pfn)))
+			err_printk(dev, entry,
+				   "dma_map_resource called for RAM address %pa\n",
+				   &phys);
+	} else {
 		check_for_stack(dev, phys);
 
 		if (!PhysHighMem(phys))
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
2.51.2



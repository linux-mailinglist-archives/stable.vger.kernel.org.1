Return-Path: <stable+bounces-52557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A790B380
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4538B285B5F
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A614C153505;
	Mon, 17 Jun 2024 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPKemqhO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B6A153593
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634220; cv=none; b=pCAD5dUKQKO/57aMpxWzJQx0CSzttWase0KvrWeE7DH8O156tH98Ol+sDKIwzRhy4VAcRe+cSEBjRsesZ271D9cZ9Ci1sDlqSdxjBROBv9W0J8RPOZOl8sMHqh/xp6Dq3nIQPZ/9JACgyryR3/m2VJRnNrp97cdrVC5lpBoDEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634220; c=relaxed/simple;
	bh=hulMgBRdPBbj4trwJAcN1LlPCcBBrpYYDYjm9FO5yH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NxtgNSdT91JfyI8XjqBWK9+/RpPcK3wIcGiqHeIYsqCa5LEXXBdVhSVLupEFiWxvgbkGxtL7Ux3aKww9YMQuyh6MJf9ToHrZ3+Invv2d6bmkYvLXKFKhx35hTxww8OtCWQ3pUFg+mB+XaSHBb94PZPmz74xQFnJG8tF9E0Gwi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPKemqhO; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-6e9a52a302dso209517a12.1
        for <stable@vger.kernel.org>; Mon, 17 Jun 2024 07:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718634218; x=1719239018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng/U4uNmua6DjTMgZUmcogSDz+BdziXEo9tvtqRjqnc=;
        b=lPKemqhOXoBbNTURBvGaBWqXsT5cLVfKbd/U5zE/r42DzcI1tDjr1AnTHejov6m7la
         cPROSTOe+QinZ2yeJ5r8m0LA3T06vN3pb8m0wbsInI7ypkCaANP2GmPO45R8VCGk9MMg
         Fn3VYZdecbDm7H9k2nZ5cDLSPH503W8jtpTAMEt1CnNxkJHMyAcFNnit0Q7StdJSH1OE
         16k+PKiPNZ7YFRh1/RAzU1C4MILHNuspHclhad5qsifNWW4tO0MF3XO+uhSjP+TCpDKp
         ZJcRGoScWZ7U+hKL1F2EYHH3i/dVmVSAhBfkOAhM0erdaEIJagX0lROyFofwvdyvTnp1
         JAEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718634218; x=1719239018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ng/U4uNmua6DjTMgZUmcogSDz+BdziXEo9tvtqRjqnc=;
        b=fq4odtFbYSdNte3qRF0MhNO/ayy5Bo1BDb68bG5CdBBaBklUV/dtBQJlMPCKXW/HmH
         DvGmMXoobP816hEmVm8LFF2QRA395FpRRvBTw5rbALzEkchXBIOvZ6LtyeeWOdR7nmlF
         oP0X9cWL/UpipBJ8kDr+V9vtb21MHc1TBqo8z0zu511+NLgMqEp1gTpuXNhvTjMWJ3pd
         PkvAZrHqd0FDJYk7aC0IAssc1+blHztw6yeKRLpawVDappz9B6hMbOzMvDs20yU4Rb4g
         qKAVMPjhhZz+ItCvct3yfYsNKB/BuJs2nagNDZzIq8OF3o75zVQ0hZ2UAxUoCGoXQJ/0
         udbw==
X-Gm-Message-State: AOJu0YwAkmYzmsTjH/ObHLISLM8JTee8kRvhnheZysrFPSYnfWSnY4ss
	eIH1mQzNjk96V4WYDGiq8knWJTp50WuCLLENIXOw8XOZdq8aLsZ0je8nAQ==
X-Google-Smtp-Source: AGHT+IETQTyLVOJP1Pdie15ZYXnDIBAEVm3MCH4DMxSBOr0m5W3jEJL5YAr1c/lzYIkjjX1UWnUuDQ==
X-Received: by 2002:a05:6a20:da98:b0:1ba:f7a6:ed61 with SMTP id adf61e73a8af0-1baf7a6f430mr8804775637.6.1718634217630;
        Mon, 17 Jun 2024 07:23:37 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:774f:1c4c:a7d2:bccd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e82sm79645965ad.22.2024.06.17.07.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:23:37 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: stable@vger.kernel.org
Cc: will@kernel.org,
	mhklinux@outlook.com,
	petr.tesarik1@huawei-partners.com,
	nicolinc@nvidia.com,
	hch@lst.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 3/3] swiotlb: extend buffer pre-padding to alloc_align_mask if necessary
Date: Mon, 17 Jun 2024 11:23:15 -0300
Message-Id: <20240617142315.2656683-4-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617142315.2656683-1-festevam@gmail.com>
References: <20240617142315.2656683-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

commit af133562d5aff41fcdbe51f1a504ae04788b5fc0 upstream.

Allow a buffer pre-padding of up to alloc_align_mask, even if it requires
allocating additional IO TLB slots.

If the allocation alignment is bigger than IO_TLB_SIZE and min_align_mask
covers any non-zero bits in the original address between IO_TLB_SIZE and
alloc_align_mask, these bits are not preserved in the swiotlb buffer
address.

To fix this case, increase the allocation size and use a larger offset
within the allocated buffer. As a result, extra padding slots may be
allocated before the mapping start address.

Leave orig_addr in these padding slots initialized to INVALID_PHYS_ADDR.
These slots do not correspond to any CPU buffer, so attempts to sync the
data should be ignored.

The padding slots should be automatically released when the buffer is
unmapped. However, swiotlb_tbl_unmap_single() takes only the address of the
DMA buffer slot, not the first padding slot. Save the number of padding
slots in struct io_tlb_slot and use it to adjust the slot index in
swiotlb_release_slots(), so all allocated slots are properly freed.

Cc: stable@vger.kernel.org # v6.6+
Fixes: 2fd4fa5d3fb5 ("swiotlb: Fix alignment checks when both allocation and DMA masks are present")
Link: https://lore.kernel.org/linux-iommu/20240311210507.217daf8b@meshulam.tesarici.cz/
Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 kernel/dma/swiotlb.c | 59 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0dc3ec199fe4..e7c3fbd0737e 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -69,11 +69,14 @@
  * @alloc_size:	Size of the allocated buffer.
  * @list:	The free list describing the number of free entries available
  *		from each index.
+ * @pad_slots:	Number of preceding padding slots. Valid only in the first
+ *		allocated non-padding slot.
  */
 struct io_tlb_slot {
 	phys_addr_t orig_addr;
 	size_t alloc_size;
-	unsigned int list;
+	unsigned short list;
+	unsigned short pad_slots;
 };
 
 static bool swiotlb_force_bounce;
@@ -287,6 +290,7 @@ static void swiotlb_init_io_tlb_pool(struct io_tlb_pool *mem, phys_addr_t start,
 					 mem->nslabs - i);
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
+		mem->slots[i].pad_slots = 0;
 	}
 
 	memset(vaddr, 0, bytes);
@@ -821,12 +825,30 @@ void swiotlb_dev_init(struct device *dev)
 #endif
 }
 
-/*
- * Return the offset into a iotlb slot required to keep the device happy.
+/**
+ * swiotlb_align_offset() - Get required offset into an IO TLB allocation.
+ * @dev:         Owning device.
+ * @align_mask:  Allocation alignment mask.
+ * @addr:        DMA address.
+ *
+ * Return the minimum offset from the start of an IO TLB allocation which is
+ * required for a given buffer address and allocation alignment to keep the
+ * device happy.
+ *
+ * First, the address bits covered by min_align_mask must be identical in the
+ * original address and the bounce buffer address. High bits are preserved by
+ * choosing a suitable IO TLB slot, but bits below IO_TLB_SHIFT require extra
+ * padding bytes before the bounce buffer.
+ *
+ * Second, @align_mask specifies which bits of the first allocated slot must
+ * be zero. This may require allocating additional padding slots, and then the
+ * offset (in bytes) from the first such padding slot is returned.
  */
-static unsigned int swiotlb_align_offset(struct device *dev, u64 addr)
+static unsigned int swiotlb_align_offset(struct device *dev,
+					 unsigned int align_mask, u64 addr)
 {
-	return addr & dma_get_min_align_mask(dev) & (IO_TLB_SIZE - 1);
+	return addr & dma_get_min_align_mask(dev) &
+		(align_mask | (IO_TLB_SIZE - 1));
 }
 
 /*
@@ -847,7 +869,7 @@ static void swiotlb_bounce(struct device *dev, phys_addr_t tlb_addr, size_t size
 		return;
 
 	tlb_offset = tlb_addr & (IO_TLB_SIZE - 1);
-	orig_addr_offset = swiotlb_align_offset(dev, orig_addr);
+	orig_addr_offset = swiotlb_align_offset(dev, 0, orig_addr);
 	if (tlb_offset < orig_addr_offset) {
 		dev_WARN_ONCE(dev, 1,
 			"Access before mapping start detected. orig offset %u, requested offset %u.\n",
@@ -983,7 +1005,7 @@ static int swiotlb_area_find_slots(struct device *dev, struct io_tlb_pool *pool,
 	unsigned long max_slots = get_max_slots(boundary_mask);
 	unsigned int iotlb_align_mask = dma_get_min_align_mask(dev);
 	unsigned int nslots = nr_slots(alloc_size), stride;
-	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
+	unsigned int offset = swiotlb_align_offset(dev, 0, orig_addr);
 	unsigned int index, slots_checked, count = 0, i;
 	unsigned long flags;
 	unsigned int slot_base;
@@ -1282,11 +1304,12 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		unsigned long attrs)
 {
 	struct io_tlb_mem *mem = dev->dma_io_tlb_mem;
-	unsigned int offset = swiotlb_align_offset(dev, orig_addr);
+	unsigned int offset;
 	struct io_tlb_pool *pool;
 	unsigned int i;
 	int index;
 	phys_addr_t tlb_addr;
+	unsigned short pad_slots;
 
 	if (!mem || !mem->nslabs) {
 		dev_warn_ratelimited(dev,
@@ -1303,6 +1326,7 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 		return (phys_addr_t)DMA_MAPPING_ERROR;
 	}
 
+	offset = swiotlb_align_offset(dev, alloc_align_mask, orig_addr);
 	index = swiotlb_find_slots(dev, orig_addr,
 				   alloc_size + offset, alloc_align_mask, &pool);
 	if (index == -1) {
@@ -1318,6 +1342,10 @@ phys_addr_t swiotlb_tbl_map_single(struct device *dev, phys_addr_t orig_addr,
 	 * This is needed when we sync the memory.  Then we sync the buffer if
 	 * needed.
 	 */
+	pad_slots = offset >> IO_TLB_SHIFT;
+	offset &= (IO_TLB_SIZE - 1);
+	index += pad_slots;
+	pool->slots[index].pad_slots = pad_slots;
 	for (i = 0; i < nr_slots(alloc_size + offset); i++)
 		pool->slots[index + i].orig_addr = slot_addr(orig_addr, i);
 	tlb_addr = slot_addr(pool->start, index) + offset;
@@ -1336,13 +1364,17 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 {
 	struct io_tlb_pool *mem = swiotlb_find_pool(dev, tlb_addr);
 	unsigned long flags;
-	unsigned int offset = swiotlb_align_offset(dev, tlb_addr);
-	int index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
-	int nslots = nr_slots(mem->slots[index].alloc_size + offset);
-	int aindex = index / mem->area_nslabs;
-	struct io_tlb_area *area = &mem->areas[aindex];
+	unsigned int offset = swiotlb_align_offset(dev, 0, tlb_addr);
+	int index, nslots, aindex;
+	struct io_tlb_area *area;
 	int count, i;
 
+	index = (tlb_addr - offset - mem->start) >> IO_TLB_SHIFT;
+	index -= mem->slots[index].pad_slots;
+	nslots = nr_slots(mem->slots[index].alloc_size + offset);
+	aindex = index / mem->area_nslabs;
+	area = &mem->areas[aindex];
+
 	/*
 	 * Return the buffer to the free list by setting the corresponding
 	 * entries to indicate the number of contiguous entries available.
@@ -1365,6 +1397,7 @@ static void swiotlb_release_slots(struct device *dev, phys_addr_t tlb_addr)
 		mem->slots[i].list = ++count;
 		mem->slots[i].orig_addr = INVALID_PHYS_ADDR;
 		mem->slots[i].alloc_size = 0;
+		mem->slots[i].pad_slots = 0;
 	}
 
 	/*
-- 
2.34.1



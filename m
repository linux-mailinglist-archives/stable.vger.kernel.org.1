Return-Path: <stable+bounces-231352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFUCDn1/y2mLIQYAu9opvQ
	(envelope-from <stable+bounces-231352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:02:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A20C365B02
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 10:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B6A5B3098997
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 07:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B9C3BE64A;
	Tue, 31 Mar 2026 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UChLk5xG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDB738238B
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943415; cv=none; b=KTA3xh5DWi+jTvOml9VVAyKb5R8Uhr9VA3Xa80Iv5AC9xVu2tgt2NtTx2dk/d56j5txLeOtuCRgMO3DGWcDf43pTUYzQBboOqVTjr/ddvjkbIUPy9W8+vNuTNaN1i2dmPFzrAfB9wmQTrxOiSA8uNG4omCbwnWXTrYxREN/C788=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943415; c=relaxed/simple;
	bh=pEAts6xefgNbpkfmypE/+GyTlphpHd+cArKTNcgfLoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gCCECd41x3fiLBD2eAcaZlZxTo6VjmXL87/Gk2A7Rw1FdhB4wxdKJWO+K9JZDg/yJd1wTbNrwLts5VM7qVR/VXhhxIgsfegLB5o+ciP4L7pO/yAuYhe+ovjIJbJm9ig9SbrJiZ1Iele2UNH+NY8MmCOvuFtozD3M3a4A1t6nqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UChLk5xG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so2808595e9.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 00:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774943413; x=1775548213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kZ0FISfr5kyvOiMiGgtJkNjcn8iqulgi6+Bp+/x1xTo=;
        b=UChLk5xGNs7vxSW4y2EREnotiu+CEHulsuxgmV4y8kiEN0vYK0SQfDXA6S6U/LvdmW
         WwJEKKcu0IFRESXVzf4A/hj2l4BE1AD3F6GF+9pXu/wTzv/q3JfO1EgXyoSPFOjFjEn6
         hd67EQkfLLXkePmNpLubp1ske1zqO8imAX3c5kv6PZPadpwjJDePAKoCcDqMWL+GUZJn
         tQXEimS8jmX7d+4JrpmIKO6yCar+QG0lbWftfgrr3ncOMQZiyAO1UJE1RADH2t8vEH/N
         degqpfW8udytysD7910JP+qYtkP2HBiWZBGZfWgDnONTOxdsyEHTBJsJOXZ23cA6Y/NO
         GhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774943413; x=1775548213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZ0FISfr5kyvOiMiGgtJkNjcn8iqulgi6+Bp+/x1xTo=;
        b=rCHWOSfGqJrEmGyS/vCuEeuZP+is/Pl54SgUwGhSMhmPYNMqCTbccrqCZefJww1xHY
         MvBEsowQZjpIMs7HiN4PEWianlREMkym9wYfzjvUXhH+YW/JtUAMBz9FPF4iEtxw4C6b
         GGF0OAgGb4+isY0M0G5LSUH1r/4mz+GB+o5MdozT9L83AWgB/nYM4bmMClckORlB+fU9
         PJTTAPsTxC5fR1orc6ooTlOR3ronPkiuh165l5q6Je0P1+YHv0Xw8dC/Pm4HhWeq/WoO
         rGz/IEjKcnkbYB+kiG0S2lf028L6c+VjGc6vlphxcDcc7TttHX0+XT7UFY7VtG/f+qDM
         wd8A==
X-Forwarded-Encrypted: i=1; AJvYcCUO/p/SL5OwitHkYfZOiw4Sz41mul0wbFfum8XQ2zFCgGMRapJWCiniJtmWpZQnHNA1qniUO+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI0iWj1aAm7P95IpniMZB1syLBeb94/3KrkOdB8sSIU+5rDL7I
	gdYVWsctXiZh50yoqOAZAOwyJkKSfkh7dx1oVjPK+rJAiN3QheQyiw/w
X-Gm-Gg: ATEYQzww8AiY9PIPvPrI9Q1Z2hDY630LrvhxZPEk2uNuP/+0FhJyII9fgDSRHkfykjw
	ebj69AT3QYnE48hd7HXXlGzKKCetOa6Q+6bnTrPTep9uC9Ey1j24L6p5r3MFgOUedKjSR8GutKC
	TgPC4YDeC8ESuBckz+f8cvngMJWvIvtCQIDIBET3QOKaxyyKfnMrBsSB31EJj/t1PY8KEFICgIz
	yJgFoC1YLM/xvTCqSuD3LYu84ko0hvojADaDwzE+VBs97MKQISui8Xm4TXV1O988b1R7kpN8yZ6
	Jrg4LeHcDqmQ/wFtEoUJPB7pS8xO1bRGChEVWjKxs/u0Yoy+7Ofmm1DrN3MFy+1XX1BcusVIKa1
	URW2xpS+zi5Ca0KesYrTbE74Sj3t6xvXNkjVFQE12AuY2WyPCHeULRBR7rjOVcIj1DM+kgCz5as
	bWiDwiXC4RaJ8H+7629E8X2KwpT2h0y+AiS6dWGv4=
X-Received: by 2002:a05:600c:8907:b0:485:fbd2:f72 with SMTP id 5b1f17b1804b1-4887818678emr31449875e9.1.1774943412488;
        Tue, 31 Mar 2026 00:50:12 -0700 (PDT)
Received: from rock-3b.tailb81abf.ts.net ([213.152.28.84])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887c91f0casm9873015e9.35.2026.03.31.00.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:50:11 -0700 (PDT)
From: Midgy BALON <midgy971@gmail.com>
To: iommu@lists.linux.dev
Cc: joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	heiko@sntech.de,
	jonas@kwiboo.se,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Midgy BALON <midgy971@gmail.com>
Subject: [PATCH] iommu/rockchip: fix page table allocation flags for v2 IOMMU
Date: Tue, 31 Mar 2026 09:50:10 +0200
Message-Id: <20260331075010.1463-1-midgy971@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[8bytes.org,kernel.org,arm.com,sntech.de,kwiboo.se,lists.infradead.org,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231352-lists,stable=lfdr.de];
	RSPAMD_URIBL_FAIL(0.00)[kwiboo.se:query timed out];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RSPAMD_EMAILBL_FAIL(0.00)[jonas.kwiboo.se:query timed out,midgy971.gmail.com:query timed out];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[midgy971@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kwiboo.se:email]
X-Rspamd-Queue-Id: 7A20C365B02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 2a7e6400f72b ("iommu: rockchip: Allocate tables from all
available memory for IOMMU v2") removed GFP_DMA32 from
iommu_data_ops_v2, reasoning that RK356x and RK3588 IOMMU v2 hardware
supports up to 40-bit physical addresses for page tables.  However, the
RK3568 IOMMU page-table walker uses a 32-bit AXI bus: it cannot access
physical addresses above 4 GB regardless of the address encoding range.

On boards with more than 4 GB of RAM (e.g. 8 GB LPDDR4X), removing
GFP_DMA32 causes two distinct failure modes:

1. Direct allocation above 4 GB: iommu_alloc_pages_sz() may return
   memory above 0x100000000.  The hardware page-table walker issues a
   bus error trying to dereference those addresses, causing an IOMMU
   fault on the first DMA transaction.

2. SWIOTLB bounce-buffer poisoning: without GFP_DMA32, page tables land
   above the SWIOTLB window.  dma_map_single() with DMA_BIT_MASK(32)
   then bounces them into a buffer below 4 GB.  rk_dte_get_page_table()
   returns phys_to_virt() of the bounce buffer address; PTEs are written
   there; the next dma_sync_single_for_device(DMA_TO_DEVICE) copies the
   original (zero) data back over the bounce buffer, silently erasing the
   freshly written PTEs.  The IOMMU faults because every PTE reads as zero.

Restore GFP_DMA32 (and DMA_BIT_MASK(32)) for iommu_data_ops_v2, which
currently only serves "rockchip,rk3568-iommu" in mainline.

Tested on Radxa ROCK 3B (RK3568, 8 GB LPDDR4X):
  - MobileNetV1 via RKNN: 5.8 ms/inference (IOMMU mode)
  - YOLOv5s 640x640 via RKNN: ~57 ms/inference (IOMMU mode)
  - No IOMMU faults, correct inference results

Fixes: 2a7e6400f72b ("iommu: rockchip: Allocate tables from all available memory for IOMMU v2")
Cc: stable@vger.kernel.org
Cc: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Midgy BALON <midgy971@gmail.com>
---
 drivers/iommu/rockchip-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 85f3667e797..8b45db29471 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1358,8 +1358,8 @@ static struct rk_iommu_ops iommu_data_ops_v2 = {
 	.pt_address = &rk_dte_pt_address_v2,
 	.mk_dtentries = &rk_mk_dte_v2,
 	.mk_ptentries = &rk_mk_pte_v2,
-	.dma_bit_mask = DMA_BIT_MASK(40),
-	.gfp_flags = 0,
+	.dma_bit_mask = DMA_BIT_MASK(32),
+	.gfp_flags = GFP_DMA32,
 };
 
 static const struct of_device_id rk_iommu_dt_ids[] = {
-- 
2.30.2



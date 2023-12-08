Return-Path: <stable+bounces-5073-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4314C80B0AD
	for <lists+stable@lfdr.de>; Sat,  9 Dec 2023 00:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083382815E7
	for <lists+stable@lfdr.de>; Fri,  8 Dec 2023 23:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787521F92D;
	Fri,  8 Dec 2023 23:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8gDe7e+"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C8A1729
	for <stable@vger.kernel.org>; Fri,  8 Dec 2023 15:41:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db53fec212aso3442714276.2
        for <stable@vger.kernel.org>; Fri, 08 Dec 2023 15:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702078911; x=1702683711; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k7GsY6GT/+tnbArErtPc1f6cs5/DzWiGNX1GnrooOm8=;
        b=K8gDe7e+NlM5dXA3tekfmsM6qM9+PqKWF1pdarRSKxNQLp6Zmo234R6MPjNiZTC7Bd
         Sy2givuIttjJG13JBSjEv1tei319RBdaOfFkhvN8v6DWnaTFFUNds0wcmRjCsalowXot
         OMyFpWUQAzQAR1novnmJ9Vmk6H4Y2rId/IgpkewJqXu8y0YzmDJkNFmYqMUcA8eKo7ZF
         SgDcmELPbDV/IHo/muYmi/NejnD6ff1fSUFLKhWavBao4W+HfVUs/e8v4u0ibVnbvXxb
         0UpLfwUZFTrZYw11OAh/MZBCS91Nwa7wpYrcPnUYawdqHqhVSWGEfnyOTmnu+JO79LS1
         Y9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702078911; x=1702683711;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7GsY6GT/+tnbArErtPc1f6cs5/DzWiGNX1GnrooOm8=;
        b=suCEUOd3TUpbE/DpJte/W/Jtu4qIjLTGeL/S6WlgV3QBLoNSVFvOtvfoZeBk3VZezw
         j5pi3U60mnZqhZGO0napS4jESnpqPiAUY1vTNWJpuFWeAKkUjowEVG/Y0kR6cmw7I5EA
         l6zvdJG8Ehl4OVOLYDnRp24SC7k+z96iyPq6kCoaSisKrBgJu2XNMJtyidr/glo/l2cd
         Gq3ibR2VWaMGJJOR7EiO1JDhgyOTBvTcZrAEwONx5gWmXbL4wq1vVKPVka+UzASMJaW6
         QJqX902918hNwZ6dM5E2B1duJYJtnwZ4ZPLil5kg08A5uV8fPw0o97blriPQco2+Gq4S
         U+Mg==
X-Gm-Message-State: AOJu0YwiBql2GJrQi5c4HDz3tYTWaP+5lFqAx5I6I8FV/IJ+KWkOQ0e/
	PcpmN4Az5tGm5xHtMKPsKx7HEqB1olHPgE7v+pvkgA==
X-Google-Smtp-Source: AGHT+IHGOJeWukTVNuH3xvDlUiPgdeVPjjFBrpqw0bilGbylCV43u5Ik4f0j+Oum1gYfbgenTrdwcI2XwBEmlFpybrySNQ==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:4a64:6d71:c7b8:4fc3])
 (user=isaacmanjarres job=sendgmr) by 2002:a25:76c8:0:b0:db7:d315:6643 with
 SMTP id r191-20020a2576c8000000b00db7d3156643mr6416ybc.6.1702078911016; Fri,
 08 Dec 2023 15:41:51 -0800 (PST)
Date: Fri,  8 Dec 2023 15:41:40 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231208234141.2356157-1-isaacmanjarres@google.com>
Subject: [PATCH v1] iommu/dma: Trace bounce buffer usage when mapping buffers
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Tom Murphy <murphyt7@tcd.ie>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>, stable@vger.kernel.org, 
	Saravana Kannan <saravanak@google.com>, kernel-team@android.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When commit 82612d66d51d ("iommu: Allow the dma-iommu api to
use bounce buffers") was introduced, it did not add the logic
for tracing the bounce buffer usage from iommu_dma_map_page().

All of the users of swiotlb_tbl_map_single() trace their bounce
buffer usage, except iommu_dma_map_page(). This makes it difficult
to track SWIOTLB usage from that function. Thus, trace bounce buffer
usage from iommu_dma_map_page().

Fixes: 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers")
Cc: stable@vger.kernel.org # v5.15+
Cc: Tom Murphy <murphyt7@tcd.ie>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 85163a83df2f..037fcf826407 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -29,6 +29,7 @@
 #include <linux/spinlock.h>
 #include <linux/swiotlb.h>
 #include <linux/vmalloc.h>
+#include <trace/events/swiotlb.h>
 
 #include "dma-iommu.h"
 
@@ -1156,6 +1157,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 			return DMA_MAPPING_ERROR;
 		}
 
+		trace_swiotlb_bounced(dev, phys, size);
+
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
 					      iova_mask(iovad), dir, attrs);
-- 
2.43.0.472.g3155946c3a-goog



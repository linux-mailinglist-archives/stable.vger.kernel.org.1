Return-Path: <stable+bounces-12802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBBC8373EF
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 21:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E924F28D344
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 20:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8516947A5C;
	Mon, 22 Jan 2024 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nxz8Zti"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08246433
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 20:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705955895; cv=none; b=bJlxjUN5J9s97XtEzTnc6LDUJO10+LgDBsdgW0zk6d3fmd1TAHfJQ0Z703wIEFC99yKFyZXIFwdzCzpKaArT6ukNc/YNZmxSRRWtbi57JOCpuNnFmt9MSyxVlyjlG/t4EhIIkK3xiPURuQqKVfRMYN2gu88y/5GyRS2RjUuDPU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705955895; c=relaxed/simple;
	bh=ht3OFOZepzevWY8LrzdZG62HQxz9zjIpaWrIyOKZiuE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XkEMyTVo7bnfjtDrS4LoEMm+g9/FaR5CuQcnLrWl/ylWCU/0FprPuZJ7BlyISegyXO676smWtt1WzZGr9BeTpEJO5jgPuG8cYmczZtOubWZRAoNVspyPpl/8gxt0jNAbEX1/ZTkyXgq2teOO35lKlqGduUxxR6cqAg8XsNOHHLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nxz8Zti; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc26605c273so5346242276.0
        for <stable@vger.kernel.org>; Mon, 22 Jan 2024 12:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705955891; x=1706560691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ovPyY1cT5jVLmjOiRM1g4P8UYTcopXTaszvOlquJxEk=;
        b=2nxz8ZtiJKl6Q5iGEQ0Hz1Q2wdky21x054B3PMCtxayWnc57cypLkoZGL9OlndFBfe
         5yeesWtBsbK8gweiCgjpGc0JTshGwm/oQeAz0PJ+JDm7sgyeOY7LA+k1jd4nVkgHjJ6Y
         NnNSkY9ThqlLZ0oXHESAnbOyL34Bvihur8r9JW3/k0RU7nP9Ba5+aiU7jTmfLEo6yCks
         WFRW8Y0rtqj7KXOlWFvsR4UJ5+x3eDqfMDrOSprUHIl4+8UaBY57UcqkEzBYBoWBV6hE
         i87qeIMuqu3BhnitatRMVp2aZD2S1ydAViZ6kU1EkGnmQ7/UbQjuBafq02nvU0pVsFoY
         DKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705955891; x=1706560691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovPyY1cT5jVLmjOiRM1g4P8UYTcopXTaszvOlquJxEk=;
        b=tSeXIGQdEIuUj0SwdiG8b47W3BL1AteFT7EmmpzWHc4xNq+MzmVs9hevp+ixxyI0MY
         vot1Uk0lKRrnm89UsvnudOL6s7PeRnHB8wJffbfgy5lDZIH7c+R4ceRDEaLdqvuVq1GV
         yv9ORAnZD6CAcC1sMttY0pwVYqWRfio8v4/EJ5sOLOtzUN2YPGtgbuXunVll71uT49Q6
         E3VzVN8jxOGA08ZlymYC0+8Jhrteip+1viDjAQMqfEXaxcolCfzXvTmE4q5tDGeayjky
         vjl1bPLcUGn+25UUzf2eW+Pnsi+vF21hTSqdOOH06B6nh6ZaNNfLPGX44Z4CVonAdSWm
         TdWA==
X-Gm-Message-State: AOJu0YyuyK6CxCHOmLPPpNB39hGIC/A4MmpX7mnu6FwpoAk6nnLCaIsA
	d30d3E0Klu+7IMILXoF2Tuux/DXDgUbF0A6dh8hqmJp8EG77u9k2KplcTRGgX4axXZE5JRYILpS
	nDXIzJ1/vg2u2FKg5GGLqFjhhgtgHyI0DhfCBJfiSBooCiPWvGDIUTljvf/fVfhQ2zBHsYeyzGQ
	R8kihsjWTwyTJCcW54dIDvjDjf0DsBhOYgjELyaL+Mpdq0MDRVlMg/Bb4tHs+htRgkmVU0QvdaM
	p4=
X-Google-Smtp-Source: AGHT+IHcuyW7OLB0d9E+mgnrWx8XjzFlhd+qR+sGVBcQIIrj0lVEKajyTntdzrwUU2FMLBPq3nvmH8038HWQSAIGv+XPUA==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:17ea:d296:86a:98b0])
 (user=isaacmanjarres job=sendgmr) by 2002:a5b:1cc:0:b0:dbe:3e36:17db with
 SMTP id f12-20020a5b01cc000000b00dbe3e3617dbmr2237086ybp.1.1705955891476;
 Mon, 22 Jan 2024 12:38:11 -0800 (PST)
Date: Mon, 22 Jan 2024 12:37:54 -0800
In-Reply-To: <2024012226-unmanned-marshy-5819@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024012226-unmanned-marshy-5819@gregkh>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122203758.1435127-1-isaacmanjarres@google.com>
Subject: [PATCH 5.15.y] iommu/dma: Trace bounce buffer usage when mapping buffers
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: stable@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Tom Murphy <murphyt7@tcd.ie>
Cc: "Isaac J. Manjarres" <isaacmanjarres@google.com>, Saravana Kannan <saravanak@google.com>, 
	Joerg Roedel <jroedel@suse.de>, kernel-team@android.com, iommu@lists.linux-foundation.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
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
Link: https://lore.kernel.org/r/20231208234141.2356157-1-isaacmanjarres@google.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
(cherry picked from commit a63c357b9fd56ad5fe64616f5b22835252c6a76a)
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/iommu/dma-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 48c6f7ff4aef..8cd63e6ccd2c 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -25,6 +25,7 @@
 #include <linux/vmalloc.h>
 #include <linux/crash_dump.h>
 #include <linux/dma-direct.h>
+#include <trace/events/swiotlb.h>
 
 struct iommu_dma_msi_page {
 	struct list_head	list;
@@ -817,6 +818,8 @@ static dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
 		void *padding_start;
 		size_t padding_size, aligned_size;
 
+		trace_swiotlb_bounced(dev, phys, size, swiotlb_force);
+
 		aligned_size = iova_align(iovad, size);
 		phys = swiotlb_tbl_map_single(dev, phys, size, aligned_size,
 					      iova_mask(iovad), dir, attrs);
-- 
2.43.0.429.g432eaa2c6b-goog



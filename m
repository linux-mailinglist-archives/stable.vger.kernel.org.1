Return-Path: <stable+bounces-182992-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BD7BB1CAE
	for <lists+stable@lfdr.de>; Wed, 01 Oct 2025 23:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88AB61C2C0C
	for <lists+stable@lfdr.de>; Wed,  1 Oct 2025 21:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE41311C01;
	Wed,  1 Oct 2025 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUAJNiHw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3F1311973
	for <stable@vger.kernel.org>; Wed,  1 Oct 2025 21:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759353571; cv=none; b=dnwj36n557vCUi+uOY3Q+N41BYxkgmSorkress8T2QjXrbVCkS4B5g4uXdENi1AD3l/EgnLVxCPDRKSwwOQoGbUzTWRqy3aVSo08eflUTJtohLh5IyOyV2GIpPvRzEKMuwEuveMh3Upv0jKqAhOzToUFE09RaUyrDWj4nUhrTGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759353571; c=relaxed/simple;
	bh=aEOledK6w1wMxGXPY673maH9I7h2aAPwCGar8VBJ4MQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nf7BE0tCZWtathhX26vNvvXygjcTy+siOAr3M6Yac4amnu+HY/sUPTqfRlX8ZevhZovfKaYiWewoovw2e45/WwhKtmQJ72Kt5ECtCFPLmkf9kWGYd0vLB3LvzfbjSu/TMHJb5leqqFUO8lQPBDn8kXWBtR4u3b1nGFM1aCy5fGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhichuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUAJNiHw; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhichuang.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28e538b5f23so2625025ad.3
        for <stable@vger.kernel.org>; Wed, 01 Oct 2025 14:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759353569; x=1759958369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A/pwp9DS0zIwOKMn4xajft4cQTdUTe4VInQWmlgA8fI=;
        b=PUAJNiHwCbgmBh/ZBlDd4tNtRzFkz6r3z7rSVYcRyPP2zTtavyOfxVn1Akh3tOaVYv
         6lJ1ns7l/8eG7Bl6lchr9Qazlk/02UUw+tXmy+a/zS2/dIUv5By/oEsIIj3Lt9yuQjz5
         zpTXga07grX51A2wJZOrk1xG8fGmweSH2MTGlg/tLUczepENdav6vx53J9q/tc02aBWl
         F0W8B6/vlsTSd+svLOUsjI6/q1AG1ksNzC8qbnzkCksPtL3rhE75tXXGvX7OIKMqmo48
         wArE9Kzkl2bSO9t6YGA+e3Hy5BWbhRTt0svKCR9952GzL0Wq9FmtWMVvQC+PLAkgoG3a
         nTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759353569; x=1759958369;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A/pwp9DS0zIwOKMn4xajft4cQTdUTe4VInQWmlgA8fI=;
        b=NvnM9JLsUKuRqWM/8gDUFFFqHSwK0YA3B1lqqrmiV0d16LrosLcTtr4rM8YQDil7Ne
         X56FcIS1Z1zw6/muJeuQLVKE/HnYPpcHogf9KwlsYaXxHdbp0C2wRKsDnbrMN9FGi2LR
         NnryYIKnry2WHOhtgLQv6aF6wphQF/ckpVA6mG+7q4Qyp52Q/wIVEpp+SQRtfgmaOHCA
         HniWyxcuHvoF2JRjWmNtyrNk/Xl5qfnyb1TVExKA3uyb2KNbRP4cjzUVFGui8Du29czd
         9KGwANfCGV9Q0XPveCzXNTN3Gzjo0rlv+86/4pNjqu874sN+huI2J9Ql6EWMymElxoMm
         bYQA==
X-Gm-Message-State: AOJu0Yz32QW89Avk5aCCmED+BzLbs/TJp1jiRkVwVsaVRSqx+BtZjeFS
	TEoZqs8I2xs02TD2qW6dTGGA2kWaEWHlj33lWOulk8doPLgXmbFguiwMip3ir0JqXlvD11j5Uzy
	ZhvJAPwbb1/xdddkDI7yB4rOhAdgKK40Zl//qaf8JCJescKdLiPTP3cKcKNBA1mSDGMa4Eij28U
	WCYQgXaVIJlyzsJdw5WHQ+InMRleCoBpS9udtA9OosZd9yB+Mm4o3J
X-Google-Smtp-Source: AGHT+IFZUy+Gi4hsRWB1Fikoy1ypU9ASzF/kgdFvxEuDyf/TEGSBYCtm7gb/35Gf45VZFWNV/v+z/b1HaTNYOuU=
X-Received: from plbkp7.prod.google.com ([2002:a17:903:2807:b0:269:b756:8e38])
 (user=zhichuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:3847:b0:264:567b:dd92 with SMTP id d9443c01a7336-28e7f457c56mr63781305ad.52.1759353568611;
 Wed, 01 Oct 2025 14:19:28 -0700 (PDT)
Date: Wed,  1 Oct 2025 21:19:09 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001211909.721369-1-zhichuang@google.com>
Subject: [PATCH] commit 6b080c4e815ceba3c08ffa980c858595c07e786a upstream
From: Zhichuang Sun <zhichuang@google.com>
To: stable@vger.kernel.org
Cc: Zhichuang Sun <zhichuang@google.com>, Nadav Amit <namit@vmware.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

iommu/amd: fix amd iotlb flush range in unmap

This was fixed in mainline in 6b080c4e815ceba3c08ffa980c858595c07e786a,
but do not backport the full refactor.

Targeting branch lts linux-5.15.y.

AMD IOMMU driver supports power of 2 KB page size, it can be 4K, 8K,
16K, etc. So when VFIO driver ask AMD IOMMU driver to unmap a
IOVA with a page_size 4K, it actually can unmap a page_size of
8K, depending on the page used during mapping. However, the iotlb
gather function use the page_size as the range of unmap range,
instead of the real unmapped page size r.

This miscalculation of iotlb flush range will make the unflushed
IOTLB entry stale. It triggered hard-to-debug silent data corruption
issue as DMA engine who used the stale IOTLB entry will DMA into
unmapped memory region.

The upstream commit aims at changing API from map/unmap_page() to
map/unmap_pages() and changed the gather range calculation along
with it. It accidentally fixed this bug in the mainline since 6.1.
For this backport, we don't backport the API change, only port the
gather range calculation to fix the bug.

Cc: Nadav Amit <namit@vmware.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Fixes: fc65d0acaf23179b94de399c204328fa259acb90
Signed-off-by: Zhichuang Sun <zhichuang@google.com>
---
 drivers/iommu/amd/iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 714c78bf69db..d3a11be8d1dd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2121,7 +2121,8 @@ static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
 
 	r = (ops->unmap) ? ops->unmap(ops, iova, page_size, gather) : 0;
 
-	amd_iommu_iotlb_gather_add_page(dom, gather, iova, page_size);
+	if (r)
+		amd_iommu_iotlb_gather_add_page(dom, gather, iova, r);
 
 	return r;
 }
-- 
2.51.0.618.g983fd99d29-goog



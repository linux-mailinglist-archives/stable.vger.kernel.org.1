Return-Path: <stable+bounces-183140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E88E2BB530F
	for <lists+stable@lfdr.de>; Thu, 02 Oct 2025 22:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D07519E7C3D
	for <lists+stable@lfdr.de>; Thu,  2 Oct 2025 20:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1315F223DC6;
	Thu,  2 Oct 2025 20:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="31izfIVs"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362AC223DFD
	for <stable@vger.kernel.org>; Thu,  2 Oct 2025 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759438166; cv=none; b=bfaqeX8+EqAyEuI+IgyLTuBxWIA0VveEyPzcrN5LfI/Tj64fgVJR79OX+KUcyvVV+mOfkw/ayoZjvpIBtG/ooPmfWxShV6xIah10tQPm1qWOO6hM6x/Xn3EVx3qD32wNUGNZ/i5lG36xH0TrjzHVMIFPAzP7AqO+yehBj9GiGtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759438166; c=relaxed/simple;
	bh=O3vGl1aWiPp1eqBGk04UZc3I6dWrZcOsqe9p0uXNk+4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rwQBbXeecWCxdlaIWbATr+yT6ODuy4pY4pV7z6XntFuPE0Bl1n0hAIU5zVpY6PSZzOZk4eK8OfdVcbESX3tdb6LcSrbhZOs1NVA28ynQFNhFn2N7IOX91N5nMM4VLrgLpAGGUwhK0XLqKk0xV6+KFnJXfsZJ+ATAXtEWpDQ6vHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhichuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=31izfIVs; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhichuang.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b60992e3b27so1340433a12.3
        for <stable@vger.kernel.org>; Thu, 02 Oct 2025 13:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759438164; x=1760042964; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2MnVQZKXfLoGb61IB8JrnKNZmJVhYzDXrmRmuT60NuI=;
        b=31izfIVsvL1mKWadOxGxEA/Y9Qbr712W+qd4KSQxGTjp/ecfVzgt9LV8dZqUPX9oiH
         5Zl1HyaOOu3kFJL0D1JHf19yWFFfV/5gkUPT/lzxn/FFDh7vOKfDb76ql3WiTLEWbNwQ
         FHfgfPk8h5jjPZzIwP6H0ZEnkD46DAwq0XkWDWDAJHrVSeeDgL4O8a2v8MMgMZHB9qz/
         bPa2vTh3XQGPVYVvFR/odHYGrAQf8m6pJYYBA0IbrYhxXNZ4y4hnx/fns3S3B53gdqHn
         dtE+Mrx3YhAnvElDy8z28ITvya6HAJs66baBZjAUqhee/qaHpvNqdrws0hNc2URhS++x
         HGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759438164; x=1760042964;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2MnVQZKXfLoGb61IB8JrnKNZmJVhYzDXrmRmuT60NuI=;
        b=K0cHZUsH6RdroyJijd0CDEVWkw7fe5Hv+xCpJKNlBX8xFXXWwEyiv9xnT6Ken5ld1Q
         /HX3aVOHD94PpuwpGVj58yut7cYWdZTDsPTC24JWfw3+KSQjG4YAYI88M8SqvWd8JoUK
         axQWqUrG1xkFldHPGSjX3RxxmZLA1fyy9mpagnirIfuZYw3e0CSq72cFp7rdVi51Cq0p
         lLxt6ihMoeuWIanKvKvFhHMfQy4Ot4BTvwFvpc87grqQIbfuFoCLprA2Q42FL717UQMi
         4TKhKPaXQpY7EKwefMwD9FDdVmMrWPylQ2yRBJpZo5Er+qdAGuu2a92QfKQ4rKG73RfH
         28bQ==
X-Gm-Message-State: AOJu0YxGz06Z4nbfTSw8XOQBarV72ouUlxe6MJqgRMQOav3r6tK2w6oj
	6LR5K4rKa4uX3/F0E4XNhnhhco21DGzFKtBlTpp6Z4rTkduJidIvUK+0u+R883k3rJweWpoRGmY
	k9wQYDg8wbaf6iaBZyp6+02RNmNEV3PP0TnjGoiGAz2iwNyqmhEbxYAzRknzELY+w0qI3IBXyPX
	JZ9j2453rsAXAc2xc65wkKTOtWyI0nRrpWt74Ae8QYBDP43FItlIF2
X-Google-Smtp-Source: AGHT+IH8kYtLf02SMO4gT+wnuuiG+l3+kjrOx4JV535PPtexh5C0zJlj3z3C8FKthAMx7xT5JrWeTytJEg+/O04=
X-Received: from plly9.prod.google.com ([2002:a17:902:7c89:b0:24b:66a:7448])
 (user=zhichuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:fa7:b0:256:2b13:5f11 with SMTP id d9443c01a7336-28e9a645c5emr7160375ad.40.1759438163650;
 Thu, 02 Oct 2025 13:49:23 -0700 (PDT)
Date: Thu,  2 Oct 2025 20:49:20 +0000
In-Reply-To: <2025100207-writing-judgingly-6b2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025100207-writing-judgingly-6b2a@gregkh>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251002204920.3562443-1-zhichuang@google.com>
Subject: [PATCH v2] commit 6b080c4e815ceba3c08ffa980c858595c07e786a upstream
From: Zhichuang Sun <zhichuang@google.com>
To: stable@vger.kernel.org
Cc: Zhichuang Sun <zhichuang@google.com>, Nadav Amit <namit@vmware.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

iommu/amd: fix amd iotlb flush range in unmap

This was fixed in mainline in 6b080c4e815ceba3c08ffa980c858595c07e786a,
but we do not backport the full patch, only the part that changes IOTLB
flush range calculation(the bug fix part). The other part of the patch
is about API change and refactoring of the code to use the new API, which
are not required for the bug fix. Besides, the API change in AMD IOMMU
driver from map/unmap to map_pages/unmap_pages also has a dependency on
the IOMMU core driver's changes that is not included in 5.15.

This bug fix patch only applies to 5.15.y. For 5.10 LTS and earlier
LTS versions, they don't have selective IOTLB flush support, so this
patch does not apply. For 6.1 and later, they already have the fix
as part of the API change.

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

Note, the upstream commit aims at changing API from map/unmap_page() to
map/unmap_pages() and changed the gather range calculation along
with it. It accidentally fixed this bug in the mainline since 6.1 without
realizing there was a bug in the old range calculation.

Cc: Nadav Amit <namit@vmware.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Fixes: fc65d0acaf23 ("iommu/amd: Selective flush on unmap")
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



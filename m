Return-Path: <stable+bounces-189194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1E7C04476
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 05:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 575F14E6628
	for <lists+stable@lfdr.de>; Fri, 24 Oct 2025 03:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175A827280E;
	Fri, 24 Oct 2025 03:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyrt/D0z"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E9202960
	for <stable@vger.kernel.org>; Fri, 24 Oct 2025 03:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761277628; cv=none; b=cyVFa+r7WZwo6/KBUer9TNYzTGfwJ0p3qXxY+FQMynFgN+1kgguJ2dU61p92n9BXMm0YnLaDHoRmNgdKdWgxI5C7bBpV17R0KVEv4jft3tlMIFT24vWDn8pc+jl6gQqWlEtxHn0G1A9yV+z46UWQdkPEDG6YymIgSe70sczFiFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761277628; c=relaxed/simple;
	bh=9cWnLkrLXqaPsJRM99oxt4vPCd7XWVuiMbIdFRMWzT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mCFadjJxEpxq16UwktSi7SSAfrHDP2P+xUMv6ExjVSyWjtqE4Ch3xcz3VyqhEAkcQQGRBNTP3EAXmE29117yO+3vUtmPcpcqp/lPtFn+CU/r55Avz39yEu/kfGEWZTs9wLVcp7DmRf8i32CRq1iiJr780c+fIvdFGkPhW3Yzy9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyrt/D0z; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-430bf3b7608so16248835ab.3
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 20:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761277625; x=1761882425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTRPcVehq1ZOZm7xL/IWpW023usBfc4VwA4QLz9tUds=;
        b=fyrt/D0zKKYB9AptfigPT9jUudDFhTxLRm/s44slHYhf48evjWiZG/hsyH1pWiUeBB
         XrXer/sh/2uVAoUhVBD6B+Qb1DeoB9NEU1mkQg2h9EtGb/CzTJelN809Wb13SXOXy068
         LO+LmrXtvALpqff3aYIrVoxGYup2/MSqlWwokwqyRiJjfhsslCRt/yu1FtP02ujhVzTP
         0PKceafYEoSIxfI6BRp/5sioUMfyI48g/ReCOPYDduTf9kZ4j8xC66do3M6GW5WFuCpe
         v6cVIJiA8SPdozJLbr9RJottJFQBahM5zlSzRJQdZoq5IhtQUAycWpPlxaCaGFWKd9MS
         Avqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761277625; x=1761882425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTRPcVehq1ZOZm7xL/IWpW023usBfc4VwA4QLz9tUds=;
        b=DJo0+rm9g2rpY/nO4V3aVH9dGW/t1Xjaa1rXIXn70Ke38KIQr68udXcyG0AKIYd1Xt
         cA+Ve3u7UyqwASVIe2G4kbDuNqS5orJQT3VTx12SnwgIPrZ43T28hlkUKeilbh9NbnVQ
         KtYGu7i0BWodHXyi5oFol0uJzuLHb/guMvEQVIMiX6OLwtax69VNp2xgQ12G0sV0gswD
         eYrwfh7Dl2mUiLZZOCcZ4IsJpVmfLynQulkpzmCeVT3gZq2OoQWWq5QnaVtPXOon/fZc
         nTaaf0F+0Rhgzdjyt8j9jtV8xUz77+ZVFFNjeGU6ClmR8txVo9dEp26Q//qfHjLpYSDx
         nqQA==
X-Forwarded-Encrypted: i=1; AJvYcCWMMXOHb4iAcbOuuin/5H0SJXX7mMEpdRMFYT/D+LXQYruw8ikHtPrP0AM4wB1uY1/qDiu7RKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoXg0P4/8pL1Lb40ZVJKHlBkXmSZBGjF0Sja/EIhBc51DNnEEL
	o4GN09T1I8yMh4J43vP9yRaBqgNLBVn2MeL21RUvqg+G+7xlxaQl+iesLsG587UQFCo=
X-Gm-Gg: ASbGncuqsVtORlrHPzOxkhHkTe00BFJwfzwHE0o4ztmXwZTQH8esE3Ey9FBWni4ow55
	EOWEljvXmNNrGIEVpbF6TMaPtV+9xLwL/DtDZ5bcyZzxq/vYsZTs4jw94DwlTTZz7YJ1aIVJci3
	HYZEByn8tlWCNAN/Mn5PDsJvgXwyXytX0XnFOi9SVrPKYScjZYJUnXwzOH9GT63UfvwKrs3cgxg
	8qXA6khbbybnpzqt2XI5mLUoMA/Sj3D85XUqV8FBAdlggdDVSuT9dX+yOdCQ1wxvop21xJA5BSo
	dRPU6FdaVJ2wGkdorvoQppb6mCgBhYqj79NjTgBo1ppiUoRu8QpnvTfJsDwKrSNHG2XzXBfgrRo
	ze4f/yrGOlM2RR+BHCmp1BWdpBDPz3kzBgGCwsRNcbR7oh7yf91Xl05KIbI+8Cro2kAgargborU
	XlxjoQQnmlyblQRELbJ73FrAwo8uzNoC7SvF/k/EZCQhE7JtDhZa0jOmXaZ5W1xqBZW6MwmfIB9
	JAps0NN2yos5uk=
X-Google-Smtp-Source: AGHT+IF4nK0dDcEQMxrByQtKSDL+Vtp/h2LVbn+x1BPoCFDYFALAcbNWnpX4PRVrQ+b7Q3SGYy2kzQ==
X-Received: by 2002:a05:6e02:3e04:b0:430:c394:15a3 with SMTP id e9e14a558f8ab-430c528d628mr363410005ab.22.1761277625271;
        Thu, 23 Oct 2025 20:47:05 -0700 (PDT)
Received: from abc-virtual-machine.localdomain (c-76-150-86-52.hsd1.il.comcast.net. [76.150.86.52])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb4e4bbefsm1712310173.5.2025.10.23.20.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 20:47:04 -0700 (PDT)
From: Yuhao Jiang <danisjiang@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	David Airlie <airlied@redhat.com>
Cc: linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: [PATCH] agp/alpha: fix out-of-bounds write with negative pg_start
Date: Thu, 23 Oct 2025 22:47:01 -0500
Message-Id: <20251024034701.1673459-1-danisjiang@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code contains an out-of-bounds write vulnerability due to insufficient
bounds validation. Negative pg_start values and integer overflow in
pg_start+pg_count can bypass the existing bounds check.

For example, pg_start=-1 with page_count=1 produces a sum of 0, passing
the check `(pg_start + page_count) > num_entries`, but later writes to
ptes[-1]. Similarly, pg_start=LONG_MAX-5 with pg_count=10 overflows,
bypassing the check.

Fix by explicitly rejecting negative pg_start and detecting overflow in
alpha_core_agp_insert_memory, alpha_core_agp_remove_memory, iommu_release,
iommu_bind, and iommu_unbind.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Yuhao Jiang <danisjiang@gmail.com>
---
 arch/alpha/kernel/pci_iommu.c | 17 ++++++++++++++++-
 drivers/char/agp/alpha-agp.c  | 13 ++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/pci_iommu.c b/arch/alpha/kernel/pci_iommu.c
index dc91de50f906..b6293dc66d45 100644
--- a/arch/alpha/kernel/pci_iommu.c
+++ b/arch/alpha/kernel/pci_iommu.c
@@ -859,6 +859,11 @@ iommu_release(struct pci_iommu_arena *arena, long pg_start, long pg_count)
 
 	if (!arena) return -EINVAL;
 
+	if (pg_start < 0 || pg_start + pg_count > (arena->size >> PAGE_SHIFT))
+		return -EINVAL;
+	if (pg_start + pg_count < pg_start)
+		return -EINVAL;
+
 	ptes = arena->ptes;
 
 	/* Make sure they're all reserved first... */
@@ -879,7 +884,12 @@ iommu_bind(struct pci_iommu_arena *arena, long pg_start, long pg_count,
 	long i, j;
 
 	if (!arena) return -EINVAL;
-	
+
+	if (pg_start < 0 || pg_start + pg_count > (arena->size >> PAGE_SHIFT))
+		return -EINVAL;
+	if (pg_start + pg_count < pg_start)
+		return -EINVAL;
+
 	spin_lock_irqsave(&arena->lock, flags);
 
 	ptes = arena->ptes;
@@ -907,6 +917,11 @@ iommu_unbind(struct pci_iommu_arena *arena, long pg_start, long pg_count)
 
 	if (!arena) return -EINVAL;
 
+	if (pg_start < 0 || pg_start + pg_count > (arena->size >> PAGE_SHIFT))
+		return -EINVAL;
+	if (pg_start + pg_count < pg_start)
+		return -EINVAL;
+
 	p = arena->ptes + pg_start;
 	for(i = 0; i < pg_count; i++)
 		p[i] = IOMMU_RESERVED_PTE;
diff --git a/drivers/char/agp/alpha-agp.c b/drivers/char/agp/alpha-agp.c
index e1763ecb8111..e2ab959662f3 100644
--- a/drivers/char/agp/alpha-agp.c
+++ b/drivers/char/agp/alpha-agp.c
@@ -93,7 +93,9 @@ static int alpha_core_agp_insert_memory(struct agp_memory *mem, off_t pg_start,
 
 	temp = agp_bridge->current_size;
 	num_entries = A_SIZE_FIX(temp)->num_entries;
-	if ((pg_start + mem->page_count) > num_entries)
+	if (pg_start < 0 || (pg_start + mem->page_count) > num_entries)
+		return -EINVAL;
+	if ((pg_start + mem->page_count) < pg_start)
 		return -EINVAL;
 
 	status = agp->ops->bind(agp, pg_start, mem);
@@ -107,8 +109,17 @@ static int alpha_core_agp_remove_memory(struct agp_memory *mem, off_t pg_start,
 					int type)
 {
 	alpha_agp_info *agp = agp_bridge->dev_private_data;
+	int num_entries;
+	void *temp;
 	int status;
 
+	temp = agp_bridge->current_size;
+	num_entries = A_SIZE_FIX(temp)->num_entries;
+	if (pg_start < 0 || (pg_start + mem->page_count) > num_entries)
+		return -EINVAL;
+	if ((pg_start + mem->page_count) < pg_start)
+		return -EINVAL;
+
 	status = agp->ops->unbind(agp, pg_start, mem);
 	alpha_core_agp_tlbflush(mem);
 	return status;
-- 
2.34.1



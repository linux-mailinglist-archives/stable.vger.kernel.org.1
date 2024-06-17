Return-Path: <stable+bounces-52555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB3E90B37B
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 17:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6AC1C23742
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3848152E0C;
	Mon, 17 Jun 2024 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEcJ86rO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09312152DF2
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 14:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634214; cv=none; b=J/knN78aqqR3WHgMflKe1Iz7xwmc2Jj1zsarSIT6btJzphWISBCqJ7AQKm6HHx4EdxEU3ochDbb76Goh2AEs/hv5V+Rl524QGF2eaosPrQcn67l1uZYCr3pgzTuHHI3E2W2Lm0+7aY3A6HoyZrDmVQOZf76h/Fw8Z8FRwvlpSGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634214; c=relaxed/simple;
	bh=staLYeh6sfJMkaGQcAoJxQQ0y3DnWYEOnJDu3voNeS8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ajeb7liaNPC5H57WFVM0b/RvUmEnMVoSdxWN8ohbvOiT+yOtZ1/rSfpeHdtzb4ChYPGbjXXhSfN6Wcx1X/N/XA+Y4oWlaREWiygo/uhJ4uvitA2bji9C1mHSkJkacsSkr9blrlShBZ8iORnLriVUGbUzphtFHLI092lBkYYqQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEcJ86rO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f6daf644b0so2881335ad.2
        for <stable@vger.kernel.org>; Mon, 17 Jun 2024 07:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718634212; x=1719239012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjAKmjOFGJRfvw9CAjB0+KWutIirXHkEdrsHPUSxkcM=;
        b=AEcJ86rOMEqPlzyh3sfsvsDw03DTOlWTim3WtnsWx6MABUD0P13UmGJSMd+9d8pW78
         h7f36bTKaTnBjnZEHhk4QtwF7dgCVF65nfEajUiXl8TcCbmZL4WPRwC/dAy6kRhG1JVE
         GC978R4piwe6VO/vGC20HtVYa5QFnRD9DILT1/7ZJixxPkM6jY/UCiJ4TQ6MAkPkKyqj
         JcTmnD3bWazHjJQiBvSFmIKKuyFEwMrDI76rc7vBjndcl7d1wXsq7owoN9vTZ0PkRlD9
         4tI7BxnzO/zjb6BsabcQVQayqypdICXIvkccYRBR42SU7XU11iUirMy/Y/RN6V8Tumul
         SqgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718634212; x=1719239012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gjAKmjOFGJRfvw9CAjB0+KWutIirXHkEdrsHPUSxkcM=;
        b=omBb7dnF2EdfpyJJERerQ0gBu/CglELvpx6L9Q43o0abUgR0zxr4gzsMosDhPLL3+V
         JeDuTqNlpnoTjnVWdnfD3TvXUGVb6E0G9K9iRnX9jclML3/POVX2znZyUhDE5gHexjCR
         qRuViUEgV1miPIH72rVX7J8cG5t3kUC4CvNlcrDU7WlrkXGf5HYqxXxCU1l3ITD3JAq5
         F/JTivlWHlqFOnBp6nXP92G4EgiHhh5SkeriHKKKwhNocuMIxyXHaCz56Aragek61tHH
         Wb39XtqBBHHhPwJqmnCQTyyVVJihAzIlCvCXMSml+g2ZRtBrNR57PfEkhll5PyhHEaU+
         9S9g==
X-Gm-Message-State: AOJu0Ywwl9aOl+GgZrQJLQuFaRldRXXUyDYZlVCsv4O1rGeoksUMFZCt
	VjVy8Zqjn3CIDQK8ttT4m4TXoyuAVFujUqQxgL8oYED3fUQmdM+r8nwb/A==
X-Google-Smtp-Source: AGHT+IHsBcbh8ZSXnnqRJo2jYERRCbWGWwLvhhwXzro9J/ozEGzfJ4vN8JPyeMZoEcwg3UIQUESN9w==
X-Received: by 2002:a17:903:1246:b0:1f2:ffbc:7156 with SMTP id d9443c01a7336-1f8625c6f31mr112648635ad.1.1718634211600;
        Mon, 17 Jun 2024 07:23:31 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:774f:1c4c:a7d2:bccd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55e82sm79645965ad.22.2024.06.17.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:23:31 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: stable@vger.kernel.org
Cc: will@kernel.org,
	mhklinux@outlook.com,
	petr.tesarik1@huawei-partners.com,
	nicolinc@nvidia.com,
	hch@lst.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/3] swiotlb: Enforce page alignment in swiotlb_alloc()
Date: Mon, 17 Jun 2024 11:23:13 -0300
Message-Id: <20240617142315.2656683-2-festevam@gmail.com>
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

From: Will Deacon <will@kernel.org>

commit 823353b7cf0ea9dfb09f5181d5fb2825d727200b upstream.

When allocating pages from a restricted DMA pool in swiotlb_alloc(),
the buffer address is blindly converted to a 'struct page *' that is
returned to the caller. In the unlikely event of an allocation bug,
page-unaligned addresses are not detected and slots can silently be
double-allocated.

Add a simple check of the buffer alignment in swiotlb_alloc() to make
debugging a little easier if something has gone wonky.

Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Will Deacon <will@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 kernel/dma/swiotlb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index a7d5fb473b32..4c10700c61d2 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -1627,6 +1627,12 @@ struct page *swiotlb_alloc(struct device *dev, size_t size)
 		return NULL;
 
 	tlb_addr = slot_addr(pool->start, index);
+	if (unlikely(!PAGE_ALIGNED(tlb_addr))) {
+		dev_WARN_ONCE(dev, 1, "Cannot allocate pages from non page-aligned swiotlb addr 0x%pa.\n",
+			      &tlb_addr);
+		swiotlb_release_slots(dev, tlb_addr);
+		return NULL;
+	}
 
 	return pfn_to_page(PFN_DOWN(tlb_addr));
 }
-- 
2.34.1



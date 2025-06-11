Return-Path: <stable+bounces-152414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E96AD54FB
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 14:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5E33189E2C5
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 12:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B78281358;
	Wed, 11 Jun 2025 12:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewnsTF+f"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AA1280313
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643630; cv=none; b=pyDoUqcJYk1hikD4CsCJjrPXLa2150bmn+Ga7LFPwGywmJD1h600wocklq5+9V/kCEcckQAQLwQ/xAnGCV9tPj/Qh2GLMGy0GZnNGiSIdZvDq31Wrj9JH+1DPBGSFhZtn2F3Loo5Lll++c0e7beE5tbdXPN1zLDEPyvtxBSr83E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643630; c=relaxed/simple;
	bh=zKTs78RTRTqS5HP35DRDL4Y0b0mNW3Gu1tDXt0akX1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIaT+HwwkBWcg398ANhwhLDH/mcYZj7LaFbni7yU3VGEekQwSn/xnI6ac1G23AWOvmkt8proex5GeZrao2CDllru2ccgTrpmZJiAcEfh9JxDrN8VRY5d/SgAbqSIIrtF2ZFHcvBbJIa2nDHDGpds5gko3y3Z0xPwrhDVeVh0nSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ewnsTF+f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749643627;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+PENtkLUfBH1Z8n7k4h6Ysph6sI1iUW3ZV5Hjz4OJ3o=;
	b=ewnsTF+fOPuF+FkMAAXUCe02YYWuOoe/3KQyYryx/4Ie0WV+Y8KXUdCYlCeAzuxAsyk/TV
	j9oXUs+LWJ4ehu9OoLnZcTMXnvGfi8rLXK7LDIraGPRS/lTMtn6+fg3BjHXiF72dPaIiv3
	+C8vbHTqvJbBadEH5KgHNXFup2knekc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-dE3-odVjPjKIjweixAQwSQ-1; Wed, 11 Jun 2025 08:07:05 -0400
X-MC-Unique: dE3-odVjPjKIjweixAQwSQ-1
X-Mimecast-MFC-AGG-ID: dE3-odVjPjKIjweixAQwSQ_1749643625
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c791987cf6so1211837785a.0
        for <stable@vger.kernel.org>; Wed, 11 Jun 2025 05:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749643625; x=1750248425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+PENtkLUfBH1Z8n7k4h6Ysph6sI1iUW3ZV5Hjz4OJ3o=;
        b=iNV4eKs42d+OcG/KtxVQZ85skEElUTnUYVhQNTUpWPRZ/pXB5T/IFlLyrf58saO5GP
         pTruCqvy0SgPHUGZLNUA5xUSdxJsXT6SD/Aynt3DLVgspnHkUlZroLsHZEDo4/yDp0v4
         Zg8boJb1dAfHyaqfs611sTXF7P8iXLGxXKT/In3IPzHB0DZgLkpJFsYhqbh4vmFZd6u3
         NMMu4oOdWuqPg4+0LyQu/nqr7ooCZKnPtgWz+tiOwlr1WkV5Qk+fkOypiqapA6gctAIl
         FVH0+PlylhWldX09KYRhr4v+RUx0k1p5vQxCYvCqcIR4Uwu2eqT4PJi2KKU+53C0N5d8
         +MQw==
X-Forwarded-Encrypted: i=1; AJvYcCWWy7GTM98Ksb/Js7PIrI5J5wyL23m5OHU9fY5F96tJdC6I6Cl2XIkAblqZOurgDMULPLjRMSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdx4nzYG/XXdaBlG2vcBuyULCbMnBcrll14pNZEBAz6XMlofIv
	CtEBie89ENlUMy5VzaXbX7fCw3k6w7vykgfAKS+UaLIOFcrcThcbWRASnh27beFSRKCCgABE3Sd
	x3JGTE6Kvir8akfPaz4G3UCBZqjHWVCmHcnuyXA4l218xm1hJ3KpVY2o+dA==
X-Gm-Gg: ASbGncunTodKLYHW4Hwx29SREraPiJyaE8ToSwnABkGqAPNK50p2EDa1Eye3Q1x60G4
	89s9as79+PvsPiF7UmbeUFMgeriw2TXXSmqP6e3CBxztC8sTupOikePOpRyLG0Smx79gzwDtiYl
	+Q9Y3yp9gFhxvDEHqo/Pn1Wmn6dX/5XhCpkwI3sBgskOFFcFQfTLb270/8x3wcFSPhI8O3kv24S
	olWDVrtC877nbTk9Y3Ij8g4i/slC2/u6KeE1xZTJnRgrtzMgx0xafRpVi4LubCFwTqnjsJRCPmh
	5JbMTgWr37/EKc5gCz+K3KD/U6b64QJnZaa9+ApddQ==
X-Received: by 2002:a05:620a:3194:b0:7d0:9ffd:422f with SMTP id af79cd13be357-7d3a89b1b3bmr505263985a.54.1749643625087;
        Wed, 11 Jun 2025 05:07:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJLjpZ1uY3+YpiReTBDNjkNaFYo7+UKPSqXzU9BVywxK8ty0bHeAi1vwl8x6v5Oh4c1OLQSA==
X-Received: by 2002:a05:620a:3194:b0:7d0:9ffd:422f with SMTP id af79cd13be357-7d3a89b1b3bmr505257485a.54.1749643624636;
        Wed, 11 Jun 2025 05:07:04 -0700 (PDT)
Received: from localhost (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d25a60c183sm847676485a.58.2025.06.11.05.07.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:07:04 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alistair Popple <apopple@nvidia.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Oscar Salvador <osalvador@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] mm/huge_memory: don't ignore queried cachemode in vmf_insert_pfn_pud()
Date: Wed, 11 Jun 2025 14:06:52 +0200
Message-ID: <20250611120654.545963-2-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611120654.545963-1-david@redhat.com>
References: <20250611120654.545963-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We setup the cache mode but ... don't forward the updated pgprot to
insert_pfn_pud().

Only a problem on x86-64 PAT when mapping PFNs using PUDs that
require a special cachemode.

Fix it by using the proper pgprot where the cachemode was setup.

Identified by code inspection.

Fixes: 7b806d229ef1 ("mm: remove vmf_insert_pfn_xxx_prot() for huge page-table entries")
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d3e66136e41a3..49b98082c5401 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1516,10 +1516,9 @@ static pud_t maybe_pud_mkwrite(pud_t pud, struct vm_area_struct *vma)
 }
 
 static void insert_pfn_pud(struct vm_area_struct *vma, unsigned long addr,
-		pud_t *pud, pfn_t pfn, bool write)
+		pud_t *pud, pfn_t pfn, pgprot_t prot, bool write)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	pgprot_t prot = vma->vm_page_prot;
 	pud_t entry;
 
 	if (!pud_none(*pud)) {
@@ -1581,7 +1580,7 @@ vm_fault_t vmf_insert_pfn_pud(struct vm_fault *vmf, pfn_t pfn, bool write)
 	pfnmap_setup_cachemode_pfn(pfn_t_to_pfn(pfn), &pgprot);
 
 	ptl = pud_lock(vma->vm_mm, vmf->pud);
-	insert_pfn_pud(vma, addr, vmf->pud, pfn, write);
+	insert_pfn_pud(vma, addr, vmf->pud, pfn, pgprot, write);
 	spin_unlock(ptl);
 
 	return VM_FAULT_NOPAGE;
@@ -1625,7 +1624,7 @@ vm_fault_t vmf_insert_folio_pud(struct vm_fault *vmf, struct folio *folio,
 		add_mm_counter(mm, mm_counter_file(folio), HPAGE_PUD_NR);
 	}
 	insert_pfn_pud(vma, addr, vmf->pud, pfn_to_pfn_t(folio_pfn(folio)),
-		write);
+		       vma->vm_page_prot, write);
 	spin_unlock(ptl);
 
 	return VM_FAULT_NOPAGE;
-- 
2.49.0



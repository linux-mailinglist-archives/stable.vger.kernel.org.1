Return-Path: <stable+bounces-152613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03414AD87C3
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 11:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C5797A9AA4
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 09:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71D22C1592;
	Fri, 13 Jun 2025 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NvXeGSJb"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5789291C0E
	for <stable@vger.kernel.org>; Fri, 13 Jun 2025 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806833; cv=none; b=Z3SwQXN9ghJtmXchdaVSXmr8yWqxw4VzkS8Fn4T/V1OfbH/o4kAO3E6ZLckd1ByGOu9w1yb6zn+33dyuAHLP7r+TFqPkb/YzVD2Bk1cOELu9jcVG0DhGkq57/yyzVK/026zwdmj5m/nACsaimqrWyZ4nH5L8g2EbpF9LWMWJM4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806833; c=relaxed/simple;
	bh=j64RqC0yW0IWSRsztwobsHrNoaRlkxqGA0a2OxsS0xI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrCeK9mGITM6xuqcz0MtoRktS0+At6zWuMWqVwryQ3Eqd3uPZazkOicRmK0MVf5uUAozLSnw74y5bvr7uhm4h9FVlgqK+PfMJD+gx3pFXbFGqGP9/zBKDWpRqrH7QOOp4uqtU02rR6MTSUioTeHyuHJb4294FYhyhKxN8FWRpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NvXeGSJb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749806831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BuuwdyX0QESH0B5VKvKy/eQpha6SfRiQdyfEZdmDLAI=;
	b=NvXeGSJbe340SJqmLk7wulFQDdhgufDgBSgHCYcLGVK6VmUOUJOM8hjnojPLBqEkdjyUHX
	OWL8VYTIsSnjhuhhIOp0Qlse6KZiw53HKNFyBOweyamCYze71Rj9eRKJTO4czH35/PSnh2
	mvrShqTmkyNnxz6m11B6z9Vg2JGuLZc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-EQxwIf0oMzKIULL8wG5C9w-1; Fri, 13 Jun 2025 05:27:07 -0400
X-MC-Unique: EQxwIf0oMzKIULL8wG5C9w-1
X-Mimecast-MFC-AGG-ID: EQxwIf0oMzKIULL8wG5C9w_1749806826
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450cb8f8b1bso4602435e9.3
        for <stable@vger.kernel.org>; Fri, 13 Jun 2025 02:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749806826; x=1750411626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BuuwdyX0QESH0B5VKvKy/eQpha6SfRiQdyfEZdmDLAI=;
        b=VgVb8Xfjxg+ftogSEYb6YBOM5RQ+oni4Q/e3+LwarPPwF/a3xcfPAHfu4UqI89dQlO
         OCMTP5iCoUzn2XXF1ZDWpBu/fKRm+GqCqU1Fa96z+zoOIuFoZB1YfZP6+IUYaDuyQq5K
         /omV+KQyGtyvrTW+qTXX5XHGb4uG3IGxGZRpLXMXLdRdNReIhoL3mlPMf6Pe9avAaeu+
         KWI1ZGjYbLm52ew0lDx3nxfidq5cDkRuZRYziDPDSyObgzSy2Nhwn455lJrE5FnNM44Q
         rWHc57MfOhNXgnLEpbMCSIN2jz0SlVXwB5yXOS6Qm0THjq5QyJgluHxpignBp7D/puje
         c1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWOyG0rEycsXERbcEkb3MIx5xlfk0x0KyEQ0IukTy0pe1UgI1Q6yg/tSqSF+CLIiW6MXraEih0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwApXgERL7Sd9DDdueqsVoLC5aRu06AO908Lm7ONuYhPzH3AjIV
	WUf55GOFnsv3xKFqxWfAabfCJUWEe3D0o2oKRo9KL4d0KxxXJklLUPdiGjwB9kQsvbcKP1w5Hdx
	4+FDJXBm38pvIHGQhx5DPX7HNKPMKtLIG9fBnmMjMBdCg4lqoozJ/4UNVuA==
X-Gm-Gg: ASbGncuj0gZfXvkTY34LuDPqye+CF0ETUvcQDaH+Ws+Fs+XExq+PVesgf9tExo2Vjyc
	ye5/Vc6oOQAwgrLgg+9U8zEeJYxAln3peAg4RvcQrhkpMGupUX+CoIPPOtQCYJ+mcamN9tVqV4y
	6vIwA5n7wqVfaqDUJRc9HJyakVf+ghsixi/umJbS+vVBtrG4n8yYkOEwgXXOJMaFBzXSDQw1Mhr
	sN3aX8/nO6IDkaz6tA+kn8v4HIGi1Wk75ghwXD894bSbTAclZPKVSpfs7TeTF4KCx7auoO0VI7Y
	8XKjoJeQ7lnOaTV5zML5CM33yEK31X8gnVCb3yeeA6Cg2I1MHqFthGLOIQVrhfSWpE5DpaQ8+s8
	IAf9rw8g=
X-Received: by 2002:a05:600c:8b44:b0:440:61eb:2ce5 with SMTP id 5b1f17b1804b1-45334ad836amr23540695e9.17.1749806826446;
        Fri, 13 Jun 2025 02:27:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFP4hRMlxC0kkYbbJprcfwWEfFpKdqbkbnkLg58Cogqr6OsnbV5xlaTNzlLDv0FGfkKMNYSyQ==
X-Received: by 2002:a05:600c:8b44:b0:440:61eb:2ce5 with SMTP id 5b1f17b1804b1-45334ad836amr23540385e9.17.1749806826108;
        Fri, 13 Jun 2025 02:27:06 -0700 (PDT)
Received: from localhost (p200300d82f1a37002982b5f7a04e4cb4.dip0.t-ipconnect.de. [2003:d8:2f1a:3700:2982:b5f7:a04e:4cb4])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4532e24420csm45559825e9.20.2025.06.13.02.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 02:27:05 -0700 (PDT)
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
	Jason Gunthorpe <jgg@nvidia.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/3] mm/huge_memory: don't ignore queried cachemode in vmf_insert_pfn_pud()
Date: Fri, 13 Jun 2025 11:27:00 +0200
Message-ID: <20250613092702.1943533-2-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613092702.1943533-1-david@redhat.com>
References: <20250613092702.1943533-1-david@redhat.com>
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

It is unclear in which configurations we would get the cachemode wrong:
through vfio seems possible. Getting cachemodes wrong is usually ... bad.
As the fix is easy, let's backport it to stable.

Identified by code inspection.

Fixes: 7b806d229ef1 ("mm: remove vmf_insert_pfn_xxx_prot() for huge page-table entries")
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
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



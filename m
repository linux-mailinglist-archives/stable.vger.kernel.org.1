Return-Path: <stable+bounces-241163-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yO/vB43a7WnIoAAAu9opvQ
	(envelope-from <stable+bounces-241163-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:27:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DA219469448
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3016130039AA
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 09:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFAA344DAA;
	Sun, 26 Apr 2026 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ClSoy0D4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489B5345751
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195651; cv=none; b=EhdHwXQjKck1tw1qB6ThqwMiNJpiZ7cuIjdqWr7uHzJkYUXNaQTcmhLG0xOp3Uv7ESkubpTlUOWKrR1Xiej8UvmDZlUiCbLcVVl2Tc5gIUJbkXQftyMqNIyuS/swbFiOg7bBIg1/4waa1Vwwcn5f10P3RQYU6VtxwsQphX1MGrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195651; c=relaxed/simple;
	bh=qTrK7sGxk9cj5ND2z4IoB1RRjTFuoKl+iErfAtNDycI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gFxZlrWghkRFsRriYxZlPdAdKmEH18V79ldxLr7HZttwVdEjMttr4+eBuEnDOm5zbdEiCSJmYxrnKpWs+IbQ18ZSOYFCnIpBzgJwEfNdvdamxQOJLuZzdwpEaBRu6jD7jUmnxrYlNQhY+HLOL4fEpv2fgDrPE2xoa1IjpFlDIF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ClSoy0D4; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad9a9be502so57647715ad.0
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 02:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777195650; x=1777800450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoquneTBQ8S9NM0KYy8UH3zDqZYMfaQ5136cWznpdGc=;
        b=ClSoy0D4jenxkFLpRU3XF7dpySadpYx9CcHSMUh+xoWey7IiAWH7ZNqdmSS91Xa0Ez
         Dtyh6rWLJ6xeN+x2HM6Eun1fhfhZYwq2HLOgdvkBodEjhMKXfZuxx+vrlGW9U660QnBM
         rAqMyFi+NWgkxv7vptQYS5RbBJA4PQIwtNnbTSog8wjlb9FBHlfE6eFrnrh8xaorPXnt
         NBTb7nIRVh2OkNZcfv/jIGoLu3Uw+80bA4IFgeoLw8W+2CuZm0yIHn2UTJbd3mVJW74a
         T5wLNPHdVLau9XLfM0igrDbXKc1tbA80KTHzEU1Hz5ngl8bs3jtBXBNIfhHKqHmaTw1t
         7u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195650; x=1777800450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CoquneTBQ8S9NM0KYy8UH3zDqZYMfaQ5136cWznpdGc=;
        b=OVuC1s8FkhDWJFZJf9/NF1sD6L0Rr2WIqcMeLT6wGf1bJ5s95k3fMP+Z7WJUdycRXV
         m8E5II5RTU4s+lr1LLi0FQOrvuD+3Ap/St5qqIrOq7O/Wxa4ID35DgnCNMtKMEJJ2k9M
         XocW0+eHaMvI4zkzUlVGuQfg2QxP4W5wm9g4lyaOCw63bO6M42Ul6s5lO4O8S+rHGjt3
         vQSy9Qm2nY8AiL4IhPb2hOQJCc+kBucDjuD1pVnncO/6BPo7zoes1INO8m4kaW86TMTy
         AYL+oNEosHP3M2K4sp4s+sb9mKegYL1sE6VHOdcNUQ5BL7Pk9tNaNQYHApkNTEq4gY4R
         CflA==
X-Forwarded-Encrypted: i=1; AFNElJ8dRyttZbz3C42g/LZYKDHDaabRotZESa/OSuVpOphoeTDUV2j3zOOIzThyaCbAsvl27SzQ+ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzThdM4IRrch2q5oE7gQ63DNF1lukgDOpIzTRP8AAK6fxML689A
	LfOfudttHsaBw8pVbVHiOnlCU5FdWQ6TQIIKo2iclkdUPqQ7yVbvu5FpH8vSrnKmX/w=
X-Gm-Gg: AeBDietIh4E8zIAx49aIx3XEVptiw/2cKyNcGCO7+ezfrQSKBUpZL4ydgepP0U3l3ca
	QP2ie+njWYqI3L7Hod5pHq3YPse/emMOSf8XIn0Z5aCbjHdGukXOgOsmAFlzttwOe0z1n9pQuAK
	qskSAEzm8QPYvfUjIDK3cMVi7OsBt2ykKIHAvESjd3V0NsxpOFL0lA6vQYOMS3g7kTZEavwElAW
	x78zRU8/IsZs17ObhAnSQEnyPFHnPld7AzcmAVAPrP8K4012m55sigCc6z45O0xJasYhKuqTeBa
	4KEY7jK0iKcTSSmxNFPMuh7qennB8Td2JLvYuoOkLPkXVdz2RiKIXqg7ucAgmF/0+8VC+3ieBCL
	Kgo1p3y0JjP7FXxrhVeg5xtoaJvlZbnlGpvAW4twOKtHOzmj3JVAG3FmmnAmBsWI1raCp5vfmJQ
	3D1yfmqpvvkkHyOi+d37P0N9HFWmrK
X-Received: by 2002:a17:902:e746:b0:2b0:5a4c:7263 with SMTP id d9443c01a7336-2b5f9ef646amr454625165ad.18.1777195649505;
        Sun, 26 Apr 2026 02:27:29 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm270352885ad.40.2026.04.26.02.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:27:29 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	aneesh.kumar@linux.ibm.com,
	joao.m.martins@oracle.com,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 4/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
Date: Sun, 26 Apr 2026 17:26:38 +0800
Message-Id: <20260426092640.375967-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260426092640.375967-1-songmuchun@bytedance.com>
References: <20260426092640.375967-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DA219469448
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,google.com,suse.com,gmail.com,linux.ibm.com,kvack.org,lists.ozlabs.org,vger.kernel.org,bytedance.com];
	TAGGED_FROM(0.00)[bounces-241163-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid,suse.de:email]

When vmemmap optimization is enabled for DAX, the nr_memmap_pages
counter in /proc/vmstat is incorrect. The current code always accounts
for the full, non-optimized vmemmap size, but vmemmap optimization
reduces the actual number of vmemmap pages by reusing tail pages. This
causes the system to overcount vmemmap usage, leading to inaccurate
page statistics in /proc/vmstat.

Fix this by introducing section_nr_vmemmap_pages(), which returns the exact
vmemmap page count for a given pfn range based on whether optimization
is in effect.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
v6 -> v7:
- Refine the alignment assertions in section_nr_vmemmap_pages().
---
 mm/sparse-vmemmap.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3340f6d30b01..01f448607bad 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -652,6 +652,31 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	}
 }
 
+static int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+{
+	const unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
+	const unsigned long pages_per_compound = 1UL << order;
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SUBSECTION));
+
+	if (!vmemmap_can_optimize(altmap, pgmap))
+		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
+
+	if (order < PFN_SECTION_SHIFT) {
+		VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, pages_per_compound));
+		return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
+	}
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages, PAGES_PER_SECTION));
+	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
+
+	if (IS_ALIGNED(pfn, pages_per_compound))
+		return VMEMMAP_RESERVE_NR;
+
+	return 0;
+}
+
 static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
@@ -659,7 +684,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 
 	return page;
 }
@@ -670,7 +695,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -678,9 +703,10 @@ static void free_map_bootmem(struct page *memmap)
 {
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
+	unsigned long pfn = page_to_pfn(memmap);
 
-	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
-						  PAGE_SIZE)));
+	memmap_boot_pages_add(-section_nr_vmemmap_pages(pfn, PAGES_PER_SECTION,
+							NULL, NULL));
 	vmemmap_free(start, end, NULL);
 }
 
-- 
2.20.1



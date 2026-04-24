Return-Path: <stable+bounces-240553-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +DY9NPzd6mkNFAAAu9opvQ
	(envelope-from <stable+bounces-240553-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 05:05:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF694594A2
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 05:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D439F301BF53
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 02:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DB031326A;
	Fri, 24 Apr 2026 02:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="LEMnwZbK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458C314B66
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776999388; cv=none; b=RvMfdCYwoYqj0wVIm+rbpcFhWGv7WDJMq3nxtMvxvgqxWc0yL0Aqhe7OQdwRwJzYt76uHZxMTfjKnTWGgaQ5p4p80z+761C/A7LemsBf7ziX2wdZRX4Tx3F4OZJ539Uat/2/3Ek66nK8D9HapeQxhvGz7/Gzdt/kOOLFVrSRvLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776999388; c=relaxed/simple;
	bh=HT5HO5ge7v5LFgL/4ymoxiP5/EbwXc4rA7DseyRJ/CM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d4pXergl1ZKElQoTJBZ1+qT08ctAvub+mQKBKM97h6mzbE3rA2mlWMm21qK6cPJLV3RTcR8uBs7FTuI+L+TGRSD+1KDTe2DnSGqb2IIVSaDsZypQTBd6W9fUMKrLYdglkOZ5vOno1T/+hRJhKC42KCmt/jnce5gesFVY08piQEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=LEMnwZbK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso34587535ad.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 19:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776999377; x=1777604177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C94hv/3Q9yeZJL9WguueLZ0Nxmqh1CO+hZjQa23mqmc=;
        b=LEMnwZbKF9H0RwaBZjEXXUIdLpODVMTtXBAYvYMQK4Tt1OkjfWonlOyJZqcQzz+Lhz
         8ufwYEOpNGnBcoUfcYZs+vnEkCFPDacgyexHFo3g3QIhn2krglQP74PECC+3nv/40X+4
         K1ZUwj13CRPBYNKkuIJbDkXlluWePeEGpWZyhWcXybNUX2rTm8PROlrzM3QYwdaEPyLf
         MSk0DSU/x7mqTG39aUVJrkhHxF7vuzZu6rhCBvLMrwDsJE7gol2E1NDMurSynQgXRkgw
         nsZQ3Koz8fZPu7BCrZY3Lu6NPIWwAqGY/ZR5qc2giVT+WZPgfE2ZguUydDgpqWyYFlLQ
         jJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999377; x=1777604177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C94hv/3Q9yeZJL9WguueLZ0Nxmqh1CO+hZjQa23mqmc=;
        b=BV8blchdWLOPRkwZQTrZd7o/h6bfKQfBz6e2Vd9p3kLIK9XjmjF/ZDo6qDE4CbvpMw
         3NXB4RAAaabGNgpE5ULAlfZD05yRB3AVc02z3Miej0iaJ3Ms+OjFaFeMFghtrsyXXi3Y
         aRgECUVJ9QGJg4mVtWYVq9vDQPaT0I682qjXWT1lfpiZ5AJr/euLJ/ME6xq5V7vK3fOO
         PSbdbXWP55zU2oL85c/lct9+xDuTF5ABJtFBjUkXuttu+hsDPLvmvf5PpMTDn3Lrtg5a
         YnvgKQoTorNF4ETa3MtfKfVmJplp4+fFm/pwqwc4Nsu+zxIoFWxhmT2B0vBIJRVRTyhh
         aAgw==
X-Forwarded-Encrypted: i=1; AFNElJ8psi7tSXH+oDAetZQLGb741e7dHOjqwpS5IhbDx0gvlJsvmveoGsfgPgkWa0B3xmZe9ViL2+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YygGSTWliCdB2sIXNFEp6UwOpkgKW2RDCL04YgrDVaL7Bhwj1dr
	1qKafzou+TGoyyFN61IDD6BLo11aVajm4rME/xT56A52CGUSDxIieXgIDjEIz7RRGmo=
X-Gm-Gg: AeBDievlaoyw7jm4zNQ0Alm4RftbnaXKil4/ow3VQ4ezgT1zdRpDviREg7D22ICF+z8
	oR64TeneYvCQUg/r4wxo5nmtRWXWSyOmB9ao6LN6ocGWPhGS0k9UL/ZmBQ1fZOiUOAG1sBCh6yC
	Inon8J9/NCX6qQaSuywBukzCsssJzHoxUXoRFf3+3+2fEb8HId/XTrYmVhhnyOlpNU6bTtesxR6
	P8pRNJ4TvbcYs61r+p83n6cus5w6YQwXPB37RLqTuknAbvEt3q+SGNDFBUOw1ItkEvoe1Qh5VZV
	uyDWAOrtXhEeXcK8+B4E1416G25mR9lQ6EMwDHQhDag0GjTW4OUgix1L5OOI4lStnxM8ntIVueE
	wnkYXZjIMBtNfe7+eybbBSWfg9KtsWuOsgEmTG7qER3yIQcYLaqZ5olzuusjXzueR2ew7/kfSpn
	/lEgtkrRayMxpYtprXjQbf6k3fzRx21r6dVtX3FybDss6VjIgvxo6kofc=
X-Received: by 2002:a17:903:28f:b0:2b4:5309:2c14 with SMTP id d9443c01a7336-2b5f9f3ad64mr324239485ad.31.1776999376914;
        Thu, 23 Apr 2026 19:56:16 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm221668325ad.63.2026.04.23.19.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:56:16 -0700 (PDT)
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
Subject: [PATCH v6 4/7] mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
Date: Fri, 24 Apr 2026 10:55:44 +0800
Message-Id: <20260424025547.3806072-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260424025547.3806072-1-songmuchun@bytedance.com>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3DF694594A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,google.com,suse.com,gmail.com,linux.ibm.com,kvack.org,lists.ozlabs.org,vger.kernel.org,bytedance.com];
	TAGGED_FROM(0.00)[bounces-240553-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid]

When vmemmap optimization is enabled for DAX, the nr_memmap_pages
counter in /proc/vmstat is incorrect. The current code always accounts
for the full, non-optimized vmemmap size, but vmemmap optimization
reduces the actual number of vmemmap pages by reusing tail pages. This
causes the system to overcount vmemmap usage, leading to inaccurate
page statistics in /proc/vmstat.

Fix this by introducing section_vmemmap_pages(), which returns the exact
vmemmap page count for a given pfn range based on whether optimization
is in effect.

Fixes: 15995a352474 ("mm: report per-page metadata information")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
---
 mm/sparse-vmemmap.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3340f6d30b01..2e642c5ff3f2 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -652,6 +652,28 @@ void offline_mem_sections(unsigned long start_pfn, unsigned long end_pfn)
 	}
 }
 
+static int __meminit section_nr_vmemmap_pages(unsigned long pfn, unsigned long nr_pages,
+		struct vmem_altmap *altmap, struct dev_pagemap *pgmap)
+{
+	const unsigned int order = pgmap ? pgmap->vmemmap_shift : 0;
+	const unsigned long pages_per_compound = 1UL << order;
+
+	VM_WARN_ON_ONCE(!IS_ALIGNED(pfn | nr_pages,
+				    min(pages_per_compound, PAGES_PER_SECTION)));
+	VM_WARN_ON_ONCE(pfn_to_section_nr(pfn) != pfn_to_section_nr(pfn + nr_pages - 1));
+
+	if (!vmemmap_can_optimize(altmap, pgmap))
+		return DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE);
+
+	if (order < PFN_SECTION_SHIFT)
+		return VMEMMAP_RESERVE_NR * nr_pages / pages_per_compound;
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
@@ -659,7 +681,7 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
 						      pgmap);
 
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+	memmap_pages_add(section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 
 	return page;
 }
@@ -670,7 +692,7 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
-	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+	memmap_pages_add(-section_nr_vmemmap_pages(pfn, nr_pages, altmap, pgmap));
 	vmemmap_free(start, end, altmap);
 }
 
@@ -678,9 +700,10 @@ static void free_map_bootmem(struct page *memmap)
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



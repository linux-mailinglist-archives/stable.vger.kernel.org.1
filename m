Return-Path: <stable+bounces-241161-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOH3JX/a7WnIoAAAu9opvQ
	(envelope-from <stable+bounces-241161-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:27:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 37207469432
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C0AA93012BC2
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 09:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B68A3218BA;
	Sun, 26 Apr 2026 09:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zd6m3n52"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C55542AA6
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195632; cv=none; b=NL6WFHtbDQgcZQwPsAbl4QCeLeaghn2zTIm7P0yaYxZJF6XzQ4nnqy7lWJjKc9Bm+hmElfgRlitpMY5C4LVsj5UJ7KSdRVH+c1eme/OmyWM3MoAXJ3pOzM84+1KIxwPmsFSSIdnX0AGL9vutjK69/mSVvlAr4UkF59UNnn2fnZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195632; c=relaxed/simple;
	bh=0PLb5zFObm442FFPCMDt2iC8dud5KQqM0ijr0fGCJws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ctpXyuhRS1WL2kAKdMGTWmZ4dsg9unKC41ci3Ka6MRuc6BqYwfcLCIZtRDvfpcWraVw3DkkZU+02eD362+o2Tqx6ssvROY8LlPcSQ4fk1XG8iYsnNJ5225vrcB9GEDcYp8goV4BUBxtfSPPzeEGYDTIRdjjrqorsen6TiIcWlS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Zd6m3n52; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad617d5b80so53916965ad.1
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777195630; x=1777800430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
        b=Zd6m3n52Hy0maXKER73IjA/PFZidCrhgVUoUuwR61TFPmrVI1DzQLeWAQyhexd4hHe
         jltRbKVLQbLrVkkqTSQhdXqR4cJ1l4BI4DoOVpKja3swYjwP1jS0QD64pidg7jZj9oo0
         LOS84UmfaRQOIfrMsF90ZUaKGPI5CTmeCKoXYmIAaFhXXocZEQr1c0tG5xvvlsyulFPc
         5SRDid09LbAVTJG9uO36VgB36IOyAXdkEJ4ujw19yCBOrE2HmcKmsdaJe1Vpt1EukAr1
         g0EpXh/uLCNnYBsDRrMJN2chcK45esV5j4Jydi6J+WPgHxnwXxXqw2lW9NDLpegHeS/c
         CXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195630; x=1777800430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
        b=ATPrGOQCN1dzmxvi8qy9g+SEvZiDP4VyFgkZvW6JD3L9VeElO+rfuz0vGB6oASXt8k
         U9xkDNErVG+vtQMYLP+A3pNLibVloDcM1Tr9A9ur5RWKnJqwV5HNdPshl5OOKC6pk04+
         B1rt8smecQs8aZQnFap7Ydl9VPrHF00VtdZ4vfKOJXct9FyFaM1jmrXz9W8SUEd4jrJo
         MEhUCW5chrevVSWuYoJybP4QK7mq6ZO4ORqkB0iwE02prNxfPbQlcLx+hjVvXpCNz0F+
         z48J6zob1jzfM97VWAO+YSsPYwp2WKxS/C4SOYVbP36JlItvAnKnr63GLxGe1MFR/7VG
         xdlg==
X-Forwarded-Encrypted: i=1; AFNElJ+93ig5xq6dNrN6+9lRVdYEg3fy54cETJLL1Xn68iCb20nJbuS/sQQchktk9R+eVVxFNJJj6bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ7ZJdof/DLSUNcvIUwWCdr2iw/fwzLF7H2vyjW3PaUCtAwCQw
	NA1FmF2ZXEmH5210YWzGtoy+FteCJqYL/u74KkfJijIOlj7RMeyTlWBcxd0/lJ0/2zQ=
X-Gm-Gg: AeBDietxIOrOLl6ctewDD/J2HPzHL1r+ZBqKq3IreKCI4Pi1jioRklO6bSYmpiQSHh1
	DfcnLINm6pMr3+vBU9RxF0TvfPvkpVRAKG14c4V4C/YOxGOUNKUsb/V551M7QBBjX5yni9/llEU
	fpRb0JpQYvngAGlLM7aHcoDhUNFydV6siX1sr4CoEZS29F00eQppeOO6KBOi96tO03O6Ac1B8v4
	BLDkGAOvvP7Lefaorz38FmZMkSTZ/FW9bUyqvI8ZfU+3GRZFtLXJDy+DpaY8ROCgSDSRsFZ/SPk
	IjTvMYlqF/61r/FbmA3FMZ8mgxrm9WPjDFOrGA/X1B/7Xavzd0MWKhD2u35K41riY7Vw160zx0Q
	nRTGokIN8tPUkPUPXj1h26m8Vh1F6OTZajH+ATXg0RHK5Xhc9ZxGF8j1rj6D1hExwQ8uylOX+ep
	CUGBH4URNJBOyheY+AA/bhrjhczakX
X-Received: by 2002:a17:902:cf0f:b0:2b7:a1ff:b239 with SMTP id d9443c01a7336-2b7a1ffb4b5mr144455245ad.14.1777195630176;
        Sun, 26 Apr 2026 02:27:10 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm270352885ad.40.2026.04.26.02.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:27:09 -0700 (PDT)
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
Subject: [PATCH v7 1/6] mm/sparse-vmemmap: Fix vmemmap accounting underflow
Date: Sun, 26 Apr 2026 17:26:35 +0800
Message-Id: <20260426092640.375967-2-songmuchun@bytedance.com>
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
X-Rspamd-Queue-Id: 37207469432
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,google.com,suse.com,gmail.com,linux.ibm.com,kvack.org,lists.ozlabs.org,vger.kernel.org,bytedance.com];
	TAGGED_FROM(0.00)[bounces-241161-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:dkim,bytedance.com:mid,suse.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

In section_activate(), if populate_section_memmap() fails, the error
handling path calls section_deactivate() to roll back the state. This
causes a vmemmap accounting imbalance.

Since commit c3576889d87b ("mm: fix accounting of memmap pages"),
memmap pages are accounted for only after populate_section_memmap()
succeeds. However, the failure path unconditionally calls
section_deactivate(), which decreases the vmemmap count. Consequently,
a failure in populate_section_memmap() leads to an accounting underflow,
incorrectly reducing the system's tracked vmemmap usage.

Fix this more thoroughly by moving all accounting calls into the lower
level functions that actually perform the vmemmap allocation and freeing:

  - populate_section_memmap() accounts for newly allocated vmemmap pages
  - depopulate_section_memmap() unaccounts when vmemmap is freed

This ensures proper accounting in all code paths, including error
handling and early section cases.

Fixes: c3576889d87b ("mm: fix accounting of memmap pages")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/sparse-vmemmap.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 6eadb9d116e4..a7b11248b989 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -656,7 +656,12 @@ static struct page * __meminit populate_section_memmap(unsigned long pfn,
 		unsigned long nr_pages, int nid, struct vmem_altmap *altmap,
 		struct dev_pagemap *pgmap)
 {
-	return __populate_section_memmap(pfn, nr_pages, nid, altmap, pgmap);
+	struct page *page = __populate_section_memmap(pfn, nr_pages, nid, altmap,
+						      pgmap);
+
+	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
+
+	return page;
 }
 
 static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
@@ -665,13 +670,17 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
 	unsigned long start = (unsigned long) pfn_to_page(pfn);
 	unsigned long end = start + nr_pages * sizeof(struct page);
 
+	memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
 	vmemmap_free(start, end, altmap);
 }
+
 static void free_map_bootmem(struct page *memmap)
 {
 	unsigned long start = (unsigned long)memmap;
 	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
 
+	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
+						  PAGE_SIZE)));
 	vmemmap_free(start, end, NULL);
 }
 
@@ -774,14 +783,10 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
 	 * The memmap of early sections is always fully populated. See
 	 * section_activate() and pfn_valid() .
 	 */
-	if (!section_is_early) {
-		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
+	if (!section_is_early)
 		depopulate_section_memmap(pfn, nr_pages, altmap);
-	} else if (memmap) {
-		memmap_boot_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page),
-							  PAGE_SIZE)));
+	else if (memmap)
 		free_map_bootmem(memmap);
-	}
 
 	if (empty)
 		ms->section_mem_map = (unsigned long)NULL;
@@ -826,7 +831,6 @@ static struct page * __meminit section_activate(int nid, unsigned long pfn,
 		section_deactivate(pfn, nr_pages, altmap);
 		return ERR_PTR(-ENOMEM);
 	}
-	memmap_pages_add(DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE));
 
 	return memmap;
 }
-- 
2.20.1



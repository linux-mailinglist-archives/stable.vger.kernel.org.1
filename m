Return-Path: <stable+bounces-241493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOzpLFtv8GmgTQEAu9opvQ
	(envelope-from <stable+bounces-241493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:27:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A77480057
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDF5030ECE93
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AF83D5229;
	Tue, 28 Apr 2026 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Xcv6nuLZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57DE3D34AA
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364367; cv=none; b=RvQ9LGFozA234OjT6dWfeWmxhl4ExprwQbosoVVBptYjcFRoHk8Ycs4m5BPZyJhdJ1ru5n09z96jA1HuMH8ut7/HXGPgbe0j3T08rcizRfB2Th6Q6wQ4SjZ/STBg8Q6LVp4kp5y/wufyXWzqHG3GWwsUk2d28L6Wc7p2bUYgtfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364367; c=relaxed/simple;
	bh=C4xXtEXsz0ixhX8JiretKLDxPoi22KeWMdBYVODC6is=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VRE+cutVXNeOiOB3np9sYh1ZwyEjZHKB39NsXJ3X+aZUVewh6QOG5SrN+wH/x12p++LpO7Gm+ho5ZiQrTUoYT8NyCdU4aYgOBzo7ztULO0fbOfo9l5YPBTPs3/Q5zQxzPeFVqE81P9xO/n6cb2Qe+9GdcRRqLr6XpPnzy+qcXDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Xcv6nuLZ; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso8526971a91.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777364365; x=1777969165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL183+C/B0Npg+SiHlF1+/ufB8oZmfwNupE6AmX40Ic=;
        b=Xcv6nuLZbW6bEKophNnpsam4Jk5GgH8DfF2UZvjY1c2UsFrqRHPpsxBRYWSezuy+ME
         EKAlKINuZu/ABcAk8XuGI90py0qfbpHS+4VVrqOD6AGjKnV3e6UGYklTYsBgN7qCsCKF
         M3MTDZ1Jj7o34O7BMBeCRJZvGOEhN+ESzRLi8L+coVbUPgtG1BJpmd6y/bNuTVaowKS8
         LTOO21n6fmRn3m60ttJX+oIqGTSELvJmcRfRdDhpNdsBo8CBmCQoZ++mgRXMjmqTGSZJ
         24pjfGz7nbjWqLccYn0RVUMdW2xssX/FcSeM8jkQ9cxty9g10JjtgqRDeJ2HDWORS0DX
         lZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364365; x=1777969165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rL183+C/B0Npg+SiHlF1+/ufB8oZmfwNupE6AmX40Ic=;
        b=VrjR95XEEesqEi1xW2l3cCwYDbgXMz27yQQKcM9pT4H59yFmF5ASKSb0ls3LsVKqmi
         sDyhF88X21xfte3dLgN4g0cnAi/2ybKlWuxyMbbg8FN0iMjD1Iq7lVdILVhl5X7uGYhJ
         GRW8AExMjArNsI+0tGVixEqq5RoLvXNwU3JL3hKkihI+p3ewdJNMWCXnAuarrZUf2NhJ
         Zsh+Pl4HfLiXt23uCle5/rQFztBNOzG4bW4z4eb8R6ScypwJ47LsYLhc8VQdcTQFMhT/
         ls6Pbrjduh390Gz0q5xr+GGsSPxG7wjTMIPtwRqfs3E4M8g+nxq1cHRy8drOWY5WhI5E
         NG7w==
X-Forwarded-Encrypted: i=1; AFNElJ8IWyeyyePY1Vrje79AyjcdmwElBiDJYtP8ehHY4JWFs4qCqF2aLgDJBOCs99sv/TUUmnUdif4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Mk61Z2hu+05Hs0Vy228njLOw8UB/tlzdn06rmEYhBG4AbRZr
	ujTMAkzkABMuM4NAQbxZpDEzSflER83bK25tSNENMORKAFPweP8yNb/JXHOldBFG8eY=
X-Gm-Gg: AeBDieu0pMR6bV+P+ZohpwN/D3brTIHLgqLXK6i4k1hFhofIPShJ6FRpxb7oDU38dnx
	uY5r88k8PRAePAbL+kHYu3KjYov6ehD8NKSV2mPwiJ/R+8Cm4g9CuqqU/+WM7NAOXf/rQcELJ+C
	0qpNCmF1prMmUEA74q91uOxEQ/epAn88j0meJAc6e/xlLoRv+zcWzvaRQgE9seYWYaAGco9gU0c
	UzdOaw/zR6xCBx/H8rbQeq4J0jz84KI9fLcvQKcG9DAClLloRijMNCZ6NoTXAj0UoLdTJaO9+xm
	9TlIGefn2zhxMKRwjDFJRGqhkLBare7DyJU9HTWjagoHJshfZ3G42L2JziWGCUWsJZDF0z+ZfZV
	lncKfLLEwKOiGoA+wk3A0IxLbTGesb2XzwH1ZpR9T6TR17zeJ1SGD0UKePCBLQMv2qRTm0MXHiy
	ki50ISFtEGTLVYjmUaynvEo5wIE3KX6ThlsmtlTHeoW+EOH6dxsg0JOe+fYfj0BA684w==
X-Received: by 2002:a17:90b:56cf:b0:35b:96bb:47ba with SMTP id 98e67ed59e1d1-364921a915dmr2295268a91.26.1777364364837;
        Tue, 28 Apr 2026 01:19:24 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649003650esm2181356a91.8.2026.04.28.01.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:19:24 -0700 (PDT)
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
Subject: [PATCH v8 4/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting with optimization
Date: Tue, 28 Apr 2026 16:18:53 +0800
Message-Id: <20260428081855.1249045-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260428081855.1249045-1-songmuchun@bytedance.com>
References: <20260428081855.1249045-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 36A77480057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,google.com,suse.com,gmail.com,linux.ibm.com,kvack.org,lists.ozlabs.org,vger.kernel.org,bytedance.com];
	TAGGED_FROM(0.00)[bounces-241493-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid]

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
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v7-v8:
- Move VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION); to the top of
  section_nr_vmemmap_pages().
- Add Acked-by from David.
---
 mm/sparse-vmemmap.c | 34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 3340f6d30b01..932082296e8d 100644
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
+	VM_WARN_ON_ONCE(nr_pages > PAGES_PER_SECTION);
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



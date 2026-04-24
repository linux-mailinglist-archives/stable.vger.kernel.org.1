Return-Path: <stable+bounces-240551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPVcKe3b6mmYEwAAu9opvQ
	(envelope-from <stable+bounces-240551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 04:56:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F024145934F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 04:56:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED2513009E08
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 02:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF39630BBAE;
	Fri, 24 Apr 2026 02:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ZUrANlLM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8495309EE6
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776999366; cv=none; b=LZbCh9t99RWv9oSN6JSp6wl8jrOW9FWrkeB7eYbV1SjM4tcIBEJrzbN8NvZdNZZjnKuLHOLHTCsq/oWkrLIO3pu0cdS1+DoIpgHoXljDyAI+dJn3gUIQvZZ3ivjbqyhSA5Sosf7S2nWCvwyFe5tjV3neBDnAm8FoioFbPv7b6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776999366; c=relaxed/simple;
	bh=0PLb5zFObm442FFPCMDt2iC8dud5KQqM0ijr0fGCJws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QkEBkU4kKKDH79P9j7bt5y7XjXiBIB2ZonfM6qtmP2VxtKhKXC4DmlzppYNYRUySxnwwq87ZGvG0tfnT4TnWaTe3AfMw3LHnGlu+yr6gmM2HbmkSowJfzhj3pQh5QAVPmzZps6s61awBzX6tYyBaj8O0EDfQsprLA/afcftmMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ZUrANlLM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aaed195901so32170345ad.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776999361; x=1777604161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
        b=ZUrANlLMBT/AyRnVQ48+VdkEbwpMv/2u4poJ+38nBrbesIY81ENYJXinPXy2OLgL30
         PIgJSAFeJnKAUsTxB/LZj5uwHdM2Q9BR0/vPhXCLGZUWFSJ6STw5dAhqkscwjdHm6IrY
         I7FfaqSfkESuJQsXEiewzQT+VPgpYTO8Wz6shajYfw/BqKHLloG3lyTs8+deS5S67ddZ
         M0Yj1Fpy4w02CuBx1IisanUt7LLEDMhVDgOgDuCQulQtmKnflIYN0YBmBB9ao2bDQ5yg
         jaIOXbloVdi7wE177wMBJA5PgsSu45uch9HSn0xBAaZsIIn3xptoNvsT4fHshq7qXIsV
         DaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999361; x=1777604161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
        b=E0eLwE+5axsr+5hRYVSpdww+fnVG/2F7z22CkAuVU3RvAlUUFX3lmRRLg+PxsDuy/o
         FYq2ZsKr6qHaRGBEilrG8xpTyddWbtQycLg9JKzkkCYlHepl65G0a4ZhMrWFypfI0pFX
         uYIk8nhSa4WunotjiQL5yYiovCLcwfhbe1N7GZ0AaWQHBIynVCRnVu5shI6dizz6OXf7
         lRHOBa1hUuZDpsOyrBqsuur7bLQSTXAMrGPBwTVHnncmJt/he0ahysb+CuHrVP0h8uV6
         8e3/Ex6W9V5ebI4eeVX05xsiGSh5WnicqdHSmN1YqcAaxxtu7cZJiq7aMDFClpIeTo/d
         61JQ==
X-Forwarded-Encrypted: i=1; AFNElJ/cZQXnVr1d0KKeRAni5O4W8jjVn3vScZiAy2idSvoE3QB1w0zKZLnGFf1SGfhr/Mu6n+ZPocY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmwHDxbgeGVwAC37yD85J25KZbq3q5iwEB5GXyydNWypggUTbq
	sf662inIkqDy4FcLm68VVZdIFnYQm1I3nYpeRToVcQI4uhY9YZEo/PmaoUuO9KDP3Mo=
X-Gm-Gg: AeBDieuTI1o5PDmkiC+NVmwIfMf+lAXhPhuzM6VcIP7WI/OG2tDN9KENQce6W7z809U
	J7j3oPyXZgxPPb65DrLZHrjjPngu90c2h1m2gnC1I6bKa8+7Ts+zpvAljYhdNa2bg2LNmGXwZy/
	LlR/JhVbdZZuO3fXfnezvps4UeMf+pVSyWycQh/fGDlc4UskcUSflRBYrV2AdF7W6d5pjkyF5El
	/UedpnsLlG37qKUlLmYHXNDXL7Ug5YAuJKcZgzZiLLedAWOM/Re9o4/Zx5MTF88pxAU/n0OBbYe
	eTMazUgnvKV3SZTSTUSg/lJ1Qu1llEuXUNKCuifzfvCgYRxXpr1X2pLlAiF8wSPkdn2gqflJLh5
	x3CrAMiUUslz1OT/gdgUWeWZFLh1enL+gauBaEr2ygTFgPGXhRNSmwlGBczBIdv+lyYav71toIt
	0CG+YghREKpusqj2xZUzxypw9sYCNhuwQ1vX3vlat0633i6kdz6e1Qncc=
X-Received: by 2002:a17:903:1b03:b0:2ae:ac0c:5a2a with SMTP id d9443c01a7336-2b5f9e7a9a0mr309495685ad.6.1776999361448;
        Thu, 23 Apr 2026 19:56:01 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm221668325ad.63.2026.04.23.19.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:56:01 -0700 (PDT)
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
Subject: [PATCH v6 1/7] mm/sparse-vmemmap: Fix vmemmap accounting underflow
Date: Fri, 24 Apr 2026 10:55:41 +0800
Message-Id: <20260424025547.3806072-2-songmuchun@bytedance.com>
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
X-Rspamd-Queue-Id: F024145934F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,google.com,suse.com,gmail.com,linux.ibm.com,kvack.org,lists.ozlabs.org,vger.kernel.org,bytedance.com];
	TAGGED_FROM(0.00)[bounces-240551-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[songmuchun@bytedance.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:dkim,bytedance.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,suse.de:email]

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



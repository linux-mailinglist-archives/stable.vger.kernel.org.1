Return-Path: <stable+bounces-240555-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF6oFnPd6mmYEwAAu9opvQ
	(envelope-from <stable+bounces-240555-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 05:03:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A916A459446
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 05:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59FCC3035A8C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 02:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855E6319860;
	Fri, 24 Apr 2026 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ga8y5FCN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8D43126D0
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776999395; cv=none; b=aQjUspXw0E+qe7JcFW4PBmudf36N4Seo1lcCdyL8TASjSJtQu1q/Er62vcp2ZxWhpsSF0WJpsH83P1ph1xMqnrhOHAP7axa1FOBMFxE/zkdbz/UzXvM9WI/BwEWqikb9SHVm4QCtFDf90lWcSxlgg/cAekVqHDyEbW4IPmelfJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776999395; c=relaxed/simple;
	bh=yaDJsF6niQhRHztNmySVX7QcIen1LwiglGYRWBKHNss=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eTK4P4py8fKLhNxiEIZrfJiF3MFs4C1Dk/tgzK2MrmLQmp/HQxYm7zTslH8mW0u/odzuBRASzk0Hqj8Aaui78dN3IGr+UGbcIGrZFm824oKvXTQ8EpmskaIl+Z5CrB6tHC8vvw0OVShQabHpDD8rE4KVJAeAzZ6wlPaM//+VdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ga8y5FCN; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab46931cf1so58196295ad.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 19:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776999387; x=1777604187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gorQ8nwUKwQQqSP5JrI9Qb+od9YHCs59YbEIcdvGJzM=;
        b=ga8y5FCNuRCGn8QRo7KBGR5G6SZ4Y8zbMbdtXzKuYpSJUHfdTZYOBmy0ZitUOg2fRC
         nb5nR9o5kqCHNRaIS7GSQNYtTikgogtoRfbVdUsAegQVIBokiQNsp6ddjLpx5pjeeO2Q
         JO76EiQ0JG3ZR86fFZE3cdoVd+S6sfHtDF49PfMiADoyPFhwfUknVFmoGHtdnUZMONBO
         wwU84iuY8wt9zcR4yWxxBF+nvfMWi/2FuNehnNwNR09rZWVVHKNs8UlgYO1mG0RR5HXV
         5NIsCPUK+6gsHNGFeAz4fDOMi2tNBt97sBR383VTNbuyHWfjE5F1sbKTn6qKy7QB4qsh
         Ds5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999387; x=1777604187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gorQ8nwUKwQQqSP5JrI9Qb+od9YHCs59YbEIcdvGJzM=;
        b=QCMoMq6JA5WE/P0HLilFPXAjTzVPsUGpDW1g2kiwB8j0DkQ+gVepQrxq0KGyIaAlVA
         LotesIwL3HwA/6UiErqCP1sG3cLRgcuelLBSWSYECOooIOY5XGecov0ypJbN/rED2+r5
         L0sUYl8PY9CdcTomseHGIVjaLR+kG1tEy1aryoq6DKduGtGHpfu7jZhMVpvKMCb9q20B
         4VQVJJYWcyM4YYc/YmH24DoLHTqI5t42q80Ii0lwZGeZ6X3AQJYRrWmJSz1EUpMKfDPl
         I9DOpb5bHKaVOicNFrw1kIt52rSqZDu1n5p2MQDjmT1G+bcxy2kXxPZm4wm9fNZVABtM
         p5PQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9K8ipSESCXJS4UlQUWla1gh2y5ir+XyJGgvf0k/vJCTSnrFi0kAFpMe0u7nEWAI304Rk8PIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhGTTIdmiNeNNsXHJq+XHSKjTROoU4ucx0FmWlF9fCJ2wiIc6
	znyQYnImIxMNBKRzsdM3olCtFn3bKlWhl6bvYdQe61u0xfKbprqxgphyzhvtA8fQVy8=
X-Gm-Gg: AeBDieu/jFyzlyszF/GXpYaxIbgexY8uOpcdT3zbFSL0Fq/X1wqTEtw6AaiEaB26QpG
	pYjUHdbxT2/aeV5v+9WEAOQsezuvG1wJ1aoCtCf+RVYSVNWJRrlRL50pcOXsO57dw5rG7NGNmbw
	up4bg7Myu5pG+2mBynY/gQ2DOfc/XJLeEyMNykxI0hH/puSWuzkKUINg4BrKf0BGNWHzXr/6q8k
	Q4NdWk9la4IX7hzAiy2KWmBYDhudWteedmEU6YalZn5A/pIRMXCB40kTYmt95CfCM4FzSTQI1rg
	gVL14QLHC4WIy7yHjNHOiXWU/9iRiRsT/YPfxCJ74wElnXA4uZ/R7dXPodRBlEnOp5UvTYFmqps
	7YjDN835aAHvYScYJsrW0SWoxzAT9lktVjEIrGYvnWrXvFB/Jz1zBAa0IXijhS7pNNP5QWIDZOr
	y7HnIHu+UrfZ/XTCjMmM8Pc4z3kWVEgLLpedIax2gaUSp2m/7tjiHO/kI1PQDvj+D2lQ==
X-Received: by 2002:a17:902:e748:b0:2b4:5d0c:7a85 with SMTP id d9443c01a7336-2b5f9dbcd42mr277705665ad.3.1776999387049;
        Thu, 23 Apr 2026 19:56:27 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm221668325ad.63.2026.04.23.19.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:56:26 -0700 (PDT)
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
Subject: [PATCH v6 6/7] mm/mm_init: Fix uninitialized struct pages for ZONE_DEVICE
Date: Fri, 24 Apr 2026 10:55:46 +0800
Message-Id: <20260424025547.3806072-7-songmuchun@bytedance.com>
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
X-Rspamd-Queue-Id: A916A459446
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
	TAGGED_FROM(0.00)[bounces-240555-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid]

If DAX memory is hotplugged into an unoccupied subsection of an early
section, section_activate() reuses the unoptimized boot memmap.
However, compound_nr_pages() still assumes that vmemmap optimization is
in effect and initializes only the reduced number of struct pages. As a
result, the remaining tail struct pages are left uninitialized, which
can later lead to unexpected behavior or crashes.

Fix this by treating early sections as unoptimized when calculating how
many struct pages to initialize.

Fixes: 6fd3620b3428 ("mm/page_alloc: reuse tail struct pages for compound devmaps")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mm_init.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index cfc76953e249..bd466a3c10c8 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1055,10 +1055,17 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
  * of how the sparse_vmemmap internals handle compound pages in the lack
  * of an altmap. See vmemmap_populate_compound_pages().
  */
-static inline unsigned long compound_nr_pages(struct vmem_altmap *altmap,
+static inline unsigned long compound_nr_pages(unsigned long pfn,
+					      struct vmem_altmap *altmap,
 					      struct dev_pagemap *pgmap)
 {
-	if (!vmemmap_can_optimize(altmap, pgmap))
+	/*
+	 * If DAX memory is hot-plugged into an unoccupied subsection
+	 * of an early section, the unoptimized boot memmap is reused.
+	 * See section_activate().
+	 */
+	if (early_section(__pfn_to_section(pfn)) ||
+	    !vmemmap_can_optimize(altmap, pgmap))
 		return pgmap_vmemmap_nr(pgmap);
 
 	return VMEMMAP_RESERVE_NR * (PAGE_SIZE / sizeof(struct page));
@@ -1128,7 +1135,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 			continue;
 
 		memmap_init_compound(page, pfn, zone_idx, nid, pgmap,
-				     compound_nr_pages(altmap, pgmap));
+				     compound_nr_pages(pfn, altmap, pgmap));
 	}
 
 	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
-- 
2.20.1



Return-Path: <stable+bounces-241494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPL3KPlt8GmgTQEAu9opvQ
	(envelope-from <stable+bounces-241494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:21:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9847FE5E
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9BEB3016490
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0B63D523C;
	Tue, 28 Apr 2026 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UuoZxxdF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1160D3D1CB1
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364373; cv=none; b=AtqtljJeM9ZbjUjcr/yPEe6aaV7wjf23iZIw7Cp8HEBYAn/J02UBr/0vTcN85u1iy+UCgC8N+F4EH9hEYqyUDpGQMHiGQqZd0tIUENEwWI/GgWlOyc5TWUOIEFKtKNSEqRJLrJBoyfL4eDN43VpW3d+xlpthFxQBoJjOr0Rytks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364373; c=relaxed/simple;
	bh=I09DVnwUmT2FgjMlL1sbr+fqXGO2fhcK42PNEcwA7S4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exiBKioClsiPhd+WGPEBPRSntGbZL2iWL1xWnUZpnunzhLRNomoJjyllLGJNXmqoxM5TeqjqzapZb+pKt71XkiRy4dotE/DL2SWDR4hYUW+Iax/ZdRJxzHj7YWAPene/GvLm5cx/PRi74K1txq88BSHXytXg4oh0+r38Quv5KnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UuoZxxdF; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so7391535a91.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777364371; x=1777969171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
        b=UuoZxxdFvqi3tYk964lJaaEa0q2ohWRuPhcP8tD9feMemxnE/tk+hCn6pqCwHNcZVZ
         B8Z8b1gA6bHZDCtZOA1nJFI8VWTm74l7xFcWHRGdThwvDKWp9JqMDdb5ctlLjmejxH5y
         f1lwlqqmjfam8mF5cG4iuYjpljZWkp8hwggPt1ZDEuxM25slrjRiG7PVYZ9hVONJkMT6
         3vOgnw535O9xKwfilVUEY1Fx6BU4fEZKNYf9AMQjKRQqKlrryYeVvO+tRz5cHs/1sYly
         YtmvbagFyei+bKEPydR7d/ubr/LhU31xTWJnN3MzZaePbiwWXS/1uD9KLnYLq0wB7X0M
         7MIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364371; x=1777969171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
        b=eIqbmzOu2F81NqOpaI9OpgKg/PFV0hExc+BoGihsLV3csS7cjjl2qVQWQ7ma1t8AWH
         Lk9rw1Fu/15ULY5WcfAn30QMmWrToTJGWkvUrQmP+91mzrgXH1Ly0pXPLHbbfXq3e3cL
         1q0fd4xsbdcWTfLO1jjaMgjG2+B3wB6mbJHGLywoSXH3GGsvdbma8dZQ8RfLyT6BOE9u
         uoncZWzj6PvQwlndxlE3BCqvC1UrVLEuIHVVTJ1ww3Y2axIxFYy4z/UcS2sEfYEs6O4L
         VwrOChv+4HrVo3mhwszxbGnw3EOrBsqqnu+tWIyi7mj9mzraIJ7DCwbOzmuOr6LRiWJr
         8W9Q==
X-Forwarded-Encrypted: i=1; AFNElJ8zeJnqnPABZNHOJRKM7N+PYASCbAvPl6L5fsE7g5Db98alIax0vaMFfwie9/MlYvNhVxufnCc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSqZtI0m9/DGaseWc75MfZWTp9VU0GmqZy7OdmmklrfpGLvetw
	aodaya4e/whda3H/UzQv/dYyRAaIWwVs4WNX5RWw2o2Ia/jYlQe2g+UatPT1KWSyzOQ=
X-Gm-Gg: AeBDietlDMOxy/fz8Vh6W4nMLysWyePbOiIz9xB7fOQbZsDyQdvIyprQJHz/aCTAr9L
	N6nbjax1d3wMjCyfi+hD6f/SiwL2C+m2jzyxriyEOumHOd0TnT0ElfYBuW4HbQAhO2xEqQ2BOQi
	b0kE/G5a4759GHzyo3nPZCG4cNeedyuQiDy5q/E4RT7s9eBryC2J+mTHAdEwVLOJbWecXti2oZL
	srIVcRn7uW5NPatuQGk/RqErD6DqRtN3MkdYj2qApFR+bf3fWA6p3ftMIFaMXpzO6MV5850JL6n
	k6mEg72EQg3lZ7AANZOP6hcKGXJF8sRUcd5DoI5h+BG1zI4POSxYrx6xHRw6nNQtXayCQHDXwlU
	IV0zNk60wIkBaFuwMyHMfa+LQX4CYdvZN8gxQIWbxezjTNtCsFyS+aO2p1NfljiAXtgT/r5rq6N
	lKiSQqC58wx9AckI2aarLvnYrKtVnD5m+rfutbHnX/tprFmXtg0BhkI20=
X-Received: by 2002:a17:90b:17c1:b0:35d:a3b4:2ef6 with SMTP id 98e67ed59e1d1-364920601f9mr2483211a91.21.1777364371205;
        Tue, 28 Apr 2026 01:19:31 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649003650esm2181356a91.8.2026.04.28.01.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:19:30 -0700 (PDT)
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
Subject: [PATCH v8 5/6] mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
Date: Tue, 28 Apr 2026 16:18:54 +0800
Message-Id: <20260428081855.1249045-6-songmuchun@bytedance.com>
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
X-Rspamd-Queue-Id: 15E9847FE5E
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
	TAGGED_FROM(0.00)[bounces-241494-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid]

The memmap_init_zone_device() function only initializes the migratetype
of the first pageblock of a compound page. If the compound page size
exceeds pageblock_nr_pages (e.g., 1GB hugepages with 2MB pageblocks),
subsequent pageblocks in the compound page remain uninitialized.

Move the migratetype initialization out of __init_zone_device_page()
and into a separate pageblock_migratetype_init_range() function. This
iterates over the entire PFN range of the memory, ensuring that all
pageblocks are correctly initialized.

Also remove the stale confusing comment about MEMINIT_HOTPLUG above
the migratetype setting since it is an obsolete relic from commit
966cf44f637e ("mm: defer ZONE_DEVICE page initialization to the point
where we init pgmap") and no longer makes sense here.

Fixes: c4386bd8ee3a ("mm/memremap: add ZONE_DEVICE support for compound pages")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mm_init.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index f9f8e1af921c..cfc76953e249 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -674,6 +674,20 @@ static inline void fixup_hashdist(void)
 static inline void fixup_hashdist(void) {}
 #endif /* CONFIG_NUMA */
 
+#ifdef CONFIG_ZONE_DEVICE
+static __meminit void pageblock_migratetype_init_range(unsigned long pfn,
+		unsigned long nr_pages, int migratetype)
+{
+	const unsigned long end = pfn + nr_pages;
+
+	for (pfn = pageblock_align(pfn); pfn < end; pfn += pageblock_nr_pages) {
+		init_pageblock_migratetype(pfn_to_page(pfn), migratetype, false);
+		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+			cond_resched();
+	}
+}
+#endif
+
 /*
  * Initialize a reserved page unconditionally, finding its zone first.
  */
@@ -1011,21 +1025,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	page_folio(page)->pgmap = pgmap;
 	page->zone_device_data = NULL;
 
-	/*
-	 * Mark the block movable so that blocks are reserved for
-	 * movable at startup. This will force kernel allocations
-	 * to reserve their blocks rather than leaking throughout
-	 * the address space during boot when many long-lived
-	 * kernel allocations are made.
-	 *
-	 * Please note that MEMINIT_HOTPLUG path doesn't clear memmap
-	 * because this is done early in section_activate()
-	 */
-	if (pageblock_aligned(pfn)) {
-		init_pageblock_migratetype(page, MIGRATE_MOVABLE, false);
-		cond_resched();
-	}
-
 	/*
 	 * ZONE_DEVICE pages other than MEMORY_TYPE_GENERIC are released
 	 * directly to the driver page allocator which will set the page count
@@ -1122,6 +1121,9 @@ void __ref memmap_init_zone_device(struct zone *zone,
 
 		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
 
+		if (IS_ALIGNED(pfn, PAGES_PER_SECTION))
+			cond_resched();
+
 		if (pfns_per_compound == 1)
 			continue;
 
@@ -1129,6 +1131,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 				     compound_nr_pages(altmap, pgmap));
 	}
 
+	pageblock_migratetype_init_range(start_pfn, nr_pages, MIGRATE_MOVABLE);
+
 	pr_debug("%s initialised %lu pages in %ums\n", __func__,
 		nr_pages, jiffies_to_msecs(jiffies - start));
 }
-- 
2.20.1



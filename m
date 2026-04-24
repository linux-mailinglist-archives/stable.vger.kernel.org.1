Return-Path: <stable+bounces-240554-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMaDKovc6mmYEwAAu9opvQ
	(envelope-from <stable+bounces-240554-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 04:59:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D63ED4593D3
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 04:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE4413015535
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 02:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9493030E84E;
	Fri, 24 Apr 2026 02:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Jhf7yVAj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22B2F1FC9
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 02:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776999391; cv=none; b=lqs5utWy2SkGZvFz7ABUdTxurirSOf2uFzFdgKBIwlYyIydxoy5og8hSRFNmS6tSppt0k6FUp8uy7YX/P4x2LNQbqC05aND5raj6/KvgWFlHcNOEOG8aBG9mWVQLGqCfMczn9a8uDd9JY27KFcxRe8wXOzSI+kDHTIYIPuuZ7EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776999391; c=relaxed/simple;
	bh=I09DVnwUmT2FgjMlL1sbr+fqXGO2fhcK42PNEcwA7S4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jeQ4I5BjpEPW+O9zLEo4OJQsFlsxX4WKhEq/U6eCovXCvdKyuflYVJ7Dc3zrYfPlGrlWUeC/pdWFRHpcSgnsOF0KNvDX8AnIhdMUvOEGsIQPL6U2JVMfA3d4yM3GV0ngEjKYDytxTdrL+Z1vTb41f6bRfa9I1RdqbYIdAZZv1S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Jhf7yVAj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b45cb89f7eso47604395ad.0
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 19:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1776999382; x=1777604182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
        b=Jhf7yVAjomFeis3Y4Y1DJDax2tSMaVzho7OV9kb5c1jHTDaoJY9tXLxobHDq71j699
         7pETj8yJ98rTmuxLJpUKYrON4ZE7JYevAgfNYwbKnF4iPp3KC1kd50I5hDTWpZ288y72
         i90N8MNO/32dgL3esQhzCbFFutWENPVXA/ShOUCF1UuYC40GiPXZSIbJx54wDXggX8sN
         4qcuGvlpclTgY+Sxdzb2AlgLA6JZieF3PBYkIdHnA7AwnzpDz4GtR7U84tSh5KNE/Ypm
         exu5wVV6CU+wlmvWjkx6fNaZr05mvL/aagRqqJOVOO6yEYVnaRNg0Dz0XvKk3va90RX1
         jShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776999382; x=1777604182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
        b=naFBITZW8Bt8YTyGJ2M2jaG0AHpBYEl82HbzMCR6SYc1lkbyyeXfJmuT/UqSXM69XM
         0DKzxM3F5GFGHFdtNke5egSLme84aDrrS6yab6A+aX5AjDpkvPKu7EsNlcx74u9poxam
         O1OlnH3dVYpUUd80S+aZqzYeVVPcrYEWCG0a1ErOl9Y0CcVTxj4TSTIFQCy3BR2IoCHr
         JK6ojfFzY/+TwXBKL2Gd/4irwnLdVNbOEoV/79cKesHIKM3QdNOZWUjc6F09wC5vlopw
         D30t5AC4YY4QzSkZtNDZ5Fjey92Hve37uxVMptJlgAplf04VAm5TufIesx7O5wLxdpMt
         X9Qg==
X-Forwarded-Encrypted: i=1; AFNElJ+P2pKZwSxU9bT/LZSKTEDE5gs0UUsd5CFbQ0mp1HEKKVC6RseT6k6kMnvoWg+IdnwYjEda0wk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6D79BBiubN2zJQKuusBzIFcAifrxlsDhaRFvq30ETGRvRtHKz
	sXtt7Lo8g4xeXmjfbcyyde4hQs3QnkWlDoEgYL4dDbBJ/bQRl//m8iMDd8QrfDBEHlu7Opse6AN
	1mVgly1c=
X-Gm-Gg: AeBDietlgQv7YKMEGJkR12H/akVOlQjijudGvYdxxVdtVGHluQU8GntZ3NuHuD0J70F
	Lsv3wrDIoUSeGVjGWWLecwDva+HZNtVWmmtCN9Pqplay2C3SqGgQPHgYPQcjZ6ghdv8ZXzVXPSd
	MGndTK8mo57Ph8tXyWJb1D09k4hSRbxa1c0zAAxZbWgth9YV1s/WWDR5vBfhIj5CHrl/DF05CJM
	uevhvIK47dNG0OyvMVq7ZwSUD3Q9G/tZ9rAKnzZW1n4kwihGT8HYNtRHHXDdfF5RUktq+euE6N4
	pDNoyZEYjMvEvbeyH0DLuR5Y7aZKIRlFxHwfGCUMeP5ah2mlIyFwxfi3OQ0ieLxzuPUkFL9qR3u
	zu9f15Vaztk5IVnZX/NW/1d8MZTdBM9W3wf7R3yHOX6AQ4llvUKxMzqClUwv+tCKxg1SbRfx8Z9
	aH442WVigOUbIH6Yi+2AJOQpw14+7TtVyTGfifn0wiRirnb4Q8I+RdwoI=
X-Received: by 2002:a17:903:1a83:b0:2b0:61c2:8e83 with SMTP id d9443c01a7336-2b5f9f36f53mr299091855ad.20.1776999381981;
        Thu, 23 Apr 2026 19:56:21 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab20d33sm221668325ad.63.2026.04.23.19.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 19:56:21 -0700 (PDT)
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
Subject: [PATCH v6 5/7] mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
Date: Fri, 24 Apr 2026 10:55:45 +0800
Message-Id: <20260424025547.3806072-6-songmuchun@bytedance.com>
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
X-Rspamd-Queue-Id: D63ED4593D3
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
	TAGGED_FROM(0.00)[bounces-240554-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid,suse.de:email]

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



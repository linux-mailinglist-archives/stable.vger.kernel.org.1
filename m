Return-Path: <stable+bounces-241164-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mI6XI+Xa7WnIoAAAu9opvQ
	(envelope-from <stable+bounces-241164-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:29:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0609E469488
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 910C33015D3B
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01E6345CC9;
	Sun, 26 Apr 2026 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="CV9sSo4v"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A36330B29
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195656; cv=none; b=bXecvfu3Qv7IRpUKQOdjg9enN8NudQsGMIKBE3XorP188+0FbsT4948PaR/QECECZ/d6sHdVGMqqCUFKCGlMgA2KpSF4ZR/OQVwOmp7eh3WVxsW+eWSwdA6Rf1JuLB04Gn/dqzT7qgEcRi51Qo36Lgd9tDNLOafwIfN6DPf/qnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195656; c=relaxed/simple;
	bh=I09DVnwUmT2FgjMlL1sbr+fqXGO2fhcK42PNEcwA7S4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F0KpnyZpdtwteOB/5Lg/TFoX06dKTCchWsUuQqd4cJI1Ebuiwi9Naj977i4qBFUOQys4WyiRvHnSrA1YbnMeRjrZyYCuNBn/kDS1O/c8Acv1TTuc/2JQBRBerAkLY4CSp0gkH31BZmdFN/drymmSd7DnzeHGsl49WfF2iwcWAkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=CV9sSo4v; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b458ca2296so57287475ad.0
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 02:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777195654; x=1777800454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
        b=CV9sSo4vcajq7s81xB9BEfrNcdptGVmM8h6nm1AHNRYBH56rFuvsig/uG1JTzSwvhN
         kyWlETA/ZcLPj4K1pcgNFvmSmDF2Yz0N8QTmbCxVr6xv32dkQwCaoDjCKmMKRgpVBHFD
         C3nTZiA2/InQDOUPZE103HJqcsKKer7eIozsrZ8Vzi9E1JObbYSULQfZtXfZR2P5rjM/
         MUrC0DPlU8yO+RtfG9MewKKV7xZ65oMI18SfjHSJ7c+LPf8DShud6GmHy2cEJSnQpBYJ
         WWACcKAg/f8VHOdm2Qki0ABe4E34OIDoW4rEfcwbEjSKjUAtQ0PrTdNI2eKZFq0xBPTZ
         lEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195654; x=1777800454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X8jAPi1Ug7YtuxDodtBim0VZYTDek6DS5vd5ro+n0/g=;
        b=TqvBDYEoY95CSE0JvzGCw/4+VIxsclK8jeMKqMFU8YDgDDxBHark8q2iAT8i50LOG7
         tkqRA8wKonCL8ReypfpVEt2JX5iOOGvaQ0q+cQiXB7gFWra1zRWsBXhOYvkmPiQCEvSc
         wcQI4KPPuBml48gIHg70aLhiCrPVCpzatQmCxMxXCAC0sBwp2ZFu+R/u2N55v5cqEpNW
         0pYPMPIgnuH2SitsSHg1/YrSVGJxtsBf3jNrOXjoMcRjXI0Vrs5viwWh5c8GMwR09dsE
         5kGpc/ilaSj591CGR7ELyUBrkkd85sGsfFk+uw+1HmDVvuuiB6mnazlzvs8mwEKGcMoE
         xsUQ==
X-Forwarded-Encrypted: i=1; AFNElJ/hFnEp7x0uq0cdyXii8jJTV16b32tCAUBxrk/1WHBe7RPxxszK+auUYywZm7T1xpGQZ+SgaAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG65OtjEEvTvHTP06bYPryB/w8evxzFyxAumXFvFZMzFVF0//m
	HIUAvxpO4gbE7Sj+DgezqZDakenSol4tATRvrGXAIET40t7LAaWMXUOfAQM75Ax4Qkg=
X-Gm-Gg: AeBDiev2axCn7xx9MWZSNsMvjZd/Hg1qYp02XVXvlAizWU8yEFdm6h2bXfrFgkVyYEs
	s9pnlP3GVOap5Z0KEnLDL2gehc2qHIoK6BLnXph2x1u8uW07bXrTMfNz7LjXSZ8AqjxoGucfQWl
	HtI8btNtReD85WoQV5HlX9XFf5+NShyg7R4EOKCfEw7q96MG19053qpyDWcHk7UdY636rRyLE+K
	Acd7lxoDBWAYLowC0S+sa1jN5jE5dGcXU5tS4fnrLCY0+nEID6k1COJJpfnGlBza8C/LaBbn602
	m0gIlrlw5xGMqm4Ule0HhtE5LPEn93UncdAbG6/N94YgjZ31QgAxgPl1lbgOkabNKkg+nROr12f
	VYpgOdWNRTUJoaKh/WTinUD8R1quel6lbxdkUkBUVsHVXkInfLFHSz7kGUYzfSDKw531IOC6oDc
	UuOAUn+05LXGoy6w9xtxXZ/m6r4ADM
X-Received: by 2002:a17:902:da8b:b0:2b9:547d:ccc8 with SMTP id d9443c01a7336-2b9547dce05mr31133985ad.30.1777195654294;
        Sun, 26 Apr 2026 02:27:34 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm270352885ad.40.2026.04.26.02.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:27:33 -0700 (PDT)
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
Subject: [PATCH v7 5/6] mm/mm_init: Fix pageblock migratetype for ZONE_DEVICE compound pages
Date: Sun, 26 Apr 2026 17:26:39 +0800
Message-Id: <20260426092640.375967-6-songmuchun@bytedance.com>
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
X-Rspamd-Queue-Id: 0609E469488
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bytedance.com,quarantine];
	R_DKIM_ALLOW(-0.20)[bytedance.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[kernel.org,oracle.com,google.com,suse.com,gmail.com,linux.ibm.com,kvack.org,lists.ozlabs.org,vger.kernel.org,bytedance.com];
	TAGGED_FROM(0.00)[bounces-241164-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bytedance.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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



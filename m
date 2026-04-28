Return-Path: <stable+bounces-241491-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ILmKKOxu8GmgTQEAu9opvQ
	(envelope-from <stable+bounces-241491-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:25:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 245DE47FFB7
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBE5230D7F67
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98B43D3481;
	Tue, 28 Apr 2026 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DEDbZV9P"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F793CD8C1
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364351; cv=none; b=JphgPDWb4oc6t0rz/W2tP/2rxK/YuNtYIFaJ8TS1OnEZrR888qI13sKiwl69P+qlo/b4A3BNPRiL7enEaUVOxbicdrPPR9CuphaP20LpPibDt4q+9gEsWkKTVsQrwLXqiexgcsR++TB/GdR8AWbYE6DhfNoTAZHfm7Qua91aSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364351; c=relaxed/simple;
	bh=0PLb5zFObm442FFPCMDt2iC8dud5KQqM0ijr0fGCJws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=blDaTbrW+C704CSRHN7bREME7wjeXhmK6/ileASU7jK/gij/xNfvj3/OQ2t4WyjRfmVwqPRqkaak5noa9DX/PRGWW1HeyXI9acZcdav7J3ctHxE6pnViO2QmjxN99JrUPwFJrFWXMzebXo95/4IvUd2MEwgS8RfM37TuGxlkkxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DEDbZV9P; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-362bb3260f1so5346073a91.2
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777364349; x=1777969149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
        b=DEDbZV9PInNIYCP2ZcJyJV+p5hB/hr7iMDPIDLMVodgpBrCgi+/i5MXm/QOyLnkhX9
         Xz9Db3TRVzgZOqrch35P6WZehwxrUSVO/jxP3kAmx+zm3aHeFkK/UqXgjIuRDP+CaCFf
         jA3R7HVaPFi9+LxzA0Kv9+GilOt7A7gh6jwv8X4qfhrG9Lq6mqELTuuOny5lvrp/hBNX
         pXEl+47rYOXFMhc2WYr7jyrq0IZPBf3nSWM8BOoHkAAiwTiKymDbwS6KHcsk6SJ22fHY
         1WsQnuoE5Kwm8ELMImE5RaNWAN+stfHWKodCFgb1M2rKmqDLQbSMGD9hcJECDNrFB/Dw
         SD5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364349; x=1777969149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Odp+99JHCbpwHHM6ds3EE8rv22wzvZDnJ+uzSMS+VHA=;
        b=PbO9GZPQQwmbU4Z8o+V5JCsLS7y08ixr0z12J4KHXBVWLbGfL/VILd4aHNWn4o+0B1
         vIT7q4ZTi5pOYdkoGWTH0eghhWnUxDpUbASogza5pRu0r34CQfIyzEHJWCg6mi23MSCg
         wdFoozCTWPqUAJMbox5gpghAHCjKSK9tXEoqRSyUtRt1I5SF088u9nqQ8Qd3PGohaqxR
         uSAvNzIgBvqqdLjy5dKjwTbXhKWGLeJpFUZ6bH+vkKPYeIRvkVVm8cLGvGDDwvZS6z5b
         10TRMrObKhbCt8xYCNCifGNwl//CEcstjTgG8tabMhDDlHods8CKLCgWveNbaXpMX+9q
         n83g==
X-Forwarded-Encrypted: i=1; AFNElJ9vqna35+ZudA5EYUK7/r+vyCK1m5u5MqL4Cd8pD3MbeQjNeR9CN/iNznFMuX0G82tJ5Tls0HI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2LG97TUoQ6L4yB40zcq2qvKxtkS2dwDWrNEtiX1xqdLLmREtJ
	3QF3UJgY47GWniKCdYMt+1KRhGP2ldb+CoO+LAhmsdnIWIs6rdWgSebABJuWxekwO+o=
X-Gm-Gg: AeBDiesHQudlXw7p5xiSD48xWMGf+mrdkezmNmHgbJEnS7AeDgs29sgHUUuXNZ0SKys
	eEK/YQLLcO1u3yXfdLv7zpZ1b1FF7J/RrZiMzUBH+nwJn8Uet3j47bdzrQ8dI9A7YCH9Mz/yQaQ
	W1Z3OCYPQcGR41Lvycg5EY8fw9hUO4VwFzyn1477HrUnUlG4svxw7KqNEXe2/hM5g2+5a56jy7R
	7n4VkPPHpH9OjvSGF8EIsRqw+YvHR4hLPm7H5CftjUvuvWCpG2Bvvx/bao2/YcUq9SAaBRHPGHy
	VRiz2gXGDSagMJgQkLvOvUCXUUXUpXKLwXPo5JsrHuupiaU89IghT7VsGF6JZpAZQbxZY9OAbuj
	w7v7a7+M3Owm6LAxeeq188AJ4jL5xwRHU5pD4K5VkTqA/T2P8DF7dOs51Pj5rDrzxFGVjRWyvD6
	0nEvPu3NAmotGpUaNtSWx5M6Q3wJsGKMQ9b7v62Dy78M6bGB94o7X1yn0=
X-Received: by 2002:a17:90a:d64e:b0:35d:8fdb:4f26 with SMTP id 98e67ed59e1d1-36491f89e50mr2246840a91.1.1777364349228;
        Tue, 28 Apr 2026 01:19:09 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649003650esm2181356a91.8.2026.04.28.01.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:19:08 -0700 (PDT)
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
Subject: [PATCH v8 1/6] mm/sparse-vmemmap: Fix vmemmap accounting underflow
Date: Tue, 28 Apr 2026 16:18:50 +0800
Message-Id: <20260428081855.1249045-2-songmuchun@bytedance.com>
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
X-Rspamd-Queue-Id: 245DE47FFB7
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
	TAGGED_FROM(0.00)[bounces-241491-lists,stable=lfdr.de];
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



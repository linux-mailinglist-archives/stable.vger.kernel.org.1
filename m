Return-Path: <stable+bounces-241165-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mH4ENcza7WnIoAAAu9opvQ
	(envelope-from <stable+bounces-241165-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:28:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA9346947A
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 11:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0638A300D4C2
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2095B345CC0;
	Sun, 26 Apr 2026 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="MQh9XJ/P"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847D53446CB
	for <stable@vger.kernel.org>; Sun, 26 Apr 2026 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195661; cv=none; b=H8LYLyFAATBLW1eGkJOg847SZcdYvDzmKE2MKMbOeVyxRHgz1joobX7kRE+OBOXdWqgRNv7Im7ECseELOx4/snncGoYv4dhRSQJQOfK3hDM8eg+SQyzmxbDOZNraC+KAs0BFTOzyCzR4MW/u0tscWgmcvShI2mA7cJVMChdd0ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195661; c=relaxed/simple;
	bh=ywbIjiAmJOpr0oswLhWAUDJeFXDBn1/X+WWcoQ+ww1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IIZIc1CFCGQrbukfEI0C5ndqBOXaNYIdaH5KMigVL72CGdYRwSfPmQ3DWddduCvhBsvM6haDGuMXQPTiAy/Ku4hYBNQJa/5MZuIW4A/oPoxZbiBJYHGUVpwGZnI72mQ+IsZymr6JIbvSGYPsWbiJBG/Op5hIW9+jI9OznIapc0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=MQh9XJ/P; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b7adb38d65so30870445ad.2
        for <stable@vger.kernel.org>; Sun, 26 Apr 2026 02:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777195660; x=1777800460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKHGjwyqOWL6rVsBt0Sw/YSvydX7Gt+2C2Tpk5skGPU=;
        b=MQh9XJ/Pazwy6fHSn8fEfl68CZW3nrFka/xAXMkqtUgqVQ8qcz8KuPE3w9Dxtaowxm
         Yd8Zr0b3wpfkDS1rIq2dQUWov6DAhbWtEK1nNBMxbJ1It6Y2Q6LVenqhDV/Tx0qGjtpV
         1b20t67ugwXbVv181N7/cwmeTpFnEOd1HmORriHF88PlcpBWBtog/aewQe0Yg8okKbIU
         lrY38mKrP/afZSng8iB7IYfMvPuW8eQSfVm2NDEA8inhbaV9nePEGDHWXdxgTNjmjCVA
         qSCu+axhniZT7d1QRsFnQaBvwDBYVpEMUyEl5eb7fCxeheIbdAaSfWmSey+JJBpBHXjO
         4/TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195660; x=1777800460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKHGjwyqOWL6rVsBt0Sw/YSvydX7Gt+2C2Tpk5skGPU=;
        b=cmvjUN0mjmrC1xtBi6EV0Gbzvo1OjbtYhB2zhwXkknVcEBRk67wxjQZmchBluKOIzW
         D0V+6eWpJtu6C8wVPnkbGeATmy4X00Zgik72zNpapdlVLZujlRJqqtKI0C5rNo+VnX6r
         BxnqQHCsOaQbe9iPqFDTfkviz3+NIsa/u/p3xOAEx0CpYUCjN+6AHg8C+fsyBd0PXbsf
         ABuZTrAzhGiVSaNHWH084RepZpJjIc3BEZKKNXNxp86VfJabji7xq+vTxiAstitscivA
         cGUEXRpdDVsyl/IVrkf461LoExUTbLhkZ9/qX1Vk9RkA/NF218+0ZLpQiXqgOYABAM2E
         9oZA==
X-Forwarded-Encrypted: i=1; AFNElJ+p7fzFO54fXsSRMXGAuRPkHGzuVR3tHfvnKf47JAEMUTCy5cy5TXJnpjsf/4nrl4tnj72SkTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBqR0jHNKJDtrsMeQdoJpuhH2daJRDcQRxrKEDtaATjfWrHcW/
	emuEYdrmxyk0Sn/ZT28MquFJqsI5NZVhLXVwpWu0bTvGp+Wf+2cgAnMEOBWMXEn/arY=
X-Gm-Gg: AeBDietNp8+3X06s9zzPespRAcMFYmTatTAARYSmsaiECBxX/BhbAl/JmxcL9WX5W+f
	RPNcLoCtNy9ZfShDjpdrFbC3fuAQPaLcfhg02SsgODZvkI3PsfYIK+A+DXmWXQOJg+9r/2MEwSf
	I01uucnFQuOu/5bb3vaiDh/kKbl2FBeiubwkhrQaTpB98F3lC9IWoJWli3G+GK2gX0JiA96JPph
	fAZicrmGjcWZTQzANa1du+J/jiqClvK6EsTV+s2lvz+MaqnmuL/DbiSCjUjwxPZqU8UB/WcXMP7
	5JqDNGw9FwL1P/sr3p8K6HyD6/amkYg80GNQKMPaFyr9H6U244ER/J7zORQUuttLO1qOHpm7gSF
	q95XhlB1BGM4ukjJI3PIfWoBpdYLpcgokEofeNog5bYIwoDNpg6/U+bVB7NQBsBoaBdmhRlD9hk
	QpQPbG9S/xTZuj+s9paSFMYbbGf22k
X-Received: by 2002:a17:902:d652:b0:2b4:62bd:ee3 with SMTP id d9443c01a7336-2b5f9f5eac7mr310134635ad.33.1777195659828;
        Sun, 26 Apr 2026 02:27:39 -0700 (PDT)
Received: from n232-176-004.byted.org ([240e:83:200::34a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab0caa9sm270352885ad.40.2026.04.26.02.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:27:39 -0700 (PDT)
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
Subject: [PATCH v7 6/6] mm/mm_init: Fix uninitialized struct pages for ZONE_DEVICE
Date: Sun, 26 Apr 2026 17:26:40 +0800
Message-Id: <20260426092640.375967-7-songmuchun@bytedance.com>
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
X-Rspamd-Queue-Id: DDA9346947A
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
	TAGGED_FROM(0.00)[bounces-241165-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,bytedance.com:dkim,bytedance.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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



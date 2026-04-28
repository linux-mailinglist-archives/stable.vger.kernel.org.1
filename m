Return-Path: <stable+bounces-241495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eFdsLQhu8GmgTQEAu9opvQ
	(envelope-from <stable+bounces-241495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:21:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7361447FE7B
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 42CC23008C3D
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94973D47DC;
	Tue, 28 Apr 2026 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="g79PBT1P"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533D3CF67F
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364378; cv=none; b=up4msSxwxk+POiiCtfpXjCn9UuUs5Rsdcd8aAkYLKf5fgG7u4iCMsDxuBB1sy9fK5+3SZ5ToC+x+cHzuVFluu27ggWNJMUYHM4WrERJFq2+sYUqYc0oiGtmVrWOmOqKX0frcwdhbqm0cKNousQ014RkAycazZVXLSHcFzhf7dPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364378; c=relaxed/simple;
	bh=ywbIjiAmJOpr0oswLhWAUDJeFXDBn1/X+WWcoQ+ww1k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tK2A6rnK3RcdoFlwU9aEXrBCq427yA0pnsqK2W7s8iI3b/5SUXXhRs67UfMZl5xO0McnsKuO2iCWNo54WIYDtAJibRtD4Zgu+BqxlcFY7+C4AamBTMl8pnN6SUEhuqsYdL3KrU7jZeimq+NSFOtP6z08qYDhTIiSCbPt2mk+AyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=g79PBT1P; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso6513048a91.0
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777364376; x=1777969176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKHGjwyqOWL6rVsBt0Sw/YSvydX7Gt+2C2Tpk5skGPU=;
        b=g79PBT1Pk67KA1ExCBnIF9gO23i41Rg1dXuPffVEjI3lNQX7BtqeVyfBTgXSqtg4Z4
         F/1C/KsemEPg/HKR97esYM9bZ0kTb5OJwXBAIRDxqHygv0h362IXma4Y4r6W6mvK/hzE
         0In5Mr/9KjmOyFQKrgHHAGvv0XRnu8G0joNGpvzWeHip4wWZkOsGL6yMm+TnDXFXHW1V
         VedcuG35b/CAN3cGyiARLmiDCDOiidfOrOBZxSZnY1cik29zq30SbsundI8o+2tAYJ7M
         kBBpRnmQ59RwUf6Q5LlJA/ToITS41acxRZjMIlW7UdEo9QiMna8+EhjNVWwEZigm24XJ
         bbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364376; x=1777969176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sKHGjwyqOWL6rVsBt0Sw/YSvydX7Gt+2C2Tpk5skGPU=;
        b=gffovPbqh19ldEOMYK2XAVa21mqf6OmMg1htQeBC1yO91yQ+RWtdIYClnFcK5yF7IS
         ArlzhKIBiBs91BwzGPyxw/kfPpbjSGpJmrFJPTzwyYKRvzkJY0G0hMzeygrTdHMosZGt
         kcLkPjsfNBbuQZG4HhGHNLrCZjIHQXNC1g2SRlrX17XDeXaDFv/MbQ83LPSfVV6ibsmk
         8BDnKtjC4ItNmKS40gA6L7TaaOZOQOTJrMA5AzH5MW7Ruhcjc9IFcPCnPF+cHfGbzV58
         6uLs5CrG80qcf/lrNHroJcAIoBoMFkV4EIhApcWEyN0x3tpS3/oa7Yg/rlwHw8fITWGE
         gSBw==
X-Forwarded-Encrypted: i=1; AFNElJ98CuuN5VGYJJktXsWZW2ekWWkA5plAEZRrvt7OUZToccNbAeea4dXdqKDpDFALwJbJRO6o+DM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQdHv6HpMVK3Afw0NmbiqE/Vuhzoqjtf6Gjg1Yg5CZa2raBJB
	bsjcc7b3YN4J61Y3krazB/l4SLT5KQFmBFrw4+zB8xT96JOEQX7BumXN6/VFuo9/7G4=
X-Gm-Gg: AeBDiesrhQUtnn0meMag7RUZzLdPMZytpj9E5G2YQryr3Z/XaOOKGQDJxsCzV5P5k7w
	HPQlcAxsVi8gEGYergnslrWOK8DEjM0wnljBKs88EhKcdJkzt1CvztKVXalCoFASq02zkAKYkBA
	B3TRjD94QxgbGu4M/I+22fi5oHAqu5PU8rdX+uKJAjpRPiZT9jsQuv0GvH/E6tpx+7F1osbu6bF
	Y8qOe/TTZXQA9OaWCPNPP0Luzw7GoBMPCJlY6tqV+k0crCFXCwnuI+M6lcQ0q43koB8YZBGKEEs
	Z20wMBPnz0bBjAhMsFotqM8J1Lg7vPVgxTfB57MCjRkQrVK5RleRQcjvC9KCze2SQ5nf9HDBoUV
	oDX+ksW2aFGNZAafXYSH/yPOfcLr6mTwzsmDey1pfuxtKA6hXTZ3ck3eH5TfFvaADJJK/pxeQ2H
	OKlOhA/sAu35NyjzD9/W0w9ZxZXP5BmzQzOVxvsrk3AcOJNd04WArxn9U=
X-Received: by 2002:a17:90b:5808:b0:35b:e5ce:73bb with SMTP id 98e67ed59e1d1-36491fbf11dmr2272598a91.1.1777364376405;
        Tue, 28 Apr 2026 01:19:36 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3649003650esm2181356a91.8.2026.04.28.01.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 01:19:36 -0700 (PDT)
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
Subject: [PATCH v8 6/6] mm/mm_init: Fix uninitialized struct pages for ZONE_DEVICE
Date: Tue, 28 Apr 2026 16:18:55 +0800
Message-Id: <20260428081855.1249045-7-songmuchun@bytedance.com>
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
X-Rspamd-Queue-Id: 7361447FE7B
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
	TAGGED_FROM(0.00)[bounces-241495-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bytedance.com:email,bytedance.com:dkim,bytedance.com:mid]

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



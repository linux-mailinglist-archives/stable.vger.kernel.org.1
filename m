Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977AD7B885B
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244031AbjJDSPT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244026AbjJDSPR (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:15:17 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B368DC1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:15:12 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-77428e40f71so6792385a.1
        for <stable@vger.kernel.org>; Wed, 04 Oct 2023 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696443312; x=1697048112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CSSGJ/XZYqdo1AkHmB2Bvh1QTbI1LUhTfLllMmN0zGE=;
        b=pjpCNkS1kQUvf+FsQ0Lk0i2/zeU5OFNIS90lfcuqeSrTsVHOl/r09IPyfPC1w32Ak3
         8mFuq2JdGRF/s5vJJybeqM5QIA/SN7ALmgAzJ2AWy2Rv1xzoDX/An8X+u8+N7Pp9+F3O
         s2l2fYe9AKeBBBgmWe1Owy+WjOh2tkOcrUeIYyU1dP1WqD5Uw9zmP/13K7tymQf0x2Uq
         KT87tC9bvvEwN1+/RlJNIftTGi9+NUBoosf28EgQf9eOhPPYbYCIqPrJpIonvHejYy1Y
         vdSsSIS8IKrdi0rY7eG2XtoajJR6PZv8GotLewPi29ESdVCxdv4cabQvijGCRsIo6PRC
         b8KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696443312; x=1697048112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSSGJ/XZYqdo1AkHmB2Bvh1QTbI1LUhTfLllMmN0zGE=;
        b=piBPSeS27jSGrLoN5uWdS9PO7cD8m28iiF7XFjOtJYGLbjNOoYnerhwv2OGioNE7rM
         V6dlQCjLm7fC/PJ2OqtHdhMkI0XHMKsx3nxImEbmdThzqj0skJVqFaG/0W2x1V6b8gzY
         oALIplmx9mUtbkLttHu5x3fORvJ6Qutclh+FI+z7q/pqbqobhOYOm+Co87KS4Qg33WFv
         /MTEYwj35AzT2qsF7ErG9sYzcT+O1lcb54AeYlIHhpCvqJYU8qFv6pxeTe3xUMUSfgXh
         +olgpd9ZRCO5haE+VcYI0CZ/yi7f6xRuK7cWYcheOY82fSsDQigiR4TTiTcEahV7LcyU
         rixQ==
X-Gm-Message-State: AOJu0Yy2qeYU82cc9A5xgKF8CQvU3xqnVZH0rEOp4NgyUjTw38AbGTGU
        I91dLTG/xvkTEtsoy2owWFMdWJqYd3f/HwcJ91A=
X-Google-Smtp-Source: AGHT+IHjO2xATKuA1V5aEnZ2MqXTzLQApdk87Sap8vPA03NVqBU/T/XiVdT2XrhPR1WIcXbIZD/P6A==
X-Received: by 2002:a05:620a:f82:b0:76e:ec77:10a4 with SMTP id b2-20020a05620a0f8200b0076eec7710a4mr2544623qkn.77.1696443311781;
        Wed, 04 Oct 2023 11:15:11 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:753d])
        by smtp.gmail.com with ESMTPSA id q16-20020a05620a039000b00770f2a690a8sm1431577qkm.53.2023.10.04.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 11:15:11 -0700 (PDT)
Date:   Wed, 4 Oct 2023 14:15:10 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     gregkh@linuxfoundation.org
Cc:     akpm@linux-foundation.org, joe.liu@mediatek.com,
        stable@vger.kernel.org, vbabka@suse.cz
Subject: [PATCH 6.1.y] mm: page_alloc: fix CMA and HIGHATOMIC landing on the
 wrong buddy list
Message-ID: <20231004181510.GA39112@cmpxchg.org>
References: <2023100429-postnasal-hassle-02be@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100429-postnasal-hassle-02be@gregkh>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
bypasses the pcplist on lock contention and returns the page directly to
the buddy list of the page's migratetype.

For pages that don't have their own pcplist, such as CMA and HIGHATOMIC,
the migratetype is temporarily updated such that the page can hitch a ride
on the MOVABLE pcplist.  Their true type is later reassessed when flushing
in free_pcppages_bulk().  However, when lock contention is detected after
the type was already overridden, the bypass will then put the page on the
wrong buddy list.

Once on the MOVABLE buddy list, the page becomes eligible for fallbacks
and even stealing.  In the case of HIGHATOMIC, otherwise ineligible
allocations can dip into the highatomic reserves.  In the case of CMA, the
page can be lost from the CMA region permanently.

Use a separate pcpmigratetype variable for the pcplist override.  Use the
original migratetype when going directly to the buddy.  This fixes the bug
and should make the intentions more obvious in the code.

Originally sent here to address the HIGHATOMIC case:
https://lore.kernel.org/lkml/20230821183733.106619-4-hannes@cmpxchg.org/

Changelog updated in response to the CMA-specific bug report.

[mgorman@techsingularity.net: updated changelog]
Link: https://lkml.kernel.org/r/20230911181108.GA104295@cmpxchg.org
Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
Reported-by: Joe Liu <joe.liu@mediatek.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
(cherry picked from commit 7b086755fb8cdbb6b3e45a1bbddc00e7f9b1dc03)
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

The conflict was due to an in-between patch (574907741599) changing
the surrounding locking:

++<<<<<<< HEAD
 +              free_unref_page_commit(zone, pcp, page, migratetype, order);
 +              pcp_spin_unlock_irqrestore(pcp, flags);
++=======
++              free_unref_page_commit(zone, pcp, page, pcpmigratetype, order);
++              pcp_spin_unlock(pcp);
++>>>>>>> 7b086755fb8c (mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong buddy list)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 69668817fed3..04b172d73f7b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3479,7 +3479,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
 	unsigned long pfn = page_to_pfn(page);
-	int migratetype;
+	int migratetype, pcpmigratetype;
 
 	if (!free_unref_page_prepare(page, pfn, order))
 		return;
@@ -3487,24 +3487,24 @@ void free_unref_page(struct page *page, unsigned int order)
 	/*
 	 * We only track unmovable, reclaimable and movable on pcp lists.
 	 * Place ISOLATE pages on the isolated list because they are being
-	 * offlined but treat HIGHATOMIC as movable pages so we can get those
-	 * areas back if necessary. Otherwise, we may have to free
+	 * offlined but treat HIGHATOMIC and CMA as movable pages so we can
+	 * get those areas back if necessary. Otherwise, we may have to free
 	 * excessively into the page allocator
 	 */
-	migratetype = get_pcppage_migratetype(page);
+	migratetype = pcpmigratetype = get_pcppage_migratetype(page);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
 			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
 			return;
 		}
-		migratetype = MIGRATE_MOVABLE;
+		pcpmigratetype = MIGRATE_MOVABLE;
 	}
 
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
 	if (pcp) {
-		free_unref_page_commit(zone, pcp, page, migratetype, order);
+		free_unref_page_commit(zone, pcp, page, pcpmigratetype, order);
 		pcp_spin_unlock_irqrestore(pcp, flags);
 	} else {
 		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
-- 
2.42.0


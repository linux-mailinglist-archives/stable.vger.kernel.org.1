Return-Path: <stable+bounces-103914-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9779EFB05
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 19:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64CC616990B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 18:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420BD223302;
	Thu, 12 Dec 2024 18:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIvDhbLJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7710A21660B;
	Thu, 12 Dec 2024 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734028438; cv=none; b=u5e6imOV3SC87kfkMv/F9g39qXPntSptGo/yWAChnGH4XBBMFWGSj66xn9skOJOl2l/cgQGu+YtGS3S/duhnsq8CNHNsXy1lEju/4TV9+B2lqB5BSlOOFf/PyVTn0NKieYd+ejJrYQTPP6N7kcDnJQ+AmmIkl57YyGCLTcPFlmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734028438; c=relaxed/simple;
	bh=tZsu8TiuLR0S0KrbV0gJ11FoB48CVZZWePFjnRlLhIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UqRQywU8+gyQwTsaRwj/URDSSrQ0J7fqThsd1rj7MXxwuyNyGYghNUfbXtcQUcyCvLQRCRreS8LDSZEYq1i3aB4ppWSQocIM/Nao6dX3z69Kl0ZBc4j2eadeuD27i86zG7z5bAzQn27nM2XAYXSkF4gmh9NFE7sxMgbnqHlPWN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIvDhbLJ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6f8524f23so55800785a.2;
        Thu, 12 Dec 2024 10:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734028435; x=1734633235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZqbWz5w80/Ao2+q+hylk/EZt96xoYzXRfCQenTqI3gE=;
        b=YIvDhbLJTZSOmwqPVFp+0cCUWmLYyQaJ24rd1MkCOPyYO6Kbvnq0ISR4ntcKA2qfxe
         4xTC2XYVyAxLX6hwF5IkWGEO5qHYOsf2ljCn9LouHQ3JH58fSYyMiU02JlFIvT4aHu1L
         bAE/pWP8C492opvRB+7VkZuuZ52/sdoClgjGt5lvRyvAlkIqeKooOevr4EaPSKicdVkU
         pGO5ZI3bShB7BEoASU+Kh3OvhRicsvoetl3HtQNnWKSadmMdyWWf88Z9Xb9NlU8zv4iX
         sPoCoyCbnTJZLcL9RKPh/X7JB9N5dlt90HcV44z05WjGXfxL9gTj2qegamHSgaMX9t1h
         JINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734028435; x=1734633235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZqbWz5w80/Ao2+q+hylk/EZt96xoYzXRfCQenTqI3gE=;
        b=kHxR9zWqbDre3DylVKsCL/RYcWbHkwmYwm/OrS8c/mpVgEEpKxY+IkbvD1+Od9Qt6r
         Z2YVWaY3Zqy+v8IsLloRhRINJL9VU6TJris402gZKD6xRcHV9KsoTtL9HlWURuP6Dni9
         yLDmNaybZuwS3Xam6RnaHQXGTBWKm4m0sN/WgTaQ0mT5AwHHHhEcbdJQSU4JK5mJ+n2W
         XsjoSluP7iMHCYWtPit+UlzbXNY87rlG0zdZNR5ees9tf8+NDFrCNpzSIv632i6slem5
         9ogGF6KBsNXkGEvs458zmaIQSBq50QZ2buUWCTXL2YraUxvb14dbrOk3EC4TizW3E2m/
         4tIA==
X-Forwarded-Encrypted: i=1; AJvYcCVD6BpkMNztMwuWUW3o9/lBWRlkLB4Gk4uJsGbnSHw+j36/58MnaR+N9spT1eo96vqtiQnpecJz@vger.kernel.org, AJvYcCWGmmhgsO+FCCXG5wkuOoi1hJOOvlEjeoWefp45AahHC2v/SbL6OQl2KLrImu0J8xrG1B6lKgPeN9MIOtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAui903q3k9ZHnsMHB4GyhUzajRqSnFjfjKj6m/tdkPHtqtDa
	2YJcUCzNJHWNr2NNAPm3ryFat1tCi2ggGQTuLDcOXn3uCpHRvMxg
X-Gm-Gg: ASbGncuu5oOuojFWFhGOEtfz+PDyUkEXrAonEoVGKZ0oa+J5/MJwkvukfAeln1lj/sT
	BLPQmtkYmaM2c0JfT+ph/2GBRmvI4KhiEXH4vN9N1jgNuVU4/F+zsjZlFS9DXLnZMoStSv/vpGR
	SyhzIkfCMObAh9eDdy7IDePhPNoIJ2lCWpY3hGlmJUp8EvOWMVou8vyzWGrIb+Z0nivSKqy1qw9
	Pd01FTiKVEk54PAIyYfDtdjo5fPaCPe9yS2mG5QKOJ9Ay0Yt+LPRw==
X-Google-Smtp-Source: AGHT+IHW4lqyDD/WZ9MZc2ZAevw778ZC2oWLKzpYfIVQPXRhxGqN/JXNrTHqvV6y9ff/9LhoNEnlKQ==
X-Received: by 2002:a05:620a:40c8:b0:7b6:f110:43d5 with SMTP id af79cd13be357-7b6f893016amr223205185a.18.1734028435127;
        Thu, 12 Dec 2024 10:33:55 -0800 (PST)
Received: from localhost ([2a03:2880:20ff:c::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6eed3d22dsm157188685a.31.2024.12.12.10.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:33:54 -0800 (PST)
From: Usama Arif <usamaarif642@gmail.com>
To: david@redhat.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	npache@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	ryncsn@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm: convert partially_mapped set/clear operations to be atomic
Date: Thu, 12 Dec 2024 18:33:51 +0000
Message-ID: <20241212183351.1345389-1-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other page flags in the 2nd page, like PG_hwpoison and
PG_anon_exclusive can get modified concurrently.
Changes to other page flags might be lost if they are
happening at the same time as non-atomic partially_mapped
operations. Hence, make partially_mapped operations atomic.

Fixes: 8422acdc97ed ("mm: introduce a pageflag for partially mapped folios")
Cc: stable@vger.kernel.org
Reported-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/all/e53b04ad-1827-43a2-a1ab-864c7efecf6e@redhat.com/
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
---
v1 -> v2:
- Collected acks
- Added cc for stable@vger.kernel.org and link of initial report
  (Johannes)
---
 include/linux/page-flags.h | 12 ++----------
 mm/huge_memory.c           |  8 ++++----
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index cf46ac720802..691506bdf2c5 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -862,18 +862,10 @@ static inline void ClearPageCompound(struct page *page)
 	ClearPageHead(page);
 }
 FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
-FOLIO_TEST_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
-/*
- * PG_partially_mapped is protected by deferred_split split_queue_lock,
- * so its safe to use non-atomic set/clear.
- */
-__FOLIO_SET_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
-__FOLIO_CLEAR_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
+FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
 #else
 FOLIO_FLAG_FALSE(large_rmappable)
-FOLIO_TEST_FLAG_FALSE(partially_mapped)
-__FOLIO_SET_FLAG_NOOP(partially_mapped)
-__FOLIO_CLEAR_FLAG_NOOP(partially_mapped)
+FOLIO_FLAG_FALSE(partially_mapped)
 #endif
 
 #define PG_head_mask ((1UL << PG_head))
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2da5520bfe24..120cd2cdc614 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3583,7 +3583,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
 			if (folio_test_partially_mapped(folio)) {
-				__folio_clear_partially_mapped(folio);
+				folio_clear_partially_mapped(folio);
 				mod_mthp_stat(folio_order(folio),
 					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 			}
@@ -3695,7 +3695,7 @@ bool __folio_unqueue_deferred_split(struct folio *folio)
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
 		if (folio_test_partially_mapped(folio)) {
-			__folio_clear_partially_mapped(folio);
+			folio_clear_partially_mapped(folio);
 			mod_mthp_stat(folio_order(folio),
 				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 		}
@@ -3739,7 +3739,7 @@ void deferred_split_folio(struct folio *folio, bool partially_mapped)
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (partially_mapped) {
 		if (!folio_test_partially_mapped(folio)) {
-			__folio_set_partially_mapped(folio);
+			folio_set_partially_mapped(folio);
 			if (folio_test_pmd_mappable(folio))
 				count_vm_event(THP_DEFERRED_SPLIT_PAGE);
 			count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
@@ -3832,7 +3832,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		} else {
 			/* We lost race with folio_put() */
 			if (folio_test_partially_mapped(folio)) {
-				__folio_clear_partially_mapped(folio);
+				folio_clear_partially_mapped(folio);
 				mod_mthp_stat(folio_order(folio),
 					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
 			}
-- 
2.43.5



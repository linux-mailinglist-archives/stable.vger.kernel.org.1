Return-Path: <stable+bounces-172659-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9CBB32B77
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 20:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C79BAA6E27
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 18:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6AD25291B;
	Sat, 23 Aug 2025 18:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4tykpeJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEAD2264CB;
	Sat, 23 Aug 2025 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755973659; cv=none; b=fLC+twLmkZwSjTd1pL1gp6Jc9dK/E38HGtoqB02JaS2i8kuFRRfCXwpuvvE66wylnCHBWCrXnTTXsmPmWtszPvkrHbtpw/HerKenKH2Ioy/ZOEgXtFmUJK5QO5bNHuF9pkJz8su0bbmPhKLludEgM2eaEj/GHFDTlQQgPR4joO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755973659; c=relaxed/simple;
	bh=ka7D9uPIa8LjevCcT0RgW79rMqAWpjKb9a2tBzhwvG8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MAvG36tj8elsTTDCXyxdi6VhzzK+ElrtF+uee9UG1ACnt0haho/Md7VJJ+c7qh610wO601fCadv7wZyfBnrBKMQ+RBf44+nZK+4n7uAFJEeIgJ1SBVCqDrFn9bHOcGFTj1HRXWe489irk7SqIRYkayJbt87qkxctbn4tlQ7AZic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4tykpeJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24680b19109so3364415ad.1;
        Sat, 23 Aug 2025 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755973656; x=1756578456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gXnziTBw7UP0Qc7D/AAchtEa0GCcVLQfrOFVsu3rHR4=;
        b=l4tykpeJBvi9jmicRy7F2x5TWyRUm5JH2fT3/SHk2MWacW82HptBY8aMOVGpdw7U9Z
         +5HOORbN8QBNQxymlKviXYRJTMQu+OPx7ET9SmqUKHTHJrga9a4j8YT+ujmJOSUbEVDZ
         WCEe4xygHQ6lZIVY93xZ7p9C0EGWRNSQNBDUM31hW06oNQc1eaA3HYWHCRIBrk5RPo61
         9jJr5n6CRIFG1/9IA0NNq3oN0xY+E9ABUGsGJ0rGs4Vom+Yyn7S2IX12/kPGSex+ELn/
         lkPYXT/ih650sGL10blmBIB9IjU9JDvhQsfCE21woYvsV7wJw6rc+SgelfHnn4OntIyq
         VxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755973656; x=1756578456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gXnziTBw7UP0Qc7D/AAchtEa0GCcVLQfrOFVsu3rHR4=;
        b=gFO6VsDirnO6lVn1eV2ACXMIVF38iKgGvqmArv3udYDlYCnRtWKcGDdieFaRzeE9ca
         wPSnQ4KDBxfdwtkE20QZiPXjsITEogo41OyNp33OA7GoXBvHkiL7ROseVdwczdxUQVzn
         evjY4WiIPET9cpEkOqXq5wZB5ckR2pUcp4wxfsbJgjgzeQ30tAHXTYhS65VXEMu6S1JR
         l5SVi2pQNVmLfAJAAPvxqozPjueHxoj7HXQy0vjutTJAw5mtpXUYDJ72yXp1/a7CQhdg
         vYrsQ7ZDUomBYDGEm+kQiRUDRyNKI/8j5UPIIMLJPLGmAU34dlhOxX1anEmvTCo+FTey
         oZZw==
X-Forwarded-Encrypted: i=1; AJvYcCV1VHyHXGMr9IAu1I2KnqvECpF16Gn2R1/982V+j4oS56xIqNyEpe1iU8mU3AdXNYegXmDG/G2U717IN+4=@vger.kernel.org, AJvYcCVQZtl5vO6E4+UPz0gvhKR53SnDzwINQ+4zfPD+IGtd0njt7B5cuIBvhwK8KGk2kx4eZmvGDSdc@vger.kernel.org
X-Gm-Message-State: AOJu0YwLRMXpCU+LRkING5Fkf26IV9hO64btaXMx1OrRc6/67FCd7iBg
	XLA+gQVBI8Z7p2lV9s4DO/sxzQFVaAfUa4HGhe19mU/dGViVJPfgLl20
X-Gm-Gg: ASbGncvF5XJB0rd2+SyeMSu/dNGcG7XO0fUhAbvser2H70Is6qiUS3zO1EwD9YIGGhS
	O/iaabm/Svs5NJ8Ues6eK2jZCeFWY572AZQ2APt9Z2Zws2y8YhLWt+RZjHIezq7DCXj4ArYGmLn
	21z1R6MLpkGOO8JreRV4URfxfW544Pd7JgAKJphC2Hn6F+A1wKXR/lEm7EK5H6sNAgIELxJdUOg
	8iJCCE4U/ES/QIZfBm3MZkcPwQLEqmbuPs3xFRtW5sSBebiuxbbJue3iE3/uUXGupSsaNuRWFD9
	1pxzB4xeOZDSnxWav8/SV74nQ5LjkpFbtBQoDujLuIUPKfUv1PsSxa+IMpa6+ZIVq7GFgWTJyHa
	NTiPVCjhtnhJAQqfiohAu3QShwe2in/363N4XuodllF6fkZCw8g==
X-Google-Smtp-Source: AGHT+IHHsu26uhRGS2VEMcQXkzG9XqnSv5HsmmjeJckuRco0jP/Cr3o6xLlULPJm4kWDO22cl069sg==
X-Received: by 2002:a17:903:41c6:b0:246:a90e:9179 with SMTP id d9443c01a7336-246a90eaf13mr3374155ad.28.1755973656315;
        Sat, 23 Aug 2025 11:27:36 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cbb7ae2dsm2779012a12.28.2025.08.23.11.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 11:27:36 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	akpm@linux-foundation.org
Cc: leitao@debian.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] mm/hugetlb: add missing hugetlb_lock in __unmap_hugepage_range()
Date: Sun, 24 Aug 2025 03:21:15 +0900
Message-Id: <20250823182115.1193563-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When restoring a reservation for an anonymous page, we need to check to
freeing a surplus. However, __unmap_hugepage_range() causes data race
because it reads h->surplus_huge_pages without the protection of
hugetlb_lock.

And adjust_reservation is a boolean variable that indicates whether
reservations for anonymous pages in each folio should be restored.
Therefore, it should be initialized to false for each round of the loop.
However, this variable is not initialized to false except when defining
the current adjust_reservation variable.

This means that once adjust_reservation is set to true even once within
the loop, reservations for anonymous pages will be restored
unconditionally in all subsequent rounds, regardless of the folio's state.

To fix this, we need to add the missing hugetlb_lock, unlock the
page_table_lock earlier so that we don't lock the hugetlb_lock inside the
page_table_lock lock, and initialize adjust_reservation to false on each
round within the loop.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+417aeb05fd190f3a6da9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=417aeb05fd190f3a6da9
Fixes: df7a6d1f6405 ("mm/hugetlb: restore the reservation if needed")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
v2: Fix issues with changing the page_table_lock unlock location and initializing adjust_reservation
- Link to v1: https://lore.kernel.org/all/20250822055857.1142454-1-aha310510@gmail.com/
---
 mm/hugetlb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 753f99b4c718..eed59cfb5d21 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5851,7 +5851,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	spinlock_t *ptl;
 	struct hstate *h = hstate_vma(vma);
 	unsigned long sz = huge_page_size(h);
-	bool adjust_reservation = false;
+	bool adjust_reservation;
 	unsigned long last_addr_mask;
 	bool force_flush = false;
 
@@ -5944,6 +5944,7 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 					sz);
 		hugetlb_count_sub(pages_per_huge_page(h), mm);
 		hugetlb_remove_rmap(folio);
+		spin_unlock(ptl);
 
 		/*
 		 * Restore the reservation for anonymous page, otherwise the
@@ -5951,14 +5952,16 @@ void __unmap_hugepage_range(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		 * If there we are freeing a surplus, do not set the restore
 		 * reservation bit.
 		 */
+		adjust_reservation = false;
+
+		spin_lock_irq(&hugetlb_lock);
 		if (!h->surplus_huge_pages && __vma_private_lock(vma) &&
 		    folio_test_anon(folio)) {
 			folio_set_hugetlb_restore_reserve(folio);
 			/* Reservation to be adjusted after the spin lock */
 			adjust_reservation = true;
 		}
-
-		spin_unlock(ptl);
+		spin_unlock_irq(&hugetlb_lock);
 
 		/*
 		 * Adjust the reservation for the region that will have the
--


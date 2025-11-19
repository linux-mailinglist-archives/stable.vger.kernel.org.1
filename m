Return-Path: <stable+bounces-195136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A5AC6C3E7
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 02:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 22DF3351F9A
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 01:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF4E22DFA4;
	Wed, 19 Nov 2025 01:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RW/1vCrk"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703502309B9
	for <stable@vger.kernel.org>; Wed, 19 Nov 2025 01:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763515599; cv=none; b=YrCfGQtas/y0LWmcPc/L/rxS3kacI1qj0T3Y+t6XMsyTFXmcS2QYlDPBdBEyFbUiB+dmpvgB9XjtoM1gcqsV8+YyjGyR7oab/CD/Qa4KSAKanKG0j7cIKGqwitnhY8ubfpQDXCjC/H4wFGjvA4Ksb1eQ9sc/LAAmkiA7yBY3kMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763515599; c=relaxed/simple;
	bh=0Fe/7tllYBnarEVIgWF2aUD4Tsipq+TS2V5IfXhhkXo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=OQVfyKqiRjeu97voQGrzK7oviHOJBjnDXB28E/2NHEBSeqRXaVcfW6+MitndeZ+9Jz1Xaynp2OmawuFBstmgMlh8F1Jj/1LgnroqE5BUqXjaXAgC2GH7C+oH6Po/VP/7b75QI3xyH4cfsNzJC6yU6t5Uhm4K6DSQMEtMCisFEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RW/1vCrk; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b7370698a8eso639872066b.0
        for <stable@vger.kernel.org>; Tue, 18 Nov 2025 17:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763515596; x=1764120396; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/k7vekq5uifkJbSVciIjngOCcc9K2Bjv96liQeZ5afs=;
        b=RW/1vCrkxhwsjmssGCdvq9LNFOL/fpS6TnqwK/zoX3AWyIM/VFBOHo+Mqg48Ex/Bm4
         +iqpZMGjOZ6jb/40L18dBK5pVU4x3ZFwSRzg3rOqYr9PgnodVUE+lQkJbU8An/iI89df
         +VCsWGZeiKVzEq5nd9y1GoAWi/iZ2MsxfOknBT/uo0ePay59TcZlyfUpE3Lu16t+XISG
         11sN/WhIRtczjV0HqxBXKdgIDdPsqvv5ri39PUe2hL0i2pShfFAJsbwyHzaZVCWVwqmZ
         Hdxzwr4GhqOn7P6wx2sxRCpkRoHGn3m5poHkOfMhLF7iw9YsPRvdVW2Bv3QOfcksCG9T
         M9iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763515596; x=1764120396;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/k7vekq5uifkJbSVciIjngOCcc9K2Bjv96liQeZ5afs=;
        b=vygHZ/Ny+gsf2rS60u4fzZDSrzb19WKZDnJ4RY9xZ3/bprG7+Ofgg50mGuN0k/iiFY
         1ZPFTw0ZlR5EyXbzS3MgXKMgZlnREFDKNYlJy9FWH4KFeSBTr94WLzBmSuBd2Og+Mx9m
         wgu7lpImn9eeu2Td3g0uVUjxBL9WspzYWQbDqjDo+jeFLaK9HSZKxV8AWjbB/zeSCzEp
         pm+NE5NPRqy5o99f6J6nZ4Xo98oRyL7qLKVJk2x3U0t/AFmhkSYO51hnHMJsOblW1Gpm
         FQKuFW5rG2ihOpzMcc9VXKD8m2rYHxI8Ql1LddXgDUKYKd7v2CKwyl6EHifSgEwIWoUZ
         2vwg==
X-Forwarded-Encrypted: i=1; AJvYcCVQYBRbCg78Uf2SFCaGOO0rsy9VskBBJIs0lN27Ec4DRZB01kJu5xPN7rUzvQeNcLeDTU75ds4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf+4MuMGjW9GeNVanAMNNZOZC78ypOUyauPNOcqzRO3Xept2GU
	9/VnaPeee7QHkUh6SLhI+Tgh0qi6WTcf6H/KsT2WbaVtJTrjVseN7b+D
X-Gm-Gg: ASbGncsfOAoL/YaZLffv6TawN/KckM1Sm23UoLYMSXoQqBlP4EI0Oka06pW78uhL+f6
	e6VEyPShhvjAmDmBe87YmuD0E7MYghIK7vE4zFyYFL3OTZzwce1CQmYVXqC+E2OMU6hw+Zu+AzN
	xqTHy4NuQjjVxYtoWKkJGDbZhzo84w437za842IxchGPA8qyr9gajkHg1XpV8kLXWezDA9LMbbK
	uE6eZpXnDz1X9TU6xn04xg9eMYHl5RR9lIU8KXmm4coJQFGGc55uHrjBAcgjalY/sLgmAqGPT5b
	fyxk50j+BJVgmPn9EgmiIE7h592hUOK+Ktce5NhPFl+of8/Vk4uAIS2Du16S/V9Xh+fMzcXcw0m
	4XcY36eulY9HlUGXwH0AQITf/afSPwhzF3yu8oYJs8gDHoVNoLdevr2tfswzdA2rmW+dFbT+mQb
	9rKMLJDz3w/m0Vun14trvRt1haoT7wsSLnPXY=
X-Google-Smtp-Source: AGHT+IFnyktwM+fGRh8zm7gxJxVmJhx+iTUvB4u1iys1ibCwKjNj95d1Xy05vA9leU7Z2ItSgFpyOQ==
X-Received: by 2002:a17:907:6d0b:b0:b73:58b4:1247 with SMTP id a640c23a62f3a-b7367926438mr1903786166b.25.1763515595525;
        Tue, 18 Nov 2025 17:26:35 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fedb91bsm1471579766b.70.2025.11.18.17.26.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Nov 2025 17:26:34 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/huge_memory: fix NULL pointer deference when splitting shmem folio in swap cache
Date: Wed, 19 Nov 2025 01:26:30 +0000
Message-Id: <20251119012630.14701-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Commit c010d47f107f ("mm: thp: split huge page to any lower order
pages") introduced an early check on the folio's order via
mapping->flags before proceeding with the split work.

This check introduced a bug: for shmem folios in the swap cache, the
mapping pointer can be NULL. Accessing mapping->flags in this state
leads directly to a NULL pointer dereference.

This commit fixes the issue by moving the check for mapping != NULL
before any attempt to access mapping->flags.

This fix necessarily changes the return value from -EBUSY to -EINVAL
when mapping is NULL. After reviewing current callers, they do not
differentiate between these two error codes, making this change safe.

Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>

---

This patch is based on current mm-new, latest commit:

    056b93566a35 mm/vmalloc: warn only once when vmalloc detect invalid gfp flags

Backport note:

Current code evolved from original commit with following four changes.
We should do proper adjustment respectively on backporting.

commit c010d47f107f609b9f4d6a103b6dfc53889049e9
Author: Zi Yan <ziy@nvidia.com>
Date:   Mon Feb 26 15:55:33 2024 -0500

    mm: thp: split huge page to any lower order pages

commit 6a50c9b512f7734bc356f4bd47885a6f7c98491a
Author: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Date:   Fri Jun 7 17:40:48 2024 +0800

    mm: huge_memory: fix misused mapping_large_folio_support() for anon folios

commit 9b2f764933eb5e3ac9ebba26e3341529219c4401
Author: Zi Yan <ziy@nvidia.com>
Date:   Wed Jan 22 11:19:27 2025 -0500

    mm/huge_memory: allow split shmem large folio to any lower order

commit 58729c04cf1092b87aeef0bf0998c9e2e4771133
Author: Zi Yan <ziy@nvidia.com>
Date:   Fri Mar 7 12:39:57 2025 -0500

    mm/huge_memory: add buddy allocator like (non-uniform) folio_split()
---
 mm/huge_memory.c | 68 +++++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 33 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7c69572b6c3f..8701c3eef05f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3696,29 +3696,42 @@ bool folio_split_supported(struct folio *folio, unsigned int new_order,
 				"Cannot split to order-1 folio");
 		if (new_order == 1)
 			return false;
-	} else if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
-		if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
-		    !mapping_large_folio_support(folio->mapping)) {
-			/*
-			 * We can always split a folio down to a single page
-			 * (new_order == 0) uniformly.
-			 *
-			 * For any other scenario
-			 *   a) uniform split targeting a large folio
-			 *      (new_order > 0)
-			 *   b) any non-uniform split
-			 * we must confirm that the file system supports large
-			 * folios.
-			 *
-			 * Note that we might still have THPs in such
-			 * mappings, which is created from khugepaged when
-			 * CONFIG_READ_ONLY_THP_FOR_FS is enabled. But in that
-			 * case, the mapping does not actually support large
-			 * folios properly.
-			 */
-			VM_WARN_ONCE(warns,
-				"Cannot split file folio to non-0 order");
+	} else {
+		const struct address_space *mapping = folio->mapping;
+
+		/* Truncated ? */
+		/*
+		 * TODO: add support for large shmem folio in swap cache.
+		 * When shmem is in swap cache, mapping is NULL and
+		 * folio_test_swapcache() is true.
+		 */
+		if (!mapping)
 			return false;
+
+		if (split_type == SPLIT_TYPE_NON_UNIFORM || new_order) {
+			if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
+			    !mapping_large_folio_support(folio->mapping)) {
+				/*
+				 * We can always split a folio down to a
+				 * single page (new_order == 0) uniformly.
+				 *
+				 * For any other scenario
+				 *   a) uniform split targeting a large folio
+				 *      (new_order > 0)
+				 *   b) any non-uniform split
+				 * we must confirm that the file system
+				 * supports large folios.
+				 *
+				 * Note that we might still have THPs in such
+				 * mappings, which is created from khugepaged
+				 * when CONFIG_READ_ONLY_THP_FOR_FS is
+				 * enabled. But in that case, the mapping does
+				 * not actually support large folios properly.
+				 */
+				VM_WARN_ONCE(warns,
+					"Cannot split file folio to non-0 order");
+				return false;
+			}
 		}
 	}
 
@@ -3965,17 +3978,6 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 		mapping = folio->mapping;
 
-		/* Truncated ? */
-		/*
-		 * TODO: add support for large shmem folio in swap cache.
-		 * When shmem is in swap cache, mapping is NULL and
-		 * folio_test_swapcache() is true.
-		 */
-		if (!mapping) {
-			ret = -EBUSY;
-			goto out;
-		}
-
 		min_order = mapping_min_folio_order(folio->mapping);
 		if (new_order < min_order) {
 			ret = -EINVAL;
-- 
2.34.1



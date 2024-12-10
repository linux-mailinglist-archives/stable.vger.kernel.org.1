Return-Path: <stable+bounces-100375-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF14D9EAC6D
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 10:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83032169699
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 09:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04DD22330F;
	Tue, 10 Dec 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iR09sli1"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A54A223300
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733823286; cv=none; b=H2tHBV4X5z2b0WlTeg2zcxCumcPiW1bzJpGfUmiek2dU0+j1DzD671zry9icJKDquF/eDYbYledc9KQqfuxlVH7NzqfMCCDXtrKwld38ZjymNMsUZ7n1Eyop+YnYwmNo3wX/GV3yxq6i+wmLnA9sVjDR/HuTFJ3c2zjysl2RF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733823286; c=relaxed/simple;
	bh=ElXP8yFZ6wrLbaHVXnASfKVk5yiYGrY60JXxHO8wEt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SARGBCiutFd8pXG6fF5aF552h3b+uZYjz44rCq6xNri3zuNKxEzT75mjxjyhtVcJMxXI3s+HxhJsuEvd5TW/yWg+FuYbFNXiOzoocFSdelGHvEVNuUl2QtMx/sVg+IjH7AjhrxTGOiEw1KYlNBjRTBRxCgTtooICdhOw/8m0fXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iR09sli1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733823282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aJTE5aAWIDEa6vwoKjHOaUlIQUcp6L018sbCgFuL3Us=;
	b=iR09sli18370tAwj7rHyxi/Xs5nU8JmBmne4jUOPj64JMAITTJZDiPqxz2FDBHaC5Wk7ZS
	VcGfK1gh6l0eJ/p75CzVkMOSysUrU3+qVlowDi05KQZJr+BDd3rfREG6fdJM+bbgNrDBsH
	ahpa4f4mVP5RSQvghdxtj2CIaPHYk4w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-LRsY3aXbMUicTgwA4mwelQ-1; Tue, 10 Dec 2024 04:34:41 -0500
X-MC-Unique: LRsY3aXbMUicTgwA4mwelQ-1
X-Mimecast-MFC-AGG-ID: LRsY3aXbMUicTgwA4mwelQ
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434f0206a83so15478355e9.3
        for <stable@vger.kernel.org>; Tue, 10 Dec 2024 01:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733823280; x=1734428080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJTE5aAWIDEa6vwoKjHOaUlIQUcp6L018sbCgFuL3Us=;
        b=L5G3hn9UNc2gQFAoWOF/5kZbGk7XMJqBEMF88W5mYOeyedYi53312qHd74XPiBwyKy
         FUkQUfuSTvEY87Q7fiXkH9RHpOaY5cnCDKdHK9OyJWY58SQRi6FCti4RMmwlq4Upw30J
         89ot3bKUQsAwVuveifsca8FGjlITxsuBS8HF1/gaPxtn8yakw4IYDq6qwGuzGfpLViLL
         7x1CycO+gs5mimFBvXE165n7ddPduvqsDXtNeEVF7mZux3x+dmqTuPc3z2OsRCzSLYpW
         JySgsl44hCguhN1B1ekZ+uk/17GR2sS4v+Y2iTzfLc4ELnQEu8HSt0gn/Id9CJAg7KKB
         lZIw==
X-Forwarded-Encrypted: i=1; AJvYcCU63eQrujvxBRj4TI18VZoIWR5I6rd1a+wFBqZiVJXPB7rSa+CQegB6x7++DHCQFCyomxE4if8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxphRMi7+ts9k9RZqjS41F9DfrUTeT7IBYZO1zKDLvzBfsci9+s
	3bjxPFyFRcdc2xtJ0CclmsMKkNqxd+ijpAGJJLbB2zpiQcXGo1+H4+z3cONJVXOhPAnHDiILfIR
	6WjYuFsNf/2pltaUHuDkfUTU3o28fQHkviBUgcHn2oFEq9qOkwbszkg==
X-Gm-Gg: ASbGncsbXrbszSYa4irapqrVO7jkXpyeKfbK4u3uJ+x/g0v27lIAFgL6+sAxKe1uSeQ
	dCWL5jPzzJ0kyDszz20ttSbCUZMh52/M6JZhYwHlnilsPPrX78rbY9aoVmL9eMdVhm6ysJW3uDH
	NpTc1v6gLhI7emPMP4SsLmz6JMEaUKHjKvWg6hEyh+d87e8UnzR/R45qq+TCpmjJJ0AvDDIKFSr
	uyjCu3wzYsw1SqJoa96ivgR8phRKmaRmY7Wukuis8mu8GKiK8bYjen4G8Vw4Y9AFyBTJruVFuQ2
	4TadWbVZyAdBd/xduE7qYCVFYHQ71gZc9orOLzI=
X-Received: by 2002:a05:600c:46c6:b0:434:fddf:5c13 with SMTP id 5b1f17b1804b1-434fff4b38bmr31213415e9.14.1733823280334;
        Tue, 10 Dec 2024 01:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEiSIcThERj1j+yIda8YMpOdaSblizl8osiTYt8iJ3IApoHVuyuGpAwgTEfZiyREhYWF3Jphg==
X-Received: by 2002:a05:600c:46c6:b0:434:fddf:5c13 with SMTP id 5b1f17b1804b1-434fff4b38bmr31213175e9.14.1733823279931;
        Tue, 10 Dec 2024 01:34:39 -0800 (PST)
Received: from localhost (p200300cbc723b8009a604b4649f987f3.dip0.t-ipconnect.de. [2003:cb:c723:b800:9a60:4b46:49f9:87f3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-434faeda409sm54729765e9.7.2024.12.10.01.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2024 01:34:39 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	David Hildenbrand <david@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Yu Zhao <yuzhao@google.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] mm/page_alloc: don't call pfn_to_page() on possibly non-existent PFN in split_large_buddy()
Date: Tue, 10 Dec 2024 10:34:37 +0100
Message-ID: <20241210093437.174413-1-david@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In split_large_buddy(), we might call pfn_to_page() on a PFN that might
not exist. In corner cases, such as when freeing the highest pageblock in
the last memory section, this could result with CONFIG_SPARSEMEM &&
!CONFIG_SPARSEMEM_EXTREME in __pfn_to_section() returning NULL and
and __section_mem_map_addr() dereferencing that NULL pointer.

Let's fix it, and avoid doing a pfn_to_page() call for the first
iteration, where we already have the page.

So far this was found by code inspection, but let's just CC stable as
the fix is easy.

Fixes: fd919a85cd55 ("mm: page_isolation: prepare for hygienic freelists")
Reported-by: Vlastimil Babka <vbabka@suse.cz>
Closes: https://lkml.kernel.org/r/e1a898ba-a717-4d20-9144-29df1a6c8813@suse.cz
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 48a291c485df4..a52c6022c65cb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1238,13 +1238,15 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	if (order > pageblock_order)
 		order = pageblock_order;
 
-	while (pfn != end) {
+	do {
 		int mt = get_pfnblock_migratetype(page, pfn);
 
 		__free_one_page(page, pfn, zone, order, mt, fpi);
 		pfn += 1 << order;
+		if (pfn == end)
+			break;
 		page = pfn_to_page(pfn);
-	}
+	} while (1);
 }
 
 static void free_one_page(struct zone *zone, struct page *page,
-- 
2.47.1



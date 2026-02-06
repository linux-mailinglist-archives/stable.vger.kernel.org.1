Return-Path: <stable+bounces-214694-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCdjEmMohmmSKAQAu9opvQ
	(envelope-from <stable+bounces-214694-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 18:44:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E21E10149E
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 18:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 955083059F26
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 17:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472D43B5301;
	Fri,  6 Feb 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIGw1jqk"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7ACE330B13
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399625; cv=none; b=jL+qm2duE2Ssy+TXddgNZ3ocvkH6v5ZoPyqtLzy23p/BMVYpBZ6HDYLox45ZXVj/nRIsQK3LFJZeATxgntux4kn7X1yNTVf4wDd8O4x4v/RY9KjW6Yv99Ro8m6QeQKUoiKHHJB7BQzHUiGni/Q3DHT2PVA6qme6qx4ZPZErk668=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399625; c=relaxed/simple;
	bh=ETeUJ92YsLQF8cr3/U9Mo4a4EvBcF512LhVaTX17na4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Li/bosYVtaucaZUzpmN5TihuPw8WkhLNCKiU7cyUW0xfx4NTmwDTXqA+NxIXMjJxhxtLo0V4hlHu/fvzs4JD2lK46lmzwzAcVdHLhQauMjZNXrD/ha6lwe3IdwHRYhJDSSKKaaWd2e/ABbzmbntN7mFpGi0Ll1J7yfb99RrKfOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIGw1jqk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59dd7bfeb8aso2959376e87.0
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 09:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770399623; x=1771004423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pcYUP41h1qvxc4IslgWl6htM1/R87B2mcOvIwOAbeo=;
        b=TIGw1jqk4ay+nDnm87Ex4VvuvOpuHP4UYYQqC01wJuX4+CzwRLyayBHGUM8nPHvOlz
         jsPdm/hWXsS+P+Idxxs9s8XfkkOBMjRMov/xTQeSyfkLUGQC9t9fssW/Q9t3yh/x7DJL
         H+CYbcGieMSxXI9WIPHrQlF+12E9mXSXy818iYKWUUcYJMBXcZ36AgffYCbP5BJA2lxJ
         nkjPmGL2AwvR+xWXXPhotqth+QDb1xkh5qJYISEt/ECuscNkAxCn1ZD2haaqGvb+UYJ0
         wOCP63AaUKlttmegH3osBHtWPKQyerY1ZuxJhEpFiEk4VYQ3K62DElu+jpq8isLuP9D6
         Q2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399623; x=1771004423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4pcYUP41h1qvxc4IslgWl6htM1/R87B2mcOvIwOAbeo=;
        b=Go+kMZmquDOucaCjfXsD39OdMKCVH7JqUOATWs4+TXMo84ksP1xeckx0Azx1tLQzys
         BXMaks4iGTVltvvswakTbxrORE9saLvPm924W2vtpCOX+3s5P/znZfbpIqv+6WKqIula
         E/PUBxNh+Zty7M4wbk9Uk+XX+NE/CFcWHrgJAkbJbpQsz0OOsWSVhjrJz0i8itkjVv6S
         vdq0nduNlPESwzoSGIWcFcxfGgjoQDV1xbkdyWt6TVehREsHLZGq0HmNfM8sVT+tgw00
         Z6t5UXPY2LI6X9KetZAFHjaD75z/5L8lm86/NUTIOQOqXJXrLaQDyhFJvWti8RHaz7DT
         rrRg==
X-Forwarded-Encrypted: i=1; AJvYcCUbdUuOU9dCa/31X4YwqPbgrVchRob8jGUqvaR2dPUBAQDUZJyjCwt+CM9/x6K2wGBOSTucDno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF88DROUNfoQBCfpfKoJ6sDenap2knNy1LXB6CNFbbuOexwus1
	6zdQdV73V3yzN3l29DVBLnq7sMAGty8DvGIPgKRQI2KcYXWYQ0PSKid/
X-Gm-Gg: AZuq6aIb+da3Qwx8gDU5nppDqWalhP0ctRBMI/lExr6OY92yREBP11hRLzDWRjkHlEd
	DAOl2m4VVpuA3ZgKjxx63A3Fufd2+whhg3C6BumlWB5fVgTkXMvCIhTIz+z6O3ARKfnFSzfJoLy
	KeVOe+sa4rhBJx4nb8E/GfsBh7XReDGv/MJuR3Tsh1tD5Ot2vCB2x/DZb3X7NWkQu+V6w5Szh0u
	sEqjOpcoVWfgybqKHT9JXPTG+TFbH5+umaygkaYdfUwpcQ9qWjDDtJ5rGAZk6mfk7qeQsm6dCIS
	Vf7jpLpsvK6eC1OG6TBAL/6A4Hw+PGVAWymPhyhb6iDEWadICtjLjeJRVSUMFbS1/Ig3N5lHQVe
	GKAqbHNLjqj70cjg7fS1q+kbtbGuopx2RzRjAkFglutjXcz7iO5ZgeGcHLjIAyah87Y6mptff0a
	MN8VrsbIX3Tgvial0bALZDcg==
X-Received: by 2002:a05:6512:b92:b0:59e:387f:bf97 with SMTP id 2adb3069b0e04-59e45050a14mr1113338e87.21.1770399622667;
        Fri, 06 Feb 2026 09:40:22 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44d00890sm772907e87.38.2026.02.06.09.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:40:22 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	vbabka@suse.cz,
	chrisl@kernel.org,
	kasong@tencent.com,
	hughd@google.com,
	ryncsn@gmail.com,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/page_alloc: clear page->private in split_page() for tail pages
Date: Fri,  6 Feb 2026 22:40:17 +0500
Message-ID: <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-214694-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,suse.cz,kernel.org,tencent.com,google.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E21E10149E
X-Rspamd-Action: no action

When vmalloc allocates high-order pages and splits them via split_page(),
tail pages may retain stale page->private values from previous use by the
buddy allocator.

This causes a use-after-free in the swap subsystem. The swap code uses
vmalloc_to_page() to get struct page pointers for swap_map, then uses
page->private to track swap count continuations. In add_swap_count_
continuation(), the condition "if (!page_private(head))" assumes fresh
pages have page->private == 0, but tail pages from split_page() may have
non-zero stale values.

When page->private accidentally contains a value like SWP_CONTINUED (32),
swap_count_continued() incorrectly assumes the continuation list is valid
and iterates over uninitialized page->lru, which may contain LIST_POISON
values from a previous list_del(), causing a crash:

  KASAN: maybe wild-memory-access in range [0xdead000000000100-0xdead000000000107]
  RIP: 0010:__do_sys_swapoff+0x1151/0x1860

Fix this by clearing page->private for tail pages in split_page(). Note
that we don't touch page->lru to avoid breaking split_free_page() which
may have the head page on a list.

Fixes: 3b8000ae185c ("mm/vmalloc: huge vmalloc backing pages should be split rather than compound")
Cc: stable@vger.kernel.org
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 mm/page_alloc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cbf758e27aa2..3604a00e2118 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3122,8 +3122,14 @@ void split_page(struct page *page, unsigned int order)
 	VM_BUG_ON_PAGE(PageCompound(page), page);
 	VM_BUG_ON_PAGE(!page_count(page), page);
 
-	for (i = 1; i < (1 << order); i++)
+	for (i = 1; i < (1 << order); i++) {
 		set_page_refcounted(page + i);
+		/*
+		 * Tail pages may have stale page->private from buddy
+		 * allocator or previous use. Clear it.
+		 */
+		set_page_private(page + i, 0);
+	}
 	split_page_owner(page, order, 0);
 	pgalloc_tag_split(page_folio(page), order, 0);
 	split_page_memcg(page, order);
-- 
2.53.0



Return-Path: <stable+bounces-214812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPX2K194h2nYYQQAu9opvQ
	(envelope-from <stable+bounces-214812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 18:37:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 055FB106BA7
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 18:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82870300F9C4
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 17:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C9B33ADB4;
	Sat,  7 Feb 2026 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9L1q5I5"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C932DD60E
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770485852; cv=none; b=iWERF3sc1iAKp/VxU4AwWGVQEunk2MfguwCvLcSlai/bWcvhvkAP/BmAJXFynuKZNHRwjqCIKNSrnxlB1hSUbXNbu6M6xWsJ2pz+IdvQoDVVMJimPHnCZoM1qgVUhmQsTRfi3H0PUXsMvPMNJ6rpOLU5/dTdacBC6wtTum/t1ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770485852; c=relaxed/simple;
	bh=E4fISVo2NO2WKZ/cPp0LpcDWkQPAsw8bdND+t6VEag0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iO4sJ1J7znOnSRavPE71oBs6MH5C4kITEJOZraa/CU3CUHOpyLErEzkFqRDKulHVxoqqKEYsVRIuUayu5MaUHztxt4yuIgxVeMiHViKHBvef2ISKP6SBOqX+k1OnBOmkLneznW90sCYa5J2w+tMb86wdj5PDD9L0qgx9zIrAhIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9L1q5I5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e3810df30so3740904e87.0
        for <stable@vger.kernel.org>; Sat, 07 Feb 2026 09:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770485850; x=1771090650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBcixq1sa+YFWzLNdSovpimwkwmojM9gmgxcC+Ozzp4=;
        b=V9L1q5I54faY3hJl4daFHkvTZzzJcyHx6Je6OAUA6USikr5WltVZGdMkQmW57bRhOR
         dCfzU7HQPnx4LmxHc1O9F/Flnzsh0BjR/ANw/mnAoA/PjS90+LNdVbobmYSjfEwha8/4
         +ScXFrbsOaiMtF8lyK458turwLxyxIQrVXf9oFiM94FQSTSSbAwNP9EmNHGOckZzISFq
         MfyxgBT0PZp3zNkZKeXf+1Thi1lEQskyi0X/hehhxMI3hl2RMtPBBMOa+1tSastRLiUd
         zK2eT2C+1kVqTqlDJHO4KrUNAbXAwgsKWhogB+ztiXZQV5Op+ferpvhsANwsQdOwJIBI
         Q1cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770485850; x=1771090650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OBcixq1sa+YFWzLNdSovpimwkwmojM9gmgxcC+Ozzp4=;
        b=odnXohIgKD6wtbYo6uKjXY3xUDxiVx8kmLc8azrkqQvXmIA7BVzb3insV8bLtv8QiI
         CZGcOA4O/MZAzrY0B8XDFFBQpn7g1nKJSPFhRZjzFAp06cScbdadihF8EJCYctO9gS+r
         iMrvJP89n8EsJBSDiNUBUpkWfcljucpnuDD2RoEaKfKTmIxGAJ+fvKy0aU/m0xYEOheG
         Ox00QRuHPLGnkg36/i+J/VVG+sfhudsZ5926+ikS+dG7rGqX0nHuuJzSDNJdyTcnMBfY
         sMx7hLdquC8PelVPz7f4M4Vigv3wWxU2L4vQhjQ3y7kVZWeQKFXvkM6x56EO3qS/G5gh
         kIJg==
X-Forwarded-Encrypted: i=1; AJvYcCWMP4r/h+vmYxGybuerUEyd5ZVntfHRv1nlb7gfHzVL6qf4H4JZtjKte4cXtRUbjGYI+hXoJGY=@vger.kernel.org
X-Gm-Message-State: AOJu0YydQyuegk1Fyh9CuiGhpdDhy2pKt+8RztJtuA+wI5rvMOZuhgVB
	KoC+C2OBGqXNAD3QA+RyIZwj01j8OzG/0Hmdd1PzcVE/+ezZ7HpRsriy
X-Gm-Gg: AZuq6aKwUy5WH3KsnAiA7q77+gNRBuahyfL0Fp4lEBIPcu9iqbvlhYvNlOs6xbpow4a
	9kIBZO8CLc4DTcQ7euPKuHJn8n5/R+xCGLGJ/g47VDtN3/BjmYw/nPfR+dEKsHwz+GgZPubHZJF
	xePVVnrWnKg9+05Wgc8wwPTlxIvKeYwNV3Pjs4Wsna4gm/OGiLltOO2Yvo4nvhQNJLESwzO+/fQ
	97XmIHb+H6aC/QZQXCFf2RTV4psXkpxKa7IfMm945yUaKAmfSjOHXVDlNylLSk3wxYGAi5BzkMN
	UpqN0ntYMZGC64VD47fy8CFKQokGLu5okfN5DdpeeZQvxucdXuI4irU743snb9pUuYo996mChml
	X8xMlAV0uMn1KHc1xAIDc/P2x+iQF4opODcxf4U4vHy3hlgfkPp0rj44GvbDplOrY2J3nNaik8o
	PEiRTjhK9f2expU6UMKMKYWQ==
X-Received: by 2002:a05:6512:3341:b0:59e:a2d:daa1 with SMTP id 2adb3069b0e04-59e450438bemr1745187e87.5.1770485850237;
        Sat, 07 Feb 2026 09:37:30 -0800 (PST)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59e44cfd475sm1405628e87.29.2026.02.07.09.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 09:37:28 -0800 (PST)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org,
	vbabka@suse.cz,
	surenb@google.com,
	mhocko@suse.com,
	jackmanb@google.com,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	npiggin@gmail.com,
	linux-kernel@vger.kernel.org,
	kasong@tencent.com,
	hughd@google.com,
	chrisl@kernel.org,
	ryncsn@gmail.com,
	stable@vger.kernel.org,
	david@kernel.org,
	willy@infradead.org,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v3] mm/page_alloc: clear page->private in free_pages_prepare()
Date: Sat,  7 Feb 2026 22:36:14 +0500
Message-ID: <20260207173615.146159-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <209207FE-D3A9-4BE2-8DA7-9BE38A19F387@nvidia.com>
References: <209207FE-D3A9-4BE2-8DA7-9BE38A19F387@nvidia.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-214812-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,suse.cz,google.com,suse.com,cmpxchg.org,nvidia.com,gmail.com,vger.kernel.org,tencent.com,kernel.org,infradead.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 055FB106BA7
X-Rspamd-Action: no action

Several subsystems (slub, shmem, ttm, etc.) use page->private but don't
clear it before freeing pages. When these pages are later allocated as
high-order pages and split via split_page(), tail pages retain stale
page->private values.

This causes a use-after-free in the swap subsystem. The swap code uses
page->private to track swap count continuations, assuming freshly
allocated pages have page->private == 0. When stale values are present,
swap_count_continued() incorrectly assumes the continuation list is valid
and iterates over uninitialized page->lru containing LIST_POISON values,
causing a crash:

  KASAN: maybe wild-memory-access in range [0xdead000000000100-0xdead000000000107]
  RIP: 0010:__do_sys_swapoff+0x1151/0x1860

Fix this by clearing page->private in free_pages_prepare(), ensuring all
freed pages have clean state regardless of previous use.

Fixes: 3b8000ae185c ("mm/vmalloc: huge vmalloc backing pages should be split rather than compound")
Cc: stable@vger.kernel.org
Suggested-by: Zi Yan <ziy@nvidia.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 mm/page_alloc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cbf758e27aa2..24ac34199f95 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1430,6 +1430,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 
 	page_cpupid_reset_last(page);
 	page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
+	page->private = 0;
 	reset_page_owner(page, order);
 	page_table_check_free(page, order);
 	pgalloc_tag_sub(page, 1 << order);
-- 
2.53.0



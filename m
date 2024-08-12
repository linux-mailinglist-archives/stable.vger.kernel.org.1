Return-Path: <stable+bounces-67379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064ED94F771
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 21:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392811C21D27
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 19:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363A7190079;
	Mon, 12 Aug 2024 19:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JurFBh+w"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8729918F2CB
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 19:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723490675; cv=none; b=Tv8IazMHghpTA535G1wErNWNIjDXcbaJKUjqjSSP1URq7w+knRcWs+3VN8Q3vmX6QfG2KrtoJtSw80AFdk1OArvueQBLe2PVnRPuqkJ5iOCDpC7bXuMFMdfzHYjVksOwgDRhFQMhUZ5gA8q9yiIQMDg0a/gay2Ue7RhRvkVgE0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723490675; c=relaxed/simple;
	bh=NzKwuJoXzmUGF5iSUml9uWF6iwC3BNkDZKU4aU6MD3s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KsPTwQ8cNVPbWNPRVbuA2SriuKFKbMcrniJ1a1HzY6Ke6D7ZVLmT4OX9uYTsyVS4yjYBbYqgvIKNGcdWADmRuQieX8f7AoFKYU1SG+RafDyzPh8zZgT0FxN2f0bXSR/fF5mGaPbGgWwZE9NQ+U1AItUblBzdvW8oskOOMENLsG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JurFBh+w; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so8479799276.0
        for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723490672; x=1724095472; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yWxCowPUnixbfZzlA8QQGBp8dYSP6RfE8f5Q6sz/520=;
        b=JurFBh+wbtn5uStA7F1sQpTuIri8L1hxWBkk2z30CbjwQOBaGRwbkZ6swnD0kX+YX0
         b3u81bz47UtvnQobhCeLQIEX/qrGpo0HH4wUCX23sOOq20pSsLuN3zwWsVluV2BLn8X4
         3b3Umh2ZMtbaES9GzyTirmO6blEw6utV7NlUrj2SFlZf3FJNPsyY54x1Pt4JEdrbZlYA
         WMQGQ6Z/yKraq0urcVxCQsU93fjnPqfHBR4GSBP2TlBY+A0ICOMHJYxgqq/Y4c1vZOXm
         PjZNvqibj0+zsSq5kzakTEy95V1IQEzWawJraFggvhjJCTJ/wt0h2vStzOAct+L9RMrj
         xzCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723490672; x=1724095472;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWxCowPUnixbfZzlA8QQGBp8dYSP6RfE8f5Q6sz/520=;
        b=QQXvvrTMw3QV93kQY2KYYQ0y1rBxfJMmjpiGhY3lMTYxisDEFDKRKSTNJHHB6h7dCM
         k++DtbZ1VgTcqJN43QkhMRBwe7JI/Fi5/nEM0TgoVG/QG8pG+WsIw/qwwV27peGd31D6
         /X3i4XypEQ2AWD5pokH9jM50ax+2aTh5cOK6ZhSZvW61nPdccA8rm8aDT6VbLTP5j3/B
         7vwLyG0wfc6Df1Xd/fcpob/vMvemipa0PmkhOgOqqkJR+yC1AyB1ri/Y7XZBUDPfFMH5
         M4k9bwM7wZEk6hHGBbXltCvQ1djgXnVdqwmVgHIhPQlWDl2mhc5d/2h7jy1XZcurpKND
         3hoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU/DW8LvnI6nlkJ85lcfHhZpVj/4voNPGRBxB1yi2RrutiSUfILXqsbWHwk+skTt/2SoW54LXEzMMpbsbCYvEhjG0bM6mO
X-Gm-Message-State: AOJu0YxTUraq9gF+6WcifKCmaNBS7YTSd0oKqlWDhgFcLEeNu25DORrQ
	NFRRHPPj9AAPNrKH/Gq5+N7jNupf2a5L5waLt4m9/6Akl/vj20wmU5ZEIY2fNuAivVoPfEa3eDm
	FHw==
X-Google-Smtp-Source: AGHT+IHKisNvsfNZ3HwptFVUwpuAndJrP1cg0JwL0YzNRZLFI3LjSNR5DwFlUuA9GavrzBxidgbOnP1w9Ro=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3912:1e97:a514:421a])
 (user=surenb job=sendgmr) by 2002:a25:bc06:0:b0:dfb:1c1c:abf9 with SMTP id
 3f1490d57ef6-e113cd5ee6fmr74667276.2.1723490672597; Mon, 12 Aug 2024 12:24:32
 -0700 (PDT)
Date: Mon, 12 Aug 2024 12:24:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240812192428.151825-1-surenb@google.com>
Subject: [PATCH v2 1/1] alloc_tag: mark pages reserved during CMA activation
 as not tagged
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, surenb@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

During CMA activation, pages in CMA area are prepared and then freed
without being allocated. This triggers warnings when memory allocation
debug config (CONFIG_MEM_ALLOC_PROFILING_DEBUG) is enabled. Fix this
by marking these pages not tagged before freeing them.

Fixes: d224eb0287fb ("codetag: debug: mark codetags for reserved pages as empty")
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Cc: stable@vger.kernel.org # v6.10
---
changes since v1 [1]
- Added Fixes tag
- CC'ed stable

[1] https://lore.kernel.org/all/20240812184455.86580-1-surenb@google.com/

 mm/mm_init.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 75c3bd42799b..ec9324653ad9 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -2245,6 +2245,16 @@ void __init init_cma_reserved_pageblock(struct page *page)
 
 	set_pageblock_migratetype(page, MIGRATE_CMA);
 	set_page_refcounted(page);
+
+	/* pages were reserved and not allocated */
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
 	__free_pages(page, pageblock_order);
 
 	adjust_managed_page_count(page, pageblock_nr_pages);

base-commit: d74da846046aeec9333e802f5918bd3261fb5509
-- 
2.46.0.76.ge559c4bf1a-goog



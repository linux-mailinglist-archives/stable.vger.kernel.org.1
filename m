Return-Path: <stable+bounces-60489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA49343E3
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 23:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64BA1C21B5D
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 21:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C6187857;
	Wed, 17 Jul 2024 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v/WPp6RX"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C1187561
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 21:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721251729; cv=none; b=ikgYafW1zq0d8B7We7cxI9a6mKB8jHCw+bf8vTa5578S4zIv5SAFlR57E1M6iOmeMi5S8hLj/eH6NAp+2y9tA7qe1XSWYq9jnwzRzA/MAKO9OMQaqmqiG0qN5wQm0nvcpMHZNhCCeC5LdoB9gwNFA6pOA6BpKC2feiLL4ywFxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721251729; c=relaxed/simple;
	bh=hV+gOr49p4cocawq3YpFNMPhdSPOJ5ilUmbodlA9FZI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lRCubD1aWoddVIzbh5B1sQRz8VvjFdbgX2NaAue00dF74AOqV3MfufDXdCLGX2mHPKIzygRs8YiLgBujFzDc9lFqfOrfpdzH4+tFT5j29ZlmqAygg5HD+PAbV2lvv9v9vWQ+gE5mDK12j1ybU4Uk2GdjmyKPs0NdB2Ro4lYxDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v/WPp6RX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--surenb.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6511c587946so2388487b3.1
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 14:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721251727; x=1721856527; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bC1XYrE8D3FwqV+dReridNcLxNzpjkdxcOvL08MCL8A=;
        b=v/WPp6RXzAb8dRyANuKl13dRDZngyeiUccrWtTRzYSafen0oQTzdAP2TAAdXHXOnbS
         RidsXLjc3yjIJ+i9RQD2G/FRq/lDHZzlsbOfswiZAaZQy1Jtu7huWxdGocTV8N7BalFx
         UlNXtXLilp+PIavXdrr0S9dnP5Uz4TRbPVK0PUVhzU7ZB9wiR7USzuWYNYk/03la0F12
         PBWQ0IV2EVZ/dWgnHFNFEntNTm+ya7FdyScyQv/uXPkpWQ2D5UquT6BUde9jHVNirotJ
         xIs48WHmKZomzs4pQgrLW1cZl847sb1fw5izjaGZ4v7eQBLZ5lwVOD39+leZlastEwgO
         UaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721251727; x=1721856527;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bC1XYrE8D3FwqV+dReridNcLxNzpjkdxcOvL08MCL8A=;
        b=J6ySHMdjaJ8hrld60fGgMSmP0kRf+yrhr20AbrYCmW8Ro4SDM+G0yi397rR6WSRyzz
         ZxooDPVVrHv16hN+VKSt9yPnV0R1e9w6WJmeSD3CFhH9qcB+t5uFdO/XKWKkBpxTP3EC
         zfrVSF2442R50K6Carkv9tBfWqOarRIAssJwfZyXobuyc249/RAH1eixSee0nkt6acXO
         9Zh5eg3E0UZ6B2UYeDHVLr5rt5FdmH2zTTSuLS2MK9k/qgI3wjgcTA/GTcKtlDiH63ka
         2+ogrf2Mhy7QmkQlh+XILGrVW8Y90nHlw5I/+/QwkwjkaKQjhIUQmGUbVkW6EpgJW/SA
         QtsA==
X-Forwarded-Encrypted: i=1; AJvYcCWNRE2H7wwu9SNS3XT8HMXOC8HfD++kazCyP7y9c7/6bRwcdJq9iQ5dmYfQPVBqETO9V0CSr8+ELvANQi0Acco3mdRoeTGN
X-Gm-Message-State: AOJu0YwXa/XUwO1QcQyRggrZcZcj1wJLUSDKE7xLe33q/ZLmhByqSJhM
	F8/0NLIJKRrK0lVScnQw3w/CnLeJExT1en3YNTijrHa5AO2vhq11l3wrwoy+CM2EFFSCkVpg2TH
	rrw==
X-Google-Smtp-Source: AGHT+IFLgB2C6j0dFHpvLIU7N8gDZUpXVn/57H01SUptIZ7LA4eVWYxCTx/3TCCmKxlLkZBSM9SJzGCH+/E=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:f44b:e467:5c7c:74ab])
 (user=surenb job=sendgmr) by 2002:a05:690c:d8d:b0:62f:f535:f2c with SMTP id
 00721157ae682-6660248e324mr151227b3.2.1721251727081; Wed, 17 Jul 2024
 14:28:47 -0700 (PDT)
Date: Wed, 17 Jul 2024 14:28:44 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240717212844.2749975-1-surenb@google.com>
Subject: [PATCH v3 1/1] alloc_tag: outline and export free_reserved_page()
From: Suren Baghdasaryan <surenb@google.com>
To: akpm@linux-foundation.org
Cc: kent.overstreet@linux.dev, hch@infradead.org, vbabka@suse.cz, 
	pasha.tatashin@soleen.com, souravpanda@google.com, keescook@chromium.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, surenb@google.com, 
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Outline and export free_reserved_page() because modules use it and it
in turn uses page_ext_{get|put} which should not be exported. The same
result could be obtained by outlining {get|put}_page_tag_ref() but that
would have higher performance impact as these functions are used in
more performance critical paths.

Fixes: dcfe378c81f7 ("lib: introduce support for page allocation tagging")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202407080044.DWMC9N9I-lkp@intel.com/
Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: stable@vger.kernel.org # v6.10
---
Changes since v2 [1]
- Dropped the first unnecessary patch from the patchset, per Vlastimil Babka
- Added Acked-by, per Vlastimil Babka
- CC'ed stable@, per Vlastimil Babka

[1] https://lore.kernel.org/all/20240717181239.2510054-1-surenb@google.com/

 include/linux/mm.h | 16 +---------------
 mm/page_alloc.c    | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index eb7c96d24ac0..b58bad248eef 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3177,21 +3177,7 @@ extern void reserve_bootmem_region(phys_addr_t start,
 				   phys_addr_t end, int nid);
 
 /* Free the reserved page into the buddy system, so it gets managed. */
-static inline void free_reserved_page(struct page *page)
-{
-	if (mem_alloc_profiling_enabled()) {
-		union codetag_ref *ref = get_page_tag_ref(page);
-
-		if (ref) {
-			set_codetag_empty(ref);
-			put_page_tag_ref(ref);
-		}
-	}
-	ClearPageReserved(page);
-	init_page_count(page);
-	__free_page(page);
-	adjust_managed_page_count(page, 1);
-}
+void free_reserved_page(struct page *page);
 #define free_highmem_page(page) free_reserved_page(page)
 
 static inline void mark_page_reserved(struct page *page)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9ecf99190ea2..7d2fa9f5e750 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5805,6 +5805,23 @@ unsigned long free_reserved_area(void *start, void *end, int poison, const char
 	return pages;
 }
 
+void free_reserved_page(struct page *page)
+{
+	if (mem_alloc_profiling_enabled()) {
+		union codetag_ref *ref = get_page_tag_ref(page);
+
+		if (ref) {
+			set_codetag_empty(ref);
+			put_page_tag_ref(ref);
+		}
+	}
+	ClearPageReserved(page);
+	init_page_count(page);
+	__free_page(page);
+	adjust_managed_page_count(page, 1);
+}
+EXPORT_SYMBOL(free_reserved_page);
+
 static int page_alloc_cpu_dead(unsigned int cpu)
 {
 	struct zone *zone;

base-commit: e2f710f97f3544df08ebe608c8157536e0ffb494
-- 
2.45.2.993.g49e7a77208-goog



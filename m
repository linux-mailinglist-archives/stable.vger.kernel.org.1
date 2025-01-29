Return-Path: <stable+bounces-111106-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D77A21AB8
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 11:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6256E16198D
	for <lists+stable@lfdr.de>; Wed, 29 Jan 2025 10:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D1A1990C3;
	Wed, 29 Jan 2025 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h464clCH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E132F171CD
	for <stable@vger.kernel.org>; Wed, 29 Jan 2025 10:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738145339; cv=none; b=MVONwasRpeW3whc57TI0j531cUXoJCNJoNaDGz7pjLRyJlBwpwpPI811eWFKS11JtYUZ4a/w3ktLbq7NnXWnpncRc6K5FQ34jRA3imyjtcQssOiXk7btSuwpKbmzxzG86GrutJoNxMd/aNogwFRSFWR8N7f0bcO/bKFr9HfGnWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738145339; c=relaxed/simple;
	bh=3oaltrIqO711OfCwUxwH9l9Tl0SYOcBxEsYnB0BVv+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTIH+gvFNw0nUHkHXMSlOSf5N1a+K85LP60Apn1zWoEqVd9N9uu/o9z1r+PTsU/9QAXSoOzM9vvpZUmRYfNe4IIkfUlSqsT60vPr2hHiDVaJVV5UdjHxpiTjktdxc7lCT0PvnB6f2QpPIBjQ3u0rHCXR+AEylrTmIUX4ysPpVEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h464clCH; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b1f05caso114757595ad.3
        for <stable@vger.kernel.org>; Wed, 29 Jan 2025 02:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738145337; x=1738750137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4eFjJLmA7+jY5KjyB1yzIOfrExQ6VpabMonRw1hJ84E=;
        b=h464clCH0jz0dAY6FdLUZXIpCpA96Ki7SaVAeIEakS72CW9orIa2zSTBQE9TDsgCL1
         jNTlGdlireOpq7Odku0Iza6qRVpz4h2FgBJWUXXrlTX+THmYtSxwYQ3Vf5OD2cggBszC
         XyJXST2y7ttmAI9Q4Z+OLjK9E5Likm+yFH5n4tZjAUTd90oxV3gy1q0Hf2tB7xDhrm0b
         VtCCNgmh3KrusJtyuUC5RvWYpcyGum5nuqm/xIFu8tBYhewwitWtn8qNsh0EKhDzx5ry
         BAMHGrR2Z5Uvubq8YinRpd2LSnwSniTW44+kMnt+v9ESmV4U8dV1P+WrtWDhDJ/LNhjk
         0fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738145337; x=1738750137;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4eFjJLmA7+jY5KjyB1yzIOfrExQ6VpabMonRw1hJ84E=;
        b=a+hFBko5Yp30JnFfz2qPOt0VA7qcFAED9uzU7yHGlhlq0Qp8xX8Hy3Qb44MYOVjV7P
         qwIkltTC06Z3pQIFVGJtctvZCZOTQxqUNF4UFL5EnTbh2yqpJWqpiKSpzI1VhEY3e1aV
         e69hTDNA3uw9fbvqo8pDqcNPXfe2LU+qmpyamikVh8Prr33b2Hhe9gca84A1vaAHmbvo
         cvnpovqYQxtFdJnxdui/gFF+ZsBfNugW2u3UjdQ9AAc/7bkFE3Ixm5kO4X+Empy/2rMW
         sGtsgzfXR5zRm1w7zzHUyXAf1uOzYmyHVuImAxqXM44dtn9ZJSjLqn+qlrJrqqgD9Unt
         +I0g==
X-Forwarded-Encrypted: i=1; AJvYcCX6InfsneiTKa+qH0C0mG640s6MM7nazX+ldSB+nkHOQm0H+fbKgi76c9tfBL6LRXs8/kPU60s=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPYNpmAfCw07dnsL4xGtMuYu+7MJrnBOmCQMOH2h/zgLDxzJz
	Gt/YUZXIQ+ZE5qTEP7x3Iua1uOgpntNFnw4nxGclg2tkgflkZ/2t
X-Gm-Gg: ASbGncsmjnPvxIhqfZNR6QJqcJa6/HGSMpHiLKwqY11G3jDuoKGdzPwVwjmQmhydhtW
	lQGskZvheEduezdlQk5sIwFbB2kTIntwcP8M688GnfcywBH+fsZcddgXjj6KTYZGrGGaCvxIi0a
	srCYD/Czi850SYn30Vp1Mcn2kGr/sYJ+HCz+jtPSzTjhhR952s9Ec6ezQzbYYMh9XyGJAFB+MxL
	FRPmxIk0Yw8k67g0HQwqxZxTM5GjBX/bq8k0X0gzsn0m2xHZ72+Nf0XBVCg6HGUuB3ellEojYnC
	WBWt9LcZIOluuhAX0nQpvto+ZY9XAD0V
X-Google-Smtp-Source: AGHT+IFu9zutwwiyXSYXOvcIiiLZl95OQxh8Qw0wNADOnSiF1SeNm1oMoqrIjLHbcsHK4atO62YRog==
X-Received: by 2002:a17:902:ec8f:b0:216:5561:70d7 with SMTP id d9443c01a7336-21dd7e4264emr39113415ad.52.1738145337032;
        Wed, 29 Jan 2025 02:08:57 -0800 (PST)
Received: from hyeyoo-laptop.localdomain ([114.29.17.235])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da555a428sm94359375ad.84.2025.01.29.02.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 02:08:56 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 mm-hotfixes] mm/zswap: fix inconsistency when zswap_store_page() fails
Date: Wed, 29 Jan 2025 19:08:44 +0900
Message-ID: <20250129100844.2935-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
skips charging any zswap entries when it failed to zswap the entire
folio.

However, when some base pages are zswapped but it failed to zswap
the entire folio, the zswap operation is rolled back.
When freeing zswap entries for those pages, zswap_entry_free() uncharges
the zswap entries that were not previously charged, causing zswap charging
to become inconsistent.

This inconsistency triggers two warnings with following steps:
  # On a machine with 64GiB of RAM and 36GiB of zswap
  $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
  $ sudo reboot

  The two warnings are:
    in mm/memcontrol.c:163, function obj_cgroup_release():
      WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));

    in mm/page_counter.c:60, function page_counter_cancel():
      if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
	  new, nr_pages))

zswap_stored_pages also becomes inconsistent in the same way.

As suggested by Kanchana, increment zswap_stored_pages and charge zswap
entries within zswap_store_page() when it succeeds. This way,
zswap_entry_free() will decrement the counter and uncharge the entries
when it failed to zswap the entire folio.

While this could potentially be optimized by batching objcg charging
and incrementing the counter, let's focus on fixing the bug this time
and leave the optimization for later after some evaluation.

After resolving the inconsistency, the warnings disappear.

Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
Cc: stable@vger.kernel.org
Co-developed-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---

v2 -> v3:
  - Adjusted Kanchana's feedback:
    - Fixed inconsistency in zswap_stored_pages
    - Now objcg charging and incrementing zswap_store_pages is done
      within zswap_stored_pages, one by one

 mm/zswap.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6504174fbc6a..f0bd962bffd5 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1504,11 +1504,14 @@ static ssize_t zswap_store_page(struct page *page,
 	entry->pool = pool;
 	entry->swpentry = page_swpentry;
 	entry->objcg = objcg;
+	if (objcg)
+		obj_cgroup_charge_zswap(objcg, entry->length);
 	entry->referenced = true;
 	if (entry->length) {
 		INIT_LIST_HEAD(&entry->lru);
 		zswap_lru_add(&zswap_list_lru, entry);
 	}
+	atomic_long_inc(&zswap_stored_pages);
 
 	return entry->length;
 
@@ -1526,7 +1529,6 @@ bool zswap_store(struct folio *folio)
 	struct obj_cgroup *objcg = NULL;
 	struct mem_cgroup *memcg = NULL;
 	struct zswap_pool *pool;
-	size_t compressed_bytes = 0;
 	bool ret = false;
 	long index;
 
@@ -1569,15 +1571,11 @@ bool zswap_store(struct folio *folio)
 		bytes = zswap_store_page(page, objcg, pool);
 		if (bytes < 0)
 			goto put_pool;
-		compressed_bytes += bytes;
 	}
 
-	if (objcg) {
-		obj_cgroup_charge_zswap(objcg, compressed_bytes);
+	if (objcg)
 		count_objcg_events(objcg, ZSWPOUT, nr_pages);
-	}
 
-	atomic_long_add(nr_pages, &zswap_stored_pages);
 	count_vm_events(ZSWPOUT, nr_pages);
 
 	ret = true;
-- 
2.47.1



Return-Path: <stable+bounces-110937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FF2A2068A
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 09:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200F4188581A
	for <lists+stable@lfdr.de>; Tue, 28 Jan 2025 08:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98BF1DED67;
	Tue, 28 Jan 2025 08:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koZmcG9z"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DBE1DE891
	for <stable@vger.kernel.org>; Tue, 28 Jan 2025 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054227; cv=none; b=edRQtiROsY6Tpz/FsNn9d3o0ijhxR04tv05ySmt2SjuybG0PePyH36eczBbx66AW+dBQ/qnGxpiQw2yVcKvSEQiiELJ74Grl3882bAkCKxVp855vKynHjm4+l9X9C9NgUOzuWAKcjk/etqVoJc1hRn1Yb9y1nybNl4/nTtTrmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054227; c=relaxed/simple;
	bh=6yugTGO8IbV+5tZXOKXuf1cMuhenvd5/UfqIoZ7bszI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n8p67a1e6Frq4rWdKbLlWUqY8pkNi9jOfExnk0ut7YdxF2rBjVONz8SV5dgyjUwyivQUu32WneCw2e3gp6AGQHArAsA5PwoX5JNCfq0Tp2FWQY0jJaESIwOFCK6AfDUDO74Agpko3FLjAJ7wROCLH9xj+23a/lPoD9nzpZICoN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koZmcG9z; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21649a7bcdcso89814445ad.1
        for <stable@vger.kernel.org>; Tue, 28 Jan 2025 00:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738054226; x=1738659026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fe/jY1AIBq99Rc24VTdN61cmwo2SmNqIaaukdWS9bVs=;
        b=koZmcG9zar+RrYtWHXpPXhbzZGHOXMFMDpQO+Iyr/zM38FeG62S4LNxJxaQ1uyxkX1
         AA++r4AUgNwE+YjCi5Ml04sJykSW5cUztFaByEzjtaFV9xLrbXlKyMaTky3Xme1Eia/u
         dGtlhXgrKYsNjiL6eOM99WcrPq8EiuJqb/shC6QDtkdQVQDFT87pllXKJUNKmnFM2A7G
         umst+MDFo29hjCbKJkdcNI2mkgCZXR9ztxgPNwL2I6AaCaUAxK/GDHKeHbZ+llpPOjQM
         M2jXi3CnkShnPVQyI9up22dyI5lP5oRCuKq0P7zUPvLUEW5iYKczOfeiIGCHNEAwT6La
         D0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738054226; x=1738659026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fe/jY1AIBq99Rc24VTdN61cmwo2SmNqIaaukdWS9bVs=;
        b=hnuRezQyv1vQVOqVli1cLHqpZcvVZV/kcoX+0a2xhbT8wtpMAsv7irzimkpUtl5azd
         CwNU6UOFOg5C5TtTKAUQKQDmph4i05drzRpyoKOoynJ9Xjx08XeJ3DXPqEeAav2qow4r
         eRCXJvmNkYHBjupksSKt4MWcqahlBIRDD3FAwn/8F6Gw7ydKgScYmXswCW0icOamGSYH
         aPUVq3lWM2aYjDoan/YeXqgOwpqy+mNqWqDN6aumz1xScLA0u3K2rqcc/SY7RNM+D3wj
         wslQGDqkhCfpSHY6N//WGZNuq2aCGaaXYoJIcDrj/bXD4Q1Du3kIw4XxnCMs3zv0pS/K
         xFdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2oUAFzrJX8LCziBpy04nRN+bldrXrb3/JLt+/ZQO3WK1XBpUd75d5ln4wqtKp0zNaJGuM5Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/oitzQaImLAt/RtDrwKMN2bs0oNRKpBz0BETk5PO3db2+5u/W
	84EgEU7mlCjEJ9tWTrUCYAy/tO8JIDCYaj0VGD2+mFbDWxIpIuk7
X-Gm-Gg: ASbGncvjTTXGvvhXGRlSGH+IOdZTlQmYaMLT1yfV1rGVqpfGNvOF6W4TpjNxXuMzoRu
	pir11ky0D5xhlpwuqNPyBNw5GS7O9WuAWDArTBDrdz/qr8Z2cZrJQWxhQ5ZIJYj3EWA/+VjH209
	XZvgZZXbaWEyMdAF4K4JMeYcyGwEY8zvWE3YlTKBNNGs+SpwI4qqsi/p68K8yGXXFi7Gp+XMXZ7
	AKvU6O5U/1eSeMEgl8JemPQMT803hTuVe0AJ0+9oN3c9w+2Xwsf/H0selriTR4NcCGMa5i7EW+m
	kzPsDI4WEo0oVQO16oJn0fllDhOfxFbBweA=
X-Google-Smtp-Source: AGHT+IFZH2gS9hh/6mdITfgOnKqyTWBhhHC56tkrEmCloyR4KXqQAkvIyl7s7vDagrRTmTe/Y46X2A==
X-Received: by 2002:aa7:9317:0:b0:725:e37d:cd35 with SMTP id d2e1a72fcca58-72dafa7c471mr68080721b3a.18.1738054225494;
        Tue, 28 Jan 2025 00:50:25 -0800 (PST)
Received: from hyeyoo-laptop.localdomain ([221.160.193.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72f8a6a07ccsm8538343b3a.28.2025.01.28.00.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 00:50:24 -0800 (PST)
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
Subject: [PATCH v6.12 hotfix] mm/zswap: fix inconsistent charging when zswap_store_page() fails
Date: Wed, 29 Jan 2025 02:49:38 +0900
Message-ID: <20250128174938.2638-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
mistakenly skipped charging any zswapped pages when a single call to
zswap_store_page() failed, even if some pages in the folio are
successfully stored in zswap.

Making things worse, these not-charged pages are uncharged in
zswap_entry_free(), making zswap charging inconsistent.

This inconsistency triggers two warnings when following these steps:
  # On a machine with 64GiB of RAM and 36GiB of zswap
  $ stress-ng --bigheap 2 # wait until the OOM-killer kills stress-ng
  $ sudo reboot

  Two warnings are:
    in mm/memcontrol.c:163, function obj_cgroup_release():
      WARN_ON_ONCE(nr_bytes & (PAGE_SIZE - 1));

    in mm/page_counter.c:60, function page_counter_cancel():
      if (WARN_ONCE(new < 0, "page_counter underflow: %ld nr_pages=%lu\n",
	  new, nr_pages))

Charge zswapped pages even if some pages of the folio are not zswapped.
After resolving the inconsistency, these warnings disappear.

Fixes: b7c0ccdfbafd ("mm: zswap: support large folios in zswap_store()")
Cc: stable@vger.kernel.org
Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/zswap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 6504174fbc6a..92752cd05c75 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1568,20 +1568,20 @@ bool zswap_store(struct folio *folio)
 
 		bytes = zswap_store_page(page, objcg, pool);
 		if (bytes < 0)
-			goto put_pool;
+			goto charge_zswap;
 		compressed_bytes += bytes;
 	}
 
-	if (objcg) {
-		obj_cgroup_charge_zswap(objcg, compressed_bytes);
-		count_objcg_events(objcg, ZSWPOUT, nr_pages);
-	}
-
 	atomic_long_add(nr_pages, &zswap_stored_pages);
 	count_vm_events(ZSWPOUT, nr_pages);
 
 	ret = true;
 
+charge_zswap:
+	if (objcg) {
+		obj_cgroup_charge_zswap(objcg, compressed_bytes);
+		count_objcg_events(objcg, ZSWPOUT, nr_pages);
+	}
 put_pool:
 	zswap_pool_put(pool);
 put_objcg:
-- 
2.47.1



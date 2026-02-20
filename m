Return-Path: <stable+bounces-217583-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJ/lNbp0mGnhIwMAu9opvQ
	(envelope-from <stable+bounces-217583-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 15:50:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 458FF168880
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 15:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C7B85309AA17
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB65A34B190;
	Fri, 20 Feb 2026 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ar1+mShr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5472F34D4D3
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771598987; cv=none; b=da2CVunc+k+FZzJ0a9O68AsjRQq6TpiV0K2oYD4fJVdarnALKED8deAGiSNFN9IZ4eUVJxLAuFb9IugcsKEK++OehauYN18MJZBNGxxykMd3MCDJXcvHp9GqrodKgPUjzE0yfjADMyRAO0S9PgNu3KDcJuYF/lHddALIk/VJs90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771598987; c=relaxed/simple;
	bh=9Nh27rPFeHNCWr8MUFQIUbZtfDXJvCeFJWUeTB2DOls=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JcePVPU31GaM3m7I/+yihCSICbTu2KkiLc43Dvcdw+4pWZ95eRPIOIxafmEQwLUaqWPBejnw5eULeu7C7XhasYjzoz3taHGWG/9MalRGHvwt6vkKxQo+I6WhGlLB/umuitVLEDMJM0aBjv7Sj8WkmOjR5QF5kYYrIaaUtOBJO2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--glider.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ar1+mShr; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--glider.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4837cee2e9bso17294455e9.3
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 06:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771598985; x=1772203785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7l0Rk7sxPzClSemlodKxJT0xAUIi4Uh2P1WbS8uB91M=;
        b=ar1+mShrdv9DPJx5gewY9qZdbnDvM1FEjtgc17sXBl8hhRg5XwZjsBSW+QbHHOBsi3
         TMxnwop17evdlMJRE3sJmevLMUuaFiIPR4SEcGhnW934ZvuW4lH6dRzGUX6aGnWg3rN0
         pySHeWEZjfphqdVIvkND3fYmi/AHN6/ZbiJ85uU0r1X1Gc/6CNcXPD5ZRK0JQs0UXV4k
         4x3BC22NIDrHoXufmBjmpblQEh/5Zhej5RTO/Wby7jXt3EmoPB+awguTQ1oLliZpHCsh
         000zDLmNKA8ZZBoHoAPuyTBTskf220ZUx7KvpmLXBNfunhA7Oot2paEs1peaeHEiOJFz
         JXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771598985; x=1772203785;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7l0Rk7sxPzClSemlodKxJT0xAUIi4Uh2P1WbS8uB91M=;
        b=kGwnZPmhi8LOlMzM/alyqiSgJ9aNQNFtXYSyu3htXWDGhTPyxlYud2tsR0GWVD/5GD
         J+qiDCtEN27U9kusrtZZFrIWAO1AB+i6kfTdWIcoteTyamTSRGmskO+bEmmWrWlS5ZKN
         NiqNAPW+tT3KUeguQrtpUogWYctf/tIGaQBUNEmPQ7eGw/tfFEgzMJmt7mTi9vpVsElB
         c+u7zkqTfMMsDDc8Pp6k6xgbW86bKpCfn0qKYJnC5sCVOfT3zsL59nNHnho5wUSKtH7r
         FemDeLQGwQy+6eiTFMrHVkPd2/uuW0dTJDgaMbnUohOs5bqumruma5y8z+YkDFov/J0J
         3aXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOBSAL0snMw0dK9r3G/4H5PJhf0nzZnfiVhdz0OO4v8jlB+N1qDi6bwdOzCiFWamrRBaeFe+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRASKfzX04+oEcHF6ygGJxSVsBQ1bemjv7kCroeFIKlY4tsTHS
	895Kx89IYQZ9k9Z7e7TYGm3O0FvhEil9MS2km61J76GIPW1Waf6k214wbm+ETfr4R8ZebVPLntO
	SGMONwA==
X-Received: from wmhn21.prod.google.com ([2002:a05:600c:3055:b0:483:6e28:c16f])
 (user=glider job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b2f:b0:47d:885d:d2ff
 with SMTP id 5b1f17b1804b1-48379c1faccmr309919275e9.29.1771598984385; Fri, 20
 Feb 2026 06:49:44 -0800 (PST)
Date: Fri, 20 Feb 2026 15:49:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
Message-ID: <20260220144940.2779209-1-glider@google.com>
Subject: [PATCH v1] mm/kfence: fix KASAN hardware tag faults during late enablement
From: Alexander Potapenko <glider@google.com>
To: glider@google.com
Cc: akpm@linux-foundation.org, mark.rutland@arm.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, pimyn@google.com, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, Marco Elver <elver@google.com>, stable@vger.kernel.org, 
	Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217583-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[glider@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,arm.com,kvack.org,vger.kernel.org,googlegroups.com,google.com,gmail.com,linuxfoundation.org,kernel.org,tugraz.at];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,tugraz.at:email]
X-Rspamd-Queue-Id: 458FF168880
X-Rspamd-Action: no action

When KASAN hardware tags are enabled, re-enabling KFENCE late (via
/sys/module/kfence/parameters/sample_interval) causes KASAN faults.

This happens because the KFENCE pool and metadata are allocated via
the page allocator, which tags the memory, while KFENCE continues to
access it using untagged pointers during initialization.

Use __GFP_SKIP_KASAN for late KFENCE pool and metadata allocations to
ensure the memory remains untagged, consistent with early allocations
from memblock. To support this, add __GFP_SKIP_KASAN to the allowlist
in __alloc_contig_verify_gfp_mask().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Kees Cook <kees@kernel.org>
Cc: Marco Elver <elver@google.com>
Cc: <stable@vger.kernel.org>
Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
Suggested-by: Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>
Signed-off-by: Alexander Potapenko <glider@google.com>

---

This is a follow-up for
"mm/kfence: disable KFENCE upon KASAN HW tags enablement"
that is currently in mm-hotfixes-unstable
---
 mm/kfence/core.c | 14 ++++++++------
 mm/page_alloc.c  |  3 ++-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/kfence/core.c b/mm/kfence/core.c
index 71f87072baf9b..30959c97b881d 100644
--- a/mm/kfence/core.c
+++ b/mm/kfence/core.c
@@ -999,14 +999,14 @@ static int kfence_init_late(void)
 #ifdef CONFIG_CONTIG_ALLOC
 	struct page *pages;
 
-	pages = alloc_contig_pages(nr_pages_pool, GFP_KERNEL, first_online_node,
-				   NULL);
+	pages = alloc_contig_pages(nr_pages_pool, GFP_KERNEL | __GFP_SKIP_KASAN,
+				   first_online_node, NULL);
 	if (!pages)
 		return -ENOMEM;
 
 	__kfence_pool = page_to_virt(pages);
-	pages = alloc_contig_pages(nr_pages_meta, GFP_KERNEL, first_online_node,
-				   NULL);
+	pages = alloc_contig_pages(nr_pages_meta, GFP_KERNEL | __GFP_SKIP_KASAN,
+				   first_online_node, NULL);
 	if (pages)
 		kfence_metadata_init = page_to_virt(pages);
 #else
@@ -1016,11 +1016,13 @@ static int kfence_init_late(void)
 		return -EINVAL;
 	}
 
-	__kfence_pool = alloc_pages_exact(KFENCE_POOL_SIZE, GFP_KERNEL);
+	__kfence_pool = alloc_pages_exact(KFENCE_POOL_SIZE,
+					  GFP_KERNEL | __GFP_SKIP_KASAN);
 	if (!__kfence_pool)
 		return -ENOMEM;
 
-	kfence_metadata_init = alloc_pages_exact(KFENCE_METADATA_SIZE, GFP_KERNEL);
+	kfence_metadata_init = alloc_pages_exact(KFENCE_METADATA_SIZE,
+						 GFP_KERNEL | __GFP_SKIP_KASAN);
 #endif
 
 	if (!kfence_metadata_init)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cbf758e27aa2c..9d1887e3d4074 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6921,7 +6921,8 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
 {
 	const gfp_t reclaim_mask = __GFP_IO | __GFP_FS | __GFP_RECLAIM;
 	const gfp_t action_mask = __GFP_COMP | __GFP_RETRY_MAYFAIL | __GFP_NOWARN |
-				  __GFP_ZERO | __GFP_ZEROTAGS | __GFP_SKIP_ZERO;
+				  __GFP_ZERO | __GFP_ZEROTAGS | __GFP_SKIP_ZERO |
+				  __GFP_SKIP_KASAN;
 	const gfp_t cc_action_mask = __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
 
 	/*
-- 
2.53.0.345.g96ddfc5eaa-goog



Return-Path: <stable+bounces-121134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86835A540B2
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 03:32:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1DF116E25D
	for <lists+stable@lfdr.de>; Thu,  6 Mar 2025 02:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B461917D0;
	Thu,  6 Mar 2025 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dCm/d1N7"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583916088F
	for <stable@vger.kernel.org>; Thu,  6 Mar 2025 02:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228317; cv=none; b=FOZkJposEXZSR/mqaYtihn5eWZrKVY0/UT0boJaqSQWYVtSiAOT5qBfj5BwIQqsy8O2K9n65d+X8H6LiiA1e9SWKj9PWiIflng9nHyByvNI8GBL23hwRlu06LxnkkNGaOm7NoTSKGCkLR/WdMr7DofIZpuMm2MRSZ3VdoFuXm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228317; c=relaxed/simple;
	bh=W1tcb7tlttKSGSGcmJVIThQ+ztQfMVdTvzNQlwimA1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XtiBpLrelS3mk0d2HnV+Ofsj+EW//g2s6A9XZOyqYPTXmET7+g63ppL/offI7pDeYBC5imgsBF4PXVPJ+mU0LocqQx9Zvr+ql8hZCd84iE/2hBeoCL9jApV4drXGGCf2tt5H7iB8/a1yWyOeRGXNTHT5AQppWT7WE1jgz3G+Tw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dCm/d1N7; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22356471820so1775585ad.0
        for <stable@vger.kernel.org>; Wed, 05 Mar 2025 18:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741228313; x=1741833113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iO6wA6XWmxnHhVJNEGwMRLVJm1A8Q49xyow/a4mczm0=;
        b=dCm/d1N7dDe2NPkJ6Jya2T99qQvSQqcVohRzYDzooC1TwgQXwUjR2mp3beEQEPjufO
         bMX29nCjbNnYi53u5O5+LOHAvi/JMLXbvGn0mAARYfmnripixu/pZ08xH9qb0Z7h2iNN
         fLR3l7w0oDd+jdNmbOhuBQB4n+cIbYZEt+kptHRB5QN9/r/uADD5NhCho2GcV+iLDSy4
         gQf2IVuFR2GQinBMykau1tO2cPB+6x16i6SDPh6ucMMreeq5H8wNB1CW8sWf5F6tjDNC
         rUnuD5sjGE9S0YxfEmIoPG4NJq/PSvxYB1Apruun/3/Nqr067yjSmDHVREtE8l1XWZEc
         AdAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741228313; x=1741833113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iO6wA6XWmxnHhVJNEGwMRLVJm1A8Q49xyow/a4mczm0=;
        b=EimzkPHBe/gSyeL9m+E46s9iS4tlCNIXCrWg9Gfzv7CPMj0y+n4dV5G5LXyYK4GpIE
         lCYZT59hMI8qjGzc9EQ77ZfccapDjb9MphJ4uRPHlkCHvIohRAz9S3tmbuptw/72+Se4
         8gM7nPakM47cAnEnSLbVa7O+gVpP+UPuXZZWPVWhNlwKtQnBtGCXCTiSDA5AvS3b87V/
         UrVx2zP1F4SByxy83F2dLdoFOCFUW1IHx7flDtOAbVPnJ0q25Fb02NpSVuxN/B1hlBe2
         9nSk23MwCOSswvoz4XeSiEiFjrRwsrDUQcscJeDFJo0ab2V9tJyixAQzWlbwPgLT4aVR
         oJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwKUVBHkWDawYRkzT2KJCPH0TJs/wU0/ka2434VKJ6sIwJLahF1OD4LcimPbxJjmC09Z+Ovr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWG5Gg0lj5JtF8NXdRthDoN9bhqDe2n2dNBvcmsxnLJQFKN9cP
	qtKtOgG0aqf7ORF33/yrIBqJ6r2PcSxzjATCORVgijpjRjP7ZaFK9W809inWhzsyakbwrMzASdJ
	RwLM=
X-Gm-Gg: ASbGncuMoRyWuoETQABRBCZWQB4LxP+75PjYk0K2XR8RzlWulULj4y+eWveAH9NxQYX
	RZ3TEdaN/fvgHSnI9luX3UgZk5ChENaNKceQ2cbffViZ9yjgJ4hONPM+0OA4fE6W1lxbNbrJr/v
	EbxYtaIdx/Osn4oItpgjA3C83AeFzuDrmsS1fGATKpBwiUnywr7a0zA2gXbCNjztvsnlLb4r9EC
	Z5bpA+BamiSpFA2BzDTl7ydfDXb7Pcmhf5gDXkCFojnXKJlWe66lq55SrDCiY+l13zUPgcxe4SF
	kA2cm7pn+PZ0Y8u3Xdc5i79XGl6EkyxMbura8teRnZwkFT2ue334b/Nh14lNCankLm2ulJWZT3q
	bjQFS
X-Google-Smtp-Source: AGHT+IFwn29sDeYBmdp4CEswbdIWIO0mgSzC0Fu02o+1MLOPwdvWyiKyshtyKjhFx5G7dBzbMS/5rQ==
X-Received: by 2002:a17:902:f683:b0:223:5c77:7ef1 with SMTP id d9443c01a7336-223f1c982c4mr86775385ad.21.1741228313590;
        Wed, 05 Mar 2025 18:31:53 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddcaesm1318185ad.28.2025.03.05.18.31.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 05 Mar 2025 18:31:52 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	kasong@tencent.com,
	chrisl@kernel.org
Cc: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm: memcontrol: fix swap counter leak from offline cgroup
Date: Thu,  6 Mar 2025 10:31:33 +0800
Message-Id: <20250306023133.44838-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 6769183166b3 has removed the parameter of id from
swap_cgroup_record() and get the memcg id from
mem_cgroup_id(folio_memcg(folio)). However, the caller of it
may update a different memcg's counter instead of
folio_memcg(folio). E.g. in the caller of mem_cgroup_swapout(),
@swap_memcg could be different with @memcg and update the counter
of @swap_memcg, but swap_cgroup_record() records the wrong memcg's
ID. When it is uncharged from __mem_cgroup_uncharge_swap(), the
swap counter will leak since the wrong recorded ID. Fix it by
bring the parameter of id back.

Fixes: 6769183166b3 ("mm/swap_cgroup: decouple swap cgroup recording and clearing")
Cc: <stable@vger.kernel.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 include/linux/swap_cgroup.h | 4 ++--
 mm/memcontrol.c             | 4 ++--
 mm/swap_cgroup.c            | 7 ++++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/linux/swap_cgroup.h b/include/linux/swap_cgroup.h
index b5ec038069dab..91cdf12190a03 100644
--- a/include/linux/swap_cgroup.h
+++ b/include/linux/swap_cgroup.h
@@ -6,7 +6,7 @@
 
 #if defined(CONFIG_MEMCG) && defined(CONFIG_SWAP)
 
-extern void swap_cgroup_record(struct folio *folio, swp_entry_t ent);
+extern void swap_cgroup_record(struct folio *folio, unsigned short id, swp_entry_t ent);
 extern unsigned short swap_cgroup_clear(swp_entry_t ent, unsigned int nr_ents);
 extern unsigned short lookup_swap_cgroup_id(swp_entry_t ent);
 extern int swap_cgroup_swapon(int type, unsigned long max_pages);
@@ -15,7 +15,7 @@ extern void swap_cgroup_swapoff(int type);
 #else
 
 static inline
-void swap_cgroup_record(struct folio *folio, swp_entry_t ent)
+void swap_cgroup_record(struct folio *folio, unsigned short id, swp_entry_t ent)
 {
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index a5d870fbb4321..a5ab603806fbb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4988,7 +4988,7 @@ void mem_cgroup_swapout(struct folio *folio, swp_entry_t entry)
 		mem_cgroup_id_get_many(swap_memcg, nr_entries - 1);
 	mod_memcg_state(swap_memcg, MEMCG_SWAP, nr_entries);
 
-	swap_cgroup_record(folio, entry);
+	swap_cgroup_record(folio, mem_cgroup_id(swap_memcg), entry);
 
 	folio_unqueue_deferred_split(folio);
 	folio->memcg_data = 0;
@@ -5050,7 +5050,7 @@ int __mem_cgroup_try_charge_swap(struct folio *folio, swp_entry_t entry)
 		mem_cgroup_id_get_many(memcg, nr_pages - 1);
 	mod_memcg_state(memcg, MEMCG_SWAP, nr_pages);
 
-	swap_cgroup_record(folio, entry);
+	swap_cgroup_record(folio, mem_cgroup_id(memcg), entry);
 
 	return 0;
 }
diff --git a/mm/swap_cgroup.c b/mm/swap_cgroup.c
index be39078f255be..1007c30f12e2c 100644
--- a/mm/swap_cgroup.c
+++ b/mm/swap_cgroup.c
@@ -58,9 +58,11 @@ static unsigned short __swap_cgroup_id_xchg(struct swap_cgroup *map,
  * entries must not have been charged
  *
  * @folio: the folio that the swap entry belongs to
+ * @id: mem_cgroup ID to be recorded
  * @ent: the first swap entry to be recorded
  */
-void swap_cgroup_record(struct folio *folio, swp_entry_t ent)
+void swap_cgroup_record(struct folio *folio, unsigned short id,
+			swp_entry_t ent)
 {
 	unsigned int nr_ents = folio_nr_pages(folio);
 	struct swap_cgroup *map;
@@ -72,8 +74,7 @@ void swap_cgroup_record(struct folio *folio, swp_entry_t ent)
 	map = swap_cgroup_ctrl[swp_type(ent)].map;
 
 	do {
-		old = __swap_cgroup_id_xchg(map, offset,
-					    mem_cgroup_id(folio_memcg(folio)));
+		old = __swap_cgroup_id_xchg(map, offset, id);
 		VM_BUG_ON(old);
 	} while (++offset != end);
 }
-- 
2.20.1



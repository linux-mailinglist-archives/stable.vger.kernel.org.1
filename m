Return-Path: <stable+bounces-89710-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 469E29BB8B2
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 16:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04FFD283DB8
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870271BC077;
	Mon,  4 Nov 2024 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iLvA3odV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B761BC065;
	Mon,  4 Nov 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730733171; cv=none; b=cmWd9Gghha6FNRXv55zXe7VDTh6aOMCLHoIH7obf+44nyGpvyfcuQxNDI8+LXHORIuXACMYLbFvyZcmFE9xJb8KHTdwpsh034nCGDINfXFySfTdWri3H0lEjarnss5a2APxaZmANICRlW9gnTkLqhq/5jz8hduJqQ+WanogBH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730733171; c=relaxed/simple;
	bh=BaaksXx/2rKmIPLxkZ/vHqVYo4nDym4qCUjVHlaqwsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5EVD2Wgvl8TZrmc2HQTZM9S9kkpcC0ekgxBkQ1+o/kyxFGt8GP9gGwh2tyXyBFjow8EotM2MUEaW0/niNFGQziUla0fiHnX9EnEnwYZuqbJTEDbclwYTNNYdn7Hs1oz1NcpBdCfNGFOLSefNBD7Uqe8YOdaZJ1cpEv0n8YF/ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iLvA3odV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cbca51687so41009015ad.1;
        Mon, 04 Nov 2024 07:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730733169; x=1731337969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EsDhKeizCbh8czq6Zo7/L6Gcau/g9OV1qCvVb2b2Aa0=;
        b=iLvA3odVlS12uLcxjChDA3H8Lo7/3akf0hVCUboCeI+hmxi4LA1+3RLCIX0I+aVVmw
         jPN1XMToHwb0VB0sWuN6PxDeU1ClwWMw/+5jcPwOP6tl2khVVXxXppRrEC+vfAUGQ8Lm
         p38tCTE2N4bymx4TBnx2kcqSkepN61jozqdv4+OtIR+DePlLxtCWF1agx5xg779TKVJd
         UuKyhBjR8YLW4jie9HRTYvcXsTzGs93uKml9cmGUZy5njwNKL5d372nwgvx309qiaC58
         VcKzbsLTAtf+w9Hm1bkvGx4cZpCznld2gCm3zeBJegViQvb+YFZycFsrXSEyL/S0B1Hf
         iM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730733169; x=1731337969;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EsDhKeizCbh8czq6Zo7/L6Gcau/g9OV1qCvVb2b2Aa0=;
        b=BTtO0do6aQKUdmK8QpjAJaYGhmxIBMipOJ15wZpXQ2EZEr6ehDzCga8axTh8AGIRYf
         TlriMR16XY3gwaRLq3JOE7a2PXqbSQVsml20lEPG+Gv1klx6qup/7WIgfcb0EFAWeYdn
         HbBftUTu/XuyJAU+QRGbuHNp0uRR/okAO4bzqgBg4REHh9TGsS5O9yOJS/j9MvJM4+cE
         N7LRAj/qDMuwXsJqbhJjnejVAeybXKmpR8TrG0Ddcjwh8LdqCvXqiUOmBCq+bLxTXUg6
         I0gLeENljmaOOi7r4sDO/4w4hq3ozMy08zcW1sYHfgQ1lslB8M7eOA6P0Gq8WlVhsrbu
         QNBg==
X-Forwarded-Encrypted: i=1; AJvYcCWXNGRptI7gAAMyPO7thIfyHmTOGs/H445Rn2hZSunasgfGarEHtrPKbNq9AD24wTLR5yESocVlch0dzrI=@vger.kernel.org, AJvYcCXrXrENF7TSFPz1BFwBZbGLpl9Z3k/tNy9I425kcRogQ1GI/6m6BOyppeLOUc35FFoMBFmZAv7X@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2+3CSzX6F63W7FLfkaES7Hpeye7gzo12vIeM+bhfkm0IgaA4w
	QYYKnVIKMUW/aywZQP52SBR9L2M8CQUgwW9Gv6lSlv84rKnkJuxLT1qzxufe
X-Google-Smtp-Source: AGHT+IHO0Y6csBSOm2+izvcly7LZuH8t5FbKjibToAXpCUmAGh9pzMbEGtKoUY9GTmnEsIJdJ3h36A==
X-Received: by 2002:a17:902:d4c2:b0:20b:bd8d:427c with SMTP id d9443c01a7336-2111aef288amr178931625ad.23.1730733168579;
        Mon, 04 Nov 2024 07:12:48 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:3d77:36dd:b1e9:70a2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056eee7bsm62143955ad.61.2024.11.04.07.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 07:12:48 -0800 (PST)
From: Koichiro Den <koichiro.den@gmail.com>
To: vbabka@suse.cz
Cc: cl@linux.com,
	penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	kees@kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	koichiro.den@gmail.com
Subject: [PATCH] mm/slab: fix warning caused by duplicate kmem_cache creation in kmem_buckets_create
Date: Tue,  5 Nov 2024 00:08:37 +0900
Message-ID: <20241104150837.2756047-1-koichiro.den@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b035f5a6d852 ("mm: slab: reduce the kmalloc() minimum alignment
if DMA bouncing possible") reduced ARCH_KMALLOC_MINALIGN to 8 on arm64.
However, with KASAN_HW_TAGS enabled, arch_slab_minalign() becomes 16.
This causes kmalloc_caches[*][8] to be aliased to kmalloc_caches[*][16],
resulting in kmem_buckets_create() attempting to create a kmem_cache for
size 16 twice. This duplication triggers warnings on boot:

[    2.325108] ------------[ cut here ]------------
[    2.325135] kmem_cache of name 'memdup_user-16' already exists
[    2.325783] WARNING: CPU: 0 PID: 1 at mm/slab_common.c:107 __kmem_cache_create_args+0xb8/0x3b0
[    2.327957] Modules linked in:
[    2.328550] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc5mm-unstable-arm64+ #12
[    2.328683] Hardware name: QEMU QEMU Virtual Machine, BIOS 2024.02-2 03/11/2024
[    2.328790] pstate: 61000009 (nZCv daif -PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    2.328911] pc : __kmem_cache_create_args+0xb8/0x3b0
[    2.328930] lr : __kmem_cache_create_args+0xb8/0x3b0
[    2.328942] sp : ffff800083d6fc50
[    2.328961] x29: ffff800083d6fc50 x28: f2ff0000c1674410 x27: ffff8000820b0598
[    2.329061] x26: 000000007fffffff x25: 0000000000000010 x24: 0000000000002000
[    2.329101] x23: ffff800083d6fce8 x22: ffff8000832222e8 x21: ffff800083222388
[    2.329118] x20: f2ff0000c1674410 x19: f5ff0000c16364c0 x18: ffff800083d80030
[    2.329135] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    2.329152] x14: 0000000000000000 x13: 0a73747369786520 x12: 79646165726c6120
[    2.329169] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 0000000000000000
[    2.329194] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
[    2.329210] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[    2.329226] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[    2.329291] Call trace:
[    2.329407]  __kmem_cache_create_args+0xb8/0x3b0
[    2.329499]  kmem_buckets_create+0xfc/0x320
[    2.329526]  init_user_buckets+0x34/0x78
[    2.329540]  do_one_initcall+0x64/0x3c8
[    2.329550]  kernel_init_freeable+0x26c/0x578
[    2.329562]  kernel_init+0x3c/0x258
[    2.329574]  ret_from_fork+0x10/0x20
[    2.329698] ---[ end trace 0000000000000000 ]---

[    2.403704] ------------[ cut here ]------------
[    2.404716] kmem_cache of name 'msg_msg-16' already exists
[    2.404801] WARNING: CPU: 2 PID: 1 at mm/slab_common.c:107 __kmem_cache_create_args+0xb8/0x3b0
[    2.404842] Modules linked in:
[    2.404971] CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.12.0-rc5mm-unstable-arm64+ #12
[    2.405026] Tainted: [W]=WARN
[    2.405043] Hardware name: QEMU QEMU Virtual Machine, BIOS 2024.02-2 03/11/2024
[    2.405057] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    2.405079] pc : __kmem_cache_create_args+0xb8/0x3b0
[    2.405100] lr : __kmem_cache_create_args+0xb8/0x3b0
[    2.405111] sp : ffff800083d6fc50
[    2.405115] x29: ffff800083d6fc50 x28: fbff0000c1674410 x27: ffff8000820b0598
[    2.405135] x26: 000000000000ffd0 x25: 0000000000000010 x24: 0000000000006000
[    2.405153] x23: ffff800083d6fce8 x22: ffff8000832222e8 x21: ffff800083222388
[    2.405169] x20: fbff0000c1674410 x19: fdff0000c163d6c0 x18: ffff800083d80030
[    2.405185] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[    2.405201] x14: 0000000000000000 x13: 0a73747369786520 x12: 79646165726c6120
[    2.405217] x11: 656820747563205b x10: 2d2d2d2d2d2d2d2d x9 : 0000000000000000
[    2.405233] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
[    2.405248] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[    2.405271] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[    2.405287] Call trace:
[    2.405293]  __kmem_cache_create_args+0xb8/0x3b0
[    2.405305]  kmem_buckets_create+0xfc/0x320
[    2.405315]  init_msg_buckets+0x34/0x78
[    2.405326]  do_one_initcall+0x64/0x3c8
[    2.405337]  kernel_init_freeable+0x26c/0x578
[    2.405348]  kernel_init+0x3c/0x258
[    2.405360]  ret_from_fork+0x10/0x20
[    2.405370] ---[ end trace 0000000000000000 ]---

To address this, alias kmem_cache for sizes smaller than min alignment
to the aligned sized kmem_cache, as done with the default system kmalloc
bucket.

Cc: <stable@vger.kernel.org> # 6.11.x
Fixes: b32801d1255b ("mm/slab: Introduce kmem_buckets_create() and family")
Signed-off-by: Koichiro Den <koichiro.den@gmail.com>
---
 mm/slab_common.c | 102 ++++++++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 40 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3d26c257ed8b..64140561dd0e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -354,6 +354,38 @@ struct kmem_cache *__kmem_cache_create_args(const char *name,
 }
 EXPORT_SYMBOL(__kmem_cache_create_args);
 
+static unsigned int __kmalloc_minalign(void)
+{
+	unsigned int minalign = dma_get_cache_alignment();
+
+	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
+	    is_swiotlb_allocated())
+		minalign = ARCH_KMALLOC_MINALIGN;
+
+	return max(minalign, arch_slab_minalign());
+}
+
+static unsigned int __kmalloc_aligned_size(unsigned int idx)
+{
+	unsigned int aligned_size = kmalloc_info[idx].size;
+	unsigned int minalign = __kmalloc_minalign();
+
+	if (minalign > ARCH_KMALLOC_MINALIGN)
+		aligned_size = ALIGN(aligned_size, minalign);
+
+	return aligned_size;
+}
+
+static unsigned int __kmalloc_aligned_idx(unsigned int idx)
+{
+	unsigned int minalign = __kmalloc_minalign();
+
+	if (minalign > ARCH_KMALLOC_MINALIGN)
+		return __kmalloc_index(__kmalloc_aligned_size(idx), false);
+
+	return idx;
+}
+
 static struct kmem_cache *kmem_buckets_cache __ro_after_init;
 
 /**
@@ -381,7 +413,10 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 				  void (*ctor)(void *))
 {
 	kmem_buckets *b;
-	int idx;
+	unsigned int idx;
+	unsigned long mask = 0;
+
+	BUILD_BUG_ON(ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]) > BITS_PER_LONG);
 
 	/*
 	 * When the separate buckets API is not built in, just return
@@ -402,43 +437,47 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 
 	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
 		char *short_size, *cache_name;
+		unsigned int aligned_size = __kmalloc_aligned_size(idx);
+		unsigned int aligned_idx = __kmalloc_aligned_idx(idx);
 		unsigned int cache_useroffset, cache_usersize;
-		unsigned int size;
 
+		/* this might be an aliased kmem_cache */
 		if (!kmalloc_caches[KMALLOC_NORMAL][idx])
 			continue;
 
-		size = kmalloc_caches[KMALLOC_NORMAL][idx]->object_size;
-		if (!size)
-			continue;
-
 		short_size = strchr(kmalloc_caches[KMALLOC_NORMAL][idx]->name, '-');
 		if (WARN_ON(!short_size))
 			goto fail;
 
-		cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
-		if (WARN_ON(!cache_name))
-			goto fail;
-
-		if (useroffset >= size) {
+		if (useroffset >= aligned_size) {
 			cache_useroffset = 0;
 			cache_usersize = 0;
 		} else {
 			cache_useroffset = useroffset;
-			cache_usersize = min(size - cache_useroffset, usersize);
+			cache_usersize = min(aligned_size - cache_useroffset, usersize);
 		}
-		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
-					0, flags, cache_useroffset,
-					cache_usersize, ctor);
-		kfree(cache_name);
-		if (WARN_ON(!(*b)[idx]))
-			goto fail;
+
+		if (!(*b)[aligned_idx]) {
+			cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
+			if (WARN_ON(!cache_name))
+				goto fail;
+			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, aligned_size,
+						0, flags, cache_useroffset,
+						cache_usersize, ctor);
+			if (WARN_ON(!(*b)[aligned_idx])) {
+				kfree(cache_name);
+				goto fail;
+			}
+			set_bit(aligned_idx, &mask);
+		}
+		if (idx != aligned_idx)
+			(*b)[idx] = (*b)[aligned_idx];
 	}
 
 	return b;
 
 fail:
-	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++)
+	for_each_set_bit(idx, &mask, ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]))
 		kmem_cache_destroy((*b)[idx]);
 	kmem_cache_free(kmem_buckets_cache, b);
 
@@ -871,24 +910,12 @@ void __init setup_kmalloc_cache_index_table(void)
 	}
 }
 
-static unsigned int __kmalloc_minalign(void)
-{
-	unsigned int minalign = dma_get_cache_alignment();
-
-	if (IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
-	    is_swiotlb_allocated())
-		minalign = ARCH_KMALLOC_MINALIGN;
-
-	return max(minalign, arch_slab_minalign());
-}
-
 static void __init
-new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
+new_kmalloc_cache(unsigned int idx, enum kmalloc_cache_type type)
 {
 	slab_flags_t flags = 0;
-	unsigned int minalign = __kmalloc_minalign();
-	unsigned int aligned_size = kmalloc_info[idx].size;
-	int aligned_idx = idx;
+	unsigned int aligned_size = __kmalloc_aligned_size(idx);
+	unsigned int aligned_idx = __kmalloc_aligned_idx(idx);
 
 	if ((KMALLOC_RECLAIM != KMALLOC_NORMAL) && (type == KMALLOC_RECLAIM)) {
 		flags |= SLAB_RECLAIM_ACCOUNT;
@@ -914,11 +941,6 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
 	if (IS_ENABLED(CONFIG_MEMCG) && (type == KMALLOC_NORMAL))
 		flags |= SLAB_NO_MERGE;
 
-	if (minalign > ARCH_KMALLOC_MINALIGN) {
-		aligned_size = ALIGN(aligned_size, minalign);
-		aligned_idx = __kmalloc_index(aligned_size, false);
-	}
-
 	if (!kmalloc_caches[type][aligned_idx])
 		kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
 					kmalloc_info[aligned_idx].name[type],
@@ -934,7 +956,7 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type)
  */
 void __init create_kmalloc_caches(void)
 {
-	int i;
+	unsigned int i;
 	enum kmalloc_cache_type type;
 
 	/*
-- 
2.43.0



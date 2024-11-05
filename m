Return-Path: <stable+bounces-89773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0EE9BC326
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 03:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC311F22941
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 02:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BF836AF5;
	Tue,  5 Nov 2024 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ryy/BDpX"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14301CD0C;
	Tue,  5 Nov 2024 02:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773681; cv=none; b=Vd8csi0VMKoZ27gn6lPEmuEbXmeJS/cISqxH0bT+sQ7GACptEcU0yVGFE+AqoOfIO5hB9g6bYKeFQvW+uRO0oxrz/enFSS5o2d2tBWsDzNUJ0xg4yzpcxNV9XY8a7vRZqx9odQr41X3P+ZcY1eX2U1+PrJbTWTBcGB3IkKrbE1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773681; c=relaxed/simple;
	bh=qojZhkK0Bv0/lJqVqNfhHkf1s2OiTV5B0rXx6mnBHtI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TN/2M3lJWqLKR+VGe/g4lMVbxqKRY9AA271xlUOaYdqUHWxIXhxaNN/pD9ZKwDw3+0xUK6WLc4WaBwC/X4ujIbHbUrtEUqMCuoEmz84uUVsraGuELw63+4cvVc3WgROlhEd2CF+a7Pirw1lQJfmgXQTAhk2CDgz0x9YX1Q4++c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ryy/BDpX; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720be27db27so3936044b3a.2;
        Mon, 04 Nov 2024 18:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730773679; x=1731378479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3W30/6d3+CvWP0OuyYGi+x0OLlLYD4V/Fui7cKummCc=;
        b=Ryy/BDpXkt85lmEBzScntp8qO2XGPNJ5yMShI1M6fcdVDoh6skTaB/mNrF6tzHIDHh
         B++fuP7eTQa0ltbRIDbS1HRuSUxbMgKd8lP6m2nxhG1p+CnNpVV8Ad1IQoasI8ojbs2J
         NpPYn/j80iPGoTuX1q5Byq0ElgzELz6UfAhwH1LcbhZ4Znd6WR84KKr/jbvaNrdt7DZS
         i2IPQiprXuasO5zo1bRWi8fcN2QxQQFwyMTcvBiJKr89naDMWT50ECU3jclLqKFq4clb
         tWHlHFw11uZ86bm0zH50TwZqy9+1Y7WS/9iIAwiGiiJ983VGNUVuMkaLqzVvHdGSVQi3
         QUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730773679; x=1731378479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3W30/6d3+CvWP0OuyYGi+x0OLlLYD4V/Fui7cKummCc=;
        b=QHiXx3rHlHxXzXf1gxswEWj/RHxI2T9f9yrx9NzeAVKOuBXeEOZL9s/mcHqevZLVd2
         hPVJs6e2BdymPEG3z22bMPnQfTOsRZ1w8JGK7byZEYLFYiLPY8i2hyOnvs/6S2CwSk67
         W7Ba3qu/qHZHHskbWBaX/w4n0aLDB0q4Bmsqww1nYqgvBVOPtAcSSIpHYxoU4MnqcIUc
         0wVYLHtRb8vkQspUELSuVrJp7zsdqibJ/U78sctmYhDljhJA0Eb9bI+kTbEBvxRkJgk8
         BIbJAU+ht7RwXFFy1sbSZ8itsmoRAvlUAVVtiu2jME842EA1mU2df2NGSnEsC/1yNR6G
         dIfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8v0P6IK4qVMmcR713lHz+ETxATEx5c+W6IlqfNL01qnUi4MX7llY97WRiP/bv6wt/bmO8S0VDgMdNFh4=@vger.kernel.org, AJvYcCWM7YVvCm7EgfPOIf99MRMfThEstV3+4uFvhCgWy7npK63b72jChLZdN4lKqa9ujz6If2QB3Lyz@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/O1x4f5OgrdCi3vSz3XWceKQcIgtA9fGOpmw2NAMx+2/ZQeZb
	1zFIfNyXFSiL12CMXyMw4ELUiQMC23CV5OxlWGCeRrXD2RvdaTEp
X-Google-Smtp-Source: AGHT+IEBfwZMMO7o+N9Ba2wkkaEAOh/cpsr7ZZW+06lkYCrZztGf4fqTtpOEsMgOKCnQLNdqdcWSUw==
X-Received: by 2002:a05:6a00:4644:b0:71e:7636:3323 with SMTP id d2e1a72fcca58-720ab3babdemr28407776b3a.7.1730773678850;
        Mon, 04 Nov 2024 18:27:58 -0800 (PST)
Received: from z790sl.. ([240f:74:7be:1:54ee:9253:695b:4125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2f17fasm8402127b3a.180.2024.11.04.18.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 18:27:58 -0800 (PST)
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
Subject: [PATCH v2] mm/slab: fix warning caused by duplicate kmem_cache creation in kmem_buckets_create
Date: Tue,  5 Nov 2024 11:27:47 +0900
Message-ID: <20241105022747.2819151-1-koichiro.den@gmail.com>
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
Changes in v2:
- Simplify by just reusing calculated aligned size stored in
  the default kmalloc_caches
---
 mm/slab_common.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3d26c257ed8b..db6ffe53c23e 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -380,8 +380,11 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 				  unsigned int usersize,
 				  void (*ctor)(void *))
 {
+	unsigned long mask = 0;
+	unsigned int idx;
 	kmem_buckets *b;
-	int idx;
+
+	BUILD_BUG_ON(ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]) > BITS_PER_LONG);
 
 	/*
 	 * When the separate buckets API is not built in, just return
@@ -403,7 +406,7 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
 		char *short_size, *cache_name;
 		unsigned int cache_useroffset, cache_usersize;
-		unsigned int size;
+		unsigned int size, aligned_idx;
 
 		if (!kmalloc_caches[KMALLOC_NORMAL][idx])
 			continue;
@@ -416,10 +419,6 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 		if (WARN_ON(!short_size))
 			goto fail;
 
-		cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
-		if (WARN_ON(!cache_name))
-			goto fail;
-
 		if (useroffset >= size) {
 			cache_useroffset = 0;
 			cache_usersize = 0;
@@ -427,18 +426,29 @@ kmem_buckets *kmem_buckets_create(const char *name, slab_flags_t flags,
 			cache_useroffset = useroffset;
 			cache_usersize = min(size - cache_useroffset, usersize);
 		}
-		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
-					0, flags, cache_useroffset,
-					cache_usersize, ctor);
-		kfree(cache_name);
-		if (WARN_ON(!(*b)[idx]))
-			goto fail;
+
+		aligned_idx = __kmalloc_index(size, false);
+		if (!(*b)[aligned_idx]) {
+			cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
+			if (WARN_ON(!cache_name))
+				goto fail;
+			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, size,
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
 
-- 
2.43.0



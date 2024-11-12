Return-Path: <stable+bounces-92742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8127B9C561D
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 12:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA696B300F8
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5271621B426;
	Tue, 12 Nov 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Zm/N7y+L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F68B20E307;
	Tue, 12 Nov 2024 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408442; cv=none; b=dOZFGDX1jFdzLuqiiQBR0amCwwxXVB7gPwbje/EypSv+ovSyM+Lsq2cDWCtZUIyr+5eJCUkiXmfEIyUKE54Y1TPjdnK+NNq6giGlS9AfQtCOQW63oLqSFSAeTMFe7Gwx/GJOTJOLKJSg2QBVnghm9DOGhJOZri2AkHZVFiHWfYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408442; c=relaxed/simple;
	bh=S0RXicJi/HoPDwsvlxX06mIilJHvnlJ0qW1O+eWDMBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEg7MRSZnaDhSVaPJcHYcvmnkp4B2xcIMNm9rmm6bnDVHniEc3HTlNRYCeZFk/CxSHVaahvNr+IG2qg5ZEQ+70AHPsdSWQuz5gTqDbvnz09e75XfOT2Ut8FeYaew99ymE+jm7YUpJrdEk00CILw5rFozEvJoCM5lSK3xy6GofBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Zm/N7y+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89104C4CECD;
	Tue, 12 Nov 2024 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731408441;
	bh=S0RXicJi/HoPDwsvlxX06mIilJHvnlJ0qW1O+eWDMBw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zm/N7y+L35QafO53Cc81LGv0cKfRYqKge4qIl0pNxi7vnsMok17qys+s2gGSzp8R0
	 ShLory6ne4VBd0yO1K3h+9Qg0Ox3sFxzdp3TiIDVUyE53rbJLf3ZL2Jx0ZbOzPSCGa
	 csp7vjDfIjFgrEcMTbB+knafcx9L8F3qKFfRHZlg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Koichiro Den <koichiro.den@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 6.11 132/184] mm/slab: fix warning caused by duplicate kmem_cache creation in kmem_buckets_create
Date: Tue, 12 Nov 2024 11:21:30 +0100
Message-ID: <20241112101905.933255618@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241112101900.865487674@linuxfoundation.org>
References: <20241112101900.865487674@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Koichiro Den <koichiro.den@gmail.com>

commit 9c9201afebea1efc7ea4b8f721ee18a05bb8aca1 upstream.

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

Fixes: b32801d1255b ("mm/slab: Introduce kmem_buckets_create() and family")
Cc: <stable@vger.kernel.org> # v6.11+
Signed-off-by: Koichiro Den <koichiro.den@gmail.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/slab_common.c |   31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -418,8 +418,11 @@ kmem_buckets *kmem_buckets_create(const
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
@@ -441,7 +444,7 @@ kmem_buckets *kmem_buckets_create(const
 	for (idx = 0; idx < ARRAY_SIZE(kmalloc_caches[KMALLOC_NORMAL]); idx++) {
 		char *short_size, *cache_name;
 		unsigned int cache_useroffset, cache_usersize;
-		unsigned int size;
+		unsigned int size, aligned_idx;
 
 		if (!kmalloc_caches[KMALLOC_NORMAL][idx])
 			continue;
@@ -454,10 +457,6 @@ kmem_buckets *kmem_buckets_create(const
 		if (WARN_ON(!short_size))
 			goto fail;
 
-		cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
-		if (WARN_ON(!cache_name))
-			goto fail;
-
 		if (useroffset >= size) {
 			cache_useroffset = 0;
 			cache_usersize = 0;
@@ -465,18 +464,28 @@ kmem_buckets *kmem_buckets_create(const
 			cache_useroffset = useroffset;
 			cache_usersize = min(size - cache_useroffset, usersize);
 		}
-		(*b)[idx] = kmem_cache_create_usercopy(cache_name, size,
+
+		aligned_idx = __kmalloc_index(size, false);
+		if (!(*b)[aligned_idx]) {
+			cache_name = kasprintf(GFP_KERNEL, "%s-%s", name, short_size + 1);
+			if (WARN_ON(!cache_name))
+				goto fail;
+			(*b)[aligned_idx] = kmem_cache_create_usercopy(cache_name, size,
 					0, flags, cache_useroffset,
 					cache_usersize, ctor);
-		kfree(cache_name);
-		if (WARN_ON(!(*b)[idx]))
-			goto fail;
+			kfree(cache_name);
+			if (WARN_ON(!(*b)[aligned_idx]))
+				goto fail;
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
 	kfree(b);
 




Return-Path: <stable+bounces-13364-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96A8837CD0
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 02:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C31B29173
	for <lists+stable@lfdr.de>; Tue, 23 Jan 2024 01:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488AC154454;
	Tue, 23 Jan 2024 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zumYng2Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892F154452;
	Tue, 23 Jan 2024 00:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969380; cv=none; b=N/xMpAmqDgQx+h2IPN7tIZ7v/HArPKZoOzbEH/e5m0SKv5WqbAefSPAlxj8x8unwKAb6E0r9MG24BPdoqHkDHcJazeMahNd2/daJPBiSDikijjLzy5gCyFNFyvI2dn1Vy4K0Sd3qnrIpi2RVn7ZO10esyZypDObCtZLVAbFYT10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969380; c=relaxed/simple;
	bh=GuMTgoTQNZBK+9hlgDV9xaMh7/RVeLYtDadOguf1ssM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OuDZImYBL5Lw75VsiOH2gXC7gSUz4344NT9fAL0b0Kq5R18FkTYYXHSnfeIAKsse6LmItejM0TEIrDVazhqqdHJKLnc1/HLfXhYUzDwwddK0rfzdwSySjcTmhu7cwcfgTbyuGWiumvl97vdm/Nnbg1ROXeflJG5tnRyLNAAnSq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zumYng2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AF9C433F1;
	Tue, 23 Jan 2024 00:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705969379;
	bh=GuMTgoTQNZBK+9hlgDV9xaMh7/RVeLYtDadOguf1ssM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zumYng2QiG5T1BF1YaXB6ug39CS2ar3c7tGL4c6dUjbgJ8cbBKcH4f3q9dPwVaj0B
	 JSrh+ZKuoZQGxoRANTVUcG14gmVHu6DMZWFAYul8aJY9ptaK95/bjTcNVXgTYb47N/
	 YjW1tBcZAQjfpdSXoIg6JU/Pcp50Of4naMpIuoXo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <oliver.sang@intel.com>,
	Hou Tao <houtao1@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 206/641] bpf: Use c->unit_size to select target cache during free
Date: Mon, 22 Jan 2024 15:51:50 -0800
Message-ID: <20240122235824.398231517@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122235818.091081209@linuxfoundation.org>
References: <20240122235818.091081209@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hou Tao <houtao1@huawei.com>

[ Upstream commit 7ac5c53e00735d183a0f5e2cfce5eeb6c16319f2 ]

At present, bpf memory allocator uses check_obj_size() to ensure that
ksize() of allocated pointer is equal with the unit_size of used
bpf_mem_cache. Its purpose is to prevent bpf_mem_free() from selecting
a bpf_mem_cache which has different unit_size compared with the
bpf_mem_cache used for allocation. But as reported by lkp, the return
value of ksize() or kmalloc_size_roundup() may change due to slab merge
and it will lead to the warning report in check_obj_size().

The reported warning happened as follows:
(1) in bpf_mem_cache_adjust_size(), kmalloc_size_roundup(96) returns the
object_size of kmalloc-96 instead of kmalloc-cg-96. The object_size of
kmalloc-96 is 96, so size_index for 96 is not adjusted accordingly.
(2) the object_size of kmalloc-cg-96 is adjust from 96 to 128 due to
slab merge in __kmem_cache_alias(). For SLAB, SLAB_HWCACHE_ALIGN is
enabled by default for kmalloc slab, so align is 64 and size is 128 for
kmalloc-cg-96. SLUB has a similar merge logic, but its object_size will
not be changed, because its align is 8 under x86-64.
(3) when unit_alloc() does kmalloc_node(96, __GFP_ACCOUNT, node),
ksize() returns 128 instead of 96 for the returned pointer.
(4) the warning in check_obj_size() is triggered.

Considering the slab merge can happen in anytime (e.g, a slab created in
a new module), the following case is also possible: during the
initialization of bpf_global_ma, there is no slab merge and ksize() for
a 96-bytes object returns 96. But after that a new slab created by a
kernel module is merged to kmalloc-cg-96 and the object_size of
kmalloc-cg-96 is adjust from 96 to 128 (which is possible for x86-64 +
CONFIG_SLAB, because its alignment requirement is 64 for 96-bytes slab).
So soon or later, when bpf_global_ma frees a 96-byte-sized pointer
which is allocated from bpf_mem_cache with unit_size=96, bpf_mem_free()
will free the pointer through a bpf_mem_cache in which unit_size is 128,
because the return value of ksize() changes. The warning for the
mismatch will be triggered again.

A feasible fix is introducing similar APIs compared with ksize() and
kmalloc_size_roundup() to return the actually-allocated size instead of
size which may change due to slab merge, but it will introduce
unnecessary dependency on the implementation details of mm subsystem.

As for now the pointer of bpf_mem_cache is saved in the 8-bytes area
(or 4-bytes under 32-bit host) above the returned pointer, using
unit_size in the saved bpf_mem_cache to select the target cache instead
of inferring the size from the pointer itself. Beside no extra
dependency on mm subsystem, the performance for bpf_mem_free_rcu() is
also improved as shown below.

Before applying the patch, the performances of bpf_mem_alloc() and
bpf_mem_free_rcu() on 8-CPUs VM with one producer are as follows:

kmalloc : alloc 11.69 ± 0.28M/s free 29.58 ± 0.93M/s
percpu  : alloc 14.11 ± 0.52M/s free 14.29 ± 0.99M/s

After apply the patch, the performance for bpf_mem_free_rcu() increases
9% and 146% for kmalloc memory and per-cpu memory respectively:

kmalloc: alloc 11.01 ± 0.03M/s free   32.42 ± 0.48M/s
percpu:  alloc 12.84 ± 0.12M/s free   35.24 ± 0.23M/s

After the fixes, there is no need to adjust size_index to fix the
mismatch between allocation and free, so remove it as well. Also return
NULL instead of ZERO_SIZE_PTR for zero-sized alloc in bpf_mem_alloc(),
because there is no bpf_mem_cache pointer saved above ZERO_SIZE_PTR.

Fixes: 9077fc228f09 ("bpf: Use kmalloc_size_roundup() to adjust size_index")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/bpf/202310302113.9f8fe705-oliver.sang@intel.com
Signed-off-by: Hou Tao <houtao1@huawei.com>
Link: https://lore.kernel.org/r/20231216131052.27621-2-houtao@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/memalloc.c | 105 +++++-------------------------------------
 1 file changed, 11 insertions(+), 94 deletions(-)

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 6a51cfe4c2d6..aa0fbf000a12 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -490,27 +490,6 @@ static void prefill_mem_cache(struct bpf_mem_cache *c, int cpu)
 	alloc_bulk(c, c->unit_size <= 256 ? 4 : 1, cpu_to_node(cpu), false);
 }
 
-static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
-{
-	struct llist_node *first;
-	unsigned int obj_size;
-
-	first = c->free_llist.first;
-	if (!first)
-		return 0;
-
-	if (c->percpu_size)
-		obj_size = pcpu_alloc_size(((void **)first)[1]);
-	else
-		obj_size = ksize(first);
-	if (obj_size != c->unit_size) {
-		WARN_ONCE(1, "bpf_mem_cache[%u]: percpu %d, unexpected object size %u, expect %u\n",
-			  idx, c->percpu_size, obj_size, c->unit_size);
-		return -EINVAL;
-	}
-	return 0;
-}
-
 /* When size != 0 bpf_mem_cache for each cpu.
  * This is typical bpf hash map use case when all elements have equal size.
  *
@@ -521,10 +500,10 @@ static int check_obj_size(struct bpf_mem_cache *c, unsigned int idx)
 int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 {
 	static u16 sizes[NUM_CACHES] = {96, 192, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096};
-	int cpu, i, err, unit_size, percpu_size = 0;
 	struct bpf_mem_caches *cc, __percpu *pcc;
 	struct bpf_mem_cache *c, __percpu *pc;
 	struct obj_cgroup *objcg = NULL;
+	int cpu, i, unit_size, percpu_size = 0;
 
 	/* room for llist_node and per-cpu pointer */
 	if (percpu)
@@ -560,7 +539,6 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 	pcc = __alloc_percpu_gfp(sizeof(*cc), 8, GFP_KERNEL);
 	if (!pcc)
 		return -ENOMEM;
-	err = 0;
 #ifdef CONFIG_MEMCG_KMEM
 	objcg = get_obj_cgroup_from_current();
 #endif
@@ -574,28 +552,12 @@ int bpf_mem_alloc_init(struct bpf_mem_alloc *ma, int size, bool percpu)
 			c->tgt = c;
 
 			init_refill_work(c);
-			/* Another bpf_mem_cache will be used when allocating
-			 * c->unit_size in bpf_mem_alloc(), so doesn't prefill
-			 * for the bpf_mem_cache because these free objects will
-			 * never be used.
-			 */
-			if (i != bpf_mem_cache_idx(c->unit_size))
-				continue;
 			prefill_mem_cache(c, cpu);
-			err = check_obj_size(c, i);
-			if (err)
-				goto out;
 		}
 	}
 
-out:
 	ma->caches = pcc;
-	/* refill_work is either zeroed or initialized, so it is safe to
-	 * call irq_work_sync().
-	 */
-	if (err)
-		bpf_mem_alloc_destroy(ma);
-	return err;
+	return 0;
 }
 
 static void drain_mem_cache(struct bpf_mem_cache *c)
@@ -869,7 +831,7 @@ void notrace *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size)
 	void *ret;
 
 	if (!size)
-		return ZERO_SIZE_PTR;
+		return NULL;
 
 	idx = bpf_mem_cache_idx(size + LLIST_NODE_SZ);
 	if (idx < 0)
@@ -879,26 +841,17 @@ void notrace *bpf_mem_alloc(struct bpf_mem_alloc *ma, size_t size)
 	return !ret ? NULL : ret + LLIST_NODE_SZ;
 }
 
-static notrace int bpf_mem_free_idx(void *ptr, bool percpu)
-{
-	size_t size;
-
-	if (percpu)
-		size = pcpu_alloc_size(*((void **)ptr));
-	else
-		size = ksize(ptr - LLIST_NODE_SZ);
-	return bpf_mem_cache_idx(size);
-}
-
 void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
 {
+	struct bpf_mem_cache *c;
 	int idx;
 
 	if (!ptr)
 		return;
 
-	idx = bpf_mem_free_idx(ptr, ma->percpu);
-	if (idx < 0)
+	c = *(void **)(ptr - LLIST_NODE_SZ);
+	idx = bpf_mem_cache_idx(c->unit_size);
+	if (WARN_ON_ONCE(idx < 0))
 		return;
 
 	unit_free(this_cpu_ptr(ma->caches)->cache + idx, ptr);
@@ -906,13 +859,15 @@ void notrace bpf_mem_free(struct bpf_mem_alloc *ma, void *ptr)
 
 void notrace bpf_mem_free_rcu(struct bpf_mem_alloc *ma, void *ptr)
 {
+	struct bpf_mem_cache *c;
 	int idx;
 
 	if (!ptr)
 		return;
 
-	idx = bpf_mem_free_idx(ptr, ma->percpu);
-	if (idx < 0)
+	c = *(void **)(ptr - LLIST_NODE_SZ);
+	idx = bpf_mem_cache_idx(c->unit_size);
+	if (WARN_ON_ONCE(idx < 0))
 		return;
 
 	unit_free_rcu(this_cpu_ptr(ma->caches)->cache + idx, ptr);
@@ -986,41 +941,3 @@ void notrace *bpf_mem_cache_alloc_flags(struct bpf_mem_alloc *ma, gfp_t flags)
 
 	return !ret ? NULL : ret + LLIST_NODE_SZ;
 }
-
-/* The alignment of dynamic per-cpu area is 8, so c->unit_size and the
- * actual size of dynamic per-cpu area will always be matched and there is
- * no need to adjust size_index for per-cpu allocation. However for the
- * simplicity of the implementation, use an unified size_index for both
- * kmalloc and per-cpu allocation.
- */
-static __init int bpf_mem_cache_adjust_size(void)
-{
-	unsigned int size;
-
-	/* Adjusting the indexes in size_index() according to the object_size
-	 * of underlying slab cache, so bpf_mem_alloc() will select a
-	 * bpf_mem_cache with unit_size equal to the object_size of
-	 * the underlying slab cache.
-	 *
-	 * The maximal value of KMALLOC_MIN_SIZE and __kmalloc_minalign() is
-	 * 256-bytes, so only do adjustment for [8-bytes, 192-bytes].
-	 */
-	for (size = 192; size >= 8; size -= 8) {
-		unsigned int kmalloc_size, index;
-
-		kmalloc_size = kmalloc_size_roundup(size);
-		if (kmalloc_size == size)
-			continue;
-
-		if (kmalloc_size <= 192)
-			index = size_index[(kmalloc_size - 1) / 8];
-		else
-			index = fls(kmalloc_size - 1) - 1;
-		/* Only overwrite if necessary */
-		if (size_index[(size - 1) / 8] != index)
-			size_index[(size - 1) / 8] = index;
-	}
-
-	return 0;
-}
-subsys_initcall(bpf_mem_cache_adjust_size);
-- 
2.43.0





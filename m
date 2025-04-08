Return-Path: <stable+bounces-129909-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAC2A801EC
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C82317B54F
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6910622424C;
	Tue,  8 Apr 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MvIxselg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2534019AD5C;
	Tue,  8 Apr 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112302; cv=none; b=UJLrmjLOnXRjt2Nu7mCC2TIrWyrOI3OgW5p0B8OVBzOjlu09AHyRW8GppJ2B/ft65G6+y/VmeWykMftwy2KAPsORD3LGHOAsuAEzq6qSSgCC+jp0w4vVbIG9hltxFlq29Z/QlPmthswdfERe+lvZBTdpfElo8jWJrq9dumzE1To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112302; c=relaxed/simple;
	bh=3PWCYpEfOh4ZQhe5bB4qm0t6iWbzqACN6Aa3X5Kssfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYwjqJnQW9BpOOKK7RT5i3HoQYjnOo/kIT5M1njtiulG0UX91wlrRgq9jAzlEoejt+6KjrcM0/kummuvgfR5BhuMX5KmHctrmPPavKxYNgonnIDMBxxo+WzaS5TYDa1mND8Gi2qAG9WmUscf2a+zxHn4qIUobaAN4IK6pnl57rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MvIxselg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85B6C4CEE5;
	Tue,  8 Apr 2025 11:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112302;
	bh=3PWCYpEfOh4ZQhe5bB4qm0t6iWbzqACN6Aa3X5Kssfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MvIxselgX/jIEGEnCg9RjrBOGuZQZ+FUgPBuMBSSSI3Bz9zR2aysZW8U7tSqj3JYa
	 nNNGnZpCdpidOlj5J1Q3Kc0+/EuK/OzxU2ewFWDRI5OzQvwohPlX7A5e6i4jgji/9f
	 XPc2JFlsWPGkP4sEpzGj+fuwqqu3gGBBeDKvy1jI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vlastimil Babka <vbabka@suse.cz>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 019/279] slab: Introduce kmalloc_size_roundup()
Date: Tue,  8 Apr 2025 12:46:42 +0200
Message-ID: <20250408104826.900462674@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 05a940656e1eb2026d9ee31019d5b47e9545124d ]

In the effort to help the compiler reason about buffer sizes, the
__alloc_size attribute was added to allocators. This improves the scope
of the compiler's ability to apply CONFIG_UBSAN_BOUNDS and (in the near
future) CONFIG_FORTIFY_SOURCE. For most allocations, this works well,
as the vast majority of callers are not expecting to use more memory
than what they asked for.

There is, however, one common exception to this: anticipatory resizing
of kmalloc allocations. These cases all use ksize() to determine the
actual bucket size of a given allocation (e.g. 128 when 126 was asked
for). This comes in two styles in the kernel:

1) An allocation has been determined to be too small, and needs to be
   resized. Instead of the caller choosing its own next best size, it
   wants to minimize the number of calls to krealloc(), so it just uses
   ksize() plus some additional bytes, forcing the realloc into the next
   bucket size, from which it can learn how large it is now. For example:

	data = krealloc(data, ksize(data) + 1, gfp);
	data_len = ksize(data);

2) The minimum size of an allocation is calculated, but since it may
   grow in the future, just use all the space available in the chosen
   bucket immediately, to avoid needing to reallocate later. A good
   example of this is skbuff's allocators:

	data = kmalloc_reserve(size, gfp_mask, node, &pfmemalloc);
	...
	/* kmalloc(size) might give us more room than requested.
	 * Put skb_shared_info exactly at the end of allocated zone,
	 * to allow max possible filling before reallocation.
	 */
	osize = ksize(data);
        size = SKB_WITH_OVERHEAD(osize);

In both cases, the "how much was actually allocated?" question is answered
_after_ the allocation, where the compiler hinting is not in an easy place
to make the association any more. This mismatch between the compiler's
view of the buffer length and the code's intention about how much it is
going to actually use has already caused problems[1]. It is possible to
fix this by reordering the use of the "actual size" information.

We can serve the needs of users of ksize() and still have accurate buffer
length hinting for the compiler by doing the bucket size calculation
_before_ the allocation. Code can instead ask "how large an allocation
would I get for a given size?".

Introduce kmalloc_size_roundup(), to serve this function so we can start
replacing the "anticipatory resizing" uses of ksize().

[1] https://github.com/ClangBuiltLinux/linux/issues/1599
    https://github.com/KSPP/linux/issues/183

[ vbabka@suse.cz: add SLOB version ]

Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Stable-dep-of: a1e64addf3ff ("net: openvswitch: remove misbehaving actions length check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/slab.h | 31 +++++++++++++++++++++++++++++++
 mm/slab.c            |  9 ++++++---
 mm/slab_common.c     | 20 ++++++++++++++++++++
 mm/slob.c            | 14 ++++++++++++++
 4 files changed, 71 insertions(+), 3 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index d9f14125d7a2b..3482c2ced139e 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -185,7 +185,21 @@ void * __must_check krealloc(const void *objp, size_t new_size, gfp_t flags);
 void kfree(const void *objp);
 void kfree_sensitive(const void *objp);
 size_t __ksize(const void *objp);
+
+/**
+ * ksize - Report actual allocation size of associated object
+ *
+ * @objp: Pointer returned from a prior kmalloc()-family allocation.
+ *
+ * This should not be used for writing beyond the originally requested
+ * allocation size. Either use krealloc() or round up the allocation size
+ * with kmalloc_size_roundup() prior to allocation. If this is used to
+ * access beyond the originally requested allocation size, UBSAN_BOUNDS
+ * and/or FORTIFY_SOURCE may trip, since they only know about the
+ * originally allocated size via the __alloc_size attribute.
+ */
 size_t ksize(const void *objp);
+
 #ifdef CONFIG_PRINTK
 bool kmem_valid_obj(void *object);
 void kmem_dump_obj(void *object);
@@ -733,6 +747,23 @@ static inline void *kzalloc_node(size_t size, gfp_t flags, int node)
 }
 
 unsigned int kmem_cache_size(struct kmem_cache *s);
+
+/**
+ * kmalloc_size_roundup - Report allocation bucket size for the given size
+ *
+ * @size: Number of bytes to round up from.
+ *
+ * This returns the number of bytes that would be available in a kmalloc()
+ * allocation of @size bytes. For example, a 126 byte request would be
+ * rounded up to the next sized kmalloc bucket, 128 bytes. (This is strictly
+ * for the general-purpose kmalloc()-based allocations, and is not for the
+ * pre-sized kmem_cache_alloc()-based allocations.)
+ *
+ * Use this to kmalloc() the full bucket size ahead of time instead of using
+ * ksize() to query the size after an allocation.
+ */
+size_t kmalloc_size_roundup(size_t size);
+
 void __init kmem_cache_init_late(void);
 
 #if defined(CONFIG_SMP) && defined(CONFIG_SLAB)
diff --git a/mm/slab.c b/mm/slab.c
index f5b2246f832da..e53e50d6c29bc 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -4226,11 +4226,14 @@ void __check_heap_object(const void *ptr, unsigned long n, struct page *page,
 #endif /* CONFIG_HARDENED_USERCOPY */
 
 /**
- * __ksize -- Uninstrumented ksize.
+ * __ksize -- Report full size of underlying allocation
  * @objp: pointer to the object
  *
- * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
- * safety checks as ksize() with KASAN instrumentation enabled.
+ * This should only be used internally to query the true size of allocations.
+ * It is not meant to be a way to discover the usable size of an allocation
+ * after the fact. Instead, use kmalloc_size_roundup(). Using memory beyond
+ * the originally requested allocation size may trigger KASAN, UBSAN_BOUNDS,
+ * and/or FORTIFY_SOURCE.
  *
  * Return: size of the actual memory used by @objp in bytes
  */
diff --git a/mm/slab_common.c b/mm/slab_common.c
index f684b06649c3e..06958c613b0ac 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -758,6 +758,26 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 	return kmalloc_caches[kmalloc_type(flags)][index];
 }
 
+size_t kmalloc_size_roundup(size_t size)
+{
+	struct kmem_cache *c;
+
+	/* Short-circuit the 0 size case. */
+	if (unlikely(size == 0))
+		return 0;
+	/* Short-circuit saturated "too-large" case. */
+	if (unlikely(size == SIZE_MAX))
+		return SIZE_MAX;
+	/* Above the smaller buckets, size is a multiple of page size. */
+	if (size > KMALLOC_MAX_CACHE_SIZE)
+		return PAGE_SIZE << get_order(size);
+
+	/* The flags don't matter since size_index is common to all. */
+	c = kmalloc_slab(size, GFP_KERNEL);
+	return c ? c->object_size : 0;
+}
+EXPORT_SYMBOL(kmalloc_size_roundup);
+
 #ifdef CONFIG_ZONE_DMA
 #define KMALLOC_DMA_NAME(sz)	.name[KMALLOC_DMA] = "dma-kmalloc-" #sz,
 #else
diff --git a/mm/slob.c b/mm/slob.c
index f3fc15df971af..d4c80bf1930d1 100644
--- a/mm/slob.c
+++ b/mm/slob.c
@@ -567,6 +567,20 @@ void kfree(const void *block)
 }
 EXPORT_SYMBOL(kfree);
 
+size_t kmalloc_size_roundup(size_t size)
+{
+	/* Short-circuit the 0 size case. */
+	if (unlikely(size == 0))
+		return 0;
+	/* Short-circuit saturated "too-large" case. */
+	if (unlikely(size == SIZE_MAX))
+		return SIZE_MAX;
+
+	return ALIGN(size, ARCH_KMALLOC_MINALIGN);
+}
+
+EXPORT_SYMBOL(kmalloc_size_roundup);
+
 /* can't use ksize for kmem_cache_alloc memory, only kmalloc */
 size_t __ksize(const void *block)
 {
-- 
2.39.5





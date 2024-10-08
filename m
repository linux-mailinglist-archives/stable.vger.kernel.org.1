Return-Path: <stable+bounces-82440-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311C8994CD3
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5CB284561
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DF41DF747;
	Tue,  8 Oct 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rwt38zI/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE61D31A0;
	Tue,  8 Oct 2024 12:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392268; cv=none; b=FPUHk3T6FKBzQixDO/X9xXUN7xwRtWRyfBQhakN77w1KByBksg0g+tl0c9ti9l8CNOCuiZj8IYAKSn/lc/+s2BgXCCjGP0VjbBGFaOKMkr3tbNnVwUOf07s2YBfCfWtk1A/L2uHvSIW4qiNFOLx0Yytjc2HUdtR7lJgrroGHr5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392268; c=relaxed/simple;
	bh=Y/l36b/gR7Tti+UQrm7mTYi3GGk6mJ90WEdj/WdQOvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oi31X87AjdRQJ8BoO4ccAHb662f6+vq6WkaIAF5wBAvQyFGryGgsfJXu7DISSn2fqOa7dwjMnqGffoJ1DsM9rzNZCfsdeVPpVIuKtogtV3/t4qATtk2sbtsLjPILH8qSr/hHHwEY05ufl8n9oW4MVL+zNINp7JSYZPHDhX4om7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rwt38zI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C288FC4CECC;
	Tue,  8 Oct 2024 12:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392268;
	bh=Y/l36b/gR7Tti+UQrm7mTYi3GGk6mJ90WEdj/WdQOvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rwt38zI/IMKRiYX0TrBKnYAKb9cQU73MVYuiTX7yu973rnsSulWDugHO2a/dFrO2D
	 Jm2iMi0R6Pt4AoDEDBlXCX9FxpW8Dz7PkuDpkUxMscZm9pPd9rGFZGzzuhCbZtVPRc
	 1P2Uh6E7CpWOQNgumEua2FV7/o+iVxgUJCeREuCs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Feng Tang <feng.tang@intel.com>,
	David Rientjes <rientjes@google.com>,
	Peng Fan <peng.fan@nxp.com>,
	Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH 6.11 365/558] mm, slub: avoid zeroing kmalloc redzone
Date: Tue,  8 Oct 2024 14:06:35 +0200
Message-ID: <20241008115716.660512930@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

From: Peng Fan <peng.fan@nxp.com>

commit 59090e479ac78ae18facd4c58eb332562a23020e upstream.

Since commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra
allocated kmalloc space than requested"), setting orig_size treats
the wasted space (object_size - orig_size) as a redzone. However with
init_on_free=1 we clear the full object->size, including the redzone.

Additionally we clear the object metadata, including the stored orig_size,
making it zero, which makes check_object() treat the whole object as a
redzone.

These issues lead to the following BUG report with "slub_debug=FUZ
init_on_free=1":

[    0.000000] =============================================================================
[    0.000000] BUG kmalloc-8 (Not tainted): kmalloc Redzone overwritten
[    0.000000] -----------------------------------------------------------------------------
[    0.000000]
[    0.000000] 0xffff000010032858-0xffff00001003285f @offset=2136. First byte 0x0 instead of 0xcc
[    0.000000] FIX kmalloc-8: Restoring kmalloc Redzone 0xffff000010032858-0xffff00001003285f=0xcc
[    0.000000] Slab 0xfffffdffc0400c80 objects=36 used=23 fp=0xffff000010032a18 flags=0x3fffe0000000200(workingset|node=0|zone=0|lastcpupid=0x1ffff)
[    0.000000] Object 0xffff000010032858 @offset=2136 fp=0xffff0000100328c8
[    0.000000]
[    0.000000] Redzone  ffff000010032850: cc cc cc cc cc cc cc cc                          ........
[    0.000000] Object   ffff000010032858: cc cc cc cc cc cc cc cc                          ........
[    0.000000] Redzone  ffff000010032860: cc cc cc cc cc cc cc cc                          ........
[    0.000000] Padding  ffff0000100328b4: 00 00 00 00 00 00 00 00 00 00 00 00              ............
[    0.000000] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.11.0-rc3-next-20240814-00004-g61844c55c3f4 #144
[    0.000000] Hardware name: NXP i.MX95 19X19 board (DT)
[    0.000000] Call trace:
[    0.000000]  dump_backtrace+0x90/0xe8
[    0.000000]  show_stack+0x18/0x24
[    0.000000]  dump_stack_lvl+0x74/0x8c
[    0.000000]  dump_stack+0x18/0x24
[    0.000000]  print_trailer+0x150/0x218
[    0.000000]  check_object+0xe4/0x454
[    0.000000]  free_to_partial_list+0x2f8/0x5ec

To address the issue, use orig_size to clear the used area. And restore
the value of orig_size after clear the remaining area.

When CONFIG_SLUB_DEBUG not defined, (get_orig_size()' directly returns
s->object_size. So when using memset to init the area, the size can simply
be orig_size, as orig_size returns object_size when CONFIG_SLUB_DEBUG not
enabled. And orig_size can never be bigger than object_size.

Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated kmalloc space than requested")
Cc: <stable@vger.kernel.org>
Reviewed-by: Feng Tang <feng.tang@intel.com>
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/slub.c |  100 ++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 53 insertions(+), 47 deletions(-)

--- a/mm/slub.c
+++ b/mm/slub.c
@@ -756,6 +756,50 @@ static inline bool slab_update_freelist(
 	return false;
 }
 
+/*
+ * kmalloc caches has fixed sizes (mostly power of 2), and kmalloc() API
+ * family will round up the real request size to these fixed ones, so
+ * there could be an extra area than what is requested. Save the original
+ * request size in the meta data area, for better debug and sanity check.
+ */
+static inline void set_orig_size(struct kmem_cache *s,
+				void *object, unsigned int orig_size)
+{
+	void *p = kasan_reset_tag(object);
+	unsigned int kasan_meta_size;
+
+	if (!slub_debug_orig_size(s))
+		return;
+
+	/*
+	 * KASAN can save its free meta data inside of the object at offset 0.
+	 * If this meta data size is larger than 'orig_size', it will overlap
+	 * the data redzone in [orig_size+1, object_size]. Thus, we adjust
+	 * 'orig_size' to be as at least as big as KASAN's meta data.
+	 */
+	kasan_meta_size = kasan_metadata_size(s, true);
+	if (kasan_meta_size > orig_size)
+		orig_size = kasan_meta_size;
+
+	p += get_info_end(s);
+	p += sizeof(struct track) * 2;
+
+	*(unsigned int *)p = orig_size;
+}
+
+static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
+{
+	void *p = kasan_reset_tag(object);
+
+	if (!slub_debug_orig_size(s))
+		return s->object_size;
+
+	p += get_info_end(s);
+	p += sizeof(struct track) * 2;
+
+	return *(unsigned int *)p;
+}
+
 #ifdef CONFIG_SLUB_DEBUG
 static unsigned long object_map[BITS_TO_LONGS(MAX_OBJS_PER_PAGE)];
 static DEFINE_SPINLOCK(object_map_lock);
@@ -985,50 +1029,6 @@ static void print_slab_info(const struct
 	       &slab->__page_flags);
 }
 
-/*
- * kmalloc caches has fixed sizes (mostly power of 2), and kmalloc() API
- * family will round up the real request size to these fixed ones, so
- * there could be an extra area than what is requested. Save the original
- * request size in the meta data area, for better debug and sanity check.
- */
-static inline void set_orig_size(struct kmem_cache *s,
-				void *object, unsigned int orig_size)
-{
-	void *p = kasan_reset_tag(object);
-	unsigned int kasan_meta_size;
-
-	if (!slub_debug_orig_size(s))
-		return;
-
-	/*
-	 * KASAN can save its free meta data inside of the object at offset 0.
-	 * If this meta data size is larger than 'orig_size', it will overlap
-	 * the data redzone in [orig_size+1, object_size]. Thus, we adjust
-	 * 'orig_size' to be as at least as big as KASAN's meta data.
-	 */
-	kasan_meta_size = kasan_metadata_size(s, true);
-	if (kasan_meta_size > orig_size)
-		orig_size = kasan_meta_size;
-
-	p += get_info_end(s);
-	p += sizeof(struct track) * 2;
-
-	*(unsigned int *)p = orig_size;
-}
-
-static inline unsigned int get_orig_size(struct kmem_cache *s, void *object)
-{
-	void *p = kasan_reset_tag(object);
-
-	if (!slub_debug_orig_size(s))
-		return s->object_size;
-
-	p += get_info_end(s);
-	p += sizeof(struct track) * 2;
-
-	return *(unsigned int *)p;
-}
-
 void skip_orig_size_check(struct kmem_cache *s, const void *object)
 {
 	set_orig_size(s, (void *)object, s->object_size);
@@ -1894,7 +1894,6 @@ static inline void inc_slabs_node(struct
 							int objects) {}
 static inline void dec_slabs_node(struct kmem_cache *s, int node,
 							int objects) {}
-
 #ifndef CONFIG_SLUB_TINY
 static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
 			       void **freelist, void *nextfree)
@@ -2243,14 +2242,21 @@ bool slab_free_hook(struct kmem_cache *s
 	 */
 	if (unlikely(init)) {
 		int rsize;
-		unsigned int inuse;
+		unsigned int inuse, orig_size;
 
 		inuse = get_info_end(s);
+		orig_size = get_orig_size(s, x);
 		if (!kasan_has_integrated_init())
-			memset(kasan_reset_tag(x), 0, s->object_size);
+			memset(kasan_reset_tag(x), 0, orig_size);
 		rsize = (s->flags & SLAB_RED_ZONE) ? s->red_left_pad : 0;
 		memset((char *)kasan_reset_tag(x) + inuse, 0,
 		       s->size - inuse - rsize);
+		/*
+		 * Restore orig_size, otherwize kmalloc redzone overwritten
+		 * would be reported
+		 */
+		set_orig_size(s, x, orig_size);
+
 	}
 	/* KASAN might put x into memory quarantine, delaying its reuse. */
 	return !kasan_slab_free(s, x, init);




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930BF75CE0A
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbjGUQQ7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbjGUQQj (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E873AB5
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A74CE61D29
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90304C433C8;
        Fri, 21 Jul 2023 16:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956138;
        bh=qI8oD5pFYy2R9X/hvZ6ziPuM+NbhTCnq+MzLu1LkBko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GwOX9Zx82zd2fjvNtxXgc+NcMUaDwtnzFiOiyWpujt4hpdFNXeSfbJXBmu3Traw0d
         97ijONQkJf0GGhfrmyFRjGZM9mljLcdXb1RB2ZzSxXfwyzbirrqFKtnfAeM9NQheoT
         +9EcjbEXk0HwGyoFcRixW+nYf15NiAg+Jx382q/A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will@kernel.org>, Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        kasan-dev@googlegroups.com, Pekka Enberg <penberg@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 138/292] kasan, slub: fix HW_TAGS zeroing with slub_debug
Date:   Fri, 21 Jul 2023 18:04:07 +0200
Message-ID: <20230721160534.776366260@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

commit fdb54d96600aafe45951f549866cd6fc1af59954 upstream.

Commit 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated
kmalloc space than requested") added precise kmalloc redzone poisoning to
the slub_debug functionality.

However, this commit didn't account for HW_TAGS KASAN fully initializing
the object via its built-in memory initialization feature.  Even though
HW_TAGS KASAN memory initialization contains special memory initialization
handling for when slub_debug is enabled, it does not account for in-object
slub_debug redzones.  As a result, HW_TAGS KASAN can overwrite these
redzones and cause false-positive slub_debug reports.

To fix the issue, avoid HW_TAGS KASAN memory initialization when
slub_debug is enabled altogether.  Implement this by moving the
__slub_debug_enabled check to slab_post_alloc_hook.  Common slab code
seems like a more appropriate place for a slub_debug check anyway.

Link: https://lkml.kernel.org/r/678ac92ab790dba9198f9ca14f405651b97c8502.1688561016.git.andreyknvl@google.com
Fixes: 946fa0dbf2d8 ("mm/slub: extend redzone check to extra allocated kmalloc space than requested")
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reported-by: Will Deacon <will@kernel.org>
Acked-by: Marco Elver <elver@google.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: kasan-dev@googlegroups.com
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kasan/kasan.h |   12 ------------
 mm/slab.h        |   16 ++++++++++++++--
 2 files changed, 14 insertions(+), 14 deletions(-)

--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -466,18 +466,6 @@ static inline void kasan_unpoison(const
 
 	if (WARN_ON((unsigned long)addr & KASAN_GRANULE_MASK))
 		return;
-	/*
-	 * Explicitly initialize the memory with the precise object size to
-	 * avoid overwriting the slab redzone. This disables initialization in
-	 * the arch code and may thus lead to performance penalty. This penalty
-	 * does not affect production builds, as slab redzones are not enabled
-	 * there.
-	 */
-	if (__slub_debug_enabled() &&
-	    init && ((unsigned long)size & KASAN_GRANULE_MASK)) {
-		init = false;
-		memzero_explicit((void *)addr, size);
-	}
 	size = round_up(size, KASAN_GRANULE_SIZE);
 
 	hw_set_mem_tag_range((void *)addr, size, tag, init);
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -684,6 +684,7 @@ static inline void slab_post_alloc_hook(
 					unsigned int orig_size)
 {
 	unsigned int zero_size = s->object_size;
+	bool kasan_init = init;
 	size_t i;
 
 	flags &= gfp_allowed_mask;
@@ -701,6 +702,17 @@ static inline void slab_post_alloc_hook(
 		zero_size = orig_size;
 
 	/*
+	 * When slub_debug is enabled, avoid memory initialization integrated
+	 * into KASAN and instead zero out the memory via the memset below with
+	 * the proper size. Otherwise, KASAN might overwrite SLUB redzones and
+	 * cause false-positive reports. This does not lead to a performance
+	 * penalty on production builds, as slub_debug is not intended to be
+	 * enabled there.
+	 */
+	if (__slub_debug_enabled())
+		kasan_init = false;
+
+	/*
 	 * As memory initialization might be integrated into KASAN,
 	 * kasan_slab_alloc and initialization memset must be
 	 * kept together to avoid discrepancies in behavior.
@@ -708,8 +720,8 @@ static inline void slab_post_alloc_hook(
 	 * As p[i] might get tagged, memset and kmemleak hook come after KASAN.
 	 */
 	for (i = 0; i < size; i++) {
-		p[i] = kasan_slab_alloc(s, p[i], flags, init);
-		if (p[i] && init && !kasan_has_integrated_init())
+		p[i] = kasan_slab_alloc(s, p[i], flags, kasan_init);
+		if (p[i] && init && (!kasan_init || !kasan_has_integrated_init()))
 			memset(p[i], 0, zero_size);
 		kmemleak_alloc_recursive(p[i], s->object_size, 1,
 					 s->flags, flags);



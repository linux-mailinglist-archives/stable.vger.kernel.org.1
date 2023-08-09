Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E7A7757C3
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjHIKtu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjHIKts (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25DD110FF
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:49:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A274C630D2
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7EFC433C7;
        Wed,  9 Aug 2023 10:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578187;
        bh=cyiCJhAjrEvCmmdDk6LeUkn/43xZoWgsNe7RPfTE/Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G4P5UcTOy/q/wtRD0zjWEmueG9Jb+iy3x2iejjextNMQXas8/qUqDO0TfPy4hMALn
         tovFjZK16SD20JV0X/p1h4u5dVeKSwwsqQqCwBpTyrdpT4AMRjDh72K7d1JsryufbR
         hj7f2+6m/iZmWEZIoYjCea2dKTemDjkMgnZ91CZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        syzbot <syzbot+ece2915262061d6e0ac1@syzkaller.appspotmail.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 137/165] kasan,kmsan: remove __GFP_KSWAPD_RECLAIM usage from kasan/kmsan
Date:   Wed,  9 Aug 2023 12:41:08 +0200
Message-ID: <20230809103647.299809609@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

commit 726ccdba1521007fab4b2b7565d255fa0f2b770c upstream.

syzbot is reporting lockdep warning in __stack_depot_save(), for
the caller of __stack_depot_save() (i.e. __kasan_record_aux_stack() in
this report) is responsible for masking __GFP_KSWAPD_RECLAIM flag in
order not to wake kswapd which in turn wakes kcompactd.

Since kasan/kmsan functions might be called with arbitrary locks held,
mask __GFP_KSWAPD_RECLAIM flag from all GFP_NOWAIT/GFP_ATOMIC allocations
in kasan/kmsan.

Note that kmsan_save_stack_with_flags() is changed to mask both
__GFP_DIRECT_RECLAIM flag and __GFP_KSWAPD_RECLAIM flag, for
wakeup_kswapd() from wake_all_kswapds() from __alloc_pages_slowpath()
calls wakeup_kcompactd() if __GFP_KSWAPD_RECLAIM flag is set and
__GFP_DIRECT_RECLAIM flag is not set.

Link: https://lkml.kernel.org/r/656cb4f5-998b-c8d7-3c61-c2d37aa90f9a@I-love.SAKURA.ne.jp
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Reported-by: syzbot <syzbot+ece2915262061d6e0ac1@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=ece2915262061d6e0ac1
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Marco Elver <elver@google.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kasan/generic.c         |    4 ++--
 mm/kasan/tags.c            |    2 +-
 mm/kmsan/core.c            |    6 +++---
 mm/kmsan/instrumentation.c |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -489,7 +489,7 @@ static void __kasan_record_aux_stack(voi
 		return;
 
 	alloc_meta->aux_stack[1] = alloc_meta->aux_stack[0];
-	alloc_meta->aux_stack[0] = kasan_save_stack(GFP_NOWAIT, can_alloc);
+	alloc_meta->aux_stack[0] = kasan_save_stack(0, can_alloc);
 }
 
 void kasan_record_aux_stack(void *addr)
@@ -519,7 +519,7 @@ void kasan_save_free_info(struct kmem_ca
 	if (!free_meta)
 		return;
 
-	kasan_set_track(&free_meta->free_track, GFP_NOWAIT);
+	kasan_set_track(&free_meta->free_track, 0);
 	/* The object was freed and has free track set. */
 	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREETRACK;
 }
--- a/mm/kasan/tags.c
+++ b/mm/kasan/tags.c
@@ -140,5 +140,5 @@ void kasan_save_alloc_info(struct kmem_c
 
 void kasan_save_free_info(struct kmem_cache *cache, void *object)
 {
-	save_stack_info(cache, object, GFP_NOWAIT, true);
+	save_stack_info(cache, object, 0, true);
 }
--- a/mm/kmsan/core.c
+++ b/mm/kmsan/core.c
@@ -74,7 +74,7 @@ depot_stack_handle_t kmsan_save_stack_wi
 	nr_entries = stack_trace_save(entries, KMSAN_STACK_DEPTH, 0);
 
 	/* Don't sleep. */
-	flags &= ~__GFP_DIRECT_RECLAIM;
+	flags &= ~(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM);
 
 	handle = __stack_depot_save(entries, nr_entries, flags, true);
 	return stack_depot_set_extra_bits(handle, extra);
@@ -245,7 +245,7 @@ depot_stack_handle_t kmsan_internal_chai
 	extra_bits = kmsan_extra_bits(depth, uaf);
 
 	entries[0] = KMSAN_CHAIN_MAGIC_ORIGIN;
-	entries[1] = kmsan_save_stack_with_flags(GFP_ATOMIC, 0);
+	entries[1] = kmsan_save_stack_with_flags(__GFP_HIGH, 0);
 	entries[2] = id;
 	/*
 	 * @entries is a local var in non-instrumented code, so KMSAN does not
@@ -253,7 +253,7 @@ depot_stack_handle_t kmsan_internal_chai
 	 * positives when __stack_depot_save() passes it to instrumented code.
 	 */
 	kmsan_internal_unpoison_memory(entries, sizeof(entries), false);
-	handle = __stack_depot_save(entries, ARRAY_SIZE(entries), GFP_ATOMIC,
+	handle = __stack_depot_save(entries, ARRAY_SIZE(entries), __GFP_HIGH,
 				    true);
 	return stack_depot_set_extra_bits(handle, extra_bits);
 }
--- a/mm/kmsan/instrumentation.c
+++ b/mm/kmsan/instrumentation.c
@@ -282,7 +282,7 @@ void __msan_poison_alloca(void *address,
 
 	/* stack_depot_save() may allocate memory. */
 	kmsan_enter_runtime();
-	handle = stack_depot_save(entries, ARRAY_SIZE(entries), GFP_ATOMIC);
+	handle = stack_depot_save(entries, ARRAY_SIZE(entries), __GFP_HIGH);
 	kmsan_leave_runtime();
 
 	kmsan_internal_set_shadow_origin(address, size, -1, handle,



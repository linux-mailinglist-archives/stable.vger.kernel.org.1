Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E51778336E
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjHUT7S (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjHUT7R (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:59:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6DC18F
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:59:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82AB96470A
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D03C433C7;
        Mon, 21 Aug 2023 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647951;
        bh=iWDUk4P8sKQkD6Cjm9oKNbn77WdQ3tBoUc1YZyoI8eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VHdEt55ca4r0pdeUVX7clmNe4XoMKCJetQMkrA9h3W7Q46C8dpPH/OP3FFIY455dA
         HrpHLu1YHr131kx0M+wi6IVNeBeeKKS1U5mzP+jfKtRdw2QaI3QEey+cVDZDIaf6w/
         JLFpQZG8GuDYmKM3rywh2u4UzLUBXGOso8q1vhEA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 167/194] zsmalloc: allow only one active pool compaction context
Date:   Mon, 21 Aug 2023 21:42:26 +0200
Message-ID: <20230821194130.043557852@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sergey Senozhatsky <senozhatsky@chromium.org>

commit d2658f2052c7db6ec0a79977205f8cf1cb9effc2 upstream.

zsmalloc pool can be compacted concurrently by many contexts,
e.g.

 cc1 handle_mm_fault()
      do_anonymous_page()
       __alloc_pages_slowpath()
        try_to_free_pages()
         do_try_to_free_pages(
          lru_gen_shrink_node()
           shrink_slab()
            do_shrink_slab()
             zs_shrinker_scan()
              zs_compact()

Pool compaction is currently (basically) single-threaded as
it is performed under pool->lock. Having multiple compaction
threads results in unnecessary contention, as each thread
competes for pool->lock. This, in turn, affects all zsmalloc
operations such as zs_malloc(), zs_map_object(), zs_free(), etc.

Introduce the pool->compaction_in_progress atomic variable,
which ensures that only one compaction context can run at a
time. This reduces overall pool->lock contention in (corner)
cases when many contexts attempt to shrink zspool simultaneously.

Link: https://lkml.kernel.org/r/20230418074639.1903197-1-senozhatsky@chromium.org
Fixes: c0547d0b6a4b ("zsmalloc: consolidate zs_pool's migrate_lock and size_class's locks")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/zsmalloc.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -246,6 +246,7 @@ struct zs_pool {
 	struct work_struct free_work;
 #endif
 	spinlock_t lock;
+	atomic_t compaction_in_progress;
 };
 
 struct zspage {
@@ -2100,6 +2101,15 @@ unsigned long zs_compact(struct zs_pool
 	struct size_class *class;
 	unsigned long pages_freed = 0;
 
+	/*
+	 * Pool compaction is performed under pool->lock so it is basically
+	 * single-threaded. Having more than one thread in __zs_compact()
+	 * will increase pool->lock contention, which will impact other
+	 * zsmalloc operations that need pool->lock.
+	 */
+	if (atomic_xchg(&pool->compaction_in_progress, 1))
+		return 0;
+
 	for (i = ZS_SIZE_CLASSES - 1; i >= 0; i--) {
 		class = pool->size_class[i];
 		if (class->index != i)
@@ -2107,6 +2117,7 @@ unsigned long zs_compact(struct zs_pool
 		pages_freed += __zs_compact(pool, class);
 	}
 	atomic_long_add(pages_freed, &pool->stats.pages_compacted);
+	atomic_set(&pool->compaction_in_progress, 0);
 
 	return pages_freed;
 }
@@ -2193,6 +2204,7 @@ struct zs_pool *zs_create_pool(const cha
 
 	init_deferred_free(pool);
 	spin_lock_init(&pool->lock);
+	atomic_set(&pool->compaction_in_progress, 0);
 
 	pool->name = kstrdup(name, GFP_KERNEL);
 	if (!pool->name)



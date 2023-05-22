Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1088370C9E3
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbjEVTw5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjEVTwk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:52:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A204E129
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:52:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35EBF62B2F
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF14C433D2;
        Mon, 22 May 2023 19:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785157;
        bh=FwaJqMjyHKOmAPpdM5XeBLjmcmG5J5gwIrLef0pDgRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3NOgkUEJGNoRHdpuAspKagye1Yl5eA8L+Dph/0hJwrgB4mjtJu3+Y/b0jcnr0X8I
         C6w4tjSL1ZzUitJY6GL4CfT4KwWVeNt9mr1q7VZc3Cnn5Re2jf+c8s389/qmC71rDV
         FyNfVpEDVwVhCDRtiTFzYIZyzWMF+sbWoHwjIX/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Chris Li (Google)" <chrisl@kernel.org>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Seth Jennings <sjenning@redhat.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 329/364] mm: fix zswap writeback race condition
Date:   Mon, 22 May 2023 20:10:34 +0100
Message-Id: <20230522190420.999199161@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>

commit 04fc7816089c5a32c29a04ec94b998e219dfb946 upstream.

The zswap writeback mechanism can cause a race condition resulting in
memory corruption, where a swapped out page gets swapped in with data that
was written to a different page.

The race unfolds like this:
1. a page with data A and swap offset X is stored in zswap
2. page A is removed off the LRU by zpool driver for writeback in
   zswap-shrink work, data for A is mapped by zpool driver
3. user space program faults and invalidates page entry A, offset X is
   considered free
4. kswapd stores page B at offset X in zswap (zswap could also be
   full, if so, page B would then be IOed to X, then skip step 5.)
5. entry A is replaced by B in tree->rbroot, this doesn't affect the
   local reference held by zswap-shrink work
6. zswap-shrink work writes back A at X, and frees zswap entry A
7. swapin of slot X brings A in memory instead of B

The fix:
Once the swap page cache has been allocated (case ZSWAP_SWAPCACHE_NEW),
zswap-shrink work just checks that the local zswap_entry reference is
still the same as the one in the tree.  If it's not the same it means that
it's either been invalidated or replaced, in both cases the writeback is
aborted because the local entry contains stale data.

Reproducer:
I originally found this by running `stress` overnight to validate my work
on the zswap writeback mechanism, it manifested after hours on my test
machine.  The key to make it happen is having zswap writebacks, so
whatever setup pumps /sys/kernel/debug/zswap/written_back_pages should do
the trick.

In order to reproduce this faster on a vm, I setup a system with ~100M of
available memory and a 500M swap file, then running `stress --vm 1
--vm-bytes 300000000 --vm-stride 4000` makes it happen in matter of tens
of minutes.  One can speed things up even more by swinging
/sys/module/zswap/parameters/max_pool_percent up and down between, say, 20
and 1; this makes it reproduce in tens of seconds.  It's crucial to set
`--vm-stride` to something other than 4096 otherwise `stress` won't
realize that memory has been corrupted because all pages would have the
same data.

Link: https://lkml.kernel.org/r/20230503151200.19707-1-cerasuolodomenico@gmail.com
Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Chris Li (Google) <chrisl@kernel.org>
Cc: Dan Streetman <ddstreet@ieee.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Seth Jennings <sjenning@redhat.com>
Cc: Vitaly Wool <vitaly.wool@konsulko.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/zswap.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -995,6 +995,22 @@ static int zswap_writeback_entry(struct
 		goto fail;
 
 	case ZSWAP_SWAPCACHE_NEW: /* page is locked */
+		/*
+		 * Having a local reference to the zswap entry doesn't exclude
+		 * swapping from invalidating and recycling the swap slot. Once
+		 * the swapcache is secured against concurrent swapping to and
+		 * from the slot, recheck that the entry is still current before
+		 * writing.
+		 */
+		spin_lock(&tree->lock);
+		if (zswap_rb_search(&tree->rbroot, entry->offset) != entry) {
+			spin_unlock(&tree->lock);
+			delete_from_swap_cache(page_folio(page));
+			ret = -ENOMEM;
+			goto fail;
+		}
+		spin_unlock(&tree->lock);
+
 		/* decompress */
 		acomp_ctx = raw_cpu_ptr(entry->pool->acomp_ctx);
 		dlen = PAGE_SIZE;



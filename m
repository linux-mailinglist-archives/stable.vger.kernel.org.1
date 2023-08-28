Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C448078AA69
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjH1KV5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjH1KVf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:21:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9A5CF7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DE276389F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 608C7C433C7;
        Mon, 28 Aug 2023 10:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218076;
        bh=pCjDyhlRneiS9hVvkHU1yVaCtoLIiqP3d7ui/vJMs8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7DORtKXxwQPJVo3xqEVvw8MsODoR7IwV/G0rz3978yPe0ZYfXBpeL3x55+vMsP6c
         TififKr7eeRlnOZK1FOi5DifNmoDz+6EwcUGOYikklr3ze5Y21XIfrYsRvrVJDLDIb
         Fb8K0sm4zy7rG06WtlYPgSSsnQ5+frp/HtVnHSUs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, "T.J. Mercier" <tjmercier@google.com>,
        Yu Zhao <yuzhao@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 087/129] mm: multi-gen LRU: dont spin during memcg release
Date:   Mon, 28 Aug 2023 12:12:46 +0200
Message-ID: <20230828101200.240802547@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: T.J. Mercier <tjmercier@google.com>

commit 6867c7a3320669cbe44b905a3eb35db725c6d470 upstream.

When a memcg is in the process of being released mem_cgroup_tryget will
fail because its reference count has already reached 0.  This can happen
during reclaim if the memcg has already been offlined, and we reclaim all
remaining pages attributed to the offlined memcg.  shrink_many attempts to
skip the empty memcg in this case, and continue reclaiming from the
remaining memcgs in the old generation.  If there is only one memcg
remaining, or if all remaining memcgs are in the process of being released
then shrink_many will spin until all memcgs have finished being released.
The release occurs through a workqueue, so it can take a while before
kswapd is able to make any further progress.

This fix results in reductions in kswapd activity and direct reclaim in
a test where 28 apps (working set size > total memory) are repeatedly
launched in a random sequence:

                                       A          B      delta   ratio(%)
           allocstall_movable       5962       3539      -2423     -40.64
            allocstall_normal       2661       2417       -244      -9.17
kswapd_high_wmark_hit_quickly      53152       7594     -45558     -85.71
                   pageoutrun      57365      11750     -45615     -79.52

Link: https://lkml.kernel.org/r/20230814151636.1639123-1-tjmercier@google.com
Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: T.J. Mercier <tjmercier@google.com>
Acked-by: Yu Zhao <yuzhao@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmscan.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4818,16 +4818,17 @@ void lru_gen_release_memcg(struct mem_cg
 
 		spin_lock_irq(&pgdat->memcg_lru.lock);
 
-		VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
+		if (hlist_nulls_unhashed(&lruvec->lrugen.list))
+			goto unlock;
 
 		gen = lruvec->lrugen.gen;
 
-		hlist_nulls_del_rcu(&lruvec->lrugen.list);
+		hlist_nulls_del_init_rcu(&lruvec->lrugen.list);
 		pgdat->memcg_lru.nr_memcgs[gen]--;
 
 		if (!pgdat->memcg_lru.nr_memcgs[gen] && gen == get_memcg_gen(pgdat->memcg_lru.seq))
 			WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
-
+unlock:
 		spin_unlock_irq(&pgdat->memcg_lru.lock);
 	}
 }
@@ -5398,8 +5399,10 @@ restart:
 	rcu_read_lock();
 
 	hlist_nulls_for_each_entry_rcu(lrugen, pos, &pgdat->memcg_lru.fifo[gen][bin], list) {
-		if (op)
+		if (op) {
 			lru_gen_rotate_memcg(lruvec, op);
+			op = 0;
+		}
 
 		mem_cgroup_put(memcg);
 
@@ -5407,7 +5410,7 @@ restart:
 		memcg = lruvec_memcg(lruvec);
 
 		if (!mem_cgroup_tryget(memcg)) {
-			op = 0;
+			lru_gen_release_memcg(memcg);
 			memcg = NULL;
 			continue;
 		}



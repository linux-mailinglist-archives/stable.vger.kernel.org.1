Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733AD75543F
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbjGPU2Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjGPU2P (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:28:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CD69F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:28:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81B1A60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C18FC433C7;
        Sun, 16 Jul 2023 20:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689539293;
        bh=fr9tjqv66lJRa/6aTa5Dna/KfbpxsxmUd81zJSlCMgY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w94TPuLZEJPA++4guNwh5v3Tv+FOieAQFQ2eHdHVC3BjTQQKyelj1IfIFlxee6w8w
         dmupveXeVC57k0FuEt1tN1xEopMYHHX3kS3e23O31H/HgL89HSl6GF4PmyeGJL55kL
         zQwBo7U0eTxEL3hgm8v9WKfT8oNtOXOV+rvk2g0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Zhao <yuzhao@google.com>,
        syzbot+87c490fd2be656269b6a@syzkaller.appspotmail.com,
        Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.4 725/800] mm/mglru: make memcg_lru->lock irq safe
Date:   Sun, 16 Jul 2023 21:49:38 +0200
Message-ID: <20230716195005.958642380@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Zhao <yuzhao@google.com>

commit 814bc1de03ea4361101408e63a68e4b82aef22cb upstream.

lru_gen_rotate_memcg() can happen in softirq if memory.soft_limit_in_bytes
is set.  This requires memcg_lru->lock to be irq safe.  Lockdep warns on
this.

This problem only affects memcg v1.

Link: https://lkml.kernel.org/r/20230619193821.2710944-1-yuzhao@google.com
Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: Yu Zhao <yuzhao@google.com>
Reported-by: syzbot+87c490fd2be656269b6a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=87c490fd2be656269b6a
Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/vmscan.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 5bf98d0a22c9..6114a1fc6c68 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4728,10 +4728,11 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 {
 	int seg;
 	int old, new;
+	unsigned long flags;
 	int bin = get_random_u32_below(MEMCG_NR_BINS);
 	struct pglist_data *pgdat = lruvec_pgdat(lruvec);
 
-	spin_lock(&pgdat->memcg_lru.lock);
+	spin_lock_irqsave(&pgdat->memcg_lru.lock, flags);
 
 	VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
 
@@ -4766,7 +4767,7 @@ static void lru_gen_rotate_memcg(struct lruvec *lruvec, int op)
 	if (!pgdat->memcg_lru.nr_memcgs[old] && old == get_memcg_gen(pgdat->memcg_lru.seq))
 		WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
 
-	spin_unlock(&pgdat->memcg_lru.lock);
+	spin_unlock_irqrestore(&pgdat->memcg_lru.lock, flags);
 }
 
 void lru_gen_online_memcg(struct mem_cgroup *memcg)
@@ -4779,7 +4780,7 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg)
 		struct pglist_data *pgdat = NODE_DATA(nid);
 		struct lruvec *lruvec = get_lruvec(memcg, nid);
 
-		spin_lock(&pgdat->memcg_lru.lock);
+		spin_lock_irq(&pgdat->memcg_lru.lock);
 
 		VM_WARN_ON_ONCE(!hlist_nulls_unhashed(&lruvec->lrugen.list));
 
@@ -4790,7 +4791,7 @@ void lru_gen_online_memcg(struct mem_cgroup *memcg)
 
 		lruvec->lrugen.gen = gen;
 
-		spin_unlock(&pgdat->memcg_lru.lock);
+		spin_unlock_irq(&pgdat->memcg_lru.lock);
 	}
 }
 
@@ -4814,7 +4815,7 @@ void lru_gen_release_memcg(struct mem_cgroup *memcg)
 		struct pglist_data *pgdat = NODE_DATA(nid);
 		struct lruvec *lruvec = get_lruvec(memcg, nid);
 
-		spin_lock(&pgdat->memcg_lru.lock);
+		spin_lock_irq(&pgdat->memcg_lru.lock);
 
 		VM_WARN_ON_ONCE(hlist_nulls_unhashed(&lruvec->lrugen.list));
 
@@ -4826,7 +4827,7 @@ void lru_gen_release_memcg(struct mem_cgroup *memcg)
 		if (!pgdat->memcg_lru.nr_memcgs[gen] && gen == get_memcg_gen(pgdat->memcg_lru.seq))
 			WRITE_ONCE(pgdat->memcg_lru.seq, pgdat->memcg_lru.seq + 1);
 
-		spin_unlock(&pgdat->memcg_lru.lock);
+		spin_unlock_irq(&pgdat->memcg_lru.lock);
 	}
 }
 
-- 
2.41.0




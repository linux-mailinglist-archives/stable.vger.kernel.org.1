Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E82E7AB6C6
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 19:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjIVRBm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 13:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjIVRBi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 13:01:38 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 879C91A2;
        Fri, 22 Sep 2023 10:01:32 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,5.10 15/17] netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails
Date:   Fri, 22 Sep 2023 19:01:16 +0200
Message-Id: <20230922170118.152420-16-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230922170118.152420-1-pablo@netfilter.org>
References: <20230922170118.152420-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 6d365eabce3c018a80f6e0379b17df2abb17405e upstream.

nft_trans_gc_queue_sync() enqueues the GC transaction and it allocates a
new one. If this allocation fails, then stop this GC sync run and retry
later.

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_pipapo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 80440ac5d44c..fbfcc3275cad 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1595,7 +1595,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 
 			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
 			if (!gc)
-				break;
+				return;
 
 			nft_pipapo_gc_deactivate(net, set, e);
 			pipapo_drop(m, rulemap);
-- 
2.30.2


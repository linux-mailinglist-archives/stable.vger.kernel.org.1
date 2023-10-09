Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1C997BE01E
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377209AbjJINhm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377230AbjJINhk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:37:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559319C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:37:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55975C433C9;
        Mon,  9 Oct 2023 13:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858658;
        bh=jD1vH9+3WX+0A+gfjHqu2MB/jqLikYlc+/Ic3v3XpYU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Crpo3QfUrW6w4Y8mSNXxDEDJQWli4VZFHn/8a28gDydnBZTySQdOS4Q71481BWves
         61kgw+ajt5hChqJ69G5zukBR9pY3Psglo+nRU5SzqD7kQbQq+xJvzK49BTICbmUmji
         yxteATUBRlBC5xanUQUYubeuMcUVxsP+dDLvLjVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 032/226] netfilter: nf_tables: fix memleak when more than 255 elements expired
Date:   Mon,  9 Oct 2023 14:59:53 +0200
Message-ID: <20231009130127.615913286@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130126.697995596@linuxfoundation.org>
References: <20231009130126.697995596@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit cf5000a7787cbc10341091d37245a42c119d26c5 upstream.

When more than 255 elements expired we're supposed to switch to a new gc
container structure.

This never happens: u8 type will wrap before reaching the boundary
and nft_trans_gc_space() always returns true.

This means we recycle the initial gc container structure and
lose track of the elements that came before.

While at it, don't deref 'gc' after we've passed it to call_rcu.

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Reported-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h |  2 +-
 net/netfilter/nf_tables_api.c     | 10 ++++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index bbe472c07d07e..5619642b9ad47 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1525,7 +1525,7 @@ struct nft_trans_gc {
 	struct net		*net;
 	struct nft_set		*set;
 	u32			seq;
-	u8			count;
+	u16			count;
 	void			*priv[NFT_TRANS_GC_BATCHCOUNT];
 	struct rcu_head		rcu;
 };
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 9fc302a6836ba..32c97cc87ddc2 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8124,12 +8124,15 @@ static int nft_trans_gc_space(struct nft_trans_gc *trans)
 struct nft_trans_gc *nft_trans_gc_queue_async(struct nft_trans_gc *gc,
 					      unsigned int gc_seq, gfp_t gfp)
 {
+	struct nft_set *set;
+
 	if (nft_trans_gc_space(gc))
 		return gc;
 
+	set = gc->set;
 	nft_trans_gc_queue_work(gc);
 
-	return nft_trans_gc_alloc(gc->set, gc_seq, gfp);
+	return nft_trans_gc_alloc(set, gc_seq, gfp);
 }
 
 void nft_trans_gc_queue_async_done(struct nft_trans_gc *trans)
@@ -8144,15 +8147,18 @@ void nft_trans_gc_queue_async_done(struct nft_trans_gc *trans)
 
 struct nft_trans_gc *nft_trans_gc_queue_sync(struct nft_trans_gc *gc, gfp_t gfp)
 {
+	struct nft_set *set;
+
 	if (WARN_ON_ONCE(!lockdep_commit_lock_is_held(gc->net)))
 		return NULL;
 
 	if (nft_trans_gc_space(gc))
 		return gc;
 
+	set = gc->set;
 	call_rcu(&gc->rcu, nft_trans_gc_trans_free);
 
-	return nft_trans_gc_alloc(gc->set, 0, gfp);
+	return nft_trans_gc_alloc(set, 0, gfp);
 }
 
 void nft_trans_gc_queue_sync_done(struct nft_trans_gc *trans)
-- 
2.40.1




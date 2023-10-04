Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C1C7B8829
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243978AbjJDSNP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243980AbjJDSNO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:13:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B1BC1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:13:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2B8C433C7;
        Wed,  4 Oct 2023 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443191;
        bh=lBV9RxDuqFaHx1HMd8Eow6KsG0fFBXTNANswxJ0eqiQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vH25V0kRMNgtduqA7WYep5tD+9nSExiU30uhGGDd1yz9s7/fEQ8x7iGS1eCU+0V5L
         nI6N7BojJBoaGPQcc7M0Sw0Fz0B+YAH6ikTk3fE9h/TzAaKsOgSe5Wyem5rlaCDP5i
         wrUvL8CB7CFG9HjevyaOIIREHbof0lJNP/Ajay2I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 030/259] netfilter: nf_tables: defer gc run if previous batch is still pending
Date:   Wed,  4 Oct 2023 19:53:23 +0200
Message-ID: <20231004175218.828945356@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 8e51830e29e12670b4c10df070a4ea4c9593e961 upstream.

Don't queue more gc work, else we may queue the same elements multiple
times.

If an element is flagged as dead, this can mean that either the previous
gc request was invalidated/discarded by a transaction or that the previous
request is still pending in the system work queue.

The latter will happen if the gc interval is set to a very low value,
e.g. 1ms, and system work queue is backlogged.

The sets refcount is 1 if no previous gc requeusts are queued, so add
a helper for this and skip gc run if old requests are pending.

Add a helper for this and skip the gc run in this case.

Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h | 5 +++++
 net/netfilter/nft_set_hash.c      | 3 +++
 net/netfilter/nft_set_rbtree.c    | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 2d501dd901521..12777a5b60cd0 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -581,6 +581,11 @@ static inline void *nft_set_priv(const struct nft_set *set)
 	return (void *)set->data;
 }
 
+static inline bool nft_set_gc_is_pending(const struct nft_set *s)
+{
+	return refcount_read(&s->refs) != 1;
+}
+
 static inline struct nft_set *nft_set_container_of(const void *priv)
 {
 	return (void *)priv - offsetof(struct nft_set, data);
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index cef5df8460009..524763659f251 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -326,6 +326,9 @@ static void nft_rhash_gc(struct work_struct *work)
 	nft_net = nft_pernet(net);
 	gc_seq = READ_ONCE(nft_net->gc_seq);
 
+	if (nft_set_gc_is_pending(set))
+		goto done;
+
 	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
 	if (!gc)
 		goto done;
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index f9d4c8fcbbf82..c6435e7092319 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -611,6 +611,9 @@ static void nft_rbtree_gc(struct work_struct *work)
 	nft_net = nft_pernet(net);
 	gc_seq  = READ_ONCE(nft_net->gc_seq);
 
+	if (nft_set_gc_is_pending(set))
+		goto done;
+
 	gc = nft_trans_gc_alloc(set, gc_seq, GFP_KERNEL);
 	if (!gc)
 		goto done;
-- 
2.40.1




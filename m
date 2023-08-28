Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5553378AA61
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjH1KVv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjH1KVX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:21:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7F2CC1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:21:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35EFB638DD
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421F8C433C8;
        Mon, 28 Aug 2023 10:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218043;
        bh=nZbwt/aOincUZqNFixGr3zdZRZFBvUEGPXcbKw/Sq9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfSo6g631TpybFqO4XxGh3Yqz+ktpZJQHAq5lRrjQef0G1nVlDDIbovQvCjTJQs4C
         noty1+hU1BOa8WMc4CmBn9aPqg/cmyC5QyPtj53PBAYXXwW5PE5jThMObcFlKTAgUM
         Lp89k0K2/ohXqI1csDGjnsoCeD1+na20fvlxBLWY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 045/129] netfilter: nf_tables: GC transaction race with abort path
Date:   Mon, 28 Aug 2023 12:12:04 +0200
Message-ID: <20230828101158.866860095@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 720344340fb9be2765bbaab7b292ece0a4570eae ]

Abort path is missing a synchronization point with GC transactions. Add
GC sequence number hence any GC transaction losing race will be
discarded.

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 539bc5d5c12fd..9cd8c14a0faf4 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10348,8 +10348,12 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 			   enum nfnl_abort_action action)
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
-	int ret = __nf_tables_abort(net, action);
+	unsigned int gc_seq;
+	int ret;
 
+	gc_seq = nft_gc_seq_begin(nft_net);
+	ret = __nf_tables_abort(net, action);
+	nft_gc_seq_end(nft_net, gc_seq);
 	mutex_unlock(&nft_net->commit_mutex);
 
 	return ret;
-- 
2.40.1




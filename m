Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0F77BE022
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377230AbjJINhv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377233AbjJINhu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:37:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3829B9
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:37:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF2DC433CA;
        Mon,  9 Oct 2023 13:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858668;
        bh=FE7vC6EVsMKOrG6q7YkR61idSPqFvLWcuoRwoB1fkrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bOT9rRTHu7+ki7QlgtWqyEl75vjdL5cph/xtZw57biwHq2FpMBkTdr5w8Pe37mqoB
         067VhfSiPCXGSOI8O+NOT1oq2Q3okoqYKivJHcF90WemOIGYHyzSRpQyQOWfYeUdM7
         EK49fa/ioS7fJYPeLpixNTLvvZPXLHOQLDWgpe5w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 025/226] netfilter: nf_tables: GC transaction race with abort path
Date:   Mon,  9 Oct 2023 14:59:46 +0200
Message-ID: <20231009130127.410234967@linuxfoundation.org>
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

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 720344340fb9be2765bbaab7b292ece0a4570eae upstream.

Abort path is missing a synchronization point with GC transactions. Add
GC sequence number hence any GC transaction losing race will be
discarded.

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 78bf82f89ecd8..1f67931b86d8e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8844,7 +8844,12 @@ static int nf_tables_abort(struct net *net, struct sk_buff *skb,
 			   enum nfnl_abort_action action)
 {
 	struct nftables_pernet *nft_net = net_generic(net, nf_tables_net_id);
-	int ret = __nf_tables_abort(net, action);
+	unsigned int gc_seq;
+	int ret;
+
+	gc_seq = nft_gc_seq_begin(nft_net);
+	ret = __nf_tables_abort(net, action);
+	nft_gc_seq_end(nft_net, gc_seq);
 
 	mutex_unlock(&nft_net->commit_mutex);
 
-- 
2.40.1




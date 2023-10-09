Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5BF7BDFF0
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377183AbjJINfw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377181AbjJINft (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:35:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D9B94
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:35:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52551C433C8;
        Mon,  9 Oct 2023 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858547;
        bh=tlXX7MiKy7vSom2ATBxwqwbs5MJ47DfiOgcwK0xXn3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aarun1k4xC+UvL+ogw+G9CEFHZWl+gF78JI9A564nF/cOPgPXHdMrl+SdHM5odydx
         ZoRUk08RcIG0SIGGScF9D9bcoTuRM4+4zduuh72jauQ057sDpYDOX/q+U/9uQCymnq
         DjNEJ9hBnFRYNPj51/cOo8mQykArGa6ruxq5Ze8c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 024/226] netfilter: nf_tables: GC transaction race with netns dismantle
Date:   Mon,  9 Oct 2023 14:59:45 +0200
Message-ID: <20231009130127.382282124@linuxfoundation.org>
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

commit 02c6c24402bf1c1e986899c14ba22a10b510916b upstream.

Use maybe_get_net() since GC workqueue might race with netns exit path.

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 43da2f0a52623..78bf82f89ecd8 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8089,9 +8089,14 @@ struct nft_trans_gc *nft_trans_gc_alloc(struct nft_set *set,
 	if (!trans)
 		return NULL;
 
+	trans->net = maybe_get_net(net);
+	if (!trans->net) {
+		kfree(trans);
+		return NULL;
+	}
+
 	refcount_inc(&set->refs);
 	trans->set = set;
-	trans->net = get_net(net);
 	trans->seq = gc_seq;
 
 	return trans;
-- 
2.40.1




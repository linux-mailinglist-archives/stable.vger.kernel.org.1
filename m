Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8907D3123
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjJWLGE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbjJWLGD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:06:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C172D7C
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:06:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F80C433C8;
        Mon, 23 Oct 2023 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059159;
        bh=jzNGlTmoxwcxyoVFuBKe0q0Klc5hk31NYMg8YOSVb6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0c7YshEALBNPas+wHceA1h1Qcib/V+C23avh0yUXYge+w4Q3vinrcw0lW+h2gxmE5
         jbrSyIutZB9+MrMLqeixgo3vlZ77TKwUJKH8DyJ0h8M4WH3ww6Y1DeUSVH5lUbRJa7
         5cTEYgshFCkh8nyALNv4oQ5Kmx5D/wVFoJDVKock=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 6.5 083/241] netfilter: nf_tables: do not refresh timeout when resetting element
Date:   Mon, 23 Oct 2023 12:54:29 +0200
Message-ID: <20231023104835.910201407@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 4c90bba60c26db7dc7df450f748e86440149786e upstream.

The dump and reset command should not refresh the timeout, this command
is intended to allow users to list existing stateful objects and reset
them, element expiration should be refresh via transaction instead with
a specific command to achieve this, otherwise this is entering combo
semantics that will be hard to be undone later (eg. a user asking to
retrieve counters but _not_ requiring to refresh expiration).

Fixes: 079cd633219d ("netfilter: nf_tables: Introduce NFT_MSG_GETSETELEM_RESET")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5553,7 +5553,6 @@ static int nf_tables_fill_setelem(struct
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	unsigned char *b = skb_tail_pointer(skb);
 	struct nlattr *nest;
-	u64 timeout = 0;
 
 	nest = nla_nest_start_noflag(skb, NFTA_LIST_ELEM);
 	if (nest == NULL)
@@ -5589,15 +5588,11 @@ static int nf_tables_fill_setelem(struct
 		         htonl(*nft_set_ext_flags(ext))))
 		goto nla_put_failure;
 
-	if (nft_set_ext_exists(ext, NFT_SET_EXT_TIMEOUT)) {
-		timeout = *nft_set_ext_timeout(ext);
-		if (nla_put_be64(skb, NFTA_SET_ELEM_TIMEOUT,
-				 nf_jiffies64_to_msecs(timeout),
-				 NFTA_SET_ELEM_PAD))
-			goto nla_put_failure;
-	} else if (set->flags & NFT_SET_TIMEOUT) {
-		timeout = READ_ONCE(set->timeout);
-	}
+	if (nft_set_ext_exists(ext, NFT_SET_EXT_TIMEOUT) &&
+	    nla_put_be64(skb, NFTA_SET_ELEM_TIMEOUT,
+			 nf_jiffies64_to_msecs(*nft_set_ext_timeout(ext)),
+			 NFTA_SET_ELEM_PAD))
+		goto nla_put_failure;
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION)) {
 		u64 expires, now = get_jiffies_64();
@@ -5612,9 +5607,6 @@ static int nf_tables_fill_setelem(struct
 				 nf_jiffies64_to_msecs(expires),
 				 NFTA_SET_ELEM_PAD))
 			goto nla_put_failure;
-
-		if (reset)
-			*nft_set_ext_expiration(ext) = now + timeout;
 	}
 
 	if (nft_set_ext_exists(ext, NFT_SET_EXT_USERDATA)) {



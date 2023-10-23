Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538AF7D312E
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjJWLGg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjJWLGe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:06:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB99D6E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:06:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2654C433C8;
        Mon, 23 Oct 2023 11:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059192;
        bh=LBXUVVwXmg8BRdc+F6whbzQPTaU6+5R5txK42q2NO0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wt1UfbMXBg+8JpSGhzTDVHtCzriVzx0sAFXeTo3DygLJi6jpiPVS8oMh6Iay/yRXi
         9XjFgFNYr3jCSxVNB+Ejbha7bcuPUyo4mLg9gyHrskWqKuJmzirrM3PM6YBP99QAcE
         RJJq2YF2U/CtUDKYQFabs0avh3ThJc3kR+m0A5tI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 6.5 087/241] netfilter: nf_tables: revert do not remove elements if set backend implements .abort
Date:   Mon, 23 Oct 2023 12:54:33 +0200
Message-ID: <20231023104836.011436025@linuxfoundation.org>
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

commit f86fb94011aeb3b26337fc22204ca726aeb8bc24 upstream.

nf_tables_abort_release() path calls nft_set_elem_destroy() for
NFT_MSG_NEWSETELEM which releases the element, however, a reference to
the element still remains in the working copy.

Fixes: ebd032fa8818 ("netfilter: nf_tables: do not remove elements if set backend implements .abort")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10336,10 +10336,7 @@ static int __nf_tables_abort(struct net
 				break;
 			}
 			te = (struct nft_trans_elem *)trans->data;
-			if (!te->set->ops->abort ||
-			    nft_setelem_is_catchall(te->set, &te->elem))
-				nft_setelem_remove(net, te->set, &te->elem);
-
+			nft_setelem_remove(net, te->set, &te->elem);
 			if (!nft_setelem_is_catchall(te->set, &te->elem))
 				atomic_dec(&te->set->nelems);
 



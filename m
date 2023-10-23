Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C627B7D3150
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbjJWLIA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbjJWLH7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:07:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E80410EB
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:07:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C5D6C433C9;
        Mon, 23 Oct 2023 11:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059274;
        bh=+5zHCygy55EN3OtOF8NTFleAzbWg0m/KEJk0GTYV228=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5Qbccl+Tb/0RZzVhcSqvSl7Xqt1DmeuUgusvxjcYQ2UN6pnsCtC97Y2jqWM0hgc7
         lHHOK9SCShxUa/NT+CHQ5qSB5AIaYKlfh1xaTgnD+RXn61GOK58oGsd5S9aJSSi2qm
         uOxvv+OMPGdoCvp2RDpBMTZ/MsYXi1YjkYTNi+0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 6.5 086/241] netfilter: nf_tables: do not remove elements if set backend implements .abort
Date:   Mon, 23 Oct 2023 12:54:32 +0200
Message-ID: <20231023104835.984142674@linuxfoundation.org>
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

commit ebd032fa881882fef2acb9da1bbde48d8233241d upstream.

pipapo set backend maintains two copies of the datastructure, removing
the elements from the copy that is going to be discarded slows down
the abort path significantly, from several minutes to few seconds after
this patch.

Fixes: 212ed75dc5fb ("netfilter: nf_tables: integrate pipapo into commit protocol")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -10336,7 +10336,10 @@ static int __nf_tables_abort(struct net
 				break;
 			}
 			te = (struct nft_trans_elem *)trans->data;
-			nft_setelem_remove(net, te->set, &te->elem);
+			if (!te->set->ops->abort ||
+			    nft_setelem_is_catchall(te->set, &te->elem))
+				nft_setelem_remove(net, te->set, &te->elem);
+
 			if (!nft_setelem_is_catchall(te->set, &te->elem))
 				atomic_dec(&te->set->nelems);
 



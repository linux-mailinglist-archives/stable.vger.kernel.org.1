Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CBC78AA9D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:24:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbjH1KXu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjH1KXS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:23:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E91383
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:23:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CBD66398F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:23:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADF8C433C7;
        Mon, 28 Aug 2023 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218195;
        bh=5iuDqNTnHT5DY3eJJuK3QSmTGimvOpnvfqezHYKQAyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TDUPFCA/pDzU4vHKuF+FvswSYiKSIk14ESjVM4Ixhy0hGZ1InBnuGkYul5XgmKODM
         X4RRZE9CrKTVHvnGOTfcPU7YUD5OZdHAIfaGuL7469Bfkcpu1aC4ADK1yF9fAnUFiw
         gLqkFwqAssK+pZHf75doJ/SJkOJrwZScozGNKwTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 6.4 129/129] netfilter: nf_tables: fix kdoc warnings after gc rework
Date:   Mon, 28 Aug 2023 12:13:28 +0200
Message-ID: <20230828101201.789209041@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 08713cb006b6f07434f276c5ee214fb20c7fd965 upstream.

Jakub Kicinski says:
  We've got some new kdoc warnings here:
  net/netfilter/nft_set_pipapo.c:1557: warning: Function parameter or member '_set' not described in 'pipapo_gc'
  net/netfilter/nft_set_pipapo.c:1557: warning: Excess function parameter 'set' description in 'pipapo_gc'
  include/net/netfilter/nf_tables.h:577: warning: Function parameter or member 'dead' not described in 'nft_set'

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Fixes: f6c383b8c31a ("netfilter: nf_tables: adapt set backend to use GC transaction API")
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20230810104638.746e46f1@kernel.org/
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/netfilter/nf_tables.h |    1 +
 net/netfilter/nft_set_pipapo.c    |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -534,6 +534,7 @@ struct nft_set_elem_expr {
  *	@expr: stateful expression
  * 	@ops: set ops
  * 	@flags: set flags
+ *	@dead: set will be freed, never cleared
  *	@genmask: generation mask
  * 	@klen: key length
  * 	@dlen: data length
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1550,7 +1550,7 @@ static void nft_pipapo_gc_deactivate(str
 
 /**
  * pipapo_gc() - Drop expired entries from set, destroy start and end elements
- * @set:	nftables API set representation
+ * @_set:	nftables API set representation
  * @m:		Matching data
  */
 static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)



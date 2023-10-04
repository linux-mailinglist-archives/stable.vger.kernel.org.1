Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E286E7B87DF
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243910AbjJDSKV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243907AbjJDSKU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:10:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000109E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:10:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444D7C433C7;
        Wed,  4 Oct 2023 18:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443017;
        bh=iPyd+QGTst2Bp04nDqw0saU9WFtnNZTnH9InVLDmYDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o1SRJ0XJPBKkEYTu3d2kBO2WC0QhZdAEgap7uYKB+SP004yTdZXhtUCcYGkqhHbCY
         tcdDyYc8yMwcs/WJgK75XZiSbRZVBdAkMCyNVf0AefaYB9rQsKLd4NAKMsGpJbxbht
         0ON18s4vFT2mZPUoGAiOyT9xqm5YMVmRNmHxSzc0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH 5.15 183/183] netfilter: nf_tables: fix kdoc warnings after gc rework
Date:   Wed,  4 Oct 2023 19:56:54 +0200
Message-ID: <20231004175211.764403224@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -499,6 +499,7 @@ struct nft_set_elem_expr {
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



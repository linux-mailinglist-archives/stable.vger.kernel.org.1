Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2707B8928
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244127AbjJDSXP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244124AbjJDSXP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:23:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2030A9E
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:23:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573D7C433C7;
        Wed,  4 Oct 2023 18:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443791;
        bh=B85bpRZbEI5QQ67+0pCy4xqACp0vsUVYBNDgW0+uQNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZcrrgmTWl59QbACc3Ff/bcfXob7G7gK8T0BlZExap/g3/4MWviVie4iaH3cWxwLS
         uay2JvvELIJYNk1UTK/UpoKaww62a/zk5ciEoVWtIqWWbjQe55cKFPreCsgB3XlIAy
         v+iqUXNf9Ool7ZIogD7kE2WFF08DzETlsmT/NoEY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 021/321] netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails
Date:   Wed,  4 Oct 2023 19:52:46 +0200
Message-ID: <20231004175230.161496017@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 6d365eabce3c018a80f6e0379b17df2abb17405e upstream.

nft_trans_gc_queue_sync() enqueues the GC transaction and it allocates a
new one. If this allocation fails, then stop this GC sync run and retry
later.

Fixes: 5f68718b34a5 ("netfilter: nf_tables: GC transaction API to avoid race with control plane")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 10b89ac74476b..c0dcc40de358f 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1596,7 +1596,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 
 			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
 			if (!gc)
-				break;
+				return;
 
 			nft_pipapo_gc_deactivate(net, set, e);
 			pipapo_drop(m, rulemap);
-- 
2.40.1




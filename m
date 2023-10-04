Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C627B8755
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243772AbjJDSEJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243767AbjJDSEI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:04:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6946FAD
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:04:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D6FC433C7;
        Wed,  4 Oct 2023 18:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442644;
        bh=1ZbhbPBTAN9bPboNHx0v9QXD5RhbT+Z5gkARVaZyikI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/x8diaFg2Q05ukuaJlqZu6BIEjXmoPpsqS100ymgmjxLMh6qTYtgMWWXy8SNHsKf
         ktWGvgx6E/7NtvcoE8q/2T9GcNz4HXtQq/GGzenQplYZS78ppQxlWN0jD/vfjKFmav
         ZEP9cgzop42y2HmznYtET2Ya02ajby3MNt71SLDs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 031/183] netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails
Date:   Wed,  4 Oct 2023 19:54:22 +0200
Message-ID: <20231004175205.264938759@linuxfoundation.org>
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
index 7248a1737ee14..83f5f276c3bff 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1597,7 +1597,7 @@ static void pipapo_gc(const struct nft_set *_set, struct nft_pipapo_match *m)
 
 			gc = nft_trans_gc_queue_sync(gc, GFP_ATOMIC);
 			if (!gc)
-				break;
+				return;
 
 			nft_pipapo_gc_deactivate(net, set, e);
 			pipapo_drop(m, rulemap);
-- 
2.40.1




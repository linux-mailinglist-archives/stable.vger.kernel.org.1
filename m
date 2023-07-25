Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5E7761257
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjGYLBU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjGYLBB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:01:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CDE44BB
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:58:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA93161654
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA7FC433C7;
        Tue, 25 Jul 2023 10:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282709;
        bh=LkSgrYh9qg9+9mxTG4LBWEYyqSZlpQBzShWSlZ/9Br8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lslUgGoVB90tyT2atTbdkBy+WBFm2LAIquln+WJK6jUYc0muzCPA4R8Sb62Qk5Z6z
         Ul66aFzdozIKJtOjCoBUbnGZ186H4jvW0uostyh5cSkNXnyFbG8+hioamHR8UrOZYp
         hSAWaBTYz3JanE3qQh1KoWcPM3mgQr7ND/hSaKWc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, lonial con <kongln9170@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 197/227] netfilter: nft_set_pipapo: fix improper element removal
Date:   Tue, 25 Jul 2023 12:46:04 +0200
Message-ID: <20230725104522.959524918@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 87b5a5c209405cb6b57424cdfa226a6dbd349232 ]

end key should be equal to start unless NFT_SET_EXT_KEY_END is present.

Its possible to add elements that only have a start key
("{ 1.0.0.0 . 2.0.0.0 }") without an internval end.

Insertion treats this via:

if (nft_set_ext_exists(ext, NFT_SET_EXT_KEY_END))
   end = (const u8 *)nft_set_ext_key_end(ext)->data;
else
   end = start;

but removal side always uses nft_set_ext_key_end().
This is wrong and leads to garbage remaining in the set after removal
next lookup/insert attempt will give:

BUG: KASAN: slab-use-after-free in pipapo_get+0x8eb/0xb90
Read of size 1 at addr ffff888100d50586 by task nft-pipapo_uaf_/1399
Call Trace:
 kasan_report+0x105/0x140
 pipapo_get+0x8eb/0xb90
 nft_pipapo_insert+0x1dc/0x1710
 nf_tables_newsetelem+0x31f5/0x4e00
 ..

Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Reported-by: lonial con <kongln9170@gmail.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_set_pipapo.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 0452ee586c1cc..a81829c10feab 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1930,7 +1930,11 @@ static void nft_pipapo_remove(const struct net *net, const struct nft_set *set,
 		int i, start, rules_fx;
 
 		match_start = data;
-		match_end = (const u8 *)nft_set_ext_key_end(&e->ext)->data;
+
+		if (nft_set_ext_exists(&e->ext, NFT_SET_EXT_KEY_END))
+			match_end = (const u8 *)nft_set_ext_key_end(&e->ext)->data;
+		else
+			match_end = data;
 
 		start = first_rule;
 		rules_fx = rules_f0;
-- 
2.39.2




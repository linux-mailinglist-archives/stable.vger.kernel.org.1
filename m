Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE67BE09A
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376894AbjJINl5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377377AbjJINl4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:41:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D22B9
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:41:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD91FC433C7;
        Mon,  9 Oct 2023 13:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696858915;
        bh=665OEBUA/BcYOyHKOt70jFidWhLO4oA80Vhp4ZWwKXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ju5CEkDtXjIRFeBC0H0O0RV+CFdwhxz9hb/mdnkt1mpX8mSl8M+9E2C9jPB04AM9E
         eoZEaHOajQ+PWuF9BkXmmQGAyQ+5WSKsbiqYNBEjF/G8uNRW44FUljIhHQboMDWxc1
         CswUxb1StCbJ2n/c7QXc43ccrfrfUaH7l3z4RDRM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 140/226] netfilter: nft_exthdr: Fix for unsafe packet data read
Date:   Mon,  9 Oct 2023 15:01:41 +0200
Message-ID: <20231009130130.396884966@linuxfoundation.org>
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

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit cf6b5ffdce5a78b2fcb0e53b3a2487c490bcbf7f ]

While iterating through an SCTP packet's chunks, skb_header_pointer() is
called for the minimum expected chunk header size. If (that part of) the
skbuff is non-linear, the following memcpy() may read data past
temporary buffer '_sch'. Use skb_copy_bits() instead which does the
right thing in this situation.

Fixes: 133dc203d77df ("netfilter: nft_exthdr: Support SCTP chunks")
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Phil Sutter <phil@nwl.cc>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_exthdr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_exthdr.c b/net/netfilter/nft_exthdr.c
index 274c5f0085186..eb183c024ac46 100644
--- a/net/netfilter/nft_exthdr.c
+++ b/net/netfilter/nft_exthdr.c
@@ -389,7 +389,9 @@ static void nft_exthdr_sctp_eval(const struct nft_expr *expr,
 				break;
 
 			dest[priv->len / NFT_REG32_SIZE] = 0;
-			memcpy(dest, (char *)sch + priv->offset, priv->len);
+			if (skb_copy_bits(pkt->skb, offset + priv->offset,
+					  dest, priv->len) < 0)
+				break;
 			return;
 		}
 		offset += SCTP_PAD4(ntohs(sch->length));
-- 
2.40.1




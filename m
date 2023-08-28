Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE678AE1B
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbjH1K1m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbjH1K10 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:27:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DDD83
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:27:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 226B36159D
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:27:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D05C433C7;
        Mon, 28 Aug 2023 10:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218443;
        bh=4gEbeYjtQqYd/I6svyD66CtG8q1QCmMK/foexXFV1Pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ddu72Kz38PKGLutYyVP99ULPZ9UX1m9l2q06Y0/NRCeBynfDJAPVbQjn6cIdhgXu2
         xxYeDvPYHQaqQp2fQU35SaScjSKIePD5cye4OqDyTz/rF7kH+tBkk9rSiYgUGQbZsQ
         vpgWxUgyc3tgTXF0IoGzzwlU/G0C1rPxwM9ZF54I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 060/129] netfilter: nft_dynset: disallow object maps
Date:   Mon, 28 Aug 2023 12:12:34 +0200
Message-ID: <20230828101155.507506762@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101153.030066927@linuxfoundation.org>
References: <20230828101153.030066927@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 23185c6aed1ffb8fc44087880ba2767aba493779 ]

Do not allow to insert elements from datapath to objects maps.

Fixes: 8aeff920dcc9 ("netfilter: nf_tables: add stateful object reference to set elements")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_dynset.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nft_dynset.c b/net/netfilter/nft_dynset.c
index 651c9784904cb..a4c6aba7da7ee 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -144,6 +144,9 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
+	if (set->flags & NFT_SET_OBJECT)
+		return -EOPNOTSUPP;
+
 	if (set->ops->update == NULL)
 		return -EOPNOTSUPP;
 
-- 
2.40.1




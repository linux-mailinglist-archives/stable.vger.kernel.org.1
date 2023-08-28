Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC1F78AC6D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjH1Kj5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbjH1Kje (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:39:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218A693
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:39:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3E2A63FFD
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:39:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6595C433C7;
        Mon, 28 Aug 2023 10:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219171;
        bh=b1HJmHLCLyLmEcDuD1lisB81DaKhNhXjNuE4AIIZ9RQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3xPnA2buG4+eUKuhtbJJeUJeL8GyUWKwnvdAwM2Q2kBJ0vF2YKfqv16x1gMr54c+
         t0iwLG2weW1NMGlbt4hNHFjOOZcCSCG4P9XChT3Yt/0w2Qd2U0io2ZLvdBCRPLjmrZ
         C6UOMKVNl5hFXkuaKpNq1x14kk7z1aN4gO/+Gkeo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 069/158] netfilter: nft_dynset: disallow object maps
Date:   Mon, 28 Aug 2023 12:12:46 +0200
Message-ID: <20230828101159.613744769@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.322319621@linuxfoundation.org>
References: <20230828101157.322319621@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
index 8aca2fdc0664c..e0c17217817d6 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -161,6 +161,9 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
+	if (set->flags & NFT_SET_OBJECT)
+		return -EOPNOTSUPP;
+
 	if (set->ops->update == NULL)
 		return -EOPNOTSUPP;
 
-- 
2.40.1




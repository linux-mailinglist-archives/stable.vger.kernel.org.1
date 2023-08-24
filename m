Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6808F787355
	for <lists+stable@lfdr.de>; Thu, 24 Aug 2023 17:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjHXPCi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 24 Aug 2023 11:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241990AbjHXPCF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 Aug 2023 11:02:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0335C7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 08:02:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3611F615C7
        for <stable@vger.kernel.org>; Thu, 24 Aug 2023 15:02:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4769FC433C7;
        Thu, 24 Aug 2023 15:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692889322;
        bh=57BYAYpP67zZgwZuJq+N/Bg4Q+oVZn/lPyygmX908Fc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9hXvUJXoIpSGLnpcHZOBGe4N6F7ZbTiqsU2To6NP5a2wDtz4hgco1qs6RH4gcGG3
         GZxnV3Jvbg3fX/wAtvyRgH2BH1z3i78YzSaBMv/VsTmB6dnHcDObqM2XgMYXJtSM0o
         eSyxQnXoO+VbNVrbDPprZTq1BZT1uWpMBg32aZHU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 087/135] netfilter: nft_dynset: disallow object maps
Date:   Thu, 24 Aug 2023 16:50:30 +0200
Message-ID: <20230824145030.667135217@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230824145027.008282920@linuxfoundation.org>
References: <20230824145027.008282920@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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
index 8d47782b778f1..408b7f5faa5e5 100644
--- a/net/netfilter/nft_dynset.c
+++ b/net/netfilter/nft_dynset.c
@@ -138,6 +138,9 @@ static int nft_dynset_init(const struct nft_ctx *ctx,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
+	if (set->flags & NFT_SET_OBJECT)
+		return -EOPNOTSUPP;
+
 	if (set->ops->update == NULL)
 		return -EOPNOTSUPP;
 
-- 
2.40.1




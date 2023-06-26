Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D3573E869
	for <lists+stable@lfdr.de>; Mon, 26 Jun 2023 20:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjFZSZe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 26 Jun 2023 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjFZSZR (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Jun 2023 14:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862482974
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 11:24:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F7FF60F4D
        for <stable@vger.kernel.org>; Mon, 26 Jun 2023 18:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97BAC433C9;
        Mon, 26 Jun 2023 18:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687803839;
        bh=wNkBY1az243WiHCcVzdWlQDF8CSoO1SrrEccfHheBdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SrPY1+VBELGgzPqEkP3hgtIxVZHE17HjYecSOH+5bxozbfMvKBR3QZPRHDLHJhqWl
         iPhPHH224oX8btvGtjaZrCjAV4gEOQo3dYkdQL48oOM60OkxbeaOp5c0yHQaGhcxZU
         OujFvNxQwGpSoDIza7wd77oAdcnLDHYVefreH5Gs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 6.3 195/199] netfilter: nf_tables: drop module reference after updating chain
Date:   Mon, 26 Jun 2023 20:11:41 +0200
Message-ID: <20230626180814.298714943@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230626180805.643662628@linuxfoundation.org>
References: <20230626180805.643662628@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 043d2acf57227db1fdaaa620b2a420acfaa56d6e upstream.

Otherwise the module reference counter is leaked.

Fixes b9703ed44ffb ("netfilter: nf_tables: support for adding new devices to an existing netdev chain")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2664,6 +2664,8 @@ static int nf_tables_updchain(struct nft
 	nft_trans_basechain(trans) = basechain;
 	INIT_LIST_HEAD(&nft_trans_chain_hooks(trans));
 	list_splice(&hook.list, &nft_trans_chain_hooks(trans));
+	if (nla[NFTA_CHAIN_HOOK])
+		module_put(hook.type->owner);
 
 	nft_trans_commit_list_add_tail(ctx->net, trans);
 



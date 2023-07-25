Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3067616E4
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjGYLn6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbjGYLn1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:43:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7211BD3;
        Tue, 25 Jul 2023 04:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30F1F616C6;
        Tue, 25 Jul 2023 11:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DEDC433C9;
        Tue, 25 Jul 2023 11:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285378;
        bh=orvMq+3ovVJb9nuqvoR+waSdokmCN1kN7ufeVzHkP84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sa04vwMIu3HIPROSBtpORlU55WKSw//VOSUSpp6hhoHC92hh7d+obs/hXc5CBQZJ2
         WcJHSgKJpNC1XWtVLw82+2G+B0OQOJq2IFqo7SgdY1Z6iui1KdzRAW7jebSL9powvj
         RpF2Q/6gB4nrIPTKN6+3d/NC+5tshgHmuKzduo8U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 5.4 183/313] netfilter: nf_tables: add rescheduling points during loop detection walks
Date:   Tue, 25 Jul 2023 12:45:36 +0200
Message-ID: <20230725104528.878520702@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
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

[ 81ea010667417ef3f218dfd99b69769fe66c2b67 ]

Add explicit rescheduling points during ruleset walk.

Switching to a faster algorithm is possible but this is a much
smaller change, suitable for nf tree.

Link: https://bugzilla.netfilter.org/show_bug.cgi?id=1460
Signed-off-by: Florian Westphal <fw@strlen.de>
Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -2712,6 +2712,8 @@ int nft_chain_validate(const struct nft_
 			if (err < 0)
 				return err;
 		}
+
+		cond_resched();
 	}
 
 	return 0;
@@ -7379,9 +7381,13 @@ static int nf_tables_check_loops(const s
 				break;
 			}
 		}
+
+		cond_resched();
 	}
 
 	list_for_each_entry(set, &ctx->table->sets, list) {
+		cond_resched();
+
 		if (!nft_is_active_next(ctx->net, set))
 			continue;
 		if (!(set->flags & NFT_SET_MAP) ||



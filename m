Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752E175572E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjGPU6H (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbjGPU6C (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:58:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CFDE45
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2BF360DD4
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24DAC433C8;
        Sun, 16 Jul 2023 20:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689541078;
        bh=KpNJLcewzjdojO8anYjx4+4cQCwSfQ/qWBl7wNU9IvE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I62hflGEMnHHyYj6qzQjGCKieNiFJyM1b6YCU0g4bQyzCdQD6rsdjv4GuX74ZXqFG
         hSFJylnhIji8kpDFV2jNCg2zO7wwYSKkHGH6J7EFVaena54VOwoKExcuTtTmSrk0K+
         l8enw48d/mmFitPQID70/DgYbAOaeGVjC3kkwenY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 6.1 581/591] netfilter: nf_tables: unbind non-anonymous set if rule construction fails
Date:   Sun, 16 Jul 2023 21:52:00 +0200
Message-ID: <20230716194938.888869023@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 3e70489721b6c870252c9082c496703677240f53 upstream.

Otherwise a dangling reference to a rule object that is gone remains
in the set binding list.

Fixes: 26b5a5712eb8 ("netfilter: nf_tables: add NFT_TRANS_PREPARE_ERROR to deal with bound set/chain")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5139,6 +5139,8 @@ void nf_tables_deactivate_set(const stru
 		nft_set_trans_unbind(ctx, set);
 		if (nft_set_is_anonymous(set))
 			nft_deactivate_next(ctx->net, set);
+		else
+			list_del_rcu(&binding->list);
 
 		set->use--;
 		break;



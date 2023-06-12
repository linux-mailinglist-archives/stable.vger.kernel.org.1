Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8718D72C1CA
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbjFLLAp (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236972AbjFLLAU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:00:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D29B025A31
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4196F6147C
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590EEC433EF;
        Mon, 12 Jun 2023 10:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566824;
        bh=4OOyBHjU/8yCIJRyUNPLnZyy0CTpJxNaf7Yi/zNAzeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iPAkfbL2MjlRCHCES7527ScquG8fcB0bFIABmatMg9VJ+KyndizgZyQoXWF7LDhnj
         fEGxyLQYSC8ncZK1BaDCtB0BPAFmNwzkm3W62CSt8sLq4qjq8jkEIOp3/XoZK/ckUi
         RngOviPpSqbgVkB/Sxan5BrI0P1x6v7Nt/Q+lCP0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 045/160] netfilter: nf_tables: out-of-bound check in chain blob
Date:   Mon, 12 Jun 2023 12:26:17 +0200
Message-ID: <20230612101717.101433202@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
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

[ Upstream commit 08e42a0d3ad30f276f9597b591f975971a1b0fcf ]

Add current size of rule expressions to the boundary check.

Fixes: 2c865a8a28a1 ("netfilter: nf_tables: add rule blob layout")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8c74bb1ca78a0..368aeabd8f8f1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8921,7 +8921,7 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 				continue;
 			}
 
-			if (WARN_ON_ONCE(data + expr->ops->size > data_boundary))
+			if (WARN_ON_ONCE(data + size + expr->ops->size > data_boundary))
 				return -ENOMEM;
 
 			memcpy(data + size, expr, expr->ops->size);
-- 
2.39.2




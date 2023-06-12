Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D144072C17F
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237107AbjFLK6x (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236292AbjFLKyi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:54:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B1D10A
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:40:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97A6F612E8
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:40:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77EFC433EF;
        Mon, 12 Jun 2023 10:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566454;
        bh=c985z30WrxbrhtjCT9lMW2cNMyjQ2xp5BOkbSsofjMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BrMTIxlBsUucqjt7vLCcjhAGFRwcHr8k3wnUhqGFq2E9UK8Ftpyvvvi9Z4xk/0yXZ
         r0wE+BAv23f+YEFbF985nnnn35DRA3SUNdd5ciajo0bdicfjUqK8zMxXNb80mp/D+P
         Jgac1K1gOp0pPu47m+iU4aXwUUVsVwgiMWU8JHOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 038/132] netfilter: nf_tables: out-of-bound check in chain blob
Date:   Mon, 12 Jun 2023 12:26:12 +0200
Message-ID: <20230612101711.968261170@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101710.279705932@linuxfoundation.org>
References: <20230612101710.279705932@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 31775d54f4b40..437891cb8c417 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8723,7 +8723,7 @@ static int nf_tables_commit_chain_prepare(struct net *net, struct nft_chain *cha
 				continue;
 			}
 
-			if (WARN_ON_ONCE(data + expr->ops->size > data_boundary))
+			if (WARN_ON_ONCE(data + size + expr->ops->size > data_boundary))
 				return -ENOMEM;
 
 			memcpy(data + size, expr, expr->ops->size);
-- 
2.39.2




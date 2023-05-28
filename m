Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26F5713C85
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjE1TPx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjE1TPv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:15:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54E0D8
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:15:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC476199D
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:15:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E2CDC4339C;
        Sun, 28 May 2023 19:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301349;
        bh=PKRZpl7fzCqWuiYsLexm06CPBRvp83F2I25Pzjtu+Rg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rILlWoD5XleQMrJcN6x00PnC7OTQxJcLf5v3crmHu4DoHSqSFWwFrM6M5MW3qWltE
         OnZXkglmc7OBIkTE6dLScU8TURaesKVZGmV+oiML9OBSHC3+kNjZjvtjhQ9GPPKFoq
         M65M42SofqxFxCXxr28byMZRAo/OvNgVnuqw7OA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Laura Garcia <nevola@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 54/86] netfilter: nf_tables: bogus EBUSY in helper removal from transaction
Date:   Sun, 28 May 2023 20:10:28 +0100
Message-Id: <20230528190830.600171765@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.564682883@linuxfoundation.org>
References: <20230528190828.564682883@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

commit 8ffcd32f64633926163cdd07a7d295c500a947d1 upstream.

Proper use counter updates when activating and deactivating the object,
otherwise, this hits bogus EBUSY error.

Fixes: cd5125d8f518 ("netfilter: nf_tables: split set destruction in deactivate and destroy phase")
Reported-by: Laura Garcia <nevola@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nft_objref.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

--- a/net/netfilter/nft_objref.c
+++ b/net/netfilter/nft_objref.c
@@ -64,21 +64,34 @@ nla_put_failure:
 	return -1;
 }
 
-static void nft_objref_destroy(const struct nft_ctx *ctx,
-			       const struct nft_expr *expr)
+static void nft_objref_deactivate(const struct nft_ctx *ctx,
+				  const struct nft_expr *expr,
+				  enum nft_trans_phase phase)
 {
 	struct nft_object *obj = nft_objref_priv(expr);
 
+	if (phase == NFT_TRANS_COMMIT)
+		return;
+
 	obj->use--;
 }
 
+static void nft_objref_activate(const struct nft_ctx *ctx,
+				const struct nft_expr *expr)
+{
+	struct nft_object *obj = nft_objref_priv(expr);
+
+	obj->use++;
+}
+
 static struct nft_expr_type nft_objref_type;
 static const struct nft_expr_ops nft_objref_ops = {
 	.type		= &nft_objref_type,
 	.size		= NFT_EXPR_SIZE(sizeof(struct nft_object *)),
 	.eval		= nft_objref_eval,
 	.init		= nft_objref_init,
-	.destroy	= nft_objref_destroy,
+	.activate	= nft_objref_activate,
+	.deactivate	= nft_objref_deactivate,
 	.dump		= nft_objref_dump,
 };
 



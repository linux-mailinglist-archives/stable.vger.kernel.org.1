Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0D7775D43
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbjHILf3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbjHILf2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:35:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A830F173A
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F3E0634E3
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500ECC433C7;
        Wed,  9 Aug 2023 11:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580926;
        bh=2mZlbLAVD93nf+7an2Iq42iwijLxRuU4FTlpsPyEBwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d55J0qv6h7tL+8SYYZpSXrBv3US8cET3JO1vfT80SymdeeUrGuTNfZiNIKHI+XnSj
         lqU3QtASli/Lc6aYja4lOaknFklYaxVRsDMeSxniM/p90snqadtOpmiLLnBww3IF5n
         S1a2EnVPPwU95hSxSe8iIfmd+dRkwTu1gEfvvFzI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 043/201] netfilter: nftables: add helper function to validate set element data
Date:   Wed,  9 Aug 2023 12:40:45 +0200
Message-ID: <20230809103645.288315462@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit 97c976d662fb9080a6a5d1e1a108c7a1f5c9484d ]

When binding sets to rule, validate set element data according to
set definition. This patch adds a helper function to be reused by
the catch-all set element support.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 0a771f7b266b ("netfilter: nf_tables: skip immediate deactivate in _PREPARE_ERROR")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_tables_api.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 356416564d9f4..5ef9acba7c171 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4576,10 +4576,9 @@ static int nft_validate_register_store(const struct nft_ctx *ctx,
 				       enum nft_data_types type,
 				       unsigned int len);
 
-static int nf_tables_bind_check_setelem(const struct nft_ctx *ctx,
-					struct nft_set *set,
-					const struct nft_set_iter *iter,
-					struct nft_set_elem *elem)
+static int nft_setelem_data_validate(const struct nft_ctx *ctx,
+				     struct nft_set *set,
+				     struct nft_set_elem *elem)
 {
 	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem->priv);
 	enum nft_registers dreg;
@@ -4591,6 +4590,14 @@ static int nf_tables_bind_check_setelem(const struct nft_ctx *ctx,
 					   set->dlen);
 }
 
+static int nf_tables_bind_check_setelem(const struct nft_ctx *ctx,
+					struct nft_set *set,
+					const struct nft_set_iter *iter,
+					struct nft_set_elem *elem)
+{
+	return nft_setelem_data_validate(ctx, set, elem);
+}
+
 int nf_tables_bind_set(const struct nft_ctx *ctx, struct nft_set *set,
 		       struct nft_set_binding *binding)
 {
-- 
2.39.2




Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2394713548
	for <lists+stable@lfdr.de>; Sat, 27 May 2023 17:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbjE0PIG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 27 May 2023 11:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbjE0PIF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 27 May 2023 11:08:05 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18718E4;
        Sat, 27 May 2023 08:08:04 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, stable@vger.kernel.org,
        sashal@kernel.org
Subject: [PATCH -stable,4.14 04/11] netfilter: nf_tables: validate registers coming from userspace.
Date:   Sat, 27 May 2023 18:08:04 +0200
Message-Id: <20230527160811.67779-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230527160811.67779-1-pablo@netfilter.org>
References: <20230527160811.67779-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ 6e1acfa387b9ff82cfc7db8cc3b6959221a95851 ]

Bail out in case userspace uses unsupported registers.

Fixes: 49499c3e6e18 ("netfilter: nf_tables: switch registers to 32 bit addressing")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 95ca28a732c7..404e0484ddd0 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5615,26 +5615,23 @@ int nft_parse_u32_check(const struct nlattr *attr, int max, u32 *dest)
 }
 EXPORT_SYMBOL_GPL(nft_parse_u32_check);
 
-/**
- *	nft_parse_register - parse a register value from a netlink attribute
- *
- *	@attr: netlink attribute
- *
- *	Parse and translate a register value from a netlink attribute.
- *	Registers used to be 128 bit wide, these register numbers will be
- *	mapped to the corresponding 32 bit register numbers.
- */
-static unsigned int nft_parse_register(const struct nlattr *attr)
+static int nft_parse_register(const struct nlattr *attr, u32 *preg)
 {
 	unsigned int reg;
 
 	reg = ntohl(nla_get_be32(attr));
 	switch (reg) {
 	case NFT_REG_VERDICT...NFT_REG_4:
-		return reg * NFT_REG_SIZE / NFT_REG32_SIZE;
+		*preg = reg * NFT_REG_SIZE / NFT_REG32_SIZE;
+		break;
+	case NFT_REG32_00...NFT_REG32_15:
+		*preg = reg + NFT_REG_SIZE / NFT_REG32_SIZE - NFT_REG32_00;
+		break;
 	default:
-		return reg + NFT_REG_SIZE / NFT_REG32_SIZE - NFT_REG32_00;
+		return -ERANGE;
 	}
+
+	return 0;
 }
 
 /**
@@ -5685,7 +5682,10 @@ int nft_parse_register_load(const struct nlattr *attr, u8 *sreg, u32 len)
 	u32 reg;
 	int err;
 
-	reg = nft_parse_register(attr);
+	err = nft_parse_register(attr, &reg);
+	if (err < 0)
+		return err;
+
 	err = nft_validate_register_load(reg, len);
 	if (err < 0)
 		return err;
@@ -5761,7 +5761,10 @@ int nft_parse_register_store(const struct nft_ctx *ctx,
 	int err;
 	u32 reg;
 
-	reg = nft_parse_register(attr);
+	err = nft_parse_register(attr, &reg);
+	if (err < 0)
+		return err;
+
 	err = nft_validate_register_store(ctx, reg, data, type, len);
 	if (err < 0)
 		return err;
-- 
2.30.2


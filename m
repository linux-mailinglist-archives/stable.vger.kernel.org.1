Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E6C713C6A
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:15:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjE1TPG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjE1TPF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:15:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D4A0;
        Sun, 28 May 2023 12:15:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6A9D61977;
        Sun, 28 May 2023 19:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9BCC433EF;
        Sun, 28 May 2023 19:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301303;
        bh=z+Ge17M51H/18sEhYh+TODqfeF9sGApLYzIF61fME2I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlWUrMDsPc+ctvEgy3LXs/TXjOFdacp9+L4/chXk9IySXR+gaAT7N+njL0XyJqz9V
         71yBdG1zqtwj8sJoWkAOvPYqmT53U5ppVb7+3raC2rnJLM6FiUMrdp0TOykS3Wu7Yn
         /yMWwCQfh2j9X8MB2Cjgdl2NiR3mDwJVpoF3Kcxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, netfilter-devel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 63/86] netfilter: nf_tables: validate registers coming from userspace.
Date:   Sun, 28 May 2023 20:10:37 +0100
Message-Id: <20230528190830.961163230@linuxfoundation.org>
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

[ 6e1acfa387b9ff82cfc7db8cc3b6959221a95851 ]

Bail out in case userspace uses unsupported registers.

Fixes: 49499c3e6e18 ("netfilter: nf_tables: switch registers to 32 bit addressing")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/netfilter/nf_tables_api.c |   31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -5615,26 +5615,23 @@ int nft_parse_u32_check(const struct nla
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
@@ -5685,7 +5682,10 @@ int nft_parse_register_load(const struct
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
@@ -5761,7 +5761,10 @@ int nft_parse_register_store(const struc
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



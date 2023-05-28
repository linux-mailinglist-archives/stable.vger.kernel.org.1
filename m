Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD62713CDD
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbjE1TTY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjE1TTX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:19:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450BFA6
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D765861A9F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006DCC433EF;
        Sun, 28 May 2023 19:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301561;
        bh=jlN6EPVbDFBOsjOsiq2g/tfa6vObHBY5rDBHnEZh4Ps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EHb7/jl5aSH5wyKqr/ydPRWvz26k0ttd2vo3B8S+YCXFg8FHU5pfoDGmUtBYXSSun
         Gd4Vx/ePO+V4SOx7OiS/uCqqX1ML0wpHUAh3fM+pys3EV05ut4k8vhx+DzOROD9tGo
         RHdih6OE/6IuNy0ZeUAPTmICS79NX8SHlPSoyy78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 078/132] netfilter: nftables: statify nft_parse_register()
Date:   Sun, 28 May 2023 20:10:17 +0100
Message-Id: <20230528190835.925248608@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190833.565872088@linuxfoundation.org>
References: <20230528190833.565872088@linuxfoundation.org>
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

[ 08a01c11a5bb3de9b0a9c9b2685867e50eda9910 ]

This function is not used anymore by any extension, statify it.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_tables.h | 1 -
 net/netfilter/nf_tables_api.c     | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index bf957156e9b76..2cd847212a048 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -191,7 +191,6 @@ static inline enum nft_registers nft_type_to_reg(enum nft_data_types type)
 }
 
 int nft_parse_u32_check(const struct nlattr *attr, int max, u32 *dest);
-unsigned int nft_parse_register(const struct nlattr *attr);
 int nft_dump_register(struct sk_buff *skb, unsigned int attr, unsigned int reg);
 
 int nft_parse_register_load(const struct nlattr *attr, u8 *sreg, u32 len);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index b86d9c14cbd69..dacdb1feb2e9a 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6987,7 +6987,7 @@ EXPORT_SYMBOL_GPL(nft_parse_u32_check);
  *	Registers used to be 128 bit wide, these register numbers will be
  *	mapped to the corresponding 32 bit register numbers.
  */
-unsigned int nft_parse_register(const struct nlattr *attr)
+static unsigned int nft_parse_register(const struct nlattr *attr)
 {
 	unsigned int reg;
 
@@ -6999,7 +6999,6 @@ unsigned int nft_parse_register(const struct nlattr *attr)
 		return reg + NFT_REG_SIZE / NFT_REG32_SIZE - NFT_REG32_00;
 	}
 }
-EXPORT_SYMBOL_GPL(nft_parse_register);
 
 /**
  *	nft_dump_register - dump a register value to a netlink attribute
-- 
2.39.2




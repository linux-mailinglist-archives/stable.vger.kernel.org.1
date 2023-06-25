Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A964573D19D
	for <lists+stable@lfdr.de>; Sun, 25 Jun 2023 17:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjFYPIm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 25 Jun 2023 11:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFYPIm (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 25 Jun 2023 11:08:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6EB1B3
        for <stable@vger.kernel.org>; Sun, 25 Jun 2023 08:08:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51d97ba7c01so366756a12.2
        for <stable@vger.kernel.org>; Sun, 25 Jun 2023 08:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687705715; x=1690297715;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+8psmx9n6qU738MmjFIgpqWWMpNDyIfBwFks/1QNRrY=;
        b=PZz21/BioLEdu4byK9LQCHOqAgj7PgnP1e1TviEQuvSEqB2BHhInqGiXXYiOLkukU5
         iZmgfAXgHce3Mg6YEkNN1fjKctm+Lr3CEZNE5Sx9HRkzyysKVAJyXdnocz7exPFYWAkO
         rJdQKmZp+A//HRYk1dP+gBpDQMflBrjxdrflm10mz3AEPOz0Lj/W2DJ2T10zbd/pCwN9
         14RXMPXXXOrZuMMd6tfYEmAVxLtQVHcXHSsHa2GxnYLVds1bPb5SPoeWA0mIjbcvGKki
         JJtPXC346zQxK/58FjBTLYcexCUYaaSKu6JVnIWGj6UPC2HPxbKc1ChKZpVj6+7LAQJE
         RIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687705715; x=1690297715;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+8psmx9n6qU738MmjFIgpqWWMpNDyIfBwFks/1QNRrY=;
        b=Amqtn7wKRI9aJyQNybIuxyoDz33RmeQfHNQcgmXFDUL1cXr+ST9fo3CRM2XpJ2w9Vk
         idTvvSyjJWt0dloREiSDMu2fMlZfo9BRZY2t0dl1bK4IrXBup00Kzo85bdMneLGwWWEL
         Jq5hdbTAjkrCSIuVphK9VAJkGUqwkJd5y2uKMXEIBoFy6zy7tvR3TmvjAYuBaDImfCiu
         POs3PWTCPRO8y5VfJ9qf2lZTbQsPpjsaTe5Anmle9Ned7U6R8rOsGHOYwL9BaX07rg0x
         x1KusTyj3TMc8ttBUwx/V57dDXPus9D/+ssr8AzICGtgf6nxAB/zWrlNKqOB4sFFXrEN
         gYQQ==
X-Gm-Message-State: AC+VfDz52MF5ow38jPw8BuTDZO4IQ5w7jsU7G9uiRRa7uO7t4Gea76Hu
        M1FUZKUs63dmbQo97B8IJnA=
X-Google-Smtp-Source: ACHHUZ4zyYi0cm09z442ZuCSIh0vyKmF6aKMnV33gwhV+YcrwB275GeC2wPQy4RkMR2YSvRVBSDJ9w==
X-Received: by 2002:a17:907:9708:b0:987:d9ee:3e56 with SMTP id jg8-20020a170907970800b00987d9ee3e56mr19344499ejc.59.1687705715177;
        Sun, 25 Jun 2023 08:08:35 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id gu3-20020a170906f28300b0096f71ace804sm2196254ejb.99.2023.06.25.08.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 08:08:33 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
        id C9C97BE2DE0; Sun, 25 Jun 2023 17:08:32 +0200 (CEST)
Date:   Sun, 25 Jun 2023 17:08:32 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     stable <stable@vger.kernel.org>
Subject: Inconsistency about backports to stable series for 6e1acfa387b9
 ("netfilter: nf_tables: validate registers coming from userspace.")?
Message-ID: <ZJhYcEqINyrKpCWV@eldamar.lan>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/BkaEwsBmWUDizqS"
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--/BkaEwsBmWUDizqS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pablo,

While checking netfilter backports to the stable series, I noticed
that 6e1acfa387b9 ("netfilter: nf_tables: validate registers coming
from userspace.") was backported in various series for stable, and
included in 4.14.316, 4.19.284, 5.4.244, 5.15.32, 5.16.18, 5.17.1,
where the original fix was in 5.18-rc1.

While the commit has 

Fixes: 49499c3e6e18 ("netfilter: nf_tables: switch registers to 32 bit addressing")

the 6e1acfa387b9 change got not backported to the 5.10.y series.

The backports to the other series are

https://lore.kernel.org/stable/20230516151606.4892-1-pablo@netfilter.org/
https://lore.kernel.org/stable/20230516150613.4566-1-pablo@netfilter.org/
https://lore.kernel.org/stable/20230516144435.4010-1-pablo@netfilter.org/

Pablo, was this an oversight and can the change as well be applied to
5.10.y?

From looking at the 5.4.y series, from the stable dependencies,
08a01c11a5bb ("netfilter: nftables: statify nft_parse_register()") is
missing in 5.10.y, then 6e1acfa387b9 ("netfilter: nf_tables: validate
registers coming from userspace.") can be applied (almost, the comment
needs to be dropped, as done in the backports).

I'm right now not understanding what I'm missing that it was for 5.4.y
but not 5.10.y after the report of the failed apply by Greg.

At least the two attached bring 5.10.y inline with 5.4.y up to 4) from
https://lore.kernel.org/stable/20230516144435.4010-1-pablo@netfilter.org/
but I'm unsure if you want/need as well the remaining 5), 6), 7), 8)
and 9).

Regards,
Salvatore

--/BkaEwsBmWUDizqS
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-netfilter-nftables-statify-nft_parse_register.patch"

From f53985195412088bec0aec9eb4283d669472c608 Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Mon, 25 Jan 2021 23:19:17 +0100
Subject: [PATCH 1/2] netfilter: nftables: statify nft_parse_register()

commit 08a01c11a5bb3de9b0a9c9b2685867e50eda9910 upstream.

This function is not used anymore by any extension, statify it.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_tables.h | 1 -
 net/netfilter/nf_tables_api.c     | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 564fbe0c865f..030237f3d82a 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -205,7 +205,6 @@ static inline enum nft_registers nft_type_to_reg(enum nft_data_types type)
 }
 
 int nft_parse_u32_check(const struct nlattr *attr, int max, u32 *dest);
-unsigned int nft_parse_register(const struct nlattr *attr);
 int nft_dump_register(struct sk_buff *skb, unsigned int attr, unsigned int reg);
 
 int nft_parse_register_load(const struct nlattr *attr, u8 *sreg, u32 len);
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index fe51cedd9cc3..e1e1cde42075 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8489,7 +8489,7 @@ EXPORT_SYMBOL_GPL(nft_parse_u32_check);
  *	Registers used to be 128 bit wide, these register numbers will be
  *	mapped to the corresponding 32 bit register numbers.
  */
-unsigned int nft_parse_register(const struct nlattr *attr)
+static unsigned int nft_parse_register(const struct nlattr *attr)
 {
 	unsigned int reg;
 
@@ -8501,7 +8501,6 @@ unsigned int nft_parse_register(const struct nlattr *attr)
 		return reg + NFT_REG_SIZE / NFT_REG32_SIZE - NFT_REG32_00;
 	}
 }
-EXPORT_SYMBOL_GPL(nft_parse_register);
 
 /**
  *	nft_dump_register - dump a register value to a netlink attribute
-- 
2.40.1


--/BkaEwsBmWUDizqS
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-netfilter-nf_tables-validate-registers-coming-from-u.patch"

From cfc6c33490e1b9c8c6a9a74f5540ccd3840ae545 Mon Sep 17 00:00:00 2001
From: Pablo Neira Ayuso <pablo@netfilter.org>
Date: Thu, 17 Mar 2022 11:59:26 +0100
Subject: [PATCH 2/2] netfilter: nf_tables: validate registers coming from
 userspace.

commit 6e1acfa387b9ff82cfc7db8cc3b6959221a95851 upstream.

Bail out in case userspace uses unsupported registers.

Fixes: 49499c3e6e18 ("netfilter: nf_tables: switch registers to 32 bit addressing")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index e1e1cde42075..e430788d6d19 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8480,26 +8480,23 @@ int nft_parse_u32_check(const struct nlattr *attr, int max, u32 *dest)
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
+static unsigned int nft_parse_register(const struct nlattr *attr, u32 *preg)
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
@@ -8550,7 +8547,10 @@ int nft_parse_register_load(const struct nlattr *attr, u8 *sreg, u32 len)
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
@@ -8619,7 +8619,10 @@ int nft_parse_register_store(const struct nft_ctx *ctx,
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
2.40.1


--/BkaEwsBmWUDizqS--

Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B72D775D02
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbjHILc4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjHILc4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:32:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CE61FDE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:32:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0364663420
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14357C433CA;
        Wed,  9 Aug 2023 11:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580774;
        bh=h8RWDouXx/uxGIg7JJjGwBYhAXOHdayLZGqwbwc6LZY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZmEmrwhRJNKWfvWrdlPBgHYBX6UvJplUBPLKdPeP0ipOLxCwVqnp3Ch0IEPGCm9z
         n/yEdNdhEAVLLQfKMEQGYgXDPvPVMOvVxUgsUr98azMMBUzeZSQY2BPO12eqDlNkwh
         15vJmZp0Lf9yLQ6Xd2BUN9bKlmzw1J0Ju1nKZy4I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lin Ma <linma@zju.edu.cn>,
        Simon Horman <horms@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 114/154] net: dcb: choose correct policy to parse DCB_ATTR_BCN
Date:   Wed,  9 Aug 2023 12:42:25 +0200
Message-ID: <20230809103640.708663755@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Lin Ma <linma@zju.edu.cn>

[ Upstream commit 31d49ba033095f6e8158c60f69714a500922e0c3 ]

The dcbnl_bcn_setcfg uses erroneous policy to parse tb[DCB_ATTR_BCN],
which is introduced in commit 859ee3c43812 ("DCB: Add support for DCB
BCN"). Please see the comment in below code

static int dcbnl_bcn_setcfg(...)
{
  ...
  ret = nla_parse_nested_deprecated(..., dcbnl_pfc_up_nest, .. )
  // !!! dcbnl_pfc_up_nest for attributes
  //  DCB_PFC_UP_ATTR_0 to DCB_PFC_UP_ATTR_ALL in enum dcbnl_pfc_up_attrs
  ...
  for (i = DCB_BCN_ATTR_RP_0; i <= DCB_BCN_ATTR_RP_7; i++) {
  // !!! DCB_BCN_ATTR_RP_0 to DCB_BCN_ATTR_RP_7 in enum dcbnl_bcn_attrs
    ...
    value_byte = nla_get_u8(data[i]);
    ...
  }
  ...
  for (i = DCB_BCN_ATTR_BCNA_0; i <= DCB_BCN_ATTR_RI; i++) {
  // !!! DCB_BCN_ATTR_BCNA_0 to DCB_BCN_ATTR_RI in enum dcbnl_bcn_attrs
  ...
    value_int = nla_get_u32(data[i]);
  ...
  }
  ...
}

That is, the nla_parse_nested_deprecated uses dcbnl_pfc_up_nest
attributes to parse nlattr defined in dcbnl_pfc_up_attrs. But the
following access code fetch each nlattr as dcbnl_bcn_attrs attributes.
By looking up the associated nla_policy for dcbnl_bcn_attrs. We can find
the beginning part of these two policies are "same".

static const struct nla_policy dcbnl_pfc_up_nest[...] = {
        [DCB_PFC_UP_ATTR_0]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_1]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_2]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_3]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_4]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_5]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_6]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_7]   = {.type = NLA_U8},
        [DCB_PFC_UP_ATTR_ALL] = {.type = NLA_FLAG},
};

static const struct nla_policy dcbnl_bcn_nest[...] = {
        [DCB_BCN_ATTR_RP_0]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_1]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_2]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_3]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_4]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_5]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_6]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_7]         = {.type = NLA_U8},
        [DCB_BCN_ATTR_RP_ALL]       = {.type = NLA_FLAG},
        // from here is somewhat different
        [DCB_BCN_ATTR_BCNA_0]       = {.type = NLA_U32},
        ...
        [DCB_BCN_ATTR_ALL]          = {.type = NLA_FLAG},
};

Therefore, the current code is buggy and this
nla_parse_nested_deprecated could overflow the dcbnl_pfc_up_nest and use
the adjacent nla_policy to parse attributes from DCB_BCN_ATTR_BCNA_0.

Hence use the correct policy dcbnl_bcn_nest to parse the nested
tb[DCB_ATTR_BCN] TLV.

Fixes: 859ee3c43812 ("DCB: Add support for DCB BCN")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20230801013248.87240-1-linma@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/dcb/dcbnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dcb/dcbnl.c b/net/dcb/dcbnl.c
index b53d5e1d026fe..71e97e2a36845 100644
--- a/net/dcb/dcbnl.c
+++ b/net/dcb/dcbnl.c
@@ -946,7 +946,7 @@ static int dcbnl_bcn_setcfg(struct net_device *netdev, struct nlmsghdr *nlh,
 		return -EOPNOTSUPP;
 
 	ret = nla_parse_nested_deprecated(data, DCB_BCN_ATTR_MAX,
-					  tb[DCB_ATTR_BCN], dcbnl_pfc_up_nest,
+					  tb[DCB_ATTR_BCN], dcbnl_bcn_nest,
 					  NULL);
 	if (ret)
 		return ret;
-- 
2.40.1



